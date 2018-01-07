#!/bin/bash

$(aws ecr get-login --no-include-email --region us-east-1)

docker build -t hello_world .

docker tag hello_world:latest 564474272842.dkr.ecr.us-east-1.amazonaws.com/hello_world:latest

docker push 564474272842.dkr.ecr.us-east-1.amazonaws.com/hello_world:latest

aws ecs register-task-definition --family hello-world --requires-compatibilities FARGATE --network-mode awsvpc --execution-role-arn "arn:aws:iam::564474272842:role/ecsTaskExecutionRole" --cpu 256 --memory 512 --container-definitions "`cat task-definition.json | jq .containerDefinitions`"

aws ecs update-service --service hello-world --task-definition hello-world


#!/bin/bash

set -e

cwd=$(pwd)
script_dir=$(dirname $(realpath "$0"))
cd ${script_dir}

# Fetch data:
cp ../../data/*.json .
cp ../../openapi_specs/*.json .

# Install requirements:
echo "Installing requirements..."
python3 -m pip install -r requirements.txt

# Run setup:
echo "Running CLU setup..."
python3 clu_setup.py
echo "Running CQA setup..."
python3 cqa_setup.py
echo "Running Orchestration setup..."
python3 orchestration_setup.py
echo "Running agent setup..."
TRIAGE_AGENT_id = $(python3 agent_setup.py | tail -n1)
export TRIAGE_AGENT_id
echo "Triage Agent ID: ${TRIAGE_AGENT_id}"
# python3 agent_setup.py

# Cleanup:
rm *.json
cd ${cwd}

echo "Language setup complete"

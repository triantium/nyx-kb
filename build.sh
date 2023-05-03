#!/bin/bash

if ! [[ -c west ]] ; then
  pip install --user -U west
  pip install --user -U pyelftools
fi

if ! [ -d '.west' ] ; then
   west init -l firmware
fi

west update

mkdir -p artifacts

west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=$(pwd)/firmware -DSHIELD="nyx_left"

cp build/zephyr/zmk.uf2 artifacts/nice_nano_v2_nyx_left.uf2

west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=$(pwd)/firmware -DSHIELD="nyx_right"

cp build/zephyr/zmk.uf2 artifacts/nice_nano_v2_nyx_right.uf2

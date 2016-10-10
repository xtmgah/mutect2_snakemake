#!/bin/bash
# =============================================
# Run xenograft pipeline made with snakemake
#
# Julia X.M. Yin
# August 2015
#==============================================

PREFIX="mutect2"
SNAKE_FILE="mutect2_variant_calling.snakemake"


source /share/ClusterShare/software/contrib/julyin/Python-3.4.3/python-3.4.3-julyin/bin/activate

snakemake -s $SNAKE_FILE --rulegraph | dot -Tpdf > $PREFIX.graph_short.pdf

snakemake -s $SNAKE_FILE --dag | dot -Tpdf > $PREFIX.graph_detailed.pdf

snakemake -s $SNAKE_FILE --cluster-config cluster.json --drmaa " -q all.q -cwd -V -b y -j y -pe smp {cluster.cores} -l {cluster.hvmem} -l {cluster.memrequested} -P {cluster.account} -N {cluster.jobname}" -j 200

snakemake -s $SNAKE_FILE --detailed-summary > $PREFIX.summary_detailed.txt

snakemake -s $SNAKE_FILE --summary > $PREFIX.summary_short.txt


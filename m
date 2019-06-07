Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1514B1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfFGSXV (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:23:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63057 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbfFGSXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:23:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FE4B1594BE;
        Fri,  7 Jun 2019 14:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UgucNY7FEcPG4ocv1lDlL129YHY=; b=lczHiI
        9iXrDsksR57eC3GsVffHc/vgl/b7MIdFcimBY46qYpXHZ5Jn/mZgLCPQ3Op64yPQ
        SGzJCJl1X8OCFD5k5obPjt02E0jPYmyPzmYkpxjv8KV70uQoFrtUS/wYgAZgoihU
        IL3zGVh0B1QBrAMxKAszFvc6/PE+tjCZLP5HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i/QUsdGsvMSiCJ+Ziybg+P8xsGtEjUxa
        Ew0uykJRDcuuf/3ZLx5j+MNrV/Fq+6k9OWW/cUY7f9UhPY10hLJuwfMxYDp13reQ
        ycTXW7JIiKrfhFzgVBmm8LALZ1GYDG3OHbB2DgrE9klqwMX0L98ghOZdpNu8iY4A
        EacL5TXwzGU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2790A1594BD;
        Fri,  7 Jun 2019 14:23:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95BFB1594BC;
        Fri,  7 Jun 2019 14:23:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 06/14] commit-graph: rearrange chunk count logic
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
        <e65f9e841d577c13d26c1737ebb8a2cf65713be9.1559830527.git.gitgitgadget@gmail.com>
Date:   Fri, 07 Jun 2019 11:23:14 -0700
In-Reply-To: <e65f9e841d577c13d26c1737ebb8a2cf65713be9.1559830527.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 06 Jun 2019
        07:15:34 -0700 (PDT)")
Message-ID: <xmqqimthp84t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51076432-8951-11E9-BFB2-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The number of chunks in a commit-graph file can change depending on
> whether we need the Extra Edges Chunk. We are going to add more optional
> chunks, and it will be helpful to rearrange this logic around the chunk
> count before doing so.
>
> Specifically, we need to finalize the number of chunks before writing
> the commit-graph header. Further, we also need to fill out the chunk
> lookup table dynamically and using "num_chunks" as we add optional
> chunks is useful for adding optional chunks in the future.

Yup.  The resulting code may be slightly longer at this step than
before, but it certainly is easier to follow the logic.  Good.


>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 909c841db5..80df6d6d9d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1206,7 +1206,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  	uint64_t chunk_offsets[5];
>  	const unsigned hashsz = the_hash_algo->rawsz;
>  	struct strbuf progress_title = STRBUF_INIT;
> -	int num_chunks = ctx->num_extra_edges ? 4 : 3;
> +	int num_chunks = 3;
>  
>  	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
>  	if (safe_create_leading_directories(ctx->graph_name)) {
> @@ -1219,27 +1219,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
>  	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>  
> -	hashwrite_be32(f, GRAPH_SIGNATURE);
> -
> -	hashwrite_u8(f, GRAPH_VERSION);
> -	hashwrite_u8(f, oid_version());
> -	hashwrite_u8(f, num_chunks);
> -	hashwrite_u8(f, 0); /* unused padding byte */
> -
>  	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
>  	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
>  	chunk_ids[2] = GRAPH_CHUNKID_DATA;
> -	if (ctx->num_extra_edges)
> -		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
> -	else
> -		chunk_ids[3] = 0;
> -	chunk_ids[4] = 0;
> +	if (ctx->num_extra_edges) {
> +		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
> +		num_chunks++;
> +	}
> +
> +	chunk_ids[num_chunks] = 0;
>  
>  	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
>  	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
>  	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
>  	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
> -	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
> +
> +	num_chunks = 3;
> +	if (ctx->num_extra_edges) {
> +		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
> +						4 * ctx->num_extra_edges;
> +		num_chunks++;
> +	}
> +
> +	hashwrite_be32(f, GRAPH_SIGNATURE);
> +
> +	hashwrite_u8(f, GRAPH_VERSION);
> +	hashwrite_u8(f, oid_version());
> +	hashwrite_u8(f, num_chunks);
> +	hashwrite_u8(f, 0);
>  
>  	for (i = 0; i <= num_chunks; i++) {
>  		uint32_t chunk_write[3];

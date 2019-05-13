Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AC01F461
	for <e@80x24.org>; Mon, 13 May 2019 05:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfEMFKB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 01:10:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60603 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfEMFKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 01:10:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA1DE76932;
        Mon, 13 May 2019 01:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nnBk2SZxD17PbTFeih3/EPWOzK8=; b=W9lGmi
        Kclo7gMdZPhstGOZfv1TECzut2Co/ZUEeUyBTXOBs6jWpZfyr8bBO5/0yUpw87Fa
        aFRd80/FyYVReOHFV3aAr3OeXOfKlFXVt36FPlr9aJrrq5jLw+bJsOC3sf3eUCx6
        H1Jsskue2LPnNOQeQFMHKd8WrnacGuQ5gPD/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HKUsaGkKo5o/c1MNSUyMof9p5EvbjYgU
        G0ZcoKlBP4ukiks5vSq87c0kOebIKLweUC+XT3cCv6F8ryUCVR58j+vSkrLObK1B
        WUEn/Fnv38bqxbS6KxzvkohorNbA2HIuOIuvg72GoW+9Nfnxcbm6MCEN6dl8xbXK
        8n9BEoFvDi8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C145D76931;
        Mon, 13 May 2019 01:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E78207692F;
        Mon, 13 May 2019 01:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 11/11] commit-graph: extract write_commit_graph_file()
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
        <fc81c8946dd53d926b03ac94e1d9e11b4f9b8fc3.1557411749.git.gitgitgadget@gmail.com>
Date:   Mon, 13 May 2019 14:09:44 +0900
In-Reply-To: <fc81c8946dd53d926b03ac94e1d9e11b4f9b8fc3.1557411749.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 09 May 2019
        07:22:40 -0700 (PDT)")
Message-ID: <xmqqpnonc547.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53B9844E-753D-11E9-AE95-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The write_commit_graph() method is too complex, so we are
> extracting methods one by one.
>
> Extract write_commit_graph_file() that takes all of the information
> in the context struct and writes the data to a commit-graph file.

The later parts of splitting pieces out of write_commit_graph() into
separate helper functions look all sensible.  One big benefit of
doing this, even if each of these helper functions have a single
caller, is that each of these individual steps now has a descriptive
name.

Module a few nits (and possibly s/method/helper function/g), the
series look good to me.

Thanks.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 155 +++++++++++++++++++++++++------------------------
>  1 file changed, 80 insertions(+), 75 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 16cdd7afb2..7723156964 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1015,21 +1015,91 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
>  	stop_progress(&ctx->progress);
>  }
>  
> -int write_commit_graph(const char *obj_dir,
> -		       struct string_list *pack_indexes,
> -		       struct string_list *commit_hex,
> -		       unsigned int flags)
> +static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  {
> -	struct write_commit_graph_context *ctx;
> +	uint32_t i;
>  	struct hashfile *f;
> -	uint32_t i, count_distinct = 0;
> -	char *graph_name = NULL;
>  	struct lock_file lk = LOCK_INIT;
>  	uint32_t chunk_ids[5];
>  	uint64_t chunk_offsets[5];
> -	int num_chunks;
>  	const unsigned hashsz = the_hash_algo->rawsz;
>  	struct strbuf progress_title = STRBUF_INIT;
> +	int num_chunks = ctx->num_extra_edges ? 4 : 3;
> +
> +	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
> +	if (safe_create_leading_directories(ctx->graph_name)) {
> +		UNLEAK(ctx->graph_name);
> +		error(_("unable to create leading directories of %s"),
> +			ctx->graph_name);
> +		return errno;
> +	}
> +
> +	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
> +	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
> +
> +	hashwrite_be32(f, GRAPH_SIGNATURE);
> +
> +	hashwrite_u8(f, GRAPH_VERSION);
> +	hashwrite_u8(f, oid_version());
> +	hashwrite_u8(f, num_chunks);
> +	hashwrite_u8(f, 0); /* unused padding byte */
> +
> +	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
> +	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
> +	chunk_ids[2] = GRAPH_CHUNKID_DATA;
> +	if (ctx->num_extra_edges)
> +		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
> +	else
> +		chunk_ids[3] = 0;
> +	chunk_ids[4] = 0;
> +
> +	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
> +	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
> +	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
> +	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
> +	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
> +
> +	for (i = 0; i <= num_chunks; i++) {
> +		uint32_t chunk_write[3];
> +
> +		chunk_write[0] = htonl(chunk_ids[i]);
> +		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
> +		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
> +		hashwrite(f, chunk_write, 12);
> +	}
> +
> +	if (ctx->report_progress) {
> +		strbuf_addf(&progress_title,
> +			    Q_("Writing out commit graph in %d pass",
> +			       "Writing out commit graph in %d passes",
> +			       num_chunks),
> +			    num_chunks);
> +		ctx->progress = start_delayed_progress(
> +			progress_title.buf,
> +			num_chunks * ctx->commits.nr);
> +	}
> +	write_graph_chunk_fanout(f, ctx);
> +	write_graph_chunk_oids(f, hashsz, ctx);
> +	write_graph_chunk_data(f, hashsz, ctx);
> +	if (ctx->num_extra_edges)
> +		write_graph_chunk_extra_edges(f, ctx);
> +	stop_progress(&ctx->progress);
> +	strbuf_release(&progress_title);
> +
> +	close_commit_graph(ctx->r);
> +	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
> +	commit_lock_file(&lk);
> +
> +	return 0;
> +}
> +
> +int write_commit_graph(const char *obj_dir,
> +		       struct string_list *pack_indexes,
> +		       struct string_list *commit_hex,
> +		       unsigned int flags)
> +{
> +	struct write_commit_graph_context *ctx;
> +	uint32_t i, count_distinct = 0;
>  	int res = 0;
>  
>  	if (!commit_graph_compatible(the_repository))
> @@ -1096,75 +1166,10 @@ int write_commit_graph(const char *obj_dir,
>  
>  	compute_generation_numbers(ctx);
>  
> -	num_chunks = ctx->num_extra_edges ? 4 : 3;
> -
> -	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
> -	if (safe_create_leading_directories(ctx->graph_name)) {
> -		UNLEAK(ctx->graph_name);
> -		error(_("unable to create leading directories of %s"),
> -			ctx->graph_name);
> -		res = errno;
> -		goto cleanup;
> -	}
> -
> -	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
> -	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
> -
> -	hashwrite_be32(f, GRAPH_SIGNATURE);
> -
> -	hashwrite_u8(f, GRAPH_VERSION);
> -	hashwrite_u8(f, oid_version());
> -	hashwrite_u8(f, num_chunks);
> -	hashwrite_u8(f, 0); /* unused padding byte */
> -
> -	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
> -	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
> -	chunk_ids[2] = GRAPH_CHUNKID_DATA;
> -	if (ctx->num_extra_edges)
> -		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
> -	else
> -		chunk_ids[3] = 0;
> -	chunk_ids[4] = 0;
> -
> -	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
> -	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
> -	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
> -	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
> -	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
> -
> -	for (i = 0; i <= num_chunks; i++) {
> -		uint32_t chunk_write[3];
> -
> -		chunk_write[0] = htonl(chunk_ids[i]);
> -		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
> -		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
> -		hashwrite(f, chunk_write, 12);
> -	}
> -
> -	if (ctx->report_progress) {
> -		strbuf_addf(&progress_title,
> -			    Q_("Writing out commit graph in %d pass",
> -			       "Writing out commit graph in %d passes",
> -			       num_chunks),
> -			    num_chunks);
> -		ctx->progress = start_delayed_progress(
> -			progress_title.buf,
> -			num_chunks * ctx->commits.nr);
> -	}
> -	write_graph_chunk_fanout(f, ctx);
> -	write_graph_chunk_oids(f, hashsz, ctx);
> -	write_graph_chunk_data(f, hashsz, ctx);
> -	if (ctx->num_extra_edges)
> -		write_graph_chunk_extra_edges(f, ctx);
> -	stop_progress(&ctx->progress);
> -	strbuf_release(&progress_title);
> -
> -	close_commit_graph(ctx->r);
> -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
> -	commit_lock_file(&lk);
> +	res = write_commit_graph_file(ctx);
>  
>  cleanup:
> -	free(graph_name);
> +	free(ctx->graph_name);
>  	free(ctx->commits.list);
>  	free(ctx->oids.list);
>  	free(ctx);

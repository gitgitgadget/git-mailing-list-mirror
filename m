Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF01DFE1D
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197068; cv=none; b=CuoSjSP8W9it51vGNetvVf31U+lVBwho6fiTkr4c0AyptJU/UY6DYgu2Ee1MHnomgy77iS1XmEK5RQRwpxDaRXC+0tSpVpnjPB5YIjysikLBIcLOlGJiWPubD4GqtwIC7OnWcWrJ8OrESZgXsLB4sGjOEGBFRwP9EId6xyRICQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197068; c=relaxed/simple;
	bh=nTIaaTRbilIXKHZm4hrUMXaaQgo2xDNK4BJgWBwoOB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovrtI4Ci1yLNHX8O2bL5CDTAjjZySvTHwCaEhbjh5aK3HCeDgX4PoW91uPpXPfXTzZDnx+gRBze9P0Q/EIdCaTjq1lSoD5LgenMfXDeAyUQYsOk4CRhN7MoieIzPP8l8OOy+RvPZhqX6ayZjXNxjR9mPpzvR75Ux6nCN0NisJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nulW/CIN; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nulW/CIN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1736197060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tM19Ej9yeU5uow0qgLJNEe9hEzGwHHOb0ItKVSH+nXM=;
	b=nulW/CINo56Rm53VaSoLabLDr0QJLXYQQyDqplSpzJhRaOUdFvgPgurEl+d5iJsRBAy0FJ
	c7szQJKLMx9JDmiVPYBjnPzQJgWoAi0qvA2zjyP8U5+kYjw0RWs6RiJForqoOxpKFaVO0m
	On++PMIDRFx/m8n4/2Okp99t7TkR/9Y=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/14] progress: stop using `the_repository`
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-1-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <20241217-pks-use-the-repository-conversion-v1-1-0dba48bcc239@pks.im>
Date: Mon, 06 Jan 2025 21:57:26 +0100
Message-ID: <87v7urk6dl.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Stop using `the_repository` in the "progress" subsystem by passing in a
> repository when initializing `struct progress`. Furthermore, store a
> pointer to the repository in that struct so that we can pass it to the
> trace2 API when logging information.
>
> Adjust callers accordingly by using `the_repository`. While there may be
> some callers that have a repository available in their context, this
> trivial conversion allows for easier verification and bubbles up the use
> of `the_repository` by one level.

I'm not sure I agree here. Below I've marked all places where I think we
are able to get the repo from somewhere else than `the_repository`. For
example, looking at diffcore-rename.c, the already present calls to
trace2_*() use `options->repo`, why shouldn't we do the same?

I understand what your angle is, you want to bubble up `the_repository`
and make the changes easier to reason about, but it feels to me we're
creating extra work. If most people disagree with me, I'm happy to take
your approach.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/blame.c          |  4 +++-
>  builtin/commit-graph.c   |  1 +
>  builtin/fsck.c           | 12 ++++++++----
>  builtin/index-pack.c     |  7 +++++--
>  builtin/log.c            |  3 ++-
>  builtin/pack-objects.c   | 21 ++++++++++++++-------
>  builtin/prune.c          |  3 ++-
>  builtin/remote.c         |  3 ++-
>  builtin/rev-list.c       |  3 ++-
>  builtin/unpack-objects.c |  3 ++-
>  commit-graph.c           | 20 +++++++++++++++++---
>  delta-islands.c          |  3 ++-
>  diffcore-rename.c        |  1 +
>  entry.c                  |  4 +++-
>  midx-write.c             | 11 ++++++++---
>  midx.c                   | 13 +++++++++----
>  pack-bitmap-write.c      |  6 ++++--
>  pack-bitmap.c            |  4 +++-
>  preload-index.c          |  4 +++-
>  progress.c               | 34 ++++++++++++++++++++--------------
>  progress.h               | 13 +++++++++----
>  prune-packed.c           |  3 ++-
>  pseudo-merge.c           |  3 ++-
>  read-cache.c             |  3 ++-
>  t/helper/test-progress.c |  6 +++++-
>  unpack-trees.c           |  4 +++-
>  walker.c                 |  3 ++-
>  27 files changed, 136 insertions(+), 59 deletions(-)
>
> [snip]
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 0196c54eb68ee54c22de72d64b3f31602594e50b..7a4dcb0716052ff1b9236ea66b8901960fe1c55d 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -197,7 +197,8 @@ static int traverse_reachable(void)
>  	unsigned int nr = 0;
>  	int result = 0;
>  	if (show_progress)
> -		progress = start_delayed_progress(_("Checking connectivity"), 0);
> +		progress = start_delayed_progress(the_repository,
> +						  _("Checking connectivity"), 0);
>  	while (pending.nr) {
>  		result |= traverse_one_object(object_array_pop(&pending));
>  		display_progress(progress, ++nr);
> @@ -703,7 +704,8 @@ static void fsck_object_dir(const char *path)
>  		fprintf_ln(stderr, _("Checking object directory"));
>  
>  	if (show_progress)
> -		progress = start_progress(_("Checking object directories"), 256);
> +		progress = start_progress(the_repository,
> +					  _("Checking object directories"), 256);
>  
>  	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
>  				      &cb_data);
> @@ -879,7 +881,8 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
>  	if (show_progress) {
>  		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
>  			pack_count++;
> -		progress = start_delayed_progress("Verifying reverse pack-indexes", pack_count);
> +		progress = start_delayed_progress(the_repository,

I think we should use `r` here.

> +						  "Verifying reverse pack-indexes", pack_count);
>  		pack_count = 0;
>  	}
>
> [snip]
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 0df66e5a243390bc1224b28e2b55c541f9d93fb1..2a2999a6b886905276a0c39dda6135f0c92aa361 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1534,6 +1534,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
>  
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(

Shall we use `ctx->r` here? And same for all other changes in this file.

> +					the_repository,
>  					_("Loading known commits in commit graph"),
>  					ctx->oids.nr);
>  	for (i = 0; i < ctx->oids.nr; i++) {
> @@ -1551,6 +1552,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
>  	 */
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(
> +					the_repository,
>  					_("Expanding reachable commits in commit graph"),
>  					0);
>  	for (i = 0; i < ctx->oids.nr; i++) {
> @@ -1571,6 +1573,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
>  
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(
> +					the_repository,
>  					_("Clearing commit marks in commit graph"),
>  					ctx->oids.nr);
>  	for (i = 0; i < ctx->oids.nr; i++) {
> @@ -1688,6 +1691,7 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
>  	if (ctx->report_progress)
>  		info.progress = ctx->progress
>  			      = start_delayed_progress(
> +					the_repository,
>  					_("Computing commit graph topological levels"),
>  					ctx->commits.nr);
>  
> @@ -1722,6 +1726,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  	if (ctx->report_progress)
>  		info.progress = ctx->progress
>  			      = start_delayed_progress(
> +					the_repository,
>  					_("Computing commit graph generation numbers"),
>  					ctx->commits.nr);
>  
> @@ -1798,6 +1803,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  
>  	if (ctx->report_progress)
>  		progress = start_delayed_progress(
> +			the_repository,
>  			_("Computing commit changed paths Bloom filters"),
>  			ctx->commits.nr);
>  
> @@ -1877,6 +1883,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
>  	data.commits = &commits;
>  	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
>  		data.progress = start_delayed_progress(
> +			the_repository,
>  			_("Collecting referenced commits"), 0);
>  
>  	refs_for_each_ref(get_main_ref_store(the_repository), add_ref_to_set,
> @@ -1908,7 +1915,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
>  			       "Finding commits for commit graph in %"PRIuMAX" packs",
>  			       pack_indexes->nr),
>  			    (uintmax_t)pack_indexes->nr);
> -		ctx->progress = start_delayed_progress(progress_title.buf, 0);
> +		ctx->progress = start_delayed_progress(the_repository,
> +						       progress_title.buf, 0);
>  		ctx->progress_done = 0;
>  	}
>  	for (i = 0; i < pack_indexes->nr; i++) {
> @@ -1959,6 +1967,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
>  {
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(
> +			the_repository,
>  			_("Finding commits for commit graph among packed objects"),
>  			ctx->approx_nr_objects);
>  	for_each_packed_object(ctx->r, add_packed_commits, ctx,
> @@ -1977,6 +1986,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
>  	ctx->num_extra_edges = 0;
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(
> +			the_repository,
>  			_("Finding extra edges in commit graph"),
>  			ctx->oids.nr);
>  	oid_array_sort(&ctx->oids);
> @@ -2136,6 +2146,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  			       get_num_chunks(cf)),
>  			    get_num_chunks(cf));
>  		ctx->progress = start_delayed_progress(
> +			the_repository,
>  			progress_title.buf,
>  			st_mult(get_num_chunks(cf), ctx->commits.nr));
>  	}
> @@ -2348,6 +2359,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(
> +					the_repository,
>  					_("Scanning merged commits"),
>  					ctx->commits.nr);
>  
> @@ -2392,7 +2404,8 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
>  		current_graph_number--;
>  
>  		if (ctx->report_progress)
> -			ctx->progress = start_delayed_progress(_("Merging commit-graph"), 0);
> +			ctx->progress = start_delayed_progress(the_repository,
> +							       _("Merging commit-graph"), 0);
>  
>  		merge_commit_graph(ctx, g);
>  		stop_progress(&ctx->progress);
> @@ -2874,7 +2887,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>  		if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW))
>  			total += g->num_commits_in_base;
>  
> -		progress = start_progress(_("Verifying commits in commit graph"),
> +		progress = start_progress(the_repository,
> +					  _("Verifying commits in commit graph"),
>  					  total);
>  	}
>  
> diff --git a/delta-islands.c b/delta-islands.c
> index 1c465a6041914538bcb8be51c500653d8fa1a626..3aec43fada36f7052b825dcb2ac0e1ad79f028b7 100644
> --- a/delta-islands.c
> +++ b/delta-islands.c
> @@ -267,7 +267,8 @@ void resolve_tree_islands(struct repository *r,
>  	QSORT(todo, nr, tree_depth_compare);
>  
>  	if (progress)
> -		progress_state = start_progress(_("Propagating island marks"), nr);
> +		progress_state = start_progress(the_repository,

Here we can use `r`.

> +						_("Propagating island marks"), nr);
>  
>  	for (i = 0; i < nr; i++) {
>  		struct object_entry *ent = todo[i].entry;
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 10bb0321b10d5896aaa6a26a624d2066598bf51f..91b77993c7827f9ddc7b444b42f480b8209fd821 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -1567,6 +1567,7 @@ void diffcore_rename_extended(struct diff_options *options,
>  	trace2_region_enter("diff", "inexact renames", options->repo);
>  	if (options->show_rename_progress) {
>  		progress = start_delayed_progress(
> +				the_repository,

Can we use `options->repo` here?

If we do, we ideally should also replace occurrences of
`the_repository->hash_algo` in this function, although I realize that's
outside the scope of this commit.

>  				_("Performing inexact rename detection"),
>  				(uint64_t)num_destinations * (uint64_t)num_sources);
>  	}
> 
> [snip]
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 4f8be53c2bd75f83a0555e2a5510c2bbca07b36d..a06a1f35c619b3b01e63a506a6d4312e14cf181c 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -590,7 +590,8 @@ int bitmap_writer_build(struct bitmap_writer *writer)
>  	int closed = 1; /* until proven otherwise */
>  
>  	if (writer->show_progress)
> -		writer->progress = start_progress("Building bitmaps",
> +		writer->progress = start_progress(the_repository,

Unsure, but can we use `writer->to_pack->repo`? Although I see some
trace2_* functions also use `the_repository`, so consistency in this
function would be nice.

> +						  "Building bitmaps",
>  						  writer->selected_nr);
>  	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
>  			    the_repository);
> @@ -710,7 +711,8 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
>  	}
>  
>  	if (writer->show_progress)
> -		writer->progress = start_progress("Selecting bitmap commits", 0);
> +		writer->progress = start_progress(the_repository,

Same, can we use `writer->to_pack->repo`?

> +						  "Selecting bitmap commits", 0);
>  
>  	for (;;) {
>  		struct commit *chosen = NULL;
>
> [snip]
>
> diff --git a/preload-index.c b/preload-index.c
> index ab94d6f39967ea4358f51ff8384aa60927bfe259..40ab2abafb8de500a5f2ec678a584a5fd5e1bc16 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -132,7 +132,9 @@ void preload_index(struct index_state *index,
>  
>  	memset(&pd, 0, sizeof(pd));
>  	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
> -		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
> +		pd.progress = start_delayed_progress(the_repository,

Can we use `index->repo` here?

> [snip]
>
> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index 971f54cfe1a895aed00f6d0a65c62aafc83a0cc8..893b763fe45490875ea226eaffff0c7cb1dafb06 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -459,7 +459,8 @@ void select_pseudo_merges(struct bitmap_writer *writer)
>  		return;
>  
>  	if (writer->show_progress)
> -		progress = start_progress("Selecting pseudo-merge commits",
> +		progress = start_progress(the_repository,

Also a candidate for `writer->to_pack->repo`?

> +					  "Selecting pseudo-merge commits",
>  					  writer->pseudo_merge_groups.nr);
>  
>  	refs_for_each_ref(get_main_ref_store(the_repository),
> diff --git a/read-cache.c b/read-cache.c
> index 15d79839c205176f9161f537aa706dac44b3023c..38c36caa7fef4d44da74c29e059839d88426df15 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1523,7 +1523,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	int t2_sum_scan = 0;
>  
>  	if (flags & REFRESH_PROGRESS && isatty(2))
> -		progress = start_delayed_progress(_("Refresh index"),
> +		progress = start_delayed_progress(the_repository,

I think also `istate->repo` would work here.

> +						  _("Refresh index"),
>  						  istate->cache_nr);
>  
>  	trace_performance_enter();
>
> [snip]
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index b3be5d542f5fc5a02b8838101f7334ff44b2c626..334cb84f6531b588688d5a43c538c8d1a5f7e768 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -372,7 +372,8 @@ static struct progress *get_progress(struct unpack_trees_options *o,
>  			total++;
>  	}
>  
> -	return start_delayed_progress(_("Updating files"), total);
> +	return start_delayed_progress(the_repository,

Maybe also use `index->repo` here?

> +				      _("Updating files"), total);
>  }
>  
>  static void setup_collided_checkout_detection(struct checkout *state,
> @@ -1773,6 +1774,7 @@ static int clear_ce_flags(struct index_state *istate,
>  	strbuf_reset(&prefix);
>  	if (show_progress)
>  		istate->progress = start_delayed_progress(
> +					the_repository,
>  					_("Updating index flags"),
>  					istate->cache_nr);
>  
> diff --git a/walker.c b/walker.c
> index 7cc9dbea46d64d6bd3336025d640f284a6202157..1cf3da02193531a17fd11dbd2e8aadf36f38b200 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -172,7 +172,8 @@ static int loop(struct walker *walker)
>  	uint64_t nr = 0;
>  
>  	if (walker->get_progress)
> -		progress = start_delayed_progress(_("Fetching objects"), 0);
> +		progress = start_delayed_progress(the_repository,
> +						  _("Fetching objects"), 0);
>  
>  	while (process_queue) {
>  		struct object *obj = process_queue->item;
>
> -- 
> 2.48.0.rc0.184.g0fc57dec57.dirty


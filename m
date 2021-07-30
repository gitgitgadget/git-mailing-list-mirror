Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F20C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4DF60F4B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhG3QZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:25:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhG3QZB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:25:01 -0400
Received: (qmail 15679 invoked by uid 109); 30 Jul 2021 16:24:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Jul 2021 16:24:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3273 invoked by uid 111); 30 Jul 2021 16:24:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Jul 2021 12:24:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Jul 2021 12:24:55 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 9/9] merge-ort: remove compile-time ability to turn
 off usage of memory pools
Message-ID: <YQQn1yS/l8j6ymZO@coredump.intra.peff.net>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
 <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
 <de30dbac25e78e5ad81053b60c3ec2ab6256fde2.1627645665.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de30dbac25e78e5ad81053b60c3ec2ab6256fde2.1627645665.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 30, 2021 at 11:47:44AM +0000, Elijah Newren via GitGitGadget wrote:

> -#if USE_MEMORY_POOL
>  	mem_pool_init(&opt->priv->internal_pool, 0);
> -	opt->priv->pool = &opt->priv->internal_pool;
> -#else
> -	opt->priv->pool = NULL;
> -#endif
> -	pool = opt->priv->pool;
> +	pool = opt->priv->pool = &opt->priv->internal_pool;

Since opt->priv->pool always points at internal_pool now, I think we can
simplify much more. Every "if (!opt->priv->pool)" can go away, and in
turn paths_to_free does, too. Those are really the spots I was most
worried about in terms of complexity.

An easy way to find these spots is to get rid of internal_pool, and just
make "pool" the struct. Then the compiler helpfully complains about all
of the places that check the boolean value of a struct. :)

The patch below is from a fairly mechanical conversion I did. All of the
spots were found by the compiler, except the one in use_cached_pairs (it
assigns to a local "pool" pointer, which is always non-NULL, but that's
not necessarily obvious to the compiler).

You might spot further opportunities for cleanup, as somebody who's more
familiar with the allocation patterns (I happened to notice manually
that paths_to_free is not needed anymore, but I don't know if there are
any other subtle bits).

-Peff

 merge-ort.c | 151 +++++++++--------------------------
 1 file changed, 37 insertions(+), 114 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 63829f5cac..441dc4e094 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -303,8 +303,6 @@ struct merge_options_internal {
 	 *   * these keys serve to intern all the path strings, which allows
 	 *     us to do pointer comparison on directory names instead of
 	 *     strcmp; we just have to be careful to use the interned strings.
-	 *     (Technically paths_to_free may track some strings that were
-	 *      removed from froms paths.)
 	 *
 	 * The values of paths:
 	 *   * either a pointer to a merged_info, or a conflict_info struct
@@ -347,18 +345,7 @@ struct merge_options_internal {
 	 * freed together too.  Using a memory pool for these provides a
 	 * nice speedup.
 	 */
-	struct mem_pool internal_pool;
-	struct mem_pool *pool; /* NULL, or pointer to internal_pool */
-
-	/*
-	 * paths_to_free: additional list of strings to free
-	 *
-	 * If keys are removed from "paths", they are added to paths_to_free
-	 * to ensure they are later freed.  We avoid free'ing immediately since
-	 * other places (e.g. conflict_info.pathnames[]) may still be
-	 * referencing these paths.
-	 */
-	struct string_list paths_to_free;
+	struct mem_pool pool;
 
 	/*
 	 * output: special messages and conflict notices for various paths
@@ -537,19 +524,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	void (*strset_clear_func)(struct strset *) =
 		reinitialize ? strset_partial_clear : strset_clear;
 
-	if (opti->pool)
-		strmap_clear_func(&opti->paths, 0);
-	else {
-		/*
-		 * We marked opti->paths with strdup_strings = 0, so that
-		 * we wouldn't have to make another copy of the fullpath
-		 * created by make_traverse_path from setup_path_info().
-		 * But, now that we've used it and have no other references
-		 * to these strings, it is time to deallocate them.
-		 */
-		free_strmap_strings(&opti->paths);
-		strmap_clear_func(&opti->paths, 1);
-	}
+	strmap_clear_func(&opti->paths, 0);
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
@@ -558,20 +533,6 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	 */
 	strmap_clear_func(&opti->conflicted, 0);
 
-	if (!opti->pool) {
-		/*
-		 * opti->paths_to_free is similar to opti->paths; we
-		 * created it with strdup_strings = 0 to avoid making
-		 * _another_ copy of the fullpath but now that we've used
-		 * it and have no other references to these strings, it is
-		 * time to deallocate them.  We do so by temporarily
-		 * setting strdup_strings to 1.
-		 */
-		opti->paths_to_free.strdup_strings = 1;
-		string_list_clear(&opti->paths_to_free, 0);
-		opti->paths_to_free.strdup_strings = 0;
-	}
-
 	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
 		discard_index(&opti->attr_index);
 
@@ -621,9 +582,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_clear(&opti->output, 0);
 	}
 
-	mem_pool_discard(&opti->internal_pool, 0);
-	if (!reinitialize)
-		opti->pool = NULL;
+	mem_pool_discard(&opti->pool, 0);
 
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
@@ -846,7 +805,7 @@ static void setup_path_info(struct merge_options *opt,
 	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
 	assert(resolved == (merged_version != NULL));
 
-	mi = mem_pool_calloc(opt->priv->pool, 1,
+	mi = mem_pool_calloc(&opt->priv->pool, 1,
 			     resolved ? sizeof(struct merged_info) :
 					sizeof(struct conflict_info));
 	mi->directory_name = current_dir_name;
@@ -895,7 +854,7 @@ static void add_pair(struct merge_options *opt,
 		     unsigned dir_rename_mask)
 {
 	struct diff_filespec *one, *two;
-	struct mem_pool *pool = opt->priv->pool;
+	struct mem_pool *pool = &opt->priv->pool;
 	struct rename_info *renames = &opt->priv->renames;
 	int names_idx = is_add ? side : 0;
 
@@ -1141,7 +1100,7 @@ static int collect_merge_info_callback(int n,
 	len = traverse_path_len(info, p->pathlen);
 
 	/* +1 in both of the following lines to include the NUL byte */
-	fullpath = mem_pool_alloc(opt->priv->pool, len + 1);
+	fullpath = mem_pool_alloc(&opt->priv->pool, len + 1);
 	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
 
 	/*
@@ -1396,7 +1355,7 @@ static int handle_deferred_entries(struct merge_options *opt,
 		copy = renames->deferred[side].possible_trivial_merges;
 		strintmap_init_with_options(&renames->deferred[side].possible_trivial_merges,
 					    0,
-					    opt->priv->pool,
+					    &opt->priv->pool,
 					    0);
 		strintmap_for_each_entry(&copy, &iter, entry) {
 			const char *path = entry->key;
@@ -2348,19 +2307,15 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	VERIFY_CI(ci);
 
 	/* Find parent directories missing from opt->priv->paths */
-	if (opt->priv->pool) {
-		cur_path = mem_pool_strdup(opt->priv->pool, new_path);
-		free((char*)new_path);
-		new_path = (char *)cur_path;
-	} else {
-		cur_path = new_path;
-	}
+	cur_path = mem_pool_strdup(&opt->priv->pool, new_path);
+	free((char*)new_path);
+	new_path = (char *)cur_path;
 
 	while (1) {
 		/* Find the parent directory of cur_path */
 		char *last_slash = strrchr(cur_path, '/');
 		if (last_slash) {
-			parent_name = mem_pool_strndup(opt->priv->pool,
+			parent_name = mem_pool_strndup(&opt->priv->pool,
 						       cur_path,
 						       last_slash - cur_path);
 		} else {
@@ -2371,8 +2326,6 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		/* Look it up in opt->priv->paths */
 		entry = strmap_get_entry(&opt->priv->paths, parent_name);
 		if (entry) {
-			if (!opt->priv->pool)
-				free((char*)parent_name);
 			parent_name = entry->key; /* reuse known pointer */
 			break;
 		}
@@ -2399,16 +2352,6 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		parent_name = cur_dir;
 	}
 
-	if (!opt->priv->pool) {
-		/*
-		 * We are removing old_path from opt->priv->paths.
-		 * old_path also will eventually need to be freed, but it
-		 * may still be used by e.g.  ci->pathnames.  So, store it
-		 * in another string-list for now.
-		 */
-		string_list_append(&opt->priv->paths_to_free, old_path);
-	}
-
 	assert(ci->filemask == 2 || ci->filemask == 4);
 	assert(ci->dirmask == 0);
 	strmap_remove(&opt->priv->paths, old_path, 0);
@@ -2442,8 +2385,6 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		new_ci->stages[index].mode = ci->stages[index].mode;
 		oidcpy(&new_ci->stages[index].oid, &ci->stages[index].oid);
 
-		if (!opt->priv->pool)
-			free(ci);
 		ci = new_ci;
 	}
 
@@ -2859,7 +2800,7 @@ static void use_cached_pairs(struct merge_options *opt,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
-	struct mem_pool *pool = opt->priv->pool;
+	struct mem_pool *pool = &opt->priv->pool;
 
 	/*
 	 * Add to side_pairs all entries from renames->cached_pairs[side_index].
@@ -2871,25 +2812,20 @@ static void use_cached_pairs(struct merge_options *opt,
 		const char *new_name = entry->value;
 		if (!new_name)
 			new_name = old_name;
-		if (pool) {
-			/*
-			 * cached_pairs has _copies* of old_name and new_name,
-			 * because it has to persist across merges.  When
-			 *   pool != NULL
-			 * pool_alloc_filespec() will just re-use the existing
-			 * filenames, which will also get re-used by
-			 * opt->priv->paths if they become renames, and then
-			 * get freed at the end of the merge, leaving the copy
-			 * in cached_pairs dangling.  Avoid this by making a
-			 * copy here.
-			 *
-			 * When pool == NULL, pool_alloc_filespec() calls
-			 * alloc_filespec(), which makes a copy; we don't want
-			 * to add another.
-			 */
-			old_name = mem_pool_strdup(pool, old_name);
-			new_name = mem_pool_strdup(pool, new_name);
-		}
+
+		/*
+		 * cached_pairs has _copies* of old_name and new_name,
+		 * because it has to persist across merges.
+		 *
+		 * pool_alloc_filespec() will just re-use the existing
+		 * filenames, which will also get re-used by
+		 * opt->priv->paths if they become renames, and then
+		 * get freed at the end of the merge, leaving the copy
+		 * in cached_pairs dangling.  Avoid this by making a
+		 * copy here.
+		 */
+		old_name = mem_pool_strdup(pool, old_name);
+		new_name = mem_pool_strdup(pool, new_name);
 
 		/* We don't care about oid/mode, only filenames and status */
 		one = pool_alloc_filespec(pool, old_name);
@@ -3002,7 +2938,7 @@ static int detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
-				 opt->priv->pool,
+				 &opt->priv->pool,
 				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index],
@@ -3053,7 +2989,7 @@ static int collect_renames(struct merge_options *opt,
 
 		if (p->status != 'A' && p->status != 'R') {
 			possibly_cache_new_pair(renames, p, side_index, NULL);
-			pool_diff_free_filepair(opt->priv->pool, p);
+			pool_diff_free_filepair(&opt->priv->pool, p);
 			continue;
 		}
 
@@ -3066,7 +3002,7 @@ static int collect_renames(struct merge_options *opt,
 
 		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (p->status != 'R' && !new_path) {
-			pool_diff_free_filepair(opt->priv->pool, p);
+			pool_diff_free_filepair(&opt->priv->pool, p);
 			continue;
 		}
 
@@ -3184,7 +3120,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 		side_pairs = &renames->pairs[s];
 		for (i = 0; i < side_pairs->nr; ++i) {
 			struct diff_filepair *p = side_pairs->queue[i];
-			pool_diff_free_filepair(opt->priv->pool, p);
+			pool_diff_free_filepair(&opt->priv->pool, p);
 		}
 	}
 
@@ -3197,7 +3133,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 	if (combined.nr) {
 		int i;
 		for (i = 0; i < combined.nr; i++)
-			pool_diff_free_filepair(opt->priv->pool,
+			pool_diff_free_filepair(&opt->priv->pool,
 						combined.queue[i]);
 		free(combined.queue);
 	}
@@ -3672,7 +3608,7 @@ static void process_entry(struct merge_options *opt,
 		 * the directory to remain here, so we need to move this
 		 * path to some new location.
 		 */
-		new_ci = mem_pool_calloc(opt->priv->pool, 1, sizeof(*new_ci));
+		new_ci = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*new_ci));
 
 		/* We don't really want new_ci->merged.result copied, but it'll
 		 * be overwritten below so it doesn't matter.  We also don't
@@ -3765,7 +3701,7 @@ static void process_entry(struct merge_options *opt,
 			const char *a_path = NULL, *b_path = NULL;
 			int rename_a = 0, rename_b = 0;
 
-			new_ci = mem_pool_alloc(opt->priv->pool,
+			new_ci = mem_pool_alloc(&opt->priv->pool,
 						sizeof(*new_ci));
 
 			if (S_ISREG(a_mode))
@@ -3835,19 +3771,8 @@ static void process_entry(struct merge_options *opt,
 				b_path = path;
 			strmap_put(&opt->priv->paths, b_path, new_ci);
 
-			if (rename_a && rename_b) {
+			if (rename_a && rename_b)
 				strmap_remove(&opt->priv->paths, path, 0);
-				/*
-				 * We removed path from opt->priv->paths.  path
-				 * will also eventually need to be freed if not
-				 * part of a memory pool...but it may still be
-				 * used by e.g. ci->pathnames.  So, store it in
-				 * another string-list for now in that case.
-				 */
-				if (!opt->priv->pool)
-					string_list_append(&opt->priv->paths_to_free,
-							   path);
-			}
 
 			/*
 			 * Do special handling for b_path since process_entry()
@@ -4454,8 +4379,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	/* Initialization of various renames fields */
 	renames = &opt->priv->renames;
-	mem_pool_init(&opt->priv->internal_pool, 0);
-	pool = opt->priv->pool = &opt->priv->internal_pool;
+	mem_pool_init(&opt->priv->pool, 0);
+	pool = &opt->priv->pool;
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		strintmap_init_with_options(&renames->dirs_removed[i],
 					    NOT_RELEVANT, pool, 0);
@@ -4492,15 +4417,13 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * Although we initialize opt->priv->paths with strdup_strings=0,
 	 * that's just to avoid making yet another copy of an allocated
 	 * string.  Putting the entry into paths means we are taking
-	 * ownership, so we will later free it.  paths_to_free is similar.
+	 * ownership, so we will later free it.
 	 *
 	 * In contrast, conflicted just has a subset of keys from paths, so
 	 * we don't want to free those (it'd be a duplicate free).
 	 */
 	strmap_init_with_options(&opt->priv->paths, pool, 0);
 	strmap_init_with_options(&opt->priv->conflicted, pool, 0);
-	if (!opt->priv->pool)
-		string_list_init_nodup(&opt->priv->paths_to_free);
 
 	/*
 	 * keys & strbufs in output will sometimes need to outlive "paths",

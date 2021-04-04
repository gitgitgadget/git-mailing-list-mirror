Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20051C43460
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 02:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC066136B
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 02:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhDDBtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 21:49:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51826 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbhDDBtP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 21:49:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FE6AA0D9F;
        Sat,  3 Apr 2021 21:49:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NChGA6qcJmE84x5zbXzyCuZIuNQ=; b=FN13fh
        susd32hAP5suhsb9whNiiQtQPJ2e2yxYhI1k1S7Ot6tvy9XBXT09YQJRWfBjVldH
        Ldp5Hjs9GRtswZ1eiwAFrCu6A5XvRaJGV3z4vYBaBYn2S8VR4/CCjzXKcyumNUgt
        A8q+F93CNy7XAUkqZ2wEkzBKjx03oFFm9neEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m/ubQpDremQyl6kpLkDbBYcou30OfSqY
        SWdbYnXMml8nZ4sXhQK2qg0Bsmu722Uuhkh3ELSNXARtVwCzbATpvCT0r4pdxpXH
        8Nu/1YfdRpe0k2kMr5aqo7FZZ+GKKRvKsml8g8H/RB90oc3COsa9e3i49peaU33f
        iZarUa00VuM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47782A0D9D;
        Sat,  3 Apr 2021 21:49:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE9A7A0D9B;
        Sat,  3 Apr 2021 21:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chinmoy <chinmoy12c@gmail.com>
Subject: Re: [PATCH v3] cache-tree.c: remove implicit dependency on
 the_repository
References: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
        <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
Date:   Sat, 03 Apr 2021 18:49:10 -0700
In-Reply-To: <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com> (Chinmoy
        via GitGitGadget's message of "Sat, 03 Apr 2021 15:57:00 +0000")
Message-ID: <xmqqpmzazund.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F377130E-94E7-11EB-9005-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chinmoy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>
> This kills the_repository dependency in cache_tree_update(),

That part of the sentence is good.  But the next four lines are not.

> but for unpack_trees(), they still assume the_repository
> (which also means the_index).
>
> Unfortunately the widespread use of unpack_trees() will make
> it hard to make the conversion now.

As long as all the users of unpack_trees() want to work with the
primary in-core index instance, that is not a problem.  There is no
need to lament with a phrase like "unfortunately".  If you are not
touching unpack_trees(), but you needed to adjust its use of
cache_tree_update(), then none of the above needs to be said.  If
you change one API function (i.e. cache_tree_update()), all callers
need to be adjusted for that change, but if one caller only wants to
work in the primary repository and with its primary index, that is
fine.  You change it so that it passes the repository and the index
it wants the updated unpack_trees() to work on, and there is nothing
notable in it.

> The `update_main_cache_tree()` method uses `cache_tree_update(r, r->index, flags)`.
> `r->index` is easily deduced from `r` but the signature of `cache_tree_update()`
> is not changed to take `struct repository *` instead of `struct index_state *`
> because there can be temporary indexes. Therefore, one might want to update
> the cache tree for an index other than `r->index`.

The flow of explanation of the thought in this paragraph is probably
backwards for most people to understand what you wanted to say.

    The cache_tree_update() was originally designed to take an istate so
    that it can work on an instance of in-core index that is not the
    primary one for the repository, and we want to keep that property
    while teaching the subsystem how to deal with a repository other
    than the_repository.  Hence it can take a pointer to the repository
    and a pointer to istate separately.

Nothing else needs to be said.  The update-main-cache-tree is a thin
wrapper to work on cache tree for THE MAIN in-core index instance,
so it is natural if it needs to pass r and r->index, exactly because
the latter is THE MAIN in-core index instance for the repository.
That is too obvious that it is best left unsaid, for the same reason
why you shouldn't even mention what you did in updating the use of
update_cache_tree() inside unpack_trees().  There is nothing notable
in there.

cf. Documentation/SubmittingPatches
[[describe-changes]]
[[summary-section]]
[[meaningful-message]]
[[imperative-mood]]


> This commit also fixes the `sparse-index.c` file in which
> the `convert_to_sparse()` and `ensure_full_index()`
> method use `cache_tree_update()`.

What branch did you base this patch on?  There is no update_cache_tree()
call in sparse-index.c on 'master' (well, there is no sparse-index.c
in 'master' to begin with).  

While it is not prohibited to build on a commit that is not on
'master', you'd need to keep your dependencies to the minimum so
that the topic won't be taken hostage by other topics that do not
move quickly enough to your liking.  Building on 'next' or 'seen'
as a whole is a guarantee that the topic will never hit 'master',
as no tip of 'next' will ever be merged directly to 'master'.

And if you are building somewhere other than the tip of 'master', it
is necessary to say where, in order to save confusion and wasted
effort for your readers.  E.g.  "This patch was made on top of
merging topic 'X' and 'Y' into 'master'".  Then you'd only have to
wait for 'X' and 'Y' to graduate to 'master' before the topic can
proceed.

Thanks.


>  builtin/checkout.c              | 11 ++++++-----
>  cache-tree.c                    | 10 ++++++----
>  cache-tree.h                    |  6 ++++--
>  sequencer.c                     |  6 +++---
>  sparse-index.c                  | 13 ++++++++-----
>  t/helper/test-dump-cache-tree.c |  2 +-
>  unpack-trees.c                  | 19 ++++++++++---------
>  7 files changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 0e6639052001..33d762a7caf9 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -684,6 +684,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  	int ret;
>  	struct lock_file lock_file = LOCK_INIT;
>  	struct tree *new_tree;
> +	struct repository *r = the_repository;
>  
>  	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>  	if (read_cache_preload(NULL) < 0)
> @@ -768,7 +769,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  				return 1;
>  			old_tree = get_commit_tree(old_branch_info->commit);
>  
> -			if (repo_index_has_changes(the_repository, old_tree, &sb))
> +			if (repo_index_has_changes(r, old_tree, &sb))
>  				die(_("cannot continue with staged changes in "
>  				      "the following files:\n%s"), sb.buf);
>  			strbuf_release(&sb);
> @@ -787,9 +788,9 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			 */
>  
>  			add_files_to_cache(NULL, NULL, 0);
> -			init_merge_options(&o, the_repository);
> +			init_merge_options(&o, r);
>  			o.verbosity = 0;
> -			work = write_in_core_index_as_tree(the_repository);
> +			work = write_in_core_index_as_tree(r);
>  
>  			ret = reset_tree(new_tree,
>  					 opts, 1,
> @@ -822,9 +823,9 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  	}
>  
>  	if (!cache_tree_fully_valid(active_cache_tree))
> -		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
> +		cache_tree_update(r, r->index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
>  
> -	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> +	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
>  		die(_("unable to write new index file"));
>  
>  	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
> diff --git a/cache-tree.c b/cache-tree.c
> index 11bf1fcae6e1..011cfd01c565 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -452,7 +452,7 @@ static int update_one(struct cache_tree *it,
>  	return i;
>  }
>  
> -int cache_tree_update(struct index_state *istate, int flags)
> +int cache_tree_update(struct repository *r, struct index_state *istate, int flags)
>  {
>  	int skip, i;
>  
> @@ -467,10 +467,10 @@ int cache_tree_update(struct index_state *istate, int flags)
>  		istate->cache_tree = cache_tree();
>  
>  	trace_performance_enter();
> -	trace2_region_enter("cache_tree", "update", the_repository);
> +	trace2_region_enter("cache_tree", "update", r);
>  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
>  		       "", 0, &skip, flags);
> -	trace2_region_leave("cache_tree", "update", the_repository);
> +	trace2_region_leave("cache_tree", "update", r);
>  	trace_performance_leave("cache_tree_update");
>  	if (i < 0)
>  		return i;
> @@ -654,12 +654,14 @@ static int write_index_as_tree_internal(struct object_id *oid,
>  					int flags,
>  					const char *prefix)
>  {
> +	struct repository *r = the_repository;
> +
>  	if (flags & WRITE_TREE_IGNORE_CACHE_TREE) {
>  		cache_tree_free(&index_state->cache_tree);
>  		cache_tree_valid = 0;
>  	}
>  
> -	if (!cache_tree_valid && cache_tree_update(index_state, flags) < 0)
> +	if (!cache_tree_valid && cache_tree_update(r, index_state, flags) < 0)
>  		return WRITE_TREE_UNMERGED_INDEX;
>  
>  	if (prefix) {
> diff --git a/cache-tree.h b/cache-tree.h
> index 8efeccebfc9f..80cc38f176c2 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -33,7 +33,7 @@ void cache_tree_write(struct strbuf *, struct cache_tree *root);
>  struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
>  
>  int cache_tree_fully_valid(struct cache_tree *);
> -int cache_tree_update(struct index_state *, int);
> +int cache_tree_update(struct repository *, struct index_state *, int);
>  void cache_tree_verify(struct repository *, struct index_state *);
>  
>  /* bitmasks to write_index_as_tree flags */
> @@ -62,9 +62,11 @@ static inline int write_cache_as_tree(struct object_id *oid, int flags, const ch
>  
>  static inline int update_main_cache_tree(int flags)
>  {
> +	struct repository *r = the_repository;
> +
>  	if (!the_index.cache_tree)
>  		the_index.cache_tree = cache_tree();
> -	return cache_tree_update(&the_index, flags);
> +	return cache_tree_update(r, r->index, flags);
>  }
>  #endif
>  
> diff --git a/sequencer.c b/sequencer.c
> index d2332d3e1787..b0fad54ae5a4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -677,10 +677,10 @@ static int do_recursive_merge(struct repository *r,
>  	return !clean;
>  }
>  
> -static struct object_id *get_cache_tree_oid(struct index_state *istate)
> +static struct object_id *get_cache_tree_oid(struct repository *r, struct index_state *istate)
>  {
>  	if (!cache_tree_fully_valid(istate->cache_tree))
> -		if (cache_tree_update(istate, 0)) {
> +		if (cache_tree_update(r, istate, 0)) {
>  			error(_("unable to update cache tree"));
>  			return NULL;
>  		}
> @@ -710,7 +710,7 @@ static int is_index_unchanged(struct repository *r)
>  	if (parse_commit(head_commit))
>  		return -1;
>  
> -	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
> +	if (!(cache_tree_oid = get_cache_tree_oid(r, istate)))
>  		return -1;
>  
>  	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
> diff --git a/sparse-index.c b/sparse-index.c
> index 95ea17174da3..e4323ffd81db 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -128,12 +128,14 @@ int set_sparse_index_config(struct repository *repo, int enable)
>  int convert_to_sparse(struct index_state *istate)
>  {
>  	int test_env;
> +	struct repository *r = the_repository;
> +
>  	if (istate->split_index || istate->sparse_index ||
>  	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>  		return 0;
>  
>  	if (!istate->repo)
> -		istate->repo = the_repository;
> +		istate->repo = r;
>  
>  	/*
>  	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
> @@ -161,7 +163,7 @@ int convert_to_sparse(struct index_state *istate)
>  		return -1;
>  	}
>  
> -	if (cache_tree_update(istate, 0)) {
> +	if (cache_tree_update(r, istate, 0)) {
>  		warning(_("unable to update cache-tree, staying full"));
>  		return -1;
>  	}
> @@ -175,7 +177,7 @@ int convert_to_sparse(struct index_state *istate)
>  
>  	/* Clear and recompute the cache-tree */
>  	cache_tree_free(&istate->cache_tree);
> -	cache_tree_update(istate, 0);
> +	cache_tree_update(r, istate, 0);
>  
>  	istate->sparse_index = 1;
>  	trace2_region_leave("index", "convert_to_sparse", istate->repo);
> @@ -216,12 +218,13 @@ void ensure_full_index(struct index_state *istate)
>  	int i;
>  	struct index_state *full;
>  	struct strbuf base = STRBUF_INIT;
> +	struct repository *r = the_repository;
>  
>  	if (!istate || !istate->sparse_index)
>  		return;
>  
>  	if (!istate->repo)
> -		istate->repo = the_repository;
> +		istate->repo = r;
>  
>  	trace2_region_enter("index", "ensure_full_index", istate->repo);
>  
> @@ -279,7 +282,7 @@ void ensure_full_index(struct index_state *istate)
>  
>  	/* Clear and recompute the cache-tree */
>  	cache_tree_free(&istate->cache_tree);
> -	cache_tree_update(istate, 0);
> +	cache_tree_update(r, istate, 0);
>  
>  	trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
> diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
> index 6a3f88f5f5d4..e6d57f9900f6 100644
> --- a/t/helper/test-dump-cache-tree.c
> +++ b/t/helper/test-dump-cache-tree.c
> @@ -64,6 +64,6 @@ int cmd__dump_cache_tree(int ac, const char **av)
>  		die("unable to read index file");
>  	istate = the_index;
>  	istate.cache_tree = another;
> -	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
> +	cache_tree_update(the_repository, &istate, WRITE_TREE_DRY_RUN);
>  	return dump_cache_tree(active_cache_tree, another, "");
>  }
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 0b888dab2246..e6bf576e174a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1571,7 +1571,7 @@ static int verify_absent(const struct cache_entry *,
>   */
>  int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
>  {
> -	struct repository *repo = the_repository;
> +	struct repository *r = the_repository;
>  	int i, ret;
>  	static struct cache_entry *dfc;
>  	struct pattern_list pl;
> @@ -1581,10 +1581,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
>  
>  	trace_performance_enter();
> -	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
> +	trace2_region_enter("unpack_trees", "unpack_trees", r);
>  
> -	prepare_repo_settings(repo);
> -	if (repo->settings.command_requires_full_index) {
> +	prepare_repo_settings(r);
> +	if (r->settings.command_requires_full_index) {
>  		ensure_full_index(o->src_index);
>  		ensure_full_index(o->dst_index);
>  	}
> @@ -1662,9 +1662,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  		}
>  
>  		trace_performance_enter();
> -		trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
> +		trace2_region_enter("unpack_trees", "traverse_trees", r);
>  		ret = traverse_trees(o->src_index, len, t, &info);
> -		trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
> +		trace2_region_leave("unpack_trees", "traverse_trees", r);
>  		trace_performance_leave("traverse_trees");
>  		if (ret < 0)
>  			goto return_failed;
> @@ -1732,9 +1732,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  		move_index_extensions(&o->result, o->src_index);
>  		if (!ret) {
>  			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
> -				cache_tree_verify(the_repository, &o->result);
> +				cache_tree_verify(r, &o->result);
>  			if (!cache_tree_fully_valid(o->result.cache_tree))
> -				cache_tree_update(&o->result,
> +				cache_tree_update(r,
> +						  &o->result,
>  						  WRITE_TREE_SILENT |
>  						  WRITE_TREE_REPAIR);
>  		}
> @@ -1750,7 +1751,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  done:
>  	if (free_pattern_list)
>  		clear_pattern_list(&pl);
> -	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
> +	trace2_region_leave("unpack_trees", "unpack_trees", r);
>  	trace_performance_leave("unpack_trees");
>  	return ret;
>  
>
> base-commit: c9e40ae8ec41c5566e5849a87c969fa81ef49fcd

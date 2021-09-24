Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD9C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03EC6105A
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbhIXRhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:37:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51903 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbhIXRhI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:37:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C2301528C2;
        Fri, 24 Sep 2021 13:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ChfJ72oVuxRq6JOFxsWJLnQOX8Gn1y3k3afaHk
        J8rvw=; b=Pb/GtW+7cXeybBr7n/Y5r6xFJ+WwgDA+QG/eTg3fhz8OJsEGp4KtT0
        b2f4NenDhUTMg+JMub6o0boVNcrK7Nbg7coOBI2jQDc2rw8Gj+GJjqS9I8pASeWj
        vt4FGSEQe8UQKQYRA6v1h/B6Fi8T9rqpeVYrDnhM9Q3tx2QQwy8ek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8334A1528C1;
        Fri, 24 Sep 2021 13:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBE051528C0;
        Fri, 24 Sep 2021 13:35:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/6] Change unpack_trees' 'reset' flag into an enum
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
        <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <b77692b8f49e6551de201104d0e3527f3379b017.1632465429.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 10:35:30 -0700
In-Reply-To: <b77692b8f49e6551de201104d0e3527f3379b017.1632465429.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 24 Sep 2021
        06:37:05 +0000")
Message-ID: <xmqq7df5x4f1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D11D8C80-1D5D-11EC-803C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Also, note that 'git checkout <pathspec>' currently also allows
> overwriting untracked files.  That case should also be fixed, ...

I wasted a few minutes wondering about the example.  Please make it
clear that you are checking out of a tree-ish that is different from
HEAD, as there will by definition no "overwriting untracked" if you
are checking out of the index.

E.g. "git checkout <tree-ish> -- <pathspec>".

With this command line:

   $ git checkout HEAD~24 -- path

where path used to be there as late as 24 revisions ago, but since
then we removed, and the user wants to materialize the file out of
the old version, path, be it tracked, untracked, or even a
directory, should be made identical to the copy from the given
version, no?  Where does the "should also be fixed" come from?

> diff --git a/builtin/am.c b/builtin/am.c
> index c79e0167e98..b17baa67ad8 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1918,8 +1918,14 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
>  	opts.dst_index = &the_index;
>  	opts.update = 1;
>  	opts.merge = 1;
> -	opts.reset = reset;
> +	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
>  	opts.fn = twoway_merge;
> +	if (opts.reset) {
> +		/* Allow ignored files in the way to get overwritten */
> +		opts.dir = xcalloc(1, sizeof(*opts.dir));
> +		opts.dir->flags |= DIR_SHOW_IGNORED;
> +		setup_standard_excludes(opts.dir);

Do these three lines make a recurring pattern when opts.reset is set?
I am wondering if this can be done more centrally by the unpack-trees
machinery (i.e. "gee this one has o->reset set to X, so let's set up
the o->dir before doing anything").

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b5d477919a7..52826e0d145 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -641,23 +641,37 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>  {
>  	struct unpack_trees_options opts;
>  	struct tree_desc tree_desc;
> +	int unpack_trees_ret;
>  
>  	memset(&opts, 0, sizeof(opts));
>  	opts.head_idx = -1;
>  	opts.update = worktree;
>  	opts.skip_unmerged = !worktree;
> -	opts.reset = 1;
> +	opts.reset = o->force ? UNPACK_RESET_OVERWRITE_UNTRACKED :
> +				UNPACK_RESET_PROTECT_UNTRACKED;
>  	opts.merge = 1;
>  	opts.fn = oneway_merge;
>  	opts.verbose_update = o->show_progress;
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
> +	if (o->overwrite_ignore) {
> +		opts.dir = xcalloc(1, sizeof(*opts.dir));
> +		opts.dir->flags |= DIR_SHOW_IGNORED;
> +		setup_standard_excludes(opts.dir);
> +	}

If our longer term goal is to decide classification of files not in
the index (currently, "ignored" and "untracked", but we may want to
add a new "precious" class) and (across various commands that build
on the unpack-trees infrastructure) to protect the "untracked" and
"precious" ones, with --[no-]overwrite-{ignore,untracked} options as
escape hatches, uniformly, perhaps the --[no-]-overwrite-ignore
option may be stolen from here and shifted to unpack_tree_options to
help us going in that direction?  This is just an observation for
longer term, not a suggestion to include the first step for such a
move in this series.

>  	init_checkout_metadata(&opts.meta, info->refname,
>  			       info->commit ? &info->commit->object.oid : null_oid(),
>  			       NULL);
>  	parse_tree(tree);
>  	init_tree_desc(&tree_desc, tree->buffer, tree->size);
> -	switch (unpack_trees(1, &tree_desc, &opts)) {
> +	unpack_trees_ret = unpack_trees(1, &tree_desc, &opts);
> +
> +	if (o->overwrite_ignore) {
> +		dir_clear(opts.dir);
> +		FREE_AND_NULL(opts.dir);

This dir_clear() is also a recurring theme.  See below.

> +	}
> +
> +	switch (unpack_trees_ret) {
>  	case -2:
>  		*writeout_error = 1;
>  		/*
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 485e7b04794..740fc0335af 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -174,6 +174,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>  	if (1 < opts.merge + opts.reset + prefix_set)
>  		die("Which one? -m, --reset, or --prefix?");
>  
> +	if (opts.reset)
> +		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
> +

We do not do anything about opts.dir here by default, which means we
by default do not overwrite ignored, but that's OK, because this old
command explicitly takes --exclude-per-directory to tell it what the
command should consider "ignored" and with the option given we do
prepare opts.dir just fine.

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 43e855cb887..a12ee986e9f 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -10,6 +10,7 @@
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
> +#include "dir.h"
>  #include "lockfile.h"
>  #include "tag.h"
>  #include "object.h"
> @@ -70,9 +71,20 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
>  		break;
>  	case HARD:
>  		opts.update = 1;
> -		/* fallthrough */
> +		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
> +		break;
> +	case MIXED:
> +		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> +		/* but opts.update=0, so working tree not updated */
> +		break;
>  	default:
> -		opts.reset = 1;
> +		BUG("invalid reset_type passed to reset_index");
> +	}
> +	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {

Unlike the one in "am", this cares .reset being a particular value,
not just being non-zero.  Puzzling.

It is a bit counter-intuitive in that we do not allow overwrite
ignored (which is currently a synonym for "expendable") when .reset
is set to allow us to ovewrite untracked.

> +		/* Setup opts.dir so we can overwrite ignored files */
> +		opts.dir = xcalloc(1, sizeof(*opts.dir));
> +		opts.dir->flags |= DIR_SHOW_IGNORED;
> +		setup_standard_excludes(opts.dir);

> @@ -104,6 +116,10 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
>  	ret = 0;
>  
>  out:
> +	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
> +		dir_clear(opts.dir);
> +		FREE_AND_NULL(opts.dir);

This dir_clear() is also a recurring theme.  See below.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 8f42360ca91..563f590afbd 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -237,6 +237,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  	struct tree_desc t[MAX_UNPACK_TREES];
>  	struct tree *tree;
>  	struct lock_file lock_file = LOCK_INIT;
> +	int unpack_trees_ret;
>  
>  	read_cache_preload(NULL);
>  	if (refresh_cache(REFRESH_QUIET))
> @@ -256,11 +257,23 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
>  	opts.merge = 1;
> -	opts.reset = reset;
> +	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
> +	if (opts.reset) {
> +		opts.dir = xcalloc(1, sizeof(*opts.dir));
> +		opts.dir->flags |= DIR_SHOW_IGNORED;
> +		setup_standard_excludes(opts.dir);
> +	}
>  	opts.update = update;
>  	opts.fn = oneway_merge;
>  
> -	if (unpack_trees(nr_trees, t, &opts))
> +	unpack_trees_ret = unpack_trees(nr_trees, t, &opts);
> +
> +	if (opts.reset) {
> +		dir_clear(opts.dir);
> +		FREE_AND_NULL(opts.dir);

This dir_clear() is also a recurring theme.  Why aren't their guards
uniformly "if (opts.dir)"?  The logic to decide if we set up opts.dir
or not may be far from here and may be different from code path to
code path, but the need to clear opts.dir should not have to care
why opts.dir was populated, no?


> +	}
> +
> +	if (unpack_trees_ret)
>  		return -1;
>  
>  	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> diff --git a/reset.c b/reset.c
> index 79310ae071b..1695f3828c5 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -1,5 +1,6 @@
>  #include "git-compat-util.h"
>  #include "cache-tree.h"
> +#include "dir.h"
>  #include "lockfile.h"
>  #include "refs.h"
>  #include "reset.h"
> @@ -57,8 +58,12 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>  	unpack_tree_opts.update = 1;
>  	unpack_tree_opts.merge = 1;
>  	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
> -	if (!detach_head)
> -		unpack_tree_opts.reset = 1;
> +	if (!detach_head) {
> +		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> +		unpack_tree_opts.dir = xcalloc(1, sizeof(*unpack_tree_opts.dir));
> +		unpack_tree_opts.dir->flags |= DIR_SHOW_IGNORED;
> +		setup_standard_excludes(unpack_tree_opts.dir);
> +	}
>  
>  	if (repo_read_index_unmerged(r) < 0) {
>  		ret = error(_("could not read index"));
> @@ -131,6 +136,10 @@ reset_head_refs:
>  			    oid_to_hex(oid), "1", NULL);
>  
>  leave_reset_head:
> +	if (unpack_tree_opts.dir) {
> +		dir_clear(unpack_tree_opts.dir);
> +		FREE_AND_NULL(unpack_tree_opts.dir);

Yes, I think this is the right way to decide if we call dir_clear(),
and all other hunks in this patch should do the same.

> +	}
>  	strbuf_release(&msg);
>  	rollback_lock_file(&lock);
>  	clear_unpack_trees_porcelain(&unpack_tree_opts);
> diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
> index 2412d121ea8..18604360df8 100755
> --- a/t/t2500-untracked-overwriting.sh
> +++ b/t/t2500-untracked-overwriting.sh
> @@ -92,7 +92,7 @@ test_setup_checkout_m () {
>  	)
>  }
>  
> -test_expect_failure 'checkout -m does not nuke untracked file' '
> +test_expect_success 'checkout -m does not nuke untracked file' '
>  	test_setup_checkout_m &&
>  	(
>  		cd checkout &&
> @@ -138,7 +138,7 @@ test_setup_sequencing () {
>  	)
>  }
>  
> -test_expect_failure 'git rebase --abort and untracked files' '
> +test_expect_success 'git rebase --abort and untracked files' '
>  	test_setup_sequencing rebase_abort_and_untracked &&
>  	(
>  		cd sequencing_rebase_abort_and_untracked &&
> @@ -155,7 +155,7 @@ test_expect_failure 'git rebase --abort and untracked files' '
>  	)
>  '
>  
> -test_expect_failure 'git rebase fast forwarding and untracked files' '
> +test_expect_success 'git rebase fast forwarding and untracked files' '
>  	test_setup_sequencing rebase_fast_forward_and_untracked &&
>  	(
>  		cd sequencing_rebase_fast_forward_and_untracked &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 5786645f315..fcbe63bbed9 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1693,6 +1693,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	struct pattern_list pl;
>  	int free_pattern_list = 0;
>  
> +	if (o->reset == UNPACK_RESET_INVALID)
> +		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
> +
>  	if (len > MAX_UNPACK_TREES)
>  		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
>  
> @@ -2218,7 +2221,8 @@ static int verify_absent_1(const struct cache_entry *ce,
>  	int len;
>  	struct stat st;
>  
> -	if (o->index_only || o->reset || !o->update)
> +	if (o->index_only || !o->update ||
> +	    o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
>  		return 0;
>  
>  	len = check_leading_path(ce->name, ce_namelen(ce), 0);
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 2d88b19dca7..1f386fb16cc 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -45,9 +45,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>   */
>  void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
>  
> +enum unpack_trees_reset_type {
> +	UNPACK_RESET_NONE = 0,    /* traditional "false" value; still valid */
> +	UNPACK_RESET_INVALID = 1, /* "true" no longer valid; use below values */
> +	UNPACK_RESET_PROTECT_UNTRACKED,
> +	UNPACK_RESET_OVERWRITE_UNTRACKED
> +};
> +
>  struct unpack_trees_options {
> -	unsigned int reset,
> -		     merge,
> +	unsigned int merge,
>  		     update,
>  		     clone,
>  		     index_only,
> @@ -64,6 +70,7 @@ struct unpack_trees_options {
>  		     exiting_early,
>  		     show_all_errors,
>  		     dry_run;
> +	enum unpack_trees_reset_type reset;
>  	const char *prefix;
>  	int cache_bottom;
>  	struct dir_struct *dir;

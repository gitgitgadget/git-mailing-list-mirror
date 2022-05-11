Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807E0C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 00:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiEKA0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 20:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbiEKA0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 20:26:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857445D5DF
        for <git@vger.kernel.org>; Tue, 10 May 2022 17:26:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FDC418E79C;
        Tue, 10 May 2022 20:26:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q9sFKKCS4G35jZ1bJp1UBfyAr4C/P3lBx9MrcB
        5p614=; b=dQZKFiqEAD0NQ5/TXlGWFbhTGl9L6exc/wT5/5aCK5lTrIVNT1tBE2
        35YZ2LbOtVP8FhOxjWVYbjeDWa9iZfLhn5aDQHv7METjscZoVqDkbaaROmSATxIt
        c8GoVdgvBWnBzyAs5pGxdvr5V+GFtRqBmoGn3EhnA9nQu7OkKUWiE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 377E318E79B;
        Tue, 10 May 2022 20:26:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D91A518E79A;
        Tue, 10 May 2022 20:26:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 5/6] stash: apply stash using 'merge_ort_nonrecursive()'
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
        <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
        <e733c2fd9f497a8d80555126ec2e166e182ab8db.1652225552.git.gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 17:26:43 -0700
In-Reply-To: <e733c2fd9f497a8d80555126ec2e166e182ab8db.1652225552.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Tue, 10 May 2022 23:32:31
        +0000")
Message-ID: <xmqqsfpg52yk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 098BA784-D0C1-11EC-8DF4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1bfba532044..3fe549f7d3c 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -492,13 +493,13 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
>  static int do_apply_stash(const char *prefix, struct stash_info *info,
>  			  int index, int quiet)
>  {
> -	int ret;
> +	int clean, ret;
>  	int has_index = index;
>  	struct merge_options o;
>  	struct object_id c_tree;
>  	struct object_id index_tree;
> -	struct commit *result;
> -	const struct object_id *bases[1];
> +	struct tree *head, *merge, *merge_base;
> +	struct lock_file lock = LOCK_INIT;
>  
>  	read_cache_preload(NULL);
>  	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> @@ -541,6 +542,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  
>  	o.branch1 = "Updated upstream";
>  	o.branch2 = "Stashed changes";
> +	o.ancestor = "Stash base";
>  
>  	if (oideq(&info->b_tree, &c_tree))
>  		o.branch1 = "Version stash was based on";
> @@ -551,10 +553,26 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  	if (o.verbosity >= 3)
>  		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
>  
> -	bases[0] = &info->b_tree;
> +	head = lookup_tree(o.repo, &c_tree);
> +	merge = lookup_tree(o.repo, &info->w_tree);
> +	merge_base = lookup_tree(o.repo, &info->b_tree);
> +
> +	repo_hold_locked_index(o.repo, &lock, LOCK_DIE_ON_ERROR);
> +	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);
> +
> +	/*
> +	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
> +	 * merge was clean, and nonzero if the merge was unclean or encountered
> +	 * an error.
> +	 */
> +	ret = clean >= 0 ? !clean : clean;
> +
> +	if (ret < 0)
> +		rollback_lock_file(&lock);
> +	else if (write_locked_index(o.repo->index, &lock,
> +				      COMMIT_LOCK | SKIP_IF_UNCHANGED))
> +		ret = error(_("could not write index"));
>  
> -	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
> -				      &result);

Nice.  We need a bit more boilerplate code, but all we need is a three-way
merge without any recursive magic.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 85c6a56f1b7..aaf4d880dbc 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1385,7 +1385,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
>  	ensure_not_expanded stash &&
>  	ensure_not_expanded stash list &&
>  	ensure_not_expanded stash show stash@{0} &&
> -	! ensure_not_expanded stash apply stash@{0} &&
> +	ensure_not_expanded stash apply stash@{0} &&
>  	ensure_not_expanded stash drop stash@{0} &&
>  
>  	echo >>sparse-index/deep/new &&
> @@ -1399,7 +1399,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
>  	oid=$(git -C sparse-index stash create) &&
>  	ensure_not_expanded stash store -m "test" $oid &&
>  	ensure_not_expanded reset --hard &&
> -	! ensure_not_expanded stash pop
> +	ensure_not_expanded stash pop
>  '
>  
>  test_expect_success 'sparse index is not expanded: diff' '

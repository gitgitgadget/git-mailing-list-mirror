Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64500C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 16:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbiEKQhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiEKQhu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 12:37:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA916D940
        for <git@vger.kernel.org>; Wed, 11 May 2022 09:37:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E13E81902C9;
        Wed, 11 May 2022 12:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PqQvekdxJRgqGBOPyOr3jNd6EFBQSJpnkuVkgp
        MlCIM=; b=Tc08OzWlHykYaglg+Sa+fIYTYlx/2aFTKNTdzz480RfZ1NmFrz4Wvr
        iX1BbN8Uon7+DUc63NILk7pJaUDl4tONY7ZCspFrd8SBYjVJkgIZymLoqudBRjA2
        sO8b8zyDrJZOXyMHBgEJODL2+PV4svhbyDdjjIw/Y/0XMR2bGor9I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D98E01902C8;
        Wed, 11 May 2022 12:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83D811902C7;
        Wed, 11 May 2022 12:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Goss Geppert <gg.oss.dev@gmail.com>
Cc:     git@vger.kernel.org, christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
References: <20220505203234.21586-1-ggossdev@gmail.com>
        <20220510171527.25778-1-ggossdev@gmail.com>
        <20220510171527.25778-2-ggossdev@gmail.com>
Date:   Wed, 11 May 2022 09:37:43 -0700
In-Reply-To: <20220510171527.25778-2-ggossdev@gmail.com> (Goss Geppert's
        message of "Tue, 10 May 2022 17:15:26 +0000")
Message-ID: <xmqq7d6sm3e0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF00F124-D148-11EC-BFCB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goss Geppert <gg.oss.dev@gmail.com> writes:

> diff --git a/dir.c b/dir.c
> index f2b0f24210..a1886e61a3 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1893,9 +1893,31 @@ static enum path_treatment treat_directory(struct dir_struct *dir,

>  	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
>  		!(dir->flags & DIR_NO_GITLINKS)) {
> +		/*
> +		 * Determine if `dirname` is a nested repo by confirming that:
> +		 * 1) we are in a nonbare repository, and
> +		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
> +		 *    which could occur if the `worktree` location was manually
> +		 *    configured by the user; see t2205 testcases 1a-1d for examples
> +		 *    where this matters
> +		 */
>  		struct strbuf sb = STRBUF_INIT;
>  		strbuf_addstr(&sb, dirname);
>  		nested_repo = is_nonbare_repository_dir(&sb);
> +
> +		if (nested_repo) {
> +			char *real_dirname, *real_gitdir;
> +			strbuf_reset(&sb);
> +			strbuf_addstr(&sb, dirname);
> +			strbuf_complete(&sb, '/');
> +			strbuf_addstr(&sb, ".git");
> +			real_dirname = real_pathdup(sb.buf, 0);

Is this _complete() necessary?

Near the top of this function there is

	/* The "len-1" is to strip the final '/' */
	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);

which indicates that we are safe to assume dirname ends with '/'.

> +			real_gitdir = real_pathdup(the_repository->gitdir, 0);

This function is repeatedly called during the traversal.

How expensive is it to keep calling real_pathdup() on the constant
the_repository->gitdir just in case it might be the same as our true
GIT_DIR?

> +
> +			nested_repo = !!strcmp(real_dirname, real_gitdir);
> +			free(real_gitdir);
> +			free(real_dirname);
> +		}
>  		strbuf_release(&sb);
>  	}
>  	if (nested_repo) {
> diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
> new file mode 100755
> index 0000000000..ca70cf3fe2
> --- /dev/null
> +++ b/t/t2205-add-worktree-config.sh
> @@ -0,0 +1,89 @@
> +#!/bin/sh
> +
> +test_description='directory traversal respects worktree config
> +
> +This test configures the repository`s worktree to be two levels above the
> +`.git` directory and checks whether we are able to add to the index those files
> +that are in either (1) the manually configured worktree directory or (2) the
> +standard worktree location with respect to the `.git` directory (i.e. ensuring
> +that the encountered `.git` directory is not treated as belonging to a foreign
> +nested repository)'
> +
> +. ./test-lib.sh
> +
> +test_expect_success '1a: setup' '
> +	test_create_repo test1 &&
> +	git --git-dir="test1/.git" config core.worktree "$(pwd)" &&
> +
> +	mkdir -p outside-tracked outside-untracked &&
> +	mkdir -p test1/inside-tracked test1/inside-untracked &&
> +	>file-tracked &&
> +	>file-untracked &&
> +	>outside-tracked/file &&
> +	>outside-untracked/file &&
> +	>test1/file-tracked &&
> +	>test1/file-untracked &&
> +	>test1/inside-tracked/file &&
> +	>test1/inside-untracked/file &&
> +
> +	cat >expect-tracked-unsorted <<-EOF &&
> +	../file-tracked
> +	../outside-tracked/file
> +	file-tracked
> +	inside-tracked/file
> +	EOF
> +
> +	cat >expect-untracked-unsorted <<-EOF &&
> +	../file-untracked
> +	../outside-untracked/file
> +	file-untracked
> +	inside-untracked/file
> +	EOF
> +
> +	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
> +
> +	cat >.gitignore <<-EOF
> +	.gitignore
> +	actual-*
> +	expect-*
> +	EOF
> +'
> +
> +test_expect_success '1b: pre-add all' '
> +	local parent_dir="$(pwd)" &&
> +	(
> +		cd test1 &&
> +		git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted
> +	) &&
> +	sort actual-all-unsorted >actual-all &&
> +	sort expect-all-unsorted >expect-all &&
> +	test_cmp expect-all actual-all
> +'
> +
> +test_expect_success '1c: post-add tracked' '
> +	local parent_dir="$(pwd)" &&
> +	(
> +		cd test1 &&
> +		git add file-tracked &&
> +		git add inside-tracked &&
> +		git add ../outside-tracked &&
> +		git add "$parent_dir/file-tracked" &&
> +		git ls-files "$parent_dir" >../actual-tracked-unsorted
> +	) &&
> +	sort actual-tracked-unsorted >actual-tracked &&
> +	sort expect-tracked-unsorted >expect-tracked &&
> +	test_cmp expect-tracked actual-tracked
> +'
> +
> +test_expect_success '1d: post-add untracked' '
> +	local parent_dir="$(pwd)" &&
> +	(
> +		cd test1 &&
> +		git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
> +	) &&
> +	sort actual-untracked-unsorted >actual-untracked &&
> +	sort expect-untracked-unsorted >expect-untracked &&
> +	test_cmp expect-untracked actual-untracked
> +'
> +
> +test_done

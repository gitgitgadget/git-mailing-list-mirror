Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34360C433FE
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiDHStT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbiDHStA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:49:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD22250E
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:46:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D3D0117B14;
        Fri,  8 Apr 2022 14:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rn7anzPjHtNreJ7ZybirRfLP1hXxKclVNluxI+
        ouKCc=; b=KP8+qgxjBUrvYv1Ywdz9tvs9VTkIG+VdUkH0ZBGqvzLvN9es0rOD7B
        dWgDHfqCtRiLOKXi5A9BYD3XreTWKgAcome3zD2c3WcvaH9U73lJ5zWVcw77zxGG
        g8zG2GOSy0V5JwXUbRbeArJU+aYUtiv3JPGXgWNngsMJHAdNhr7Ws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44BF9117B12;
        Fri,  8 Apr 2022 14:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 991B2117B11;
        Fri,  8 Apr 2022 14:46:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        joostkremers@fastmail.fm
Subject: Re: [PATCH] stash: disable literal treatment when passing top pathspec
References: <20220408031228.782547-1-kyle@kyleam.com>
Date:   Fri, 08 Apr 2022 11:46:52 -0700
In-Reply-To: <20220408031228.782547-1-kyle@kyleam.com> (Kyle Meyer's message
        of "Thu, 7 Apr 2022 23:12:28 -0400")
Message-ID: <xmqqa6cvmmzn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 422FB4FE-B76C-11EC-A411-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> do_push_stash() passes ":/" as the pathspec to two subprocess calls.
> When pathspecs are interpreted literally for the main process, these
> subprocess calls do not behave as intended:
>
>  * the 'git clean' call, triggered by --include-untracked, does not
>    remove untracked files from the working tree
>
>  * the 'git checkout' call, triggered by --keep-index, fails with a
>    message about ":/" not matching any known files, and the main
>    command exits with a non-zero status
>
> Fix both of these spots by passing --no-literal-pathspecs to the
> subprocess commands.

Yuck (to the original problem, not to the proposed solution).

I wonder if stopping to use ":/" (or using "." instead, if we need
to give _some_ pathspec) is a better approach.  Don't we move to the
top of the working tree by the time cmd_stash() is called and whatever
subprocess we spawn via run_command() interface will start at the
top anyway, no?

> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  builtin/stash.c                    | 5 ++++-
>  t/t3903-stash.sh                   | 5 +++++
>  t/t3905-stash-include-untracked.sh | 5 +++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 0c7b6a9588..afc8400c5d 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1529,7 +1529,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  					     GIT_WORK_TREE_ENVIRONMENT,
>  					     the_repository->worktree);
>  			}
> -			strvec_pushl(&cp.args, "clean", "--force",
> +			strvec_pushl(&cp.args, "--no-literal-pathspecs",
> +				     "clean", "--force",
>  				     "--quiet", "-d", ":/", NULL);
>  			if (include_untracked == INCLUDE_ALL_FILES)
>  				strvec_push(&cp.args, "-x");
> @@ -1592,6 +1593,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  			struct child_process cp = CHILD_PROCESS_INIT;
>  
>  			cp.git_cmd = 1;
> +			if (!ps->nr)
> +				strvec_push(&cp.args, "--no-literal-pathspecs");
>  			strvec_pushl(&cp.args, "checkout", "--no-overlay",
>  				     oid_to_hex(&info.i_tree), "--", NULL);
>  			if (!ps->nr)
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 4abbc8fcca..f85c3a06cb 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1383,6 +1383,11 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
>  	test_path_is_missing to-remove
>  '
>  
> +test_expect_success 'stash --keep-index succeeds with --literal-pathspecs' '
> +	echo modified >file &&
> +	git --literal-pathspecs stash --keep-index
> +'
> +
>  test_expect_success 'stash apply should succeed with unmodified file' '
>  	echo base >file &&
>  	git add file &&
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index 5390eec4e3..2f216274b2 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -427,5 +427,10 @@ test_expect_success 'stash -u ignores sub-repository' '
>  	git init sub-repo &&
>  	git stash -u
>  '
> +test_expect_success 'stash -u works with --literal-pathspecs' '
> +	>untracked &&
> +	git --literal-pathspecs stash -u &&
> +	test_path_is_missing untracked
> +'
>  
>  test_done
>
> base-commit: bf23fe5c37d62f37267d31d4afa1a1444f70cdac

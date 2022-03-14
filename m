Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A025C433FE
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 19:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbiCNToP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbiCNToM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 15:44:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7827B17A9B
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 12:43:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12B0017A822;
        Mon, 14 Mar 2022 15:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QCpq/lBPug7P5XBfsLyjpdKOSP/1xS2uPpOdsT
        /PgpM=; b=BS1opmXQGkO6XezrGzd1DQvYmR6dkxCLLA337BxdqvUes77dzY+CFO
        LjHiAi7JBudSeWE52ZPa7w+o8FZcPFMjOueNFjFNj7NDHuQNh6TgWDJRIJPxaT28
        GodsHKJOb206KKOYilrVFPmYT47yAMr5w9eu4K/JTKPmV9yPOFUhw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 078C817A821;
        Mon, 14 Mar 2022 15:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DAB917A81F;
        Mon, 14 Mar 2022 15:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 5/5] stash: make internal resets quiet and refresh index
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <3334d4cb6f302a35986d94ea8ffcd1ee9c6aae5d.1647274230.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 19:42:55 +0000
In-Reply-To: <3334d4cb6f302a35986d94ea8ffcd1ee9c6aae5d.1647274230.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 14 Mar 2022 16:10:30
        +0000")
Message-ID: <xmqqtuc0qq0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2241D2A-A3CE-11EC-9897-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add the options '-q' and '--refresh' to the 'git reset' executed in
> 'reset_head()', and '--refresh' to the 'git reset -q' executed in
> 'do_push_stash(...)'.
>
> 'stash' is implemented such that git commands invoked  as part of it (e.g.,
> 'clean', 'read-tree', 'reset', etc.) have their informational output
> silenced. However, the 'reset' in 'reset_head()' is *not* called with '-q',
> leading to the potential for a misleading printout from 'git stash apply
> --index' if the stash included a removed file:
>
> Unstaged changes after reset: D      <deleted file>
>
> Not only is this confusing in its own right (since, after the reset, 'git
> stash' execution would stage the deletion in the index), it would be printed
> even when the stash was applied with the '-q' option. As a result, the
> messaging is removed entirely by calling 'git status' with '-q'.
>
> Additionally, because the default behavior of 'git reset -q' is to skip
> refreshing the index, but later operations in 'git stash' subcommands expect
> a non-stale index, enable '--refresh' as well.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/stash.c  |  5 +++--
>  t/t3903-stash.sh | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 3e8af210fde..91407d9bbe0 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -310,7 +310,7 @@ static int reset_head(void)
>  	 * API for resetting.
>  	 */
>  	cp.git_cmd = 1;
> -	strvec_push(&cp.args, "reset");
> +	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
>  
>  	return run_command(&cp);
>  }
> @@ -1633,7 +1633,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  			struct child_process cp = CHILD_PROCESS_INIT;
>  
>  			cp.git_cmd = 1;
> -			strvec_pushl(&cp.args, "reset", "-q", "--", NULL);
> +			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
> +				     NULL);
>  			add_pathspecs(&cp.args, ps);
>  			if (run_command(&cp)) {
>  				ret = -1;
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index f36e121210e..17f2ad2344c 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -261,6 +261,18 @@ test_expect_success 'apply -q is quiet' '
>  	test_must_be_empty output.out
>  '
>  
> +test_expect_success 'apply --index -q is quiet' '
> +	# Added file, deleted file, modified file all staged for commit
> +	echo foo >new-file &&
> +	echo test >file &&
> +	git add new-file file &&
> +	git rm other-file &&
> +
> +	git stash &&

Hpmh.  The hunk that updates reset_head() does get exercised by
"apply --index", so testing that is OK, but we are also patching
"do_push_stash()" to be quiet, so don't we care the chattyness of
this step, too?

In these steps, we also want the same "did the command refresh the
index?" tests, no?

> +	git stash apply --index -q >output.out 2>&1 &&
> +	test_must_be_empty output.out
> +'
> +
>  test_expect_success 'save -q is quiet' '
>  	git stash save --quiet >output.out 2>&1 &&
>  	test_must_be_empty output.out

Other than these nits I noticed, the overall idea of the topic is
well presented.  Thanks for working on this.


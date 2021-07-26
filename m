Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3177C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B19C60F44
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGZR6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:58:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51696 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZR6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:58:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B2D0D03DD;
        Mon, 26 Jul 2021 14:39:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vbYfjPi1Ccq+7NaHhEK4ujbuD5WGB7drhAJeCN
        OZ7tM=; b=X7bF/AVj+hp7C5RQzkek2SaifuWfJatKj+een1cPEzLFX8h6DgHW+C
        mmzLF2kdTBicWFC6ZO43akTho6mWo2GKvtGAmZTZBfE9T2ip5B7MkYB02R5txJa5
        5fncbng+Zza6J0PBAIW4fsA/tzsw5Yc7C+8E31GKy4MfSgP41ee8w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 523FCD03DC;
        Mon, 26 Jul 2021 14:39:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5D04D03DB;
        Mon, 26 Jul 2021 14:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Oded S via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Oded S <oded@istraresearch.com>
Subject: Re: [PATCH] Fix git-bisect when show-branch is configured to run
 with pager
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 11:39:19 -0700
In-Reply-To: <pull.1003.git.1627311659384.gitgitgadget@gmail.com> (Oded S. via
        GitGitGadget's message of "Mon, 26 Jul 2021 15:00:59 +0000")
Message-ID: <xmqq4kcgkjhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9E77ECC-EE40-11EB-B418-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Oded S via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] Fix git-bisect when show-branch is configured to run with pager

Perhaps

    Subject: bisect: disable pager while invoking show-branch

cf. Documentation/SubmittingPatches (describe-changes)

> From: Oded Shimon <oded@istraresearch.com>

Here is the space for you to answer these potential questions by
future readers of your code in "git log -p" output in advance:

 * The title says "fix", but how is it broken?  If the user prefers
   to run show-branch with their pager, why would it be a good
   change to unilaterally countermand that preference?

 * When is show-branch invoked in the "git bisect" session?  Perhaps
   that justifies the unilateral disabling of the pager, but it is
   not explained here so we cannot tell why the author of this
   change thought it was a good idea.

 * We see in the patch context that "checkout" is also invoked
   somewhere in the same program, but it does not gain the
   "--no-pager" option.  Why?  If those who prefer show-branch to
   page have trouble using "bisect", wouldn't those who prefer
   "checkout" to page have the same trouble?

> Signed-off-by: Oded Shimon <oded@istraresearch.com>

Thanks for trying to make Git better.  I cannot quite tell without
these questions (and there may be others) answered in the proposed
log message if the proposed change is a good one.

Also, in the longer term, I suspect that we probably should stop
calling show-branch from this codepath and here is why.

If we look at "git show v1.5.3:git-bisect.sh" and look for
invocation of show-branch, and look for show-branch in the current
codebase wrt bisect, i.e.

    $ git grep show-branch bisect.c git-bisect.sh builtin/bisect--helper.c

we notice that we used to call the command in many more places to
write into BISECT_LOG and also after checking out the commit to be
tested.  In today's code, the latter is the only place that still
uses show-branch.  What happend to the use of the other one?  IOW,
how do we write BISECT_LOG these days in such a way that it is
compatible/comparable to the output we got from show-branch in olden
times?  Would it easy to emulate it so that we do not use show-branch
at all?  If so, reusing how the part that writes BISECT_LOG does to
show the revision after checking it out may be a good clean-up,
regardless of "show-branch pages" issue.

In any case, if the "for those with show-branch configured to page,
the current behaviour of bisect needs fixing" is true, then I think
your patch may even be worth applying before such a longer-term
change.

Thanks.


>     Fix git-bisect when show-branch is configured to run with pager
>     
>     Signed-off-by: Oded Shimon oded@istraresearch.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1003%2Foded-ist%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1003/oded-ist/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1003
>
>  bisect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index af2863d044b..c02bcc3359f 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -23,7 +23,7 @@ static struct oid_array skipped_revs;
>  static struct object_id *current_bad_oid;
>  
>  static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
> -static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
> +static const char *argv_show_branch[] = {"-P", "show-branch", NULL, NULL};
>  
>  static const char *term_bad;
>  static const char *term_good;
> @@ -748,7 +748,7 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
>  			return -abs(res);
>  	}
>  
> -	argv_show_branch[1] = bisect_rev_hex;
> +	argv_show_branch[2] = bisect_rev_hex;
>  	res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
>  	/*
>  	 * Errors in `run_command()` itself, signaled by res < 0,
>
> base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687

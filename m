Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF49C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiBXTUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXTUn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:20:43 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684571B84C9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:20:13 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 357AA10CE27;
        Thu, 24 Feb 2022 14:20:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8c58QZOZNoqb2D51auPbBQsO+gP7Ot1TiAgEpg
        kUUp4=; b=LplHoS2ZeWuLcsEMgRTbDpRJxlFFeD2Xt88cObIkpYIXHpuQfuDppC
        8Gu8hEhqjktYEIk0AQmd6TIzNmZ+h5ht6yz78cCe91WVPqxiEJawStgI5YsLg7Uh
        vVoLZa+ZPDvkoGKnBQU84fQ/13hiwjPpU475NbExqsFrf+mg0z+ks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AD5610CE25;
        Thu, 24 Feb 2022 14:20:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FDFF10CE23;
        Thu, 24 Feb 2022 14:20:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 1/3] merge: new autosetupmerge option 'simple' for
 matching branches
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
        <89efc1e15646599753baeab38ba2399dcbe868f1.1645695940.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 11:20:10 -0800
In-Reply-To: <89efc1e15646599753baeab38ba2399dcbe868f1.1645695940.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Thu, 24 Feb 2022 09:45:38
        +0000")
Message-ID: <xmqqbkywm5qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C91CEA32-95A6-11EC-AE2F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> The push.defaut option "simple" helps produce

The cover letter wrappeed around 70 columns, which was much easier
to read.

Please re-read Documentation/SubmittingPatches[[describe-changes]]
section before going forward.

> predictable/understandable behavior for beginners,
> where they don't accidentally push to the
> "wrong" branch in centralized workflows. If they
> create a local branch with a different name
> and then try to do a plain push, it will
> helpfully fail and explain why.
>
> However, such users can often find themselves
> confused by the behavior of git after they first
> branch, and before they push. At that stage,
> their upstream tracking branch is the original
> remote branch, and pull (for example) behaves
> very differently to how it later does when they
> create their own same-name remote branch.

Instead of saying "very differently", explain what happens before
and after the behaviour-change-triggering-event.

> This commit introduces a new option to the
> branch.autosetupmerge setting, "simple",
> which is intended to be consistent with and
> complementary to the push.default "simple"
> option.
>
> It will set up automatic tracking for a new
> branch only if the remote ref is a branch and
> that remote branch name matches the new local
> branch name. It is a reduction in scope of
> the existing default option, "true".
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>  branch.c | 9 +++++++++
>  branch.h | 1 +
>  config.c | 3 +++
>  3 files changed, 13 insertions(+)
>
> diff --git a/branch.c b/branch.c
> index 6b31df539a5..246bc82ce3c 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -256,6 +256,15 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  		die(_("not tracking: ambiguous information for ref %s"),
>  		    orig_ref);
>  
> +	if (track == BRANCH_TRACK_SIMPLE) {
> +		// only track if remote branch name matches
> +		// (tracking.srcs must contain only one entry from find_tracked_branch with this config)

	/*
	 * Our multi-line comments look exactly
	 * like this.  They are not overly long,
	 * have their opening and closing slash-aster
	 * and aster-slash on their own line.
	 */

> +		if (strncmp(tracking.srcs->items[0].string, "refs/heads/", 11))
> +			return;
> +		if (strcmp(tracking.srcs->items[0].string + 11, new_ref))
> +			return;


Don't count hardcoded string length.  

		char *tracked_branch;
		if (!skip_prefix(tracking.srcs->items[0].string,
				 "refs/heads/", &tracked_branch) ||
		    strcmp(tracked_branch, new_ref))
			return;

or something along the line, perhaps?

But the post-context in this hunk makes the refernece to items[0] in
the above look very wrong.  It says tracking.srcs may not have even
a single item at this point in the original code flow.  If that is
true, the above reference to ->items[0] may not be safely done at
all.

Also, what happens when there are more than one in the items[]
array?  What makes it sensible to use the first one, ignoring the
others?

> +	}
> +
>  	if (tracking.srcs->nr < 1)
>  		string_list_append(tracking.srcs, orig_ref);
>  	if (install_branch_config_multiple_remotes(config_flags, new_ref,
> diff --git a/branch.h b/branch.h
> index 04df2aa5b51..560b6b96a8f 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -12,6 +12,7 @@ enum branch_track {
>  	BRANCH_TRACK_EXPLICIT,
>  	BRANCH_TRACK_OVERRIDE,
>  	BRANCH_TRACK_INHERIT,
> +	BRANCH_TRACK_SIMPLE,
>  };
>  
>  extern enum branch_track git_branch_track;
> diff --git a/config.c b/config.c
> index e0c03d154c9..cc586ac816c 100644
> --- a/config.c
> +++ b/config.c
> @@ -1673,6 +1673,9 @@ static int git_default_branch_config(const char *var, const char *value)
>  		} else if (value && !strcmp(value, "inherit")) {
>  			git_branch_track = BRANCH_TRACK_INHERIT;
>  			return 0;
> +		} else if (value && !strcmp(value, "simple")) {
> +			git_branch_track = BRANCH_TRACK_SIMPLE;
> +			return 0;
>  		}
>  		git_branch_track = git_config_bool(var, value);
>  		return 0;

These two hunks look perfect.


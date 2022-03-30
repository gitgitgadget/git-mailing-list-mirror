Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3586C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 21:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbiC3VPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiC3VO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 17:14:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400E3EA80
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:13:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C50C911A11E;
        Wed, 30 Mar 2022 17:13:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4o7Cn2yQ0Wfm3FmvvxbKnBccHnchdrbrEAhFYq
        m8FJg=; b=GfTq9+TKVt9HqzSWeSZzAUIVc64IiIpNxld4jspTltJDoO6mfhXZ93
        zMX7ougl9BzyPMTpJiqPuTAZ8gwwWIjdZa51bSzlF7BEy7FAmnE7lGwydVnC5Uz/
        pMamFTbBO5rcP7QFnWSJL7jzqHxKAI4HgOs4OalkVXSbgUwJA+lGI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBF0C11A11D;
        Wed, 30 Mar 2022 17:13:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F97711A11C;
        Wed, 30 Mar 2022 17:13:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/4] branch: support more tracking modes when recursing
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <0b682c173c8cfa7f49ba17b2d71049ac702ec747.1648584079.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 14:13:10 -0700
In-Reply-To: <0b682c173c8cfa7f49ba17b2d71049ac702ec747.1648584079.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 29 Mar 2022 20:01:16
        +0000")
Message-ID: <xmqqee2j6t5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 344EC44C-B06E-11EC-9783-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/branch.c b/branch.c
> index 6b31df539a5..7377b9f451a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -233,6 +233,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>  
> +	if (!track)
> +		BUG("asked to set up tracking, but tracking is disallowed");

I am wondering if this wants to be

	if (track == BRANCH_TRACK_NEVER)

instead.  Do we elsewhere rely on the fact that NEVER is assigned 0?

> @@ -534,8 +537,27 @@ static int submodule_create_branch(struct repository *r,
>  		strvec_push(&child.args, "--quiet");
>  	if (reflog)
>  		strvec_push(&child.args, "--create-reflog");
> -	if (track == BRANCH_TRACK_ALWAYS || track == BRANCH_TRACK_EXPLICIT)
> -		strvec_push(&child.args, "--track");
> +
> +	switch (track) {
> +	case BRANCH_TRACK_NEVER:
> +		strvec_push(&child.args, "--no-track");
> +		break;
> +	case BRANCH_TRACK_ALWAYS:
> +	case BRANCH_TRACK_EXPLICIT:
> +		strvec_push(&child.args, "--track=direct");
> +		break;
> +	case BRANCH_TRACK_OVERRIDE:
> +		BUG("BRANCH_TRACK_OVERRIDE cannot be used when creating a branch.");
> +		break;
> +	case BRANCH_TRACK_INHERIT:
> +		strvec_push(&child.args, "--track=inherit");
> +		break;

OK.

> +	case BRANCH_TRACK_UNSPECIFIED:
> +		/* Default for "git checkout". No need to pass --track. */
> +	case BRANCH_TRACK_REMOTE:
> +		/* Default for "git branch". No need to pass --track. */
> +		break;

Is that "no need to pass", or "no need to, and it will be detrimental to, pass"?

IOW, if we are relying on the command spawned via start_command()
interface to read and honor the configured default for themselves,
then passing explicit --track=whatever from this caller will be not
just necessary but is wrong, right?  I am worried about "No need to"
tempting "helpful" developers into doing unnecessary things, just to
be more explicit, for example. 

> @@ -614,7 +636,8 @@ void create_branches_recursively(struct repository *r, const char *name,
>  	 * tedious to determine whether or not tracking was set up in the
>  	 * superproject.
>  	 */
> -	setup_tracking(name, tracking_name, track, quiet);
> +	if (track)
> +		setup_tracking(name, tracking_name, track, quiet);

Here we do rely on the fact that NEVER has the value of 0.  If there
are other instances of code elsewhere that does so, then this one
and the other one at the top of this message are both fine.

Given that we started simple and then gradually added more features,
I would not be surprised if the older code written back when there
were only 0 (no track) and 1 (track) assumed 0 means no.  There is
one in create_branch() where we do

	if (real_ref && track)
		setup_tracking(ref.buf + 11, real_ref, track, quiet);

which also relies on the fact that NEVER is 0.

> -		OPT_SET_INT('t', "track", &track,
> -			    N_("set up tracking mode (see git-pull(1))"),
> -			    BRANCH_TRACK_EXPLICIT),
> +		OPT_CALLBACK_F('t', "track",  &track, "(direct|inherit)",
> +			N_("set branch tracking configuration"),
> +			PARSE_OPT_OPTARG,
> +			parse_opt_tracking_mode),

Hmph, this is quite curious.  How did the whole thing even worked
without this?

Ah, OK, this is in submodule--helper.c and tracking specification in
the top-level were OK.  Just that we forgot to correctly pass it
down when calling down to submodules.  Makes sense.

Thanks.

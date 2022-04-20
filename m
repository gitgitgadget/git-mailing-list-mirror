Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D17C433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 22:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353833AbiDTWSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 18:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351515AbiDTWSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 18:18:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3923CA75
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 15:15:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D7B3132CC5;
        Wed, 20 Apr 2022 18:15:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wU82D9BoWT2L8kENXLPt3Dw0QeynQIbyBwzJwe
        Oj/cU=; b=bvrtw7HDkNYTCT0CFqUvxmz86VjRuNAElfInaNJDIPk/ctn0/xZOWL
        BUe2oWT+D3nM/mEJ7XYB9tgVT8HKMTuS2Ma+S6BrRcmIpPWCSKgKi53CHX3IwVOW
        KNKstYh9tLnsUk/VsBbqri39/oLPtTI4wgeraZMC/nYljF1HE5sNs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74DD6132CC3;
        Wed, 20 Apr 2022 18:15:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFD6A132CC2;
        Wed, 20 Apr 2022 18:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 6/8] rebase --apply: make reflog messages match
 rebase --merge
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <95161f21e0004cff1bb0915aa39200b286e592e5.1650448612.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 15:15:51 -0700
In-Reply-To: <95161f21e0004cff1bb0915aa39200b286e592e5.1650448612.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 20 Apr 2022 09:56:49
        +0000")
Message-ID: <xmqq4k2nmmeg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 711B73D6-C0F7-11EC-83F2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The apply backend creates slightly different reflog messages to the
> merge backend when starting and finishing a rebase and when picking
> commits. The choice of backend is really an implementation detail so
> it is confusing to have the same command create different messages
> depending on which backend is selected. Change the apply backend so
> the reflog messages from the two backends match as closely as
> possible.

I do not agree with that line of thought.

When choosing backend, the user clearly cares which one is used to
do the job, so it is far from an "implementation detail" that is
better hidden from the users.  In other words, the message being
different is not source of confusion in this case.  Producing
different messages depending on the version of Git may create worse
confusion, though.

> Note that there is still a difference when committing a
> conflict resolution - the merge backend will use "(continue)" rather
> than "(pick)" in that case as it does not know which command created
> the conflict that it is committing.

That is OK, unless we can teach the backend to produce a more proper
one (if 'continue' is considered less proper, that is, than 'pick';
I do not think I would personally care between the two words too
much).

> -	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
> +	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> -	strbuf_addf(&head_reflog, "%s finished: returning to %s",
> +	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
>  	ropts.branch = opts->head_name;
>  	ropts.flags = RESET_HEAD_REFS_ONLY;

These convey the same information so it is "Meh---I do not care too
strongly about them" kind of change, unless the justification is
"let's show the (word) in parehtheses consistently in these reflog
entries", in which case they are welcome change.

Overall, I'd rather see us not to apply this patch at this point in
time, especially ...

> +	strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",

... this new use of .env_array member semantically conflicts with
the removal of .env member from the structure being proposed in
another topic in flight.

> +		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
>  	if (opts->action && !strcmp("continue", opts->action)) {
>  		strvec_push(&am.args, "--resolved");
>  		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1763,7 +1764,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		printf(_("First, rewinding head to replay your work on top of "
>  			 "it...\n"));
>  
> -	strbuf_addf(&msg, "%s: checkout %s",
> +	strbuf_addf(&msg, "%s (start): checkout %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);

I think this one is a strict improvement with or without () around
the word that tells us what phase of the rebase operation we are at,
and if it happens to match what the other backend produces, that
would be a tolerable small regression, even though it makes it hard
to tell them apart.

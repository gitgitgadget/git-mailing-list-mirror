Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E6C48BDF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 01:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B162161375
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 01:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFKBnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:43:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64873 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFKBnK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 21:43:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DE35CAB1E;
        Thu, 10 Jun 2021 21:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xw7BRRpUwQMXrCSr6pDROp3C8i7x5CkgQMj9UY
        nPUKQ=; b=XAThbgCv1zqVLTnUnnZJHv8UHlXZFT5zejCqADkLSjQa5W5ZxJLvUM
        qWuMe6mtstL3RrV31q3RTv2u2t7Q44D10dv/h4zDGsg20IXOwxGMQjtw9ahVubMH
        /rmnSI5TnjtnsD/tFPJDSXhDqeDwM+NAest9BXSDrZj10kl53EUN0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15C72CAB1D;
        Thu, 10 Jun 2021 21:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97659CAB1C;
        Thu, 10 Jun 2021 21:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] remote: initialize values that might not be set
References: <pull.974.git.1623069570553.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2106072355110.55@tvgsbejvaqbjf.bet>
        <xmqqlf7ltg4q.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2106101046470.57@tvgsbejvaqbjf.bet>
Date:   Fri, 11 Jun 2021 10:41:11 +0900
In-Reply-To: <nycvar.QRO.7.76.6.2106101046470.57@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 10 Jun 2021 11:24:52 +0200 (CEST)")
Message-ID: <xmqqeed95gaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A8CC4CC-CA56-11EB-B096-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You will notice that there are two Trace2 calls in that conditional `abf
> == AHEAD_BEHIND_FULL` block.

Yes, the calls use ours/theirs uninitialized.  Is it sensible to
show 0 there, or "(unset)" or its moral equivalent (e.g. "-1")?  Not
showing them indeed is an option, which is what you did below, and
that I find sensible, too.

> Now, what I failed to realize when reviewing this code (and I _bet_ Stolee
> was in the same boat when they contributed the patch) is that this version
> of `format_tracking_info()` is different from what is in v2.32.0. It is
> the version we have in the `microsoft/git` fork, and it has not yet made
> it upstream. To be precise, it is this commit:
> https://github.com/microsoft/git/commit/91209e591b0398c8334a78001a245807f7eb348a
>
> In light of this, it might make more sense for us to fixup! this commit
> thusly:
>
> -- snip --
> diff --git a/remote.c b/remote.c
> index caed9cbc31b1..cfb7b6bd8d30 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2110,7 +2110,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
>  	trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_flags", abf);
>  	trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_result", sti);
> -	if (abf == AHEAD_BEHIND_FULL) {
> +	if (sti >= 0 && abf == AHEAD_BEHIND_FULL) {
>  	    trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_ahead", ours);
>  	    trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_behind", theirs);
>  	}

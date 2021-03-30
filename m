Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A2FC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996D0601FC
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhC3SsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:48:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53933 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhC3Srq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 14:47:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A1BFBFEB0;
        Tue, 30 Mar 2021 14:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=upi95MA0Z3XZvNI33EcSsdoMoTc=; b=Uy1SPk
        pLyOWz4C20CmN5FUMAFbAQS0uHDpg2ApjafxyJK3NvsgWBVyx4vMCknbuDxRD3x8
        h/60qDNpwFTrzRfM1mZcYweIuUgWfBRFaQbQEKb3sN+xRea+TmU2WJlQqcmAa/sN
        EMI+GGSsXjRUE+BT5UO4nZjoBu1esQpLj04Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PIlqgIQHXg1ZedXl4N0PRPmSu1Qcoycr
        XUTjwQb0hCVkA+93fk+R0fV/jQ0sKrb6rJW/D4TcaSQxXhAi4/7w+wjpPeNZgsgf
        N0WQpGt5D5VPisHsQB/yMcExfqJ8SRnXUIJkpqmnPntIpCruOfW6mCWGHUyIcDjl
        Qq5/RK6t2dg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42A20BFEAF;
        Tue, 30 Mar 2021 14:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4696BFEAE;
        Tue, 30 Mar 2021 14:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and
 revert messages
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
        <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
Date:   Tue, 30 Mar 2021 11:47:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 30 Mar 2021 12:13:33 +0200 (CEST)")
Message-ID: <xmqq7dloeawf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A3398C2-9188-11EB-83FB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> @@ -182,7 +182,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>>  				"--signoff", opts->signoff,
>>  				"--no-commit", opts->no_commit,
>>  				"-x", opts->record_origin,
>> -				"--edit", opts->edit,
>> +				"--edit", opts->edit == 1,
>
> Honestly, I'd prefer `> 0` here.

Unless somebody (including Elijah) is trying to soon introduce yet
another value to .edit member, I'd agree 100%.  If it is a tristate
(unspecified, no, yes), I think "is it positive" should be the way
to ask "does the user definitely wants it?", "is it zero" should be
the way to ask "does the user definitely declines it?" and "is it
non-negative" (and "is it negative") the way to ask "does the user
care (or not care)?".  Using that consistently is good.

>> +static int should_edit(struct replay_opts *opts) {
>> +	assert(opts->edit >= -1 && opts->edit <= 1);
>
> Do we really want to introduce more of these useless `assert()`s? I know
> that we stopped converting them to `BUG()`, but I really dislike
> introducing new ones: they have very little effect, being no-ops by
> default in most setups.

Yeah, in a new code in flux where programmers can easily make
errors, "if (...) BUG()" may not be a bad thing to add (but then we
may want to see if we can make the codepaths involved less error
prone), but I agree with your view that assert() is mostly useless.
A comment that explains the expectation and why that expectation is
there would be more useful.


>> +	if (opts->edit == -1)
>
> Maybe `< 0`, as we do elsewhere for "not specified"?

Yup.

>> +		/*
>> +		 * Note that we only handle the case of non-conflicted
>> +		 * commits; continue_single_pick() handles the conflicted
>> +		 * commits itself instead of calling this function.
>> +		 */
>> +		return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
>
> Apart from the extra parentheses, that makes sense to me.

I can take it either way (but personally I think this particular one
is easier to see as written---this is subjective).

> ...
> The rest looks good, and the comments are _really_ helpful.

Yup, I agree.

Thanks for a review.

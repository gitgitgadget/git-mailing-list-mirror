Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51853C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4D64F7E
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBCRHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:07:50 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:44719 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhBCRHs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:07:48 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4DW7QH5NbQz5tlB;
        Wed,  3 Feb 2021 18:07:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 53E6B20F3;
        Wed,  3 Feb 2021 18:07:02 +0100 (CET)
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
 <87czxjomn8.fsf@evledraar.gmail.com>
 <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
 <87wnvrefbv.fsf@evledraar.gmail.com>
 <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
 <87tuqvdy1b.fsf@evledraar.gmail.com>
 <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
 <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
 <1dfb079e-a472-0259-2a00-100eb7a06297@kdbg.org>
 <xmqq35yegrcv.fsf@gitster.c.googlers.com>
 <12a440af-c080-089d-bf60-76262d5aec7a@kdbg.org>
 <xmqqwnvqdsax.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <aa672f2b-6886-a2bf-5129-f10f4e488961@kdbg.org>
Date:   Wed, 3 Feb 2021 18:07:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnvqdsax.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.21 um 23:21 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> Anyway, my opinion in the message you are responding to was that the
>>> exit status of the pager subprocess wait_for_pager_atexit() finds
>>> does not matter, and there is no reason to overly complicate the
>>> implementation like the comments in Ævar's [v2 5/5] implies, and it
>>> is sufficient to just hide the fact in wait_for_pager_signal() that
>>> we got SIGPIPE.  I am not sure if you are agreeing with me, or are
>>> showing me where/why I was wrong.
>>
>> We are agreeing that the SIGPIPE should not be reported.
>>
>> We may be disagreeing whether it is good or bad that git's exit code is
>> overridden by the pager's exit code, which Ævar wanted to implement,
>> IIUC. I think that is reasonable and I base my opinion on the comparison
>> with the pipeline `git log | less`, where git's exit code is ignored.
> 
> I guess we are then in agreement---I do think it makes sense to send
> the true exit code from the pager as the exit code from the pager to
> the trace output, which is what the early part of Ævar's patch does,
> but I do not think the exit code of the pager should affect the exit
> code from "git log" as a whole.

Then we do not agree. The exit code of `git log | less` is ignored, and
I regard `git -p log` just as a short-hand for that.

That said, I don't care a lot about the exit code. When a pager is in
the game, we are talking about an interactive command invocation, and
what the exit code of that is, is irrelevant in practice.

The only thing I care is that git does not die due to a SIGPIPE when the
pager is closed early.

-- Hannes

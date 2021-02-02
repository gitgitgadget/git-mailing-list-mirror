Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA656C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851EC64EE8
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 07:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBBHqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 02:46:38 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:43342 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhBBHqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 02:46:37 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4DVH1F102fz5tl9;
        Tue,  2 Feb 2021 08:45:53 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C02104B94;
        Tue,  2 Feb 2021 08:45:51 +0100 (CET)
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
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
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1dfb079e-a472-0259-2a00-100eb7a06297@kdbg.org>
Date:   Tue, 2 Feb 2021 08:45:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.21 um 06:25 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Sorry, but you still have lost me---I do not see if/why we even care
>> about atexit codepath.  As far as the end users are concered, they
>> are running "git" and observing the exit code from "git".  There,
>> reporting that "git" was killed by SIGPIPE, instead of exiting
>> normally, is not something they want to hear about after quitting
>> their pager, and that is why the signal reception codepath matters.
> 
> (something I noticed that I left unsaid...)
> 
> On the other hand, "git" spawns not just pager but other
> subprocesses (e.g. "hooks"), and it is entirely up to us what to do
> with the exit code from them.  When we care about making an external
> effect (e.g. post-$action hooks that are run for their side effects),
> we can ignore their exit status just fine.
> 
> And I do not see why the "we waited before leaving, and noticed the
> pager exited with non-zero status" that we could notice in the
> atexit codepath has to be so special.  We _could_ (modulo the "exit
> there is not portable" you noted) make our exit status reflect that,
> but I do not think it is all that important a "failure" (as opposed
> to, say, we tried to show a commit message but failed to recode it
> into utf-8, or we tried to spawn the pager but failed to start a
> process) to clobber _our_ exit status with pager's exit status.
> 
> So...

The pager is a special case of a sub-process spawned, as it really only
a courtesy for the user. Without the pager facility, the user would have
to use

    git log | less

In that situation, the exit code of the pager *does* override git's, and
it is also irrelevant for the user that git was killed by SIGPIPE and is
not worth a visible notice.

-- Hannes

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B317C43381
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A0964E3F
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 16:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhBDQVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhBDPLl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 10:11:41 -0500
Received: from joooj.vinc17.net (joooj.vinc17.net [IPv6:2001:4b99:1:3:216:3eff:fe20:ac98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A07C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 07:11:00 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id EDA7B4CE;
        Thu,  4 Feb 2021 16:10:57 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id B5630C20303; Thu,  4 Feb 2021 16:10:56 +0100 (CET)
Date:   Thu, 4 Feb 2021 16:10:56 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
Message-ID: <20210204151056.GH148009@zira.vinc17.org>
References: <87wnvrefbv.fsf@evledraar.gmail.com>
 <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
 <87tuqvdy1b.fsf@evledraar.gmail.com>
 <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
 <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
 <1dfb079e-a472-0259-2a00-100eb7a06297@kdbg.org>
 <xmqq35yegrcv.fsf@gitster.c.googlers.com>
 <12a440af-c080-089d-bf60-76262d5aec7a@kdbg.org>
 <xmqqwnvqdsax.fsf@gitster.c.googlers.com>
 <aa672f2b-6886-a2bf-5129-f10f4e488961@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa672f2b-6886-a2bf-5129-f10f4e488961@kdbg.org>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-03 18:07:02 +0100, Johannes Sixt wrote:
> Then we do not agree. The exit code of `git log | less` is ignored,
> and I regard `git -p log` just as a short-hand for that.

If git didn't have the -p feature, "git log | less" would just be
one way to get a pager. For instance, I use an alias that does

  pager-wrapper grep --color=always --line-buffered -E

which sends the grep output to a pager, and returns the exit status
of the pager if non-zero, otherwise the exit status of grep, except
when this is SIGPIPE. An unavoidable issue is that if there has been
an error in grep, I could still get the exit status 0. But as a user,
this is a choice I have done by quitting the pager before letting
grep terminate in the normal way (which could have been costly) so
that it could report the error, say, about unreadable files with a
recursive grep (grep -r).

So Git could do the same thing, and even better, because it controls
its own exit status: if there has been an error in the generation of
the Git output (for instance, I can see that there is a --check option
of "git log" that can trigger an error), then this error should be
reported (with a non-zero exit status) after the pager is quit, as if
a pager were not used. Otherwise, terminate with the exit status of
the pager.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)

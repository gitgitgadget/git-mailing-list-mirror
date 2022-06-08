Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD06AC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 19:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiFHTRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiFHTRm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 15:17:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8BD6E8E8
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 12:17:40 -0700 (PDT)
Received: (qmail 4756 invoked by uid 109); 8 Jun 2022 19:17:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jun 2022 19:17:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Wed, 8 Jun 2022 15:17:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
Message-ID: <YqD100DRVJoZCC+x@coredump.intra.peff.net>
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
 <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
 <xmqqv8theehf.fsf@gitster.g>
 <xmqqczfpe9ua.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczfpe9ua.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 03, 2022 at 02:05:49PM -0700, Junio C Hamano wrote:

> > Are we sure that the reason no longer applies?  How do we know?  We
> > would want to explain that to future developers in the proposed log
> > message, I would think.
> 
> We can flip it the other way around.  
> 
> I do not think I ever saw anybody asked anybody on this list who got
> a BUG() message to use the coredump to do something useful.  Don't
> modern distros ship with "ulimit -c 0" these days?

Certainly I have found the coredumps useful, though I would expect most
Git developers to be able to run under a debugger and stop at BUG()
anyway. So we could probably live without that, but...

> It might be possible that a better direction is to introduce
> GIT_ABORT_ON_BUG environment or core.abortOnBUG configuration that
> chooses between abort() and exit(99), or something like that, and
> then we switch to use the latter by default over time?

It really should continue to die with a signal (or an exit code that
pretends to be one) to continue triggering even under test_must_fail().

IMHO the whole "let's trigger BUG() intentionally via test-tool" stuff
in t1406 is misguided. It's literally introducing broken code that is
not run in the normal Git binary in order to make sure that it's broken.
If that were the only spot, I'd suggest just getting rid of it entirely.
But the code in t0210 that checks the handling of trace2 and BUG() is
probably worth keeping.

I do agree that an environment variable would be a better selector than
"this code is linked against test-tool". I thought so even back in:

  https://lore.kernel.org/git/20180507090109.GA367@sigill.intra.peff.net/

:) That message also covers the flip-side case discussed earlier in this
thread: why calling abort() unconditionally in the test suite can be a
pain.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D9320970
	for <e@80x24.org>; Wed, 12 Apr 2017 00:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbdDLAuQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 20:50:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:60476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbdDLAuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 20:50:16 -0400
Received: (qmail 24733 invoked by uid 109); 12 Apr 2017 00:50:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 00:50:14 +0000
Received: (qmail 9540 invoked by uid 111); 12 Apr 2017 00:50:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 20:50:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 20:50:11 -0400
Date:   Tue, 11 Apr 2017 20:50:11 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
Message-ID: <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net>
References: <20170410125911.6800-1-szeder.dev@gmail.com>
 <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
 <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
 <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net>
 <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net>
 <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 02:27:05AM +0200, SZEDER Gábor wrote:

> >> I wonder if you could make it a general test-lib function, like:
> >>
> >>   run_and_wait () {
> >>         # we read stdout from the child only for the side effect
> >>         # of waiting until all child sub-processes exit, closing their
> >>         # fd 9.
> >>         does_not_matter=$("$@" 9>&1)
> >
> >
> > I'm afraid this won't work on Windows when the invoked command is git. FD
> > inheritance between MSYS (bash) and non-MSYS programs (git) is only
> > implemented for FDs 0,1,2. That's a deficiency of MSYS, and I don't think
> > that was improved in MSYS2.
> 
> Oh, that's a pity, I was almost ready with v2...
> 
> Unfortunately, this makes the general helper function unworkable, of
> course.  Though in this particular case it wouldn't matter, because on
> Windows daemonize() is basically a noop and 'git gc --auto' remains in
> the foreground anyway.

That makes it tempting to use in this scenario as a one-off with a
comment.

> I think we should stick with my initial patch, then.

I'm not entirely opposed, but my understanding was that it didn't
actually fix the race, it just made it a bit bigger. Which is sort of
unsatisfying.

I couldn't get the original to show a failure, though, even under heavy
load. So maybe widening the race is enough.

-Peff

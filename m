Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697D6208E3
	for <e@80x24.org>; Thu, 31 Aug 2017 04:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdHaEJL (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 00:09:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750882AbdHaEJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 00:09:10 -0400
Received: (qmail 11474 invoked by uid 109); 31 Aug 2017 04:09:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Aug 2017 04:09:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25836 invoked by uid 111); 31 Aug 2017 04:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Aug 2017 00:09:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Aug 2017 00:09:07 -0400
Date:   Thu, 31 Aug 2017 00:09:07 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170831040907.a4qpydb3w2aghatm@sigill.intra.peff.net>
References: <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <3e632fd3-7db9-4c38-c524-b56a06cfaa87@alum.mit.edu>
 <20170830195320.27w5mhnrcd2uosvz@sigill.intra.peff.net>
 <20170830195731.GB50018@google.com>
 <20170830201132.kmtp5mfu6qotn5s7@sigill.intra.peff.net>
 <20170830210602.GC50018@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830210602.GC50018@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 02:06:02PM -0700, Brandon Williams wrote:

> > We could extend that protection by having sigchain_push_common() set
> > sa_mask to cover all of the related signals. On Linux and BSD the
> > current code using signal() also implies SA_RESTART. We could add that
> > to our flags, though I suspect in practice it doesn't matter. Whenever
> > we establish a handler like this our intent is to never return from it.
> > 
> > That just protects us from calling the _same_ handler from itself. But
> > that's probably enough in practice, and means handlers don't have to
> > worry about "critical sections". The other alternative is sigprocmask()
> > to block signals entirely during a section. I'm not sure if there are
> > portability questions there (it looks like we have a mingw wrapper
> > there, but it's a complete noop).
> 
> Yeah there's a lot about signals that I'm not very clear on.  I do know
> that Eric helped me out on the fork-exec series I worked on earlier in
> the year and I believe it was to turn on/off signals during process
> launches in 45afb1ca9 (run-command: block signals between fork and
> execve, 2017-04-19).  Though that bit of code is strictly for unix so I
> wouldn't know how that would work on windows machines.  Portability does
> seem to always be a challenging problem.

Based on the sketch I wrote above, I figured it would be pretty easy to
convert sigchain to sigaction. But after taking a look at
compat/mingw.c, I don't think Windows would be on board. sigaction()
there is is a stub implementation that _only_ handles SIGALRM and
nothing else.

So I think the best we could do is put big #ifdefs around it to use
sigaction on other platforms, and fall back to signal() on Windows.
That's do-able, but my enthusiasm is waning as the complexity increases.
Getting two SIGINTs in a row seems plausible, but we already handle that
well. Getting SIGINT and then a _different_ signal while we're in the
handler seems less likely in practice. The only combination I can think
that would be common is TERM+KILL, but of course we're not catching KILL
in the first place.

So this seems like adding complexity for very little benefit.

-Peff

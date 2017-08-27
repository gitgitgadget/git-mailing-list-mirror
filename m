Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1023D20285
	for <e@80x24.org>; Sun, 27 Aug 2017 19:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdH0TPL (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 15:15:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:50478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751264AbdH0TPL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 15:15:11 -0400
Received: (qmail 28803 invoked by uid 109); 27 Aug 2017 19:15:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 19:15:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29080 invoked by uid 111); 27 Aug 2017 19:15:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 15:15:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Aug 2017 15:15:09 -0400
Date:   Sun, 27 Aug 2017 15:15:09 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170827191508.bkydifqihq3ke3rw@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 09:09:15PM +0200, Martin Ågren wrote:

> On 27 August 2017 at 20:21, Lars Schneider <larsxschneider@gmail.com> wrote:
> >
> >> On 27 Aug 2017, at 09:37, Martin Ågren <martin.agren@gmail.com> wrote:
> >>
> >> The static-ness was silently dropped in commit 70428d1a5 ("pkt-line: add
> >> packet_write_fmt_gently()", 2016-10-16). As a result, for each call to
> >> packet_write_fmt_1, we allocate and leak a buffer.
> >
> > Oh :-( Thanks for detecting and fixing the leak.
> >
> > How did you actually find it? Reading the code or did you use some
> > tool?
> 
> Valgrind found it for me. Most leaks it reports are "ok" since we're
> about to exit, it just takes more or less effort to realize that...

This is one more thing it would be nice to have as part of our
perf-testing framework. It will run two versions of Git across a battery
of tests and report on the runtime differences for each. It would be
great if it did the same for peak heap. The tricky thing is that you
sometimes need repositories that are exaggerated in size in one
dimension to notice the differences as significant. So I don't know if
we would need new tests for this, or if existing "this repo has a lot of
refs" tests would have caught this.

Another approach, of course, is to get valgrind (or asan) to a
zero-leaks-reported steady state, and then even small leak reports would
be worth investigating. I'm not sure how easy it is to get there, and
whether it's less work to actually plug free-on-exit leaks or somehow
suppress the reports. I think most free-on-exit false positives would
show up as "leaked but still reachable", whereas leaks like this that
can grow without bound mean would not be reachable (we throw away the
pointer to the memory at the end of the function).

-Peff

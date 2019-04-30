Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD691F453
	for <e@80x24.org>; Tue, 30 Apr 2019 17:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3Ruu (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 13:50:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:44796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725930AbfD3Ruu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 13:50:50 -0400
Received: (qmail 25413 invoked by uid 109); 30 Apr 2019 17:50:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Apr 2019 17:50:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10907 invoked by uid 111); 30 Apr 2019 17:51:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 13:51:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 13:50:48 -0400
Date:   Tue, 30 Apr 2019 13:50:48 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190430175048.GB16729@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
 <19221376.OlD5LWjr85@mfick-lnx>
 <20190423015538.GA16369@sigill.intra.peff.net>
 <20190423042109.GA19183@sigill.intra.peff.net>
 <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 05:08:40PM +0700, Duy Nguyen wrote:

> On Tue, Apr 23, 2019 at 11:45 AM Jeff King <peff@peff.net> wrote:
> >
> > On Mon, Apr 22, 2019 at 09:55:38PM -0400, Jeff King wrote:
> >
> > > Here are my p5302 numbers on linux.git, by the way.
> > >
> > >   Test                                           jk/p5302-repeat-fix
> > >   ------------------------------------------------------------------
> > >   5302.2: index-pack 0 threads                   307.04(303.74+3.30)
> > >   5302.3: index-pack 1 thread                    309.74(306.13+3.56)
> > >   5302.4: index-pack 2 threads                   177.89(313.73+3.60)
> > >   5302.5: index-pack 4 threads                   117.14(344.07+4.29)
> > >   5302.6: index-pack 8 threads                   112.40(607.12+5.80)
> > >   5302.7: index-pack default number of threads   135.00(322.03+3.74)
> > >
> > > which still imply that "4" is a win over "3" ("8" is slightly better
> > > still in wall-clock time, but the total CPU rises dramatically; that's
> > > probably because this is a quad-core with hyperthreading, so by that
> > > point we're just throttling down the CPUs).
> >
> > And here's a similar test run on a 20-core Xeon w/ hyperthreading (I
> > tweaked the test to keep going after eight threads):
> >
> > Test                            HEAD
> > ----------------------------------------------------
> > 5302.2: index-pack 1 threads    376.88(364.50+11.52)
> > 5302.3: index-pack 2 threads    228.13(371.21+17.86)
> > 5302.4: index-pack 4 threads    151.41(387.06+21.12)
> > 5302.5: index-pack 8 threads    113.68(413.40+25.80)
> > 5302.6: index-pack 16 threads   100.60(511.85+37.53)
> > 5302.7: index-pack 32 threads   94.43(623.82+45.70)
> > 5302.8: index-pack 40 threads   93.64(702.88+47.61)
> >
> > I don't think any of this is _particularly_ relevant to your case, but
> > it really seems to me that the default of capping at 3 threads is too
> > low.
> 
> Looking back at the multithread commit, I think the trend was the same
> and I capped it because the gain was not proportional to the number of
> cores we threw at index-pack anymore. I would not be opposed to
> raising the cap though (or maybe just remove it)

I'm not sure what the right cap would be. I don't think it's static;
we'd want ~4 threads on the top case, and 10-20 on the bottom one.

It does seem like there's an inflection point in the graph at N/2
threads. But then maybe that's just because these are hyper-threaded
machines, so "N/2" is the actual number of physical cores, and the
inflated CPU times above that are just because we can't turbo-boost
then, so we're actually clocking slower. Multi-threaded profiling and
measurement is such a mess. :)

So I'd say the right answer is probably either online_cpus() or half
that. The latter would be more appropriate for the machines I have, but
I'd worry that it would leave performance on the table for non-intel
machines.

-Peff

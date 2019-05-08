Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10A91F45F
	for <e@80x24.org>; Wed,  8 May 2019 07:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEHHLK (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 03:11:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:51340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725884AbfEHHLH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 03:11:07 -0400
Received: (qmail 668 invoked by uid 109); 8 May 2019 07:11:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 May 2019 07:11:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20932 invoked by uid 111); 8 May 2019 07:11:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 May 2019 03:11:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 May 2019 03:11:05 -0400
Date:   Wed, 8 May 2019 03:11:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190508071105.GA14043@sigill.intra.peff.net>
References: <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
 <20190504013713.GC17551@sigill.intra.peff.net>
 <87a7g2iuem.fsf@evledraar.gmail.com>
 <20190507074506.GF28060@sigill.intra.peff.net>
 <8736lqisyx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736lqisyx.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 10:12:06AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I think we'd want a way to tell the bitmap code to update our progress
> > meter as it traverses (both single objects, but also taking into account
> > when it finds a bitmap and then suddenly bumps the value by a large
> > amount).
> 
> Not splitting it will fix the progress bar stalling, so it fixes the
> problem that the user is wondering if the command is entirely hanging.
> 
> But I was hoping to give the user an idea of roughly where we're
> spending our time, e.g. so you can see how much the pack.useSparse
> setting is helping (or not).

Yeah, I think that's a bigger and more complicated problem. I admit that
my main annoyance is just the stall while we fill in the bitmaps (and
it's easy because the bitmap traversal is the same unit of work as a
regular traversal).

> So something where we report sub-progress as we go along, and perhaps
> print some brief summary at the end if it took long enough, e.g.:
> 
>     Enumerating Objects (X^1%) => Marking trees (Y^1%)
>     Enumerating Objects (X^2%) => Calculating bitmaps (Y^2%)
> 
> And at the end:
> 
>     Enumerating Objects (100%) in ~2m30s -- (~10s marking trees, ~2m10s bitmaps, ~10s other)
> 
> I.e. bringing the whole "nested" trace2 regions full circle with the
> progress bar where we could elect to trace/show some of that info, and
> then you could turn on some trace2 mode/verbose progress to see more.

I do wonder if this really needs to be part of the progress bar. The
goal of the progress bar is to give the user a sense that work is
happening, and (if possible, but not for "enumerating") an idea of when
it might finish. If the trace code can already do detailed timings, then
shouldn't we just be encouraging people to use that?

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD931F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeCaKRx (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:17:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:49910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753075AbeCaKRx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:17:53 -0400
Received: (qmail 7367 invoked by uid 109); 31 Mar 2018 10:17:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 31 Mar 2018 10:17:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3703 invoked by uid 111); 31 Mar 2018 10:18:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 31 Mar 2018 06:18:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Mar 2018 06:17:51 -0400
Date:   Sat, 31 Mar 2018 06:17:51 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 08/13] pack-objects: shrink z_delta_size field in
 struct object_entry
Message-ID: <20180331101750.GB32290@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-9-pclouds@gmail.com>
 <20180330205905.GG14782@sigill.intra.peff.net>
 <CACsJy8DFpqa5DYmNpBpeWOW1a3UH64AHa2vG3nkJVLoMR73wqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DFpqa5DYmNpBpeWOW1a3UH64AHa2vG3nkJVLoMR73wqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 06:40:23AM +0200, Duy Nguyen wrote:

> > Unlike the depth, I don't think there's any _inherent_ reason you
> > couldn't throw, say, 1MB deltas into the cache (if you sized it large
> > enough). But I doubt such deltas are really all that common. Here are
> > the top 10 in linux.git:
> >
> >   $ git cat-file --batch-all-objects --batch-check='%(deltabase) %(objectsize:disk)' |
> >     grep -v ^00000 | sort -k 2nr | head
> >   a02b6794337286bc12c907c33d5d75537c240bd0 769103
> >   b28d4b64c05da02c5e8c684dcb9422876225ebdc 327116
> >   1e98ce86ed19aff9ba721d13a749ff08088c9922 325257
> >   a02b6794337286bc12c907c33d5d75537c240bd0 240647
> >   c550d99286c01867dfb26e432417f3106acf8611 177896
> >   5977795854f852c2b95dd023fd03cace023ee41c 119737
> >   4ccf9681c45d01d17376f7e0d266532a4460f5f8 112671
> >   b39fb6821faa9e7bc36de738152a2817b4bf3654 112657
> >   2645d6239b74bebd661436762e819b831095b084 103980
> >   b8ce7fe5d8def58dc63b7ae099eff7bd07e4e845 101014
> >
> > It's possible some weird workload would want to tweak this. Say you were
> > storing a ton of delta-capable files that were big and always differed
> > by a megabyte. And it was somehow really important to you to tradeoff
> > memory for CPU during the write phase of a pack.
> 
> We're not short on spare bits so I will try to raise this limit to 1MB
> (not because you mentioned 1MB, but because the largest size in your
> output is close to 1MB).

I doubt it matters much. Unless somebody has been tweaking the config
themselves, this has been limited to 1000 for everybody running
linux.git and nobody has ever noticed.

So I think it would only be an issue if:

  1. you had an oddball repo with gigantic deltas

AND

  2. you for some reason really cared about caching the deltas between
     phases

AND

  3. you had done enough homework to even figure out that this knob
     existed

I was thinking that you might care about (2) for serving fetches of your
oddball repository. But really, if you care about minimizing work, you
want to be reusing on-disk deltas anyway, which would skip this cache
entirely. So any work we do to reproduce the delta would probably be
dwarfed by the finding of this giant delta in the first place.

So raise the limit if you want, but I'd be surprised if anybody was even
doing (3) in the first place.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5824A1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 21:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeHQAHk (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 20:07:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:58094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725856AbeHQAHj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 20:07:39 -0400
Received: (qmail 18201 invoked by uid 109); 16 Aug 2018 21:06:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 21:06:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19410 invoked by uid 111); 16 Aug 2018 21:07:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 17:07:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 17:06:57 -0400
Date:   Thu, 16 Aug 2018 17:06:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180816210657.GA9291@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
 <20180816205556.GA8257@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180816205556.GA8257@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 04:55:56PM -0400, Jeff King wrote:

> >  * We spend the majority of the ~30s on this:
> >    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L70-L79
> 
> This is hashing the actual packfile. This is potentially quite long,
> especially if you have a ton of big objects.
> 
> I wonder if we need to do this as a separate step anyway, though. Our
> verification is based on index-pack these days, which means it's going
> to walk over the whole content as part of the "Indexing objects" step to
> expand base objects and mark deltas for later. Could we feed this hash
> as part of that walk over the data? It's not going to save us 30s, but
> it's likely to be more efficient. And it would fold the effort naturally
> into the existing progress meter.

Actually, I take it back. That's the nice, modern way we do it in
git-verify-pack. But git-fsck uses the ancient "just walk over all of
the idx entries method". It at least sorts in pack order, which is good,
but:

  - it's not multi-threaded, like index-pack/verify-pack

  - the index-pack way is actually more efficient than pack-ordering for
    the delta-base cache, because it actually walks the delta-graph in
    the optimal order

Once upon a time verify-pack used this same pack-check code, and we
switched in 3de89c9d42 (verify-pack: use index-pack --verify,
2011-06-03). So I suspect the right thing to do here is for fsck to
switch to that, too, and then delete pack-check.c entirely.

That may well involve us switching the progress to a per-pack view
(e.g., "checking pack 1/10 (10%)", followed by its own progress meter).
But I don't think that would be a bad thing. It's a more realistic view
of the work we're actually doing. Although perhaps it's misleading about
the total work remaining, because not all packs are the same size (so
you see that you're halfway through pack 2/10, but that's quite likely
to be half of the total work if it's the one gigantic pack).

-Peff

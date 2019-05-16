Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860F21F4B6
	for <e@80x24.org>; Thu, 16 May 2019 21:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfEPVnC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 17:43:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:59942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727775AbfEPVnC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 17:43:02 -0400
Received: (qmail 1954 invoked by uid 109); 16 May 2019 21:43:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 21:43:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7551 invoked by uid 111); 16 May 2019 21:43:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 17:43:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 17:42:58 -0400
Date:   Thu, 16 May 2019 17:42:58 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190516214257.GD10787@sigill.intra.peff.net>
References: <20190516211226.GE9816@sigill.intra.peff.net>
 <20190516213056.221406-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516213056.221406-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 02:30:56PM -0700, Jonathan Tan wrote:

> > So I could go either way, though I do think it makes sense for on-demand
> > fetches for partial clones to avoid asking for thin packs as a general
> > principle.
> 
> This should not be a problem since fetch-pack can already know that
> we're doing an on-demand fetch (args->no_dependents), so we should be
> able to either plumb a "no-thin-pack" arg in the same way or rename
> args->no_dependents to also encompass the no-thin-pack option. But this
> can be done separately from this patch set, I think.

Yeah, I think it can be done separately. Though the two may intermingle
if we want to instruct index-pack that it should not try to pre-fetch if
we did not ask for a thin pack.

> > As a matter of fact, should partial clones _always_ avoid
> > asking for thin packs?  That would make this issue go away entirely.
> > 
> > Sometimes it would be more efficient (we do not have to get an extra
> > base object just to resolve the delta we needed) but sometimes worse (if
> > we did actually have the base, it's a win). Whether it's a win would
> > depend on the "hit" rate, and I suspect that is heavily dependent on
> > workload characteristics (what kind of filtering is in use, are we
> > topping up in a non-partial way, etc).
> 
> I think it's best if we still allow servers to serve thin packs. For
> example, if we're excluding only large blobs, clients would still want
> servers to be able to delta against blobs that they have.

Yes, this is getting into the hit-rate thing I mentioned. You're right
that for a reasonably typical case of "no blobs over 10MB" we'd have a
very high hit rate, and disabling thin packs would almost certainly be a
big loss.

I guess even when we have a "miss", the cost is usually not that high
either. If we get A as a delta against B, then in the non-thin-pack case
we transfer all of A. In the thin-pack case with pre-fetch we transfer
all of B, and then the delta. But the delta is often small enough
compared to the total content that it's not that big a deal either way.
There are pathological cases, of course, but that's already true. :)

So you're right, it's probably still a win to use thin packs when we
can.

> > Right, REF_DELTA is definitely correctly handled currently, and I don't
> > think that would break with your patch. It's just that your patch would
> > introduce a bunch of extra traffic as we request bases separately that
> > are already in the pack.
> 
> Ah...I see. For this problem, I think that it can be solved with the
> "if (objects[d->obj_no].real_type != OBJ_REF_DELTA)" check that the
> existing code uses before calling read_object(). I'll include this in
> the next reroll if any other issue comes up.

I'm confused about this. Aren't we pre-fetching before we've actually
resolved deltas? The base could be in the pack as a true base, and we
might have seen it already then. But it could itself be a delta, and we
wouldn't know we have it until we resolve it (this gets into the
lucky/unlucky ordering thing).

-Peff

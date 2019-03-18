Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3C320248
	for <e@80x24.org>; Mon, 18 Mar 2019 23:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCRXx6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 19:53:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:55774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726579AbfCRXx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 19:53:58 -0400
Received: (qmail 17943 invoked by uid 109); 18 Mar 2019 23:53:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 23:53:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24988 invoked by uid 111); 18 Mar 2019 23:54:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 19:54:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 19:53:56 -0400
Date:   Mon, 18 Mar 2019 19:53:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 4/4] gc docs: downplay the usefulness of --aggressive
Message-ID: <20190318235356.GK29661@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-5-avarab@gmail.com>
 <20190318202824.GA24222@gmail.com>
 <20190318212227.GD29661@sigill.intra.peff.net>
 <87k1gvespm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1gvespm.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 11:13:57PM +0100, Ævar Arnfjörð Bjarmason wrote:

> What happened here is that I'd entirely forgotten about your 07e7dbf0db
> and in skimming while writing this throught we were still picking larger
> depth values, which we aren't.
> 
> I'll fix that, and see that gc.aggressiveDepth also needs to be changed
> to note that the depth it's now using as "aggressive" is just the
> default of 50 you'd get without --aggressive.

Yeah. I think I tweaked the documentation in that commit, but I agree
it's probably worth calling out the subtlety that it's the same as the
default.

> > It is possible, if it finds more deltas due to the larger window, that
> > we'd spend more time accessing those deltas. But if the chains aren't
> > long, the base cache tends to perform well, and delta reconstruction is
> > about the same cost as zlib inflating. And we have a smaller disk cache
> > footprint.
> 
> I haven't tested that but suspect it won't matter. We do spend a *lot*
> more time though, so that still needs to be noted...

Yeah, agreed on both counts.

> On the topic of other things I may have screwed up, is this:
> 
>     +The effects of this option are persistent to the extent that
>     +`gc.autoPackLimit` and friends don't cause a consolidation of existing
>     +pack(s) generated with this option.
> 
> Actually wrong since we don't pass -f usually, and thus a one-off
> --aggressive would live forever for the objects involved in that run no
> matter if we later consolidate?
> 
> From the docs it seems so, but I'd like to confirm...

In general, yeah, I'd expect an --aggressive repack's effects to live on
through subsequent gc's. It's not _entirely_ true, because objects from
that big repack may end up duplicate in another pack (e.g., due to
thin-fixing, or just a client which sends objects we didn't need due to
push's abbreviated negotiation). And then either:

  - we may select the copy of the object from the other pack, where it's
    a base object, and then end up looking for a new delta for it

  - after the pack-mru patches from ~2016, we don't have a strict
    ordering of the packs, which means we can see cycles in the delta
    graph. So even if object A isn't duplicated, it may be a delta on B,
    which deltas on C, and then the copy of C we pick is from another
    pack where it's a delta on A. We have to break the cycle, which
    could happen on any one of A, B, or C.

I haven't done careful measurements, but I'd be surprised if those cases
make a significant dent, even over many gc's. What I think probably does
make a dent is that new objects come into the repo with whatever crappy
packing the client did as part of the push, and you'd ideally like to
throw away all of their deltas and just find new good ones.

I think it might help for pack-objects to have a mode that isn't quite
"keep the big pack", but rather "keep the deltas from the big pack, but
not other ones, but otherwise create a new big pack". But this has
diverged pretty far from the point of your series. :)

-Peff

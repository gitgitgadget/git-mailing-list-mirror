Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DFF1F461
	for <e@80x24.org>; Fri, 17 May 2019 01:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfEQBJx (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 21:09:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:60292 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725985AbfEQBJw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 21:09:52 -0400
Received: (qmail 9208 invoked by uid 109); 17 May 2019 01:09:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 01:09:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9557 invoked by uid 111); 17 May 2019 01:10:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 21:10:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 21:09:51 -0400
Date:   Thu, 16 May 2019 21:09:51 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190517010950.GA30146@sigill.intra.peff.net>
References: <20190516214257.GD10787@sigill.intra.peff.net>
 <20190516231509.253998-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516231509.253998-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 04:15:09PM -0700, Jonathan Tan wrote:

> > /*
> >  * Second pass:
> >  * - for all non-delta objects, look if it is used as a base for
> >  *   deltas;
> >  * - if used as a base, uncompress the object and apply all deltas,
> >  *   recursively checking if the resulting object is used as a base
> >  *   for some more deltas.
> >  */
> 
> I haven't seen any code that contradicts this comment. And looking at
> the code, for each non-delta object, I think that all deltas are checked
> - regardless of whether they appear before or after that non-delta
> object. (find_ref_delta() does a binary search from 0 to
> nr_ref_deltas, calculated in parse_pack_objects() which happens before
> any resolution of deltas.)
> 
> And find_unresolved_deltas_1() (called from resolve_deltas() indirectly)
> sets the real_type when it resolves a delta, as far as I can tell.
> 
> So there is more than one "resolve deltas" step - resolve_deltas() and
> then fix_unresolved_deltas(). The pre-fetching happens only during the
> latter.

OK, that is better than I realized. But I think there is still one
interesting case: what happens if a thin delta is used as the base for a
non-thin delta (even one that is OFS_DELTA)?

We cannot handle that second delta until the third pass in
fix_unresolved_deltas(), because we do not realize we have the base
until we resolve the thin delta.

Specifically, I wonder:

  - do we pre-fetch it, not realizing that we will soon have the base?
    That's not ideal, but I think is necessary if we pre-fetch (and is
    still a worst case even if we did single on-demand fetches).

  - will we ever append a presumed-thin base to the pack, only to later
    realize that we already have that object, creating a duplicate
    object in the pack? If so, do we handle this correctly when
    generating the index (I know we've had issues in the past and have
    expressly forbidden duplicates from appearing in the index; even
    having a duplicate in the pack stream itself is non-ideal, though,
    as it screws up things like on-disk size calculations).

    Because of the sorting in fix_unresolved_deltas(), I think this
    could easily be prevented if the non-thin delta is OFS_DELTA (by
    just checking for the base in our already-found list of objects
    before we call read_object_file(). But for REF_DELTA, I think we
    have no way of knowing that appending is the wrong thing (and no
    good way of backing it out afterwards).

-Peff

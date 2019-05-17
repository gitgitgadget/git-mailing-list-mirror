Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77941F461
	for <e@80x24.org>; Fri, 17 May 2019 01:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfEQBWg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 21:22:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:60324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726839AbfEQBWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 21:22:36 -0400
Received: (qmail 9620 invoked by uid 109); 17 May 2019 01:22:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 01:22:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9670 invoked by uid 111); 17 May 2019 01:23:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 21:23:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 21:22:34 -0400
Date:   Thu, 16 May 2019 21:22:34 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190517012234.GA31027@sigill.intra.peff.net>
References: <20190516214257.GD10787@sigill.intra.peff.net>
 <20190516231509.253998-1-jonathantanmy@google.com>
 <20190517010950.GA30146@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517010950.GA30146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 09:09:50PM -0400, Jeff King wrote:

>   - will we ever append a presumed-thin base to the pack, only to later
>     realize that we already have that object, creating a duplicate
>     object in the pack? If so, do we handle this correctly when
>     generating the index (I know we've had issues in the past and have
>     expressly forbidden duplicates from appearing in the index; even
>     having a duplicate in the pack stream itself is non-ideal, though,
>     as it screws up things like on-disk size calculations).
> 
>     Because of the sorting in fix_unresolved_deltas(), I think this
>     could easily be prevented if the non-thin delta is OFS_DELTA (by
>     just checking for the base in our already-found list of objects
>     before we call read_object_file(). But for REF_DELTA, I think we
>     have no way of knowing that appending is the wrong thing (and no
>     good way of backing it out afterwards).

Actually, I think even for REF_DELTA our pack-objects would never
produce such a pack, because IIRC we _always_ put bases in the pack
before their deltas. But that's a pretty subtle thing to depend on. I'm
fine with it if violating it just means things are slightly less
optimal. I'm more worried if it means that index-pack silently produces
a bogus pack.

I think to trigger it you'd have to manually assemble an evil pack as I
described (e.g., using the routines in t/lib-pack.sh). I'm going offline
for a bit, but I may have a go at it later tonight or tomorrow.

-Peff

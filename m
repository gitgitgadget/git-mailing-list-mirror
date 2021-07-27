Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5690C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE2760F91
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhG0R3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:29:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:58842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0R3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:29:50 -0400
Received: (qmail 31031 invoked by uid 109); 27 Jul 2021 17:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 17:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 856 invoked by uid 111); 27 Jul 2021 17:29:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 13:29:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 13:29:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP8zsR+W8JeCWc1Q@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 06:14:09PM -0400, Taylor Blau wrote:

> > Ah, this jogged my memory: this is a relic from when we generated MIDX
> > bitmaps in-process with the rest of the `repack` code. And when we did
> > that, we did have to call `reprepare_packed_git()` after writing the new
> > packs but before moving them into place.
> 
> Actually, I take that back. You were right from the start: the way the
> code is written we *can* end up calling both:
> 
>   - load_multi_pack_index, from write_midx_internal(), which sets up a
>     MIDX, but does not update r->objects->multi_pack_index to point at
>     it.
> 
>   - ...and prepare_multi_pack_index_one (via prepare_bitmap_git ->
>     open_bitmap -> open_midx_bitmap -> get_multi_pack_index ->
>     prepare_packed_git) which *also* creates a new MIDX, *and*
>     updates the_repository->objects->multi_pack_index to point at it.
> 
> (The latter codepath is from the check in write_midx_internal() to see
> if we already have a MIDX bitmap when the MIDX we are trying to write
> already exists on disk.)
> 
> So in this scenario, we have two copies of the same MIDX open, and the
> repository's single pack is opened in one of the MIDXs, but not both.
> One copy of the pack is pointed at via r->objects->packed_git. Then when
> we fall back to open_pack_bitmap(), we call get_all_packs(), which calls
> prepare_midx_pack(), which installs the second MIDX's copy of the same
> pack into the r->objects->packed_git, and we have a cycle.

Right, I understand how that ends up with duplicate structs for each
pack. But how do we get a cycle out of that?

> I think there are a few ways to fix this bug. The most obvious is to
> make install_packed_git() check for the existence of the pack in the
> hashmap of installed packs before (re-)installing it. But that could be
> quadratic if the hashmap has too many collisions (and the lookup tends
> towards being linear in the number of keys rather than constant).

I think it may be worth doing that anyway. You can assume the hashmap
will behave reasonably.

But it would mean that the "multi_pack_index" flag in packed_git does
not specify _which_ midx is pointing to it. At the very least, it would
need to become a ref-count (so when one midx goes away, it does not lose
its "I am part of a midx" flag).  And possibly it would need to actually
know the complete list of midx structs it's associated with (I haven't
looked at all of the uses of that flag).

That makes things sufficiently tricky that I would prefer not to
untangle it as part of this series.

> But I think that a more straightforward way would be to open the MIDX we
> use when generating the MIDX with prepare_multi_pack_index_one() instead
> of load_multi_pack_index() so that the resulting MIDX is pointed at by
> r->objects->multi_pack_index. That would prevent the latter call from
> deep within the callstack of prepare_bitmap_git() from opening another
> copy and then (mistakenly) re-installing the same pack twice.

But now the internal midx writing code can never call close_midx() on
that, because it does not own it to close. Can we simply drop the
close_midx() call there?

This would all make much more sense to me if write_midx_internal()
simply took a conceptually read-only midx as a parameter, and the caller
passed in the appropriate one (probably even using
prepare_multi_pack_index_one() to get it).

-Peff

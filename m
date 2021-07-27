Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962ABC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7EC60FEE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhG0RRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:17:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:58818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhG0RRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:17:03 -0400
Received: (qmail 30992 invoked by uid 109); 27 Jul 2021 17:17:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 17:17:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 743 invoked by uid 111); 27 Jul 2021 17:17:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 13:17:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 13:17:02 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQA/jt0mhP0QjA26@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP8F9ttlMXwNZBam@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 02:59:02PM -0400, Taylor Blau wrote:

> > Hmm, after staring at this for a bit, I've unconfused and re-confused
> > myself several times.
> >
> > Here are some interesting bits:
> >
> >   - calling load_multi_pack_index() directly creates a new midx object.
> >     None of its m->packs[] array will be filled in. Nor is it reachable
> >     as r->objects->multi_pack_index.
> >
> >   - in using that midx, we end up calling prepare_midx_pack() for
> >     various packs, which creates a new packed_git struct and adds it to
> >     r->objects->packed_git (via install_packed_git()).
> >
> > So that's a bit weird already, because we have packed_git structs in
> > r->objects that came from a midx that isn't r->objects->multi_pack_index.
> > And then if we later call prepare_multi_pack_index(), for example as
> > part of a pack reprepare, then we'd end up with duplicates.
> 
> Ah, this jogged my memory: this is a relic from when we generated MIDX
> bitmaps in-process with the rest of the `repack` code. And when we did
> that, we did have to call `reprepare_packed_git()` after writing the new
> packs but before moving them into place.
> 
> So that's where the `reprepare_packed_git()` came from, but we don't
> have any of that code anymore, since we now generate MIDX bitmaps by
> invoking:
> 
>     git multi-pack-index write --bitmap --stdin-packs --refs-snapshot
> 
> as a sub-process of `git repack`; no need for any reprepare which is
> what was triggering this bug.

OK, that makes sense, especially given the "close_midx() leaves the
pointer bogus" stuff discussed elsewhere.

> To be sure, I reverted this patch out of GitHub's fork, and reran the
> tests both in normal mode (just `make test`) and then once more with the
> `GIT_TEST_MULTI_PACK_INDEX{,_WRITE_BITMAP}` environment variables set.
> Unsurprisingly, it passed both times.
> 
> I'm happy to keep digging further, but I think that I'm 99% satisfied
> here. Digging further involves resurrecting a much older version of this
> series (and others adjacent to it), and there are probably other bugs
> lurking that would be annoying to tease out.
> 
> In any case, let's drop this patch from the series. It's disappointing
> that we can't run:
> 
>     git -c core.multiPackIndex= multi-pack-index write
> 
> anymore, but I guess that's no worse than the state we were in before
> this patch, so I'm content to let it live on.

Great. If we can drop it, I think that is the best path forward. I think
that may simplify things for the writing patch, too, then. It should not
matter if we move close_midx() anymore, because we will not be closing
the main r->objects->multi_pack_index struct.

I do suspect we could be skipping the load _and_ close of the midx
entirely in write_midx_internal(), and just using whatever the caller
has passed in (and arguably just having most callers pass in the regular
midx struct if they want us to reuse parts of it). That might be a
cleanup we can leave for later, but it might be necessary to touch these
bits anyway (if there is still some kind of close_midx() ordering gotcha
in the function).

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABCAC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBAE64E3E
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhBQT0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:26:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:36162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232852AbhBQT0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:26:25 -0500
Received: (qmail 19703 invoked by uid 109); 17 Feb 2021 19:25:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 19:25:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7649 invoked by uid 111); 17 Feb 2021 19:25:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 14:25:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 14:25:41 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] p5303: measure time to repack with keep
Message-ID: <YC1ttSf1xZLbCSH8@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <b5081c01b53beb568ef2e59956d25b36be9f24d0.1612411124.git.me@ttaylorr.com>
 <YCxcGKo7kyLwVvw+@coredump.intra.peff.net>
 <YC1q64fQxHBMxmyw@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC1q64fQxHBMxmyw@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 02:13:47PM -0500, Taylor Blau wrote:

> > > That's because the code paths around handling .keep files are known to
> > > scale badly; they look in every single pack file to find each object.
> >
> > Well, part of it is just that with 1000 packs we have 20 times as many
> > objects that are actually getting packed with --stdin-packs, compared to
> > the 50-pack case. IIRC, each pack is a fixed-size slice and then the
> > residual is put into the .keep pack. So the fact that the time gets
> > closer to a full repack as we add more packs is expected: we are asking
> > pack-objects to do more work!
> 
> No, the residual base pack isn't marked as kept on-disk. But the
> --stdin-packs test treats it as such, by passing '^pack-$base_pack.pack'
> as input to '--stdin-packs' (thus marking it as kept in-core).

Sorry, I perhaps shouldn't have said ".keep" here. But it's the same
thing, isn't it? The 50 pack case is packing 50*pack_size objects
(because it's excluding everything else that is in the base pack we mark
as keep-in-core), and the 1000-pack case is packing 1000*pack_size
objects (for the same reason).

So any patterns we see between them have more to do with that, than how
the keep-handling code scales with the number of non-kept packs.

> > For showing the impact of the optimizations in patches 7 and 8, I think
> > doing a full repack with --honor-pack-keep is a better test. Because
> > then we're always doing a full traversal, and most of the work continues
> > to scale with the repo size (though obviously not the actual shuffling
> > of packed bytes around). That would get rid of the weird "no work to do"
> > case in the single-pack tests, too.
> 
> I think you're suggesting that we change the "repack ($nr_packs)" test
> to have the residual pack marked as kept (so we're measuring time it
> takes to repack everything that _isn't_ in the base pack)?
> 
> That would allow a more direct comparison, but I think it's loosing out
> on an important aspect which is how long it takes to pack the entire
> repository. Maybe we want three.

That was what I was suggesting, but I think it's equivalent to what your
--stdin-packs is testing. I guess the most interesting thing would
actually be an _additional_ pack mark as .keep (and that pack does not
even have to contain anything interesting -- the point is how much
effort it costs to find that out. Of course the bigger it is the more
pronounced the effect of avoiding lookups in it).

-Peff

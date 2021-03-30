Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF6C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D628161999
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC3HLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:11:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:36732 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhC3HLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 03:11:50 -0400
Received: (qmail 18076 invoked by uid 109); 30 Mar 2021 07:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 07:11:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22011 invoked by uid 111); 30 Mar 2021 07:11:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 03:11:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 03:11:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 08/16] midx: allow marking a pack as preferred
Message-ID: <YGLPND21b0o8JIfw@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <30194a6786bec51e0f41de0e6c855dc2297806c6.1615482270.git.me@ttaylorr.com>
 <YGHBe1ZB/iCRpqgD@coredump.intra.peff.net>
 <YGJDYIxicaPDMdeZ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGJDYIxicaPDMdeZ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 05:15:12PM -0400, Taylor Blau wrote:

> There are two solutions to the problem:
> 
>   - You could write the mtimes in the MIDX itself. This would give you a
>     single point of reference, and resolve the TOCTOU race I just
>     described.
> 
>   - Or, you could forget about mtimes entirely and let the MIDX dictate
>     the pack ordering itself. That resolves the race in a
>     similar-but-different way.
> 
> Of the two, I prefer the latter, but I think it introduces functionality
> that we don't necessarily need yet.

Yeah, I'd strongly favor the latter over the former. The reason to go
with the solution you have in this series is that it doesn't require
changing anything in the on-disk midx format, and we think it is good
enough. But once we are going to change the on-disk format, we might as
well give the writing side as much flexibility as possible.

Of course the mtimes themselves are really just numbers, so in a sense
the two are really equivalent. ;)

> That's because the objects within
> the packs are still ordered as such, and so the compression we get in
> the packs is just as good as it is for single-pack bitmaps. It's only at
> the objects between pack boundaries that any runs of 1s or 0s might be
> interrupted, but there are far fewer pack boundaries than objects, so it
> doesn't seem to matter in practice.

Right. The absolute worst case is a large number of single-object packs,
in which case the bitmap order becomes essentially random with respect
to history (because it would be sorted by sha1 of the packs).

The effect _might_ be measurable in more real-world cases, like say one
big pack and 100 pushes each with a handful of commits. The big pack
would be in good shape, but you have a lot of extra pack boundaries that
hurt the bitmap compression.

But in practice, generating bitmaps is expensive enough that you'd
probably want to roll up some of the packs anyway (and that is certainly
what we are doing at GitHub, using your "repack --geometric"). So you'd
end usually with one big pack representing most of history, and then a
handful of roll-up packs.

So I'm a little curious whether one could even measure the impact of,
say, 100 little packs. But not enough to even run the experiment,
because even that is not a case that is really that interesting.

> Anyway, I think that you know all of that already (mostly because we
> thought aloud together when I originally brought this up), but I figure
> that this detail may be interesting for other readers, too.

Indeed. And I know that you know everything I just wrote, but I agree
it's nice to get a record of these discussions onto the list. :)

-Peff

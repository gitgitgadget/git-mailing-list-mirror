Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792EBC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjDRKjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjDRKjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 06:39:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8B199C
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 03:39:10 -0700 (PDT)
Received: (qmail 4996 invoked by uid 109); 18 Apr 2023 10:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 10:39:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 836 invoked by uid 111); 18 Apr 2023 10:39:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 06:39:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 06:39:09 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 03/10] builtin/gc.c: ignore cruft packs with
 `--keep-largest-pack`
Message-ID: <20230418103909.GD508219@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
 <796df920ad6af0ee9101a0f3f80edbc793987336.1681764848.git.me@ttaylorr.com>
 <xmqqildui0gk.fsf@gitster.g>
 <ZD3QLMs8/+DLKZM6@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZD3QLMs8/+DLKZM6@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 07:03:08PM -0400, Taylor Blau wrote:

> On Mon, Apr 17, 2023 at 03:54:35PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > >   - The same is true for `gc.bigPackThreshold`, if the size of the cruft
> > >     pack exceeds the limit set by the caller.
> >
> > This is not as cut-and-dried clear as the previous one.  "This pack
> > is so large that it is not worth rewriting it only to expunge a
> > handful of objects that are no longer reachable from it" is the main
> > motivation to use this configuration, but doesn't some part of the
> > same reasoning apply equally to a large cruft pack?  But let's
> > assume that the configuration is totally irrelevant to cruft packs
> > and read on.
> 
> This is an inherent design trade-off. I imagine that callers who want to
> avoid rewriting their (large) cruft packs would prefer to generate a new
> cruft pack on top with just the recently accumulated unreachable
> objects.
> 
> That kind of works, except if you need to prune objects that are packed
> in an earlier cruft pack. If you have `gc.bigPackThreshold`, there is no
> way to do this if you need to expire objects that are in cruft packs
> above that threshold.
> 
> A user may find themselves frustrated when trying to `git gc --prune`
> some sensitive object(s) from their repository doesn't appear to work,
> only to discover that `gc.bigPackThreshold` is set somewhere in their
> configuration.
> 
> Writing (largely) the same cruft pack to expunge a few objects isn't
> ideal, but it is better than the status quo. And if you have so many
> unreachable objects that this is a concern, it is probably time to prune
> anyway.

Yeah, what your patch does makes sense to me as a default behavior. In a
pre-cruft-pack world, those objects would all be left alone by
gc.bigPackThreshol (because they're loose), and the essence of
cruft-packs is creating a parallel universe where those ejected-to-loose
objects just happen to be stored in a more efficient format.

> It is possible that in the future we could support writing multiple
> cruft packs (we already handle the presence of multiple cruft packs
> fine, just don't expose an easy way for the user to write >1 of them).
> And at that point we would be able to relax this patch a bit and allow
> `gc.bigPackThreshold` to cover cruft packs, too. But in the meantime,
> the benefit of avoiding loose object explosions outweighs the possible
> drawbacks here, IMHO.

I wondered if that interface might be an option to say "hey, I have a
gigantic cruft file I want to carry forward, please leave it alone".

But if you have a giant cruft pack that is making your "git gc" too
slow, it will eventually age out on its own. And if you're impatient,
then "git gc --prune=now" is probably the right tool.

And If you really did want to keep rolling it forward for some reason,
then I'd think marking it with ".keep" would be the best thing (and
maybe even dropping the mtimes file? I'm not sure a how a kept-cruft
pack does or should behave).

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81792C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiITUGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiITUG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:06:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C761724
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:06:28 -0700 (PDT)
Received: (qmail 30929 invoked by uid 109); 20 Sep 2022 20:06:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 20:06:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14433 invoked by uid 111); 20 Sep 2022 20:06:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 16:06:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 16:06:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, derrickstolee@github.com
Subject: Re: [PATCH] midx.c: use `pack-objects --stdin-packs` when repacking
Message-ID: <YyodQg5diyr/UYK1@coredump.intra.peff.net>
References: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
 <YyoUZb90HeJnOuAV@coredump.intra.peff.net>
 <YyoZM1V5S53dz6U6@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyoZM1V5S53dz6U6@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 03:49:07PM -0400, Taylor Blau wrote:

> > Is that true also of "multi-pack-index repack"? I guess it would depend
> > on how you invoke it. I admit I don't think I've ever used it myself,
> > since the new "repack --geometric --write-midx" approach matches my
> > mental model. I'm not sure when you'd actually run the "multi-pack-index
> > repack" command. But if you did it with --batch-size=0 (the default), I
> > think we'd end up traversing every object in history.
> 
> We could probably benefit from it, but only if there is a MIDX bitmap
> around to begin with. For instance, you could first try and lookup each
> object you're missing a namehash for and then read its value out of the
> hashcache extension in the MIDX bitmap (assuming the MIDX bitmap exists,
> and has a hashcache).
> 
> But if you don't have a MIDX bitmap, or it has a poor selection of
> commits, then you're out of luck.

You could also use a pack bitmap if there is one (and it's one of the
included packs). But yes, if you have neither, it's no help.

Mostly I'm just concerned that this could have an outsized negative
performance effect if you have a setup like:

  - you have a gigantic repository, say that takes 15 minutes to do a
    full "rev-list --objects" on (like linux.git with all its forks)

  - most of that is in one big pack, but you acquire new packs
    occasionally via pushes, etc

  - doing "git repack --geometric" rolls up the new packs, nicely
    traversing just the new objects

  - doing "git multi-pack-index repack" before your patch is fast-ish.
    It stuffs all the objects into a new pack. But after your patch, it
    does that 15-minute traversal.

But I don't know if that's even realistic, because I'm still wondering
why somebody would run "git multi-pack-index repack" in the first place.
And if they'd always do so with --batch-size anyway, which would
mitigate this (because it gives a geometric-ish approach where we leave
the huge pack untouched).

If it is, then one thing to consider is tying the "do the extra
traversal" feature to the presence / size of excluded packs. And
possibly considering the presence of a bitmap to indicate that it's
worth doing (assuming the optimization there is implemented).

But that sounds like a lot of work to get right, and again, I'm not
really sure of the benefit.

> > The old code went in object order within the midx. Is this sorted by
> > sha1, or the pack pseudo-order? If the former, then that will yield a
> > different order of objects inside pack-objects (since it is seeing the
> > packs in order of our m->pack_names array). I don't _think_ it matters,
> > but I just wanted to double check.
> 
> Good point. This ends up ordering the packs based on their SHA-1
> checksum, and probably should stick to the pack mtimes instead.
> 
> Unfortunately, we discard that information by the time we get to this
> point in midx_repack(). We don't even have it written durably in the
> MIDX, either, so we reconstruct it on-the-fly in
> fill_included_packs_batch() (see the `QSORT()` call there with
> `compare_by_mtime()`).
> 
> I agree that it probably doesn't matter in practice, but it's worth
> trying to match the existing behavior, at least.

Yeah, sorting the packs by mtime might be sensible. I know in the final
midx, we use object order to find the "preferred" pack. And you could
iterate the objects here, passing along their de-duped pack name. But I
don't think we have the objects here in that useful order; that is
really the order of the midx's .rev file, IIRC, and this is probably the
actual sha1 order.

-Peff

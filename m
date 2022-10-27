Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC28FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 20:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiJ0Uyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiJ0UyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 16:54:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE398CA3
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:46:04 -0700 (PDT)
Received: (qmail 18094 invoked by uid 109); 27 Oct 2022 20:45:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Oct 2022 20:45:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24716 invoked by uid 111); 27 Oct 2022 20:45:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Oct 2022 16:45:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Oct 2022 16:45:46 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Teng Long <dyroneteng@gmail.com>, gitster@pobox.com,
        avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y1rt+uOKwlP5PIrT@coredump.intra.peff.net>
References: <xmqqtu5zyndk.fsf@gitster.g>
 <20220829024803.47496-1-tenglong.tl@alibaba-inc.com>
 <Y1mp23NHB0qzKsPR@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1mp23NHB0qzKsPR@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 05:42:51PM -0400, Taylor Blau wrote:

> At GitHub, we actually *do* remove this warning entirely:
> 
> --- >8 ---
> 
> From: Jeff King <peff@peff.net>
> Subject: [PATCH] pack-bitmap: drop "ignoring extra bitmap" warning

A blast from the past. You didn't include the Date field, but this was
from ~2017.

> For the general case of what ships in git.git, I *do* find this warning
> useful. It's helpful when hacking on pack-bitmap.c to know if you've
> messed up, and it's useful to see the filename of the affected
> bitmap(s).

It feels like you might be a special case, though. Most people are not
hacking on the bitmap code. :)

I wonder if you'd be better served by having good tracing for the bitmap
code. Then it could tell you lots of things, like which bitmap it
actually opened, which ones it ignored, etc. Of course you'd have to
remember to enable that tracing when you're working in the area.

The other thing that has always bugged me about this warning (and would
be true of tracing code, too) is that it inherently requires looking at
all of the packfiles. I.e., open_pack_bitmap() doesn't return when it
finds something; it keeps going just in case it finds another bitmap so
it can say "hey, there's an extra one!".

This complicates the code a little bit. But it's also inefficient. If we
have N packs, we'll do N open() calls, most of which will fail. Weirder,
though, is that we open the pack .idx first. So we're literally opening,
mapping, and checking the idx for every pack for no reason!

Now this might not be as bad as it seems:

  - in the long run, we might open those idx files anyway, if we have to
    access those packs. So it's really just overriding the lazy-open
    behavior.

  - in the worst case, the one bitmap file is at the end of the list, so
    you hit all N anyway. And this is actually pretty common, since we
    sort in reverse-chronological order, and the bitmap is usually on
    the oldest and biggest pack.

  - in general, having a lot of packs has bad performance for other
    reasons. So you'd generally want to keep N small-ish in the first
    place.

So it may not be worth worrying about. It does seem like it would be
easy to reorder open_pack_bitmap_1() to look for a bitmap file first and
only open the idx if it finds something.

It's possible we have a weird race-dependency on opening those idx files
early (certainly there's some subtlety with pack-objects keeping the
.pack files themselves open which prevents problems with a simultaneous
repack). But I think it would be OK; we don't commit to using a
particular .idx file in the general case, and one that goes away would
just cause us to reprepare_packed_git() and continue. For a particular
.bitmap, we do commit to having the matching .idx file, but obviously
we'd want to open and check that one before considering the bitmap to be
successfully opened.

> I think we could reasonably change the warning to
> 
>     warning(_("ignoring extra bitmap file: %s"),
>             basename(packfile->pack_name));
> 
> since the rest of the path is obvious based on which repository you're
> working in. So that would be a reasonable change to shorten up the
> output a little bit.

Yeah. If we are going to keep the warning, this makes much better sense.
Possibly we could even just skip_prefix() on the object directory,
though I think in practice it amounts to the same thing.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF35C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 04:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCYE5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 00:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCYE5L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 00:57:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339721A480
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 21:57:10 -0700 (PDT)
Received: (qmail 10446 invoked by uid 109); 25 Mar 2023 04:57:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 04:57:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9474 invoked by uid 111); 25 Mar 2023 04:57:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 00:57:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 00:57:08 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Message-ID: <20230325045708.GA555973@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
 <20230321175612.GF3119834@coredump.intra.peff.net>
 <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
 <20230324182929.GA536252@coredump.intra.peff.net>
 <ZB4w2gCo/qPCmWkz@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB4w2gCo/qPCmWkz@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 07:23:06PM -0400, Taylor Blau wrote:

> On Fri, Mar 24, 2023 at 02:29:29PM -0400, Jeff King wrote:
> > We know the advance will succeed because we checked ahead of time that
> > we had enough bytes. So it really is a BUG() if we don't, as it would
> > indicate somebody missed the earlier check. On the other hand, it is a
> > weird spot for an extra check, because by definition we'll have just
> > read off the array just before the seek.
> 
> Here you claim that we want bitmap_index_seek_to() to call BUG() if we
> end up with map_pos >= map_size. But...

I think the paragraph above doesn't have enough context. I meant
incrementing the pos here (which is why "we checked ahead of time that
we had enough bytes"), in which case it is a BUG() (double-checking the
earlier check).

In a seek_to(), there is no previous check. We have to make sure the
requested offset is within bounds.

> > The case where we _do_ seek directly to a file-provided offset, rather
> > than incrementing, is an important check that this series adds, but that
> > one should be a die() and not a BUG().
> 
> ...here you say that it should be a die().

Right, so that one would be a die(). Or better still, an error().

> I think it does depend on the context. When seeking directly to a
> position before reading something, die()-ing is appropriate. The case
> where you seek to a relative position to reflect that you just read
> something, a BUG() is appropriate.

Right, exactly. We are agreeing, I think.

> So really, I think you want something like this:
> 
>     static void bitmap_index_seek_set(struct bitmap_index *bitmap_git, size_t pos)
>     {
>       if (pos >= bitmap_git->map_size)
>         die(_("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")"),
>             (uintmax_t)bitmap_git->map_pos,
>             (uintmax_t)bitmap_git->map_size);
> 
>       bitmap_git->map_pos = pos;
>     }
> 
>     static void bitmap_index_seek_ahead(struct bitmap_index *bitmap_git,
>                                         size_t offset)
>     {
>       if (bitmap_git->map_pos + offset >= bitmap_git->map_size)
>         BUG("cannot seek %"PRIuMAX" byte(s) ahead of %"PRIuMAX" "
>             "(%"PRIuMAX" >= %"PRIuMAX")",
>             (uintmax_t)offset,
>             (uintmax_t)bitmap_git->map_pos,
>             (uintmax_t)(bitmap_git->map_pos + offset),
>             (uintmax_t)bitmap_git->map_size);
> 
>       bitmap_git->map_pos += offset;
>     }
> 
> Does that match what you were thinking?

Yes, though I am of the opinion that the assertion in seek_ahead() is
largely pointless, simply because if it ever triggered we would already
have triggered undefined behavior. I'm not opposed to adding it if you
feel strongly, I just wouldn't bother myself (and instead would focus on
making the "do we have enough bytes to read" checks more consistent and
harder-to-get-wrong).

Seeking to exactly map_size in the seek_set() case (i.e., the "=" in
">=") is a little funny, but not illegal. Either way, you'd want to
check "and do we have N bytes to read from this offset" immediately
afterwards (and your series does), so that would catch any non-zero
reads there.

-Peff

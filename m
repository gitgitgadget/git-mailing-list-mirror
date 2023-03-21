Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA2C7619A
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCUR4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCUR4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:56:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F551C84
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:56:13 -0700 (PDT)
Received: (qmail 28204 invoked by uid 109); 21 Mar 2023 17:56:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 17:56:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2497 invoked by uid 111); 21 Mar 2023 17:56:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 13:56:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 13:56:12 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Message-ID: <20230321175612.GF3119834@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 04:02:49PM -0400, Taylor Blau wrote:

> The pack-bitmap internals use a combination of a `map` and `map_pos`
> variable to keep a pointer to a memory mapped region of the `.bitmap`
> file, as well as the position within that file, respectively.
> 
> Reads within the memory mapped region are meant to mimic file reads,
> where each read adjusts the offset of the file descriptor accordingly.
> This functionality is implemented by adjusting the `map_pos` variable
> after each read.
> 
> Factor out a function similar to seek() which adjusts the `map_pos`
> variable for us. Since the bitmap code only needs to adjust relative to
> the beginning of the file as well as the current position, we do not
> need to support any "whence" values outside of SEEK_SET and SEEK_CUR.

I like the idea of centralizing the bounds checks here.

I do think copying lseek() is a little awkward, though. As you note, we
only care about SEEK_SET and SEEK_CUR, and we have to BUG() on anything
else. Which means we have a run-time check, rather than a compile time
check. If we had two functions like:

  void bitmap_index_seek_to(struct bitmap_index *bitmap_git, size_t pos)
  {
	bitmap_git->map_pos = pos;
	if (bitmap_git->map_pos >= bitmap_git->map_size)
	   ...etc...
  }

  void bitmap_index_incr(struct bitmap_index *bitmap_git, size_t offset)
  {
	bitmap_index_seek_to(bitmap_git, st_add(bitmap_git->map_pos, offset));
  }

then the compiler can see all cases directly. I dunno how much it
matters.

The other thing that's interesting from a bounds-checking perspective is
that you're checking the seek _after_ you've read an item. Which has two
implications:

  - I don't think we could ever overflow size_t here. We are working
    with a buffer that we got from mmap(), so it's already probably
    bounded to some much smaller subset of size_t. And even if we
    imagine that you really could get a buffer that stretches for the
    whole of the memory space, and that incrementing it by 4 bytes would
    overflow, we'd by definition have just overflowed the memory space
    itself by reading 4 bytes (and presumably segfaulted). So I really
    doubt this st_add() is doing anything.

  - The more interesting case is that we are not overflowing size_t, but
    simply walking past bitmap_git->map_size. But again, we are reading
    first and then seeking. So if our seek does go past, then by
    definition we just read garbage bytes, which is undefined behavior.

    For a bounds-check, wouldn't we want it the other way around? To
    make sure we have 4 bytes available, and then if so read them and
    increment the offset?

> +	if (bitmap_git->map_pos >= bitmap_git->map_size)
> +		BUG("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")",
> +		    (uintmax_t)bitmap_git->map_pos,
> +		    (uintmax_t)bitmap_git->map_size);

This uses ">=", which is good, because it is valid to walk the pointer
to one past the end of the map, which is effectively EOF. But as above,
in that condition the callers should be checking for this EOF state
before reading the bytes.

-Peff

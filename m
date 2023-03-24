Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FCC6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 18:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCXS3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXS3l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 14:29:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B83A168BE
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:29:32 -0700 (PDT)
Received: (qmail 5868 invoked by uid 109); 24 Mar 2023 18:29:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Mar 2023 18:29:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4475 invoked by uid 111); 24 Mar 2023 18:29:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Mar 2023 14:29:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Mar 2023 14:29:29 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Message-ID: <20230324182929.GA536252@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
 <20230321175612.GF3119834@coredump.intra.peff.net>
 <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 02:04:05PM -0400, Derrick Stolee wrote:

> >> +	if (bitmap_git->map_pos >= bitmap_git->map_size)
> >> +		BUG("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")",
> >> +		    (uintmax_t)bitmap_git->map_pos,
> >> +		    (uintmax_t)bitmap_git->map_size);
> > 
> > This uses ">=", which is good, because it is valid to walk the pointer
> > to one past the end of the map, which is effectively EOF. But as above,
> > in that condition the callers should be checking for this EOF state
> > before reading the bytes.
> 
> In other words, it would be too easy for a strange data shape to trigger
> this BUG() statement, which should be reserved for the most-extreme cases
> of developer mistake. Things like "this is an unacceptable 'whence' value"
> or "this should never be NULL" make sense, but this is too likely to be
> hit due to a runtime error.

Sort of. AFAICT in all of the "increment" cases we'll already have done
bounds-checks, so this really is a BUG() condition. But in that case I
question whether it's even worthwhile. The calling code ends up being
something like:

  /* check that we have enough bytes */
  if (total - pos < 4)
	return error(...);

  /* read those bytes */
  get_be32() or whatever...

  /* now advance pos, making sure we...had enough bytes? */
  bitmap_index_seek(..., 4);

We know the advance will succeed because we checked ahead of time that
we had enough bytes. So it really is a BUG() if we don't, as it would
indicate somebody missed the earlier check. On the other hand, it is a
weird spot for an extra check, because by definition we'll have just
read off the array just before the seek.

> Would it make sense to return an 'int' instead of the size_t of map_pos?
> That way we could return in error if this is exceeded, and then all
> callers can respond "oh wait, that move would exceed the file size, so
> I should fail in my own way..."?

You can die() to avoid returning an error. But given that this is bitmap
code, and we can generally complete the operation even if it is broken
(albeit slower), usually we'd try to return the error up the call chain
(like bitmap_index_seek_commit() does later in the series). Plus that
follows our libification trend of not killing the process in low-level
code.

It does make the callers more complicated, though. If this were
_replacing_ the existing bounds-checks that might be worth it, but
coming after like this, I guess I just don't see it as adding much.

The case where we _do_ seek directly to a file-provided offset, rather
than incrementing, is an important check that this series adds, but that
one should be a die() and not a BUG().

-Peff

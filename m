Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A02C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 18:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCXSfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCXSfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 14:35:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F72738
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:35:16 -0700 (PDT)
Received: (qmail 5894 invoked by uid 109); 24 Mar 2023 18:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Mar 2023 18:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4544 invoked by uid 111); 24 Mar 2023 18:35:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Mar 2023 14:35:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Mar 2023 14:35:14 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where
 possible
Message-ID: <20230324183514.GB536252@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
 <20230321180525.GG3119834@coredump.intra.peff.net>
 <8a7cf287-421c-9a7f-0788-c5e219e6a8e3@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a7cf287-421c-9a7f-0788-c5e219e6a8e3@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 02:06:43PM -0400, Derrick Stolee wrote:

> >> +	bitmap_index_seek(index, header_size, SEEK_CUR);
> >>  	return 0;
> >>  }
> > 
> > Likewise this function already has bounds checks at the top:
> > 
> > 	if (index->map_size < header_size + the_hash_algo->rawsz)
> > 		return error(_("corrupted bitmap index (too small)"));
> > 
> > I'd be perfectly happy if we swapped that our for checking the bounds on
> > individual reads, but the extra checking in the seek step here just
> > seems redundant (and again, too late).
> 
> I think it would be nice to replace all of these custom bounds
> checks with a check within bitmap_index_seek() and error conditions
> done in response to an error code returned by that method. It keeps
> the code more consistent in the potential future of changing the
> amount to move the map_pos and the amount checked in these conditions.

Yeah, that's what I was getting at. But doing it at seek time is too
late. We'll have just read off the end of the array.

You really need an interface more like "make sure there are N bytes for
me to read at offset X". Then you can read and advance past them.

For individual items where you want to copy the bytes out anyway (like a
be32) you can have a nice interface like:

  if (read_be32(bitmap_git, &commit_idx_pos) < 0 ||
      read_u8(bitmap_git, &xor_offset) < 0 ||
      read_u8(bitmap_git, &flags) < 0)
	return error("truncated bitmap entry");

But given that there is only one spot that calls these, that kind of
refactoring might not be worth it (right now it just uses the magic
number "6" right before grabbing the data).

-Peff

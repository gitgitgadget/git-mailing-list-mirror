Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F20C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 06:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951012224B
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 06:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKNGXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 01:23:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:58214 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgKNGXM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 01:23:12 -0500
Received: (qmail 28801 invoked by uid 109); 14 Nov 2020 06:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Nov 2020 06:23:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20775 invoked by uid 111); 14 Nov 2020 06:23:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Nov 2020 01:23:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Nov 2020 01:23:10 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 17/23] pack-bitmap-write: build fewer intermediate bitmaps
Message-ID: <20201114062310.GA828053@coredump.intra.peff.net>
References: <cover.1605123652.git.me@ttaylorr.com>
 <ab64354851e2aa61e901e37814b2ae33d8f855d1.1605123653.git.me@ttaylorr.com>
 <20201113222328.GA8033@szeder.dev>
 <20201113230324.GA784144@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113230324.GA784144@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 06:03:24PM -0500, Jeff King wrote:

> But what's slightly disturbing is this output:
> 
> >   --- expect      2020-11-13 22:20:39.246355100 +0000
> >   +++ actual      2020-11-13 22:20:39.254355294 +0000
> >   @@ -1 +1 @@
> >   -239
> >   +236
> >   error: last command exited with $?=1
> 
> We're actually producing the wrong answer here, which implies that
> ewah_read_mmap() is not being careful enough. Or possibly we are feeding
> it extra bytes (e.g., letting it run over into the name-hash cache or
> into the trailer checksum).
> 
> I think we'll have to dig further into this, probably running the sha256
> case in a debugger to see what offsets we actually end up reading.

Yep, the problem is in the caller, which is not careful about size
checks before reading the header before the actual ewah.

The first hunk here fixes it (the second is just another possible
corruption I noticed, but not triggered by the test):

diff --git a/pack-bitmap.c b/pack-bitmap.c
index dc811ebae8..785009b04e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -229,11 +229,16 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		uint32_t commit_idx_pos;
 		struct object_id oid;
 
+		if (index->map_size - index->map_pos < 6)
+			return error("corrupt ewah bitmap: truncated header for entry %d", i);
+
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		nth_packed_object_id(&oid, index->pack, commit_idx_pos);
+		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
+			return error("corrupt ewah bitmap: commit index %u out of range",
+				     (unsigned)commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)

We should definitely do something like this, but there are some possible
further improvements:

  - I think that map_size includes the trailing hash, and almost
    certainly any post-index extensions. We could probably compute the
    correct boundary of the bitmaps themselves in the caller and make
    sure we don't read past it. I'm not sure if it's worth the effort,
    though. In a truncation situation, basically all bets are off (is
    the trailer still there and the bitmap entries malformed, or is the
    trailer truncated?). The best we can do is try to read what's there
    as if it's correct data (and protect ourselves when it's obviously
    bogus).

  - we could avoid the magic "6" if read_be32() and read_u8(), which are
    custom helpers for this function, checked sizes before advancing the
    pointers.

  - I'm hesitant to add more tests in this area. As you can see from the
    commit which "broke" the test, truncating at byte N is going to be
    sensitive to small variations in the bitmap generation. So unless
    we're actually parsing the bitmaps and doing targeted corruptions,
    the tests will be somewhat brittle.

-Peff

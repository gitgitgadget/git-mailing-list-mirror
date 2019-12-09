Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B62C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63E3206D3
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfLIHGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:06:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:41748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727196AbfLIHGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 02:06:44 -0500
Received: (qmail 18356 invoked by uid 109); 9 Dec 2019 07:06:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 07:06:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18402 invoked by uid 111); 9 Dec 2019 07:11:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 02:11:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 02:06:42 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 5/9] pack-bitmap: introduce bitmap_walk_contains()
Message-ID: <20191209070642.GE40570@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-6-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115141541.11149-6-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:15:37PM +0100, Christian Couder wrote:

> We will use this helper function in a following commit to
> tell us if an object is packed.

Yeah, makes sense. This is eventually used in have_duplicate_entry() in
pack-objects, to check whether an object is already mentioned in
reuse_packfile_bitmap. And that's the part that would fix the test
failures from the previous commit.

But of course we don't yet have reuse_packfile_bitmap; that comes later.

> +int bitmap_walk_contains(struct bitmap_index *bitmap_git,
> +			 struct bitmap *bitmap, const struct object_id *oid)
> +{
> +	int idx;
> +
> +	if (!bitmap)
> +		return 0;
> +
> +	idx = bitmap_position(bitmap_git, oid);
> +	return idx >= 0 && bitmap_get(bitmap, idx);
> +}

This is really a factoring out of code in
bitmap_has_oid_in_uninteresting(). So I think you could simplify that
like:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index cbfc544411..f5749d0ab3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1194,16 +1194,6 @@ void free_bitmap_index(struct bitmap_index *b)
 int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
 				    const struct object_id *oid)
 {
-	int pos;
-
-	if (!bitmap_git)
-		return 0; /* no bitmap loaded */
-	if (!bitmap_git->haves)
-		return 0; /* walk had no "haves" */
-
-	pos = bitmap_position_packfile(bitmap_git, oid);
-	if (pos < 0)
-		return 0;
-
-	return bitmap_get(bitmap_git->haves, pos);
+	return bitmap_git &&
+	       bitmap_walk_contains(bitmap_git, bitmap_git->haves, oid);
 }

One curiosity is that bitmap_has_oid_in_uninteresting() only uses
bitmap_position_packfile(), not bitmap_position(). So it wouldn't find
objects which weren't in the bitmapped packfile (i.e., ones where we
extended the bitmap to handle loose objects, or objects in other packs).

That seems like a bug in the current code to me. I suspect nobody
noticed because the only effect would be that sometimes we fail to
notice that we could reuse a delta against such an object (which isn't
incorrect, just suboptimal). I don't think p5311 would show this,
though, because it simulates a server that is fully packed.

I think it's probably still worth doing this as a preparatory patch,
though:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e07c798879..6df22e7291 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1125,7 +1125,7 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
 	if (!bitmap_git->haves)
 		return 0; /* walk had no "haves" */
 
-	pos = bitmap_position_packfile(bitmap_git, oid);
+	pos = bitmap_position(bitmap_git, oid);
 	if (pos < 0)
 		return 0;
 

-Peff

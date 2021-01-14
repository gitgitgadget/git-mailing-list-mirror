Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1FC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466542310F
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbhANULv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:11:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:56426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbhANULv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:11:51 -0500
Received: (qmail 17759 invoked by uid 109); 14 Jan 2021 20:11:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 20:11:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17718 invoked by uid 111); 14 Jan 2021 20:11:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 15:11:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 15:11:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
Message-ID: <YAClXle+utN/VnVZ@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
 <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
 <YACcoNY/SiEbBSgh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YACcoNY/SiEbBSgh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 02:33:53PM -0500, Jeff King wrote:

> So "pos" in this case is not wrong. But I agree that it could stand to
> be more clear. Saying "nth" does not help things IMHO (there is an "nth"
> pack position, as well).
> 
> But maybe this makes it more clear (or possibly just the name change
> without the comment):

Here it is again, but with a signoff and commit message, and done on top
of your series (so if we agree this is a good resolution, it can just be
picked up on top, but I am also happy for it to be squashed into patch
15).

-- >8 --
Subject: [PATCH] for_each_object_in_pack(): clarify pack vs index ordering

We may return objects in one of two orders: how they appear in the .idx
(sorted by object id) or how they appear in the packfile itself. To
further complicate matters, we have two ordering variables, "i" and
"pos", and it is not clear to which order they apply.

Let's clarify this by using an unambiguous name where possible, and
leaving a comment for the variable that does double-duty.

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7bb1750934..35d50e2c38 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2082,19 +2082,31 @@ int for_each_object_in_pack(struct packed_git *p,
 	}
 
 	for (i = 0; i < p->num_objects; i++) {
-		uint32_t pos;
+		uint32_t index_pos;
 		struct object_id oid;
 
+		/*
+		 * We are iterating "i" from 0 up to num_objects, but its
+		 * meaning may be different, depending on the requested output
+		 * order:
+		 *
+		 *   - in object-name order, it is the same as the index order
+		 *     used by nth_packed_object_id(), so we can pass it
+		 *     directly
+		 *
+		 *   - in pack-order, it is pack position, which we must
+		 *     convert to an index position in order to get the oid.
+		 */
 		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
-			pos = pack_pos_to_index(p, i);
+			index_pos = pack_pos_to_index(p, i);
 		else
-			pos = i;
+			index_pos = i;
 
-		if (nth_packed_object_id(&oid, p, pos) < 0)
+		if (nth_packed_object_id(&oid, p, index_pos) < 0)
 			return error("unable to get sha1 of object %u in %s",
-				     pos, p->pack_name);
+				     index_pos, p->pack_name);
 
-		r = cb(&oid, p, pos, data);
+		r = cb(&oid, p, index_pos, data);
 		if (r)
 			break;
 	}
-- 
2.30.0.578.g0a9fb12091


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82BCC46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjAGNu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjAGNu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:50:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F0665ACB
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:50:54 -0800 (PST)
Received: (qmail 23524 invoked by uid 109); 7 Jan 2023 13:50:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:50:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23825 invoked by uid 111); 7 Jan 2023 13:50:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:50:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:50:53 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 5/5] packfile: inline custom read_object()
Message-ID: <Y7l4vQwRZzGtxlBB@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the pack code was split into its own file[1], it got a copy of the
static read_object() function. But there's only one caller here, so we
could just inline it. And it's worth doing so, as the name read_object()
invites comparisons to the public read_object_file(), but the two don't
behave quite the same.

[1] The move happened over several commits, but the relevant one here is
    f1d8130be0 (pack: move clear_delta_base_cache(), packed_object_info(),
    unpack_entry(), 2017-08-18).

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index c0d7dd93f4..79e21ab18e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1650,22 +1650,6 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
 
-static void *read_object(struct repository *r,
-			 const struct object_id *oid,
-			 enum object_type *type,
-			 unsigned long *size)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-	void *content;
-	oi.typep = type;
-	oi.sizep = size;
-	oi.contentp = &content;
-
-	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
-		return NULL;
-	return content;
-}
-
 void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		   enum object_type *final_type, unsigned long *final_size)
 {
@@ -1798,14 +1782,22 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			uint32_t pos;
 			struct object_id base_oid;
 			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
+				struct object_info oi = OBJECT_INFO_INIT;
+
 				nth_packed_object_id(&base_oid, p,
 						     pack_pos_to_index(p, pos));
 				error("failed to read delta base object %s"
 				      " at offset %"PRIuMAX" from %s",
 				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, &base_oid);
-				base = read_object(r, &base_oid, &type, &base_size);
+
+				oi.typep = &type;
+				oi.sizep = &base_size;
+				oi.contentp = &base;
+				if (oid_object_info_extended(r, &base_oid, &oi, 0) < 0)
+					base = NULL;
+
 				external_base = base;
 			}
 		}
-- 
2.39.0.469.g9000b9c396

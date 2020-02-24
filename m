Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E9C35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AEA20658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgBXEc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:32:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:52320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727189AbgBXEc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:32:28 -0500
Received: (qmail 5207 invoked by uid 109); 24 Feb 2020 04:32:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:32:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6928 invoked by uid 111); 24 Feb 2020 04:41:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:41:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:32:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 05/10] pack-bitmap: use object_id when loading on-disk bitmaps
Message-ID: <20200224043227.GE1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A pack bitmap file contains the index position of the commit for each
bitmap, which we then translate into an object id via
nth_packed_object_sha1(). In preparation for that function going away,
we can switch to the more type-safe nth_packed_object_id().

Note that even though the result ends up in an object_id this does incur
an extra copy of the hash (into our temporary object_id, and then into
the final malloc'd stored_bitmap struct). This shouldn't make any
measurable difference. If it did, we could avoid this copy _and_ the
copy of the rest of the items by allocating the stored_bitmap struct
beforehand and reading directly into it from the bitmap file. Or better
still, if this is a bottleneck, we could introduce an on-disk index to
the bitmap file so we don't have to read every single entry to use just
one of them. So it's not worth worrying about micro-optimizing out this
one hash copy.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c81d323329..1a067885a1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -169,7 +169,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 
 static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 					  struct ewah_bitmap *root,
-					  const unsigned char *hash,
+					  const struct object_id *oid,
 					  struct stored_bitmap *xor_with,
 					  int flags)
 {
@@ -181,15 +181,15 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	stored->root = root;
 	stored->xor = xor_with;
 	stored->flags = flags;
-	oidread(&stored->oid, hash);
+	oidcpy(&stored->oid, oid);
 
 	hash_pos = kh_put_oid_map(index->bitmaps, stored->oid, &ret);
 
 	/* a 0 return code means the insertion succeeded with no changes,
 	 * because the SHA1 already existed on the map. this is bad, there
 	 * shouldn't be duplicated commits in the index */
 	if (ret == 0) {
-		error("Duplicate entry in bitmap index: %s", hash_to_hex(hash));
+		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
 		return NULL;
 	}
 
@@ -221,13 +221,13 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		struct ewah_bitmap *bitmap = NULL;
 		struct stored_bitmap *xor_bitmap = NULL;
 		uint32_t commit_idx_pos;
-		const unsigned char *sha1;
+		struct object_id oid;
 
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		sha1 = nth_packed_object_sha1(index->pack, commit_idx_pos);
+		nth_packed_object_id(&oid, index->pack, commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
@@ -244,7 +244,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		}
 
 		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
-			index, bitmap, sha1, xor_bitmap, flags);
+			index, bitmap, &oid, xor_bitmap, flags);
 	}
 
 	return 0;
-- 
2.25.1.823.g95c5488cf7


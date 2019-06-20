Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B65D1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfFTHli (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:45432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:38 -0400
Received: (qmail 16693 invoked by uid 109); 20 Jun 2019 07:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12944 invoked by uid 111); 20 Jun 2019 07:42:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:35 -0400
Date:   Thu, 20 Jun 2019 03:41:35 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 13/17] pack-bitmap: convert khash_sha1 maps into kh_oid_map
Message-ID: <20190620074135.GM3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the users of our khash_sha1 maps actually have a "struct
object_id". Let's use the more descriptive type.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap-write.c | 14 +++++++-------
 pack-bitmap.c       |  8 ++++----
 pack-bitmap.h       |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 0637378533..fa78a460c9 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -28,8 +28,8 @@ struct bitmap_writer {
 	struct ewah_bitmap *blobs;
 	struct ewah_bitmap *tags;
 
-	khash_sha1 *bitmaps;
-	khash_sha1 *reused;
+	kh_oid_map_t *bitmaps;
+	kh_oid_map_t *reused;
 	struct packing_data *to_pack;
 
 	struct bitmapped_commit *selected;
@@ -175,7 +175,7 @@ add_to_include_set(struct bitmap *base, struct commit *commit)
 	if (bitmap_get(base, bitmap_pos))
 		return 0;
 
-	hash_pos = kh_get_sha1(writer.bitmaps, commit->object.oid.hash);
+	hash_pos = kh_get_oid_map(writer.bitmaps, commit->object.oid);
 	if (hash_pos < kh_end(writer.bitmaps)) {
 		struct bitmapped_commit *bc = kh_value(writer.bitmaps, hash_pos);
 		bitmap_or_ewah(base, bc->bitmap);
@@ -256,7 +256,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	struct bitmap *base = bitmap_new();
 	struct rev_info revs;
 
-	writer.bitmaps = kh_init_sha1();
+	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
 
 	if (writer.show_progress)
@@ -311,7 +311,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		if (i >= reuse_after)
 			stored->flags |= BITMAP_FLAG_REUSE;
 
-		hash_pos = kh_put_sha1(writer.bitmaps, object->oid.hash, &hash_ret);
+		hash_pos = kh_put_oid_map(writer.bitmaps, object->oid, &hash_ret);
 		if (hash_ret == 0)
 			die("Duplicate entry when writing index: %s",
 			    oid_to_hex(&object->oid));
@@ -366,7 +366,7 @@ void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack)
 	if (!(bitmap_git = prepare_bitmap_git(to_pack->repo)))
 		return;
 
-	writer.reused = kh_init_sha1();
+	writer.reused = kh_init_oid_map();
 	rebuild_existing_bitmaps(bitmap_git, to_pack, writer.reused,
 				 writer.show_progress);
 	/*
@@ -382,7 +382,7 @@ static struct ewah_bitmap *find_reused_bitmap(const struct object_id *oid)
 	if (!writer.reused)
 		return NULL;
 
-	hash_pos = kh_get_sha1(writer.reused, oid->hash);
+	hash_pos = kh_get_oid_map(writer.reused, *oid);
 	if (hash_pos >= kh_end(writer.reused))
 		return NULL;
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 998133588f..ed2befaac6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1041,7 +1041,7 @@ static int rebuild_bitmap(uint32_t *reposition,
 
 int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 			     struct packing_data *mapping,
-			     khash_sha1 *reused_bitmaps,
+			     kh_oid_map_t *reused_bitmaps,
 			     int show_progress)
 {
 	uint32_t i, num_objects;
@@ -1080,9 +1080,9 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 			if (!rebuild_bitmap(reposition,
 					    lookup_stored_bitmap(stored),
 					    rebuild)) {
-				hash_pos = kh_put_sha1(reused_bitmaps,
-						       stored->oid.hash,
-						       &hash_ret);
+				hash_pos = kh_put_oid_map(reused_bitmaps,
+							  stored->oid,
+							  &hash_ret);
 				kh_value(reused_bitmaps, hash_pos) =
 					bitmap_to_ewah(rebuild);
 			}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ee9792264c..00de3ec8e4 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -51,7 +51,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
 				       uint32_t *entries, off_t *up_to);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
-			     khash_sha1 *reused_bitmaps, int show_progress);
+			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
 
 /*
-- 
2.22.0.732.g5402924b4b


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED011F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFTHlC (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:45254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:01 -0400
Received: (qmail 16459 invoked by uid 109); 20 Jun 2019 07:41:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12732 invoked by uid 111); 20 Jun 2019 07:41:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:41:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:40:59 -0400
Date:   Thu, 20 Jun 2019 03:40:59 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/17] pack-bitmap-write: convert some helpers to use
 object_id
Message-ID: <20190620074059.GC3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few functions take raw hash pointers, but all of their callers
actually have a "struct object_id". Let's retain that extra type as long
as possible (which will let future patches extend that further, and so
on).

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap-write.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 802ed62677..59aa201043 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -142,13 +142,13 @@ static inline void reset_all_seen(void)
 	seen_objects_nr = 0;
 }
 
-static uint32_t find_object_pos(const unsigned char *hash)
+static uint32_t find_object_pos(const struct object_id *oid)
 {
-	struct object_entry *entry = packlist_find(writer.to_pack, hash, NULL);
+	struct object_entry *entry = packlist_find(writer.to_pack, oid->hash, NULL);
 
 	if (!entry) {
 		die("Failed to write bitmap index. Packfile doesn't have full closure "
-			"(object %s is missing)", hash_to_hex(hash));
+			"(object %s is missing)", oid_to_hex(oid));
 	}
 
 	return oe_in_pack_pos(writer.to_pack, entry);
@@ -157,7 +157,7 @@ static uint32_t find_object_pos(const unsigned char *hash)
 static void show_object(struct object *object, const char *name, void *data)
 {
 	struct bitmap *base = data;
-	bitmap_set(base, find_object_pos(object->oid.hash));
+	bitmap_set(base, find_object_pos(&object->oid));
 	mark_as_seen(object);
 }
 
@@ -170,7 +170,7 @@ static int
 add_to_include_set(struct bitmap *base, struct commit *commit)
 {
 	khiter_t hash_pos;
-	uint32_t bitmap_pos = find_object_pos(commit->object.oid.hash);
+	uint32_t bitmap_pos = find_object_pos(&commit->object.oid);
 
 	if (bitmap_get(base, bitmap_pos))
 		return 0;
@@ -375,14 +375,14 @@ void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack)
 	 */
 }
 
-static struct ewah_bitmap *find_reused_bitmap(const unsigned char *sha1)
+static struct ewah_bitmap *find_reused_bitmap(const struct object_id *oid)
 {
 	khiter_t hash_pos;
 
 	if (!writer.reused)
 		return NULL;
 
-	hash_pos = kh_get_sha1(writer.reused, sha1);
+	hash_pos = kh_get_sha1(writer.reused, oid->hash);
 	if (hash_pos >= kh_end(writer.reused))
 		return NULL;
 
@@ -422,14 +422,14 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 		if (next == 0) {
 			chosen = indexed_commits[i];
-			reused_bitmap = find_reused_bitmap(chosen->object.oid.hash);
+			reused_bitmap = find_reused_bitmap(&chosen->object.oid);
 		} else {
 			chosen = indexed_commits[i + next];
 
 			for (j = 0; j <= next; ++j) {
 				struct commit *cm = indexed_commits[i + j];
 
-				reused_bitmap = find_reused_bitmap(cm->object.oid.hash);
+				reused_bitmap = find_reused_bitmap(&cm->object.oid);
 				if (reused_bitmap || (cm->object.flags & NEEDS_BITMAP) != 0) {
 					chosen = cm;
 					break;
-- 
2.22.0.732.g5402924b4b


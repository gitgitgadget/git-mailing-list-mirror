Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60EF31F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfFTHle (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:45404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHle (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:34 -0400
Received: (qmail 16665 invoked by uid 109); 20 Jun 2019 07:41:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12907 invoked by uid 111); 20 Jun 2019 07:42:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:32 -0400
Date:   Thu, 20 Jun 2019 03:41:32 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/17] delta-islands: convert island_marks khash to use oids
Message-ID: <20190620074131.GL3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the users of this map have an actual "struct object_id" rather
than a bare sha1. Let's use the more descriptive type (and get one step
closer to dropping khash_sha1 entirely).

Signed-off-by: Jeff King <peff@peff.net>
---
 delta-islands.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/delta-islands.c b/delta-islands.c
index 5f3ab914f5..88d102298c 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -22,7 +22,7 @@
 
 KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
 
-static khash_sha1 *island_marks;
+static kh_oid_map_t *island_marks;
 static unsigned island_counter;
 static unsigned island_counter_core;
 
@@ -105,7 +105,7 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
 	 * If we don't have a bitmap for the target, we can delta it
 	 * against anything -- it's not an important object
 	 */
-	trg_pos = kh_get_sha1(island_marks, trg_oid->hash);
+	trg_pos = kh_get_oid_map(island_marks, *trg_oid);
 	if (trg_pos >= kh_end(island_marks))
 		return 1;
 
@@ -113,7 +113,7 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
 	 * if the source (our delta base) doesn't have a bitmap,
 	 * we don't want to base any deltas on it!
 	 */
-	src_pos = kh_get_sha1(island_marks, src_oid->hash);
+	src_pos = kh_get_oid_map(island_marks, *src_oid);
 	if (src_pos >= kh_end(island_marks))
 		return 0;
 
@@ -129,11 +129,11 @@ int island_delta_cmp(const struct object_id *a, const struct object_id *b)
 	if (!island_marks)
 		return 0;
 
-	a_pos = kh_get_sha1(island_marks, a->hash);
+	a_pos = kh_get_oid_map(island_marks, *a);
 	if (a_pos < kh_end(island_marks))
 		a_bitmap = kh_value(island_marks, a_pos);
 
-	b_pos = kh_get_sha1(island_marks, b->hash);
+	b_pos = kh_get_oid_map(island_marks, *b);
 	if (b_pos < kh_end(island_marks))
 		b_bitmap = kh_value(island_marks, b_pos);
 
@@ -154,7 +154,7 @@ static struct island_bitmap *create_or_get_island_marks(struct object *obj)
 	khiter_t pos;
 	int hash_ret;
 
-	pos = kh_put_sha1(island_marks, obj->oid.hash, &hash_ret);
+	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);
 	if (hash_ret)
 		kh_value(island_marks, pos) = island_bitmap_new(NULL);
 
@@ -167,7 +167,7 @@ static void set_island_marks(struct object *obj, struct island_bitmap *marks)
 	khiter_t pos;
 	int hash_ret;
 
-	pos = kh_put_sha1(island_marks, obj->oid.hash, &hash_ret);
+	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);
 	if (hash_ret) {
 		/*
 		 * We don't have one yet; make a copy-on-write of the
@@ -279,7 +279,7 @@ void resolve_tree_islands(struct repository *r,
 		struct name_entry entry;
 		khiter_t pos;
 
-		pos = kh_get_sha1(island_marks, ent->idx.oid.hash);
+		pos = kh_get_oid_map(island_marks, ent->idx.oid);
 		if (pos >= kh_end(island_marks))
 			continue;
 
@@ -456,7 +456,7 @@ static void deduplicate_islands(struct repository *r)
 
 void load_delta_islands(struct repository *r)
 {
-	island_marks = kh_init_sha1();
+	island_marks = kh_init_oid_map();
 	remote_islands = kh_init_str();
 
 	git_config(island_config_callback, NULL);
@@ -468,7 +468,7 @@ void load_delta_islands(struct repository *r)
 
 void propagate_island_marks(struct commit *commit)
 {
-	khiter_t pos = kh_get_sha1(island_marks, commit->object.oid.hash);
+	khiter_t pos = kh_get_oid_map(island_marks, commit->object.oid);
 
 	if (pos < kh_end(island_marks)) {
 		struct commit_list *p;
@@ -490,7 +490,7 @@ int compute_pack_layers(struct packing_data *to_pack)
 
 	for (i = 0; i < to_pack->nr_objects; ++i) {
 		struct object_entry *entry = &to_pack->objects[i];
-		khiter_t pos = kh_get_sha1(island_marks, entry->idx.oid.hash);
+		khiter_t pos = kh_get_oid_map(island_marks, entry->idx.oid);
 
 		oe_set_layer(to_pack, entry, 1);
 
-- 
2.22.0.732.g5402924b4b


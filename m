Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41141F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFTHlG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:45270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHlF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:05 -0400
Received: (qmail 16479 invoked by uid 109); 20 Jun 2019 07:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12741 invoked by uid 111); 20 Jun 2019 07:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:41:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:03 -0400
Date:   Thu, 20 Jun 2019 03:41:03 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/17] pack-objects: convert packlist_find() to use object_id
Message-ID: <20190620074103.GD3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We take a raw hash pointer, but most of our callers have a "struct
object_id" already. Let's switch to taking the full struct, which will
let us continue removing uses of raw sha1 buffers.

There are two callers that do need special attention:

  - in rebuild_existing_bitmaps(), we need to switch to
    nth_packed_object_oid(). This incurs an extra hash copy over
    pointing straight to the mmap'd sha1, but it shouldn't be measurable
    compared to the rest of the operation.

  - in can_reuse_delta() we already spent the effort to copy the sha1
    into a "struct object_id", but now we just have to do so a little
    earlier in the function (we can't easily convert that function's
    callers because they may be pointing at mmap'd REF_DELTA blocks).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 19 ++++++++++---------
 pack-bitmap-write.c    |  2 +-
 pack-bitmap.c          |  6 +++---
 pack-objects.c         |  4 ++--
 pack-objects.h         |  2 +-
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b2be8869c2..c95693fd4b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -606,12 +606,12 @@ static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 		       void *cb_data)
 {
 	struct object_id peeled;
-	struct object_entry *entry = packlist_find(&to_pack, oid->hash, NULL);
+	struct object_entry *entry = packlist_find(&to_pack, oid, NULL);
 
 	if (entry)
 		entry->tagged = 1;
 	if (!peel_ref(path, &peeled)) {
-		entry = packlist_find(&to_pack, peeled.hash, NULL);
+		entry = packlist_find(&to_pack, &peeled, NULL);
 		if (entry)
 			entry->tagged = 1;
 	}
@@ -996,7 +996,7 @@ static int have_duplicate_entry(const struct object_id *oid,
 {
 	struct object_entry *entry;
 
-	entry = packlist_find(&to_pack, oid->hash, index_pos);
+	entry = packlist_find(&to_pack, oid, index_pos);
 	if (!entry)
 		return 0;
 
@@ -1494,11 +1494,13 @@ static int can_reuse_delta(const unsigned char *base_sha1,
 	if (!base_sha1)
 		return 0;
 
+	oidread(&base_oid, base_sha1);
+
 	/*
 	 * First see if we're already sending the base (or it's explicitly in
 	 * our "excluded" list).
 	 */
-	base = packlist_find(&to_pack, base_sha1, NULL);
+	base = packlist_find(&to_pack, &base_oid, NULL);
 	if (base) {
 		if (!in_same_island(&delta->idx.oid, &base->idx.oid))
 			return 0;
@@ -1511,7 +1513,6 @@ static int can_reuse_delta(const unsigned char *base_sha1,
 	 * even if it was buried too deep in history to make it into the
 	 * packing list.
 	 */
-	oidread(&base_oid, base_sha1);
 	if (thin && bitmap_has_oid_in_uninteresting(bitmap_git, &base_oid)) {
 		if (use_delta_islands) {
 			if (!in_same_island(&delta->idx.oid, &base_oid))
@@ -2571,7 +2572,7 @@ static void add_tag_chain(const struct object_id *oid)
 	 * it was included via bitmaps, we would not have parsed it
 	 * previously).
 	 */
-	if (packlist_find(&to_pack, oid->hash, NULL))
+	if (packlist_find(&to_pack, oid, NULL))
 		return;
 
 	tag = lookup_tag(the_repository, oid);
@@ -2595,7 +2596,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, &peeled)    && /* peelable? */
-	    packlist_find(&to_pack, peeled.hash, NULL))      /* object packed? */
+	    packlist_find(&to_pack, &peeled, NULL))      /* object packed? */
 		add_tag_chain(oid);
 	return 0;
 }
@@ -2795,7 +2796,7 @@ static void show_object(struct object *obj, const char *name, void *data)
 		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
 			depth++;
 
-		ent = packlist_find(&to_pack, obj->oid.hash, NULL);
+		ent = packlist_find(&to_pack, &obj->oid, NULL);
 		if (ent && depth > oe_tree_depth(&to_pack, ent))
 			oe_set_tree_depth(&to_pack, ent, depth);
 	}
@@ -3026,7 +3027,7 @@ static void loosen_unused_packed_objects(void)
 
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_oid(&oid, p, i);
-			if (!packlist_find(&to_pack, oid.hash, NULL) &&
+			if (!packlist_find(&to_pack, &oid, NULL) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime))
 				if (force_object_loose(&oid, p->mtime))
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 59aa201043..0637378533 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -144,7 +144,7 @@ static inline void reset_all_seen(void)
 
 static uint32_t find_object_pos(const struct object_id *oid)
 {
-	struct object_entry *entry = packlist_find(writer.to_pack, oid->hash, NULL);
+	struct object_entry *entry = packlist_find(writer.to_pack, oid, NULL);
 
 	if (!entry) {
 		die("Failed to write bitmap index. Packfile doesn't have full closure "
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6069b2fe55..ff1f07e249 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1057,13 +1057,13 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 	reposition = xcalloc(num_objects, sizeof(uint32_t));
 
 	for (i = 0; i < num_objects; ++i) {
-		const unsigned char *sha1;
+		struct object_id oid;
 		struct revindex_entry *entry;
 		struct object_entry *oe;
 
 		entry = &bitmap_git->pack->revindex[i];
-		sha1 = nth_packed_object_sha1(bitmap_git->pack, entry->nr);
-		oe = packlist_find(mapping, sha1, NULL);
+		nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
+		oe = packlist_find(mapping, &oid, NULL);
 
 		if (oe)
 			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
diff --git a/pack-objects.c b/pack-objects.c
index ce33b8906e..49fdf52ea6 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -68,7 +68,7 @@ static void rehash_objects(struct packing_data *pdata)
 }
 
 struct object_entry *packlist_find(struct packing_data *pdata,
-				   const unsigned char *sha1,
+				   const struct object_id *oid,
 				   uint32_t *index_pos)
 {
 	uint32_t i;
@@ -77,7 +77,7 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 	if (!pdata->index_size)
 		return NULL;
 
-	i = locate_object_entry_hash(pdata, sha1, &found);
+	i = locate_object_entry_hash(pdata, oid->hash, &found);
 
 	if (index_pos)
 		*index_pos = i;
diff --git a/pack-objects.h b/pack-objects.h
index 6fde7ce27c..857d43850b 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -187,7 +187,7 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    uint32_t index_pos);
 
 struct object_entry *packlist_find(struct packing_data *pdata,
-				   const unsigned char *sha1,
+				   const struct object_id *oid,
 				   uint32_t *index_pos);
 
 static inline uint32_t pack_name_hash(const char *name)
-- 
2.22.0.732.g5402924b4b


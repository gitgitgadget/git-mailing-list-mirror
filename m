Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8791C35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAD820658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgBXE1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:27:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:52290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727188AbgBXE1i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:27:38 -0500
Received: (qmail 5166 invoked by uid 109); 24 Feb 2020 04:27:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:27:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6848 invoked by uid 111); 24 Feb 2020 04:36:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:36:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:27:36 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 01/10] nth_packed_object_oid(): use customary integer return
Message-ID: <20200224042736.GA1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our nth_packed_object_sha1() function returns NULL for error. So when we
wrapped it with nth_packed_object_oid(), we kept the same semantics. But
it's a bit funny, because the caller actually passes in an out
parameter, and the pointer we return is just that same struct they
passed to us (or NULL).

It's not too terrible, but it does make the interface a little
non-idiomatic. Let's switch to our usual "0 for success, negative for
error" return value. Most callers either don't check it, or are
trivially converted. The one that requires the biggest change is
actually improved, as we can ditch an extra aliased pointer variable.

Since we are changing the interface in a subtle way that the compiler
wouldn't catch, let's also change the name to catch any topics in
flight. We can drop the 'o' and make it nth_packed_object_id(). That's
slightly shorter, but also less redundant since the 'o' stands for
"object" already.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c |  4 ++--
 midx.c                 |  2 +-
 pack-bitmap.c          |  4 ++--
 packfile.c             | 18 +++++++++---------
 packfile.h             |  5 ++---
 sha1-name.c            | 13 ++++++-------
 6 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 940fbcb7b3..de8335e2bd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3053,7 +3053,7 @@ static void add_objects_in_unpacked_packs(void)
 			   in_pack.alloc);
 
 		for (i = 0; i < p->num_objects; i++) {
-			nth_packed_object_oid(&oid, p, i);
+			nth_packed_object_id(&oid, p, i);
 			o = lookup_unknown_object(&oid);
 			if (!(o->flags & OBJECT_ADDED))
 				mark_in_pack_object(o, p, &in_pack);
@@ -3157,7 +3157,7 @@ static void loosen_unused_packed_objects(void)
 			die(_("cannot open pack index"));
 
 		for (i = 0; i < p->num_objects; i++) {
-			nth_packed_object_oid(&oid, p, i);
+			nth_packed_object_id(&oid, p, i);
 			if (!packlist_find(&to_pack, &oid) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime))
diff --git a/midx.c b/midx.c
index 37ec28623a..1527e464a7 100644
--- a/midx.c
+++ b/midx.c
@@ -534,7 +534,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
 			    uint32_t cur_object,
 			    struct pack_midx_entry *entry)
 {
-	if (!nth_packed_object_oid(&entry->oid, p, cur_object))
+	if (nth_packed_object_id(&entry->oid, p, cur_object) < 0)
 		die(_("failed to locate object %d in packfile"), cur_object);
 
 	entry->pack_int_id = pack_int_id;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5a8689cdf8..c81d323329 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -658,7 +658,7 @@ static void show_objects_for_type(
 			offset += ewah_bit_ctz64(word >> offset);
 
 			entry = &bitmap_git->pack->revindex[pos + offset];
-			nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
+			nth_packed_object_id(&oid, bitmap_git->pack, entry->nr);
 
 			if (bitmap_git->hashes)
 				hash = get_be32(bitmap_git->hashes + entry->nr);
@@ -1136,7 +1136,7 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 		struct object_entry *oe;
 
 		entry = &bitmap_git->pack->revindex[i];
-		nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
+		nth_packed_object_id(&oid, bitmap_git->pack, entry->nr);
 		oe = packlist_find(mapping, &oid);
 
 		if (oe)
diff --git a/packfile.c b/packfile.c
index 99dd1a7d09..947c3f8e5d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1261,7 +1261,7 @@ static int retry_bad_packed_offset(struct repository *r,
 	revidx = find_pack_revindex(p, obj_offset);
 	if (!revidx)
 		return OBJ_BAD;
-	nth_packed_object_oid(&oid, p, revidx->nr);
+	nth_packed_object_id(&oid, p, revidx->nr);
 	mark_bad_packed_object(p, oid.hash);
 	type = oid_object_info(r, &oid, NULL);
 	if (type <= OBJ_NONE)
@@ -1693,7 +1693,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			off_t len = revidx[1].offset - obj_offset;
 			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
 				struct object_id oid;
-				nth_packed_object_oid(&oid, p, revidx->nr);
+				nth_packed_object_id(&oid, p, revidx->nr);
 				error("bad packed object CRC for %s",
 				      oid_to_hex(&oid));
 				mark_bad_packed_object(p, oid.hash);
@@ -1782,7 +1782,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			struct object_id base_oid;
 			revidx = find_pack_revindex(p, obj_offset);
 			if (revidx) {
-				nth_packed_object_oid(&base_oid, p, revidx->nr);
+				nth_packed_object_id(&base_oid, p, revidx->nr);
 				error("failed to read delta base object %s"
 				      " at offset %"PRIuMAX" from %s",
 				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
@@ -1890,15 +1890,15 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 	}
 }
 
-const struct object_id *nth_packed_object_oid(struct object_id *oid,
-					      struct packed_git *p,
-					      uint32_t n)
+int nth_packed_object_id(struct object_id *oid,
+			 struct packed_git *p,
+			 uint32_t n)
 {
 	const unsigned char *hash = nth_packed_object_sha1(p, n);
 	if (!hash)
-		return NULL;
+		return -1;
 	hashcpy(oid->hash, hash);
-	return oid;
+	return 0;
 }
 
 void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
@@ -2077,7 +2077,7 @@ int for_each_object_in_pack(struct packed_git *p,
 		else
 			pos = i;
 
-		if (!nth_packed_object_oid(&oid, p, pos))
+		if (nth_packed_object_id(&oid, p, pos) < 0)
 			return error("unable to get sha1 of object %u in %s",
 				     pos, p->pack_name);
 
diff --git a/packfile.h b/packfile.h
index ec536a4ae5..95b83ba25b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -129,10 +129,9 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
 /*
  * Like nth_packed_object_sha1, but write the data into the object specified by
- * the the first argument.  Returns the first argument on success, and NULL on
- * error.
+ * the the first argument.  Returns 0 on success, negative otherwise.
  */
-const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
+int nth_packed_object_id(struct object_id *, struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
diff --git a/sha1-name.c b/sha1-name.c
index f2e24ea666..5bb006e5a9 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -155,7 +155,6 @@ static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
 	uint32_t num, i, first = 0;
-	const struct object_id *current = NULL;
 
 	if (p->multi_pack_index)
 		return;
@@ -173,10 +172,10 @@ static void unique_in_pack(struct packed_git *p,
 	 */
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
-		current = nth_packed_object_oid(&oid, p, i);
-		if (!match_sha(ds->len, ds->bin_pfx.hash, current->hash))
+		nth_packed_object_id(&oid, p, i);
+		if (!match_sha(ds->len, ds->bin_pfx.hash, oid.hash))
 			break;
-		update_candidates(ds, current);
+		update_candidates(ds, &oid);
 	}
 }
 
@@ -643,14 +642,14 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	 */
 	mad->init_len = 0;
 	if (!match) {
-		if (nth_packed_object_oid(&oid, p, first))
+		if (!nth_packed_object_id(&oid, p, first))
 			extend_abbrev_len(&oid, mad);
 	} else if (first < num - 1) {
-		if (nth_packed_object_oid(&oid, p, first + 1))
+		if (!nth_packed_object_id(&oid, p, first + 1))
 			extend_abbrev_len(&oid, mad);
 	}
 	if (first > 0) {
-		if (nth_packed_object_oid(&oid, p, first - 1))
+		if (!nth_packed_object_id(&oid, p, first - 1))
 			extend_abbrev_len(&oid, mad);
 	}
 	mad->init_len = mad->cur_len;
-- 
2.25.1.823.g95c5488cf7


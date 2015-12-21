From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pack-revindex: store entries directly in packed_git
Date: Mon, 21 Dec 2015 01:20:33 -0500
Message-ID: <20151221062033.GA2819@sigill.intra.peff.net>
References: <20151221061948.GA25763@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 07:20:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAtpo-0001Ry-En
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 07:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbbLUGUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 01:20:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:44791 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750931AbbLUGUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 01:20:36 -0500
Received: (qmail 29392 invoked by uid 102); 21 Dec 2015 06:20:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 00:20:36 -0600
Received: (qmail 18351 invoked by uid 107); 21 Dec 2015 06:20:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 01:20:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Dec 2015 01:20:33 -0500
Content-Disposition: inline
In-Reply-To: <20151221061948.GA25763@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282784>

A pack_revindex struct has two elements: the revindex
entries themselves, and a pointer to the packed_git. We need
both to do lookups, because only the latter knows things
like the number of objects in the pack.

Now that packed_git contains the pack_revindex struct it's
just as easy to pass around the packed_git itself, and we do
not need the extra back-pointer.

We can instead just store the entries directly in the pack.
All functions which took a pack_revindex now just take a
packed_git. We still lazy-load in find_pack_revindex, so
most callers are unaffected.

The exception is the bitmap code, which computes the
revindex and caches the pointer when we load the bitmaps. We
can continue to load, drop the extra cache pointer, and just
access bitmap_git.pack.revindex directly.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is optional, but I think it is a nice cleanup on top of 1/2.

 cache.h         |  2 +-
 pack-bitmap.c   | 13 +++++--------
 pack-revindex.c | 47 ++++++++++++++++++++++-------------------------
 pack-revindex.h | 11 ++++-------
 4 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/cache.h b/cache.h
index de4ef88..565937e 100644
--- a/cache.h
+++ b/cache.h
@@ -1299,7 +1299,7 @@ extern struct packed_git {
 		 freshened:1,
 		 do_not_close:1;
 	unsigned char sha1[20];
-	struct pack_revindex reverse_index;
+	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index cb9c622..dd8dc16 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -33,9 +33,6 @@ static struct bitmap_index {
 	/* Packfile to which this bitmap index belongs to */
 	struct packed_git *pack;
 
-	/* reverse index for the packfile */
-	struct pack_revindex *reverse_index;
-
 	/*
 	 * Mark the first `reuse_objects` in the packfile as reused:
 	 * they will be sent as-is without using them for repacking
@@ -308,7 +305,7 @@ static int load_pack_bitmap(void)
 
 	bitmap_git.bitmaps = kh_init_sha1();
 	bitmap_git.ext_index.positions = kh_init_sha1_pos();
-	bitmap_git.reverse_index = revindex_for_pack(bitmap_git.pack);
+	load_pack_revindex(bitmap_git.pack);
 
 	if (!(bitmap_git.commits = read_bitmap_1(&bitmap_git)) ||
 		!(bitmap_git.trees = read_bitmap_1(&bitmap_git)) ||
@@ -380,7 +377,7 @@ static inline int bitmap_position_packfile(const unsigned char *sha1)
 	if (!offset)
 		return -1;
 
-	return find_revindex_position(bitmap_git.reverse_index, offset);
+	return find_revindex_position(bitmap_git.pack, offset);
 }
 
 static int bitmap_position(const unsigned char *sha1)
@@ -630,7 +627,7 @@ static void show_objects_for_type(
 			if (pos + offset < bitmap_git.reuse_objects)
 				continue;
 
-			entry = &bitmap_git.reverse_index->revindex[pos + offset];
+			entry = &bitmap_git.pack->revindex[pos + offset];
 			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
 
 			if (bitmap_git.hashes)
@@ -804,7 +801,7 @@ int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
 		return -1;
 
 	bitmap_git.reuse_objects = *entries = reuse_objects;
-	*up_to = bitmap_git.reverse_index->revindex[reuse_objects].offset;
+	*up_to = bitmap_git.pack->revindex[reuse_objects].offset;
 	*packfile = bitmap_git.pack;
 
 	return 0;
@@ -1038,7 +1035,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		struct revindex_entry *entry;
 		struct object_entry *oe;
 
-		entry = &bitmap_git.reverse_index->revindex[i];
+		entry = &bitmap_git.pack->revindex[i];
 		sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
 		oe = packlist_find(mapping, sha1, NULL);
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 8e63dbc..155a8a3 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -115,14 +115,13 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 /*
  * Ordered list of offsets of objects in the pack.
  */
-static void create_pack_revindex(struct pack_revindex *rix)
+static void create_pack_revindex(struct packed_git *p)
 {
-	struct packed_git *p = rix->p;
 	unsigned num_ent = p->num_objects;
 	unsigned i;
 	const char *index = p->index_data;
 
-	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
+	p->revindex = xmalloc(sizeof(*p->revindex) * (num_ent + 1));
 	index += 4 * 256;
 
 	if (p->index_version > 1) {
@@ -132,46 +131,42 @@ static void create_pack_revindex(struct pack_revindex *rix)
 		for (i = 0; i < num_ent; i++) {
 			uint32_t off = ntohl(*off_32++);
 			if (!(off & 0x80000000)) {
-				rix->revindex[i].offset = off;
+				p->revindex[i].offset = off;
 			} else {
-				rix->revindex[i].offset =
+				p->revindex[i].offset =
 					((uint64_t)ntohl(*off_64++)) << 32;
-				rix->revindex[i].offset |=
+				p->revindex[i].offset |=
 					ntohl(*off_64++);
 			}
-			rix->revindex[i].nr = i;
+			p->revindex[i].nr = i;
 		}
 	} else {
 		for (i = 0; i < num_ent; i++) {
 			uint32_t hl = *((uint32_t *)(index + 24 * i));
-			rix->revindex[i].offset = ntohl(hl);
-			rix->revindex[i].nr = i;
+			p->revindex[i].offset = ntohl(hl);
+			p->revindex[i].nr = i;
 		}
 	}
 
 	/* This knows the pack format -- the 20-byte trailer
 	 * follows immediately after the last object data.
 	 */
-	rix->revindex[num_ent].offset = p->pack_size - 20;
-	rix->revindex[num_ent].nr = -1;
-	sort_revindex(rix->revindex, num_ent, p->pack_size);
+	p->revindex[num_ent].offset = p->pack_size - 20;
+	p->revindex[num_ent].nr = -1;
+	sort_revindex(p->revindex, num_ent, p->pack_size);
 }
 
-struct pack_revindex *revindex_for_pack(struct packed_git *p)
+void load_pack_revindex(struct packed_git *p)
 {
-	struct pack_revindex *rix = &p->reverse_index;
-	if (!rix->revindex) {
-		rix->p = p;
-		create_pack_revindex(rix);
-	}
-	return rix;
+	if (!p->revindex)
+		create_pack_revindex(p);
 }
 
-int find_revindex_position(struct pack_revindex *pridx, off_t ofs)
+int find_revindex_position(struct packed_git *p, off_t ofs)
 {
 	int lo = 0;
-	int hi = pridx->p->num_objects + 1;
-	struct revindex_entry *revindex = pridx->revindex;
+	int hi = p->num_objects + 1;
+	struct revindex_entry *revindex = p->revindex;
 
 	do {
 		unsigned mi = lo + (hi - lo) / 2;
@@ -189,11 +184,13 @@ int find_revindex_position(struct pack_revindex *pridx, off_t ofs)
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 {
-	struct pack_revindex *pridx = revindex_for_pack(p);
-	int pos = find_revindex_position(pridx, ofs);
+	int pos;
+
+	load_pack_revindex(p);
+	pos = find_revindex_position(p, ofs);
 
 	if (pos < 0)
 		return NULL;
 
-	return pridx->revindex + pos;
+	return p->revindex + pos;
 }
diff --git a/pack-revindex.h b/pack-revindex.h
index d737f98..e262f3e 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -1,18 +1,15 @@
 #ifndef PACK_REVINDEX_H
 #define PACK_REVINDEX_H
 
+struct packed_git;
+
 struct revindex_entry {
 	off_t offset;
 	unsigned int nr;
 };
 
-struct pack_revindex {
-	struct packed_git *p;
-	struct revindex_entry *revindex;
-};
-
-struct pack_revindex *revindex_for_pack(struct packed_git *p);
-int find_revindex_position(struct pack_revindex *pridx, off_t ofs);
+void load_pack_revindex(struct packed_git *p);
+int find_revindex_position(struct packed_git *p, off_t ofs);
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
 
-- 
2.7.0.rc1.350.g9acc0f4

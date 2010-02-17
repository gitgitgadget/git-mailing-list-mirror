From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 1/6] fast-import: start using struct pack_idx_entry
Date: Wed, 17 Feb 2010 14:05:51 -0500
Message-ID: <1266433556-1987-2-git-send-email-nico@fluxnic.net>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpDv-0004rj-1m
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab0BQTGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:06:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0BQTGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:06:02 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000GRF2DZ9K50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 14:06:00 -0500 (EST)
X-Mailer: git-send-email 1.7.0.23.gf5ef4
In-reply-to: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140247>

This is in preparation for using write_idx_file().

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 fast-import.c |   57 ++++++++++++++++++++++++++++-----------------------------
 1 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b477dc6..c29737e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -164,12 +164,11 @@ Format of STDIN stream:
 
 struct object_entry
 {
+	struct pack_idx_entry idx;
 	struct object_entry *next;
-	uint32_t offset;
 	uint32_t type : TYPE_BITS,
 		pack_id : PACK_ID_BITS,
 		depth : DEPTH_BITS;
-	unsigned char sha1[20];
 };
 
 struct object_entry_pool
@@ -521,7 +520,7 @@ static struct object_entry *new_object(unsigned char *sha1)
 		alloc_objects(object_entry_alloc);
 
 	e = blocks->next_free++;
-	hashcpy(e->sha1, sha1);
+	hashcpy(e->idx.sha1, sha1);
 	return e;
 }
 
@@ -530,7 +529,7 @@ static struct object_entry *find_object(unsigned char *sha1)
 	unsigned int h = sha1[0] << 8 | sha1[1];
 	struct object_entry *e;
 	for (e = object_table[h]; e; e = e->next)
-		if (!hashcmp(sha1, e->sha1))
+		if (!hashcmp(sha1, e->idx.sha1))
 			return e;
 	return NULL;
 }
@@ -542,7 +541,7 @@ static struct object_entry *insert_object(unsigned char *sha1)
 	struct object_entry *p = NULL;
 
 	while (e) {
-		if (!hashcmp(sha1, e->sha1))
+		if (!hashcmp(sha1, e->idx.sha1))
 			return e;
 		p = e;
 		e = e->next;
@@ -550,7 +549,7 @@ static struct object_entry *insert_object(unsigned char *sha1)
 
 	e = new_object(sha1);
 	e->next = NULL;
-	e->offset = 0;
+	e->idx.offset = 0;
 	if (p)
 		p->next = e;
 	else
@@ -857,7 +856,7 @@ static int oecmp (const void *a_, const void *b_)
 {
 	struct object_entry *a = *((struct object_entry**)a_);
 	struct object_entry *b = *((struct object_entry**)b_);
-	return hashcmp(a->sha1, b->sha1);
+	return hashcmp(a->idx.sha1, b->idx.sha1);
 }
 
 static char *create_index(void)
@@ -887,7 +886,7 @@ static char *create_index(void)
 	for (i = 0; i < 256; i++) {
 		struct object_entry **next = c;
 		while (next < last) {
-			if ((*next)->sha1[0] != i)
+			if ((*next)->idx.sha1[0] != i)
 				break;
 			next++;
 		}
@@ -901,10 +900,10 @@ static char *create_index(void)
 	sha1write(f, array, 256 * sizeof(int));
 	git_SHA1_Init(&ctx);
 	for (c = idx; c != last; c++) {
-		uint32_t offset = htonl((*c)->offset);
+		uint32_t offset = htonl((*c)->idx.offset);
 		sha1write(f, &offset, 4);
-		sha1write(f, (*c)->sha1, sizeof((*c)->sha1));
-		git_SHA1_Update(&ctx, (*c)->sha1, 20);
+		sha1write(f, (*c)->idx.sha1, sizeof((*c)->idx.sha1));
+		git_SHA1_Update(&ctx, (*c)->idx.sha1, 20);
 	}
 	sha1write(f, pack_data->sha1, sizeof(pack_data->sha1));
 	sha1close(f, NULL, CSUM_FSYNC);
@@ -1063,13 +1062,13 @@ static int store_object(
 	e = insert_object(sha1);
 	if (mark)
 		insert_mark(mark, e);
-	if (e->offset) {
+	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
 	} else if (find_sha1_pack(sha1, packed_git)) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
-		e->offset = 1; /* just not zero! */
+		e->idx.offset = 1; /* just not zero! */
 		duplicate_count_by_type[type]++;
 		return 1;
 	}
@@ -1127,12 +1126,12 @@ static int store_object(
 
 	e->type = type;
 	e->pack_id = pack_id;
-	e->offset = pack_size;
+	e->idx.offset = pack_size;
 	object_count++;
 	object_count_by_type[type]++;
 
 	if (delta) {
-		unsigned long ofs = e->offset - last->offset;
+		unsigned long ofs = e->idx.offset - last->offset;
 		unsigned pos = sizeof(hdr) - 1;
 
 		delta_count_by_type[type]++;
@@ -1165,7 +1164,7 @@ static int store_object(
 		} else {
 			strbuf_swap(&last->data, dat);
 		}
-		last->offset = e->offset;
+		last->offset = e->idx.offset;
 		last->depth = e->depth;
 	}
 	return 0;
@@ -1259,14 +1258,14 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	if (mark)
 		insert_mark(mark, e);
 
-	if (e->offset) {
+	if (e->idx.offset) {
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(offset);
 
 	} else if (find_sha1_pack(sha1, packed_git)) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
-		e->offset = 1; /* just not zero! */
+		e->idx.offset = 1; /* just not zero! */
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(offset);
 
@@ -1274,7 +1273,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		e->depth = 0;
 		e->type = OBJ_BLOB;
 		e->pack_id = pack_id;
-		e->offset = offset;
+		e->idx.offset = offset;
 		object_count++;
 		object_count_by_type[OBJ_BLOB]++;
 	}
@@ -1326,7 +1325,7 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size = pack_size + 20;
 	}
-	return unpack_entry(p, oe->offset, &type, sizep);
+	return unpack_entry(p, oe->idx.offset, &type, sizep);
 }
 
 static const char *get_mode(const char *str, uint16_t *modep)
@@ -1457,7 +1456,7 @@ static void store_tree(struct tree_entry *root)
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
-		lo.offset = le->offset;
+		lo.offset = le->idx.offset;
 		lo.depth = t->delta_depth;
 	}
 
@@ -1715,7 +1714,7 @@ static void dump_marks_helper(FILE *f,
 		for (k = 0; k < 1024; k++) {
 			if (m->data.marked[k])
 				fprintf(f, ":%" PRIuMAX " %s\n", base + k,
-					sha1_to_hex(m->data.marked[k]->sha1));
+					sha1_to_hex(m->data.marked[k]->idx.sha1));
 		}
 	}
 }
@@ -1798,7 +1797,7 @@ static void read_marks(void)
 			e = insert_object(sha1);
 			e->type = type;
 			e->pack_id = MAX_PACK_ID;
-			e->offset = 1; /* just not zero! */
+			e->idx.offset = 1; /* just not zero! */
 		}
 		insert_mark(mark, e);
 	}
@@ -2183,7 +2182,7 @@ static void file_change_m(struct branch *b)
 	if (*p == ':') {
 		char *x;
 		oe = find_mark(strtoumax(p + 1, &x, 10));
-		hashcpy(sha1, oe->sha1);
+		hashcpy(sha1, oe->idx.sha1);
 		p = x;
 	} else if (!prefixcmp(p, "inline")) {
 		inline_data = 1;
@@ -2316,7 +2315,7 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 	if (*p == ':') {
 		char *x;
 		oe = find_mark(strtoumax(p + 1, &x, 10));
-		hashcpy(sha1, oe->sha1);
+		hashcpy(sha1, oe->idx.sha1);
 		p = x;
 	} else if (!prefixcmp(p, "inline")) {
 		inline_data = 1;
@@ -2339,7 +2338,7 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 		struct object_entry *commit_oe = find_mark(commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
-		hashcpy(commit_sha1, commit_oe->sha1);
+		hashcpy(commit_sha1, commit_oe->idx.sha1);
 	} else if (!get_sha1(p, commit_sha1)) {
 		unsigned long size;
 		char *buf = read_object_with_reference(commit_sha1,
@@ -2446,7 +2445,7 @@ static int parse_from(struct branch *b)
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
-		hashcpy(b->sha1, oe->sha1);
+		hashcpy(b->sha1, oe->idx.sha1);
 		if (oe->pack_id != MAX_PACK_ID) {
 			unsigned long size;
 			char *buf = gfi_unpack_entry(oe, &size);
@@ -2481,7 +2480,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
-			hashcpy(n->sha1, oe->sha1);
+			hashcpy(n->sha1, oe->idx.sha1);
 		} else if (!get_sha1(from, n->sha1)) {
 			unsigned long size;
 			char *buf = read_object_with_reference(n->sha1,
@@ -2639,7 +2638,7 @@ static void parse_new_tag(void)
 		from_mark = strtoumax(from + 1, NULL, 10);
 		oe = find_mark(from_mark);
 		type = oe->type;
-		hashcpy(sha1, oe->sha1);
+		hashcpy(sha1, oe->idx.sha1);
 	} else if (!get_sha1(from, sha1)) {
 		unsigned long size;
 		char *buf;
-- 
1.7.0.23.gf5ef4

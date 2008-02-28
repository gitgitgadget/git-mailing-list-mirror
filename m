From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/4] factorize revindex code out of builtin-pack-objects.c
Date: Thu, 28 Feb 2008 00:25:17 -0500
Message-ID: <1204176320-31358-2-git-send-email-nico@cam.org>
References: <1204176320-31358-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 06:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUbHN-0004Z9-91
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 06:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbYB1FZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 00:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbYB1FZY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 00:25:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYB1FZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 00:25:22 -0500
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWX00B63OE9QT70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Feb 2008 00:25:22 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.200.g99e75
In-reply-to: <1204176320-31358-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75355>

No functional change. This is needed to fix verify-pack in a later patch.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Makefile               |    5 +-
 builtin-pack-objects.c |  160 +++---------------------------------------------
 pack-revindex.c        |  142 ++++++++++++++++++++++++++++++++++++++++++
 pack-revindex.h        |   12 ++++
 4 files changed, 167 insertions(+), 152 deletions(-)
 create mode 100644 pack-revindex.c
 create mode 100644 pack-revindex.h

diff --git a/Makefile b/Makefile
index 149343c..530427c 100644
--- a/Makefile
+++ b/Makefile
@@ -304,7 +304,8 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h ll-merge.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h \
+	ll-merge.h pack-revindex.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -328,7 +329,7 @@ LIB_OBJS = \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
 	transport.o bundle.o walker.o parse-options.o ws.o archive.o branch.o \
-	ll-merge.o alias.o
+	ll-merge.o alias.o pack-revindex.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 1bba6e6..c7834bb 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include "delta.h"
 #include "pack.h"
+#include "pack-revindex.h"
 #include "csum-file.h"
 #include "tree-walk.h"
 #include "diff.h"
@@ -93,157 +94,11 @@ static int *object_ix;
 static int object_ix_hashsz;
 
 /*
- * Pack index for existing packs give us easy access to the offsets into
- * corresponding pack file where each object's data starts, but the entries
- * do not store the size of the compressed representation (uncompressed
- * size is easily available by examining the pack entry header).  It is
- * also rather expensive to find the sha1 for an object given its offset.
- *
- * We build a hashtable of existing packs (pack_revindex), and keep reverse
- * index here -- pack index file is sorted by object name mapping to offset;
- * this pack_revindex[].revindex array is a list of offset/index_nr pairs
- * ordered by offset, so if you know the offset of an object, next offset
- * is where its packed representation ends and the index_nr can be used to
- * get the object sha1 from the main index.
- */
-struct revindex_entry {
-	off_t offset;
-	unsigned int nr;
-};
-struct pack_revindex {
-	struct packed_git *p;
-	struct revindex_entry *revindex;
-};
-static struct  pack_revindex *pack_revindex;
-static int pack_revindex_hashsz;
-
-/*
  * stats
  */
 static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
 
-static int pack_revindex_ix(struct packed_git *p)
-{
-	unsigned long ui = (unsigned long)p;
-	int i;
-
-	ui = ui ^ (ui >> 16); /* defeat structure alignment */
-	i = (int)(ui % pack_revindex_hashsz);
-	while (pack_revindex[i].p) {
-		if (pack_revindex[i].p == p)
-			return i;
-		if (++i == pack_revindex_hashsz)
-			i = 0;
-	}
-	return -1 - i;
-}
-
-static void prepare_pack_ix(void)
-{
-	int num;
-	struct packed_git *p;
-	for (num = 0, p = packed_git; p; p = p->next)
-		num++;
-	if (!num)
-		return;
-	pack_revindex_hashsz = num * 11;
-	pack_revindex = xcalloc(sizeof(*pack_revindex), pack_revindex_hashsz);
-	for (p = packed_git; p; p = p->next) {
-		num = pack_revindex_ix(p);
-		num = - 1 - num;
-		pack_revindex[num].p = p;
-	}
-	/* revindex elements are lazily initialized */
-}
-
-static int cmp_offset(const void *a_, const void *b_)
-{
-	const struct revindex_entry *a = a_;
-	const struct revindex_entry *b = b_;
-	return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
-}
-
-/*
- * Ordered list of offsets of objects in the pack.
- */
-static void prepare_pack_revindex(struct pack_revindex *rix)
-{
-	struct packed_git *p = rix->p;
-	int num_ent = p->num_objects;
-	int i;
-	const char *index = p->index_data;
-
-	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
-	index += 4 * 256;
-
-	if (p->index_version > 1) {
-		const uint32_t *off_32 =
-			(uint32_t *)(index + 8 + p->num_objects * (20 + 4));
-		const uint32_t *off_64 = off_32 + p->num_objects;
-		for (i = 0; i < num_ent; i++) {
-			uint32_t off = ntohl(*off_32++);
-			if (!(off & 0x80000000)) {
-				rix->revindex[i].offset = off;
-			} else {
-				rix->revindex[i].offset =
-					((uint64_t)ntohl(*off_64++)) << 32;
-				rix->revindex[i].offset |=
-					ntohl(*off_64++);
-			}
-			rix->revindex[i].nr = i;
-		}
-	} else {
-		for (i = 0; i < num_ent; i++) {
-			uint32_t hl = *((uint32_t *)(index + 24 * i));
-			rix->revindex[i].offset = ntohl(hl);
-			rix->revindex[i].nr = i;
-		}
-	}
-
-	/* This knows the pack format -- the 20-byte trailer
-	 * follows immediately after the last object data.
-	 */
-	rix->revindex[num_ent].offset = p->pack_size - 20;
-	rix->revindex[num_ent].nr = -1;
-	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
-}
-
-static struct revindex_entry * find_packed_object(struct packed_git *p,
-						  off_t ofs)
-{
-	int num;
-	int lo, hi;
-	struct pack_revindex *rix;
-	struct revindex_entry *revindex;
-	num = pack_revindex_ix(p);
-	if (num < 0)
-		die("internal error: pack revindex uninitialized");
-	rix = &pack_revindex[num];
-	if (!rix->revindex)
-		prepare_pack_revindex(rix);
-	revindex = rix->revindex;
-	lo = 0;
-	hi = p->num_objects + 1;
-	do {
-		int mi = (lo + hi) / 2;
-		if (revindex[mi].offset == ofs) {
-			return revindex + mi;
-		}
-		else if (ofs < revindex[mi].offset)
-			hi = mi;
-		else
-			lo = mi + 1;
-	} while (lo < hi);
-	die("internal error: pack revindex corrupt");
-}
-
-static const unsigned char *find_packed_object_name(struct packed_git *p,
-						    off_t ofs)
-{
-	struct revindex_entry *entry = find_packed_object(p, ofs);
-	return nth_packed_object_sha1(p, entry->nr);
-}
 
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
 {
@@ -510,7 +365,7 @@ static unsigned long write_object(struct sha1file *f,
 		}
 		hdrlen = encode_header(obj_type, entry->size, header);
 		offset = entry->in_pack_offset;
-		revidx = find_packed_object(p, offset);
+		revidx = find_pack_revindex(p, offset);
 		datalen = revidx[1].offset - offset;
 		if (!pack_to_stdout && p->index_version > 1 &&
 		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr))
@@ -1162,8 +1017,11 @@ static void check_object(struct object_entry *entry)
 				die("delta base offset out of bound for %s",
 				    sha1_to_hex(entry->idx.sha1));
 			ofs = entry->in_pack_offset - ofs;
-			if (!no_reuse_delta && !entry->preferred_base)
-				base_ref = find_packed_object_name(p, ofs);
+			if (!no_reuse_delta && !entry->preferred_base) {
+				struct revindex_entry *revidx;
+				revidx = find_pack_revindex(p, ofs);
+				base_ref = nth_packed_object_sha1(p, revidx->nr);
+			}
 			entry->in_pack_header_size = used + used_0;
 			break;
 		}
@@ -1240,9 +1098,11 @@ static void get_object_details(void)
 		sorted_by_offset[i] = objects + i;
 	qsort(sorted_by_offset, nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
 
-	prepare_pack_ix();
+	init_pack_revindex();
+
 	for (i = 0; i < nr_objects; i++)
 		check_object(sorted_by_offset[i]);
+
 	free(sorted_by_offset);
 }
 
diff --git a/pack-revindex.c b/pack-revindex.c
new file mode 100644
index 0000000..cde3f5b
--- /dev/null
+++ b/pack-revindex.c
@@ -0,0 +1,142 @@
+#include "cache.h"
+#include "pack-revindex.h"
+
+/*
+ * Pack index for existing packs give us easy access to the offsets into
+ * corresponding pack file where each object's data starts, but the entries
+ * do not store the size of the compressed representation (uncompressed
+ * size is easily available by examining the pack entry header).  It is
+ * also rather expensive to find the sha1 for an object given its offset.
+ *
+ * We build a hashtable of existing packs (pack_revindex), and keep reverse
+ * index here -- pack index file is sorted by object name mapping to offset;
+ * this pack_revindex[].revindex array is a list of offset/index_nr pairs
+ * ordered by offset, so if you know the offset of an object, next offset
+ * is where its packed representation ends and the index_nr can be used to
+ * get the object sha1 from the main index.
+ */
+
+struct pack_revindex {
+	struct packed_git *p;
+	struct revindex_entry *revindex;
+};
+
+static struct  pack_revindex *pack_revindex;
+static int pack_revindex_hashsz;
+
+static int pack_revindex_ix(struct packed_git *p)
+{
+	unsigned long ui = (unsigned long)p;
+	int i;
+
+	ui = ui ^ (ui >> 16); /* defeat structure alignment */
+	i = (int)(ui % pack_revindex_hashsz);
+	while (pack_revindex[i].p) {
+		if (pack_revindex[i].p == p)
+			return i;
+		if (++i == pack_revindex_hashsz)
+			i = 0;
+	}
+	return -1 - i;
+}
+
+void init_pack_revindex(void)
+{
+	int num;
+	struct packed_git *p;
+
+	for (num = 0, p = packed_git; p; p = p->next)
+		num++;
+	if (!num)
+		return;
+	pack_revindex_hashsz = num * 11;
+	pack_revindex = xcalloc(sizeof(*pack_revindex), pack_revindex_hashsz);
+	for (p = packed_git; p; p = p->next) {
+		num = pack_revindex_ix(p);
+		num = - 1 - num;
+		pack_revindex[num].p = p;
+	}
+	/* revindex elements are lazily initialized */
+}
+
+static int cmp_offset(const void *a_, const void *b_)
+{
+	const struct revindex_entry *a = a_;
+	const struct revindex_entry *b = b_;
+	return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
+}
+
+/*
+ * Ordered list of offsets of objects in the pack.
+ */
+static void create_pack_revindex(struct pack_revindex *rix)
+{
+	struct packed_git *p = rix->p;
+	int num_ent = p->num_objects;
+	int i;
+	const char *index = p->index_data;
+
+	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
+	index += 4 * 256;
+
+	if (p->index_version > 1) {
+		const uint32_t *off_32 =
+			(uint32_t *)(index + 8 + p->num_objects * (20 + 4));
+		const uint32_t *off_64 = off_32 + p->num_objects;
+		for (i = 0; i < num_ent; i++) {
+			uint32_t off = ntohl(*off_32++);
+			if (!(off & 0x80000000)) {
+				rix->revindex[i].offset = off;
+			} else {
+				rix->revindex[i].offset =
+					((uint64_t)ntohl(*off_64++)) << 32;
+				rix->revindex[i].offset |=
+					ntohl(*off_64++);
+			}
+			rix->revindex[i].nr = i;
+		}
+	} else {
+		for (i = 0; i < num_ent; i++) {
+			uint32_t hl = *((uint32_t *)(index + 24 * i));
+			rix->revindex[i].offset = ntohl(hl);
+			rix->revindex[i].nr = i;
+		}
+	}
+
+	/* This knows the pack format -- the 20-byte trailer
+	 * follows immediately after the last object data.
+	 */
+	rix->revindex[num_ent].offset = p->pack_size - 20;
+	rix->revindex[num_ent].nr = -1;
+	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
+}
+
+struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
+{
+	int num;
+	int lo, hi;
+	struct pack_revindex *rix;
+	struct revindex_entry *revindex;
+
+	num = pack_revindex_ix(p);
+	if (num < 0)
+		die("internal error: pack revindex uninitialized");
+
+	rix = &pack_revindex[num];
+	if (!rix->revindex)
+		create_pack_revindex(rix);
+	revindex = rix->revindex;
+
+	lo = 0;
+	hi = p->num_objects + 1;
+	do {
+		int mi = (lo + hi) / 2;
+		if (revindex[mi].offset == ofs) {
+			return revindex + mi;
+		} else if (ofs < revindex[mi].offset)
+			hi = mi;
+		else
+			lo = mi + 1;
+	} while (lo < hi);
+	die("internal error: pack revindex corrupt");
+}
diff --git a/pack-revindex.h b/pack-revindex.h
new file mode 100644
index 0000000..2c51af9
--- /dev/null
+++ b/pack-revindex.h
@@ -0,0 +1,12 @@
+#ifndef PACK_REVINDEX_H
+#define PACK_REVINDEX_H
+
+struct revindex_entry {
+	off_t offset;
+	unsigned int nr;
+};
+
+void init_pack_revindex(void);
+struct revindex_entry * find_pack_revindex(struct packed_git *p, off_t ofs);
+
+#endif
-- 
1.5.4.2.200.g99e75

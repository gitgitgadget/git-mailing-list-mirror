From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 13/24] read-cache: read resolve-undo data
Date: Wed, 27 Nov 2013 13:00:48 +0100
Message-ID: <1385553659-9928-14-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vldou-00021J-9z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab3K0MCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:10 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:43837 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab3K0MCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:07 -0500
Received: by mail-la0-f50.google.com with SMTP id el20so5176541lab.37
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Hmq3jPzxw6uKSwrNaGNlrEwfVGJcrnKpxoxRGQ+YvI=;
        b=nNmkeFjrXFGvQCAP9sC/Wzfg+kG85ydk6FurdRC+FVMyGAMQpPHKNelRx/lo3wucYh
         HlUXcNHecVx4d/uiy+IDOYt4zWxx/Rm8qkPkn7dsaSia81bNoYtAbRpoAmxG4f36d5Yl
         TSipNbKxsEGx3lC4nlXPWq1bdeHHp7DchN92FaVgk4fa7VZIfC4Foj/zRhrNuu0VmiFw
         OFjrg2Hc18xJuGHduspY4FUCJcT7b48G0eIGDKd2JIjOdjkpZ4ORc75eJHyP6+IC3Jzo
         6dWOiDj8M4TscDFT0Dwm/y3RaOQSP3SxjhwfONM4CNI0B8XQJbear4E9+eKLpGTHMVsV
         j4MA==
X-Received: by 10.112.160.170 with SMTP id xl10mr1302643lbb.40.1385553725940;
        Wed, 27 Nov 2013 04:02:05 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id i8sm14944029lbh.2.2013.11.27.04.02.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:04 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238427>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data are then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 3 deletions(-)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 9d8c8f0..a9c687f 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "read-cache.h"
+#include "string-list.h"
 #include "resolve-undo.h"
 #include "cache-tree.h"
 #include "dir.h"
@@ -13,13 +14,18 @@ struct cache_header_v5 {
 	uint32_t hdr_nextension;
 };
 
+struct extension_header {
+	char signature[4];
+	uint32_t size;
+	uint32_t crc;
+};
+
 struct directory_entry {
 	struct directory_entry **sub;
 	struct directory_entry *next;
 	struct directory_entry *next_hash;
 	struct cache_entry *ce;
 	struct cache_entry *ce_last;
-	uint32_t conflict_size;
 	uint32_t de_foffset;
 	uint32_t de_nsubtrees;
 	uint32_t de_nfiles;
@@ -42,7 +48,6 @@ struct conflict_entry {
 	uint32_t nfileconflicts;
 	struct conflict_part *entries;
 	uint32_t namelen;
-	uint32_t pathlen;
 	char name[FLEX_ARRAY];
 };
 
@@ -50,6 +55,12 @@ struct conflict_entry {
  * Index File I/O
  *****************************************************************/
 
+struct ondisk_conflict_part {
+	uint16_t flags;
+	uint16_t entry_mode;
+	unsigned char sha1[20];
+};
+
 struct ondisk_cache_entry {
 	uint16_t flags;
 	uint16_t mode;
@@ -145,7 +156,7 @@ static int verify_hdr(void *mmap, unsigned long size)
 	hdr = mmap;
 	hdr_v5 = ptr_add(mmap, sizeof(*hdr));
 	/* Size of the header + the size of the extensionoffsets */
-	header_size = sizeof(*hdr) + sizeof(*hdr_v5) + hdr_v5->hdr_nextension * 4;
+	header_size = sizeof(*hdr) + sizeof(*hdr_v5) + ntohl(hdr_v5->hdr_nextension) * 4;
 	/* Initialize crc */
 	filecrc = ptr_add(mmap, header_size);
 	if (!check_crc32(0, hdr, header_size, ntohl(*filecrc)))
@@ -279,6 +290,134 @@ static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
 	return 0;
 }
 
+static struct conflict_part *conflict_part_from_ondisk(struct ondisk_conflict_part *ondisk)
+{
+	struct conflict_part *cp = xmalloc(sizeof(struct conflict_part));
+
+	cp->flags      = ntoh_s(ondisk->flags);
+	cp->entry_mode = ntoh_s(ondisk->entry_mode);
+	hashcpy(cp->sha1, ondisk->sha1);
+	return cp;
+}
+
+struct conflict_entry *create_new_conflict(char *name, int len)
+{
+	struct conflict_entry *conflict_entry;
+
+	conflict_entry = xmalloc(conflict_entry_size(len));
+	memset(conflict_entry, 0, conflict_entry_size(len));
+	conflict_entry->namelen = len;
+	memcpy(conflict_entry->name, name, len);
+
+	return conflict_entry;
+}
+
+static void add_part_to_conflict_entry(struct conflict_entry *entry,
+				       struct conflict_part *conflict_part)
+{
+
+	struct conflict_part *conflict_search;
+
+	entry->nfileconflicts++;
+	if (!entry->entries)
+		entry->entries = conflict_part;
+	else {
+		conflict_search = entry->entries;
+		while (conflict_search->next)
+			conflict_search = conflict_search->next;
+		conflict_search->next = conflict_part;
+	}
+}
+
+/*
+ * Read the resolve undo data on disk and convert it to the internal
+ * resolve undo format.
+ */
+static int read_resolve_undo(struct index_state *istate,
+			     unsigned int offset, void *mmap,
+			     unsigned int entries)
+{
+	int i, k;
+
+	for (i = 0; i < entries; i++) {
+		char *name;
+		unsigned int len, *nfileconflicts, nc;
+		uint32_t *crc;
+		struct ondisk_conflict_part *ondisk;
+		struct conflict_part *cp;
+		struct string_list_item *lost;
+		struct resolve_undo_info *ui;
+
+		name = ptr_add(mmap, offset);
+		len = strlen(name);
+		offset += len + 1;
+		nfileconflicts = ptr_add(mmap, offset);
+		nc = ntoh_l(*nfileconflicts);
+		offset += 4;
+
+		crc = ptr_add(mmap, offset +
+			      nc * sizeof(struct ondisk_conflict_part));
+		if (!check_crc32(0, name, len + 1 + 4 +
+				 nc * sizeof(struct ondisk_conflict_part),
+				 ntoh_l(*crc)))
+			return -1;
+
+		ondisk = ptr_add(mmap, offset);
+		cp = conflict_part_from_ondisk(ondisk);
+		if (cp->flags & CONFLICT_CONFLICTED) {
+			offset += nc * sizeof(struct ondisk_conflict_part) + 4;
+			continue;
+		}
+		offset += sizeof(struct ondisk_conflict_part);
+		if (!istate->resolve_undo) {
+			istate->resolve_undo = xcalloc(1, sizeof(struct string_list));
+			istate->resolve_undo->strdup_strings = 1;
+		}
+
+		lost = string_list_insert(istate->resolve_undo, name);
+		if (!lost->util)
+			lost->util = xcalloc(1, sizeof(*ui));
+		ui = lost->util;
+		for (k = 0; k < 3; k++)
+			ui->mode[k] = 0;
+
+		ui->mode[conflict_stage(cp) - 1] = cp->entry_mode;
+		hashcpy(ui->sha1[conflict_stage(cp) - 1], cp->sha1);
+		for (k = 1; k < nc; k++) {
+			struct conflict_part *cp;
+
+			ondisk = ptr_add(mmap, offset);
+			cp = conflict_part_from_ondisk(ondisk);
+			ui->mode[conflict_stage(cp) - 1] = cp->entry_mode;
+			hashcpy(ui->sha1[conflict_stage(cp) - 1], cp->sha1);
+			offset += sizeof(struct ondisk_conflict_part);
+		}
+		offset += 4; /* crc */
+	}
+	return 0;
+}
+
+static int read_index_extension(struct index_state *istate,
+				void *mmap, unsigned int extoffset)
+{
+	struct extension_header *ehdr;
+
+	ehdr = ptr_add(mmap, extoffset);
+	/* -4 for the crc that's included in the struct */
+	if (!check_crc32(0, ptr_add(mmap, extoffset),
+			 sizeof(*ehdr) - 4, ntoh_l(ehdr->crc)))
+		return -1;
+
+	switch (CACHE_EXT(ehdr->signature)) {
+	case CACHE_EXT_RESOLVE_UNDO:
+		if (read_resolve_undo(istate, extoffset + sizeof(*ehdr),
+				      mmap, ntoh_l(ehdr->size)) < 0)
+			return -1;
+		break;
+	}
+	return 0;
+}
+
 /*
  * Read all file entries from the index.  This function is recursive to get
  * the ordering right. In the index file the entries are sorted def, abc/def,
@@ -404,6 +543,21 @@ static int read_index_v5(struct index_state *istate, void *mmap,
 		}
 		de = de->next;
 	}
+
+	if (!opts || opts->read_resolve_undo) {
+		for (i = 0; i < ntohl(hdr_v5->hdr_nextension); i++) {
+			/*
+			 * After the index entry there is a number of
+			 * extensions, which is written in the header.
+			 * The extensions are prefixed by extension name
+			 * (4-byte) and length of the extension (4-byte,
+			 * usually the number of entries in that section)
+			 * in network byte order
+			 */
+			if (read_index_extension(istate, mmap, extoffsets[i]) < 0)
+				return -1;
+		}
+	}
 	free_directory_tree(root_directory);
 	istate->cache_nr = nr;
 	return 0;
-- 
1.8.4.2

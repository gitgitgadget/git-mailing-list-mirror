From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 16/24] read-cache: read resolve-undo data
Date: Sun, 18 Aug 2013 21:42:05 +0200
Message-ID: <1376854933-31241-17-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yE-000474-JE
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab3HRTs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:59 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:46042 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915Ab3HRTs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:58 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so1384009wgh.8
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBfdgKwP4Y2sqLSkYxhLVJnqfhMBrWLnKmocdM3hgCY=;
        b=IIF4U6p346NCJemnFOFSkq6j5q96xVv9sZxueN3j+/F60n3j817ExeBo4qiTR/MYjo
         CQr6WrVjh46VZoh3rdJN3riT3DS+YnLTLvA9uuI+JbE/Gx1CK4DXNBWpfBtaVTJFwtE8
         ccQQcDcJ0NpIOuePozLnf6SBM1m7JEQFyOf9Ws7zr0DnzWl8sGpAWdKhavWGBUez5gGc
         wyPkvozuYFEL1mXto2cbUSLaQuBQbz7/U5cR7f/PbnSb5LrqJwZ1ef19+iX97GZ/IqpY
         5mHAOfsnykqJT6FMhp0svZoq4cBRGo2Yd8pS6EfLkqofiV2Qf/cRBwcI873sfayDT/n3
         /VkA==
X-Received: by 10.194.120.68 with SMTP id la4mr1876561wjb.33.1376855336830;
        Sun, 18 Aug 2013 12:48:56 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id l7sm11972429wiw.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232504>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 799b8e7..85a2069 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "read-cache.h"
+#include "string-list.h"
 #include "resolve-undo.h"
 #include "cache-tree.h"
 #include "dir.h"
@@ -308,6 +309,31 @@ static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
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
+static void conflict_entry_push(struct conflict_entry **head,
+				struct conflict_entry **tail,
+				struct conflict_entry *conflict_entry)
+{
+	if (!*head) {
+		*head = *tail = conflict_entry;
+		(*tail)->next = NULL;
+		return;
+	}
+
+	(*tail)->next = conflict_entry;
+	conflict_entry->next = NULL;
+	*tail = (*tail)->next;
+}
+
 struct conflict_entry *create_new_conflict(char *name, int len, int pathlen)
 {
 	struct conflict_entry *conflict_entry;
@@ -345,6 +371,106 @@ void add_part_to_conflict_entry(struct directory_entry *de,
 	}
 }
 
+static int read_conflicts(struct conflict_entry **head,
+			  struct directory_entry *de,
+			  void *mmap, unsigned long mmap_size)
+{
+	struct conflict_entry *tail;
+	unsigned int croffset, i;
+	char *full_name;
+
+	croffset = de->de_cr;
+	tail = NULL;
+	for (i = 0; i < de->de_ncr; i++) {
+		struct conflict_entry *conflict_new;
+		unsigned int len, *nfileconflicts;
+		char *name;
+		void *crc_start;
+		int k, offset;
+		uint32_t *filecrc;
+
+		offset = croffset;
+		crc_start = ptr_add(mmap, offset);
+		name = ptr_add(mmap, offset);
+		len = strlen(name);
+		offset += len + 1;
+		nfileconflicts = ptr_add(mmap, offset);
+		offset += 4;
+
+		full_name = xmalloc(sizeof(char) * (len + de->de_pathlen));
+		memcpy(full_name, de->pathname, de->de_pathlen);
+		memcpy(full_name + de->de_pathlen, name, len);
+		conflict_new = create_new_conflict(full_name,
+				len + de->de_pathlen, de->de_pathlen);
+		for (k = 0; k < ntoh_l(*nfileconflicts); k++) {
+			struct ondisk_conflict_part *ondisk;
+			struct conflict_part *cp;
+
+			ondisk = ptr_add(mmap, offset);
+			cp = conflict_part_from_ondisk(ondisk);
+			cp->next = NULL;
+			add_part_to_conflict_entry(de, conflict_new, cp);
+			offset += sizeof(struct ondisk_conflict_part);
+		}
+		filecrc = ptr_add(mmap, offset);
+		free(full_name);
+		if (!check_crc32(0, crc_start,
+			len + 1 + 4 + conflict_new->nfileconflicts
+			* sizeof(struct ondisk_conflict_part),
+			ntoh_l(*filecrc)))
+			return -1;
+		croffset = offset + 4;
+		conflict_entry_push(head, &tail, conflict_new);
+	}
+	return 0;
+}
+
+static int convert_resolve_undo(struct index_state *istate,
+				struct directory_entry *de,
+				void *mmap, unsigned long mmap_size)
+{
+	int i;
+	struct conflict_entry *conflicts = NULL;
+
+	if (read_conflicts(&conflicts, de, mmap, mmap_size) < 0)
+		return -1;
+
+	while (conflicts) {
+		struct string_list_item *lost;
+		struct resolve_undo_info *ui;
+		struct conflict_part *cp;
+
+		if (conflicts->entries &&
+		    (conflicts->entries->flags & CONFLICT_CONFLICTED)) {
+			conflicts = conflicts->next;
+			continue;
+		}
+		if (!istate->resolve_undo) {
+			istate->resolve_undo = xcalloc(1, sizeof(struct string_list));
+			istate->resolve_undo->strdup_strings = 1;
+		}
+
+		lost = string_list_insert(istate->resolve_undo, conflicts->name);
+		if (!lost->util)
+			lost->util = xcalloc(1, sizeof(*ui));
+		ui = lost->util;
+
+		cp = conflicts->entries;
+		for (i = 0; i < 3; i++)
+			ui->mode[i] = 0;
+		while (cp) {
+			ui->mode[conflict_stage(cp) - 1] = cp->entry_mode;
+			hashcpy(ui->sha1[conflict_stage(cp) - 1], cp->sha1);
+			cp = cp->next;
+		}
+		conflicts = conflicts->next;
+	}
+	for (i = 0; i < de->de_nsubtrees; i++)
+		if (convert_resolve_undo(istate, de->sub[i], mmap, mmap_size) < 0)
+			return -1;
+	return 0;
+}
+
 static int read_entries(struct index_state *istate, struct directory_entry *de,
 			unsigned int first_entry_offset, void *mmap,
 			unsigned long mmap_size, unsigned int *nr,
@@ -444,6 +570,10 @@ static int read_index_v5(struct index_state *istate, void *mmap,
 	if (!need_root)
 		parse_pathspec(&adjusted_pathspec, PATHSPEC_ALL_MAGIC, PATHSPEC_PREFER_CWD, NULL, paths);
 
+	if (!opts || opts->read_resolve_undo)
+		if (convert_resolve_undo(istate, root_directory, mmap, mmap_size) < 0)
+			return -1;
+
 	de = root_directory;
 	last_de = de;
 	while (de) {
-- 
1.8.3.4.1231.g9fbf354.dirty

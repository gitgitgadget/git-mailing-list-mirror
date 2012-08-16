From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 11/13] Write resolve-undo data for index-v5
Date: Thu, 16 Aug 2012 11:58:47 +0200
Message-ID: <1345111129-6925-12-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrX-0008Ge-Po
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab2HPJ7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:23 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48208 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756360Ab2HPJ7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:17 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 9133E4EFF6; Thu, 16 Aug 2012 11:59:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index d740d0b..ce2375a 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -907,6 +907,99 @@ static void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree
 	convert_one_to_ondisk_v5(table, root, "", 0, 0);
 }
 
+static void resolve_undo_to_ondisk_v5(struct hash_table *table,
+				      struct string_list *resolve_undo,
+				      unsigned int *ndir, int *total_dir_len,
+				      struct directory_entry *de)
+{
+	struct string_list_item *item;
+	struct directory_entry *search;
+
+	if (!resolve_undo)
+		return;
+	for_each_string_list_item(item, resolve_undo) {
+		struct conflict_entry *conflict_entry;
+		struct resolve_undo_info *ui = item->util;
+		char *super;
+		int i, dir_len, len;
+		uint32_t crc;
+		struct directory_entry *found, *current, *new_tree;
+
+		if (!ui)
+			continue;
+
+		super = super_directory(item->string);
+		if (!super)
+			dir_len = 0;
+		else
+			dir_len = strlen(super);
+		crc = crc32(0, (Bytef*)super, dir_len);
+		found = lookup_hash(crc, table);
+		current = NULL;
+		new_tree = NULL;
+
+		while (!found) {
+			struct directory_entry *new;
+
+			new = init_directory_entry(super, dir_len);
+			if (!current)
+				current = new;
+			insert_directory_entry(new, table, total_dir_len, ndir, crc);
+			if (new_tree != NULL)
+				new->de_nsubtrees = 1;
+			new->next = new_tree;
+			new_tree = new;
+			super = super_directory(super);
+			if (!super)
+				dir_len = 0;
+			else
+				dir_len = strlen(super);
+			crc = crc32(0, (Bytef*)super, dir_len);
+			found = lookup_hash(crc, table);
+		}
+		search = found;
+		while (search->next_hash && strcmp(super, search->pathname) != 0)
+			search = search->next_hash;
+		if (search && !current)
+			current = search;
+		if (!search && !current)
+			current = new_tree;
+		if (!super && new_tree) {
+			new_tree->next = de->next;
+			de->next = new_tree;
+			de->de_nsubtrees++;
+		} else if (new_tree) {
+			struct directory_entry *temp;
+
+			search = de->next;
+			while (strcmp(super, search->pathname))
+				search = search->next;
+			temp = new_tree;
+			while (temp->next)
+				temp = temp->next;
+			search->de_nsubtrees++;
+			temp->next = search->next;
+			search->next = new_tree;
+		}
+
+		len = strlen(item->string);
+		conflict_entry = create_new_conflict(item->string, len, current->de_pathlen);
+		add_conflict_to_directory_entry(current, conflict_entry);
+		for (i = 0; i < 3; i++) {
+			if (ui->mode[i]) {
+				struct conflict_part *cp;
+
+				cp = xmalloc(sizeof(struct conflict_part));
+				cp->flags = (i + 1) << CONFLICT_STAGESHIFT;
+				cp->entry_mode = ui->mode[i];
+				cp->next = NULL;
+				hashcpy(cp->sha1, ui->sha1[i]);
+				add_part_to_conflict_entry(current, conflict_entry, cp);
+			}
+		}
+	}
+}
+
 static struct directory_entry *compile_directory_data(struct index_state *istate,
 						int nfile,
 						unsigned int *ndir,
@@ -1012,6 +1105,9 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			previous_entry->next = no_subtrees;
 		}
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
+	resolve_undo_to_ondisk_v5(&table, istate->resolve_undo, ndir, total_dir_len, de);
 	return de;
 }
 
-- 
1.7.11.2

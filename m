From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v3 11/13] Write resolve-undo data for index-v5
Date: Wed,  8 Aug 2012 13:17:59 +0200
Message-ID: <1344424681-31469-12-git-send-email-t.gummerer@gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 13:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz4UN-0004gC-Io
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 13:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508Ab2HHLb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 07:31:29 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:36975 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755966Ab2HHLb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 07:31:26 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 5CB0C4EFF5; Wed,  8 Aug 2012 13:18:49 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203085>

Write the resolve undo data to the ondisk format, by joining the data
in the resolve-undo string-list with the already existing conflicts
that were compiled before, when searching the directories and add
them to the corresponding directory entries.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c |    3 ++
 resolve-undo.c  |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 resolve-undo.h  |    1 +
 3 files changed, 97 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 45f7acd..3d03111 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -861,6 +861,9 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			previous_entry->next = no_subtrees;
 		}
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
+	resolve_undo_to_ondisk_v5(&table, istate->resolve_undo, ndir, total_dir_len, de);
 	return de;
 }
 
diff --git a/resolve-undo.c b/resolve-undo.c
index f96c6ba..4568dcc 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -206,3 +206,96 @@ void resolve_undo_convert_v5(struct index_state *istate,
 		ce = ce->next;
 	}
 }
+
+void resolve_undo_to_ondisk_v5(struct hash_table *table,
+				struct string_list *resolve_undo,
+				unsigned int *ndir, int *total_dir_len,
+				struct directory_entry *de)
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
diff --git a/resolve-undo.h b/resolve-undo.h
index ab660a6..ff80d84 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -14,5 +14,6 @@ extern int unmerge_index_entry_at(struct index_state *, int);
 extern void unmerge_index(struct index_state *, const char **);
 
 extern void resolve_undo_convert_v5(struct index_state *, struct conflict_entry *);
+extern void resolve_undo_to_ondisk_v5(struct hash_table *, struct string_list *, unsigned int *, int *, struct directory_entry *);
 
 #endif
-- 
1.7.10.GIT

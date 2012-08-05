From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 14/16] Write resolve-undo data for index-v5
Date: Sun,  5 Aug 2012 23:49:11 +0200
Message-ID: <1344203353-2819-15-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8ix-0001x2-Lj
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab2HEVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48892 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab2HEVuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:50:11 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so648690eaa.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UA056bdJGfRZPx5eq+Pu89k+xoIIex8Akg5Z3B3mapQ=;
        b=Eni2VO63qXrCSOJQUxV/qwwbALvECwlBogLklLo+yFor3JX4FihR9smvpisWgsW3el
         ovl49xQTeZKPJ3WJHmTuaojucaZt20aGRC1LOgRcmR0KR7rEVUP9ZV65AjmLVJR8V4te
         Zbfy9tqyihHHH/Kwb0dBqrGczO/ltkONEbewoR3lwMfybJFrIw4ozr6o039i4QYvsz8U
         vtrIfMcna+j2i5s8wVtxQOnLmq8kiK56iMmB6+cwkCEed0y+mPUY1fGkXhFApfM+kS2I
         UiXXT65VHMmVCJG6l8USU+xqBCp7voTG8ChZrv6qE2SZm7Bkj9NQ4aC7N1F0JXYCqisF
         q6lg==
Received: by 10.14.203.70 with SMTP id e46mr10039808eeo.2.1344203411083;
        Sun, 05 Aug 2012 14:50:11 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id 7sm42305758eeb.3.2012.08.05.14.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:50:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202928>

Write the resolve undo data to the ondisk format, by joining the data
in the resolve-undo string-list with the already existing conflicts
that were compiled before, when searching the directories and add
them to the corresponding directory entries.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c   |    1 +
 resolve-undo.c |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 resolve-undo.h |    1 +
 3 files changed, 95 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index d18383f..6496cc4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2765,6 +2765,7 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 	}
 	if (istate->cache_tree)
 		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
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

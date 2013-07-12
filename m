From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 17/19] read-cache: write resolve-undo data for index-v5
Date: Fri, 12 Jul 2013 19:27:02 +0200
Message-ID: <1373650024-3001-18-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhDk-0006s1-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201Ab3GLRdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:33:24 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:63975 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813Ab3GLRdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:33:24 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so9266400pbc.24
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QH+gh8V4jJO0qld7uxUP98yC7KiqSGLIwAV5cjp+9uo=;
        b=0Yrs7oCaumkjHJBeVlWhtugE4Kxx2QcpvzfuQdKMKteDHE5CRgPs8xxAyhPar2Tmbv
         Sd83txM6Z9x0ac15AklCWww1dI7fRpkOlLPXIsO9Ns5FNYNjGj9wQCGQs46oC26kUbqE
         +lEci/8q/y4ffwpDjSXA3SVKDOFmmsoJ6HaTwhcbRdXC0Ifl2qGuqCdJafEx7In0GEBV
         TElDLFfkGp4x15T1cwZDGitgV9VY5t94VEeLtLkuUvwV80JKfinHQzvvScqk9HHD9MVo
         OLzvhYrz1A9QAaa7eIfDXCocen+72rgrCsmXJnHHu31Mo9BtxmhzcTDE1yXp6qQceQea
         MEiQ==
X-Received: by 10.66.26.46 with SMTP id i14mr45086141pag.25.1373650403574;
        Fri, 12 Jul 2013 10:33:23 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id y9sm46390485pbb.46.2013.07.12.10.33.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:33:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230229>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index cd819b4..093ee1a 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -992,6 +992,99 @@ static void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree
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
@@ -1099,6 +1192,7 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 	}
 	if (istate->cache_tree)
 		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
+	resolve_undo_to_ondisk_v5(&table, istate->resolve_undo, ndir, total_dir_len, de);
 	return de;
 }
 
-- 
1.8.3.453.g1dfc63d

From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 20/24] read-cache: write resolve-undo data for index-v5
Date: Sun, 18 Aug 2013 21:42:09 +0200
Message-ID: <1376854933-31241-21-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yX-0004K8-LB
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab3HRTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:15 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:54922 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab3HRTtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:11 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so3124153wes.20
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6drLXlFyXkIIOu224m8JVF/9nncdkQ7pX5BfUYRz5vo=;
        b=d+si4/xh7CU8swruQMXQlJNPT+ihNNsgjiEqdNTrXlQapbPmKYwooHV9rEP3wIybuE
         CPEOAMDjaCaB1HOTDYF0FZ0ASaahfhCzrWfBeRxgz5anHsrssUPNUS9A8IBk1wUyCrNQ
         iXxFe+QfZRf264O3LVDPi6rQj17VauDl3BzkPn+wWCdhnZP/+uqTaw/ootPQwJC457Kd
         8A3zuNlKw7SoOxEYaxCMqZRt4ukvF8gDRzkqYUFNeotw0DMXJ14S+ltnlfkFstCkyxet
         CN+335aLh7/A23R7tZoReKI5muK7StLbjV95FpMjNIZNflxzvc6xIQ0+gteNw6CRDMW3
         Yv0g==
X-Received: by 10.194.123.227 with SMTP id md3mr5792588wjb.17.1376855350664;
        Sun, 18 Aug 2013 12:49:10 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id dt17sm11967005wic.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:49:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232508>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index ed52b7c..10960fd 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -942,6 +942,94 @@ static void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree
 	convert_one_to_ondisk_v5(table, root, "", 0, 0);
 }
 
+static void resolve_undo_to_ondisk_v5(struct hash_table *table,
+				      struct string_list *resolve_undo,
+				      unsigned int *ndir,
+				      unsigned int *total_dir_len,
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
+		dir_len = super ? strlen(super) : 0;
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
+			dir_len = super ? strlen(super) : 0;
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
 static void ce_queue_push(struct cache_entry **head,
 			  struct cache_entry **tail,
 			  struct cache_entry *ce)
@@ -1014,6 +1102,7 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 	}
 	if (istate->cache_tree)
 		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
+	resolve_undo_to_ondisk_v5(&table, istate->resolve_undo, ndir, total_dir_len, de);
 	return de;
 }
 
-- 
1.8.3.4.1231.g9fbf354.dirty

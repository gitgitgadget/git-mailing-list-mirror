From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 20/22] read-cache: write resolve-undo data for index-v5
Date: Sun,  7 Jul 2013 10:11:58 +0200
Message-ID: <1373184720-29767-21-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk6R-0006fi-Jf
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab3GGINp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:45 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:64509 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab3GGINk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:40 -0400
Received: by mail-ea0-f178.google.com with SMTP id l15so2233312eak.23
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WkkgKAFVpRW0OQDy9+ushs/Z9RN6HCIzueNuMAAH2B8=;
        b=0KYCml/nztK5qgkEQj4M41OBcBqckOztBNhSGau1Nh5UEM92s8fS2ddapzml8O8lIi
         PtphcGC3N5QMdtY3ai/m8PZ+nu5mUu5jx77wiTsHQx4oGE5i2fa9yh+RqXZrspAp9xem
         TLHNcN85AF8a7fvcvfgGesxlObP/D2oe+9kaRIkvldkfslFTglorvgVHCVTmQZu/WIqN
         V68kX5AMBQDuiSiDa2IlGAnKkNoAh2UqKRaBVeiEMIEBMCaIPKsLPqBPHjuVULxOvH42
         VihVAvgVhjKfLrsB/M9JfyleJH1YyG4VkIdyek7o2aMtqSyY7k6gEqwISAtxH399v0kU
         O+xg==
X-Received: by 10.15.33.132 with SMTP id c4mr19880967eev.12.1373184819316;
        Sun, 07 Jul 2013 01:13:39 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id y1sm30800077eew.3.2013.07.07.01.13.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229750>

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
index 306de30..412db53 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -1011,6 +1011,99 @@ static void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree
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
@@ -1118,6 +1211,7 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 	}
 	if (istate->cache_tree)
 		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
+	resolve_undo_to_ondisk_v5(&table, istate->resolve_undo, ndir, total_dir_len, de);
 	return de;
 }
 
-- 
1.8.3.453.g1dfc63d

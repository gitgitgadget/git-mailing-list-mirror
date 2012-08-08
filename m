From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v3 07/13] Read resolve-undo data
Date: Wed,  8 Aug 2012 13:17:55 +0200
Message-ID: <1344424681-31469-8-git-send-email-t.gummerer@gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 13:31:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz4UM-0004gC-KY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 13:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab2HHLb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 07:31:27 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:36978 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734Ab2HHLb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 07:31:26 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id BDE8F4EFF0; Wed,  8 Aug 2012 13:18:48 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203082>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c |    1 +
 resolve-undo.c  |   36 ++++++++++++++++++++++++++++++++++++
 resolve-undo.h  |    2 ++
 3 files changed, 39 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index ec1201d..b47398d 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -494,6 +494,7 @@ static struct directory_entry *read_entries(struct index_state *istate,
 	int i;
 
 	conflict_queue = read_conflicts(de, mmap, mmap_size, fd);
+	resolve_undo_convert_v5(istate, conflict_queue);
 	for (i = 0; i < de->de_nfiles; i++) {
 		ce = read_entry(de,
 				entry_offset,
diff --git a/resolve-undo.c b/resolve-undo.c
index 72b4612..f96c6ba 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -170,3 +170,39 @@ void unmerge_index(struct index_state *istate, const char **pathspec)
 		i = unmerge_index_entry_at(istate, i);
 	}
 }
+
+void resolve_undo_convert_v5(struct index_state *istate,
+					struct conflict_entry *ce)
+{
+	int i;
+
+	while (ce) {
+		struct string_list_item *lost;
+		struct resolve_undo_info *ui;
+		struct conflict_part *cp;
+
+		if (ce->entries && (ce->entries->flags & CONFLICT_CONFLICTED) != 0) {
+			ce = ce->next;
+			continue;
+		}
+		if (!istate->resolve_undo) {
+			istate->resolve_undo = xcalloc(1, sizeof(struct string_list));
+			istate->resolve_undo->strdup_strings = 1;
+		}
+
+		lost = string_list_insert(istate->resolve_undo, ce->name);
+		if (!lost->util)
+			lost->util = xcalloc(1, sizeof(*ui));
+		ui = lost->util;
+
+		cp = ce->entries;
+		for (i = 0; i < 3; i++)
+			ui->mode[i] = 0;
+		while (cp) {
+			ui->mode[conflict_stage(cp) - 1] = cp->entry_mode;
+			hashcpy(ui->sha1[conflict_stage(cp) - 1], cp->sha1);
+			cp = cp->next;
+		}
+		ce = ce->next;
+	}
+}
diff --git a/resolve-undo.h b/resolve-undo.h
index 8458769..ab660a6 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -13,4 +13,6 @@ extern void resolve_undo_clear_index(struct index_state *);
 extern int unmerge_index_entry_at(struct index_state *, int);
 extern void unmerge_index(struct index_state *, const char **);
 
+extern void resolve_undo_convert_v5(struct index_state *, struct conflict_entry *);
+
 #endif
-- 
1.7.10.GIT

From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 07/13] Read resolve-undo data
Date: Thu, 16 Aug 2012 11:58:43 +0200
Message-ID: <1345111129-6925-8-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrq-0000D2-Re
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab2HPJ7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:39 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48204 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756233Ab2HPJ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:14 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id C59E34EFF1; Thu, 16 Aug 2012 11:59:09 +0200 (CEST)
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
 read-cache-v5.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 2031969..fb549de 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "read-cache.h"
+#include "string-list.h"
 #include "resolve-undo.h"
 #include "cache-tree.h"
 
@@ -447,6 +448,42 @@ static int read_conflicts(struct conflict_entry **head,
 	return 0;
 }
 
+static void resolve_undo_convert_v5(struct index_state *istate,
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
+
 static int read_entries(struct index_state *istate, struct directory_entry **de,
 			unsigned long *entry_offset, void **mmap,
 			unsigned long mmap_size, int *nr,
@@ -460,6 +497,7 @@ static int read_entries(struct index_state *istate, struct directory_entry **de,
 	conflict_queue = NULL;
 	if (read_conflicts(&conflict_queue, *de, mmap, mmap_size) < 0)
 		return -1;
+	resolve_undo_convert_v5(istate, conflict_queue);
 	for (i = 0; i < (*de)->de_nfiles; i++) {
 		if (read_entry(&ce,
 				*de,
-- 
1.7.11.2

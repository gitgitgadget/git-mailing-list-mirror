From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 16/22] read-cache: read resolve-undo data
Date: Sun,  7 Jul 2013 10:11:54 +0200
Message-ID: <1373184720-29767-17-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk69-0006Q3-Dc
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab3GGIN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:29 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:42389 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3GGINZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:25 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so2132797eek.23
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YCLSEI78Zgu4oRsIXly/Om9yvCGTlAqEKgtuE8FrQp0=;
        b=JHfIYpU5nArSKip9PvBVF+G3gvsc2MsYxOrTk0yL9zWjyXzzF9dD4XFhf//J6bHjLm
         yNdRin+F0vZTm8oVBRz8J3I/nT/CjGyzlJpGfj978+arHZvO9DTs9RVH/2/dQfYsGcYR
         QDjdEWcb2o2q4i8vXTUWo9NnshGZFEIOzQzpmygJhwVmS9o0t2Cr4V2aFvgm8bn7WB1A
         V/a79pId7juvKc/A2z9irS/VcAHenkTZS08oZe0wMYEcPj5rOSd7S7eUZ6GTBB4kbx0Q
         y5TGNDSuHsY3wmsfcGYyKhdkikMjwuD6yKPk+n5HB6PhKzpwrRR3ARlUrHu08tGKPnwj
         6yLQ==
X-Received: by 10.15.110.197 with SMTP id ch45mr19320448eeb.149.1373184804600;
        Sun, 07 Jul 2013 01:13:24 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id b7sm30645035eef.16.2013.07.07.01.13.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229744>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index e319f30..193970a 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "read-cache.h"
+#include "string-list.h"
 #include "resolve-undo.h"
 #include "cache-tree.h"
 #include "dir.h"
@@ -447,6 +448,43 @@ static int read_conflicts(struct conflict_entry **head,
 	return 0;
 }
 
+static void resolve_undo_convert_v5(struct index_state *istate,
+				    struct conflict_entry *conflict)
+{
+	int i;
+
+	while (conflict) {
+		struct string_list_item *lost;
+		struct resolve_undo_info *ui;
+		struct conflict_part *cp;
+
+		if (conflict->entries &&
+		    (conflict->entries->flags & CONFLICT_CONFLICTED) != 0) {
+			conflict = conflict->next;
+			continue;
+		}
+		if (!istate->resolve_undo) {
+			istate->resolve_undo = xcalloc(1, sizeof(struct string_list));
+			istate->resolve_undo->strdup_strings = 1;
+		}
+
+		lost = string_list_insert(istate->resolve_undo, conflict->name);
+		if (!lost->util)
+			lost->util = xcalloc(1, sizeof(*ui));
+		ui = lost->util;
+
+		cp = conflict->entries;
+		for (i = 0; i < 3; i++)
+			ui->mode[i] = 0;
+		while (cp) {
+			ui->mode[conflict_stage(cp) - 1] = cp->entry_mode;
+			hashcpy(ui->sha1[conflict_stage(cp) - 1], cp->sha1);
+			cp = cp->next;
+		}
+		conflict = conflict->next;
+	}
+}
+
 static int read_entries(struct index_state *istate, struct directory_entry **de,
 			unsigned int *entry_offset, void **mmap,
 			unsigned long mmap_size, unsigned int *nr,
@@ -460,6 +498,7 @@ static int read_entries(struct index_state *istate, struct directory_entry **de,
 	conflict_queue = NULL;
 	if (read_conflicts(&conflict_queue, *de, mmap, mmap_size) < 0)
 		return -1;
+	resolve_undo_convert_v5(istate, conflict_queue);
 	for (i = 0; i < (*de)->de_nfiles; i++) {
 		if (read_entry(&ce,
 			       *de,
-- 
1.8.3.453.g1dfc63d

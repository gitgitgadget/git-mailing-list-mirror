From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 13/19] read-cache: read resolve-undo data
Date: Fri, 12 Jul 2013 19:26:58 +0200
Message-ID: <1373650024-3001-14-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:30:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhB8-0004z1-1M
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192Ab3GLRam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:30:42 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34637 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964904Ab3GLRal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:30:41 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so9241301pac.12
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DjIOf8I2FHvNY2F0BahhhRvR8xEsvXjbdKctQPrYVLo=;
        b=ppg4D7/GhLxjOKacnJcuj8e/RCQgAgf2jF89gjDXU8psciLdJG1tmGg8SQWoEDVtJ8
         jiTXmfAW4pmgFoXYywPAa6qLsbJG6pX2il/FTkemgs5d9B5MNGFR7AI7kPBLkbfpGKBA
         mtTgShzK/eVbIvRuQpOLrPkrumeOHS3CRQ7offbaVGQszBJAYJtQgHGW5RtxxaC1nDqk
         EXDppqQ0Z8O80DM+2UsEC1fmNPpEMmfwNOKlTHilrux5b3+Su+Ra4GdQ/LW3egaKerMA
         gF4n87268jknwdcUsTEuJP+sYa8ez7h1kpkhA5MdNbxJ8M9Md6DrZeFAM6JbAhhYI2A1
         tzMA==
X-Received: by 10.66.246.106 with SMTP id xv10mr24285146pac.100.1373650241192;
        Fri, 12 Jul 2013 10:30:41 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id py4sm3168879pbc.14.2013.07.12.10.30.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:30:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230225>

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
index 00112ea..853b97d 100644
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

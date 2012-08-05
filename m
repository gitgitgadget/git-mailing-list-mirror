From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 10/16] Read resolve-undo data
Date: Sun,  5 Aug 2012 23:49:07 +0200
Message-ID: <1344203353-2819-11-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8iw-0001x2-5I
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab2HEVus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:48 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48918 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab2HEVuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:50:03 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so649089eei.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9u91+YQ1UN76PE9kW+dAvwp4MfUuh0JT3LXQ480UXBY=;
        b=CeLlCWAcisT+CD7vFcImXwAOv9KBOMmIlxIxiWxAReYFXQ/XJUxsYFQnHRvMEhPM0G
         UiTtJeYMFZd7gXFlVtggFikKTfJK93vPPV83NzQ+zOspDhcyif8vAuR6ypqfKcRRDW0r
         haKQWm68KB5Vb7bhdXzkWrY9Aj7UTXlWB8q7SE3UiHBc9sOcwdpi5C4xwbe3xy0nG2Se
         VgTnQcDnadbF+MfD8jVcAEj+VlvrZt1+J037AYO0hD4YsHTgSnRTg0ZjCZuYm9d71Rej
         Flm8SckxcUMRvbLw3HQ6ZZb7it+kPwVCpzV0su+Vx/VKASoTo6DcgqfdMHP/Z/3Co3Fm
         vDOA==
Received: by 10.14.179.200 with SMTP id h48mr10472611eem.12.1344203402581;
        Sun, 05 Aug 2012 14:50:02 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id k41sm42248766eep.13.2012.08.05.14.50.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:50:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202927>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c   |    1 +
 resolve-undo.c |   36 ++++++++++++++++++++++++++++++++++++
 resolve-undo.h |    2 ++
 3 files changed, 39 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 70334f9..03370f9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1942,6 +1942,7 @@ static struct directory_entry *read_entries_v5(struct index_state *istate,
 	int i;
 
 	conflict_queue = read_conflicts_v5(de, mmap, mmap_size, fd);
+	resolve_undo_convert_v5(istate, conflict_queue);
 	for (i = 0; i < de->de_nfiles; i++) {
 		ce = read_entry_v5(de,
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

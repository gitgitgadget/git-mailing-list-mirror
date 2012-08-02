From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 10/16] Read resolve-undo data
Date: Thu,  2 Aug 2012 13:02:00 +0200
Message-ID: <1343905326-23790-11-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:04:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtCE-0005eb-MF
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab2HBLDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54882 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2HBLDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:03:07 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so838702eaa.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IeqE5Xuv3QbqfnTFc9vLUTv5oJ2TdyFTjTtjXb1pmvI=;
        b=SjnpWRS1Iyg/AhAaQfIfv+OGnhdUQpLN5/YTMaH1GRqqGavHPXQc+w/Ai22+In1ftL
         QwXccU4uF5LXhhb4K9RK7ScrOOqov8eMM64U6a6TfHBx7rpSYHjzFFNrsevM1WBoIPMj
         Ds8LWauzIvZ4VttBWRb1ozDC4GXQn9p6EcV9NqWysdLg1I/UvaEgMEdl1WxglGNlk1Z+
         2u5a65/lK+hS5TWDrYVQXAVZ+A3cuqFdApBmRd0YxDzcxsBU6CNXripru26bdvEWdz7u
         ahbhhdzMK2cqTWHfWHIXNcagTCLN6yTp4m3zSgreCcE7H2BsZi9khPoe/iAEm6v2Tf1D
         nrWw==
Received: by 10.14.214.196 with SMTP id c44mr26518279eep.7.1343905386829;
        Thu, 02 Aug 2012 04:03:06 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id v5sm16442721eel.6.2012.08.02.04.03.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:03:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202765>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in
the ondisk format of the index file version 5, conflicts and
resolved data is read at the same time, and the resolve-undo
data is then converted to the in-memory format.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c   |  1 +
 resolve-undo.c | 36 ++++++++++++++++++++++++++++++++++++
 resolve-undo.h |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 884c2a7..cef9a4e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1910,6 +1910,7 @@ static struct directory_entry *read_entries_v5(struct index_state *istate,
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
1.7.10.886.gdf6792c.dirty

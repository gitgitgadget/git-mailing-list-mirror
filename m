From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [RFC PATCH 1/2] wt-status: Split header generation into three functions
Date: Mon,  8 Sep 2008 00:05:02 +0200
Message-ID: <1220825103-19599-2-git-send-email-mail@cup.kalibalik.dk>
References: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk>
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 00:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcSOt-0007mh-G6
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 00:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYIGWFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 18:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbYIGWFL
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 18:05:11 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:33296 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbYIGWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 18:05:06 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4E62B1405A;
	Mon,  8 Sep 2008 00:05:07 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id F2A6714062;
	Mon,  8 Sep 2008 00:05:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.dirty
In-Reply-To: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95183>

Reorganize header generation so that all header text related to each
block is in one place.

This adds a function, but makes it easier to see what is generated in
each case. It also allows for easy tweaking of individual headers.
---
 wt-status.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 889e50f..ceb3a1e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,12 +22,6 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	"\033[31m", /* WT_STATUS_NOBRANCH: red */
 };
 
-static const char use_add_msg[] =
-"use \"git add <file>...\" to update what will be committed";
-static const char use_add_rm_msg[] =
-"use \"git add/rm <file>...\" to update what will be committed";
-static const char use_add_to_include_msg[] =
-"use \"git add <file>...\" to include in what will be committed";
 enum untracked_status_type show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 
 static int parse_status_slot(const char *var, int offset)
@@ -76,12 +70,24 @@ static void wt_status_print_cached_header(struct wt_status *s)
 	color_fprintf_ln(s->fp, c, "#");
 }
 
-static void wt_status_print_header(struct wt_status *s,
-				   const char *main, const char *sub)
+static void wt_status_print_dirty_header(struct wt_status *s,
+					 int has_deleted)
 {
 	const char *c = color(WT_STATUS_HEADER);
-	color_fprintf_ln(s->fp, c, "# %s:", main);
-	color_fprintf_ln(s->fp, c, "#   (%s)", sub);
+	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
+	if (!has_deleted) {
+		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
+	} else {
+		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to update what will be committed)");
+	}
+	color_fprintf_ln(s->fp, c, "#");
+}
+
+static void wt_status_print_untracked_header(struct wt_status *s)
+{
+	const char *c = color(WT_STATUS_HEADER);
+	color_fprintf_ln(s->fp, c, "# Untracked files:");
+	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
 	color_fprintf_ln(s->fp, c, "#");
 }
 
@@ -166,14 +172,14 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 	struct wt_status *s = data;
 	int i;
 	if (q->nr) {
-		const char *msg = use_add_msg;
+		int has_deleted = 0;
 		s->workdir_dirty = 1;
 		for (i = 0; i < q->nr; i++)
 			if (q->queue[i]->status == DIFF_STATUS_DELETED) {
-				msg = use_add_rm_msg;
+				has_deleted = 1;
 				break;
 			}
-		wt_status_print_header(s, "Changed but not updated", msg);
+		wt_status_print_dirty_header(s, has_deleted);
 	}
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
@@ -291,8 +297,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 		}
 		if (!shown_header) {
 			s->workdir_untracked = 1;
-			wt_status_print_header(s, "Untracked files",
-					       use_add_to_include_msg);
+			wt_status_print_untracked_header(s);
 			shown_header = 1;
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-- 
1.6.0.1.dirty

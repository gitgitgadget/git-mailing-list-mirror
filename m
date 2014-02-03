From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 8/8] combine-diff: bail out early, if num_paths=0
Date: Mon,  3 Feb 2014 16:47:22 +0400
Message-ID: <2dc2bcce19105cdd384f119328c06321cbea599a.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIv0-00075i-RX
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbaBCMq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 07:46:26 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37601 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbaBCMqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:46:25 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIut-0004aX-PB; Mon, 03 Feb 2014 16:46:23 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIwh-0007G1-Ba; Mon, 03 Feb 2014 16:48:15 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241434>

That simplifies the code - instead of repeated checking for
num_paths !=0, let's verify it once, and return if it is, and
free following code from repeated ifs.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c | 52 +++++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 3e3f328..c1f481f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1459,12 +1459,18 @@ void diff_tree_combined(const unsigned char *sha1,
 		}
 	}
 
+	free_pathspec(&diffopts.pathspec);
+
 	/* find out number of surviving paths */
 	for (num_paths = 0, p = paths; p; p = p->next)
 		num_paths++;
 
+	/* nothing to do, if no paths */
+	if (!num_paths)
+		return;
+
 	/* order paths according to diffcore_order */
-	if (opt->orderfile && num_paths) {
+	if (opt->orderfile) {
 		struct obj_order *o;
 
 		o = xmalloc(sizeof(*o) * num_paths);
@@ -1483,28 +1489,26 @@ void diff_tree_combined(const unsigned char *sha1,
 	}
 
 
-	if (num_paths) {
-		if (opt->output_format & (DIFF_FORMAT_RAW |
-					  DIFF_FORMAT_NAME |
-					  DIFF_FORMAT_NAME_STATUS)) {
-			for (p = paths; p; p = p->next)
-				show_raw_diff(p, num_parent, rev);
-			needsep = 1;
-		}
-		else if (opt->output_format &
-			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
-			needsep = 1;
-		else if (opt->output_format & DIFF_FORMAT_CALLBACK)
-			handle_combined_callback(opt, paths, num_parent, num_paths);
-
-		if (opt->output_format & DIFF_FORMAT_PATCH) {
-			if (needsep)
-				printf("%s%c", diff_line_prefix(opt),
-				       opt->line_termination);
-			for (p = paths; p; p = p->next)
-				show_patch_diff(p, num_parent, dense,
-						0, rev);
-		}
+	if (opt->output_format & (DIFF_FORMAT_RAW |
+				  DIFF_FORMAT_NAME |
+				  DIFF_FORMAT_NAME_STATUS)) {
+		for (p = paths; p; p = p->next)
+			show_raw_diff(p, num_parent, rev);
+		needsep = 1;
+	}
+	else if (opt->output_format &
+		 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
+		needsep = 1;
+	else if (opt->output_format & DIFF_FORMAT_CALLBACK)
+		handle_combined_callback(opt, paths, num_parent, num_paths);
+
+	if (opt->output_format & DIFF_FORMAT_PATCH) {
+		if (needsep)
+			printf("%s%c", diff_line_prefix(opt),
+			       opt->line_termination);
+		for (p = paths; p; p = p->next)
+			show_patch_diff(p, num_parent, dense,
+					0, rev);
 	}
 
 	/* Clean things up */
@@ -1513,8 +1517,6 @@ void diff_tree_combined(const unsigned char *sha1,
 		paths = paths->next;
 		free(tmp);
 	}
-
-	free_pathspec(&diffopts.pathspec);
 }
 
 void diff_tree_combined_merge(const struct commit *commit, int dense,
-- 
1.9.rc1.181.g641f458

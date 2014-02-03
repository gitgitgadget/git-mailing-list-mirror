From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 5/8] combine-diff: move show_log_first logic/action out of paths scanning
Date: Mon,  3 Feb 2014 16:47:19 +0400
Message-ID: <3f729b3cac37e11e8ec74d88b4caac79f037194b.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:46:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIup-000700-4I
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbaBCMqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 07:46:11 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37512 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbaBCMqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:46:09 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIud-0004Zw-SL; Mon, 03 Feb 2014 16:46:08 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIwR-0007Fs-Ct; Mon, 03 Feb 2014 16:47:59 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241431>

Judging from sample outputs and tests nothing changes in diff -c output,
and this change will help later patches, when we'll be refactoring paths
scanning into its own function with several variants - the
show_log_first logic / code will stay common to all of them.

NOTE: only now we have to take care to explicitly not show anything if
    parents array is empty, as in fact there are some clients in Git code,
    which calls diff_tree_combined() in such a way.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index a03147c..272931f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1313,6 +1313,20 @@ void diff_tree_combined(const unsigned char *sha1,
 	struct combine_diff_path *p, *paths = NULL;
 	int i, num_paths, needsep, show_log_first, num_parent = parents->nr;
 
+	/* nothing to do, if no parents */
+	if (!num_parent)
+		return;
+
+	show_log_first = !!rev->loginfo && !rev->no_commit_id;
+	needsep = 0;
+	if (show_log_first) {
+		show_log(rev);
+
+		if (rev->verbose_header && opt->output_format)
+			printf("%s%c", diff_line_prefix(opt),
+			       opt->line_termination);
+	}
+
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -1321,8 +1335,6 @@ void diff_tree_combined(const unsigned char *sha1,
 	/* tell diff_tree to emit paths in sorted (=tree) order */
 	diffopts.orderfile = NULL;
 
-	show_log_first = !!rev->loginfo && !rev->no_commit_id;
-	needsep = 0;
 	/* find set of paths that everybody touches */
 	for (i = 0; i < num_parent; i++) {
 		/* show stat against the first parent even
@@ -1338,14 +1350,6 @@ void diff_tree_combined(const unsigned char *sha1,
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
 
-		if (show_log_first && i == 0) {
-			show_log(rev);
-
-			if (rev->verbose_header && opt->output_format)
-				printf("%s%c", diff_line_prefix(opt),
-				       opt->line_termination);
-		}
-
 		/* if showing diff, show it in requested order */
 		if (diffopts.output_format != DIFF_FORMAT_NO_OUTPUT &&
 		    opt->orderfile) {
-- 
1.9.rc1.181.g641f458

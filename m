From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 6/8] combine-diff: Move changed-paths scanning logic into its own function
Date: Mon,  3 Feb 2014 16:47:20 +0400
Message-ID: <19328cce4bfb32f7f514f0bd81aa8b1081e0c0cf.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIut-00073H-GI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbaBCMqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 07:46:16 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37555 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbaBCMqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:46:14 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIuj-0004aJ-2x; Mon, 03 Feb 2014 16:46:13 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIwW-0007Fv-MQ; Mon, 03 Feb 2014 16:48:04 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241432>

Move code for finding paths for which diff(commit,parent_i) is not-empty
for all parents to separate function - at present we have generic (and
slow) code for this job, which translates 1 n-parent problem to n
1-parent problems and then intersect results, and will be adding another
limited, but faster, paths scanning implementation in the next patch.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c | 79 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 272931f..427a7c1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1303,6 +1303,50 @@ static const char *path_path(void *obj)
 	return path->path;
 }
 
+
+/* find set of paths that every parent touches */
+static struct combine_diff_path *find_paths(const unsigned char *sha1,
+	const struct sha1_array *parents, struct diff_options *opt)
+{
+	struct combine_diff_path *paths = NULL;
+	int i, num_parent = parents->nr;
+
+	int output_format = opt->output_format;
+	const char *orderfile = opt->orderfile;
+
+	opt->output_format = DIFF_FORMAT_NO_OUTPUT;
+	/* tell diff_tree to emit paths in sorted (=tree) order */
+	opt->orderfile = NULL;
+
+	for (i = 0; i < num_parent; i++) {
+		/* show stat against the first parent even
+		 * when doing combined diff.
+		 */
+		int stat_opt = (output_format &
+				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+		if (i == 0 && stat_opt)
+			opt->output_format = stat_opt;
+		else
+			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
+		diff_tree_sha1(parents->sha1[i], sha1, "", opt);
+		diffcore_std(opt);
+		paths = intersect_paths(paths, i, num_parent);
+
+		/* if showing diff, show it in requested order */
+		if (opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
+		    orderfile) {
+			diffcore_order(orderfile);
+		}
+
+		diff_flush(opt);
+	}
+
+	opt->output_format = output_format;
+	opt->orderfile = orderfile;
+	return paths;
+}
+
+
 void diff_tree_combined(const unsigned char *sha1,
 			const struct sha1_array *parents,
 			int dense,
@@ -1310,7 +1354,7 @@ void diff_tree_combined(const unsigned char *sha1,
 {
 	struct diff_options *opt = &rev->diffopt;
 	struct diff_options diffopts;
-	struct combine_diff_path *p, *paths = NULL;
+	struct combine_diff_path *p, *paths;
 	int i, num_paths, needsep, show_log_first, num_parent = parents->nr;
 
 	/* nothing to do, if no parents */
@@ -1329,35 +1373,16 @@ void diff_tree_combined(const unsigned char *sha1,
 
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
-	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	DIFF_OPT_SET(&diffopts, RECURSIVE);
 	DIFF_OPT_CLR(&diffopts, ALLOW_EXTERNAL);
-	/* tell diff_tree to emit paths in sorted (=tree) order */
-	diffopts.orderfile = NULL;
 
-	/* find set of paths that everybody touches */
-	for (i = 0; i < num_parent; i++) {
-		/* show stat against the first parent even
-		 * when doing combined diff.
-		 */
-		int stat_opt = (opt->output_format &
-				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
-		if (i == 0 && stat_opt)
-			diffopts.output_format = stat_opt;
-		else
-			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_tree_sha1(parents->sha1[i], sha1, "", &diffopts);
-		diffcore_std(&diffopts);
-		paths = intersect_paths(paths, i, num_parent);
-
-		/* if showing diff, show it in requested order */
-		if (diffopts.output_format != DIFF_FORMAT_NO_OUTPUT &&
-		    opt->orderfile) {
-			diffcore_order(opt->orderfile);
-		}
-
-		diff_flush(&diffopts);
-	}
+	/* find set of paths that everybody touches
+	 *
+	 * NOTE find_paths() also handles --stat, as it computes
+	 * diff(sha1,parent_i) for all i to do the job, specifically
+	 * for parent0.
+	 */
+	paths = find_paths(sha1, parents, &diffopts);
 
 	/* find out number of surviving paths */
 	for (num_paths = 0, p = paths; p; p = p->next)
-- 
1.9.rc1.181.g641f458

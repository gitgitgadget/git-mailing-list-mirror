From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 04/11] tree-diff: move all action-taking code out of compare_tree_entry()
Date: Fri,  7 Feb 2014 21:48:45 +0400
Message-ID: <533204f5c956f2cb7442a48ac2a776eee4a43049.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWb-0000ZZ-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbaBGRr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:28 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33776 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbaBGRrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:19 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpWI-0002LB-8d; Fri, 07 Feb 2014 21:47:18 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpY4-0004AB-1p; Fri, 07 Feb 2014 21:49:08 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241781>

- let it do only comparison.

This way the code is cleaner and more structured - cmp function only
compares, and the driver takes action based on comparison result.

There should be no change in performance, as effectively, we just move
if series from on place into another, and merge it to was-already-there
same switch/if, so the result is maybe a little bit faster.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index c3fbfba..54a3d23 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -9,8 +9,7 @@
 static void show_path(struct strbuf *base, struct diff_options *opt,
 		      struct tree_desc *t1, struct tree_desc *t2);
 
-static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
-			      struct strbuf *base, struct diff_options *opt)
+static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
@@ -28,19 +27,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 	 * even when having the same name.
 	 */
 	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
-	if (cmp < 0) {
-		show_path(base, opt, t1, /*t2=*/NULL);
-		return -1;
-	}
-	if (cmp > 0) {
-		show_path(base, opt, /*t1=*/NULL, t2);
-		return 1;
-	}
-	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
-		return 0;
-
-	show_path(base, opt, t1, t2);
-	return 0;
+	return cmp;
 }
 
 
@@ -163,6 +150,8 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 	strbuf_add(&base, base_str, baselen);
 
 	for (;;) {
+		int cmp;
+
 		if (diff_can_quit_early(opt))
 			break;
 		if (opt->pathspec.nr) {
@@ -182,21 +171,28 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 			continue;
 		}
 
-		cmp = compare_tree_entry(t1, t2, &base, opt);
+		cmp = compare_tree_entry(t1, t2);
 
 		/* t1 = t2 */
 		if (cmp == 0) {
+			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
+			    hashcmp(t1->entry.sha1, t2->entry.sha1) ||
+			    (t1->entry.mode != t2->entry.mode))
+				show_path(&base, opt, t1, t2);
+
 			update_tree_entry(t1);
 			update_tree_entry(t2);
 		}
 
 		/* t1 < t2 */
 		else if (cmp < 0) {
+			show_path(&base, opt, t1, /*t2=*/NULL);
 			update_tree_entry(t1);
 		}
 
 		/* t1 > t2 */
 		else {
+			show_path(&base, opt, /*t1=*/NULL, t2);
 			update_tree_entry(t2);
 		}
 	}
-- 
1.9.rc1.181.g641f458

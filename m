From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 08/19] tree-diff: move all action-taking code out of compare_tree_entry()
Date: Mon, 24 Feb 2014 20:21:40 +0400
Message-ID: <d63db800c368a89a9620e07297136d43bf6f9ced.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHT-0003ZL-0V
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbaBXQVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:09 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34174 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbaBXQVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:07 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHB-000409-SJ; Mon, 24 Feb 2014 20:21:05 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyIr-00079o-1Y; Mon, 24 Feb 2014 20:22:49 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242599>

- let it do only comparison.

This way the code is cleaner and more structured - cmp function only
compares, and the driver takes action based on comparison result.

There should be no change in performance, as effectively, we just move
if series from on place into another, and merge it to was-already-there
same switch/if, so the result is maybe a little bit faster.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 5f7dbbf..6207372 100644
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
 
 
@@ -161,6 +148,8 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 	strbuf_add(&base, base_str, baselen);
 
 	for (;;) {
+		int cmp;
+
 		if (diff_can_quit_early(opt))
 			break;
 		if (opt->pathspec.nr) {
@@ -180,21 +169,28 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
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

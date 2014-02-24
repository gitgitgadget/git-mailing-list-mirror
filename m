From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 09/19] tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
Date: Mon, 24 Feb 2014 20:21:41 +0400
Message-ID: <c0c58e97d0ad8cec28704976b1a46dc6a8702f23.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHT-0003ZL-IT
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbaBXQVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:11 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34179 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbaBXQVK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:10 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHE-00040H-Ri; Mon, 24 Feb 2014 20:21:09 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyIu-00079r-12; Mon, 24 Feb 2014 20:22:52 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242600>

Since previous commit, this function does not compare entry hashes, and
mode are compared fully outside of it. So what it does is compare entry
names and DIR bit in modes. Reflect this in its name.

Add documentation stating the semantics, and move the note about
files/dirs comparison to it.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 6207372..3345534 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -9,7 +9,14 @@
 static void show_path(struct strbuf *base, struct diff_options *opt,
 		      struct tree_desc *t1, struct tree_desc *t2);
 
-static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2)
+/*
+ * Compare two tree entries, taking into account only path/S_ISDIR(mode),
+ * but not their sha1's.
+ *
+ * NOTE files and directories *always* compare differently, even when having
+ *      the same name - thanks to base_name_compare().
+ */
+static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
@@ -22,10 +29,6 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2)
 	pathlen1 = tree_entry_len(&t1->entry);
 	pathlen2 = tree_entry_len(&t2->entry);
 
-	/*
-	 * NOTE files and directories *always* compare differently,
-	 * even when having the same name.
-	 */
 	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
 	return cmp;
 }
@@ -169,7 +172,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 			continue;
 		}
 
-		cmp = compare_tree_entry(t1, t2);
+		cmp = tree_entry_pathcmp(t1, t2);
 
 		/* t1 = t2 */
 		if (cmp == 0) {
-- 
1.9.rc1.181.g641f458

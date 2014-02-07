From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 05/11] tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
Date: Fri,  7 Feb 2014 21:48:46 +0400
Message-ID: <dd82f6456fcd7efdbbd3ad82c364bc6974223f6c.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWr-0000ne-DY
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbaBGRrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:25 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33781 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaBGRrW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:22 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpWK-0002LG-Ts; Fri, 07 Feb 2014 21:47:21 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpY6-0004AE-My; Fri, 07 Feb 2014 21:49:10 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241783>

Since previous commit, this function does not compare entry hashes, and
mode are compared fully outside of it. So what it does is compare entry
names and DIR bit in modes. Reflect this in its name.

Add documentation stating the semantics, and move the note about
files/dirs comparison to it.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 54a3d23..df90bbe 100644
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
@@ -171,7 +174,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 			continue;
 		}
 
-		cmp = compare_tree_entry(t1, t2);
+		cmp = tree_entry_pathcmp(t1, t2);
 
 		/* t1 = t2 */
 		if (cmp == 0) {
-- 
1.9.rc1.181.g641f458

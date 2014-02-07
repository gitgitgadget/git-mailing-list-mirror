From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 03/11] tree-diff: don't assume compare_tree_entry() returns -1,0,1
Date: Fri,  7 Feb 2014 21:48:44 +0400
Message-ID: <e61a30650c98ba5a1f1a9cbc96c4ba4801cee72d.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWa-0000ZZ-G1
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbaBGRrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:20 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33773 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbaBGRrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:17 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpWF-0002L6-QJ; Fri, 07 Feb 2014 21:47:15 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpY1-0004A8-Jd; Fri, 07 Feb 2014 21:49:05 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241780>

It does, but we'll be reworking it in the next patch after it won't, and
besides it is better to stick to standard
strcmp/memcmp/base_name_compare/etc... convention, where comparison
function returns <0, =0, >0

Regarding performance, comparing for <0, =0, >0 should be a little bit
faster, than switch, because it is just 1 test-without-immediate
instruction and then up to 3 conditional branches, and in switch you
have up to 3 tests with immediate and up to 3 conditional branches.

No worry, that update_tree_entry(t2) is duplicated for =0 and >0 - it
will be good after we'll be adding support for multiparent walker and
will stay that way.

=0 case goes first, because it happens more often in real diffs - i.e.
paths are the same.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 0c8e3fc..c3fbfba 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -181,18 +181,24 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 			update_tree_entry(t1);
 			continue;
 		}
-		switch (compare_tree_entry(t1, t2, &base, opt)) {
-		case -1:
+
+		cmp = compare_tree_entry(t1, t2, &base, opt);
+
+		/* t1 = t2 */
+		if (cmp == 0) {
 			update_tree_entry(t1);
-			continue;
-		case 0:
+			update_tree_entry(t2);
+		}
+
+		/* t1 < t2 */
+		else if (cmp < 0) {
 			update_tree_entry(t1);
-			/* Fallthrough */
-		case 1:
+		}
+
+		/* t1 > t2 */
+		else {
 			update_tree_entry(t2);
-			continue;
 		}
-		die("git diff-tree: internal error");
 	}
 
 	strbuf_release(&base);
-- 
1.9.rc1.181.g641f458

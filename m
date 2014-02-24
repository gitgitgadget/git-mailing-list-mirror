From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 07/19] tree-diff: don't assume compare_tree_entry() returns -1,0,1
Date: Mon, 24 Feb 2014 20:21:39 +0400
Message-ID: <487b0970053a3190da57c30f521c39c23f85dcec.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHH-0003Pq-8e
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbaBXQVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:05 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34169 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbaBXQVD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:03 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyH8-000404-9o; Mon, 24 Feb 2014 20:21:02 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyIn-00079l-FE; Mon, 24 Feb 2014 20:22:45 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242596>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index a5b9ff9..5f7dbbf 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -179,18 +179,24 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
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

From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-base.c: pathological case fix.
Date: Thu, 11 Aug 2005 18:14:50 -0700
Message-ID: <7vk6isc5x1.fsf_-_@assigned-by-dhcp.cox.net>
References: <7virydlzal.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508110840080.3295@g5.osdl.org>
	<7vbr44f5s1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508111601000.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 03:15:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3O8N-0004ya-Kf
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 03:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVHLBOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 21:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVHLBOw
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 21:14:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49086 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932368AbVHLBOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 21:14:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812011451.QBSU1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 21:14:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508111601000.3295@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 11 Aug 2005 16:05:44 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Also add some illustration requested by Linus.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 merge-base.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 68 insertions(+), 6 deletions(-)

5cbb01b3bb1828759596bff71e16cfcee798491c
diff --git a/merge-base.c b/merge-base.c
--- a/merge-base.c
+++ b/merge-base.c
@@ -6,18 +6,82 @@
 #define PARENT2 2
 #define UNINTERESTING 4
 
-static int interesting(struct commit_list *list)
+static struct commit *interesting(struct commit_list *list)
 {
 	while (list) {
 		struct commit *commit = list->item;
 		list = list->next;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
-		return 1;
+		return commit;
 	}
-	return 0;
+	return NULL;
 }
 
+/*
+ * A pathological example of how this thing works.
+ *
+ * Suppose we had this commit graph, where chronologically
+ * the timestamp on the commit are A <= B <= C <= D <= E <= F
+ * and we are trying to figure out the merge base for E and F
+ * commits.
+ *
+ *                  F
+ *                 / \
+ *            E   A   D
+ *             \ /   /  
+ *              B   /
+ *               \ /
+ *                C
+ *
+ * First we push E and F to list to be processed.  E gets bit 1
+ * and F gets bit 2.  The list becomes:
+ *
+ *     list=F(2) E(1), result=empty
+ *
+ * Then we pop F, the newest commit, from the list.  Its flag is 2.
+ * We scan its parents, mark them reachable from the side that F is
+ * reachable from, and push them to the list:
+ *
+ *     list=E(1) D(2) A(2), result=empty
+ *
+ * Next pop E and do the same.
+ *
+ *     list=D(2) B(1) A(2), result=empty
+ *
+ * Next pop D and do the same.
+ *
+ *     list=C(2) B(1) A(2), result=empty
+ *
+ * Next pop C and do the same.
+ *
+ *     list=B(1) A(2), result=empty
+ *
+ * Now it is B's turn.  We mark its parent, C, reachable from B's side,
+ * and push it to the list:
+ *
+ *     list=C(3) A(2), result=empty
+ *
+ * Now pop C and notice it has flags==3.  It is placed on the result list,
+ * and the list now contains:
+ *
+ *     list=A(2), result=C(3)
+ *
+ * We pop A and do the same.
+ * 
+ *     list=B(3), result=C(3)
+ *
+ * Next, we pop B and something very interesting happens.  It has flags==3
+ * so it is also placed on the result list, and its parents are marked
+ * uninteresting, retroactively, and placed back on the list:
+ *
+ *    list=C(7), result=C(7) B(3)
+ * 
+ * Now, list does not have any interesting commit.  So we find the newest
+ * commit from the result list that is not marked uninteresting.  Which is
+ * commit B.
+ */
+
 static struct commit *common_ancestor(struct commit *rev1, struct commit *rev2)
 {
 	struct commit_list *list = NULL;
@@ -58,9 +122,7 @@ static struct commit *common_ancestor(st
 			insert_by_date(p, &list);
 		}
 	}
-	if (!result)
-		return NULL;
-	return result->item;
+	return interesting(result);
 }
 
 int main(int argc, char **argv)

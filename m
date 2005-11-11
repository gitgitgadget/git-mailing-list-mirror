From: Junio C Hamano <junkio@cox.net>
Subject: merge-base: fully contaminate the well.
Date: Thu, 10 Nov 2005 18:58:07 -0800
Message-ID: <7vzmobuc00.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108210211.GA23265@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
	<20051108223609.GA4805@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
	<20051109003236.GA30496@pasky.or.cz>
	<Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
	<7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
	<7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net>
	<7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511090800330.3247@g5.osdl.org>
	<7virv1efzv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511091348530.4627@g5.osdl.org>
	<7virv1a0ro.fsf@assigned-by-dhcp.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 03:59:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaP7P-0002pR-JO
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 03:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVKKC6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 21:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVKKC6K
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 21:58:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:9348 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932289AbVKKC6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 21:58:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111025735.CGB4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 21:57:35 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11552>

The discussion on the list demonstrated a pathological case where
an ancestor of a merge-base can be left interesting.  This commit
introduces a postprocessing phase to fix it.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Linus Torvalds <torvalds@osdl.org> writes:

  > On Wed, 9 Nov 2005, Junio C Hamano wrote:
  >
  >> But the point of well-poisoning you did in merge-base was to
  >> detect that E is an ancestor of B and exclude it in the first
  >> place.
  >
  > Ahh, you're right, and I'm wrong. That "E" is not a real merge-base, since 
  > there _is_ a valid merge-base that is a direct descendant of it and thus 
  > objectively better.
  >
  > Which means that sometimes it can stop with too _many_ merge heads, just 
  > because it hasn't realized that they are reachable through a chain that is 
  > otherwise provably uninteresting.

  I am not particularly proud of this change, but here is an
  attempt to fully contaminate the well without going all the
  way down to root.  It adds a postprocessing phase which does
  not parse any new commits.

  > The thing is, I don't see what guarantees that the show-branch brhaviour 
  > is safe or conservative.

  You are right about this; I have a separate patch to fix it.


 merge-base.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 1 deletions(-)

applies-to: 8eacf17303188e55375f76bea8051555ba1baf02
a2fd94f707128f3f390362725c8d8b0802940111
diff --git a/merge-base.c b/merge-base.c
index 286bf0e..43a6818 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -80,6 +80,45 @@ static struct commit *interesting(struct
  * Now, list does not have any interesting commit.  So we find the newest
  * commit from the result list that is not marked uninteresting.  Which is
  * commit B.
+ *
+ *
+ * Another pathological example how this thing can fail to mark an ancestor
+ * of a merge base as UNINTERESTING without the postprocessing phase.
+ *
+ *		  2
+ *		  H
+ *	    1    / \
+ *	    G   A   \
+ *	    |\ /     \ 
+ *	    | B       \
+ *	    |  \       \
+ *	     \  C       F
+ *	      \  \     / 
+ *	       \  D   /   
+ *		\ |  /
+ *		 \| /
+ *		  E
+ *
+ *	 list			A B C D E F G H
+ *	 G1 H2			- - - - - - 1 2
+ *	 H2 E1 B1		- 1 - - 1 - 1 2
+ *	 F2 E1 B1 A2		2 1 - - 1 2 1 2
+ *	 E3 B1 A2		2 1 - - 3 2 1 2
+ *	 B1 A2			2 1 - - 3 2 1 2
+ *	 C1 A2			2 1 1 - 3 2 1 2
+ *	 D1 A2			2 1 1 1 3 2 1 2
+ *	 A2			2 1 1 1 3 2 1 2
+ *	 B3			2 3 1 1 3 2 1 2
+ *	 C7			2 3 7 1 3 2 1 2
+ *
+ * At this point, unfortunately, everybody in the list is
+ * uninteresting, so we fail to complete the following two
+ * steps to fully marking uninteresting commits.
+ *
+ *	 D7			2 3 7 7 3 2 1 2
+ *	 E7			2 3 7 7 7 2 1 2
+ *
+ * and we end up showing E as an interesting merge base.
  */
 
 static int show_all = 0;
@@ -88,6 +127,7 @@ static int merge_base(struct commit *rev
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
+	struct commit_list *tmp = NULL;
 
 	if (rev1 == rev2) {
 		printf("%s\n", sha1_to_hex(rev1->object.sha1));
@@ -104,9 +144,10 @@ static int merge_base(struct commit *rev
 
 	while (interesting(list)) {
 		struct commit *commit = list->item;
-		struct commit_list *tmp = list, *parents;
+		struct commit_list *parents;
 		int flags = commit->object.flags & 7;
 
+		tmp = list;
 		list = list->next;
 		free(tmp);
 		if (flags == 3) {
@@ -130,6 +171,41 @@ static int merge_base(struct commit *rev
 	if (!result)
 		return 1;
 
+	/*
+	 * Postprocess to fully contaminate the well.
+	 */
+	for (tmp = result; tmp; tmp = tmp->next) {
+		struct commit *c = tmp->item;
+		/* Reinject uninteresting ones to list,
+		 * so we can scan their parents.
+		 */
+		if (c->object.flags & UNINTERESTING)
+			commit_list_insert(c, &list);
+	}
+	while (list) {
+		struct commit *c = list->item;
+		struct commit_list *parents;
+
+		tmp = list;
+		list = list->next;
+		free(tmp);
+
+		/* Anything taken out of the list is uninteresting, so
+		 * mark all its parents uninteresting.  We do not
+		 * parse new ones (we already parsed all the relevant
+		 * ones).
+		 */
+		parents = c->parents;
+		while (parents) {
+			struct commit *p = parents->item;
+			parents = parents->next;
+			if (!(p->object.flags & UNINTERESTING)) {
+				p->object.flags |= UNINTERESTING;
+				commit_list_insert(p, &list);
+			}
+		}
+	}
+
 	while (result) {
 		struct commit *commit = result->item;
 		result = result->next;
---
0.99.9.GIT

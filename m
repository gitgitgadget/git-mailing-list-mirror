From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 02 Jul 2006 11:28:00 -0700
Message-ID: <7vmzbr50b3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
	<44A6CD1D.2000600@lsrfire.ath.cx>
	<Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
	<7vveqhccnk.fsf@assigned-by-dhcp.cox.net>
	<7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
	<20060702094938.GA10944@lsrfire.ath.cx>
	<Pine.LNX.4.64.0607020935460.12404@g5.osdl.org>
	<44A8051D.6040605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 20:28:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx6fx-0001Eg-61
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 20:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWGBS2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 14:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWGBS2F
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 14:28:05 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58341 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964874AbWGBS2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 14:28:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702182802.HFCS19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 14:28:02 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44A8051D.6040605@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sun, 02 Jul 2006 19:40:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23111>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> I suspect the only way to fix that is to make "get_merge_bases()" not use 
>> UNINTERESTING at all, but instead just explicitly use something like
>
> No and yes.  Patch 1 in the 3+1 series changes the flags used in
> commit.c to not conflict with the ones in revision.h[*].  So we have two
> different UNINTERESTINGs, and get_merge_bases() doesn't mess up the
> show/no-show markings.

Gaah.  commit.c defines its own UNINTERESTING and you rely on
not including revision.h which is ... gasp ... #$@#$!!!

Could we do something like this, pretty please?

---
diff --git a/commit.c b/commit.c
index 94c1d0e..a608faf 100644
--- a/commit.c
+++ b/commit.c
@@ -851,14 +851,14 @@ void sort_in_topological_order_fn(struct
 /* bits #0..7 in revision.h */
 #define PARENT1		(1u<< 8)
 #define PARENT2		(1u<< 9)
-#define UNINTERESTING	(1u<<10)
+#define STALE		(1u<<10)
 
 static struct commit *interesting(struct commit_list *list)
 {
 	while (list) {
 		struct commit *commit = list->item;
 		list = list->next;
-		if (commit->object.flags & UNINTERESTING)
+		if (commit->object.flags & STALE)
 			continue;
 		return commit;
 	}
@@ -920,17 +920,17 @@ static struct commit *interesting(struct
  *
  * Next, we pop B and something very interesting happens.  It has flags==3
  * so it is also placed on the result list, and its parents are marked
- * uninteresting, retroactively, and placed back on the list:
+ * stale, retroactively, and placed back on the list:
  *
  *    list=C(7), result=C(7) B(3)
  *
  * Now, list does not have any interesting commit.  So we find the newest
- * commit from the result list that is not marked uninteresting.  Which is
+ * commit from the result list that is not marked stale.  Which is
  * commit B.
  *
  *
  * Another pathological example how this thing used to fail to mark an
- * ancestor of a merge base as UNINTERESTING before we introduced the
+ * ancestor of a merge base as STALE before we introduced the
  * postprocessing phase (mark_reachable_commits).
  *
  *		  2
@@ -960,8 +960,8 @@ static struct commit *interesting(struct
  *	 C7			2 3 7 1 3 2 1 2
  *
  * At this point, unfortunately, everybody in the list is
- * uninteresting, so we fail to complete the following two
- * steps to fully marking uninteresting commits.
+ * stale, so we fail to complete the following two
+ * steps to fully marking stale commits.
  *
  *	 D7			2 3 7 7 3 2 1 2
  *	 E7			2 3 7 7 7 2 1 2
@@ -981,10 +981,10 @@ static void mark_reachable_commits(struc
 	 */
 	for (tmp = result; tmp; tmp = tmp->next) {
 		struct commit *c = tmp->item;
-		/* Reinject uninteresting ones to list,
+		/* Reinject stale ones to list,
 		 * so we can scan their parents.
 		 */
-		if (c->object.flags & UNINTERESTING)
+		if (c->object.flags & STALE)
 			commit_list_insert(c, &list);
 	}
 	while (list) {
@@ -995,8 +995,8 @@ static void mark_reachable_commits(struc
 		list = list->next;
 		free(tmp);
 
-		/* Anything taken out of the list is uninteresting, so
-		 * mark all its parents uninteresting.  We do not
+		/* Anything taken out of the list is stale, so
+		 * mark all its parents stale.  We do not
 		 * parse new ones (we already parsed all the relevant
 		 * ones).
 		 */
@@ -1004,8 +1004,8 @@ static void mark_reachable_commits(struc
 		while (parents) {
 			struct commit *p = parents->item;
 			parents = parents->next;
-			if (!(p->object.flags & UNINTERESTING)) {
-				p->object.flags |= UNINTERESTING;
+			if (!(p->object.flags & STALE)) {
+				p->object.flags |= STALE;
 				commit_list_insert(p, &list);
 			}
 		}
@@ -1034,7 +1034,7 @@ struct commit_list *get_merge_bases(stru
 		struct commit *commit = list->item;
 		struct commit_list *parents;
 		int flags = commit->object.flags
-			& (PARENT1 | PARENT2 | UNINTERESTING);
+			& (PARENT1 | PARENT2 | STALE);
 
 		tmp = list;
 		list = list->next;
@@ -1042,8 +1042,8 @@ struct commit_list *get_merge_bases(stru
 		if (flags == (PARENT1 | PARENT2)) {
 			insert_by_date(commit, &result);
 
-			/* Mark parents of a found merge uninteresting */
-			flags |= UNINTERESTING;
+			/* Mark parents of a found merge stale */
+			flags |= STALE;
 		}
 		parents = commit->parents;
 		while (parents) {
@@ -1067,7 +1067,7 @@ struct commit_list *get_merge_bases(stru
 	for (tmp = result, list = NULL; tmp; ) {
 		struct commit *commit = tmp->item;
 		struct commit_list *next = tmp->next;
-		if (commit->object.flags & UNINTERESTING) {
+		if (commit->object.flags & STALE) {
 			if (list != NULL)
 				list->next = next;
 			free(tmp);
@@ -1075,15 +1075,15 @@ struct commit_list *get_merge_bases(stru
 			if (list == NULL)
 				result = tmp;
 			list = tmp;
-			commit->object.flags |= UNINTERESTING;
+			commit->object.flags |= STALE;
 		}
 
 		tmp = next;
 	}
 
 	if (cleanup) {
-		clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
-		clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
+		clear_commit_marks(rev1, PARENT1 | PARENT2 | STALE);
+		clear_commit_marks(rev2, PARENT1 | PARENT2 | STALE);
 	}
 
 	return result;

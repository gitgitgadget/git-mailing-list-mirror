From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list bug?
Date: Fri, 10 Mar 2006 02:25:04 -0800
Message-ID: <7vslpqy4u7.fsf@assigned-by-dhcp.cox.net>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
	<7vacc0iten.fsf@assigned-by-dhcp.cox.net>
	<7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net>
	<7virqmzlhb.fsf@assigned-by-dhcp.cox.net>
	<7v4q26zklx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 10 11:25:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHeoA-0005UT-90
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 11:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWCJKZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 05:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbWCJKZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 05:25:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45553 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751976AbWCJKZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 05:25:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060310102310.KFVQ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Mar 2006 05:23:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4q26zklx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 10 Mar 2006 01:59:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17467>

Junio C Hamano <junkio@cox.net> writes:

> It however has a side effect -- uninteresting commits were never
> parsed here, but now they get parsed.  I am not sure if there
> are correctness implications...

Actually there is.  If a merge with an uninteresting side branch
was the only thing that brought changes to paths we are
interested in, we do not want TREE_SAME logic to remove other
parents (i.e. the branches we are interested in) from the merge
commit.  

So we would need a combination of both, something like this?

---
diff --git a/revision.c b/revision.c
index 713f27e..c8d93ff 100644
--- a/revision.c
+++ b/revision.c
@@ -282,6 +282,7 @@ static int same_tree_as_empty(struct tre
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
+	int tree_changed = 0;
 
 	if (!commit->tree)
 		return;
@@ -296,14 +297,19 @@ static void try_to_simplify_commit(struc
 	while ((parent = *pp) != NULL) {
 		struct commit *p = parent->item;
 
-		if (p->object.flags & UNINTERESTING) {
-			pp = &parent->next;
-			continue;
-		}
-
 		parse_commit(p);
 		switch (compare_tree(p->tree, commit->tree)) {
 		case TREE_SAME:
+			if (p->object.flags & UNINTERESTING) {
+				/* Even if a merge with an uninteresting
+				 * side branch brought the entire change
+				 * we are interested in, we do not want
+				 * to lose the other branches of this
+				 * merge, so we just keep going.
+				 */
+				pp = &parent->next;
+				continue;
+			}
 			parent->next = NULL;
 			commit->parents = parent;
 			return;
@@ -315,12 +321,14 @@ static void try_to_simplify_commit(struc
 			}
 		/* fallthrough */
 		case TREE_DIFFERENT:
+			tree_changed = 1;
 			pp = &parent->next;
 			continue;
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	commit->object.flags |= TREECHANGE;
+	if (tree_changed)
+		commit->object.flags |= TREECHANGE;
 }
 
 static void add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)

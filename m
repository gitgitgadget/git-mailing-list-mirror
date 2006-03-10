From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list bug?
Date: Fri, 10 Mar 2006 01:40:16 -0800
Message-ID: <7virqmzlhb.fsf@assigned-by-dhcp.cox.net>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
	<7vacc0iten.fsf@assigned-by-dhcp.cox.net>
	<7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 10 10:40:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHe6i-0001B7-Q8
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 10:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbWCJJkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 04:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWCJJkT
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 04:40:19 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:56765 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1752103AbWCJJkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 04:40:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060310093650.UAPD17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Mar 2006 04:36:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 10 Mar 2006 00:20:40 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17465>

Junio C Hamano <junkio@cox.net> writes:

> To my surprise, it turns out that this regression was not very
> recent.  Bisecting points at this commite:
>...
> I haven't had time to dig into this deeper yet...


I am wondering why try_to_simplify_commit() skips parents marked
with UNINTERESTING.  I think this is causing a problem Catalin
found with rev-list.

If you have (time flows from top to bottom):

	commit#1	(it does not matter what this does)
        commit#2        change file B only
        commit#3	change file A only
        commit#4	change file B only

"git-rev-list commit#1..commit#4 -- A" shows commit#3 (correct)
and commit#2 (incorrect).

It pushes commit#1 (UNINTERESTING) and commit#4 (~UNINTERESTING)
and starts traversing.  try-to-simplify(commit#4) says "no tree
change between #3 and #4" and it returns without marking
commit#4 with TREECHANGE flag.  But when looking at commit#2 and
trying to simplify it, it says "Ah, its parent is uninteresting,
so I would not do compare_tree()".  Iteration over parents of
commit#2 leaves the while() loop and at the end of function the
commit is marked with TREECHANGE and is shown.

The attached patch seems to fix it (without losing the logic to
omit tree comparison with UNINTERESTING parent, which I do not
quite understand).



---
diff --git a/revision.c b/revision.c
index 713f27e..23c9b9d 100644
--- a/revision.c
+++ b/revision.c
@@ -282,6 +282,7 @@ static int same_tree_as_empty(struct tre
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
+	int changed = 0;
 
 	if (!commit->tree)
 		return;
@@ -315,12 +316,14 @@ static void try_to_simplify_commit(struc
 			}
 		/* fallthrough */
 		case TREE_DIFFERENT:
+			changed = 1;
 			pp = &parent->next;
 			continue;
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	commit->object.flags |= TREECHANGE;
+	if (changed)
+		commit->object.flags |= TREECHANGE;
 }
 
 static void add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)

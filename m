From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] git log --first-parent
Date: Tue, 13 Mar 2007 01:55:36 -0700
Message-ID: <7vfy89ldyv.fsf_-_@assigned-by-dhcp.cox.net>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
	<20070311160424.GA629@fieldses.org>
	<200703111815.l2BIFHbq010315@localhost.localdomain>
	<Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
	<7vwt1nv6r5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 09:55:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR2nF-0004hL-H6
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 09:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbXCMIzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 04:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbXCMIzj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 04:55:39 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49810 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbXCMIzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 04:55:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313085535.UBUD1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Mar 2007 04:55:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a8vd1W0051kojtg0000000; Tue, 13 Mar 2007 04:55:37 -0400
In-Reply-To: <7vwt1nv6r5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 11 Mar 2007 13:56:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42109>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Comments? Do people think it would be a good idea to do
>>
>> 	git merge --no-fast-forward -m "Merge feature Xyz" xyz-branch
>>
>> as an option?
>>
>> 			Linus
>
> For one thing, this would make the earlier "first parent log
> summary" idea useful again.

While I was writing "What's cooking" tonight, I came up with
this patch so that I can view what's in topic branches.

This time somehow I ended up having to cross merge a few topics
(e.g. jc/fetch which is the partial C rewrite has been cooking
long enough that merging 'master' to get Nico's OBJ_TYPE
cleanups has become useful), and also 'next' is a pure
integration branch, and it turns out that reviewing them with

	$ git log --first-parent master..jc/fetch

was easier to view what really was going on on that particular
topic, without getting distracted with what was merged from
sideways.

---

diff --git a/revision.c b/revision.c
index 3c2eb12..8afc196 100644
--- a/revision.c
+++ b/revision.c
@@ -350,6 +350,7 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
+	int add, rest;
 
 	if (commit->object.flags & ADDED)
 		return;
@@ -395,18 +396,19 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 		return;
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
-	parent = commit->parents;
-	while (parent) {
+
+	rest = !revs->first_parent_only;
+	for (parent = commit->parents, add = 1; parent; add = rest) {
 		struct commit *p = parent->item;
 
 		parent = parent->next;
-
 		parse_commit(p);
 		p->object.flags |= left_flag;
 		if (p->object.flags & SEEN)
 			continue;
 		p->object.flags |= SEEN;
-		insert_by_date(p, list);
+		if (add)
+			insert_by_date(p, list);
 	}
 }
 
@@ -836,6 +838,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_all(revs, flags);
 				continue;
 			}
+			if (!strcmp(arg, "--first-parent")) {
+				revs->first_parent_only = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
diff --git a/revision.h b/revision.h
index 6ae39e6..55e6b53 100644
--- a/revision.h
+++ b/revision.h
@@ -46,7 +46,8 @@ struct rev_info {
 			boundary:2,
 			left_right:1,
 			parents:1,
-			reverse:1;
+			reverse:1,
+			first_parent_only:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,

From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [updated PATCH] Simplify and fix --first-parent implementation
Date: Sun, 27 Apr 2008 19:32:46 +0200
Message-ID: <20080427173246.10023.45426.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:33:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAku-0005Ea-9p
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbYD0Rcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756602AbYD0Rcv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:32:51 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43457 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbYD0Rcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:32:51 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 7B5435460; Sun, 27 Apr 2008 19:32:46 +0200 (CEST)
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80459>

The purpose of --first-parent is to simplify the tree into a tree without
 merges.  This is accomplished by pretending there are no other parents
than the first parent when encountering a merge.  In order to implement
this correctly the behaviour should be such that the tree traversal does
not depend on any parent other than the first.

The old code marked the other parents as seen, which means that the tree
traversal (under certain circumstances) will behave differently depending
on which merges have been done, therefore violating the rule that only the
first parent should be relevant.

Case in point, given the following tree:

       -----
      /     \
 D---E---F---G master

The current first-parent code considers E to be seen and stops the
traversal after showing G and F.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 revision.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)


diff --git a/revision.c b/revision.c
index 4231ea2..bcfcd2a 100644
--- a/revision.c
+++ b/revision.c
@@ -415,7 +415,6 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
-	int add, rest;
 
 	if (commit->object.flags & ADDED)
 		return 0;
@@ -462,19 +461,18 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
 
-	rest = !revs->first_parent_only;
-	for (parent = commit->parents, add = 1; parent; add = rest) {
+	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 
-		parent = parent->next;
 		if (parse_commit(p) < 0)
 			return -1;
 		p->object.flags |= left_flag;
 		if (p->object.flags & SEEN)
 			continue;
 		p->object.flags |= SEEN;
-		if (add)
-			insert_by_date(p, list);
+		insert_by_date(p, list);
+		if(revs->first_parent_only)
+			break;
 	}
 	return 0;
 }

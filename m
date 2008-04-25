From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH] Simplify and fix --first-parent implementation
Date: Fri, 25 Apr 2008 20:10:46 +0200
Message-ID: <20080425234556.D60FD5461@aristoteles.cuci.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:46:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpXcw-0004gI-A7
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 01:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761537AbYDYXqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 19:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762100AbYDYXqB
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 19:46:01 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:56105 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759933AbYDYXp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 19:45:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id D60FD5461; Sat, 26 Apr 2008 01:45:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80354>

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
-- 
1.5.5.1.83.ge77a4.dirty

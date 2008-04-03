From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH] Check for circular references causing 'lost' nodes
Date: Thu, 3 Apr 2008 10:48:38 +0200
Message-ID: <20080425234556.C271E545D@aristoteles.cuci.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:46:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpXcx-0004gI-2J
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 01:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762100AbYDYXqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 19:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762120AbYDYXqD
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 19:46:03 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:56103 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761263AbYDYXp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 19:45:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id C271E545D; Sat, 26 Apr 2008 01:45:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80356>

---
 commit.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 94d5b3d..7524d2b 100644
--- a/commit.c
+++ b/commit.c
@@ -426,6 +426,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	struct commit_list *next, *orig = *list;
 	struct commit_list *work, **insert;
 	struct commit_list **pptr;
+	int nelements = 0;
 
 	if (!orig)
 		return;
@@ -436,6 +437,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		struct commit *commit = next->item;
 		commit->object.flags |= TOPOSORT;
 		commit->indegree = 0;
+		nelements++;
 	}
 
 	/* update the indegree */
@@ -506,7 +508,11 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		commit->object.flags &= ~TOPOSORT;
 		*pptr = work_item;
 		pptr = &work_item->next;
+		nelements--;
 	}
+	if (nelements)
+		fprintf(stderr, "Circular references in %d suppressed nodes\n",
+		 nelements);
 }
 
 /* merge-base stuff */
-- 
1.5.5.1.83.ge77a4.dirty

From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [updated PATCH] Check for circular references causing 'lost' nodes
Date: Sun, 27 Apr 2008 19:32:46 +0200
Message-ID: <20080427173246.10023.36908.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:33:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAkv-0005Ea-JA
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbYD0Rcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756949AbYD0Rcx
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:32:53 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43460 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbYD0Rcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:32:51 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 657DC545D; Sun, 27 Apr 2008 19:32:46 +0200 (CEST)
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80461>

The most likely cause for circular references are bad entries in the
grafts file; since basically noone tells you where you went wrong, it
can be a bit puzzling to find out that part of your tree goes dark
sometimes, depending on which tool/options you pick to walk the
commit-tree (most notably, things go wrong when using --topo-order even
though things *seem* allright without that option).

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 commit.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/commit.c b/commit.c
index 94d5b3d..a3afad7 100644
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
@@ -506,7 +508,12 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		commit->object.flags &= ~TOPOSORT;
 		*pptr = work_item;
 		pptr = &work_item->next;
+		nelements--;
 	}
+	if (nelements)
+		fprintf(stderr,
+		 "Circular references resulting in %d suppressed nodes\n",
+		 nelements);
 }
 
 /* merge-base stuff */

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] sort_in_topological_order(): avoid setting a commit
 flag
Date: Wed, 23 Jul 2008 01:51:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230150480.8986@racer>
References: <alpine.DEB.1.00.0807230148130.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: pasky@suse.cz, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 23 02:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSaq-0006Q1-Jd
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbYGWAvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbYGWAvg
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:51:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:49706 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751856AbYGWAvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:51:36 -0400
Received: (qmail invoked by alias); 23 Jul 2008 00:51:34 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp024) with SMTP; 23 Jul 2008 02:51:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JNW1n7TnJfW8yOK6ZZn9cv3yS2HGUsX7BE4nEaZ
	CucYD0MetOXT7+
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807230148130.8986@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89582>


We used to set the TOPOSORT flag of commits during the topological
sorting, but we can just as well use the member "indegree" for it:
indegree is now incremented by 1 in the cases where the commit used
to have the TOPOSORT flag.

This is the same behavior as before, since indegree could not be
non-zero when TOPOSORT was unset.

Incidentally, this fixes the bug in show-branch where the 8th column
was not shown: show-branch sorts the commits in topological order,
assuming that all the commit flags are available for show-branch's
private matters.

But this was not true: TOPOSORT was identical to the flag corresponding
to the 8th ref.  So the flags for the 8th column were unset by the
topological sorting.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is another late-night patch done by yours-truly.  However,
	I tried extra hard to make sure that every occurrence of
	indegree was properly changed, and I am pretty certain that
	the reasoning with the unset TOPOSORT is correct.

	But please check (I know, not necessary to ask for extra review
	for my patches,	but nevertheless).

 commit.c                       |   13 ++++++-------
 revision.h                     |    3 +--
 t/t3202-show-branch-octopus.sh |    2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index 5148ec5..9dacfb8 100644
--- a/commit.c
+++ b/commit.c
@@ -436,8 +436,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
-		commit->object.flags |= TOPOSORT;
-		commit->indegree = 0;
+		commit->indegree = 1;
 	}
 
 	/* update the indegree */
@@ -446,7 +445,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		while (parents) {
 			struct commit *parent = parents->item;
 
-			if (parent->object.flags & TOPOSORT)
+			if (parent->indegree)
 				parent->indegree++;
 			parents = parents->next;
 		}
@@ -464,7 +463,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
-		if (!commit->indegree)
+		if (commit->indegree == 1)
 			insert = &commit_list_insert(commit, insert)->next;
 	}
 
@@ -486,7 +485,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent=parents->item;
 
-			if (!(parent->object.flags & TOPOSORT))
+			if (!parent->indegree)
 				continue;
 
 			/*
@@ -494,7 +493,8 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 			 * when all their children have been emitted thereby
 			 * guaranteeing topological order.
 			 */
-			if (!--parent->indegree) {
+			if (--parent->indegree == 1) {
+				parent->indegree = 0;
 				if (!lifo)
 					insert_by_date(parent, &work);
 				else
@@ -505,7 +505,6 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		 * work_item is a commit all of whose children
 		 * have already been emitted. we can emit it now.
 		 */
-		commit->object.flags &= ~TOPOSORT;
 		*pptr = work_item;
 		pptr = &work_item->next;
 	}
diff --git a/revision.h b/revision.h
index fa68c65..f64e8ce 100644
--- a/revision.h
+++ b/revision.h
@@ -12,8 +12,7 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define TOPOSORT	(1u<<9)	/* In the active toposort list.. */
-#define ALL_REV_FLAGS	((1u<<10)-1)
+#define ALL_REV_FLAGS	((1u<<9)-1)
 
 struct rev_info;
 struct log_info;
diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch-octopus.sh
index 8d50c23..7fe4a6e 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch-octopus.sh
@@ -49,7 +49,7 @@ cat > expect << EOF
 +++++++++* [branch10^] initial
 EOF
 
-test_expect_failure 'show-branch with more than 8 branches' '
+test_expect_success 'show-branch with more than 8 branches' '
 
 	git show-branch $(for i in $numbers; do echo branch$i; done) > out &&
 	test_cmp expect out
-- 
1.6.0.rc0.22.gf2096d.dirty

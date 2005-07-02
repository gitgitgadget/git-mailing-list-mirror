From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 8/8] Removes support for O(n^2) algorithm from git-rev-list completely [rev 2]
Date: Sat, 02 Jul 2005 15:38:15 +1000
Message-ID: <20050702053815.11579.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sat Jul 02 07:31:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Doaar-000898-Bj
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 07:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVGBFir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 01:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVGBFir
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 01:38:47 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:18306 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261805AbVGBFiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 01:38:18 -0400
Received: (qmail 11589 invoked by uid 500); 2 Jul 2005 05:38:15 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch completely removes support for the O(n^2) bisection
algorithm from commit.c, commit.h and rev-list.c

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Linus: I have included this patch to allow you to easily remove the O(n^2)
algorithm if that is your choice. I am not expecting you to do so.

[rev 2] 
	* re-issued to cope with re-issue of immediately preceding patch
---

 commit.c                   |   31 -------------------------------
 commit.h                   |    7 -------
 rev-list.c                 |    7 -------
 t/t6002-rev-list-bisect.sh |    1 -
 4 files changed, 0 insertions(+), 46 deletions(-)

612b72335b99071c7f825b3633f241c4d12dfe6e
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -504,37 +504,6 @@ static void clear_distance(struct commit
 	}
 }
 
-struct commit_list *find_bisection(struct commit_list *list)
-{
-	int nr, closest;
-	struct commit_list *p, *best;
-
-	nr = 0;
-	p = list;
-	while (p) {
-		nr++;
-		p = p->next;
-	}
-	closest = 0;
-	best = list;
-
-	p = list;
-	while (p) {
-		int distance = count_distance(p);
-		clear_distance(list);
-		if (nr - distance < distance)
-			distance = nr - distance;
-		if (distance > closest) {
-			best = p;
-			closest = distance;
-		}
-		p = p->next;
-	}
-	if (best)
-		best->next = NULL;
-	return best;
-}
-
 static inline struct bisect_by_cut_node * get_bisect_by_cut_node(struct commit * commit)
 {
 	return (struct bisect_by_cut_node *)commit->object.util;
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -74,13 +74,6 @@ int count_parents(struct commit * commit
 void sort_in_topological_order(struct commit_list ** list);
 
 /*
- * Uses an O(n^2) algorithm to find the commit that bisects 
- * the subgraph represented by the list of commits. The boundaries
- * of the subgraph are delimited by adjacent nodes that have
- */
-struct commit_list *find_bisection(struct commit_list *list);
-
-/*
  * Uses O(n) to find the bisection of a list of commits
  * which is already sorted in topological order.
  */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -19,7 +19,6 @@ static const char rev_list_usage[] =
                       "  --bisect\n"
 		      "  --merge-order [ --show-breaks ]";
 
-static int bisect_list = 0;
 static int tag_objects = 0;
 static int tree_objects = 0;
 static int blob_objects = 0;
@@ -252,8 +251,6 @@ struct commit_list *limit_list(struct co
 		}
 		p = &commit_list_insert(commit, p)->next;
 	}
-	if (bisect_list)
-		newlist = find_bisection(newlist);
 	return newlist;
 }
 
@@ -370,10 +367,6 @@ int main(int argc, char **argv)
 			bisect_by_cut_option = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--bisect-orig")) {
-			bisect_list = 1;
-			continue;
-		}
 		if (!strcmp(arg, "--objects")) {
 			tag_objects = 1;
 			tree_objects = 1;
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -241,7 +241,6 @@ EOF
 }
 
 test_sequence "--bisect"
-test_sequence "--bisect-orig"
 
 #
 #
------------

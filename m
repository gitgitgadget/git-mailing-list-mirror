From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] topo-order: make --date-order optional.
Date: Wed, 15 Feb 2006 22:18:29 -0800
Message-ID: <7vbqx7keru.fsf@assigned-by-dhcp.cox.net>
References: <17395.58926.26670.23572@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 07:18:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9cTZ-0007v0-J3
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 07:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWBPGSb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 01:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWBPGSb
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 01:18:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1224 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750957AbWBPGSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 01:18:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216061558.DGGC17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 01:15:58 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17395.58926.26670.23572@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Thu, 16 Feb 2006 13:40:46 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16271>

This adds --date-order to rev-list; it is similar to topo order
in the sense that no parent comes before all of its children,
but otherwise things are still ordered in the commit timestamp
order.

The same flag is also added to show-branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Paul, this supersedes the previous one, which made topo-order
   behave date-order unconditionally.

   The thing is, topological ordering code has a nice property
   that the equally eligible ones are pushed into a LIFO, which
   keeps single strand of pearls together and as good as the
   merge order for practical purposes.  Doing date-order breaks
   it.  Since we would want both, there is a new option as you
   originally wanted.

   I've tested it to see that it passes the tests, but that is
   not saying much ;-).

 commit.c      |   13 ++++++++++---
 commit.h      |    4 +++-
 rev-list.c    |   11 ++++++++++-
 rev-parse.c   |    1 +
 show-branch.c |    9 +++++----
 5 files changed, 29 insertions(+), 9 deletions(-)

4c8725f16abff4be4812d0d07a663250bef3ef0e
diff --git a/commit.c b/commit.c
index 67e11d7..c550a00 100644
--- a/commit.c
+++ b/commit.c
@@ -571,7 +571,7 @@ int count_parents(struct commit * commit
 /*
  * Performs an in-place topological sort on the list supplied.
  */
-void sort_in_topological_order(struct commit_list ** list)
+void sort_in_topological_order(struct commit_list ** list, int lifo)
 {
 	struct commit_list * next = *list;
 	struct commit_list * work = NULL, **insert;
@@ -630,7 +630,10 @@ void sort_in_topological_order(struct co
 		}
 		next=next->next;
 	}
+
 	/* process the list in topological order */
+	if (!lifo)
+		sort_by_date(&work);
 	while (work) {
 		struct commit * work_item = pop_commit(&work);
 		struct sort_node * work_node = (struct sort_node *)work_item->object.util;
@@ -647,8 +650,12 @@ void sort_in_topological_order(struct co
                                  * guaranteeing topological order.
                                  */
 				pn->indegree--;
-				if (!pn->indegree) 
-					commit_list_insert(parent, &work);
+				if (!pn->indegree) {
+					if (!lifo)
+						insert_by_date(parent, &work);
+					else
+						commit_list_insert(parent, &work);
+				}
 			}
 			parents=parents->next;
 		}
diff --git a/commit.h b/commit.h
index 986b22d..70a7c75 100644
--- a/commit.h
+++ b/commit.h
@@ -72,6 +72,8 @@ int count_parents(struct commit * commit
  * Post-conditions: 
  *   invariant of resulting list is:
  *      a reachable from b => ord(b) < ord(a)
+ *   in addition, when lifo == 0, commits on parallel tracks are
+ *   sorted in the dates order.
  */
-void sort_in_topological_order(struct commit_list ** list);
+void sort_in_topological_order(struct commit_list ** list, int lifo);
 #endif /* COMMIT_H */
diff --git a/rev-list.c b/rev-list.c
index 63391fc..f2d1105 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -27,6 +27,7 @@ static const char rev_list_usage[] =
 "  ordering output:\n"
 "    --merge-order [ --show-breaks ]\n"
 "    --topo-order\n"
+"    --date-order\n"
 "  formatting output:\n"
 "    --parents\n"
 "    --objects\n"
@@ -56,6 +57,7 @@ static int merge_order = 0;
 static int show_breaks = 0;
 static int stop_traversal = 0;
 static int topo_order = 0;
+static int lifo = 1;
 static int no_merges = 0;
 static const char **paths = NULL;
 static int remove_empty_trees = 0;
@@ -856,6 +858,13 @@ int main(int argc, const char **argv)
 		}
 		if (!strcmp(arg, "--topo-order")) {
 		        topo_order = 1;
+			lifo = 1;
+		        limited = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--date-order")) {
+		        topo_order = 1;
+			lifo = 0;
 		        limited = 1;
 			continue;
 		}
@@ -940,7 +949,7 @@ int main(int argc, const char **argv)
 	        if (limited)
 			list = limit_list(list);
 		if (topo_order)
-			sort_in_topological_order(&list);
+			sort_in_topological_order(&list, lifo);
 		show_commit_list(list);
 	} else {
 #ifndef NO_OPENSSL
diff --git a/rev-parse.c b/rev-parse.c
index b82f294..9161fae 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -48,6 +48,7 @@ static int is_rev_argument(const char *a
 		"--show-breaks",
 		"--sparse",
 		"--topo-order",
+		"--date-order",
 		"--unpacked",
 		NULL
 	};
diff --git a/show-branch.c b/show-branch.c
index 511fd3b..5a86ae2 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -535,6 +535,7 @@ int main(int ac, char **av)
 	int num_rev, i, extra = 0;
 	int all_heads = 0, all_tags = 0;
 	int all_mask, all_revs;
+	int lifo = 1;
 	char head_path[128];
 	const char *head_path_p;
 	int head_path_len;
@@ -544,7 +545,6 @@ int main(int ac, char **av)
 	int no_name = 0;
 	int sha1_name = 0;
 	int shown_merge_point = 0;
-	int topo_order = 0;
 	int with_current_branch = 0;
 	int head_at = -1;
 
@@ -586,7 +586,9 @@ int main(int ac, char **av)
 		else if (!strcmp(arg, "--independent"))
 			independent = 1;
 		else if (!strcmp(arg, "--topo-order"))
-			topo_order = 1;
+			lifo = 1;
+		else if (!strcmp(arg, "--date-order"))
+			lifo = 0;
 		else
 			usage(show_branch_usage);
 		ac--; av++;
@@ -710,8 +712,7 @@ int main(int ac, char **av)
 		exit(0);
 
 	/* Sort topologically */
-	if (topo_order)
-		sort_in_topological_order(&seen);
+	sort_in_topological_order(&seen, lifo);
 
 	/* Give names to commits */
 	if (!sha1_name && !no_name)
-- 
1.2.1.gbf0a

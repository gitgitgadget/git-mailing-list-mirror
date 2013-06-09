From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] toposort: rename "lifo" field
Date: Sun,  9 Jun 2013 16:24:34 -0700
Message-ID: <1370820277-30158-2-git-send-email-gitster@pobox.com>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 01:24:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uloym-0004dh-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab3FIXYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:24:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab3FIXYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:24:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5083026E56;
	Sun,  9 Jun 2013 23:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AObE
	ddiolLVaQar8PR8qrtfYFds=; b=A2x4GmFg6xRn1UnvpEdqBjhXReqt8rY+bcKN
	5GyLcM01RM862+rJ33+D1kmqjvroivfk1qmyBOgRfKT4R1OYYQAlKffYEr640goR
	WR8uGsM2uH/QCz/AfseIND2L45G9WSetHSgwo/rwig5Q9p/fT4YqyE+V3pJ9HBP6
	GqJB520=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	hqfPf0e1qSd6biMp+KmS4r2f0AUKQyflBu23IkuaQJ/i5MrN54vDHVjto9a2TKDT
	UZzmD8Q2mKgiHmlwxRmS8DqFNSDtlVmHIgZMkztF4BvYNR1TcsEkJ27vd79yZAOR
	/Qh1MALKCqcevyMd1f68iyRguIKMg/r6VkN5JIA9L9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47DB126E55;
	Sun,  9 Jun 2013 23:24:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58E0026E51;
	Sun,  9 Jun 2013 23:24:40 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-477-gc2fede3
In-Reply-To: <1370820277-30158-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C2210AA6-D15B-11E2-8245-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227209>

The primary invariant of sort_in_topological_order() is that a
parent commit is not emitted untile all children of it are.  When
traversing a forked history like this with "git log C E":

    A----B----C
     \
      D----E

we ensure that A is emitted after all of B, C, D, and E are done, B
has to wait until C is done, and D has to wait until E is done.

In some applications, however, we would further want to control how
these child commits B, C, D and E on two parallel ancestry chains
are shown.

Most of the time, we would want to see C and B emitted together, and
then E and D, and finally A (i.e. the --topo-order output).  The
"lifo" parameter of the sort_in_topological_order() function is used
to control this behaviour.  We start the traversal by knowing two
commits, C and E.  While keeping in mind that we also need to
inspect E later, we pick C first to inspect, and we notice and
record that B needs to be inspected.  By structuring the "work to be
done" set as a LIFO stack, we ensure that B is inspected next,
before other in-flight commits we had known that we will need to
inspect, e.g. E.

When showing in --date-order, we would want to see commits ordered
by timestamps, i.e. show C, E, B and D in this order before showing
A, possibly mixing commits from two parallel histories together.
When "lifo" parameter is set to false, the function keeps the "work
to be done" set sorted in the date order to realize this semantics.
After inspecting C, we add B to the "work to be done" set, but the
next commit we inspect from the set is E which is newer than B.

The name "lifo", however, is too strongly tied to the way how the
function implements its behaviour, and does not describe what the
behaviour _means_.

Replace this field with an enum rev_sort_order, with two possible
values: REV_SORT_IN_GRAPH_ORDER and REV_SORT_BY_COMMIT_DATE, and
update the existing code.  The mechanical replacement rule is:

  "lifo == 0" is equivalent to "sort_order == REV_SORT_BY_COMMIT_DATE"
  "lifo == 1" is equivalent to "sort_order == REV_SORT_IN_GRAPH_ORDER"

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c         |  2 +-
 builtin/show-branch.c | 14 ++++++++------
 commit.c              | 12 ++++++++----
 commit.h              | 14 +++++++++++---
 revision.c            | 10 +++++-----
 revision.h            |  6 +++++-
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..8d26042 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -205,7 +205,7 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 	int i = revs->early_output;
 	int show_header = 1;
 
-	sort_in_topological_order(&list, revs->lifo);
+	sort_in_topological_order(&list, revs->sort_order);
 	while (list && i) {
 		struct commit *commit = list->item;
 		switch (simplify_commit(revs, commit)) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d208fd6..7c57985 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -631,7 +631,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int num_rev, i, extra = 0;
 	int all_heads = 0, all_remotes = 0;
 	int all_mask, all_revs;
-	int lifo = 1;
+	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
 	char head[128];
 	const char *head_p;
 	int head_len;
@@ -666,15 +666,17 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			    N_("show possible merge bases")),
 		OPT_BOOLEAN(0, "independent", &independent,
 			    N_("show refs unreachable from any other ref")),
-		OPT_BOOLEAN(0, "topo-order", &lifo,
-			    N_("show commits in topological order")),
+		OPT_SET_INT(0, "topo-order", &sort_order,
+			    N_("show commits in topological order"),
+			    REV_SORT_IN_GRAPH_ORDER),
 		OPT_BOOLEAN(0, "topics", &topics,
 			    N_("show only commits not on the first branch")),
 		OPT_SET_INT(0, "sparse", &dense,
 			    N_("show merges reachable from only one tip"), 0),
-		OPT_SET_INT(0, "date-order", &lifo,
+		OPT_SET_INT(0, "date-order", &sort_order,
 			    N_("show commits where no parent comes before its "
-			       "children"), 0),
+			       "children"),
+			    REV_SORT_BY_COMMIT_DATE),
 		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
 			       "base"),
@@ -901,7 +903,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		exit(0);
 
 	/* Sort topologically */
-	sort_in_topological_order(&seen, lifo);
+	sort_in_topological_order(&seen, sort_order);
 
 	/* Give names to commits */
 	if (!sha1_name && !no_name)
diff --git a/commit.c b/commit.c
index f97456d..11b9635 100644
--- a/commit.c
+++ b/commit.c
@@ -512,7 +512,7 @@ define_commit_slab(indegree_slab, int);
 /*
  * Performs an in-place topological sort on the list supplied.
  */
-void sort_in_topological_order(struct commit_list ** list, int lifo)
+void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order sort_order)
 {
 	struct commit_list *next, *orig = *list;
 	struct commit_list *work, **insert;
@@ -561,7 +561,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	}
 
 	/* process the list in topological order */
-	if (!lifo)
+	if (sort_order != REV_SORT_IN_GRAPH_ORDER)
 		commit_list_sort_by_date(&work);
 
 	pptr = list;
@@ -588,10 +588,14 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 			 * guaranteeing topological order.
 			 */
 			if (--(*pi) == 1) {
-				if (!lifo)
+				switch (sort_order) {
+				case REV_SORT_BY_COMMIT_DATE:
 					commit_list_insert_by_date(parent, &work);
-				else
+					break;
+				default: /* REV_SORT_IN_GRAPH_ORDER */
 					commit_list_insert(parent, &work);
+					break;
+				}
 			}
 		}
 		/*
diff --git a/commit.h b/commit.h
index 70e749d..247e474 100644
--- a/commit.h
+++ b/commit.h
@@ -139,15 +139,23 @@ struct commit *pop_commit(struct commit_list **stack);
 void clear_commit_marks(struct commit *commit, unsigned int mark);
 void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark);
 
+
+enum rev_sort_order {
+	REV_SORT_IN_GRAPH_ORDER = 0,
+	REV_SORT_BY_COMMIT_DATE
+};
+
 /*
  * Performs an in-place topological sort of list supplied.
  *
  *   invariant of resulting list is:
  *      a reachable from b => ord(b) < ord(a)
- *   in addition, when lifo == 0, commits on parallel tracks are
- *   sorted in the dates order.
+ *   sort_order further specifies:
+ *   REV_SORT_IN_GRAPH_ORDER: try to show a commit on a single-parent
+ *                            chain together.
+ *   REV_SORT_BY_COMMIT_DATE: show eligible commits in committer-date order.
  */
-void sort_in_topological_order(struct commit_list ** list, int lifo);
+void sort_in_topological_order(struct commit_list **, enum rev_sort_order);
 
 struct commit_graft {
 	unsigned char sha1[20];
diff --git a/revision.c b/revision.c
index cf620c6..966ebbc 100644
--- a/revision.c
+++ b/revision.c
@@ -1038,7 +1038,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	DIFF_OPT_SET(&revs->pruning, QUICK);
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
-	revs->lifo = 1;
+	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs->dense = 1;
 	revs->prefix = prefix;
 	revs->max_age = -1;
@@ -1373,7 +1373,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--merge")) {
 		revs->show_merge = 1;
 	} else if (!strcmp(arg, "--topo-order")) {
-		revs->lifo = 1;
+		revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
 		revs->topo_order = 1;
 	} else if (!strcmp(arg, "--simplify-merges")) {
 		revs->simplify_merges = 1;
@@ -1391,7 +1391,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->prune = 1;
 		load_ref_decorations(DECORATE_SHORT_REFS);
 	} else if (!strcmp(arg, "--date-order")) {
-		revs->lifo = 0;
+		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
 	} else if (!prefixcmp(arg, "--early-output")) {
 		int count = 100;
@@ -2165,7 +2165,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (limit_list(revs) < 0)
 			return -1;
 	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->lifo);
+		sort_in_topological_order(&revs->commits, revs->sort_order);
 	if (revs->simplify_merges)
 		simplify_merges(revs);
 	if (revs->children.name)
@@ -2480,7 +2480,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * If revs->topo_order is set, sort the boundary commits
 	 * in topological order
 	 */
-	sort_in_topological_order(&revs->commits, revs->lifo);
+	sort_in_topological_order(&revs->commits, revs->sort_order);
 }
 
 static struct commit *get_revision_internal(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index 5da09ee..2a5e325 100644
--- a/revision.h
+++ b/revision.h
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "grep.h"
 #include "notes.h"
+#include "commit.h"
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
@@ -60,6 +61,10 @@ struct rev_info {
 	const char *prefix;
 	const char *def;
 	struct pathspec prune_data;
+
+	/* topo-sort */
+	enum rev_sort_order sort_order;
+
 	unsigned int	early_output:1,
 			ignore_missing:1;
 
@@ -70,7 +75,6 @@ struct rev_info {
 			show_all:1,
 			remove_empty_trees:1,
 			simplify_history:1,
-			lifo:1,
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
-- 
1.8.3-451-gb703ddf

From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/3] rev-lib: Make it easy to do rename tracking
Date: Wed, 8 Mar 2006 23:59:39 +0100
Message-ID: <20060308225939.GC461@c165.ib.student.liu.se>
References: <20060308225412.GA461@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Mar 09 00:00:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH7dQ-00074t-9h
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 00:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWCHW7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 17:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWCHW7l
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 17:59:41 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:43906 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1030245AbWCHW7k
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 17:59:40 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 45D2440FF; Thu,  9 Mar 2006 00:15:11 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FH7d5-00008k-00; Wed, 08 Mar 2006 23:59:39 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060308225412.GA461@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17390>

prune_fn in the rev_info structure is called in place of
try_to_simplify_commit. This makes it possible to do rename tracking
with a custom try_to_simplify_commit-like function.

This commit also introduces init_revisions which initialises the rev_info
structure with default values.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 rev-list.c |    6 +++---
 revision.c |   59 +++++++++++++++++++++++++++++++++++++----------------------
 revision.h |   20 +++++++++++++++++++-
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/rev-list.c b/rev-list.c
index 8e4d83e..83a8ec2 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -190,7 +190,7 @@ static int count_distance(struct commit_
 
 		if (commit->object.flags & (UNINTERESTING | COUNTED))
 			break;
-		if (!revs.paths || (commit->object.flags & TREECHANGE))
+		if (!revs.prune_data || (commit->object.flags & TREECHANGE))
 			nr++;
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
@@ -224,7 +224,7 @@ static struct commit_list *find_bisectio
 	nr = 0;
 	p = list;
 	while (p) {
-		if (!revs.paths || (p->item->object.flags & TREECHANGE))
+		if (!revs.prune_data || (p->item->object.flags & TREECHANGE))
 			nr++;
 		p = p->next;
 	}
@@ -234,7 +234,7 @@ static struct commit_list *find_bisectio
 	for (p = list; p; p = p->next) {
 		int distance;
 
-		if (revs.paths && !(p->item->object.flags & TREECHANGE))
+		if (revs.prune_data && !(p->item->object.flags & TREECHANGE))
 			continue;
 
 		distance = count_distance(p);
diff --git a/revision.c b/revision.c
index 2a33637..991dfe8 100644
--- a/revision.c
+++ b/revision.c
@@ -197,9 +197,6 @@ static int everybody_uninteresting(struc
 	return 1;
 }
 
-#define TREE_SAME	0
-#define TREE_NEW	1
-#define TREE_DIFFERENT	2
 static int tree_difference = TREE_SAME;
 
 static void file_add_remove(struct diff_options *options,
@@ -241,7 +238,7 @@ static struct diff_options diff_opt = {
 	.change = file_change,
 };
 
-static int compare_tree(struct tree *t1, struct tree *t2)
+int compare_tree(struct tree *t1, struct tree *t2)
 {
 	if (!t1)
 		return TREE_NEW;
@@ -253,7 +250,7 @@ static int compare_tree(struct tree *t1,
 	return tree_difference;
 }
 
-static int same_tree_as_empty(struct tree *t1)
+int same_tree_as_empty(struct tree *t1)
 {
 	int retval;
 	void *tree;
@@ -321,6 +318,7 @@ static void try_to_simplify_commit(struc
 	commit->object.flags |= TREECHANGE;
 }
 
+
 static void add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
 {
 	struct commit_list *parent = commit->parents;
@@ -358,8 +356,11 @@ static void add_parents_to_list(struct r
 	 * simplify the commit history and find the parent
 	 * that has no differences in the path set if one exists.
 	 */
-	if (revs->paths)
+	/* if (revs->paths)
 		try_to_simplify_commit(revs, commit);
+	*/
+	if (revs->prune_fn)
+		revs->prune_fn(revs, commit);
 
 	parent = commit->parents;
 	while (parent) {
@@ -381,9 +382,6 @@ static void limit_list(struct rev_info *
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 
-	if (revs->paths)
-		diff_tree_setup_paths(revs->paths);
-
 	while (list) {
 		struct commit_list *entry = list;
 		struct commit *commit = list->item;
@@ -435,6 +433,24 @@ static void handle_all(struct rev_info *
 	for_each_ref(handle_one_ref);
 }
 
+
+void init_revisions(struct rev_info *revs)
+{
+	memset(revs, 0, sizeof(*revs));
+	revs->lifo = 1;
+	revs->dense = 1;
+	revs->prefix = setup_git_directory();
+	revs->max_age = -1;
+	revs->min_age = -1;
+	revs->max_count = -1;
+
+	revs->prune_fn = NULL;
+	revs->prune_data = NULL;
+
+	revs->topo_setter = default_setter;
+	revs->topo_getter = default_getter;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -448,14 +464,8 @@ int setup_revisions(int argc, const char
 	const char **unrecognized = argv + 1;
 	int left = 1;
 
-	memset(revs, 0, sizeof(*revs));
-	revs->lifo = 1;
-	revs->dense = 1;
-	revs->prefix = setup_git_directory();
-	revs->max_age = -1;
-	revs->min_age = -1;
-	revs->max_count = -1;
-
+	init_revisions(revs);
+	
 	/* First, search for "--" */
 	seen_dashdash = 0;
 	for (i = 1; i < argc; i++) {
@@ -464,7 +474,7 @@ int setup_revisions(int argc, const char
 			continue;
 		argv[i] = NULL;
 		argc = i;
-		revs->paths = get_pathspec(revs->prefix, argv + i + 1);
+		revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
 		seen_dashdash = 1;
 		break;
 	}
@@ -628,7 +638,7 @@ int setup_revisions(int argc, const char
 				if (lstat(argv[j], &st) < 0)
 					die("'%s': %s", arg, strerror(errno));
 			}
-			revs->paths = get_pathspec(revs->prefix, argv + i);
+			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
 		}
 		commit = get_commit_reference(revs, arg, sha1, flags ^ local_flags);
@@ -642,8 +652,13 @@ int setup_revisions(int argc, const char
 		commit = get_commit_reference(revs, def, sha1, 0);
 		add_one_commit(commit, revs);
 	}
-	if (revs->paths)
+
+	if (revs->prune_data) {
+		diff_tree_setup_paths(revs->prune_data);
+		revs->prune_fn = try_to_simplify_commit;
 		revs->limited = 1;
+	}
+
 	return left;
 }
 
@@ -653,7 +668,7 @@ void prepare_revision_walk(struct rev_in
 	if (revs->limited)
 		limit_list(revs);
 	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->lifo);
+		sort_in_topological_order_fun(&revs->commits, revs->lifo, revs->topo_setter, revs->topo_getter);
 }
 
 static int rewrite_one(struct commit **pp)
@@ -709,7 +724,7 @@ struct commit *get_revision(struct rev_i
 			return NULL;
 		if (revs->no_merges && commit->parents && commit->parents->next)
 			goto next;
-		if (revs->paths && revs->dense) {
+		if (revs->prune_fn && revs->dense) {
 			if (!(commit->object.flags & TREECHANGE))
 				goto next;
 			rewrite_parents(commit);
diff --git a/revision.h b/revision.h
index 31e8f61..510d936 100644
--- a/revision.h
+++ b/revision.h
@@ -7,6 +7,10 @@
 #define SHOWN		(1u<<3)
 #define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
 
+struct rev_info;
+
+typedef void (prune_fn_t)(struct rev_info *revs, struct commit *commit);
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -14,7 +18,9 @@ struct rev_info {
 
 	/* Basic information */
 	const char *prefix;
-	const char **paths;
+
+	void* prune_data;
+	prune_fn_t* prune_fn;
 
 	/* Traversal flags */
 	unsigned int	dense:1,
@@ -33,9 +39,21 @@ struct rev_info {
 	int max_count;
 	unsigned long max_age;
 	unsigned long min_age;
+
+	set_fn_t topo_setter;
+	get_fn_t topo_getter;
 };
 
+#define TREE_SAME	0
+#define TREE_NEW	1
+#define TREE_DIFFERENT	2
+
 /* revision.c */
+extern int same_tree_as_empty(struct tree *t1);
+extern int compare_tree(struct tree *t1, struct tree *t2);
+
+
+extern void init_revisions(struct rev_info *revs);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
 extern void prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);

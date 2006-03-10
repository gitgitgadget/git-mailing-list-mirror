From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/3] rev-lib: Make it easy to do rename tracking (take 2)
Date: Fri, 10 Mar 2006 10:21:39 +0100
Message-ID: <20060310092139.24015.47686.stgit@c165>
References: <20060310092135.24015.26510.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 10 10:22:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHdot-00044h-8E
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 10:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWCJJVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 04:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWCJJVq
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 04:21:46 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:62341 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751945AbWCJJVp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 04:21:45 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 84DE54118; Fri, 10 Mar 2006 10:37:16 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FHdoZ-0006G1-00; Fri, 10 Mar 2006 10:21:39 +0100
To: git@vger.kernel.org
In-Reply-To: <20060310092135.24015.26510.stgit@c165>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17462>


prune_fn in the rev_info structure is called in place of
try_to_simplify_commit. This makes it possible to do rename tracking
with a custom try_to_simplify_commit-like function.

This commit also introduces init_revisions which initialises the rev_info
structure with default values.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 rev-list.c |    6 ++--
 revision.c |  100 ++++++++++++++++++++++++++++++++++--------------------------
 revision.h |   18 ++++++++++-
 3 files changed, 76 insertions(+), 48 deletions(-)

diff --git a/rev-list.c b/rev-list.c
index 8e4d83e..812d237 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -190,7 +190,7 @@ static int count_distance(struct commit_
 
 		if (commit->object.flags & (UNINTERESTING | COUNTED))
 			break;
-		if (!revs.paths || (commit->object.flags & TREECHANGE))
+		if (!revs.prune_fn || (commit->object.flags & TREECHANGE))
 			nr++;
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
@@ -224,7 +224,7 @@ static struct commit_list *find_bisectio
 	nr = 0;
 	p = list;
 	while (p) {
-		if (!revs.paths || (p->item->object.flags & TREECHANGE))
+		if (!revs.prune_fn || (p->item->object.flags & TREECHANGE))
 			nr++;
 		p = p->next;
 	}
@@ -234,7 +234,7 @@ static struct commit_list *find_bisectio
 	for (p = list; p; p = p->next) {
 		int distance;
 
-		if (revs.paths && !(p->item->object.flags & TREECHANGE))
+		if (revs.prune_fn && !(p->item->object.flags & TREECHANGE))
 			continue;
 
 		distance = count_distance(p);
diff --git a/revision.c b/revision.c
index 2a33637..b41f961 100644
--- a/revision.c
+++ b/revision.c
@@ -197,31 +197,27 @@ static int everybody_uninteresting(struc
 	return 1;
 }
 
-#define TREE_SAME	0
-#define TREE_NEW	1
-#define TREE_DIFFERENT	2
-static int tree_difference = TREE_SAME;
+static int tree_difference = REV_TREE_SAME;
 
 static void file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
 		    const char *base, const char *path)
 {
-	int diff = TREE_DIFFERENT;
+	int diff = REV_TREE_DIFFERENT;
 
 	/*
-	 * Is it an add of a new file? It means that
-	 * the old tree didn't have it at all, so we
-	 * will turn "TREE_SAME" -> "TREE_NEW", but
-	 * leave any "TREE_DIFFERENT" alone (and if
-	 * it already was "TREE_NEW", we'll keep it
-	 * "TREE_NEW" of course).
+	 * Is it an add of a new file? It means that the old tree
+	 * didn't have it at all, so we will turn "REV_TREE_SAME" ->
+	 * "REV_TREE_NEW", but leave any "REV_TREE_DIFFERENT" alone
+	 * (and if it already was "REV_TREE_NEW", we'll keep it
+	 * "REV_TREE_NEW" of course).
 	 */
 	if (addremove == '+') {
 		diff = tree_difference;
-		if (diff != TREE_SAME)
+		if (diff != REV_TREE_SAME)
 			return;
-		diff = TREE_NEW;
+		diff = REV_TREE_NEW;
 	}
 	tree_difference = diff;
 }
@@ -232,7 +228,7 @@ static void file_change(struct diff_opti
 		 const unsigned char *new_sha1,
 		 const char *base, const char *path)
 {
-	tree_difference = TREE_DIFFERENT;
+	tree_difference = REV_TREE_DIFFERENT;
 }
 
 static struct diff_options diff_opt = {
@@ -241,19 +237,19 @@ static struct diff_options diff_opt = {
 	.change = file_change,
 };
 
-static int compare_tree(struct tree *t1, struct tree *t2)
+int rev_compare_tree(struct tree *t1, struct tree *t2)
 {
 	if (!t1)
-		return TREE_NEW;
+		return REV_TREE_NEW;
 	if (!t2)
-		return TREE_DIFFERENT;
-	tree_difference = TREE_SAME;
+		return REV_TREE_DIFFERENT;
+	tree_difference = REV_TREE_SAME;
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &diff_opt) < 0)
-		return TREE_DIFFERENT;
+		return REV_TREE_DIFFERENT;
 	return tree_difference;
 }
 
-static int same_tree_as_empty(struct tree *t1)
+int rev_same_tree_as_empty(struct tree *t1)
 {
 	int retval;
 	void *tree;
@@ -285,7 +281,7 @@ static void try_to_simplify_commit(struc
 		return;
 
 	if (!commit->parents) {
-		if (!same_tree_as_empty(commit->tree))
+		if (!rev_same_tree_as_empty(commit->tree))
 			commit->object.flags |= TREECHANGE;
 		return;
 	}
@@ -300,19 +296,20 @@ static void try_to_simplify_commit(struc
 		}
 
 		parse_commit(p);
-		switch (compare_tree(p->tree, commit->tree)) {
-		case TREE_SAME:
+		switch (rev_compare_tree(p->tree, commit->tree)) {
+		case REV_TREE_SAME:
 			parent->next = NULL;
 			commit->parents = parent;
 			return;
 
-		case TREE_NEW:
-			if (revs->remove_empty_trees && same_tree_as_empty(p->tree)) {
+		case REV_TREE_NEW:
+			if (revs->remove_empty_trees &&
+			    rev_same_tree_as_empty(p->tree)) {
 				*pp = parent->next;
 				continue;
 			}
 		/* fallthrough */
-		case TREE_DIFFERENT:
+		case REV_TREE_DIFFERENT:
 			pp = &parent->next;
 			continue;
 		}
@@ -358,8 +355,8 @@ static void add_parents_to_list(struct r
 	 * simplify the commit history and find the parent
 	 * that has no differences in the path set if one exists.
 	 */
-	if (revs->paths)
-		try_to_simplify_commit(revs, commit);
+	if (revs->prune_fn)
+		revs->prune_fn(revs, commit);
 
 	parent = commit->parents;
 	while (parent) {
@@ -381,9 +378,6 @@ static void limit_list(struct rev_info *
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 
-	if (revs->paths)
-		diff_tree_setup_paths(revs->paths);
-
 	while (list) {
 		struct commit_list *entry = list;
 		struct commit *commit = list->item;
@@ -435,6 +429,23 @@ static void handle_all(struct rev_info *
 	for_each_ref(handle_one_ref);
 }
 
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
+	revs->topo_setter = topo_sort_default_setter;
+	revs->topo_getter = topo_sort_default_getter;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -448,14 +459,8 @@ int setup_revisions(int argc, const char
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
@@ -464,7 +469,7 @@ int setup_revisions(int argc, const char
 			continue;
 		argv[i] = NULL;
 		argc = i;
-		revs->paths = get_pathspec(revs->prefix, argv + i + 1);
+		revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
 		seen_dashdash = 1;
 		break;
 	}
@@ -628,7 +633,7 @@ int setup_revisions(int argc, const char
 				if (lstat(argv[j], &st) < 0)
 					die("'%s': %s", arg, strerror(errno));
 			}
-			revs->paths = get_pathspec(revs->prefix, argv + i);
+			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
 		}
 		commit = get_commit_reference(revs, arg, sha1, flags ^ local_flags);
@@ -642,8 +647,13 @@ int setup_revisions(int argc, const char
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
 
@@ -653,7 +663,9 @@ void prepare_revision_walk(struct rev_in
 	if (revs->limited)
 		limit_list(revs);
 	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->lifo);
+		sort_in_topological_order_fn(&revs->commits, revs->lifo,
+					     revs->topo_setter,
+					     revs->topo_getter);
 }
 
 static int rewrite_one(struct commit **pp)
@@ -709,7 +721,7 @@ struct commit *get_revision(struct rev_i
 			return NULL;
 		if (revs->no_merges && commit->parents && commit->parents->next)
 			goto next;
-		if (revs->paths && revs->dense) {
+		if (revs->prune_fn && revs->dense) {
 			if (!(commit->object.flags & TREECHANGE))
 				goto next;
 			rewrite_parents(commit);
diff --git a/revision.h b/revision.h
index 31e8f61..6c2beca 100644
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
@@ -14,7 +18,8 @@ struct rev_info {
 
 	/* Basic information */
 	const char *prefix;
-	const char **paths;
+	void *prune_data;
+	prune_fn_t *prune_fn;
 
 	/* Traversal flags */
 	unsigned int	dense:1,
@@ -33,9 +38,20 @@ struct rev_info {
 	int max_count;
 	unsigned long max_age;
 	unsigned long min_age;
+
+	topo_sort_set_fn_t topo_setter;
+	topo_sort_get_fn_t topo_getter;
 };
 
+#define REV_TREE_SAME		0
+#define REV_TREE_NEW		1
+#define REV_TREE_DIFFERENT	2
+
 /* revision.c */
+extern int rev_same_tree_as_empty(struct tree *t1);
+extern int rev_compare_tree(struct tree *t1, struct tree *t2);
+
+extern void init_revisions(struct rev_info *revs);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
 extern void prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);

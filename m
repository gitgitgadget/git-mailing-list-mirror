From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/3] git-rev-list libification: rev-list walking
Date: Tue, 28 Feb 2006 11:24:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602281120060.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 28 20:24:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEASH-0000vG-5M
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 20:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWB1TYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 14:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWB1TYO
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 14:24:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39373 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932455AbWB1TYN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 14:24:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1SJO7DZ007309
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Feb 2006 11:24:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1SJO1GW025879;
	Tue, 28 Feb 2006 11:24:04 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
X-Spam-Status: No, hits=-5.776 required=5 tests=PATCH_UNIFIED_DIFF_OSDL,REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16947>


This actually moves the "meat" of the revision walking from rev-list.c
to the new library code in revision.h. It introduces the new functions

	void prepare_revision_walk(struct rev_info *revs);
	struct commit *get_revision(struct rev_info *revs);

to prepare and then walk the revisions that we have.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

All the same old warnigns apply!! This is a bit more intrusive than the 
previous patch series, since it actually changes how things work. It 
passes all the tests I threw at it (well, actually, I only tested the end 
result of the whole series, bad me), but I'd obviously like to remind 
everybody that this is some really core code, and mistakes are bad.

I didn't worry about cleaning code up. It probably could be cleaned up, 
but I worked at trying to just move as much of it as-is from rev-list.c as 
possible, while leaving any code that was really only relevant to rev-list 
itself alone.

diff --git a/rev-list.c b/rev-list.c
index 2e80930..94f22dd 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -8,11 +8,10 @@
 #include "diff.h"
 #include "revision.h"
 
-/* bits #0 and #1 in revision.h */
+/* bits #0-2 in revision.h */
 
-#define COUNTED		(1u << 2)
-#define SHOWN		(1u << 3)
-#define TREECHANGE	(1u << 4)
+#define COUNTED		(1u << 3)
+#define SHOWN		(1u << 4)
 #define TMP_MARK	(1u << 5) /* for isolated cases; clean after use */
 
 static const char rev_list_usage[] =
@@ -213,17 +212,17 @@ static struct object_list **process_tree
 	return p;
 }
 
-static void show_commit_list(struct commit_list *list)
+static void show_commit_list(struct rev_info *revs)
 {
+	struct commit *commit;
 	struct object_list *objects = NULL, **p = &objects, *pending;
-	while (list) {
-		struct commit *commit = pop_most_recent_commit(&list, SEEN);
 
+	while ((commit = get_revision(revs)) != NULL) {
 		p = process_tree(commit->tree, p, NULL, "");
 		if (process_commit(commit) == STOP)
 			break;
 	}
-	for (pending = revs.pending_objects; pending; pending = pending->next) {
+	for (pending = revs->pending_objects; pending; pending = pending->next) {
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
@@ -259,19 +258,6 @@ static void show_commit_list(struct comm
 	}
 }
 
-static int everybody_uninteresting(struct commit_list *orig)
-{
-	struct commit_list *list = orig;
-	while (list) {
-		struct commit *commit = list->item;
-		list = list->next;
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		return 0;
-	}
-	return 1;
-}
-
 /*
  * This is a truly stupid algorithm, but it's only
  * used for bisection, and we just don't care enough.
@@ -379,224 +365,12 @@ static void mark_edges_uninteresting(str
 	}
 }
 
-#define TREE_SAME	0
-#define TREE_NEW	1
-#define TREE_DIFFERENT	2
-static int tree_difference = TREE_SAME;
-
-static void file_add_remove(struct diff_options *options,
-		    int addremove, unsigned mode,
-		    const unsigned char *sha1,
-		    const char *base, const char *path)
-{
-	int diff = TREE_DIFFERENT;
-
-	/*
-	 * Is it an add of a new file? It means that
-	 * the old tree didn't have it at all, so we
-	 * will turn "TREE_SAME" -> "TREE_NEW", but
-	 * leave any "TREE_DIFFERENT" alone (and if
-	 * it already was "TREE_NEW", we'll keep it
-	 * "TREE_NEW" of course).
-	 */
-	if (addremove == '+') {
-		diff = tree_difference;
-		if (diff != TREE_SAME)
-			return;
-		diff = TREE_NEW;
-	}
-	tree_difference = diff;
-}
-
-static void file_change(struct diff_options *options,
-		 unsigned old_mode, unsigned new_mode,
-		 const unsigned char *old_sha1,
-		 const unsigned char *new_sha1,
-		 const char *base, const char *path)
-{
-	tree_difference = TREE_DIFFERENT;
-}
-
-static struct diff_options diff_opt = {
-	.recursive = 1,
-	.add_remove = file_add_remove,
-	.change = file_change,
-};
-
-static int compare_tree(struct tree *t1, struct tree *t2)
-{
-	if (!t1)
-		return TREE_NEW;
-	if (!t2)
-		return TREE_DIFFERENT;
-	tree_difference = TREE_SAME;
-	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &diff_opt) < 0)
-		return TREE_DIFFERENT;
-	return tree_difference;
-}
-
-static int same_tree_as_empty(struct tree *t1)
-{
-	int retval;
-	void *tree;
-	struct tree_desc empty, real;
-
-	if (!t1)
-		return 0;
-
-	tree = read_object_with_reference(t1->object.sha1, "tree", &real.size, NULL);
-	if (!tree)
-		return 0;
-	real.buf = tree;
-
-	empty.buf = "";
-	empty.size = 0;
-
-	tree_difference = 0;
-	retval = diff_tree(&empty, &real, "", &diff_opt);
-	free(tree);
-
-	return retval >= 0 && !tree_difference;
-}
-
-static void try_to_simplify_commit(struct commit *commit)
-{
-	struct commit_list **pp, *parent;
-
-	if (!commit->tree)
-		return;
-
-	if (!commit->parents) {
-		if (!same_tree_as_empty(commit->tree))
-			commit->object.flags |= TREECHANGE;
-		return;
-	}
-
-	pp = &commit->parents;
-	while ((parent = *pp) != NULL) {
-		struct commit *p = parent->item;
-
-		if (p->object.flags & UNINTERESTING) {
-			pp = &parent->next;
-			continue;
-		}
-
-		parse_commit(p);
-		switch (compare_tree(p->tree, commit->tree)) {
-		case TREE_SAME:
-			parent->next = NULL;
-			commit->parents = parent;
-			return;
-
-		case TREE_NEW:
-			if (revs.remove_empty_trees && same_tree_as_empty(p->tree)) {
-				*pp = parent->next;
-				continue;
-			}
-		/* fallthrough */
-		case TREE_DIFFERENT:
-			pp = &parent->next;
-			continue;
-		}
-		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
-	}
-	commit->object.flags |= TREECHANGE;
-}
-
-static void add_parents_to_list(struct commit *commit, struct commit_list **list)
-{
-	struct commit_list *parent = commit->parents;
-
-	/*
-	 * If the commit is uninteresting, don't try to
-	 * prune parents - we want the maximal uninteresting
-	 * set.
-	 *
-	 * Normally we haven't parsed the parent
-	 * yet, so we won't have a parent of a parent
-	 * here. However, it may turn out that we've
-	 * reached this commit some other way (where it
-	 * wasn't uninteresting), in which case we need
-	 * to mark its parents recursively too..
-	 */
-	if (commit->object.flags & UNINTERESTING) {
-		while (parent) {
-			struct commit *p = parent->item;
-			parent = parent->next;
-			parse_commit(p);
-			p->object.flags |= UNINTERESTING;
-			if (p->parents)
-				mark_parents_uninteresting(p);
-			if (p->object.flags & SEEN)
-				continue;
-			p->object.flags |= SEEN;
-			insert_by_date(p, list);
-		}
-		return;
-	}
-
-	/*
-	 * Ok, the commit wasn't uninteresting. Try to
-	 * simplify the commit history and find the parent
-	 * that has no differences in the path set if one exists.
-	 */
-	if (revs.paths)
-		try_to_simplify_commit(commit);
-
-	parent = commit->parents;
-	while (parent) {
-		struct commit *p = parent->item;
-
-		parent = parent->next;
-
-		parse_commit(p);
-		if (p->object.flags & SEEN)
-			continue;
-		p->object.flags |= SEEN;
-		insert_by_date(p, list);
-	}
-}
-
-static struct commit_list *limit_list(struct commit_list *list)
-{
-	struct commit_list *newlist = NULL;
-	struct commit_list **p = &newlist;
-	while (list) {
-		struct commit_list *entry = list;
-		struct commit *commit = list->item;
-		struct object *obj = &commit->object;
-
-		list = list->next;
-		free(entry);
-
-		if (revs.max_age != -1 && (commit->date < revs.max_age))
-			obj->flags |= UNINTERESTING;
-		if (revs.unpacked && has_sha1_pack(obj->sha1))
-			obj->flags |= UNINTERESTING;
-		add_parents_to_list(commit, &list);
-		if (obj->flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list))
-				break;
-			continue;
-		}
-		if (revs.min_age != -1 && (commit->date > revs.min_age))
-			continue;
-		p = &commit_list_insert(commit, p)->next;
-	}
-	if (revs.tree_objects)
-		mark_edges_uninteresting(newlist);
-	if (bisect_list)
-		newlist = find_bisection(newlist);
-	return newlist;
-}
-
 int main(int argc, const char **argv)
 {
 	struct commit_list *list;
 	int i;
 
-	argc = setup_revisions(argc, argv, &revs);
+	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
@@ -672,24 +446,18 @@ int main(int argc, const char **argv)
 	    (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) && !revs.pending_objects))
 		usage(rev_list_usage);
 
-	if (revs.paths)
-		diff_tree_setup_paths(revs.paths);
+	prepare_revision_walk(&revs);
+	if (revs.tree_objects)
+		mark_edges_uninteresting(revs.commits);
+
+	if (bisect_list)
+		revs.commits = find_bisection(revs.commits);
 
 	save_commit_buffer = verbose_header;
 	track_object_refs = 0;
 
-	if (!merge_order) {		
-		sort_by_date(&list);
-		if (list && !revs.limited && revs.max_count == 1 &&
-		    !revs.tag_objects && !revs.tree_objects && !revs.blob_objects) {
-			show_commit(list->item);
-			return 0;
-		}
-	        if (revs.limited)
-			list = limit_list(list);
-		if (revs.topo_order)
-			sort_in_topological_order(&list, revs.lifo);
-		show_commit_list(list);
+	if (!merge_order) {
+		show_commit_list(&revs);
 	} else {
 #ifndef NO_OPENSSL
 		if (sort_list_in_merge_order(list, &process_commit)) {
diff --git a/revision.c b/revision.c
index 0422593..fb728c1 100644
--- a/revision.c
+++ b/revision.c
@@ -3,6 +3,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
+#include "diff.h"
 #include "refs.h"
 #include "revision.h"
 
@@ -183,6 +184,229 @@ static struct commit *get_commit_referen
 	die("%s is unknown object", name);
 }
 
+static int everybody_uninteresting(struct commit_list *orig)
+{
+	struct commit_list *list = orig;
+	while (list) {
+		struct commit *commit = list->item;
+		list = list->next;
+		if (commit->object.flags & UNINTERESTING)
+			continue;
+		return 0;
+	}
+	return 1;
+}
+
+#define TREE_SAME	0
+#define TREE_NEW	1
+#define TREE_DIFFERENT	2
+static int tree_difference = TREE_SAME;
+
+static void file_add_remove(struct diff_options *options,
+		    int addremove, unsigned mode,
+		    const unsigned char *sha1,
+		    const char *base, const char *path)
+{
+	int diff = TREE_DIFFERENT;
+
+	/*
+	 * Is it an add of a new file? It means that
+	 * the old tree didn't have it at all, so we
+	 * will turn "TREE_SAME" -> "TREE_NEW", but
+	 * leave any "TREE_DIFFERENT" alone (and if
+	 * it already was "TREE_NEW", we'll keep it
+	 * "TREE_NEW" of course).
+	 */
+	if (addremove == '+') {
+		diff = tree_difference;
+		if (diff != TREE_SAME)
+			return;
+		diff = TREE_NEW;
+	}
+	tree_difference = diff;
+}
+
+static void file_change(struct diff_options *options,
+		 unsigned old_mode, unsigned new_mode,
+		 const unsigned char *old_sha1,
+		 const unsigned char *new_sha1,
+		 const char *base, const char *path)
+{
+	tree_difference = TREE_DIFFERENT;
+}
+
+static struct diff_options diff_opt = {
+	.recursive = 1,
+	.add_remove = file_add_remove,
+	.change = file_change,
+};
+
+static int compare_tree(struct tree *t1, struct tree *t2)
+{
+	if (!t1)
+		return TREE_NEW;
+	if (!t2)
+		return TREE_DIFFERENT;
+	tree_difference = TREE_SAME;
+	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &diff_opt) < 0)
+		return TREE_DIFFERENT;
+	return tree_difference;
+}
+
+static int same_tree_as_empty(struct tree *t1)
+{
+	int retval;
+	void *tree;
+	struct tree_desc empty, real;
+
+	if (!t1)
+		return 0;
+
+	tree = read_object_with_reference(t1->object.sha1, "tree", &real.size, NULL);
+	if (!tree)
+		return 0;
+	real.buf = tree;
+
+	empty.buf = "";
+	empty.size = 0;
+
+	tree_difference = 0;
+	retval = diff_tree(&empty, &real, "", &diff_opt);
+	free(tree);
+
+	return retval >= 0 && !tree_difference;
+}
+
+static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list **pp, *parent;
+
+	if (!commit->tree)
+		return;
+
+	if (!commit->parents) {
+		if (!same_tree_as_empty(commit->tree))
+			commit->object.flags |= TREECHANGE;
+		return;
+	}
+
+	pp = &commit->parents;
+	while ((parent = *pp) != NULL) {
+		struct commit *p = parent->item;
+
+		if (p->object.flags & UNINTERESTING) {
+			pp = &parent->next;
+			continue;
+		}
+
+		parse_commit(p);
+		switch (compare_tree(p->tree, commit->tree)) {
+		case TREE_SAME:
+			parent->next = NULL;
+			commit->parents = parent;
+			return;
+
+		case TREE_NEW:
+			if (revs->remove_empty_trees && same_tree_as_empty(p->tree)) {
+				*pp = parent->next;
+				continue;
+			}
+		/* fallthrough */
+		case TREE_DIFFERENT:
+			pp = &parent->next;
+			continue;
+		}
+		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
+	}
+	commit->object.flags |= TREECHANGE;
+}
+
+static void add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
+{
+	struct commit_list *parent = commit->parents;
+
+	/*
+	 * If the commit is uninteresting, don't try to
+	 * prune parents - we want the maximal uninteresting
+	 * set.
+	 *
+	 * Normally we haven't parsed the parent
+	 * yet, so we won't have a parent of a parent
+	 * here. However, it may turn out that we've
+	 * reached this commit some other way (where it
+	 * wasn't uninteresting), in which case we need
+	 * to mark its parents recursively too..
+	 */
+	if (commit->object.flags & UNINTERESTING) {
+		while (parent) {
+			struct commit *p = parent->item;
+			parent = parent->next;
+			parse_commit(p);
+			p->object.flags |= UNINTERESTING;
+			if (p->parents)
+				mark_parents_uninteresting(p);
+			if (p->object.flags & SEEN)
+				continue;
+			p->object.flags |= SEEN;
+			insert_by_date(p, list);
+		}
+		return;
+	}
+
+	/*
+	 * Ok, the commit wasn't uninteresting. Try to
+	 * simplify the commit history and find the parent
+	 * that has no differences in the path set if one exists.
+	 */
+	if (revs->paths)
+		try_to_simplify_commit(revs, commit);
+
+	parent = commit->parents;
+	while (parent) {
+		struct commit *p = parent->item;
+
+		parent = parent->next;
+
+		parse_commit(p);
+		if (p->object.flags & SEEN)
+			continue;
+		p->object.flags |= SEEN;
+		insert_by_date(p, list);
+	}
+}
+
+static void limit_list(struct rev_info *revs)
+{
+	struct commit_list *list = revs->commits;
+	struct commit_list *newlist = NULL;
+	struct commit_list **p = &newlist;
+
+	while (list) {
+		struct commit_list *entry = list;
+		struct commit *commit = list->item;
+		struct object *obj = &commit->object;
+
+		list = list->next;
+		free(entry);
+
+		if (revs->max_age != -1 && (commit->date < revs->max_age))
+			obj->flags |= UNINTERESTING;
+		if (revs->unpacked && has_sha1_pack(obj->sha1))
+			obj->flags |= UNINTERESTING;
+		add_parents_to_list(revs, commit, &list);
+		if (obj->flags & UNINTERESTING) {
+			mark_parents_uninteresting(commit);
+			if (everybody_uninteresting(list))
+				break;
+			continue;
+		}
+		if (revs->min_age != -1 && (commit->date > revs->min_age))
+			continue;
+		p = &commit_list_insert(commit, p)->next;
+	}
+	revs->commits = newlist;
+}
+
 static void add_one_commit(struct commit *commit, struct rev_info *revs)
 {
 	if (!commit || (commit->object.flags & SEEN))
@@ -214,10 +438,9 @@ static void handle_all(struct rev_info *
  *
  * Returns the number of arguments left ("new argc").
  */
-int setup_revisions(int argc, const char **argv, struct rev_info *revs)
+int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
 	int i, flags, seen_dashdash;
-	const char *def = NULL;
 	const char **unrecognized = argv+1;
 	int left = 1;
 
@@ -381,3 +604,23 @@ int setup_revisions(int argc, const char
 	*unrecognized = NULL;
 	return left;
 }
+
+void prepare_revision_walk(struct rev_info *revs)
+{
+	if (revs->paths)
+		diff_tree_setup_paths(revs->paths);
+	sort_by_date(&revs->commits);
+	if (revs->limited)
+		limit_list(revs);
+	if (revs->topo_order)
+		sort_in_topological_order(&revs->commits, revs->lifo);
+}
+
+struct commit *get_revision(struct rev_info *revs)
+{
+	if (!revs->commits)
+		return NULL;
+	return pop_most_recent_commit(&revs->commits, SEEN);
+}
+
+
diff --git a/revision.h b/revision.h
index a22f198..0bed3c0 100644
--- a/revision.h
+++ b/revision.h
@@ -3,6 +3,7 @@
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
+#define TREECHANGE	(1u<<2)
 
 struct rev_info {
 	/* Starting list */
@@ -32,7 +33,10 @@ struct rev_info {
 };
 
 /* revision.c */
-extern int setup_revisions(int argc, const char **argv, struct rev_info *revs);
+extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern void prepare_revision_walk(struct rev_info *revs);
+extern struct commit *get_revision(struct rev_info *revs);
+
 extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
 

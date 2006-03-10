From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 3/3] blame: Rename detection (take 2)
Date: Fri, 10 Mar 2006 10:21:41 +0100
Message-ID: <20060310092141.24015.42482.stgit@c165>
References: <20060310092135.24015.26510.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 10 10:22:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHdov-00044h-Q5
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 10:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWCJJVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 04:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWCJJVs
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 04:21:48 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:62853 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751955AbWCJJVq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 04:21:46 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A01A94102; Fri, 10 Mar 2006 10:37:18 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FHdob-0006GB-00; Fri, 10 Mar 2006 10:21:41 +0100
To: git@vger.kernel.org
In-Reply-To: <20060310092135.24015.26510.stgit@c165>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17463>




Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 blame.c |  239 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 199 insertions(+), 40 deletions(-)

diff --git a/blame.c b/blame.c
index 90338af..ac57e10 100644
--- a/blame.c
+++ b/blame.c
@@ -14,6 +14,7 @@
 #include "tree.h"
 #include "blob.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "revision.h"
 
 #define DEBUG 0
@@ -34,7 +35,9 @@ struct util_info {
 	char *buf;
 	unsigned long size;
 	int num_lines;
-//    const char* path;
+	const char* pathname;
+
+	void* topo_data;
 };
 
 struct chunk {
@@ -342,25 +345,34 @@ static int map_line(struct commit *commi
 	return info->line_map[line];
 }
 
-static int fill_util_info(struct commit *commit, const char *path)
+static struct util_info* get_util(struct commit *commit)
 {
-	struct util_info *util;
-	if (commit->object.util)
-		return 0;
+	struct util_info *util = commit->object.util;
+
+	if (util)
+		return util;
 
 	util = xmalloc(sizeof(struct util_info));
+	util->buf = NULL;
+	util->size = 0;
+	util->line_map = NULL;
+	util->num_lines = -1;
+	util->pathname = NULL;
+	commit->object.util = util;
+	return util;
+}
 
-	if (get_blob_sha1(commit->tree, path, util->sha1)) {
-		free(util);
+static int fill_util_info(struct commit *commit)
+{
+	struct util_info *util = commit->object.util;
+
+	assert(util);
+	assert(util->pathname);
+	
+	if (get_blob_sha1(commit->tree, util->pathname, util->sha1))
 		return 1;
-	} else {
-		util->buf = NULL;
-		util->size = 0;
-		util->line_map = NULL;
-		util->num_lines = -1;
-		commit->object.util = util;
+	else
 		return 0;
-	}
 }
 
 static void alloc_line_map(struct commit *commit)
@@ -389,10 +401,11 @@ static void alloc_line_map(struct commit
 
 static void init_first_commit(struct commit* commit, const char* filename)
 {
-	struct util_info* util;
+	struct util_info* util = commit->object.util;
 	int i;
 
-	if (fill_util_info(commit, filename))
+	util->pathname = filename;
+	if (fill_util_info(commit))
 		die("fill_util_info failed");
 
 	alloc_line_map(commit);
@@ -453,7 +466,7 @@ static void process_commits(struct rev_i
 		if(num_parents == 0)
 			*initial = commit;
 
-		if(fill_util_info(commit, path))
+		if (fill_util_info(commit))
 			continue;
 
 		alloc_line_map(commit);
@@ -471,7 +484,7 @@ static void process_commits(struct rev_i
 				printf("parent: %s\n",
 				       sha1_to_hex(parent->object.sha1));
 
-			if(fill_util_info(parent, path)) {
+			if (fill_util_info(parent)) {
 				num_parents--;
 				continue;
 			}
@@ -511,6 +524,135 @@ static void process_commits(struct rev_i
 	} while ((commit = get_revision(rev)) != NULL);
 }
 
+
+static int compare_tree_path(struct rev_info* revs,
+			     struct commit* c1, struct commit* c2)
+{
+	const char* paths[2];
+	struct util_info* util = c2->object.util;
+	paths[0] = util->pathname;
+	paths[1] = NULL;
+
+	diff_tree_setup_paths(get_pathspec(revs->prefix, paths));
+	return rev_compare_tree(c1->tree, c2->tree);
+}
+
+
+static int same_tree_as_empty_path(struct rev_info *revs, struct tree* t1,
+				   const char* path)
+{
+	const char* paths[2];
+	paths[0] = path;
+	paths[1] = NULL;
+
+	diff_tree_setup_paths(get_pathspec(revs->prefix, paths));
+	return rev_same_tree_as_empty(t1);
+}
+
+static const char* find_rename(struct commit* commit, struct commit* parent)
+{
+	struct util_info* cutil = commit->object.util;
+	struct diff_options diff_opts;
+	const char *paths[1];
+	int i;
+
+	if (DEBUG) {
+		printf("find_rename commit: %s ",
+		       sha1_to_hex(commit->object.sha1));
+		puts(sha1_to_hex(parent->object.sha1));
+	}
+
+	diff_setup(&diff_opts);
+	diff_opts.recursive = 1;
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	paths[0] = NULL;
+	diff_tree_setup_paths(paths);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("diff_setup_done failed");
+
+	diff_tree_sha1(commit->tree->object.sha1, parent->tree->object.sha1,
+		       "", &diff_opts);
+	diffcore_std(&diff_opts);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		if (p->status == 'R' && !strcmp(p->one->path, cutil->pathname)) {
+			if (DEBUG)
+				printf("rename %s -> %s\n", p->one->path, p->two->path);
+			return p->two->path;
+		}
+	}
+
+	return 0;
+}
+
+static void simplify_commit(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list **pp, *parent;
+
+	if (!commit->tree)
+		return;
+
+	if (!commit->parents) {
+		struct util_info* util = commit->object.util;
+		if (!same_tree_as_empty_path(revs, commit->tree,
+					     util->pathname))
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
+		switch (compare_tree_path(revs, p, commit)) {
+		case REV_TREE_SAME:
+			parent->next = NULL;
+			commit->parents = parent;
+			get_util(p)->pathname = get_util(commit)->pathname;
+			return;
+
+		case REV_TREE_NEW:
+		{
+			
+			struct util_info* util = commit->object.util;
+			if (revs->remove_empty_trees &&
+			    same_tree_as_empty_path(revs, p->tree,
+						    util->pathname)) {
+				const char* new_name = find_rename(commit, p);
+				if (new_name) {
+					struct util_info* putil = get_util(p);
+					if (!putil->pathname)
+						putil->pathname = strdup(new_name);
+				} else {
+					*pp = parent->next;
+					continue;
+				}
+			}
+		}
+
+		/* fallthrough */
+		case REV_TREE_DIFFERENT:
+			pp = &parent->next;
+			if (!get_util(p)->pathname)
+				get_util(p)->pathname =
+					get_util(commit)->pathname;
+			continue;
+		}
+		die("bad tree compare for commit %s",
+		    sha1_to_hex(commit->object.sha1));
+	}
+	commit->object.flags |= TREECHANGE;
+}
+
+
 struct commit_info
 {
 	char* author;
@@ -569,6 +711,18 @@ static const char* format_time(unsigned 
 	return time_buf;
 }
 
+static void topo_setter(struct commit* c, void* data)
+{
+	struct util_info* util = c->object.util;
+	util->topo_data = data;
+}
+
+static void* topo_getter(struct commit* c)
+{
+	struct util_info* util = c->object.util;
+	return util->topo_data;
+}
+
 int main(int argc, const char **argv)
 {
 	int i;
@@ -580,8 +734,8 @@ int main(int argc, const char **argv)
 	int sha1_len = 8;
 	int compability = 0;
 	int options = 1;
+	struct commit* start_commit;
 
-	int num_args;
 	const char* args[10];
 	struct rev_info rev;
 
@@ -634,28 +788,29 @@ int main(int argc, const char **argv)
 		strcpy(filename_buf, filename);
 	filename = filename_buf;
 
-	{
-		struct commit* c;
-		if (get_sha1(commit, sha1))
-			die("get_sha1 failed, commit '%s' not found", commit);
-		c = lookup_commit_reference(sha1);
-
-		if (fill_util_info(c, filename)) {
-			printf("%s not found in %s\n", filename, commit);
-			return 1;
-		}
+	if (get_sha1(commit, sha1))
+		die("get_sha1 failed, commit '%s' not found", commit);	
+	start_commit = lookup_commit_reference(sha1);
+	get_util(start_commit)->pathname = filename;
+	if (fill_util_info(start_commit)) {
+		printf("%s not found in %s\n", filename, commit);
+		return 1;
 	}
 
-	num_args = 0;
-	args[num_args++] = NULL;
-	args[num_args++] = "--topo-order";
-	args[num_args++] = "--remove-empty";
-	args[num_args++] = commit;
-	args[num_args++] = "--";
-	args[num_args++] = filename;
-	args[num_args] = NULL;
 
-	setup_revisions(num_args, args, &rev, "HEAD");
+	init_revisions(&rev);	
+	rev.remove_empty_trees = 1;
+	rev.topo_order = 1;
+	rev.prune_fn = simplify_commit;
+	rev.topo_setter = topo_setter;
+	rev.topo_getter = topo_getter;
+	rev.limited = 1;
+
+	commit_list_insert(start_commit, &rev.commits);
+	
+	args[0] = filename;
+	args[1] = NULL;
+	diff_tree_setup_paths(args);
 	prepare_revision_walk(&rev);
 	process_commits(&rev, filename, &initial);
 
@@ -665,17 +820,21 @@ int main(int argc, const char **argv)
 
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
+		struct util_info* u;
+
 		if (!c)
 			c = initial;
 
+		u = c->object.util;
 		get_commit_info(c, &ci);
 		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
 		if(compability)
 			printf("\t(%10s\t%10s\t%d)", ci.author,
 			       format_time(ci.author_time, ci.author_tz), i+1);
 		else
-			printf(" (%-15.15s %10s %*d) ", ci.author,
-			       format_time(ci.author_time, ci.author_tz),
+			printf(" %s (%-15.15s %10s %*d) ", u->pathname,
+			       ci.author, format_time(ci.author_time,
+						      ci.author_tz),
 			       max_digits, i+1);
 
 		if(i == num_blame_lines - 1) {

From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [RFC, PATCH] Teach revision.c about renames
Date: Mon, 15 May 2006 22:37:00 +0200
Message-ID: <20060515203700.GB4497@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon May 15 23:38:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffkm2-0000rm-Fp
	for gcvg-git@gmane.org; Mon, 15 May 2006 23:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWEOVii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 17:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWEOVii
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 17:38:38 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:8609 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S964857AbWEOVii (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 17:38:38 -0400
Received: from c165 ([213.114.27.121] [213.114.27.121])
          by mxfep01.bredband.com with ESMTP
          id <20060515213836.LSFE19930.mxfep01.bredband.com@c165>;
          Mon, 15 May 2006 23:38:36 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FfjoL-0008L5-00; Mon, 15 May 2006 22:37:01 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20087>

Hi,

The attached patch is a work in progress to add support for rename
following to the revision walking code in revision.c.

When the rename following is enabled (with the new '--renames' flag)
any pathspecs given on the command line are interpreted as
filenames. Those filenames are then followed through the commit graph.

For example, 'git log --renames -- git-fetch.sh' will show us the
history of 'git-fetch.sh' till commit
215a7ad1ef790467a4cd3f0dcffbd6e5f04c38f7 where it was renamed from
git-fetch-script, we then get the history of git-fetch-script instead.

This works with all commands that use revision.c. So 'gitk --renames
git-fetch.sh' and 'git whatchanged --renames git-fetch.sh' also
work. Multiple filenames are supposed to work (e.g., 'gitk --renames
-- git-fetch.sh Documentation/technical/pack-protocol.txt')

The patch currently have a few issues (that I am aware of):

* A linked list is used to keep track of which filenames that we care
  about for each commit. A more efficient data structure may be a good
  idea.

* Memory leaks. In particular the struct path_lists are never freed.

* Pathspecs that aren't filenames cause assertion failures. (for
  example 'git log --renames -- Documentation/') I don't really know
  what we should do in this case. Should we interpret 'Documentation/'
  as if the user supplied us with all the files in the Documentation
  directory and then track those? Or, should we show commits that
  change anything under Documentation/ (i.e., the old non-rename
  following behaviour) and additionally track files that are moved
  from Documentation/ to some other location. Yet another alternative
  is to disallow non-filenames. Thoughts?

* Is '--renames' a good name for the flag? I considered
  '--follow-renames' first, but found it a bit too long.


Any comments would be greatly appreciated.

- Fredrik

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 log-tree.c |    7 +
 revision.c |  347 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.h |   30 +++++
 3 files changed, 381 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index b90ba67..8ed500a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -84,11 +84,12 @@ int log_tree_diff_flush(struct rev_info 
 }
 
 static int diff_root_tree(struct rev_info *opt,
-			  const unsigned char *new, const char *base)
+			  struct commit* commit, const char *base)
 {
 	int retval;
 	void *tree;
 	struct tree_desc empty, real;
+	const unsigned char* new = commit->object.sha1;
 
 	tree = read_object_with_reference(new, tree_type, &real.size, NULL);
 	if (!tree)
@@ -97,6 +98,7 @@ static int diff_root_tree(struct rev_inf
 
 	empty.buf = "";
 	empty.size = 0;
+	rev_setup_diffopt_paths(opt, commit, NULL);
 	retval = diff_tree(&empty, &real, base, &opt->diffopt);
 	free(tree);
 	log_tree_diff_flush(opt);
@@ -129,7 +131,7 @@ static int log_tree_diff(struct rev_info
 	parents = commit->parents;
 	if (!parents) {
 		if (opt->show_root_diff)
-			diff_root_tree(opt, sha1, "");
+			diff_root_tree(opt, commit, "");
 		return !opt->loginfo;
 	}
 
@@ -148,6 +150,7 @@ static int log_tree_diff(struct rev_info
 	for (;;) {
 		struct commit *parent = parents->item;
 
+		rev_setup_diffopt_paths(opt, commit, parent);
 		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 
diff --git a/revision.c b/revision.c
index 2294b16..523ab29 100644
--- a/revision.c
+++ b/revision.c
@@ -1,12 +1,17 @@
+#include <assert.h>
+
 #include "cache.h"
 #include "tag.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "refs.h"
 #include "revision.h"
 
+#define DEBUG 0
+
 static char *path_name(struct name_path *path, const char *name)
 {
 	struct name_path *p;
@@ -507,6 +512,320 @@ static int add_parents_only(struct rev_i
 	return 1;
 }
 
+/* Rename following code */
+const struct path_list* path_list_find(const struct path_list* list,
+					      const char* path)
+{
+	for(; list; list = list->next) {
+		if (!strcmp(path, list->item))
+			return list;
+	}
+
+	return NULL;
+}
+
+struct path_list* path_list_insert(char *item, struct path_list **list_p)
+{
+	struct path_list *new_list = xmalloc(sizeof(struct path_list));
+	new_list->item = item;
+	new_list->next = *list_p;
+	*list_p = new_list;
+	return new_list;
+}
+
+void path_list_print(FILE* file, struct path_list* list)
+{
+	for(; list; list = list->next)
+		fprintf(file, "%s ", list->item);
+	fputc('\n', file);
+}
+
+void free_path_list(struct path_list *list)
+{
+	while (list) {
+		struct path_list *temp = list;
+		list = temp->next;
+		free(temp);
+	}
+}
+
+const char** convert_to_pathspec(struct path_list* l1, struct path_list* l2)
+{
+	struct path_list* l;
+	const char** ret;
+	int i, len = 0;
+
+	for(l = l1; l; l = l->next, len++)
+		;
+	for(l = l2; l; l = l->next, len++)
+		;
+
+	ret = xmalloc((len+1)*sizeof(char*));
+	for(i = 0; l1; l1 = l1->next, i++)
+		ret[i] = l1->item;
+ 	for(; l2; l2 = l2->next, i++)
+		ret[i] = l2->item;
+
+	ret[len] = NULL;
+	return ret;
+}
+
+static struct rev_commit_info* get_util(struct commit *commit)
+{
+	struct rev_commit_info *util = commit->object.util;
+
+	if (util)
+		return util;
+
+	util = xmalloc(sizeof(struct rev_commit_info));
+	util->paths = NULL;
+	util->topo_data = NULL;
+	commit->object.util = util;
+	return util;
+}
+
+void rev_setup_diffopt_paths(struct rev_info* revs,
+			     struct commit* commit,
+			     struct commit* parent)
+{
+	const char** pathspec =
+		convert_to_pathspec(get_util(commit)->paths,
+				    parent ? get_util(parent)->paths : NULL);
+
+	/* FIXME we can't free revs->diffopt.paths here because the
+	 * initial value of that variable isn't necessarily allocated
+	 * by malloc.
+	 *
+	 * free(revs->diffopt.paths); */
+	diff_tree_release_paths(&revs->diffopt);
+	diff_tree_setup_paths(pathspec, &revs->diffopt);
+}
+
+
+static void topo_setter(struct commit* c, void* data)
+{
+	struct rev_commit_info* util = c->object.util;
+	util->topo_data = data;
+}
+
+static void* topo_getter(struct commit* c)
+{
+	struct rev_commit_info* util = c->object.util;
+	return util->topo_data;
+}
+
+
+static int same_tree_as_empty_paths(struct rev_info *revs, struct tree* t1,
+				    struct path_list* paths)
+{
+	int ret;
+
+	const char** pathspec = convert_to_pathspec(paths, NULL);
+	diff_tree_setup_paths(pathspec, &revs->pruning);
+	ret = rev_same_tree_as_empty(revs, t1);
+	diff_tree_release_paths(&revs->pruning);
+	free(pathspec);
+	return ret;
+}
+
+
+static struct path_list* file_removals;
+static void file_add_remove_ren(struct diff_options *options,
+				int addremove, unsigned mode,
+				const unsigned char *sha1,
+				const char *base, const char *path)
+{
+	if (DEBUG)
+		printf("%c base: '%s' path: '%s'\n", addremove, base, path);
+
+	if (addremove == '-') {
+		char* p = xmalloc(strlen(base) + strlen(path) + 1);
+		strcpy(p, base);
+		strcat(p, path);
+		path_list_insert(p, &file_removals);
+		tree_difference = REV_TREE_NEW;
+	} else {
+		assert(0);
+	}
+}
+
+static void file_change_ren(struct diff_options *options,
+			    unsigned old_mode, unsigned new_mode,
+			    const unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const char *base, const char *path)
+{
+	if (tree_difference == REV_TREE_SAME)
+		tree_difference = REV_TREE_DIFFERENT;
+}
+
+static int compare_tree_paths(struct rev_info* revs,
+			      struct commit* parent, struct commit* commit,
+			      struct path_list** added)
+{
+	const char** pathspec;
+	struct diff_options dopts;
+
+	diff_setup(&dopts);
+	dopts.recursive = 1;
+	dopts.add_remove = file_add_remove_ren;
+	dopts.change = file_change_ren;
+	dopts.output_format = DIFF_FORMAT_NO_OUTPUT;
+
+	pathspec = convert_to_pathspec(get_util(commit)->paths, NULL);
+	diff_tree_setup_paths(pathspec, &dopts);
+
+	if (diff_setup_done(&dopts) < 0)
+		die("diff_setup_done failed");
+
+	file_removals = NULL;
+	tree_difference = REV_TREE_SAME;
+
+	diff_tree_sha1(commit->tree->object.sha1, parent->tree->object.sha1,
+		       "", &dopts);
+
+	diff_flush(&dopts);
+	diff_tree_release_paths(&dopts);
+	free(pathspec);
+
+	*added = file_removals;
+	return tree_difference;
+}
+
+static struct path_list* find_renames(struct commit* commit,
+				      struct commit* parent,
+				      struct path_list* paths)
+{
+	int i;
+	struct diff_options dopts;
+	struct path_list* ret = NULL;
+
+	if (DEBUG) {
+		printf("find_renames commit: %s ",
+		       sha1_to_hex(commit->object.sha1));
+		puts(sha1_to_hex(parent->object.sha1));
+		printf("rename from paths: ");
+		path_list_print(stdout, paths);
+	}
+
+	diff_setup(&dopts);
+	dopts.recursive = 1;
+	dopts.detect_rename = DIFF_DETECT_RENAME;
+	dopts.output_format = DIFF_FORMAT_NO_OUTPUT;
+
+	if (diff_setup_done(&dopts) < 0)
+		die("diff_setup_done failed");
+
+	diff_tree_sha1(commit->tree->object.sha1, parent->tree->object.sha1,
+		       "", &dopts);
+	diffcore_std(&dopts);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		if (0 && p->status == 'R' && DEBUG)
+			printf("rename %s -> %s\n", p->one->path, p->two->path);
+
+		if (p->status == 'R' && path_list_find(paths, p->one->path)) {
+			if (DEBUG)
+				printf("rename %s -> %s\n",
+				       p->one->path, p->two->path);
+			path_list_insert(strdup(p->two->path), &ret);
+		}
+	}
+	diff_flush(&dopts);
+
+	if (DEBUG) {
+		printf("rename result: ");
+		path_list_print(stdout, ret);
+	}
+	return ret;
+}
+
+static struct path_list* rewrite_paths(struct rev_info *revs,
+				       struct commit* commit,
+				       struct commit* parent,
+				       struct path_list* removed)
+{
+	struct path_list* new_paths = find_renames(commit, parent, removed);
+	struct path_list* cpaths = get_util(commit)->paths;
+	for(; cpaths; cpaths = cpaths->next) {
+		if (!path_list_find(removed, cpaths->item))
+			path_list_insert(cpaths->item, &new_paths);
+	}
+	return new_paths;
+}
+
+static void simplify_commit_rename(struct rev_info *revs,
+				   struct commit *commit)
+{
+	struct commit_list **pp, *parent;
+
+	if (!commit->tree)
+		return;
+
+	{
+		struct rev_commit_info* util = get_util(commit);
+		if (!util->paths) {
+			util->paths = revs->initial_paths;
+			if (DEBUG)
+				printf("NULL paths\n");
+		}
+	}
+
+	if (!commit->parents) {
+		struct rev_commit_info* util = commit->object.util;
+		if (!same_tree_as_empty_paths(revs, commit->tree,
+					      util->paths))
+			commit->object.flags |= TREECHANGE;
+		return;
+	}
+
+	pp = &commit->parents;
+	while ((parent = *pp) != NULL) {
+		struct commit *p = parent->item;
+		struct path_list* removed;
+
+		if (p->object.flags & UNINTERESTING) {
+			pp = &parent->next;
+			continue;
+		}
+
+		parse_commit(p);
+		switch (compare_tree_paths(revs, p, commit, &removed)) {
+		case REV_TREE_SAME:
+			parent->next = NULL;
+			commit->parents = parent;
+			get_util(p)->paths = get_util(commit)->paths;
+			return;
+
+		case REV_TREE_NEW:
+		{
+			struct path_list* new_paths =
+				rewrite_paths(revs, commit, p, removed);
+			if (new_paths) {
+				struct rev_commit_info* putil = get_util(p);
+				if (!putil->paths)
+					putil->paths = new_paths;
+			} else {
+				*pp = parent->next;
+				continue;
+			}
+		}
+
+		/* fallthrough */
+		case REV_TREE_DIFFERENT:
+			pp = &parent->next;
+			if (!get_util(p)->paths)
+				get_util(p)->paths = get_util(commit)->paths;
+			continue;
+		}
+		die("bad tree compare for commit %s",
+		    sha1_to_hex(commit->object.sha1));
+	}
+	commit->object.flags |= TREECHANGE;
+}
+
 void init_revisions(struct rev_info *revs)
 {
 	memset(revs, 0, sizeof(*revs));
@@ -742,6 +1061,11 @@ int setup_revisions(int argc, const char
 				revs->full_diff = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--renames")) {
+				revs->follow_renames = 1;
+				continue;
+			}
+
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
 				revs->diff = 1;
@@ -841,6 +1165,29 @@ int setup_revisions(int argc, const char
 		    (revs->diffopt.output_format != DIFF_FORMAT_DIFFSTAT))
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
+	if (revs->follow_renames && revs->prune_data) {
+		if (revs->remove_empty_trees)
+			die("--renames and --remove-empty are currently "
+			    "mutually exclusive");
+		revs->prune_fn = simplify_commit_rename;
+		revs->topo_setter = topo_setter;
+		revs->topo_getter = topo_getter;
+		revs->limited = 1;
+
+		{
+			char** p;
+			for(p = revs->prune_data; *p; p++) {
+				if (DEBUG)
+					printf("filename: %s\n", *p);
+				path_list_insert(strdup(*p),
+						 &revs->initial_paths);
+			}
+		}
+
+		if (DEBUG)
+			printf("prefix: %s\n", revs->prefix);
+	}
+
 	revs->diffopt.abbrev = revs->abbrev;
 	diff_setup_done(&revs->diffopt);
 
diff --git a/revision.h b/revision.h
index 48d7b4c..e73a327 100644
--- a/revision.h
+++ b/revision.h
@@ -39,7 +39,8 @@ struct rev_info {
 			limited:1,
 			unpacked:1,
 			boundary:1,
-			parents:1;
+			parents:1,
+			follow_renames:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
@@ -68,6 +69,9 @@ struct rev_info {
 	struct diff_options diffopt;
 	struct diff_options pruning;
 
+	/* Rename following */
+	struct path_list* initial_paths;
+
 	topo_sort_set_fn_t topo_setter;
 	topo_sort_get_fn_t topo_getter;
 };
@@ -99,4 +103,28 @@ extern struct object_list **add_object(s
 				       struct name_path *path,
 				       const char *name);
 
+
+
+struct path_list {
+	char* item;
+	struct path_list *next;
+};
+
+struct rev_commit_info {
+	struct path_list* paths;
+	void* topo_data;
+};
+
+extern const struct path_list*
+path_list_find(const struct path_list* list, const char* path);
+extern struct path_list*
+path_list_insert(char *item, struct path_list **list_p);
+extern void path_list_print(FILE*, struct path_list* list);
+extern void free_path_list(struct path_list *list);
+extern const char** convert_to_pathspec(struct path_list* l1,
+					struct path_list* l2);
+extern void rev_setup_diffopt_paths(struct rev_info* revs,
+				    struct commit* commit,
+				    struct commit* parent);
+
 #endif

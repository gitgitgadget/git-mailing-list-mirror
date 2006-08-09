From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Wed, 9 Aug 2006 21:28:15 +0200
Message-ID: <20060809192815.GA7954@c165.ib.student.liu.se>
References: <200608091257.19461.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 21:28:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAtj4-0007n2-5y
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 21:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHIT2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWHIT2S
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 15:28:18 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:62338 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750940AbWHIT2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 15:28:17 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep01.bredband.com with ESMTP
          id <20060809192815.XWUA17083.mxfep01.bredband.com@c165>;
          Wed, 9 Aug 2006 21:28:15 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GAtix-0007Ep-00; Wed, 09 Aug 2006 21:28:15 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200608091257.19461.jnareb@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25135>

On Wed, Aug 09, 2006 at 12:57:19PM +0200, Jakub Narebski wrote:
> This is call for better rename support in git (better than --full-history).
> There was such an attempt in "[RFC, PATCH] Teach revision.c about renames"
> by Fredrik Kuivinen
>   http://marc.theaimsgroup.com/?l=git&m=114772921317920
> but IIRC patch was dropped in the favor of --full-history option.

I don't think it was dropped in favor --full-history. Anyway, I did
some more work on that patch back then. Compared to the one posted in
the mail referenced above a couple of bugs have been fixed and a few
tests have been added. If anyone wants to play with it see the patch
in the end of this mail. It is on top of
ed90cbf5f681c0144909457be3f4792b47604a5b, so it's quite old and will
most probably not apply cleanly on the current master branch. I just
noticed that it makes t/t6003-rev-list-topo-order.sh fail too.

> What is needed by gitweb is for git-rev-list to not only follow revisions
> of file contents across renames, and return more revisions, 

Note that it is not enough to only return more revisions.

For example, consider the commits (newest commit first)
A: Rename "bar" to "foo"
B: No changes to "bar"
C: No changes to "bar", delete "foo"
<more commits here>

Then you want "git-rev-list --renames A -- foo" to return A,... not A,C,...

>                                                             but also
> return _how_ filename changes, without need to call git-diff-tree on each
> returned revision.

This is currently not done by the patch. Should be straight forward to
add though.


- Fredrik


---
 Documentation/git-rev-list.txt |    6 
 Makefile                       |    2 
 log-tree.c                     |    9 
 revision.c                     |  636 ++++++++++++++++++++++++++++++++++++++++-
 revision.h                     |   38 ++
 t/t6004-rev-list-rename.sh     |  100 ++++++
 6 files changed, 780 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ad6d14c..f7ecf8e 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -103,6 +103,12 @@ OPTIONS
 	topological order (i.e. descendant commits are shown
 	before their parents).
 
+--renames::
+	When optional paths are given together with '--renames' the
+	paths are tracked, and any renames detected by Git are
+	followed. This is useful for tracking the history of files
+	across renames.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Makefile b/Makefile
index dbf19c6..4212a05 100644
--- a/Makefile
+++ b/Makefile
@@ -85,7 +85,7 @@ uname_P := $(shell sh -c 'uname -p 2>/de
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g3 -O0 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
diff --git a/log-tree.c b/log-tree.c
index 58b0163..e53dd19 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -133,11 +133,12 @@ int log_tree_diff_flush(struct rev_info 
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
@@ -146,9 +147,11 @@ static int diff_root_tree(struct rev_inf
 
 	empty.buf = "";
 	empty.size = 0;
+	rev_setup_diffopt_paths(opt, commit, NULL);
 	retval = diff_tree(&empty, &real, base, &opt->diffopt);
 	free(tree);
 	log_tree_diff_flush(opt);
+	rev_free_diffopt_paths(opt, commit);
 	return retval;
 }
 
@@ -178,7 +181,7 @@ static int log_tree_diff(struct rev_info
 	parents = commit->parents;
 	if (!parents) {
 		if (opt->show_root_diff)
-			diff_root_tree(opt, sha1, "");
+			diff_root_tree(opt, commit, "");
 		return !opt->loginfo;
 	}
 
@@ -197,8 +200,10 @@ static int log_tree_diff(struct rev_info
 	for (;;) {
 		struct commit *parent = parents->item;
 
+		rev_setup_diffopt_paths(opt, commit, parent);
 		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
+		rev_free_diffopt_paths(opt, commit);
 
 		showed_log |= !opt->loginfo;
 
diff --git a/revision.c b/revision.c
index 2294b16..6d31e2d 100644
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
@@ -398,28 +403,67 @@ static void add_parents_to_list(struct r
 	}
 }
 
+static struct commit_list* remove_duplicates(struct commit_list* list)
+{
+	struct commit_list* res = list, *end;
+
+	if (!list)
+		return NULL;
+
+	if (DEBUG) {
+		printf("removing duplicates... list:\n");
+		commit_list_print(list);
+		printf("end of list\n");
+	}
+
+	res->item->object.flags |= DUPLICATE;
+	end = res;
+	for(list = list->next; list; list = list->next) {
+		if (!(list->item->object.flags & DUPLICATE)) {
+			end->next = list;
+			end = list;
+			list->item->object.flags |= DUPLICATE;
+		} else if(DEBUG)
+			printf("removing duplicate: %s\n", sha1_to_hex(list->item->object.sha1));
+	}
+	end->next = NULL;
+
+	if (DEBUG){
+		printf("new list:\n");
+		commit_list_print(res);
+		printf("end of list\n");
+	}
+
+	return res;
+}
+
 static void limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 
-	while (list) {
-		struct commit_list *entry = list;
-		struct commit *commit = list->item;
+	/* We have to be a bit careful here because objects may be
+	 * added to revs->commits by functions called by
+	 * add_parents_to_list and we want to process all those
+	 * objects, in addition to the objects which are in the list
+	 * in the beginning. */
+	while (revs->commits) {
+		struct commit_list *entry = revs->commits;
+		struct commit *commit = revs->commits->item;
 		struct object *obj = &commit->object;
 
-		list = list->next;
+		revs->commits = revs->commits->next;
 		free(entry);
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
 		if (revs->unpacked && has_sha1_pack(obj->sha1))
 			obj->flags |= UNINTERESTING;
-		add_parents_to_list(revs, commit, &list);
+		add_parents_to_list(revs, commit, &revs->commits);
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list))
+			if (everybody_uninteresting(revs->commits))
 				break;
 			continue;
 		}
@@ -457,6 +501,8 @@ static void limit_list(struct rev_info *
 			commit->object.flags &= ~TMP_MARK;
 		}
 	}
+	if (revs->follow_renames)
+		newlist = remove_duplicates(newlist);
 	revs->commits = newlist;
 }
 
@@ -507,6 +553,512 @@ static int add_parents_only(struct rev_i
 	return 1;
 }
 
+/* Rename following code */
+struct mem_pool
+{
+	/* This is slightly ugly. We don't really store paths in this
+	 * list, we store pointers to our memory blocks. */
+	struct path_list* list;
+
+	int block_size, len;
+};
+
+static void* mem_pool_alloc(struct mem_pool* pool, size_t size)
+{
+	assert(size < pool->block_size);
+	if (pool->list && pool->block_size - pool->len > size) {
+		int old_len = pool->len;
+		pool->len += size;
+		return pool->list->item + old_len;
+	} else {
+		if (DEBUG)
+			printf("allocating new block\n");
+		path_list_insert(xmalloc(pool->block_size), &pool->list);
+		pool->len = size;
+		return pool->list->item;
+	}
+}
+
+static void mem_pool_free(struct mem_pool* pool)
+{
+	struct path_list* next;
+	for (; pool->list; pool->list = next) {
+		free(pool->list->item);
+		next = pool->list->next;
+		free(pool->list);
+	}
+}
+
+static void mem_pool_init(struct mem_pool* pool, int block_size)
+{
+	pool->list = NULL;
+	pool->len = 0;
+	pool->block_size = block_size;
+}
+
+const struct path_list* path_list_find(const struct path_list* list,
+				       const char* path)
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
+/* Return non-zero if l1 is a (not necessarily proper) subset of l2
+ * and zero otherwise.
+ *
+ * Yes, this is slow. */
+int path_list_issubseteq(struct path_list* l1, struct path_list* l2)
+{
+	for (; l1; l1 = l1->next) {
+		if (!path_list_find(l2, l1->item))
+			return 0;
+	}
+
+	return 1;
+}
+
+struct path_list* path_list_insert_pool(char *item, struct path_list **list_p,
+					struct mem_pool* pool)
+{
+	struct path_list *new_list =
+		mem_pool_alloc(pool, sizeof(struct path_list));
+	new_list->item = item;
+	new_list->next = *list_p;
+	*list_p = new_list;
+	return new_list;
+}
+
+
+struct path_list* path_list_union_pool(struct path_list* l1,
+				       struct path_list* l2,
+				       struct mem_pool* pool)
+{
+	struct path_list* res;
+	for (; l1; l1 = l1->next)
+		path_list_insert_pool(l1->item, &res, pool);
+	for (; l2; l2 = l2->next)
+		path_list_insert_pool(l2->item, &res, pool);
+	return res;
+}
+
+void path_list_print(FILE* file, struct path_list* list)
+{
+	for(; list; list = list->next)
+		fprintf(file, "%s ", list->item);
+	fputc('\n', file);
+}
+
+void path_list_free(struct path_list *list)
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
+static int file_exists_helper(unsigned char *sha1, const char *base,
+			      int baselen, const char *pathname,
+			      unsigned mode, int stage);
+
+static int file_found;
+static const char* file_to_find;
+static int file_exists(struct tree *t, const char *pathname)
+{
+	const char *pathspec[2];
+
+	file_to_find = pathname;
+	pathspec[0] = pathname;
+	pathspec[1] = NULL;
+	file_found = 0;
+	read_tree_recursive(t, "", 0, 0, pathspec, file_exists_helper);
+
+	return file_found;
+}
+
+static int file_exists_helper(unsigned char *sha1, const char *base,
+			      int baselen, const char *pathname,
+			      unsigned mode, int stage)
+{
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	if (strncmp(file_to_find, base, baselen) ||
+	    strcmp(file_to_find + baselen, pathname))
+		return -1;
+
+	file_found = 1;
+	return -1;
+}
+
+static struct rev_commit_info* get_util(struct commit *commit)
+{
+	struct rev_commit_info *util = commit->object.util;
+
+	if (util)
+		return util;
+
+	util = xcalloc(1, sizeof(struct rev_commit_info));
+	commit->object.util = util;
+	return util;
+}
+
+void rev_setup_diffopt_paths(struct rev_info* revs,
+			     struct commit* commit,
+			     struct commit* parent)
+{
+	const char** pathspec;
+
+	if (!revs->follow_renames)
+		return;
+
+	pathspec = convert_to_pathspec(get_util(commit)->paths,
+				       parent ? get_util(parent)->paths : NULL);
+
+	diff_tree_setup_paths(pathspec, &revs->diffopt);
+}
+
+void rev_free_diffopt_paths(struct rev_info* revs, struct commit* commit)
+{
+	if (!revs->follow_renames)
+		return;
+
+	free(revs->diffopt.paths);
+	diff_tree_release_paths(&revs->diffopt);
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
+static int same_tree_as_empty_paths(struct rev_info *revs, struct tree* t1,
+				    struct path_list* paths)
+{
+	int ret;
+
+	if (!paths)
+		return 1;
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
+static struct mem_pool *current_string_pool, *current_list_pool;
+static void file_add_remove_ren(struct diff_options *options,
+				int addremove, unsigned mode,
+				const unsigned char *sha1,
+				const char *base, const char *path)
+{
+	if (DEBUG)
+		printf("%c base: '%s' path: '%s'\n", addremove, base, path);
+
+	if (addremove == '-') {
+		char* p = mem_pool_alloc(current_string_pool,
+					 strlen(base) + strlen(path) + 1);
+		strcpy(p, base);
+		strcat(p, path);
+		path_list_insert_pool(p, &file_removals, current_list_pool);
+		tree_difference = REV_TREE_NEW;
+	} else {
+		; //assert(0);
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
+	struct path_list* paths = get_util(commit)->paths;
+
+	if (!paths) {
+		*added = NULL;
+		return REV_TREE_SAME;
+	}
+
+	diff_setup(&dopts);
+	dopts.recursive = 1;
+	dopts.add_remove = file_add_remove_ren;
+	dopts.change = file_change_ren;
+	dopts.output_format = DIFF_FORMAT_NO_OUTPUT;
+
+	pathspec = convert_to_pathspec(paths, NULL);
+	diff_tree_setup_paths(pathspec, &dopts);
+
+	if (diff_setup_done(&dopts) < 0)
+		die("diff_setup_done failed");
+
+	file_removals = NULL;
+	tree_difference = REV_TREE_SAME;
+	current_string_pool = revs->string_pool;
+	current_list_pool = revs->list_pool;
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
+static struct path_list* find_renames(struct rev_info* revs,
+				      struct commit* commit,
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
+			char *str = mem_pool_alloc(revs->string_pool,
+						   strlen(p->two->path)+1);
+			strcpy(str, p->two->path);
+			path_list_insert_pool(str, &ret, revs->list_pool);
+
+			if (DEBUG) {
+				printf("rename %s -> %s\n",
+				       p->one->path, p->two->path);
+			}
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
+	struct path_list* new_paths = find_renames(revs, commit, parent,
+						   removed);
+	struct path_list* cpaths = get_util(commit)->paths;
+	for(; cpaths; cpaths = cpaths->next) {
+		if (!path_list_find(removed, cpaths->item))
+			path_list_insert(cpaths->item, &new_paths);
+	}
+	return new_paths;
+}
+
+static void reinsert_commit(struct rev_info* revs, struct commit* commit)
+{
+	/* Reparse the commit. We want the original parent list again
+	 * as the set of files we are following has grown. */
+
+	free_commit_list(commit->parents);
+	/* We need the following, otherwise parse_commit wont do the
+	 * right thing with the parents list. */
+	commit->parents = NULL;
+
+	commit->object.parsed = 0;
+	parse_commit(commit);
+
+	commit->object.flags &= ~ADDED;
+	commit_list_insert(commit, &revs->commits);
+	if (DEBUG)
+		printf("reinsert commit %s\n",
+		       sha1_to_hex(commit->object.sha1));
+}
+
+static void simplify_commit_rename(struct rev_info *revs,
+				   struct commit *commit)
+{
+	struct commit_list **pp, *parent;
+	struct rev_commit_info* cutil = get_util(commit);
+	int tree_changed = 0;
+
+	if (!commit->tree)
+		return;
+
+	if (!commit->parents) {
+		if (!same_tree_as_empty_paths(revs, commit->tree,
+					      cutil->paths))
+			commit->object.flags |= TREECHANGE;
+		return;
+	}
+
+	pp = &commit->parents;
+	while ((parent = *pp) != NULL) {
+		struct commit *p = parent->item;
+		struct path_list* removed;
+		struct rev_commit_info* putil = get_util(p);
+
+		parse_commit(p);
+		switch (compare_tree_paths(revs, p, commit, &removed)) {
+		case REV_TREE_SAME:
+		{
+			int do_return = 1;
+			if (!putil->paths)
+				putil->paths = cutil->paths;
+			else if (!path_list_issubseteq(cutil->paths,
+						       putil->paths)) {
+				putil->paths =
+					path_list_union_pool(cutil->paths,
+							     putil->paths,
+							     revs->list_pool);
+				reinsert_commit(revs, p);
+				tree_changed = 1;
+				do_return = 0;
+			}
+			if (p->object.flags & UNINTERESTING) {
+				/* Even if a merge with an uninteresting
+				 * side branch brought the entire change
+				 * we are interested in, we do not want
+				 * to lose the other branches of this
+				 * merge, so we just keep going.
+				 */
+				pp = &parent->next;
+				continue;
+			}
+			if (do_return) {
+				parent->next = NULL;
+				commit->parents = parent;
+				return;
+			} else {
+				continue;
+			}
+		}
+
+		case REV_TREE_NEW:
+		{
+			struct path_list* new_paths =
+				rewrite_paths(revs, commit, p, removed);
+			if (new_paths) {
+				if (!putil->paths)
+					putil->paths = new_paths;
+				else if (!path_list_issubseteq(new_paths,
+							       putil->paths)) {
+					putil->paths =
+						path_list_union_pool(new_paths,
+								     putil->paths,
+								     revs->list_pool);
+					reinsert_commit(revs, p);
+				}
+			} else {
+				parse_commit(p);
+				p->parents = NULL;
+			}
+			tree_changed = 1;
+			pp = &parent->next;
+			continue;
+		}
+
+		case REV_TREE_DIFFERENT:
+			tree_changed = 1;
+			pp = &parent->next;
+			if (!putil->paths)
+				putil->paths = cutil->paths;
+			else if (!path_list_issubseteq(cutil->paths,
+						       putil->paths)) {
+				putil->paths =
+					path_list_union_pool(cutil->paths,
+							     putil->paths,
+							     revs->list_pool);
+				reinsert_commit(revs, p);
+			}
+			continue;
+		}
+		die("bad tree compare for commit %s",
+		    sha1_to_hex(commit->object.sha1));
+	}
+	if (tree_changed)
+		commit->object.flags |= TREECHANGE;
+}
+
 void init_revisions(struct rev_info *revs)
 {
 	memset(revs, 0, sizeof(*revs));
@@ -742,6 +1294,11 @@ int setup_revisions(int argc, const char
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
@@ -841,15 +1398,65 @@ int setup_revisions(int argc, const char
 		    (revs->diffopt.output_format != DIFF_FORMAT_DIFFSTAT))
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
+	if (revs->follow_renames && revs->prune_data) {
+		char** p;
+		if (revs->remove_empty_trees)
+			die("--renames and --remove-empty are currently "
+			    "mutually exclusive");
+		revs->prune_fn = simplify_commit_rename;
+		revs->topo_setter = topo_setter;
+		revs->topo_getter = topo_getter;
+		revs->limited = 1;
+		revs->string_pool = xmalloc(sizeof(struct mem_pool));
+		revs->list_pool = xmalloc(sizeof(struct mem_pool));
+		mem_pool_init(revs->string_pool, 1024*4);
+		mem_pool_init(revs->list_pool, 1024*4);
+
+		revs->initial_paths = NULL;
+		for(p = revs->prune_data; *p; p++) {
+			char* str = mem_pool_alloc(revs->string_pool,
+						   strlen(*p)+1);
+			strcpy(str, *p);
+			path_list_insert(str, &revs->initial_paths);
+			if (DEBUG)
+				printf("filename: %s\n", *p);
+		}
+
+		if (DEBUG)
+			printf("prefix: %s\n", revs->prefix);
+	}
+
 	revs->diffopt.abbrev = revs->abbrev;
 	diff_setup_done(&revs->diffopt);
 
 	return left;
 }
 
+void free_revisions(struct rev_info *revs)
+{
+	if (revs->follow_renames) {
+		mem_pool_free(revs->string_pool);
+		mem_pool_free(revs->list_pool);
+
+		free(revs->string_pool);
+		free(revs->list_pool);
+	}
+}
+
+static void insert_by_date_commits(struct rev_info* revs,
+				   struct commit* commit)
+{
+	insert_by_date(commit, &revs->commits);
+	if (!revs->last_commit)
+		revs->last_commit = revs->commits;
+	else if (revs->last_commit->next)
+		revs->last_commit = revs->last_commit->next;
+}
+
 void prepare_revision_walk(struct rev_info *revs)
 {
 	struct object_list *list;
+	struct commit_list *clist;
 
 	list = revs->pending_objects;
 	revs->pending_objects = NULL;
@@ -858,12 +1465,27 @@ void prepare_revision_walk(struct rev_in
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
-				insert_by_date(commit, &revs->commits);
+				insert_by_date_commits(revs, commit);
 			}
 		}
 		list = list->next;
 	}
 
+	for (clist = revs->commits; clist; clist = clist->next) {
+		struct commit *commit = clist->item;
+		struct rev_commit_info *util = get_util(commit);
+		if (!util->paths) {
+			struct path_list* l;
+			for (l = revs->initial_paths; l; l = l->next) {
+				if (file_exists(commit->tree, l->item)) {
+					path_list_insert(l->item, &util->paths);
+				}
+			}
+			if (DEBUG)
+				printf("NULL paths\n");
+		}
+	}
+
 	if (revs->no_walk)
 		return;
 	if (revs->limited)
diff --git a/revision.h b/revision.h
index bdbdd23..a2d9666 100644
--- a/revision.h
+++ b/revision.h
@@ -9,15 +9,19 @@ #define TMP_MARK	(1u<<4) /* for isolated
 #define BOUNDARY	(1u<<5)
 #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
+#define DUPLICATE	(1u<<8)
 
 struct rev_info;
 struct log_info;
+struct path_list;
 
 typedef void (prune_fn_t)(struct rev_info *revs, struct commit *commit);
 
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
+	  /* the last entry in the 'commits' list */
+	struct commit_list *last_commit;
 	struct object_list *pending_objects;
 
 	/* Basic information */
@@ -39,7 +43,8 @@ struct rev_info {
 			limited:1,
 			unpacked:1,
 			boundary:1,
-			parents:1;
+			parents:1,
+			follow_renames:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
@@ -70,6 +75,11 @@ struct rev_info {
 	struct diff_options diffopt;
 	struct diff_options pruning;
 
+	/* Rename following */
+	struct path_list* initial_paths;
+	struct mem_pool* string_pool;
+	struct mem_pool* list_pool;
+
 	topo_sort_set_fn_t topo_setter;
 	topo_sort_get_fn_t topo_getter;
 };
@@ -84,6 +94,7 @@ extern int rev_compare_tree(struct rev_i
 
 extern void init_revisions(struct rev_info *revs);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern void free_revisions(struct rev_info *revs);
 extern void prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 
@@ -101,4 +112,29 @@ extern struct object_list **add_object(s
 				       struct name_path *path,
 				       const char *name);
 
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
+extern const struct path_list* path_list_find(const struct path_list* list,
+					      const char* path);
+extern struct path_list* path_list_insert(char *item,
+					  struct path_list **list_p);
+extern void path_list_print(FILE*, struct path_list* list);
+extern void free_path_list(struct path_list *list);
+extern const char** convert_to_pathspec(struct path_list* l1,
+					struct path_list* l2);
+
+extern void rev_setup_diffopt_paths(struct rev_info* revs,
+				    struct commit* commit,
+				    struct commit* parent);
+extern void rev_free_diffopt_paths(struct rev_info* revs,
+				   struct commit* commit);
+
 #endif
diff --git a/t/t6004-rev-list-rename.sh b/t/t6004-rev-list-rename.sh
new file mode 100755
index 0000000..e2d37d1
--- /dev/null
+++ b/t/t6004-rev-list-rename.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Fredrik Kuivinen
+# Bases on t6003-rev-list-topo-order.sh
+
+test_description='Tests git-rev-list --renames functionality'
+
+. ./test-lib.sh
+. ../t6000lib.sh # t6xxx specific functions
+
+list_duplicates()
+{
+    "$@" | sort | uniq -d
+}
+
+unique_commit_wd()
+{
+	_text=$1
+        _tree=`git-write-tree`
+	shift 1
+    	echo $_text | git-commit-tree $_tree "$@"
+}
+
+cp ../../COPYING .
+cp ../../README .
+git-update-index --add COPYING README
+hide_error save_tag root unique_commit_wd root
+
+echo '1' >> COPYING
+git-update-index COPYING
+save_tag l0 unique_commit_wd l0 -p root
+
+echo '1' >> README
+git-update-index COPYING README
+save_tag l1 unique_commit_wd l1 -p l0
+
+echo '2' >> COPYING
+echo '2' >> README
+git-update-index COPYING README
+save_tag l2 unique_commit_wd l2 -p l1
+
+git mv README README-ren
+save_tag l3 unique_commit_wd l3 -p l2
+
+git mv README-ren README-ren2
+save_tag a0 unique_commit_wd a0 -p l3
+
+git mv README-ren2 README-ren
+git mv COPYING COPYING-ren
+
+save_tag b0 unique_commit_wd b0 -p l3
+git mv README-ren README-ren2
+
+save_tag m unique_commit_wd m -p a0 -p b0
+git mv README-ren2 README-ren3
+echo '3' >> COPYING-ren
+git-update-index COPYING-ren
+save_tag head unique_commit_wd head -p m
+
+test_output_expect_success "--renames head -- README-ren3" "git-rev-list --topo-order --renames head -- README-ren3" <<EOF
+head
+a0
+l3
+l2
+l1
+root
+EOF
+
+test_output_expect_success "--renames head a0 -- COPYING" "git-rev-list --topo-order --renames head a0 -- COPYING" <<EOF
+l2
+l0
+root
+EOF
+
+test_output_expect_success "--renames head -- README-ren3 COPYING-ren" "git-rev-list --topo-order --renames head -- README-ren3 COPYING-ren" <<EOF
+head
+m
+b0
+a0
+l3
+l2
+l1
+l0
+root
+EOF
+
+test_output_expect_success "--renames --all -- README-ren3 COPYING" "git-rev-list --topo-order --renames --all -- README-ren3 COPYING" <<EOF
+head
+a0
+l3
+l2
+l1
+l0
+root
+EOF
+
+test_output_expect_success "--renames head -- COPYING README" "git-rev-list --renames head -- COPYING README" <<EOF
+EOF
+
+test_done

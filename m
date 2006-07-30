From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] read-trees: refactor the unpack_trees() part
Date: Sun, 30 Jul 2006 20:25:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607302024090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 30 20:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Fyf-0002NW-Tf
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWG3SZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWG3SZW
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:25:22 -0400
Received: from mail.gmx.net ([213.165.64.21]:65239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932407AbWG3SZU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 14:25:20 -0400
Received: (qmail invoked by alias); 30 Jul 2006 18:25:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 30 Jul 2006 20:25:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24465>


Basically, the options are passed by a struct unpack_trees_options now.
That's all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	It is a real pity we do not have "subcopies" in our diff file 
	format yet, because "copy" and "rename " do not help in this case.

 Makefile            |    4 
 builtin-read-tree.c |  571 ++++++++-------------------------------------------
 unpack-trees.c      |  394 +++++++++++++++++++++++++++++++++++
 unpack-trees.h      |   30 +++
 4 files changed, 517 insertions(+), 482 deletions(-)

diff --git a/Makefile b/Makefile
index c7b161b..4de2011 100644
--- a/Makefile
+++ b/Makefile
@@ -232,7 +232,7 @@ LIB_H = \
 	blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h log-tree.h dir.h path-list.h
+	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -247,7 +247,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	alloc.o merge-file.o path-list.o $(DIFF_OBJS)
+	alloc.o merge-file.o path-list.o unpack-trees.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 49c10bf..a9852c7 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -11,411 +11,17 @@ #include "object.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
-#include <sys/time.h>
-#include <signal.h>
+#include "unpack-trees.h"
 #include "builtin.h"
 
-static int reset = 0;
-static int merge = 0;
-static int update = 0;
-static int index_only = 0;
-static int nontrivial_merge = 0;
-static int trivial_merges_only = 0;
-static int aggressive = 0;
-static int verbose_update = 0;
-static volatile int progress_update = 0;
-static const char *prefix = NULL;
-
-static int head_idx = -1;
-static int merge_size = 0;
-
 static struct object_list *trees = NULL;
 
-static struct cache_entry df_conflict_entry;
-
-struct tree_entry_list {
-	struct tree_entry_list *next;
-	unsigned directory : 1;
-	unsigned executable : 1;
-	unsigned symlink : 1;
-	unsigned int mode;
-	const char *name;
-	const unsigned char *sha1;
-};
-
-static struct tree_entry_list df_conflict_list;
-
-typedef int (*merge_fn_t)(struct cache_entry **src);
-
-static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
-{
-	struct tree_desc desc;
-	struct name_entry one;
-	struct tree_entry_list *ret = NULL;
-	struct tree_entry_list **list_p = &ret;
-
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
-
-	while (tree_entry(&desc, &one)) {
-		struct tree_entry_list *entry;
-
-		entry = xmalloc(sizeof(struct tree_entry_list));
-		entry->name = one.path;
-		entry->sha1 = one.sha1;
-		entry->mode = one.mode;
-		entry->directory = S_ISDIR(one.mode) != 0;
-		entry->executable = (one.mode & S_IXUSR) != 0;
-		entry->symlink = S_ISLNK(one.mode) != 0;
-		entry->next = NULL;
-
-		*list_p = entry;
-		list_p = &entry->next;
-	}
-	return ret;
-}
-
-static int entcmp(const char *name1, int dir1, const char *name2, int dir2)
-{
-	int len1 = strlen(name1);
-	int len2 = strlen(name2);
-	int len = len1 < len2 ? len1 : len2;
-	int ret = memcmp(name1, name2, len);
-	unsigned char c1, c2;
-	if (ret)
-		return ret;
-	c1 = name1[len];
-	c2 = name2[len];
-	if (!c1 && dir1)
-		c1 = '/';
-	if (!c2 && dir2)
-		c2 = '/';
-	ret = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
-	if (c1 && c2 && !ret)
-		ret = len1 - len2;
-	return ret;
-}
-
-static int unpack_trees_rec(struct tree_entry_list **posns, int len,
-			    const char *base, merge_fn_t fn, int *indpos)
-{
-	int baselen = strlen(base);
-	int src_size = len + 1;
-	do {
-		int i;
-		const char *first;
-		int firstdir = 0;
-		int pathlen;
-		unsigned ce_size;
-		struct tree_entry_list **subposns;
-		struct cache_entry **src;
-		int any_files = 0;
-		int any_dirs = 0;
-		char *cache_name;
-		int ce_stage;
-
-		/* Find the first name in the input. */
-
-		first = NULL;
-		cache_name = NULL;
-
-		/* Check the cache */
-		if (merge && *indpos < active_nr) {
-			/* This is a bit tricky: */
-			/* If the index has a subdirectory (with
-			 * contents) as the first name, it'll get a
-			 * filename like "foo/bar". But that's after
-			 * "foo", so the entry in trees will get
-			 * handled first, at which point we'll go into
-			 * "foo", and deal with "bar" from the index,
-			 * because the base will be "foo/". The only
-			 * way we can actually have "foo/bar" first of
-			 * all the things is if the trees don't
-			 * contain "foo" at all, in which case we'll
-			 * handle "foo/bar" without going into the
-			 * directory, but that's fine (and will return
-			 * an error anyway, with the added unknown
-			 * file case.
-			 */
-
-			cache_name = active_cache[*indpos]->name;
-			if (strlen(cache_name) > baselen &&
-			    !memcmp(cache_name, base, baselen)) {
-				cache_name += baselen;
-				first = cache_name;
-			} else {
-				cache_name = NULL;
-			}
-		}
-
-#if DBRT_DEBUG > 1
-		if (first)
-			printf("index %s\n", first);
-#endif
-		for (i = 0; i < len; i++) {
-			if (!posns[i] || posns[i] == &df_conflict_list)
-				continue;
-#if DBRT_DEBUG > 1
-			printf("%d %s\n", i + 1, posns[i]->name);
-#endif
-			if (!first || entcmp(first, firstdir,
-					     posns[i]->name, 
-					     posns[i]->directory) > 0) {
-				first = posns[i]->name;
-				firstdir = posns[i]->directory;
-			}
-		}
-		/* No name means we're done */
-		if (!first)
-			return 0;
-
-		pathlen = strlen(first);
-		ce_size = cache_entry_size(baselen + pathlen);
-
-		src = xcalloc(src_size, sizeof(struct cache_entry *));
-
-		subposns = xcalloc(len, sizeof(struct tree_list_entry *));
-
-		if (cache_name && !strcmp(cache_name, first)) {
-			any_files = 1;
-			src[0] = active_cache[*indpos];
-			remove_cache_entry_at(*indpos);
-		}
-
-		for (i = 0; i < len; i++) {
-			struct cache_entry *ce;
-
-			if (!posns[i] ||
-			    (posns[i] != &df_conflict_list &&
-			     strcmp(first, posns[i]->name))) {
-				continue;
-			}
-
-			if (posns[i] == &df_conflict_list) {
-				src[i + merge] = &df_conflict_entry;
-				continue;
-			}
-
-			if (posns[i]->directory) {
-				struct tree *tree = lookup_tree(posns[i]->sha1);
-				any_dirs = 1;
-				parse_tree(tree);
-				subposns[i] = create_tree_entry_list(tree);
-				posns[i] = posns[i]->next;
-				src[i + merge] = &df_conflict_entry;
-				continue;
-			}
-
-			if (!merge)
-				ce_stage = 0;
-			else if (i + 1 < head_idx)
-				ce_stage = 1;
-			else if (i + 1 > head_idx)
-				ce_stage = 3;
-			else
-				ce_stage = 2;
-
-			ce = xcalloc(1, ce_size);
-			ce->ce_mode = create_ce_mode(posns[i]->mode);
-			ce->ce_flags = create_ce_flags(baselen + pathlen,
-						       ce_stage);
-			memcpy(ce->name, base, baselen);
-			memcpy(ce->name + baselen, first, pathlen + 1);
-
-			any_files = 1;
-
-			memcpy(ce->sha1, posns[i]->sha1, 20);
-			src[i + merge] = ce;
-			subposns[i] = &df_conflict_list;
-			posns[i] = posns[i]->next;
-		}
-		if (any_files) {
-			if (merge) {
-				int ret;
-
-#if DBRT_DEBUG > 1
-				printf("%s:\n", first);
-				for (i = 0; i < src_size; i++) {
-					printf(" %d ", i);
-					if (src[i])
-						printf("%s\n", sha1_to_hex(src[i]->sha1));
-					else
-						printf("\n");
-				}
-#endif
-				ret = fn(src);
-				
-#if DBRT_DEBUG > 1
-				printf("Added %d entries\n", ret);
-#endif
-				*indpos += ret;
-			} else {
-				for (i = 0; i < src_size; i++) {
-					if (src[i]) {
-						add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
-					}
-				}
-			}
-		}
-		if (any_dirs) {
-			char *newbase = xmalloc(baselen + 2 + pathlen);
-			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, first, pathlen);
-			newbase[baselen + pathlen] = '/';
-			newbase[baselen + pathlen + 1] = '\0';
-			if (unpack_trees_rec(subposns, len, newbase, fn,
-					     indpos))
-				return -1;
-			free(newbase);
-		}
-		free(subposns);
-		free(src);
-	} while (1);
-}
-
 static void reject_merge(struct cache_entry *ce)
 {
 	die("Entry '%s' would be overwritten by merge. Cannot merge.", 
 	    ce->name);
 }
 
-/* Unlink the last component and attempt to remove leading
- * directories, in case this unlink is the removal of the
- * last entry in the directory -- empty directories are removed.
- */
-static void unlink_entry(char *name)
-{
-	char *cp, *prev;
-
-	if (unlink(name))
-		return;
-	prev = NULL;
-	while (1) {
-		int status;
-		cp = strrchr(name, '/');
-		if (prev)
-			*prev = '/';
-		if (!cp)
-			break;
-
-		*cp = 0;
-		status = rmdir(name);
-		if (status) {
-			*cp = '/';
-			break;
-		}
-		prev = cp;
-	}
-}
-
-static void progress_interval(int signum)
-{
-	progress_update = 1;
-}
-
-static void setup_progress_signal(void)
-{
-	struct sigaction sa;
-	struct itimerval v;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = progress_interval;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
-}
-
-static struct checkout state;
-static void check_updates(struct cache_entry **src, int nr)
-{
-	unsigned short mask = htons(CE_UPDATE);
-	unsigned last_percent = 200, cnt = 0, total = 0;
-
-	if (update && verbose_update) {
-		for (total = cnt = 0; cnt < nr; cnt++) {
-			struct cache_entry *ce = src[cnt];
-			if (!ce->ce_mode || ce->ce_flags & mask)
-				total++;
-		}
-
-		/* Don't bother doing this for very small updates */
-		if (total < 250)
-			total = 0;
-
-		if (total) {
-			fprintf(stderr, "Checking files out...\n");
-			setup_progress_signal();
-			progress_update = 1;
-		}
-		cnt = 0;
-	}
-
-	while (nr--) {
-		struct cache_entry *ce = *src++;
-
-		if (total) {
-			if (!ce->ce_mode || ce->ce_flags & mask) {
-				unsigned percent;
-				cnt++;
-				percent = (cnt * 100) / total;
-				if (percent != last_percent ||
-				    progress_update) {
-					fprintf(stderr, "%4u%% (%u/%u) done\r",
-						percent, cnt, total);
-					last_percent = percent;
-					progress_update = 0;
-				}
-			}
-		}
-		if (!ce->ce_mode) {
-			if (update)
-				unlink_entry(ce->name);
-			continue;
-		}
-		if (ce->ce_flags & mask) {
-			ce->ce_flags &= ~mask;
-			if (update)
-				checkout_entry(ce, &state, NULL);
-		}
-	}
-	if (total) {
-		signal(SIGALRM, SIG_IGN);
-		fputc('\n', stderr);
-	}
-}
-
-static int unpack_trees(merge_fn_t fn)
-{
-	int indpos = 0;
-	unsigned len = object_list_length(trees);
-	struct tree_entry_list **posns;
-	int i;
-	struct object_list *posn = trees;
-	merge_size = len;
-
-	if (len) {
-		posns = xmalloc(len * sizeof(struct tree_entry_list *));
-		for (i = 0; i < len; i++) {
-			posns[i] = create_tree_entry_list((struct tree *) posn->item);
-			posn = posn->next;
-		}
-		if (unpack_trees_rec(posns, len, prefix ? prefix : "",
-				     fn, &indpos))
-			return -1;
-	}
-
-	if (trivial_merges_only && nontrivial_merge)
-		die("Merge requires file-level merging");
-
-	check_updates(active_cache, active_nr);
-	return 0;
-}
-
 static int list_tree(unsigned char *sha1)
 {
 	struct tree *tree = parse_tree_indirect(sha1);
@@ -440,11 +46,12 @@ static int same(struct cache_entry *a, s
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static void verify_uptodate(struct cache_entry *ce)
+static void verify_uptodate(struct cache_entry *ce,
+		struct unpack_trees_options *o)
 {
 	struct stat st;
 
-	if (index_only || reset)
+	if (o->index_only || o->reset)
 		return;
 
 	if (!lstat(ce->name, &st)) {
@@ -453,7 +60,7 @@ static void verify_uptodate(struct cache
 			return;
 		errno = 0;
 	}
-	if (reset) {
+	if (o->reset) {
 		ce->ce_flags |= htons(CE_UPDATE);
 		return;
 	}
@@ -472,18 +79,20 @@ static void invalidate_ce_path(struct ca
  * We do not want to remove or overwrite a working tree file that
  * is not tracked.
  */
-static void verify_absent(const char *path, const char *action)
+static void verify_absent(const char *path, const char *action,
+		struct unpack_trees_options *o)
 {
 	struct stat st;
 
-	if (index_only || reset || !update)
+	if (o->index_only || o->reset || !o->update)
 		return;
 	if (!lstat(path, &st))
 		die("Untracked working tree file '%s' "
 		    "would be %s by merge.", path, action);
 }
 
-static int merged_entry(struct cache_entry *merge, struct cache_entry *old)
+static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
+		struct unpack_trees_options *o)
 {
 	merge->ce_flags |= htons(CE_UPDATE);
 	if (old) {
@@ -497,12 +106,12 @@ static int merged_entry(struct cache_ent
 		if (same(old, merge)) {
 			*merge = *old;
 		} else {
-			verify_uptodate(old);
+			verify_uptodate(old, o);
 			invalidate_ce_path(old);
 		}
 	}
 	else {
-		verify_absent(merge->name, "overwritten");
+		verify_absent(merge->name, "overwritten", o);
 		invalidate_ce_path(merge);
 	}
 
@@ -511,12 +120,13 @@ static int merged_entry(struct cache_ent
 	return 1;
 }
 
-static int deleted_entry(struct cache_entry *ce, struct cache_entry *old)
+static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
+		struct unpack_trees_options *o)
 {
 	if (old)
-		verify_uptodate(old);
+		verify_uptodate(old, o);
 	else
-		verify_absent(ce->name, "removed");
+		verify_absent(ce->name, "removed", o);
 	ce->ce_mode = 0;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
@@ -545,11 +155,12 @@ static void show_stage_entry(FILE *o,
 }
 #endif
 
-static int threeway_merge(struct cache_entry **stages)
+static int threeway_merge(struct cache_entry **stages,
+		struct unpack_trees_options *o)
 {
 	struct cache_entry *index;
 	struct cache_entry *head; 
-	struct cache_entry *remote = stages[head_idx + 1];
+	struct cache_entry *remote = stages[o->head_idx + 1];
 	int count;
 	int head_match = 0;
 	int remote_match = 0;
@@ -562,7 +173,7 @@ static int threeway_merge(struct cache_e
 	int no_anc_exists = 1;
 	int i;
 
-	for (i = 1; i < head_idx; i++) {
+	for (i = 1; i < o->head_idx; i++) {
 		if (!stages[i])
 			any_anc_missing = 1;
 		else {
@@ -573,14 +184,14 @@ static int threeway_merge(struct cache_e
 	}
 
 	index = stages[0];
-	head = stages[head_idx];
+	head = stages[o->head_idx];
 
-	if (head == &df_conflict_entry) {
+	if (head == &o->df_conflict_entry) {
 		df_conflict_head = 1;
 		head = NULL;
 	}
 
-	if (remote == &df_conflict_entry) {
+	if (remote == &o->df_conflict_entry) {
 		df_conflict_remote = 1;
 		remote = NULL;
 	}
@@ -596,7 +207,7 @@ static int threeway_merge(struct cache_e
 	 * and #14.
 	 */
 	if (!same(remote, head)) {
-		for (i = 1; i < head_idx; i++) {
+		for (i = 1; i < o->head_idx; i++) {
 			if (same(stages[i], head)) {
 				head_match = i;
 			}
@@ -614,7 +225,7 @@ static int threeway_merge(struct cache_e
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
 			reject_merge(index);
-		return merged_entry(remote, index);
+		return merged_entry(remote, index, o);
 	}
 	/*
 	 * If we have an entry in the index cache, then we want to
@@ -627,10 +238,10 @@ static int threeway_merge(struct cache_e
 	if (head) {
 		/* #5ALT, #15 */
 		if (same(head, remote))
-			return merged_entry(head, index);
+			return merged_entry(head, index, o);
 		/* #13, #3ALT */
 		if (!df_conflict_remote && remote_match && !head_match)
-			return merged_entry(head, index);
+			return merged_entry(head, index, o);
 	}
 
 	/* #1 */
@@ -640,7 +251,7 @@ static int threeway_merge(struct cache_e
 	/* Under the new "aggressive" rule, we resolve mostly trivial
 	 * cases that we historically had git-merge-one-file resolve.
 	 */
-	if (aggressive) {
+	if (o->aggressive) {
 		int head_deleted = !head && !df_conflict_head;
 		int remote_deleted = !remote && !df_conflict_remote;
 		/*
@@ -651,16 +262,16 @@ static int threeway_merge(struct cache_e
 		    (head_deleted && remote && remote_match) ||
 		    (remote_deleted && head && head_match)) {
 			if (index)
-				return deleted_entry(index, index);
+				return deleted_entry(index, index, o);
 			else if (path)
-				verify_absent(path, "removed");
+				verify_absent(path, "removed", o);
 			return 0;
 		}
 		/*
 		 * Added in both, identically.
 		 */
 		if (no_anc_exists && head && remote && same(head, remote))
-			return merged_entry(head, index);
+			return merged_entry(head, index, o);
 
 	}
 
@@ -669,17 +280,17 @@ static int threeway_merge(struct cache_e
 	 * conflict resolution files. 
 	 */
 	if (index) {
-		verify_uptodate(index);
+		verify_uptodate(index, o);
 	}
 	else if (path)
-		verify_absent(path, "overwritten");
+		verify_absent(path, "overwritten", o);
 
-	nontrivial_merge = 1;
+	o->nontrivial_merge = 1;
 
 	/* #2, #3, #4, #6, #7, #9, #11. */
 	count = 0;
 	if (!head_match || !remote_match) {
-		for (i = 1; i < head_idx; i++) {
+		for (i = 1; i < o->head_idx; i++) {
 			if (stages[i]) {
 				keep_entry(stages[i]);
 				count++;
@@ -708,14 +319,15 @@ #endif
  * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
  *
  */
-static int twoway_merge(struct cache_entry **src)
+static int twoway_merge(struct cache_entry **src,
+		struct unpack_trees_options *o)
 {
 	struct cache_entry *current = src[0];
 	struct cache_entry *oldtree = src[1], *newtree = src[2];
 
-	if (merge_size != 2)
+	if (o->merge_size != 2)
 		return error("Cannot do a twoway merge of %d trees",
-			     merge_size);
+			     o->merge_size);
 
 	if (current) {
 		if ((!oldtree && !newtree) || /* 4 and 5 */
@@ -730,12 +342,12 @@ static int twoway_merge(struct cache_ent
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
 			/* 10 or 11 */
-			return deleted_entry(oldtree, current);
+			return deleted_entry(oldtree, current, o);
 		}
 		else if (oldtree && newtree &&
 			 same(current, oldtree) && !same(current, newtree)) {
 			/* 20 or 21 */
-			return merged_entry(newtree, current);
+			return merged_entry(newtree, current, o);
 		}
 		else {
 			/* all other failures */
@@ -749,9 +361,9 @@ static int twoway_merge(struct cache_ent
 		}
 	}
 	else if (newtree)
-		return merged_entry(newtree, current);
+		return merged_entry(newtree, current, o);
 	else
-		return deleted_entry(oldtree, current);
+		return deleted_entry(oldtree, current, o);
 }
 
 /*
@@ -760,20 +372,21 @@ static int twoway_merge(struct cache_ent
  * Keep the index entries at stage0, collapse stage1 but make sure
  * stage0 does not have anything there.
  */
-static int bind_merge(struct cache_entry **src)
+static int bind_merge(struct cache_entry **src,
+		struct unpack_trees_options *o)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
-	if (merge_size != 1)
+	if (o->merge_size != 1)
 		return error("Cannot do a bind merge of %d trees\n",
-			     merge_size);
+			     o->merge_size);
 	if (a && old)
 		die("Entry '%s' overlaps.  Cannot bind.", a->name);
 	if (!a)
 		return keep_entry(old);
 	else
-		return merged_entry(a, NULL);
+		return merged_entry(a, NULL, o);
 }
 
 /*
@@ -782,19 +395,20 @@ static int bind_merge(struct cache_entry
  * The rule is:
  * - take the stat information from stage0, take the data from stage1
  */
-static int oneway_merge(struct cache_entry **src)
+static int oneway_merge(struct cache_entry **src,
+		struct unpack_trees_options *o)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
-	if (merge_size != 1)
+	if (o->merge_size != 1)
 		return error("Cannot do a oneway merge of %d trees",
-			     merge_size);
+			     o->merge_size);
 
 	if (!a)
-		return deleted_entry(old, old);
+		return deleted_entry(old, old, o);
 	if (old && same(old, a)) {
-		if (reset) {
+		if (o->reset) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ce_match_stat(old, &st, 1))
@@ -802,7 +416,7 @@ static int oneway_merge(struct cache_ent
 		}
 		return keep_entry(old);
 	}
-	return merged_entry(a, old);
+	return merged_entry(a, old, o);
 }
 
 static int read_cache_unmerged(void)
@@ -874,14 +488,12 @@ int cmd_read_tree(int argc, const char *
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
-	merge_fn_t fn = NULL;
+	struct unpack_trees_options opts;
 
-	df_conflict_list.next = &df_conflict_list;
-	state.base_dir = "";
-	state.force = 1;
-	state.quiet = 1;
-	state.refresh_cache = 1;
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = -1;
 
+	setup_git_directory();
 	git_config(git_default_config);
 
 	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
@@ -890,8 +502,6 @@ int cmd_read_tree(int argc, const char *
 
 	git_config(git_default_config);
 
-	merge = 0;
-	reset = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -899,12 +509,12 @@ int cmd_read_tree(int argc, const char *
 		 * the working tree.
 		 */
 		if (!strcmp(arg, "-u")) {
-			update = 1;
+			opts.update = 1;
 			continue;
 		}
 
 		if (!strcmp(arg, "-v")) {
-			verbose_update = 1;
+			opts.verbose_update = 1;
 			continue;
 		}
 
@@ -912,7 +522,7 @@ int cmd_read_tree(int argc, const char *
 		 * not even look at the working tree.
 		 */
 		if (!strcmp(arg, "-i")) {
-			index_only = 1;
+			opts.index_only = 1;
 			continue;
 		}
 
@@ -921,10 +531,10 @@ int cmd_read_tree(int argc, const char *
 		 * given subdirectory.
 		 */
 		if (!strncmp(arg, "--prefix=", 9)) {
-			if (stage || merge || prefix)
+			if (stage || opts.merge || opts.prefix)
 				usage(read_tree_usage);
-			prefix = arg + 9;
-			merge = 1;
+			opts.prefix = arg + 9;
+			opts.merge = 1;
 			stage = 1;
 			if (read_cache_unmerged())
 				die("you need to resolve your current index first");
@@ -936,38 +546,38 @@ int cmd_read_tree(int argc, const char *
 		 * correspond to them.
 		 */
 		if (!strcmp(arg, "--reset")) {
-			if (stage || merge || prefix)
+			if (stage || opts.merge || opts.prefix)
 				usage(read_tree_usage);
-			reset = 1;
-			merge = 1;
+			opts.reset = 1;
+			opts.merge = 1;
 			stage = 1;
 			read_cache_unmerged();
 			continue;
 		}
 
 		if (!strcmp(arg, "--trivial")) {
-			trivial_merges_only = 1;
+			opts.trivial_merges_only = 1;
 			continue;
 		}
 
 		if (!strcmp(arg, "--aggressive")) {
-			aggressive = 1;
+			opts.aggressive = 1;
 			continue;
 		}
 
 		/* "-m" stands for "merge", meaning we start in stage 1 */
 		if (!strcmp(arg, "-m")) {
-			if (stage || merge || prefix)
+			if (stage || opts.merge || opts.prefix)
 				usage(read_tree_usage);
 			if (read_cache_unmerged())
 				die("you need to resolve your current index first");
 			stage = 1;
-			merge = 1;
+			opts.merge = 1;
 			continue;
 		}
 
 		/* using -u and -i at the same time makes no sense */
-		if (1 < index_only + update)
+		if (1 < opts.index_only + opts.update)
 			usage(read_tree_usage);
 
 		if (get_sha1(arg, sha1))
@@ -976,52 +586,53 @@ int cmd_read_tree(int argc, const char *
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
-	if ((update||index_only) && !merge)
+	if ((opts.update||opts.index_only) && !opts.merge)
 		usage(read_tree_usage);
 
-	if (prefix) {
-		int pfxlen = strlen(prefix);
+	if (opts.prefix) {
+		int pfxlen = strlen(opts.prefix);
 		int pos;
-		if (prefix[pfxlen-1] != '/')
+		if (opts.prefix[pfxlen-1] != '/')
 			die("prefix must end with /");
 		if (stage != 2)
 			die("binding merge takes only one tree");
-		pos = cache_name_pos(prefix, pfxlen);
+		pos = cache_name_pos(opts.prefix, pfxlen);
 		if (0 <= pos)
 			die("corrupt index file");
 		pos = -pos-1;
 		if (pos < active_nr &&
-		    !strncmp(active_cache[pos]->name, prefix, pfxlen))
-			die("subdirectory '%s' already exists.", prefix);
-		pos = cache_name_pos(prefix, pfxlen-1);
+		    !strncmp(active_cache[pos]->name, opts.prefix, pfxlen))
+			die("subdirectory '%s' already exists.", opts.prefix);
+		pos = cache_name_pos(opts.prefix, pfxlen-1);
 		if (0 <= pos)
-			die("file '%.*s' already exists.", pfxlen-1, prefix);
+			die("file '%.*s' already exists.",
+					pfxlen-1, opts.prefix);
 	}
 
-	if (merge) {
+	if (opts.merge) {
 		if (stage < 2)
 			die("just how do you expect me to merge %d trees?", stage-1);
 		switch (stage - 1) {
 		case 1:
-			fn = prefix ? bind_merge : oneway_merge;
+			opts.fn = opts.prefix ? bind_merge : oneway_merge;
 			break;
 		case 2:
-			fn = twoway_merge;
+			opts.fn = twoway_merge;
 			break;
 		case 3:
 		default:
-			fn = threeway_merge;
+			opts.fn = threeway_merge;
 			cache_tree_free(&active_cache_tree);
 			break;
 		}
 
 		if (stage - 1 >= 3)
-			head_idx = stage - 2;
+			opts.head_idx = stage - 2;
 		else
-			head_idx = 1;
+			opts.head_idx = 1;
 	}
 
-	unpack_trees(fn);
+	unpack_trees(trees, &opts);
 
 	/*
 	 * When reading only one tree (either the most basic form,
@@ -1029,7 +640,7 @@ int cmd_read_tree(int argc, const char *
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
 	 */
-	if (trees && trees->item && !prefix && (!merge || (stage == 2))) {
+	if (trees && trees->item && !opts.prefix && (!opts.merge || (stage == 2))) {
 		cache_tree_free(&active_cache_tree);
 		prime_cache_tree();
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
new file mode 100644
index 0000000..ecff92d
--- /dev/null
+++ b/unpack-trees.c
@@ -0,0 +1,394 @@
+#include <signal.h>
+#include <sys/time.h>
+#include "cache.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+
+struct tree_entry_list {
+	struct tree_entry_list *next;
+	unsigned directory : 1;
+	unsigned executable : 1;
+	unsigned symlink : 1;
+	unsigned int mode;
+	const char *name;
+	const unsigned char *sha1;
+};
+
+static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
+{
+	struct tree_desc desc;
+	struct name_entry one;
+	struct tree_entry_list *ret = NULL;
+	struct tree_entry_list **list_p = &ret;
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (tree_entry(&desc, &one)) {
+		struct tree_entry_list *entry;
+
+		entry = xmalloc(sizeof(struct tree_entry_list));
+		entry->name = one.path;
+		entry->sha1 = one.sha1;
+		entry->mode = one.mode;
+		entry->directory = S_ISDIR(one.mode) != 0;
+		entry->executable = (one.mode & S_IXUSR) != 0;
+		entry->symlink = S_ISLNK(one.mode) != 0;
+		entry->next = NULL;
+
+		*list_p = entry;
+		list_p = &entry->next;
+	}
+	return ret;
+}
+
+static int entcmp(const char *name1, int dir1, const char *name2, int dir2)
+{
+	int len1 = strlen(name1);
+	int len2 = strlen(name2);
+	int len = len1 < len2 ? len1 : len2;
+	int ret = memcmp(name1, name2, len);
+	unsigned char c1, c2;
+	if (ret)
+		return ret;
+	c1 = name1[len];
+	c2 = name2[len];
+	if (!c1 && dir1)
+		c1 = '/';
+	if (!c2 && dir2)
+		c2 = '/';
+	ret = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
+	if (c1 && c2 && !ret)
+		ret = len1 - len2;
+	return ret;
+}
+
+static int unpack_trees_rec(struct tree_entry_list **posns, int len,
+			    const char *base, struct unpack_trees_options *o,
+			    int *indpos,
+			    struct tree_entry_list *df_conflict_list)
+{
+	int baselen = strlen(base);
+	int src_size = len + 1;
+	do {
+		int i;
+		const char *first;
+		int firstdir = 0;
+		int pathlen;
+		unsigned ce_size;
+		struct tree_entry_list **subposns;
+		struct cache_entry **src;
+		int any_files = 0;
+		int any_dirs = 0;
+		char *cache_name;
+		int ce_stage;
+
+		/* Find the first name in the input. */
+
+		first = NULL;
+		cache_name = NULL;
+
+		/* Check the cache */
+		if (o->merge && *indpos < active_nr) {
+			/* This is a bit tricky: */
+			/* If the index has a subdirectory (with
+			 * contents) as the first name, it'll get a
+			 * filename like "foo/bar". But that's after
+			 * "foo", so the entry in trees will get
+			 * handled first, at which point we'll go into
+			 * "foo", and deal with "bar" from the index,
+			 * because the base will be "foo/". The only
+			 * way we can actually have "foo/bar" first of
+			 * all the things is if the trees don't
+			 * contain "foo" at all, in which case we'll
+			 * handle "foo/bar" without going into the
+			 * directory, but that's fine (and will return
+			 * an error anyway, with the added unknown
+			 * file case.
+			 */
+
+			cache_name = active_cache[*indpos]->name;
+			if (strlen(cache_name) > baselen &&
+			    !memcmp(cache_name, base, baselen)) {
+				cache_name += baselen;
+				first = cache_name;
+			} else {
+				cache_name = NULL;
+			}
+		}
+
+#if DBRT_DEBUG > 1
+		if (first)
+			printf("index %s\n", first);
+#endif
+		for (i = 0; i < len; i++) {
+			if (!posns[i] || posns[i] == df_conflict_list)
+				continue;
+#if DBRT_DEBUG > 1
+			printf("%d %s\n", i + 1, posns[i]->name);
+#endif
+			if (!first || entcmp(first, firstdir,
+					     posns[i]->name, 
+					     posns[i]->directory) > 0) {
+				first = posns[i]->name;
+				firstdir = posns[i]->directory;
+			}
+		}
+		/* No name means we're done */
+		if (!first)
+			return 0;
+
+		pathlen = strlen(first);
+		ce_size = cache_entry_size(baselen + pathlen);
+
+		src = xcalloc(src_size, sizeof(struct cache_entry *));
+
+		subposns = xcalloc(len, sizeof(struct tree_list_entry *));
+
+		if (cache_name && !strcmp(cache_name, first)) {
+			any_files = 1;
+			src[0] = active_cache[*indpos];
+			remove_cache_entry_at(*indpos);
+		}
+
+		for (i = 0; i < len; i++) {
+			struct cache_entry *ce;
+
+			if (!posns[i] ||
+			    (posns[i] != df_conflict_list &&
+			     strcmp(first, posns[i]->name))) {
+				continue;
+			}
+
+			if (posns[i] == df_conflict_list) {
+				src[i + o->merge] = &o->df_conflict_entry;
+				continue;
+			}
+
+			if (posns[i]->directory) {
+				struct tree *tree = lookup_tree(posns[i]->sha1);
+				any_dirs = 1;
+				parse_tree(tree);
+				subposns[i] = create_tree_entry_list(tree);
+				posns[i] = posns[i]->next;
+				src[i + o->merge] = &o->df_conflict_entry;
+				continue;
+			}
+
+			if (!o->merge)
+				ce_stage = 0;
+			else if (i + 1 < o->head_idx)
+				ce_stage = 1;
+			else if (i + 1 > o->head_idx)
+				ce_stage = 3;
+			else
+				ce_stage = 2;
+
+			ce = xcalloc(1, ce_size);
+			ce->ce_mode = create_ce_mode(posns[i]->mode);
+			ce->ce_flags = create_ce_flags(baselen + pathlen,
+						       ce_stage);
+			memcpy(ce->name, base, baselen);
+			memcpy(ce->name + baselen, first, pathlen + 1);
+
+			any_files = 1;
+
+			memcpy(ce->sha1, posns[i]->sha1, 20);
+			src[i + o->merge] = ce;
+			subposns[i] = df_conflict_list;
+			posns[i] = posns[i]->next;
+		}
+		if (any_files) {
+			if (o->merge) {
+				int ret;
+
+#if DBRT_DEBUG > 1
+				printf("%s:\n", first);
+				for (i = 0; i < src_size; i++) {
+					printf(" %d ", i);
+					if (src[i])
+						printf("%s\n", sha1_to_hex(src[i]->sha1));
+					else
+						printf("\n");
+				}
+#endif
+				ret = o->fn(src, o);
+				
+#if DBRT_DEBUG > 1
+				printf("Added %d entries\n", ret);
+#endif
+				*indpos += ret;
+			} else {
+				for (i = 0; i < src_size; i++) {
+					if (src[i]) {
+						add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+					}
+				}
+			}
+		}
+		if (any_dirs) {
+			char *newbase = xmalloc(baselen + 2 + pathlen);
+			memcpy(newbase, base, baselen);
+			memcpy(newbase + baselen, first, pathlen);
+			newbase[baselen + pathlen] = '/';
+			newbase[baselen + pathlen + 1] = '\0';
+			if (unpack_trees_rec(subposns, len, newbase, o,
+					     indpos, df_conflict_list))
+				return -1;
+			free(newbase);
+		}
+		free(subposns);
+		free(src);
+	} while (1);
+}
+
+/* Unlink the last component and attempt to remove leading
+ * directories, in case this unlink is the removal of the
+ * last entry in the directory -- empty directories are removed.
+ */
+static void unlink_entry(char *name)
+{
+	char *cp, *prev;
+
+	if (unlink(name))
+		return;
+	prev = NULL;
+	while (1) {
+		int status;
+		cp = strrchr(name, '/');
+		if (prev)
+			*prev = '/';
+		if (!cp)
+			break;
+
+		*cp = 0;
+		status = rmdir(name);
+		if (status) {
+			*cp = '/';
+			break;
+		}
+		prev = cp;
+	}
+}
+
+static volatile int progress_update = 0;
+
+static void progress_interval(int signum)
+{
+	progress_update = 1;
+}
+
+static void setup_progress_signal(void)
+{
+	struct sigaction sa;
+	struct itimerval v;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = progress_interval;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+
+	v.it_interval.tv_sec = 1;
+	v.it_interval.tv_usec = 0;
+	v.it_value = v.it_interval;
+	setitimer(ITIMER_REAL, &v, NULL);
+}
+
+static struct checkout state;
+static void check_updates(struct cache_entry **src, int nr,
+		struct unpack_trees_options *o)
+{
+	unsigned short mask = htons(CE_UPDATE);
+	unsigned last_percent = 200, cnt = 0, total = 0;
+
+	if (o->update && o->verbose_update) {
+		for (total = cnt = 0; cnt < nr; cnt++) {
+			struct cache_entry *ce = src[cnt];
+			if (!ce->ce_mode || ce->ce_flags & mask)
+				total++;
+		}
+
+		/* Don't bother doing this for very small updates */
+		if (total < 250)
+			total = 0;
+
+		if (total) {
+			fprintf(stderr, "Checking files out...\n");
+			setup_progress_signal();
+			progress_update = 1;
+		}
+		cnt = 0;
+	}
+
+	while (nr--) {
+		struct cache_entry *ce = *src++;
+
+		if (total) {
+			if (!ce->ce_mode || ce->ce_flags & mask) {
+				unsigned percent;
+				cnt++;
+				percent = (cnt * 100) / total;
+				if (percent != last_percent ||
+				    progress_update) {
+					fprintf(stderr, "%4u%% (%u/%u) done\r",
+						percent, cnt, total);
+					last_percent = percent;
+					progress_update = 0;
+				}
+			}
+		}
+		if (!ce->ce_mode) {
+			if (o->update)
+				unlink_entry(ce->name);
+			continue;
+		}
+		if (ce->ce_flags & mask) {
+			ce->ce_flags &= ~mask;
+			if (o->update)
+				checkout_entry(ce, &state, NULL);
+		}
+	}
+	if (total) {
+		signal(SIGALRM, SIG_IGN);
+		fputc('\n', stderr);
+	}
+}
+
+int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
+{
+	int indpos = 0;
+	unsigned len = object_list_length(trees);
+	struct tree_entry_list **posns;
+	int i;
+	struct object_list *posn = trees;
+	struct tree_entry_list df_conflict_list;
+
+	df_conflict_list.next = &df_conflict_list;
+	state.base_dir = "";
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+
+	o->merge_size = len;
+
+	if (len) {
+		posns = xmalloc(len * sizeof(struct tree_entry_list *));
+		for (i = 0; i < len; i++) {
+			posns[i] = create_tree_entry_list((struct tree *) posn->item);
+			posn = posn->next;
+		}
+		if (unpack_trees_rec(posns, len, o->prefix ? o->prefix : "",
+				     o, &indpos, &df_conflict_list))
+			return -1;
+	}
+
+	if (o->trivial_merges_only && o->nontrivial_merge)
+		die("Merge requires file-level merging");
+
+	check_updates(active_cache, active_nr, o);
+	return 0;
+}
+
+
diff --git a/unpack-trees.h b/unpack-trees.h
new file mode 100644
index 0000000..babfcd7
--- /dev/null
+++ b/unpack-trees.h
@@ -0,0 +1,30 @@
+#ifndef UNPACK_TREES_H
+#define UNPACK_TREES_H
+
+struct unpack_trees_options;
+
+typedef int (*merge_fn_t)(struct cache_entry **src,
+		struct unpack_trees_options *options);
+
+struct unpack_trees_options {
+	int reset;
+	int merge;
+	int update;
+	int index_only;
+	int nontrivial_merge;
+	int trivial_merges_only;
+	int verbose_update;
+	int aggressive;
+	const char *prefix;
+	merge_fn_t fn;
+
+	int head_idx;
+	int merge_size;
+
+	struct cache_entry df_conflict_entry;
+};
+
+extern int unpack_trees(struct object_list *trees,
+		struct unpack_trees_options *options);
+
+#endif
-- 
1.4.2.rc2.g76b2-dirty

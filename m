From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [WIP] Status update on merge-recursive in C
Date: Sat, 8 Jul 2006 18:42:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607081840280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jul 08 18:43:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzFtY-0007Z9-5r
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 18:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWGHQmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 12:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWGHQmp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 12:42:45 -0400
Received: from mail.gmx.net ([213.165.64.21]:37846 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964880AbWGHQmo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 12:42:44 -0400
Received: (qmail invoked by alias); 08 Jul 2006 16:42:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 08 Jul 2006 18:42:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23490>


This is just an update for people being interested. Alex and me were
busy with that project for a few days now. While it has progressed nicely,
there are quite a couple TODOs in merge-recursive.c, just search for "TODO".

For impatient people: yes, it passes all the tests, and yes, according
to the evil test Alex did, it is faster than the Python script.

But no, it is not yet finished. Biggest points are:

- there are still three external calls
- in the end, it should not be necessary to write the index more than once
  (just before exiting)
- a lot of things can be refactored to make the code easier and shorter

BTW we cannot just plug in git-merge-tree yet, because git-merge-tree
does not handle renames at all.

This patch is meant for testing, and as such,

- it compile the program to git-merge-recur
- it adjusts the scripts and tests to use git-merge-recur instead of
  git-merge-recursive
- it provides "TEST", a script to execute the tests regarding -recursive
- it inlines the changes to read-cache.c (read_cache_from(), discard_cache()
  and refresh_cache_entry())

Brought to you by Alex Riesen and Dscho

---

 Makefile                |    8 
 TEST                    |   10 
 cache.h                 |    4 
 git-merge.sh            |    6 
 git-rebase.sh           |    4 
 merge-recursive.c       | 1560 +++++++++++++++++++++++++++++++++++++++++++++++
 path-list.c             |  105 +++
 path-list.h             |   22 +
 read-cache.c            |  104 ++-
 t/t3402-rebase-merge.sh |    2 
 10 files changed, 1773 insertions(+), 52 deletions(-)

diff --git a/Makefile b/Makefile
index 8d429a0..11feefe 100644
--- a/Makefile
+++ b/Makefile
@@ -179,7 +179,8 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X \
 	git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
+	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
+	git-merge-recur$X
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X git-update-ref$X \
 	git-count-objects$X git-diff$X git-push$X git-mailsplit$X \
@@ -647,6 +648,11 @@ git-http-push$X: revision.o http.o http-
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+merge-recursive.o path-list.o: path-list.h
+git-merge-recur$X: merge-recursive.o path-list.o $(LIB_FILE)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS)
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
diff --git a/TEST b/TEST
new file mode 100755
index 0000000..d530983
--- /dev/null
+++ b/TEST
@@ -0,0 +1,10 @@
+#!/bin/sh -x
+cd t || exit
+./t3400-rebase.sh              "$@" && \
+./t6020-merge-df.sh            "$@" && \
+./t3401-rebase-partial.sh      "$@" && \
+./t6021-merge-criss-cross.sh   "$@" && \
+./t3402-rebase-merge.sh        "$@" && \
+./t6022-merge-rename.sh        "$@" && \
+./t6010-merge-base.sh          "$@" && \
+:
diff --git a/cache.h b/cache.h
index 7b5c91c..08777ca 100644
--- a/cache.h
+++ b/cache.h
@@ -115,6 +115,7 @@ #define cache_entry_size(len) ((offsetof
 extern struct cache_entry **active_cache;
 extern unsigned int active_nr, active_alloc, active_cache_changed;
 extern struct cache_tree *active_cache_tree;
+extern int cache_errno;
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
@@ -142,13 +143,16 @@ #define alloc_nr(x) (((x)+16)*3/2)
 
 /* Initialize and use the cache information */
 extern int read_cache(void);
+extern int read_cache_from(const char *path);
 extern int write_cache(int newfd, struct cache_entry **cache, int entries);
+extern int discard_cache(void);
 extern int verify_path(const char *path);
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
 extern int add_cache_entry(struct cache_entry *ce, int option);
+extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_cache_entry_at(int pos);
 extern int remove_file_from_cache(const char *path);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
diff --git a/git-merge.sh b/git-merge.sh
index 24e3b50..b26ca14 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,15 +9,15 @@ USAGE='[-n] [--no-commit] [--squash] [-s
 LF='
 '
 
-all_strategies='recursive octopus resolve stupid ours'
-default_twohead_strategies='recursive'
+all_strategies='recur recur octopus resolve stupid ours'
+default_twohead_strategies='recur'
 default_octopus_strategies='octopus'
 no_trivial_merge_strategies='ours'
 use_strategies=
 
 index_merge=t
 if test "@@NO_PYTHON@@"; then
-	all_strategies='resolve octopus stupid ours'
+	all_strategies='recur resolve octopus stupid ours'
 	default_twohead_strategies='resolve'
 fi
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 3945e06..5d4c7d2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -35,7 +35,7 @@ If you would prefer to skip this patch, 
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset newbase
-strategy=recursive
+strategy=recur
 do_merge=
 dotest=$GIT_DIR/.dotest-merge
 prec=4
@@ -292,7 +292,7 @@ then
 	exit $?
 fi
 
-if test "@@NO_PYTHON@@" && test "$strategy" = "recursive"
+if test "@@NO_PYTHON@@" && test "$strategy" = "recur"
 then
 	die 'The recursive merge strategy currently relies on Python,
 which this installation of git was not configured with.  Please consider
diff --git a/merge-recursive.c b/merge-recursive.c
new file mode 100644
index 0000000..07a2b38
--- /dev/null
+++ b/merge-recursive.c
@@ -0,0 +1,1560 @@
+/*
+ * Recursive Merge algorithm stolen from git-merge-recursive.py by
+ * Fredrik Kuivinen.
+ * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
+ */
+#include <stdarg.h>
+#include <string.h>
+#include <assert.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <time.h>
+#include "cache.h"
+#include "cache-tree.h"
+#include "commit.h"
+#include "blob.h"
+#include "tree-walk.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "run-command.h"
+#include "tag.h"
+
+#include "path-list.h"
+
+/*#define DEBUG*/
+
+#ifdef DEBUG
+#define debug(args, ...) fprintf(stderr, args, ## __VA_ARGS__)
+#else
+#define debug(args, ...)
+#endif
+
+#ifdef DEBUG
+#include "quote.h"
+static void show_ce_entry(const char *tag, struct cache_entry *ce)
+{
+	if (tag && *tag &&
+	    (ce->ce_flags & htons(CE_VALID))) {
+		static char alttag[4];
+		memcpy(alttag, tag, 3);
+		if (isalpha(tag[0]))
+			alttag[0] = tolower(tag[0]);
+		else if (tag[0] == '?')
+			alttag[0] = '!';
+		else {
+			alttag[0] = 'v';
+			alttag[1] = tag[0];
+			alttag[2] = ' ';
+			alttag[3] = 0;
+		}
+		tag = alttag;
+	}
+
+	fprintf(stderr,"%s%06o %s %d\t",
+			tag,
+			ntohl(ce->ce_mode),
+			sha1_to_hex(ce->sha1),
+			ce_stage(ce));
+	write_name_quoted("", 0, ce->name,
+			'\n', stderr);
+	fputc('\n', stderr);
+}
+
+static void ls_files() {
+	int i;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		show_ce_entry("", ce);
+	}
+	fprintf(stderr, "---\n");
+}
+#endif
+
+/*
+ * A virtual commit has
+ * - (const char *)commit->util set to the name, and
+ * - *(int *)commit->object.sha1 set to the virtual id.
+ */
+static const char *commit_title(struct commit *commit, int *len)
+{
+	const char *s = "(null commit)";
+	*len = strlen(s);
+
+	if ( commit->util ) {
+		s = commit->util;
+		*len = strlen(s);
+	} else {
+		if ( parse_commit(commit) != 0 ) {
+			s = "(bad commit)";
+			*len = strlen(s);
+		} else {
+			s = commit->buffer;
+			char prev = '\0';
+			while ( *s ) {
+				if ( '\n' == prev && '\n' == *s ) {
+					++s;
+					break;
+				}
+				prev = *s++;
+			}
+			*len = 0;
+			while ( s[*len] && '\n' != s[*len] )
+				++(*len);
+		}
+	}
+	return s;
+}
+
+static const char *commit_hex_sha1(const struct commit *commit)
+{
+	return commit->util ? "virtual" : commit ?
+		sha1_to_hex(commit->object.sha1) : "undefined";
+}
+
+static unsigned commit_list_count(const struct commit_list *l)
+{
+	unsigned c = 0;
+	for (; l; l = l->next )
+		c++;
+	return c;
+}
+
+static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
+{
+	struct commit *commit = xcalloc(1, sizeof(struct commit));
+	static unsigned virtual_id = 1;
+	commit->tree = tree;
+	commit->util = (void*)comment;
+	*(int*)commit->object.sha1 = virtual_id++;
+	return commit;
+}
+
+/*
+ * TODO: we should not have to copy the SHA1s around, but rather reference
+ * them. That way, sha_eq() is just sha1 == sha2.
+ */
+static int sha_eq(const unsigned char *a, const unsigned char *b)
+{
+	if ( !a && !b )
+		return 2;
+	return a && b && memcmp(a, b, 20) == 0;
+}
+
+static void memswp(void *p1, void *p2, unsigned n)
+{
+	unsigned char *a = p1, *b = p2;
+	while ( n-- ) {
+		*a ^= *b;
+		*b ^= *a;
+		*a ^= *b;
+		++a;
+		++b;
+	}
+}
+
+/*
+ * TODO: we should convert the merge_result users to
+ * 	int blabla(..., struct commit **result)
+ * like everywhere else in git.
+ * Same goes for merge_tree_result and merge_file_info.
+ */
+struct merge_result
+{
+	struct commit *commit;
+	unsigned clean:1;
+};
+
+struct merge_tree_result
+{
+	struct tree *tree;
+	unsigned clean:1;
+};
+
+/*
+ * TODO: check if we can just reuse the active_cache structure: it is already
+ * sorted (by name, stage).
+ * Only problem: do not write it when flushing the cache.
+ */
+struct stage_data
+{
+	struct
+	{
+		unsigned mode;
+		unsigned char sha[20];
+	} stages[4];
+	unsigned processed:1;
+};
+
+static struct path_list currentFileSet = {NULL, 0, 0, 1};
+static struct path_list currentDirectorySet = {NULL, 0, 0, 1};
+
+static int output_indent = 0;
+
+static void output(const char *fmt, ...)
+{
+	va_list args;
+	int i;
+	for ( i = output_indent; i--; )
+		fputs("  ", stdout);
+	va_start(args, fmt);
+	vfprintf(stdout, fmt, args);
+	va_end(args);
+	fputc('\n', stdout);
+}
+
+static const char *original_index_file;
+static const char *temporary_index_file;
+static int cache_dirty = 0;
+
+static int flush_cache()
+{
+	/* flush temporary index */
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	int fd = hold_lock_file_for_update(lock, getenv("GIT_INDEX_FILE"));
+	if (fd < 0)
+		die("could not lock %s", temporary_index_file);
+	if (write_cache(fd, active_cache, active_nr) ||
+			close(fd) || commit_lock_file(lock))
+		die ("unable to write %s", getenv("GIT_INDEX_FILE"));
+	discard_cache();
+	cache_dirty = 0;
+	return 0;
+}
+
+static void setup_index(int temp)
+{
+	const char *idx = temp ? temporary_index_file: original_index_file;
+	if (cache_dirty)
+		die("fatal: cache changed flush_cache();");
+	unlink(temporary_index_file);
+	setenv("GIT_INDEX_FILE", idx, 1);
+	discard_cache();
+}
+
+static struct cache_entry *make_cache_entry(unsigned int mode,
+		const unsigned char *sha1, const char *path, int stage, int refresh)
+{
+	int size, len;
+	struct cache_entry *ce;
+
+	if (!verify_path(path))
+		return NULL;
+
+	len = strlen(path);
+	size = cache_entry_size(len);
+	ce = xcalloc(1, size);
+
+	memcpy(ce->sha1, sha1, 20);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_mode = create_ce_mode(mode);
+
+	if (refresh)
+		return refresh_cache_entry(ce, 0);
+
+	return ce;
+}
+
+static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
+		const char *path, int stage, int refresh, int options)
+{
+	struct cache_entry *ce;
+	if (!cache_dirty)
+		read_cache_from(getenv("GIT_INDEX_FILE"));
+	cache_dirty++;
+	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh);
+	if (!ce)
+		return error("cache_addinfo failed: %s", strerror(cache_errno));
+	return add_cache_entry(ce, options);
+}
+
+/*
+ * This is a global variable which is used in a number of places but
+ * only written to in the 'merge' function.
+ *
+ * index_only == 1    => Don't leave any non-stage 0 entries in the cache and
+ *                       don't update the working directory.
+ *               0    => Leave unmerged entries in the cache and update
+ *                       the working directory.
+ */
+static int index_only = 0;
+
+/*
+ * TODO: this can be streamlined by refactoring builtin-read-tree.c
+ */
+static int git_read_tree(const struct tree *tree)
+{
+#if 0
+	fprintf(stderr, "GIT_INDEX_FILE='%s' git-read-tree %s\n",
+		getenv("GIT_INDEX_FILE"),
+		sha1_to_hex(tree->object.sha1));
+#endif
+	const char *argv[] = { "git-read-tree", NULL, NULL, };
+	if (cache_dirty)
+		die("read-tree with dirty cache");
+	argv[1] = sha1_to_hex(tree->object.sha1);
+	int rc = run_command_v(2, argv);
+	return rc < 0 ? -1: rc;
+}
+
+/*
+ * TODO: this can be streamlined by refactoring builtin-read-tree.c
+ */
+static int git_merge_trees(const char *update_arg,
+			   struct tree *common,
+			   struct tree *head,
+			   struct tree *merge)
+{
+#if 0
+	fprintf(stderr, "GIT_INDEX_FILE='%s' git-read-tree %s -m %s %s %s\n",
+		getenv("GIT_INDEX_FILE"),
+		update_arg,
+		sha1_to_hex(common->object.sha1),
+		sha1_to_hex(head->object.sha1),
+		sha1_to_hex(merge->object.sha1));
+#endif
+	const char *argv[] = {
+		"git-read-tree", NULL, "-m", NULL, NULL, NULL,
+		NULL,
+	};
+	if (cache_dirty)
+		flush_cache();
+	argv[1] = update_arg;
+	argv[3] = sha1_to_hex(common->object.sha1);
+	argv[4] = sha1_to_hex(head->object.sha1);
+	argv[5] = sha1_to_hex(merge->object.sha1);
+	int rc = run_command_v(6, argv);
+	return rc < 0 ? -1: rc;
+}
+
+/*
+ * TODO: this can be streamlined by refactoring builtin-write-tree.c
+ */
+static struct tree *git_write_tree()
+{
+#if 0
+	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
+		getenv("GIT_INDEX_FILE"));
+#endif
+	if (cache_dirty)
+		flush_cache();
+	FILE *fp = popen("git-write-tree 2>/dev/null", "r");
+	char buf[41];
+	unsigned char sha1[20];
+	int ch;
+	unsigned i = 0;
+	while ( (ch = fgetc(fp)) != EOF )
+		if ( i < sizeof(buf)-1 && ch >= '0' && ch <= 'f' )
+			buf[i++] = ch;
+		else
+			break;
+	int rc = pclose(fp);
+	if ( rc == -1 || WEXITSTATUS(rc) )
+		return NULL;
+	buf[i] = '\0';
+	if ( get_sha1(buf, sha1) != 0 )
+		return NULL;
+	return lookup_tree(sha1);
+}
+
+/*
+ * TODO: get rid of files_and_dirs; we do not use it except for
+ * current_file_set and current_dir_set, which are global already.
+ */
+static struct
+{
+	struct path_list *files;
+	struct path_list *dirs;
+} files_and_dirs;
+
+static int save_files_dirs(const unsigned char *sha1,
+		const char *base, int baselen, const char *path,
+		unsigned int mode, int stage)
+{
+	int len = strlen(path);
+	char *newpath = malloc(baselen + len + 1);
+	memcpy(newpath, base, baselen);
+	memcpy(newpath + baselen, path, len);
+	newpath[baselen + len] = '\0';
+
+	if (S_ISDIR(mode))
+		path_list_insert(newpath, files_and_dirs.dirs);
+	else
+		path_list_insert(newpath, files_and_dirs.files);
+	free(newpath);
+
+	return READ_TREE_RECURSIVE;
+}
+
+static int get_files_dirs(struct tree *tree,
+			  struct path_list *files,
+			  struct path_list *dirs)
+{
+	int n;
+	files_and_dirs.files = files;
+	files_and_dirs.dirs = dirs;
+	debug("get_files_dirs ...\n");
+	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs) != 0) {
+		debug("  get_files_dirs done (0)\n");
+		return 0;
+	}
+	n = files->nr + dirs->nr;
+	debug("  get_files_dirs done (%d)\n", n);
+	return n;
+}
+
+/*
+ * TODO: this wrapper is so small, we can use path_list_lookup directly.
+ * Same goes for index_entry_get(), free_index_entries(), find_rename_bysrc(),
+ * free_rename_entries().
+ */
+static struct stage_data *index_entry_find(struct path_list *ents,
+					    const char *path)
+{
+	struct path_list_item *item = path_list_lookup(path, ents);
+	if (item)
+		return item->util;
+	return NULL;
+}
+
+static struct stage_data *index_entry_get(struct path_list *ents,
+					   const char *path)
+{
+	struct path_list_item *item = path_list_lookup(path, ents);
+
+	if (item == NULL) {
+		item = path_list_insert(path, ents);
+		item->util = xcalloc(1, sizeof(struct stage_data));
+	}
+	return item->util;
+}
+
+/*
+ * TODO: since the result of index_entry_from_db() is tucked into a
+ * path_list anyway, this helper can do that already.
+ */
+/*
+ * Returns a index_entry instance which doesn't have to correspond to
+ * a real cache entry in Git's index.
+ */
+static struct stage_data *index_entry_from_db(const char *path,
+					       struct tree *o,
+					       struct tree *a,
+					       struct tree *b)
+{
+	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
+	get_tree_entry(o->object.sha1, path,
+			e->stages[1].sha, &e->stages[1].mode);
+	get_tree_entry(a->object.sha1, path,
+			e->stages[2].sha, &e->stages[2].mode);
+	get_tree_entry(b->object.sha1, path,
+			e->stages[3].sha, &e->stages[3].mode);
+	return e;
+}
+
+static void free_index_entries(struct path_list **ents)
+{
+	if (!*ents)
+		return;
+
+	path_list_clear(*ents, 1);
+	free(*ents);
+	*ents = NULL;
+}
+
+/*
+ * Create a dictionary mapping file names to CacheEntry objects. The
+ * dictionary contains one entry for every path with a non-zero stage entry.
+ */
+static struct path_list *get_unmerged()
+{
+	struct path_list *unmerged = xcalloc(1, sizeof(struct path_list));
+	int i;
+
+	unmerged->strdup_paths = 1;
+	if (!cache_dirty) {
+		read_cache_from(getenv("GIT_INDEX_FILE"));
+		cache_dirty++;
+	}
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (!ce_stage(ce))
+			continue;
+
+		struct stage_data *e = index_entry_get(unmerged, ce->name);
+		e->stages[ce_stage(ce)].mode = ntohl(ce->ce_mode);
+		memcpy(e->stages[ce_stage(ce)].sha, ce->sha1, 20);
+	}
+
+	debug("  get_unmerged done\n");
+	return unmerged;
+}
+
+struct rename
+{
+	struct diff_filepair *pair;
+	struct stage_data *src_entry;
+	struct stage_data *dst_entry;
+	unsigned processed:1;
+};
+
+static struct rename *find_rename_bysrc(struct path_list *e,
+					      const char *name)
+{
+	struct path_list_item *item = path_list_lookup(name, e);
+	if (item)
+		return item->util;
+	return NULL;
+}
+
+static void free_rename_entries(struct path_list **list)
+{
+	if (!*list)
+		return;
+
+	path_list_clear(*list, 0);
+	free(*list);
+	*list = NULL;
+}
+
+/*
+ * Get information of all renames which occured between 'oTree' and
+ * 'tree'. We need the three trees in the merge ('oTree', 'aTree' and
+ * 'bTree') to be able to associate the correct cache entries with
+ * the rename information. 'tree' is always equal to either aTree or bTree.
+ */
+static struct path_list *get_renames(struct tree *tree,
+					struct tree *oTree,
+					struct tree *aTree,
+					struct tree *bTree,
+					struct path_list *entries)
+{
+#ifdef DEBUG
+	time_t t = time(0);
+	debug("getRenames ...\n");
+#endif
+	int i;
+	struct path_list *renames = xcalloc(1, sizeof(struct path_list));
+	struct diff_options opts;
+	diff_setup(&opts);
+	opts.recursive = 1;
+	opts.detect_rename = DIFF_DETECT_RENAME;
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	if (diff_setup_done(&opts) < 0)
+		die("diff setup failed");
+	diff_tree_sha1(oTree->object.sha1, tree->object.sha1, "", &opts);
+	diffcore_std(&opts);
+	for (i = 0; i < diff_queued_diff.nr; ++i) {
+		struct rename *re;
+		struct diff_filepair *pair = diff_queued_diff.queue[i];
+		if (pair->status != 'R') {
+			diff_free_filepair(pair);
+			continue;
+		}
+		re = xmalloc(sizeof(*re));
+		re->processed = 0;
+		re->pair = pair;
+		re->src_entry = index_entry_find(entries, re->pair->one->path);
+		/* TODO: should it not be an error, if src_entry was found? */
+		if ( !re->src_entry ) {
+			re->src_entry = index_entry_from_db(re->pair->one->path,
+					oTree, aTree, bTree);
+			struct path_list_item *item =
+				path_list_insert(re->pair->one->path, entries);
+			item->util = re->src_entry;
+		}
+		re->dst_entry = index_entry_find(entries, re->pair->two->path);
+		if ( !re->dst_entry ) {
+			re->dst_entry = index_entry_from_db(re->pair->two->path,
+					oTree, aTree, bTree);
+			struct path_list_item *item =
+				path_list_insert(re->pair->two->path, entries);
+			item->util = re->dst_entry;
+		}
+		struct path_list_item *item = path_list_insert(pair->one->path, renames);
+		item->util = re;
+	}
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_flush(&opts);
+	debug("  getRenames done in %ld\n", time(0)-t);
+	return renames;
+}
+
+/*
+ * TODO: the code would be way nicer, if we had a struct containing just sha1 and mode.
+ * In this particular case, we might get away reusing stage_data, no?
+ */
+int update_stages(const char *path,
+		   unsigned char *osha, unsigned omode,
+		   unsigned char *asha, unsigned amode,
+		   unsigned char *bsha, unsigned bmode,
+		   int clear /* =True */)
+{
+	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+	if ( clear ) 
+		if (add_cacheinfo(0, null_sha1, path, 0, 0, options))
+			return -1;
+	if ( omode )
+		if (add_cacheinfo(omode, osha, path, 1, 0, options))
+			return -1;
+	if ( amode )
+		if (add_cacheinfo(omode, osha, path, 2, 0, options))
+			return -1;
+	if ( bmode )
+		if (add_cacheinfo(omode, osha, path, 3, 0, options))
+			return -1;
+	return 0;
+}
+
+/*
+ * TODO: there has to be a function in libgit doing this exact thing.
+ */
+static int remove_path(const char *name)
+{
+	int ret;
+	char *slash;
+
+	ret = unlink(name);
+	if ( ret )
+		return ret;
+	int len = strlen(name);
+	char *dirs = malloc(len+1);
+	memcpy(dirs, name, len);
+	dirs[len] = '\0';
+	while ( (slash = strrchr(name, '/')) ) {
+		*slash = '\0';
+		len = slash - name;
+		if ( rmdir(name) != 0 )
+			break;
+	}
+	free(dirs);
+	return ret;
+}
+
+/* General TODO: unC99ify the code: no declaration after code */
+/* General TODO: no javaIfiCation: rename updateCache to update_cache */
+/*
+ * TODO: once we no longer call external programs, we'd probably be better of
+ * not setting / getting the environment variable GIT_INDEX_FILE all the time.
+ */
+int remove_file(int clean, const char *path)
+{
+	int updateCache = index_only || clean;
+	int updateWd = !index_only;
+
+	if ( updateCache ) {
+		if (!cache_dirty)
+			read_cache_from(getenv("GIT_INDEX_FILE"));
+		cache_dirty++;
+		if (remove_file_from_cache(path))
+			return -1;
+	}
+	if ( updateWd )
+	{
+		unlink(path);
+		if ( errno != ENOENT || errno != EISDIR )
+			return -1;
+		remove_path(path);
+	}
+	return 0;
+}
+
+static char *unique_path(const char *path, const char *branch)
+{
+	char *newpath = xmalloc(strlen(path) + 1 + strlen(branch) + 8 + 1);
+	strcpy(newpath, path);
+	strcat(newpath, "~");
+	char *p = newpath + strlen(newpath);
+	strcpy(p, branch);
+	for ( ; *p; ++p )
+		if ( '/' == *p )
+			*p = '_';
+	int suffix = 0;
+	struct stat st;
+	while ( path_list_has_path(&currentFileSet, newpath) ||
+		path_list_has_path(&currentDirectorySet, newpath) ||
+		lstat(newpath, &st) == 0 ) {
+		sprintf(p, "_%d", suffix++);
+	}
+	path_list_insert(newpath, &currentFileSet);
+	return newpath;
+}
+
+/*
+ * TODO: except for create_last, this so looks like
+ * safe_create_leading_directories().
+ */
+static int mkdir_p(const char *path, unsigned long mode, int create_last)
+{
+	char *buf = strdup(path);
+	char *p;
+
+	for ( p = buf; *p; ++p ) {
+		if ( *p != '/' )
+			continue;
+		*p = '\0';
+		if (mkdir(buf, mode)) {
+			int e = errno;
+			if ( e == EEXIST ) {
+				struct stat st;
+				if ( !stat(buf, &st) && S_ISDIR(st.st_mode) )
+					goto next; /* ok */
+				errno = e;
+			}
+			free(buf);
+			return -1;
+		}
+	next:
+		*p = '/';
+	}
+	free(buf);
+	if ( create_last && mkdir(path, mode) )
+		return -1;
+	return 0;
+}
+
+static void flush_buffer(int fd, const char *buf, unsigned long size)
+{
+	while (size > 0) {
+		long ret = xwrite(fd, buf, size);
+		if (ret < 0) {
+			/* Ignore epipe */
+			if (errno == EPIPE)
+				break;
+			die("merge-recursive: %s", strerror(errno));
+		} else if (!ret) {
+			die("merge-recursive: disk full?");
+		}
+		size -= ret;
+		buf += ret;
+	}
+}
+
+/* General TODO: reindent according to guide lines (no if ( blabla )) */
+void update_file_flags(const unsigned char *sha,
+		   unsigned mode,
+		   const char *path,
+		   int updateCache,
+		   int updateWd)
+{
+	if ( index_only )
+		updateWd = 0;
+
+	if ( updateWd ) {
+		char type[20];
+		void *buf;
+		unsigned long size;
+
+		buf = read_sha1_file(sha, type, &size);
+		if (!buf)
+			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
+		if ( strcmp(type, blob_type) != 0 )
+			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
+
+		if ( S_ISREG(mode) ) {
+			if ( mkdir_p(path, 0777, 0 /* don't create last element */) )
+				die("failed to create path %s: %s", path, strerror(errno));
+			unlink(path);
+			if ( mode & 0100 )
+				mode = 0777;
+			else
+				mode = 0666;
+			int fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+			if ( fd < 0 )
+				die("failed to open %s: %s", path, strerror(errno));
+			flush_buffer(fd, buf, size);
+			close(fd);
+		} else if ( S_ISLNK(mode) ) {
+			char *linkTarget = malloc(size + 1);
+			memcpy(linkTarget, buf, size);
+			linkTarget[size] = '\0';
+			mkdir_p(path, 0777, 0);
+			symlink(linkTarget, path);
+		} else
+			die("do not know what to do with %06o %s '%s'",
+			    mode, sha1_to_hex(sha), path);
+	}
+	if ( updateCache )
+		add_cacheinfo(mode, sha, path, 0, updateWd, ADD_CACHE_OK_TO_ADD);
+}
+
+/* TODO: is this often used? if not, do direct call */
+void update_file(int clean,
+		const unsigned char *sha,
+		unsigned mode,
+		const char *path)
+{
+	update_file_flags(sha, mode, path, index_only || clean, !index_only);
+}
+
+/* Low level file merging, update and removal */
+
+struct merge_file_info
+{
+	unsigned char sha[20];
+	unsigned mode;
+	unsigned clean:1,
+		 merge:1;
+};
+
+static char *git_unpack_file(const unsigned char *sha1, char *path)
+{
+	void *buf;
+	char type[20];
+	unsigned long size;
+	int fd;
+
+	buf = read_sha1_file(sha1, type, &size);
+	if (!buf || strcmp(type, blob_type))
+		die("unable to read blob object %s", sha1_to_hex(sha1));
+
+	strcpy(path, ".merge_file_XXXXXX");
+	fd = mkstemp(path);
+	if (fd < 0)
+		die("unable to create temp-file");
+	flush_buffer(fd, buf, size);
+	close(fd);
+	return path;
+}
+
+/*
+ * TODO: the signature would be much more efficient using stage_data
+ */
+static struct merge_file_info merge_file(const char *oPath,
+					 const unsigned char *oSha,
+					 unsigned oMode,
+					 const char *aPath,
+					 const unsigned char *aSha,
+					 unsigned aMode,
+					 const char *bPath,
+					 const unsigned char *bSha,
+					 unsigned bMode,
+					 const char *branch1Name,
+					 const char *branch2Name)
+{
+	struct merge_file_info result;
+	result.merge = 0;
+	result.clean = 1;
+
+	if ( (S_IFMT & aMode) != (S_IFMT & bMode) ) {
+		result.clean = 0;
+		if ( S_ISREG(aMode) ) {
+			result.mode = aMode;
+			memcpy(result.sha, aSha, 20);
+		} else {
+			result.mode = bMode;
+			memcpy(result.sha, bSha, 20);
+		}
+	} else {
+		if ( memcmp(aSha, oSha, 20) != 0 && memcmp(bSha, oSha, 20) != 0 )
+			result.merge = 1;
+
+		result.mode = aMode == oMode ? bMode: aMode;
+
+		if ( memcmp(aSha, oSha, 20) == 0 )
+			memcpy(result.sha, bSha, 20);
+		else if ( memcmp(bSha, oSha, 20) == 0 )
+			memcpy(result.sha, aSha, 20);
+		else if ( S_ISREG(aMode) ) {
+
+			int code = 1;
+			char orig[PATH_MAX];
+			char src1[PATH_MAX];
+			char src2[PATH_MAX];
+
+			git_unpack_file(oSha, orig);
+			git_unpack_file(aSha, src1);
+			git_unpack_file(bSha, src2);
+
+			const char *argv[] = {
+				"merge", "-L", NULL, "-L", NULL, "-L", NULL,
+				src1, orig, src2,
+				NULL
+			};
+			char *la, *lb, *lo;
+			argv[2] = la = strdup(mkpath("%s/%s", branch1Name, aPath));
+			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, bPath));
+			argv[4] = lo = strdup(mkpath("orig/%s", oPath));
+
+#if 0
+			printf("%s %s %s %s %s %s %s %s %s %s\n",
+			       argv[0], argv[1], argv[2], argv[3], argv[4],
+			       argv[5], argv[6], argv[7], argv[8], argv[9]);
+#endif
+			code = run_command_v(10, argv);
+
+			free(la);
+			free(lb);
+			free(lo);
+			if ( code && code < -256 ) {
+				die("Failed to execute 'merge'. merge(1) is used as the "
+				    "file-level merge tool. Is 'merge' in your path?");
+			}
+			struct stat st;
+			int fd = open(src1, O_RDONLY);
+			if (fd < 0 || fstat(fd, &st) < 0 ||
+					index_fd(result.sha, fd, &st, 1,
+						"blob"))
+				die("Unable to add %s to database", src1);
+			close(fd);
+
+			unlink(orig);
+			unlink(src1);
+			unlink(src2);
+
+			result.clean = WEXITSTATUS(code) == 0;
+		} else {
+			if ( !(S_ISLNK(aMode) || S_ISLNK(bMode)) )
+				die("cannot merge modes?");
+
+			memcpy(result.sha, aSha, 20);
+
+			if ( memcmp(aSha, bSha, 20) != 0 )
+				result.clean = 0;
+		}
+	}
+
+	return result;
+}
+
+static void conflict_rename_rename(struct rename *ren1,
+				   const char *branch1,
+				   struct rename *ren2,
+				   const char *branch2)
+{
+	char *del[2];
+	int delp = 0;
+	const char *ren1_dst = ren1->pair->two->path;
+	const char *ren2_dst = ren2->pair->two->path;
+	const char *dstName1 = ren1_dst;
+	const char *dstName2 = ren2_dst;
+	if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
+		dstName1 = del[delp++] = unique_path(ren1_dst, branch1);
+		output("%s is a directory in %s adding as %s instead",
+		       ren1_dst, branch2, dstName1);
+		remove_file(0, ren1_dst);
+	}
+	if (path_list_has_path(&currentDirectorySet, ren2_dst)) {
+		dstName2 = del[delp++] = unique_path(ren2_dst, branch2);
+		output("%s is a directory in %s adding as %s instead",
+		       ren2_dst, branch1, dstName2);
+		remove_file(0, ren2_dst);
+	}
+	update_stages(dstName1,
+		      NULL, 0,
+		      ren1->pair->two->sha1, ren1->pair->two->mode,
+		      NULL, 0,
+		      1 /* clear */);
+	update_stages(dstName2,
+		      NULL, 0,
+		      NULL, 0,
+		      ren2->pair->two->sha1, ren2->pair->two->mode,
+		      1 /* clear */);
+	while ( delp-- )
+		free(del[delp]);
+}
+
+static void conflict_rename_dir(struct rename *ren1,
+				const char *branch1)
+{
+	char *newPath = unique_path(ren1->pair->two->path, branch1);
+	output("Renaming %s to %s instead", ren1->pair->one->path, newPath);
+	remove_file(0, ren1->pair->two->path);
+	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, newPath);
+	free(newPath);
+}
+
+static void conflict_rename_rename_2(struct rename *ren1,
+				     const char *branch1,
+				     struct rename *ren2,
+				     const char *branch2)
+{
+	char *newPath1 = unique_path(ren1->pair->two->path, branch1);
+	char *newPath2 = unique_path(ren2->pair->two->path, branch2);
+	output("Renaming %s to %s and %s to %s instead",
+	       ren1->pair->one->path, newPath1,
+	       ren2->pair->one->path, newPath2);
+	remove_file(0, ren1->pair->two->path);
+	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, newPath1);
+	update_file(0, ren2->pair->two->sha1, ren2->pair->two->mode, newPath2);
+	free(newPath2);
+	free(newPath1);
+}
+
+/* General TODO: get rid of all the debug messages */
+static int process_renames(struct path_list *renamesA,
+			   struct path_list *renamesB,
+			   const char *branchNameA,
+			   const char *branchNameB)
+{
+	int cleanMerge = 1, i;
+	struct path_list srcNames = {NULL, 0, 0, 0}, byDstA = {NULL, 0, 0, 0}, byDstB = {NULL, 0, 0, 0};
+	const struct rename *sre;
+
+	/*
+	 * TODO: think about a saner way to do this.
+	 * Since both renamesA and renamesB are sorted, it should
+	 * be much more efficient to traverse both simultaneously,
+	 * only byDstA and byDstB should be needed.
+	 */
+	debug("processRenames...\n");
+	for (i = 0; i < renamesA->nr; i++) {
+		sre = renamesA->items[i].util;
+		path_list_insert(sre->pair->one->path, &srcNames);
+		path_list_insert(sre->pair->two->path, &byDstA)->util
+			= sre->dst_entry;
+	}
+	for (i = 0; i < renamesB->nr; i++) {
+		sre = renamesB->items[i].util;
+		path_list_insert(sre->pair->one->path, &srcNames);
+		path_list_insert(sre->pair->two->path, &byDstB)->util
+			= sre->dst_entry;
+	}
+
+	for (i = 0; i < srcNames.nr; i++) {
+		char *src = srcNames.items[i].path;
+		struct path_list *renames1, *renames2, *renames2Dst;
+		struct rename *ren1, *ren2;
+		const char *branchName1, *branchName2;
+		ren1 = find_rename_bysrc(renamesA, src);
+		ren2 = find_rename_bysrc(renamesB, src);
+		/* TODO: refactor, so that 1/2 are not needed */
+		if ( ren1 ) {
+			renames1 = renamesA;
+			renames2 = renamesB;
+			renames2Dst = &byDstB;
+			branchName1 = branchNameA;
+			branchName2 = branchNameB;
+		} else {
+			renames1 = renamesB;
+			renames2 = renamesA;
+			renames2Dst = &byDstA;
+			branchName1 = branchNameB;
+			branchName2 = branchNameA;
+			struct rename *tmp = ren2;
+			ren2 = ren1;
+			ren1 = tmp;
+		}
+
+		ren1->dst_entry->processed = 1;
+		ren1->src_entry->processed = 1;
+
+		if ( ren1->processed )
+			continue;
+		ren1->processed = 1;
+
+		const char *ren1_src = ren1->pair->one->path;
+		const char *ren1_dst = ren1->pair->two->path;
+
+		if ( ren2 ) {
+			const char *ren2_src = ren2->pair->one->path;
+			const char *ren2_dst = ren2->pair->two->path;
+			/* Renamed in 1 and renamed in 2 */
+			if (strcmp(ren1_src, ren2_src) != 0)
+				die("ren1.src != ren2.src");
+			ren2->dst_entry->processed = 1;
+			ren2->processed = 1;
+			if (strcmp(ren1_dst, ren2_dst) != 0) {
+				cleanMerge = 0;
+				output("CONFLICT (rename/rename): "
+				       "Rename %s->%s in branch %s "
+				       "rename %s->%s in %s",
+				       src, ren1_dst, branchName1,
+				       src, ren2_dst, branchName2);
+				conflict_rename_rename(ren1, branchName1, ren2, branchName2);
+			} else {
+				remove_file(1, ren1_src);
+				struct merge_file_info mfi;
+				mfi = merge_file(ren1_src,
+						 ren1->pair->one->sha1,
+						 ren1->pair->one->mode,
+						 ren1_dst,
+						 ren1->pair->two->sha1,
+						 ren1->pair->two->mode,
+						 ren2_dst,
+						 ren2->pair->two->sha1,
+						 ren2->pair->two->mode,
+						 branchName1,
+						 branchName2);
+				if ( mfi.merge || !mfi.clean )
+					output("Renaming %s->%s", src, ren1_dst);
+
+				if ( mfi.merge )
+					output("Auto-merging %s", ren1_dst);
+
+				if ( !mfi.clean ) {
+					output("CONFLICT (content): merge conflict in %s",
+					       ren1_dst);
+					cleanMerge = 0;
+
+					if ( !index_only )
+						update_stages(ren1_dst,
+							      ren1->pair->one->sha1,
+							      ren1->pair->one->mode,
+							      ren1->pair->two->sha1,
+							      ren1->pair->two->mode,
+							      ren2->pair->two->sha1,
+							      ren2->pair->two->mode,
+							      1 /* clear */);
+				}
+				update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
+			}
+		} else {
+			/* Renamed in 1, maybe changed in 2 */
+			remove_file(1, ren1_src);
+
+			unsigned char srcShaOtherBranch[20], dstShaOtherBranch[20];
+			unsigned srcModeOtherBranch, dstModeOtherBranch;
+
+			int stage = renamesA == renames1 ? 3: 2;
+
+			memcpy(srcShaOtherBranch, ren1->src_entry->stages[stage].sha, 20);
+			srcModeOtherBranch = ren1->src_entry->stages[stage].mode;
+
+			memcpy(dstShaOtherBranch, ren1->dst_entry->stages[stage].sha, 20);
+			dstModeOtherBranch = ren1->dst_entry->stages[stage].mode;
+
+			int tryMerge = 0;
+			char *newPath;
+
+			if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
+				cleanMerge = 0;
+				output("CONFLICT (rename/directory): Rename %s->%s in %s "
+				       " directory %s added in %s",
+				       ren1_src, ren1_dst, branchName1,
+				       ren1_dst, branchName2);
+				conflict_rename_dir(ren1, branchName1);
+			} else if ( memcmp(srcShaOtherBranch, null_sha1, 20) == 0 ) {
+				cleanMerge = 0;
+				output("CONFLICT (rename/delete): Rename %s->%s in %s "
+				       "and deleted in %s",
+				       ren1_src, ren1_dst, branchName1,
+				       branchName2);
+				update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
+			} else if ( memcmp(dstShaOtherBranch, null_sha1, 20) != 0 ) {
+				cleanMerge = 0;
+				tryMerge = 1;
+				output("CONFLICT (rename/add): Rename %s->%s in %s. "
+				       "%s added in %s",
+				       ren1_src, ren1_dst, branchName1,
+				       ren1_dst, branchName2);
+				newPath = unique_path(ren1_dst, branchName2);
+				output("Adding as %s instead", newPath);
+				update_file(0, dstShaOtherBranch, dstModeOtherBranch, newPath);
+			} else if ( (ren2 = find_rename_bysrc(renames2Dst, ren1_dst)) ) {
+				cleanMerge = 0;
+				ren2->processed = 1;
+				output("CONFLICT (rename/rename): Rename %s->%s in %s. "
+				       "Rename %s->%s in %s",
+				       ren1_src, ren1_dst, branchName1,
+				       ren2->pair->one->path, ren2->pair->two->path, branchName2);
+				conflict_rename_rename_2(ren1, branchName1, ren2, branchName2);
+			} else
+				tryMerge = 1;
+
+			if ( tryMerge ) {
+				const char *oname = ren1_src;
+				const char *aname = ren1_dst;
+				const char *bname = ren1_src;
+				unsigned char osha[20], asha[20], bsha[20];
+				unsigned omode = ren1->pair->one->mode;
+				unsigned amode = ren1->pair->two->mode;
+				unsigned bmode = srcModeOtherBranch;
+				memcpy(osha, ren1->pair->one->sha1, 20);
+				memcpy(asha, ren1->pair->two->sha1, 20);
+				memcpy(bsha, srcShaOtherBranch, 20);
+				const char *aBranch = branchName1;
+				const char *bBranch = branchName2;
+
+				if ( renamesA != renames1 ) {
+					memswp(&aname, &bname, sizeof(aname));
+					memswp(asha, bsha, 20);
+					memswp(&aBranch, &bBranch, sizeof(aBranch));
+				}
+				struct merge_file_info mfi;
+				mfi = merge_file(oname, osha, omode,
+						 aname, asha, amode,
+						 bname, bsha, bmode,
+						 aBranch, bBranch);
+
+				if ( mfi.merge || !mfi.clean )
+					output("Renaming %s => %s", ren1_src, ren1_dst);
+				if ( mfi.merge )
+					output("Auto-merging %s", ren1_dst);
+				if ( !mfi.clean ) {
+					output("CONFLICT (rename/modify): Merge conflict in %s",
+					       ren1_dst);
+					cleanMerge = 0;
+
+					if ( !index_only )
+						update_stages(ren1_dst,
+							      osha, omode,
+							      asha, amode,
+							      bsha, bmode,
+							      1 /* clear */);
+				}
+				update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
+			}
+		}
+	}
+	path_list_clear(&srcNames, 0);
+	debug("  processRenames done\n");
+
+	if (cache_dirty)
+		flush_cache();
+	return cleanMerge;
+}
+
+static unsigned char *has_sha(const unsigned char *sha)
+{
+	return memcmp(sha, null_sha1, 20) == 0 ? NULL: (unsigned char *)sha;
+}
+
+/* Per entry merge function */
+static int process_entry(const char *path, struct stage_data *entry,
+			 const char *branch1Name,
+			 const char *branch2Name)
+{
+	/*
+	printf("processing entry, clean cache: %s\n", index_only ? "yes": "no");
+	print_index_entry("\tpath: ", entry);
+	*/
+	int cleanMerge = 1;
+	unsigned char *oSha = has_sha(entry->stages[1].sha);
+	unsigned char *aSha = has_sha(entry->stages[2].sha);
+	unsigned char *bSha = has_sha(entry->stages[3].sha);
+	unsigned oMode = entry->stages[1].mode;
+	unsigned aMode = entry->stages[2].mode;
+	unsigned bMode = entry->stages[3].mode;
+
+	if ( oSha && (!aSha || !bSha) ) {
+		/* Case A: Deleted in one */
+		if ( (!aSha && !bSha) ||
+		     (sha_eq(aSha, oSha) && !bSha) ||
+		     (!aSha && sha_eq(bSha, oSha)) ) {
+			/* Deleted in both or deleted in one and
+			 * unchanged in the other */
+			if ( aSha )
+				output("Removing %s", path);
+			remove_file(1, path);
+		} else {
+			/* Deleted in one and changed in the other */
+			cleanMerge = 0;
+			if ( !aSha ) {
+				output("CONFLICT (delete/modify): %s deleted in %s "
+				       "and modified in %s. Version %s of %s left in tree.",
+				       path, branch1Name,
+				       branch2Name, branch2Name, path);
+				update_file(0, bSha, bMode, path);
+			} else {
+				output("CONFLICT (delete/modify): %s deleted in %s "
+				       "and modified in %s. Version %s of %s left in tree.",
+				       path, branch2Name,
+				       branch1Name, branch1Name, path);
+				update_file(0, aSha, aMode, path);
+			}
+		}
+
+	} else if ( (!oSha && aSha && !bSha) ||
+		    (!oSha && !aSha && bSha) ) {
+		/* Case B: Added in one. */
+		const char *addBranch;
+		const char *otherBranch;
+		unsigned mode;
+		const unsigned char *sha;
+		const char *conf;
+
+		if ( aSha ) {
+			addBranch = branch1Name;
+			otherBranch = branch2Name;
+			mode = aMode;
+			sha = aSha;
+			conf = "file/directory";
+		} else {
+			addBranch = branch2Name;
+			otherBranch = branch1Name;
+			mode = bMode;
+			sha = bSha;
+			conf = "directory/file";
+		}
+		if ( path_list_has_path(&currentDirectorySet, path) ) {
+			cleanMerge = 0;
+			const char *newPath = unique_path(path, addBranch);
+			output("CONFLICT (%s): There is a directory with name %s in %s. "
+			       "Adding %s as %s",
+			       conf, path, otherBranch, path, newPath);
+			remove_file(0, path);
+			update_file(0, sha, mode, newPath);
+		} else {
+			output("Adding %s", path);
+			update_file(1, sha, mode, path);
+		}
+	} else if ( !oSha && aSha && bSha ) {
+		/* Case C: Added in both (check for same permissions). */
+		if ( sha_eq(aSha, bSha) ) {
+			if ( aMode != bMode ) {
+				cleanMerge = 0;
+				output("CONFLICT: File %s added identically in both branches, "
+				       "but permissions conflict %06o->%06o",
+				       path, aMode, bMode);
+				output("CONFLICT: adding with permission: %06o", aMode);
+				update_file(0, aSha, aMode, path);
+			} else {
+				/* This case is handled by git-read-tree */
+				assert(0 && "This case must be handled by git-read-tree");
+			}
+		} else {
+			cleanMerge = 0;
+			const char *newPath1 = unique_path(path, branch1Name);
+			const char *newPath2 = unique_path(path, branch2Name);
+			output("CONFLICT (add/add): File %s added non-identically "
+			       "in both branches. Adding as %s and %s instead.",
+			       path, newPath1, newPath2);
+			remove_file(0, path);
+			update_file(0, aSha, aMode, newPath1);
+			update_file(0, bSha, bMode, newPath2);
+		}
+
+	} else if ( oSha && aSha && bSha ) {
+		/* case D: Modified in both, but differently. */
+		output("Auto-merging %s", path);
+		struct merge_file_info mfi;
+		mfi = merge_file(path, oSha, oMode,
+				 path, aSha, aMode,
+				 path, bSha, bMode,
+				 branch1Name, branch2Name);
+
+		if ( mfi.clean )
+			update_file(1, mfi.sha, mfi.mode, path);
+		else {
+			cleanMerge = 0;
+			output("CONFLICT (content): Merge conflict in %s", path);
+
+			if ( index_only )
+				update_file(0, mfi.sha, mfi.mode, path);
+			else
+				update_file_flags(mfi.sha, mfi.mode, path,
+					      0 /* updateCache */, 1 /* updateWd */);
+		}
+	} else
+		die("Fatal merge failure, shouldn't happen.");
+
+	if (cache_dirty)
+		flush_cache();
+
+	return cleanMerge;
+}
+
+static struct merge_tree_result merge_trees(struct tree *head,
+					    struct tree *merge,
+					    struct tree *common,
+					    const char *branch1Name,
+					    const char *branch2Name)
+{
+	int code;
+	struct merge_tree_result result = { NULL, 0 };
+	if ( !memcmp(common->object.sha1, merge->object.sha1, 20) ) {
+		output("Already uptodate!");
+		result.tree = head;
+		result.clean = 1;
+		return result;
+	}
+
+	debug("merge_trees ...\n");
+	code = git_merge_trees(index_only ? "-i": "-u", common, head, merge);
+
+	if ( code != 0 )
+		die("merging of trees %s and %s failed",
+		    sha1_to_hex(head->object.sha1),
+		    sha1_to_hex(merge->object.sha1));
+
+	result.tree = git_write_tree();
+
+	if ( !result.tree ) {
+		path_list_clear(&currentFileSet, 1);
+		path_list_clear(&currentDirectorySet, 1);
+		get_files_dirs(head, &currentFileSet, &currentDirectorySet);
+		get_files_dirs(merge, &currentFileSet, &currentDirectorySet);
+
+		struct path_list *entries = get_unmerged();
+		struct path_list *re_head, *re_merge;
+		re_head  = get_renames(head, common, head, merge, entries);
+		re_merge = get_renames(merge, common, head, merge, entries);
+		result.clean = process_renames(re_head, re_merge,
+					       branch1Name, branch2Name);
+		debug("\tprocessing entries...\n");
+		int i;
+		for (i = 0; i < entries->nr; i++) {
+			const char *path = entries->items[i].path;
+			struct stage_data *e = entries->items[i].util;
+			if (e->processed)
+				continue;
+			if (!process_entry(path, e, branch1Name, branch2Name))
+				result.clean = 0;
+		}
+
+		free_rename_entries(&re_merge);
+		free_rename_entries(&re_head);
+		free_index_entries(&entries);
+
+		if (result.clean || index_only)
+			result.tree = git_write_tree();
+		else
+			result.tree = NULL;
+		debug("\t  processing entries done\n");
+	} else {
+		result.clean = 1;
+		printf("merging of trees %s and %s resulted in %s\n",
+		       sha1_to_hex(head->object.sha1),
+		       sha1_to_hex(merge->object.sha1),
+		       sha1_to_hex(result.tree->object.sha1));
+	}
+
+	debug("  merge_trees done\n");
+	return result;
+}
+
+/*
+ * Merge the commits h1 and h2, return the resulting virtual
+ * commit object and a flag indicating the cleaness of the merge.
+ */
+static
+struct merge_result merge(struct commit *h1,
+			  struct commit *h2,
+			  const char *branch1Name,
+			  const char *branch2Name,
+			  int callDepth /* =0 */,
+			  struct commit *ancestor /* =None */)
+{
+	struct merge_result result = { NULL, 0 };
+	const char *msg;
+	int msglen;
+	struct commit_list *ca = NULL, *iter;
+	struct commit *mergedCA;
+	struct merge_tree_result mtr;
+
+	output("Merging:");
+	msg = commit_title(h1, &msglen);
+	/* TODO: refactor. we always show the sha1 with the title */
+	output("%s %.*s", commit_hex_sha1(h1), msglen, msg);
+	msg = commit_title(h2, &msglen);
+	output("%s %.*s", commit_hex_sha1(h2), msglen, msg);
+
+	if ( ancestor )
+		commit_list_insert(ancestor, &ca);
+	else
+		ca = get_merge_bases(h1, h2, 1);
+
+	output("found %u common ancestor(s):", commit_list_count(ca));
+	for (iter = ca; iter; iter = iter->next) {
+		msg = commit_title(iter->item, &msglen);
+		output("%s %.*s", commit_hex_sha1(iter->item), msglen, msg);
+	}
+
+	mergedCA = pop_commit(&ca);
+
+	/* TODO: what happens when merge with virtual commits fails? */
+	for (iter = ca; iter; iter = iter->next) {
+		output_indent = callDepth + 1;
+		result = merge(mergedCA, iter->item,
+			       "Temporary merge branch 1",
+			       "Temporary merge branch 2",
+			       callDepth + 1,
+			       NULL);
+		mergedCA = result.commit;
+		output_indent = callDepth;
+
+		if ( !mergedCA )
+			die("merge returned no commit");
+	}
+
+	if ( callDepth == 0 ) {
+		setup_index(0);
+		index_only = 0;
+	} else {
+		setup_index(1);
+		git_read_tree(h1->tree);
+		index_only = 1;
+	}
+
+	mtr = merge_trees(h1->tree, h2->tree,
+			  mergedCA->tree, branch1Name, branch2Name);
+
+	if ( !ancestor && (mtr.clean || index_only) ) {
+		result.commit = make_virtual_commit(mtr.tree, "merged tree");
+		commit_list_insert(h1, &result.commit->parents);
+		commit_list_insert(h2, &result.commit->parents->next);
+	} else
+		result.commit = NULL;
+
+	result.clean = mtr.clean;
+	return result;
+}
+
+static struct commit *get_ref(const char *ref)
+{
+	unsigned char sha1[20];
+	struct object *object;
+	
+	if (get_sha1(ref, sha1))
+		die("Could not resolve ref '%s'", ref);
+	object = deref_tag(parse_object(sha1), ref, strlen(ref));
+	if (object->type != TYPE_COMMIT)
+		return NULL;
+	if (parse_commit((struct commit *)object))
+		die("Could not parse commit '%s'", sha1_to_hex(object->sha1));
+	return (struct commit *)object;
+}
+
+int main(int argc, char *argv[])
+{
+	static const char *bases[2];
+	static unsigned bases_count = 0;
+
+	original_index_file = getenv("GIT_INDEX_FILE");
+
+	if (!original_index_file)
+		original_index_file = strdup(git_path("index"));
+
+	temporary_index_file = strdup(git_path("mrg-rcrsv-tmp-idx"));
+
+	if (argc < 4)
+		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
+
+	int i;
+	for (i = 1; i < argc; ++i) {
+		if (!strcmp(argv[i], "--"))
+			break;
+		if (bases_count < sizeof(bases)/sizeof(*bases))
+			bases[bases_count++] = argv[i];
+	}
+	if (argc - i != 3) /* "--" "<head>" "<remote>" */
+		die("Not handling anything other than two heads merge.");
+
+	const char *branch1, *branch2;
+
+	branch1 = argv[++i];
+	branch2 = argv[++i];
+	printf("Merging %s with %s\n", branch1, branch2);
+
+	struct merge_result result;
+	struct commit *h1 = get_ref(branch1);
+	struct commit *h2 = get_ref(branch2);
+
+	if (bases_count == 1) {
+		struct commit *ancestor = get_ref(bases[0]);
+		result = merge(h1, h2, branch1, branch2, 0, ancestor);
+	} else
+		result = merge(h1, h2, branch1, branch2, 0, NULL);
+
+	if (cache_dirty)
+		flush_cache();
+
+	return result.clean ? 0: 1;
+}
+
+/*
+vim: sw=8 noet
+*/
diff --git a/path-list.c b/path-list.c
new file mode 100644
index 0000000..f15a10d
--- /dev/null
+++ b/path-list.c
@@ -0,0 +1,105 @@
+#include <stdio.h>
+#include "cache.h"
+#include "path-list.h"
+
+/* if there is no exact match, point to the index where the entry could be
+ * inserted */
+static int get_entry_index(const struct path_list *list, const char *path,
+		int *exact_match)
+{
+	int left = -1, right = list->nr;
+
+	while (left + 1 < right) {
+		int middle = (left + right) / 2;
+		int compare = strcmp(path, list->items[middle].path);
+		if (compare < 0)
+			right = middle;
+		else if (compare > 0)
+			left = middle;
+		else {
+			*exact_match = 1;
+			return middle;
+		}
+	}
+
+	*exact_match = 0;
+	return right;
+}
+
+/* returns -1-index if already exists */
+static int add_entry(struct path_list *list, const char *path)
+{
+	int exact_match;
+	int index = get_entry_index(list, path, &exact_match);
+
+	if (exact_match)
+		return -1 - index;
+
+	if (list->nr + 1 >= list->alloc) {
+		list->alloc += 32;
+		list->items = xrealloc(list->items, list->alloc
+				* sizeof(struct path_list_item));
+	}
+	if (index < list->nr)
+		memmove(list->items + index + 1, list->items + index,
+				(list->nr - index)
+				* sizeof(struct path_list_item));
+	list->items[index].path = list->strdup_paths ?
+		strdup(path) : (char *)path;
+	list->items[index].util = NULL;
+	list->nr++;
+
+	return index;
+}
+
+struct path_list_item *path_list_insert(const char *path, struct path_list *list)
+{
+	int index = add_entry(list, path);
+
+	if (index < 0)
+		index = 1 - index;
+
+	return list->items + index;
+}
+
+int path_list_has_path(const struct path_list *list, const char *path)
+{
+	int exact_match;
+	get_entry_index(list, path, &exact_match);
+	return exact_match;
+}
+
+struct path_list_item *path_list_lookup(const char *path, struct path_list *list)
+{
+	int exact_match, i = get_entry_index(list, path, &exact_match);
+	if (!exact_match)
+		return NULL;
+	return list->items + i;
+}
+
+void path_list_clear(struct path_list *list, int free_items)
+{
+	if (list->items) {
+		int i;
+		if (free_items)
+			for (i = 0; i < list->nr; i++) {
+				if (list->strdup_paths)
+					free(list->items[i].path);
+				if (list->items[i].util)
+					free(list->items[i].util);
+			}
+		free(list->items);
+	}
+	list->items = NULL;
+	list->nr = list->alloc = 0;
+}
+
+void print_path_list(const char *text, const struct path_list *p)
+{
+	int i;
+	if ( text )
+		printf("%s\n", text);
+	for (i = 0; i < p->nr; i++)
+		printf("%s:%p\n", p->items[i].path, p->items[i].util);
+}
+
diff --git a/path-list.h b/path-list.h
new file mode 100644
index 0000000..d6401ea
--- /dev/null
+++ b/path-list.h
@@ -0,0 +1,22 @@
+#ifndef _PATH_LIST_H_
+#define _PATH_LIST_H_
+
+struct path_list_item {
+	char *path;
+	void *util;
+};
+struct path_list
+{
+	struct path_list_item *items;
+	unsigned int nr, alloc;
+	unsigned int strdup_paths:1;
+};
+
+void print_path_list(const char *text, const struct path_list *p);
+
+int path_list_has_path(const struct path_list *list, const char *path);
+void path_list_clear(struct path_list *list, int free_items);
+struct path_list_item *path_list_insert(const char *path, struct path_list *list);
+struct path_list_item *path_list_lookup(const char *path, struct path_list *list);
+
+#endif /* _PATH_LIST_H_ */
diff --git a/read-cache.c b/read-cache.c
index 3c32aae..f6e1b70 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -24,6 +24,11 @@ unsigned int active_nr = 0, active_alloc
 
 struct cache_tree *active_cache_tree = NULL;
 
+int cache_errno = 0;
+
+static void *cache_mmap = NULL;
+static size_t cache_mmap_size = 0;
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -577,22 +582,6 @@ int add_cache_entry(struct cache_entry *
 	return 0;
 }
 
-/* Three functions to allow overloaded pointer return; see linux/err.h */
-static inline void *ERR_PTR(long error)
-{
-	return (void *) error;
-}
-
-static inline long PTR_ERR(const void *ptr)
-{
-	return (long) ptr;
-}
-
-static inline long IS_ERR(const void *ptr)
-{
-	return (unsigned long)ptr > (unsigned long)-1000L;
-}
-
 /*
  * "refresh" does not calculate a new sha1 file or bring the
  * cache up-to-date for mode/content changes. But what it
@@ -604,14 +593,16 @@ static inline long IS_ERR(const void *pt
  * For example, you'd want to do this after doing a "git-read-tree",
  * to link up the stat cache details with the proper files.
  */
-static struct cache_entry *refresh_entry(struct cache_entry *ce, int really)
+struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
 {
 	struct stat st;
 	struct cache_entry *updated;
 	int changed, size;
 
-	if (lstat(ce->name, &st) < 0)
-		return ERR_PTR(-errno);
+	if (lstat(ce->name, &st) < 0) {
+		cache_errno = errno;
+		return NULL;
+	}
 
 	changed = ce_match_stat(ce, &st, really);
 	if (!changed) {
@@ -619,11 +610,13 @@ static struct cache_entry *refresh_entry
 		    !(ce->ce_flags & htons(CE_VALID)))
 			; /* mark this one VALID again */
 		else
-			return NULL;
+			return ce;
 	}
 
-	if (ce_modified(ce, &st, really))
-		return ERR_PTR(-EINVAL);
+	if (ce_modified(ce, &st, really)) {
+		cache_errno = EINVAL;
+		return NULL;
+	}
 
 	size = ce_size(ce);
 	updated = xmalloc(size);
@@ -666,13 +659,13 @@ int refresh_cache(unsigned int flags)
 			continue;
 		}
 
-		new = refresh_entry(ce, really);
-		if (!new)
+		new = refresh_cache_entry(ce, really);
+		if (new == ce)
 			continue;
-		if (IS_ERR(new)) {
-			if (not_new && PTR_ERR(new) == -ENOENT)
+		if (!new) {
+			if (not_new && cache_errno == ENOENT)
 				continue;
-			if (really && PTR_ERR(new) == -EINVAL) {
+			if (really && cache_errno == EINVAL) {
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
@@ -729,39 +722,43 @@ static int read_index_extension(const ch
 
 int read_cache(void)
 {
+	return read_cache_from(get_index_file());
+}
+
+/* remember to discard_cache() before reading a different cache! */
+int read_cache_from(const char *path)
+{
 	int fd, i;
 	struct stat st;
-	unsigned long size, offset;
-	void *map;
+	unsigned long offset;
 	struct cache_header *hdr;
 
 	errno = EBUSY;
-	if (active_cache)
+	if (cache_mmap)
 		return active_nr;
 
 	errno = ENOENT;
 	index_file_timestamp = 0;
-	fd = open(get_index_file(), O_RDONLY);
+	fd = open(path, O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
 		die("index file open failed (%s)", strerror(errno));
 	}
 
-	size = 0; // avoid gcc warning
-	map = MAP_FAILED;
+	cache_mmap = MAP_FAILED;
 	if (!fstat(fd, &st)) {
-		size = st.st_size;
+		cache_mmap_size = st.st_size;
 		errno = EINVAL;
-		if (size >= sizeof(struct cache_header) + 20)
-			map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		if (cache_mmap_size >= sizeof(struct cache_header) + 20)
+			cache_mmap = mmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	}
 	close(fd);
-	if (map == MAP_FAILED)
+	if (cache_mmap == MAP_FAILED)
 		die("index file mmap failed (%s)", strerror(errno));
 
-	hdr = map;
-	if (verify_hdr(hdr, size) < 0)
+	hdr = cache_mmap;
+	if (verify_hdr(hdr, cache_mmap_size) < 0)
 		goto unmap;
 
 	active_nr = ntohl(hdr->hdr_entries);
@@ -770,12 +767,12 @@ int read_cache(void)
 
 	offset = sizeof(*hdr);
 	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = (struct cache_entry *) ((char *) map + offset);
+		struct cache_entry *ce = (struct cache_entry *) ((char *) cache_mmap + offset);
 		offset = offset + ce_size(ce);
 		active_cache[i] = ce;
 	}
 	index_file_timestamp = st.st_mtime;
-	while (offset <= size - 20 - 8) {
+	while (offset <= cache_mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
 		 * sections, each of which is prefixed with
@@ -783,10 +780,10 @@ int read_cache(void)
 		 * in 4-byte network byte order.
 		 */
 		unsigned long extsize;
-		memcpy(&extsize, (char *) map + offset + 4, 4);
+		memcpy(&extsize, (char *) cache_mmap + offset + 4, 4);
 		extsize = ntohl(extsize);
-		if (read_index_extension(((const char *) map) + offset,
-					 (char *) map + offset + 8,
+		if (read_index_extension(((const char *) cache_mmap) + offset,
+					 (char *) cache_mmap + offset + 8,
 					 extsize) < 0)
 			goto unmap;
 		offset += 8;
@@ -795,11 +792,28 @@ int read_cache(void)
 	return active_nr;
 
 unmap:
-	munmap(map, size);
+	munmap(cache_mmap, cache_mmap_size);
 	errno = EINVAL;
 	die("index file corrupt");
 }
 
+int discard_cache()
+{
+	int ret;
+	
+	if (cache_mmap == NULL)
+		return 0;
+	ret = munmap(cache_mmap, cache_mmap_size);
+	cache_mmap = NULL;
+	cache_mmap_size = 0;
+	active_nr = active_cache_changed = 0;
+	index_file_timestamp = 0;
+	cache_tree_free(&active_cache_tree);
+	
+	/* no need to throw away allocated active_cache */
+	return ret;
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index d34c6cf..b70e177 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -51,7 +51,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'reference merge' '
-	git merge -s recursive "reference merge" HEAD master
+	git merge -s recur "reference merge" HEAD master
 '
 
 test_expect_success rebase '

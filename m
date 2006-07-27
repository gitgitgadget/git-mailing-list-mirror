From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cumulative update of merge-recursive in C
Date: Thu, 27 Jul 2006 13:17:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271315440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 13:17:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G63sB-00059x-V8
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 13:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWG0LRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 07:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWG0LRO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 07:17:14 -0400
Received: from mail.gmx.net ([213.165.64.21]:39556 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751269AbWG0LRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 07:17:09 -0400
Received: (qmail invoked by alias); 27 Jul 2006 11:17:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 27 Jul 2006 13:17:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24278>


This contains mainly three sorts of fixes:

- get rid of small wrapper functions
- reuse the diff_filespec structure when sha1, mode & path are needed
- Junio's pedantic updates

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Sorry for the big patch; it seemed to be tiny each
	time I committed.

 merge-recursive.c |  894 ++++++++++++++++++++++-------------------------------
 1 files changed, 366 insertions(+), 528 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8d30519..85bb47a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -25,9 +25,9 @@ #include "path-list.h"
 /*#define DEBUG*/
 
 #ifdef DEBUG
-#define debug(args, ...) fprintf(stderr, args, ## __VA_ARGS__)
+#define debug(...) fprintf(stderr, __VA_ARGS__)
 #else
-#define debug(args, ...)
+#define debug(...) do { ; /* nothing */ } while (0)
 #endif
 
 #ifdef DEBUG
@@ -61,13 +61,14 @@ static void show_ce_entry(const char *ta
 	fputc('\n', stderr);
 }
 
-static void ls_files() {
+static void ls_files(void) {
 	int i;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		show_ce_entry("", ce);
 	}
 	fprintf(stderr, "---\n");
+	if (0) ls_files(); /* avoid "unused" warning */
 }
 #endif
 
@@ -76,41 +77,6 @@ #endif
  * - (const char *)commit->util set to the name, and
  * - *(int *)commit->object.sha1 set to the virtual id.
  */
-static const char *commit_title(struct commit *commit, int *len)
-{
-	const char *s = "(null commit)";
-	*len = strlen(s);
-
-	if ( commit->util ) {
-		s = commit->util;
-		*len = strlen(s);
-	} else {
-		if ( parse_commit(commit) != 0 ) {
-			s = "(bad commit)";
-			*len = strlen(s);
-		} else {
-			s = commit->buffer;
-			char prev = '\0';
-			while ( *s ) {
-				if ( '\n' == prev && '\n' == *s ) {
-					++s;
-					break;
-				}
-				prev = *s++;
-			}
-			*len = 0;
-			while ( s[*len] && '\n' != s[*len] )
-				++(*len);
-		}
-	}
-	return s;
-}
-
-static const char *commit_hex_sha1(const struct commit *commit)
-{
-	return commit->util ? "virtual" : commit ?
-		sha1_to_hex(commit->object.sha1) : "undefined";
-}
 
 static unsigned commit_list_count(const struct commit_list *l)
 {
@@ -136,41 +102,11 @@ static struct commit *make_virtual_commi
  */
 static int sha_eq(const unsigned char *a, const unsigned char *b)
 {
-	if ( !a && !b )
+	if (!a && !b)
 		return 2;
 	return a && b && memcmp(a, b, 20) == 0;
 }
 
-static void memswp(void *p1, void *p2, unsigned n)
-{
-	unsigned char *a = p1, *b = p2;
-	while ( n-- ) {
-		*a ^= *b;
-		*b ^= *a;
-		*a ^= *b;
-		++a;
-		++b;
-	}
-}
-
-/*
- * TODO: we should convert the merge_result users to
- * 	int blabla(..., struct commit **result)
- * like everywhere else in git.
- * Same goes for merge_tree_result and merge_file_info.
- */
-struct merge_result
-{
-	struct commit *commit;
-	unsigned clean:1;
-};
-
-struct merge_tree_result
-{
-	struct tree *tree;
-	unsigned clean:1;
-};
-
 /*
  * TODO: check if we can just reuse the active_cache structure: it is already
  * sorted (by name, stage).
@@ -195,7 +131,7 @@ static void output(const char *fmt, ...)
 {
 	va_list args;
 	int i;
-	for ( i = output_indent; i--; )
+	for (i = output_indent; i--;)
 		fputs("  ", stdout);
 	va_start(args, fmt);
 	vfprintf(stdout, fmt, args);
@@ -203,11 +139,37 @@ static void output(const char *fmt, ...)
 	fputc('\n', stdout);
 }
 
+static void output_commit_title(struct commit *commit)
+{
+	int i;
+	for (i = output_indent; i--;)
+		fputs("  ", stdout);
+	if (commit->util)
+		printf("virtual %s\n", (char *)commit->util);
+	else {
+		printf("%s ", sha1_to_hex(commit->object.sha1));
+		if (parse_commit(commit) != 0)
+			printf("(bad commit)\n");
+		else {
+			const char *s;
+			int len;
+			for (s = commit->buffer; *s; s++)
+				if (*s == '\n' && s[1] == '\n') {
+					s += 2;
+					break;
+				}
+			for (len = 0; s[len] && '\n' != s[len]; len++)
+				; /* do nothing */
+			printf("%.*s\n", len, s);
+		}
+	}
+}
+
 static const char *original_index_file;
 static const char *temporary_index_file;
 static int cache_dirty = 0;
 
-static int flush_cache()
+static int flush_cache(void)
 {
 	/* flush temporary index */
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
@@ -290,11 +252,12 @@ #if 0
 		getenv("GIT_INDEX_FILE"),
 		sha1_to_hex(tree->object.sha1));
 #endif
+	int rc;
 	const char *argv[] = { "git-read-tree", NULL, NULL, };
 	if (cache_dirty)
 		die("read-tree with dirty cache");
 	argv[1] = sha1_to_hex(tree->object.sha1);
-	int rc = run_command_v(2, argv);
+	rc = run_command_v(2, argv);
 	return rc < 0 ? -1: rc;
 }
 
@@ -314,6 +277,7 @@ #if 0
 		sha1_to_hex(head->object.sha1),
 		sha1_to_hex(merge->object.sha1));
 #endif
+	int rc;
 	const char *argv[] = {
 		"git-read-tree", NULL, "-m", NULL, NULL, NULL,
 		NULL,
@@ -324,50 +288,42 @@ #endif
 	argv[3] = sha1_to_hex(common->object.sha1);
 	argv[4] = sha1_to_hex(head->object.sha1);
 	argv[5] = sha1_to_hex(merge->object.sha1);
-	int rc = run_command_v(6, argv);
+	rc = run_command_v(6, argv);
 	return rc < 0 ? -1: rc;
 }
 
 /*
  * TODO: this can be streamlined by refactoring builtin-write-tree.c
  */
-static struct tree *git_write_tree()
+static struct tree *git_write_tree(void)
 {
 #if 0
 	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
 		getenv("GIT_INDEX_FILE"));
 #endif
-	if (cache_dirty)
-		flush_cache();
-	FILE *fp = popen("git-write-tree 2>/dev/null", "r");
+	FILE *fp;
+	int rc;
 	char buf[41];
 	unsigned char sha1[20];
 	int ch;
 	unsigned i = 0;
-	while ( (ch = fgetc(fp)) != EOF )
-		if ( i < sizeof(buf)-1 && ch >= '0' && ch <= 'f' )
+	if (cache_dirty)
+		flush_cache();
+	fp = popen("git-write-tree 2>/dev/null", "r");
+	while ((ch = fgetc(fp)) != EOF)
+		if (i < sizeof(buf)-1 && ch >= '0' && ch <= 'f')
 			buf[i++] = ch;
 		else
 			break;
-	int rc = pclose(fp);
-	if ( rc == -1 || WEXITSTATUS(rc) )
+	rc = pclose(fp);
+	if (rc == -1 || WEXITSTATUS(rc))
 		return NULL;
 	buf[i] = '\0';
-	if ( get_sha1(buf, sha1) != 0 )
+	if (get_sha1(buf, sha1) != 0)
 		return NULL;
 	return lookup_tree(sha1);
 }
 
-/*
- * TODO: get rid of files_and_dirs; we do not use it except for
- * current_file_set and current_dir_set, which are global already.
- */
-static struct
-{
-	struct path_list *files;
-	struct path_list *dirs;
-} files_and_dirs;
-
 static int save_files_dirs(const unsigned char *sha1,
 		const char *base, int baselen, const char *path,
 		unsigned int mode, int stage)
@@ -379,70 +335,36 @@ static int save_files_dirs(const unsigne
 	newpath[baselen + len] = '\0';
 
 	if (S_ISDIR(mode))
-		path_list_insert(newpath, files_and_dirs.dirs);
+		path_list_insert(newpath, &currentDirectorySet);
 	else
-		path_list_insert(newpath, files_and_dirs.files);
+		path_list_insert(newpath, &currentFileSet);
 	free(newpath);
 
 	return READ_TREE_RECURSIVE;
 }
 
-static int get_files_dirs(struct tree *tree,
-			  struct path_list *files,
-			  struct path_list *dirs)
+static int get_files_dirs(struct tree *tree)
 {
 	int n;
-	files_and_dirs.files = files;
-	files_and_dirs.dirs = dirs;
 	debug("get_files_dirs ...\n");
 	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs) != 0) {
 		debug("  get_files_dirs done (0)\n");
 		return 0;
 	}
-	n = files->nr + dirs->nr;
+	n = currentFileSet.nr + currentDirectorySet.nr;
 	debug("  get_files_dirs done (%d)\n", n);
 	return n;
 }
 
 /*
- * TODO: this wrapper is so small, we can use path_list_lookup directly.
- * Same goes for index_entry_get(), free_index_entries(), find_rename_bysrc(),
- * free_rename_entries().
- */
-static struct stage_data *index_entry_find(struct path_list *ents,
-					    const char *path)
-{
-	struct path_list_item *item = path_list_lookup(path, ents);
-	if (item)
-		return item->util;
-	return NULL;
-}
-
-static struct stage_data *index_entry_get(struct path_list *ents,
-					   const char *path)
-{
-	struct path_list_item *item = path_list_lookup(path, ents);
-
-	if (item == NULL) {
-		item = path_list_insert(path, ents);
-		item->util = xcalloc(1, sizeof(struct stage_data));
-	}
-	return item->util;
-}
-
-/*
- * TODO: since the result of index_entry_from_db() is tucked into a
- * path_list anyway, this helper can do that already.
- */
-/*
  * Returns a index_entry instance which doesn't have to correspond to
  * a real cache entry in Git's index.
  */
-static struct stage_data *index_entry_from_db(const char *path,
-					       struct tree *o,
-					       struct tree *a,
-					       struct tree *b)
+static struct stage_data *insert_stage_data(const char *path,
+		struct tree *o, struct tree *a, struct tree *b,
+		struct path_list *entries)
 {
+	struct path_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
 	get_tree_entry(o->object.sha1, path,
 			e->stages[1].sha, &e->stages[1].mode);
@@ -450,24 +372,16 @@ static struct stage_data *index_entry_fr
 			e->stages[2].sha, &e->stages[2].mode);
 	get_tree_entry(b->object.sha1, path,
 			e->stages[3].sha, &e->stages[3].mode);
+	item = path_list_insert(path, entries);
+	item->util = e;
 	return e;
 }
 
-static void free_index_entries(struct path_list **ents)
-{
-	if (!*ents)
-		return;
-
-	path_list_clear(*ents, 1);
-	free(*ents);
-	*ents = NULL;
-}
-
 /*
  * Create a dictionary mapping file names to CacheEntry objects. The
  * dictionary contains one entry for every path with a non-zero stage entry.
  */
-static struct path_list *get_unmerged()
+static struct path_list *get_unmerged(void)
 {
 	struct path_list *unmerged = xcalloc(1, sizeof(struct path_list));
 	int i;
@@ -478,16 +392,22 @@ static struct path_list *get_unmerged()
 		cache_dirty++;
 	}
 	for (i = 0; i < active_nr; i++) {
+		struct path_list_item *item;
+		struct stage_data *e;
 		struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
 			continue;
 
-		struct stage_data *e = index_entry_get(unmerged, ce->name);
+		item = path_list_lookup(ce->name, unmerged);
+		if (!item) {
+			item = path_list_insert(ce->name, unmerged);
+			item->util = xcalloc(1, sizeof(struct stage_data));
+		}
+		e = item->util;
 		e->stages[ce_stage(ce)].mode = ntohl(ce->ce_mode);
 		memcpy(e->stages[ce_stage(ce)].sha, ce->sha1, 20);
 	}
 
-	debug("  get_unmerged done\n");
 	return unmerged;
 }
 
@@ -499,25 +419,6 @@ struct rename
 	unsigned processed:1;
 };
 
-static struct rename *find_rename_bysrc(struct path_list *e,
-					      const char *name)
-{
-	struct path_list_item *item = path_list_lookup(name, e);
-	if (item)
-		return item->util;
-	return NULL;
-}
-
-static void free_rename_entries(struct path_list **list)
-{
-	if (!*list)
-		return;
-
-	path_list_clear(*list, 0);
-	free(*list);
-	*list = NULL;
-}
-
 /*
  * Get information of all renames which occured between 'oTree' and
  * 'tree'. We need the three trees in the merge ('oTree', 'aTree' and
@@ -530,13 +431,16 @@ static struct path_list *get_renames(str
 					struct tree *bTree,
 					struct path_list *entries)
 {
+	int i;
+	struct path_list *renames;
+	struct diff_options opts;
 #ifdef DEBUG
 	time_t t = time(0);
+
 	debug("getRenames ...\n");
 #endif
-	int i;
-	struct path_list *renames = xcalloc(1, sizeof(struct path_list));
-	struct diff_options opts;
+
+	renames = xcalloc(1, sizeof(struct path_list));
 	diff_setup(&opts);
 	opts.recursive = 1;
 	opts.detect_rename = DIFF_DETECT_RENAME;
@@ -546,6 +450,7 @@ #endif
 	diff_tree_sha1(oTree->object.sha1, tree->object.sha1, "", &opts);
 	diffcore_std(&opts);
 	for (i = 0; i < diff_queued_diff.nr; ++i) {
+		struct path_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
 		if (pair->status != 'R') {
@@ -555,78 +460,66 @@ #endif
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
 		re->pair = pair;
-		re->src_entry = index_entry_find(entries, re->pair->one->path);
-		/* TODO: should it not be an error, if src_entry was found? */
-		if ( !re->src_entry ) {
-			re->src_entry = index_entry_from_db(re->pair->one->path,
-					oTree, aTree, bTree);
-			struct path_list_item *item =
-				path_list_insert(re->pair->one->path, entries);
-			item->util = re->src_entry;
-		}
-		re->dst_entry = index_entry_find(entries, re->pair->two->path);
-		if ( !re->dst_entry ) {
-			re->dst_entry = index_entry_from_db(re->pair->two->path,
-					oTree, aTree, bTree);
-			struct path_list_item *item =
-				path_list_insert(re->pair->two->path, entries);
-			item->util = re->dst_entry;
-		}
-		struct path_list_item *item = path_list_insert(pair->one->path, renames);
+		item = path_list_lookup(re->pair->one->path, entries);
+		if (!item)
+			re->src_entry = insert_stage_data(re->pair->one->path,
+					oTree, aTree, bTree, entries);
+		else
+			re->src_entry = item->util;
+
+		item = path_list_lookup(re->pair->two->path, entries);
+		if (!item)
+			re->dst_entry = insert_stage_data(re->pair->two->path,
+					oTree, aTree, bTree, entries);
+		else
+			re->dst_entry = item->util;
+		item = path_list_insert(pair->one->path, renames);
 		item->util = re;
 	}
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_queued_diff.nr = 0;
 	diff_flush(&opts);
+#ifdef DEBUG
 	debug("  getRenames done in %ld\n", time(0)-t);
+#endif
 	return renames;
 }
 
-/*
- * TODO: the code would be way nicer, if we had a struct containing just sha1 and mode.
- * In this particular case, we might get away reusing stage_data, no?
- */
-int update_stages(const char *path,
-		   unsigned char *osha, unsigned omode,
-		   unsigned char *asha, unsigned amode,
-		   unsigned char *bsha, unsigned bmode,
-		   int clear /* =True */)
+int update_stages(const char *path, struct diff_filespec *o,
+		struct diff_filespec *a, struct diff_filespec *b, int clear)
 {
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
-	if ( clear )
-		if (add_cacheinfo(0, null_sha1, path, 0, 0, options))
+	if (clear) 
+		if (remove_file_from_cache(path))
 			return -1;
-	if ( omode )
-		if (add_cacheinfo(omode, osha, path, 1, 0, options))
+	if (o)
+		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
 			return -1;
-	if ( amode )
-		if (add_cacheinfo(omode, osha, path, 2, 0, options))
+	if (a)
+		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
 			return -1;
-	if ( bmode )
-		if (add_cacheinfo(omode, osha, path, 3, 0, options))
+	if (b)
+		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
 			return -1;
 	return 0;
 }
 
-/*
- * TODO: there has to be a function in libgit doing this exact thing.
- */
 static int remove_path(const char *name)
 {
-	int ret;
-	char *slash;
+	int ret, len;
+	char *slash, *dirs;
 
 	ret = unlink(name);
-	if ( ret )
+	if (ret)
 		return ret;
-	int len = strlen(name);
-	char *dirs = malloc(len+1);
+	len = strlen(name);
+	dirs = malloc(len+1);
 	memcpy(dirs, name, len);
 	dirs[len] = '\0';
-	while ( (slash = strrchr(name, '/')) ) {
+	while ((slash = strrchr(name, '/'))) {
 		*slash = '\0';
 		len = slash - name;
-		if ( rmdir(name) != 0 )
+		if (rmdir(name) != 0)
 			break;
 	}
 	free(dirs);
@@ -636,7 +529,7 @@ static int remove_path(const char *name)
 /* General TODO: unC99ify the code: no declaration after code */
 /* General TODO: no javaIfiCation: rename updateCache to update_cache */
 /*
- * TODO: once we no longer call external programs, we'd probably be better of
+ * TODO: once we no longer call external programs, we'd probably be better off
  * not setting / getting the environment variable GIT_INDEX_FILE all the time.
  */
 int remove_file(int clean, const char *path)
@@ -644,17 +537,17 @@ int remove_file(int clean, const char *p
 	int updateCache = index_only || clean;
 	int updateWd = !index_only;
 
-	if ( updateCache ) {
+	if (updateCache) {
 		if (!cache_dirty)
 			read_cache_from(getenv("GIT_INDEX_FILE"));
 		cache_dirty++;
 		if (remove_file_from_cache(path))
 			return -1;
 	}
-	if ( updateWd )
+	if (updateWd)
 	{
 		unlink(path);
-		if ( errno != ENOENT || errno != EISDIR )
+		if (errno != ENOENT || errno != EISDIR)
 			return -1;
 		remove_path(path);
 	}
@@ -664,55 +557,31 @@ int remove_file(int clean, const char *p
 static char *unique_path(const char *path, const char *branch)
 {
 	char *newpath = xmalloc(strlen(path) + 1 + strlen(branch) + 8 + 1);
+	int suffix = 0;
+	struct stat st;
+	char *p = newpath + strlen(newpath);
 	strcpy(newpath, path);
 	strcat(newpath, "~");
-	char *p = newpath + strlen(newpath);
 	strcpy(p, branch);
-	for ( ; *p; ++p )
-		if ( '/' == *p )
+	for (; *p; ++p)
+		if ('/' == *p)
 			*p = '_';
-	int suffix = 0;
-	struct stat st;
-	while ( path_list_has_path(&currentFileSet, newpath) ||
-		path_list_has_path(&currentDirectorySet, newpath) ||
-		lstat(newpath, &st) == 0 ) {
+	while (path_list_has_path(&currentFileSet, newpath) ||
+	       path_list_has_path(&currentDirectorySet, newpath) ||
+	       lstat(newpath, &st) == 0)
 		sprintf(p, "_%d", suffix++);
-	}
+
 	path_list_insert(newpath, &currentFileSet);
 	return newpath;
 }
 
-/*
- * TODO: except for create_last, this so looks like
- * safe_create_leading_directories().
- */
-static int mkdir_p(const char *path, unsigned long mode, int create_last)
+static int mkdir_p(const char *path, unsigned long mode)
 {
+	/* path points to cache entries, so strdup before messing with it */
 	char *buf = strdup(path);
-	char *p;
-
-	for ( p = buf; *p; ++p ) {
-		if ( *p != '/' )
-			continue;
-		*p = '\0';
-		if (mkdir(buf, mode)) {
-			int e = errno;
-			if ( e == EEXIST ) {
-				struct stat st;
-				if ( !stat(buf, &st) && S_ISDIR(st.st_mode) )
-					goto next; /* ok */
-				errno = e;
-			}
-			free(buf);
-			return -1;
-		}
-	next:
-		*p = '/';
-	}
+	int result = safe_create_leading_directories(buf);
 	free(buf);
-	if ( create_last && mkdir(path, mode) )
-		return -1;
-	return 0;
+	return result;
 }
 
 static void flush_buffer(int fd, const char *buf, unsigned long size)
@@ -732,17 +601,16 @@ static void flush_buffer(int fd, const c
 	}
 }
 
-/* General TODO: reindent according to guide lines (no if ( blabla )) */
 void update_file_flags(const unsigned char *sha,
-		   unsigned mode,
-		   const char *path,
-		   int updateCache,
-		   int updateWd)
+		       unsigned mode,
+		       const char *path,
+		       int update_cache,
+		       int update_wd)
 {
-	if ( index_only )
-		updateWd = 0;
+	if (index_only)
+		update_wd = 0;
 
-	if ( updateWd ) {
+	if (update_wd) {
 		char type[20];
 		void *buf;
 		unsigned long size;
@@ -750,37 +618,38 @@ void update_file_flags(const unsigned ch
 		buf = read_sha1_file(sha, type, &size);
 		if (!buf)
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
-		if ( strcmp(type, blob_type) != 0 )
+		if (strcmp(type, blob_type) != 0)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
 
-		if ( S_ISREG(mode) ) {
-			if ( mkdir_p(path, 0777, 0 /* don't create last element */) )
+		if (S_ISREG(mode)) {
+			int fd;
+			if (mkdir_p(path, 0777))
 				die("failed to create path %s: %s", path, strerror(errno));
 			unlink(path);
-			if ( mode & 0100 )
+			if (mode & 0100)
 				mode = 0777;
 			else
 				mode = 0666;
-			int fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
-			if ( fd < 0 )
+			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+			if (fd < 0)
 				die("failed to open %s: %s", path, strerror(errno));
 			flush_buffer(fd, buf, size);
 			close(fd);
-		} else if ( S_ISLNK(mode) ) {
-			char *linkTarget = malloc(size + 1);
-			memcpy(linkTarget, buf, size);
-			linkTarget[size] = '\0';
-			mkdir_p(path, 0777, 0);
-			symlink(linkTarget, path);
+		} else if (S_ISLNK(mode)) {
+			char *lnk = malloc(size + 1);
+			memcpy(lnk, buf, size);
+			lnk[size] = '\0';
+			mkdir_p(path, 0777);
+			unlink(lnk);
+			symlink(lnk, path);
 		} else
 			die("do not know what to do with %06o %s '%s'",
 			    mode, sha1_to_hex(sha), path);
 	}
-	if ( updateCache )
-		add_cacheinfo(mode, sha, path, 0, updateWd, ADD_CACHE_OK_TO_ADD);
+	if (update_cache)
+		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
 }
 
-/* TODO: is this often used? if not, do direct call */
 void update_file(int clean,
 		const unsigned char *sha,
 		unsigned mode,
@@ -819,64 +688,53 @@ static char *git_unpack_file(const unsig
 	return path;
 }
 
-/*
- * TODO: the signature would be much more efficient using stage_data
- */
-static struct merge_file_info merge_file(const char *oPath,
-					 const unsigned char *oSha,
-					 unsigned oMode,
-					 const char *aPath,
-					 const unsigned char *aSha,
-					 unsigned aMode,
-					 const char *bPath,
-					 const unsigned char *bSha,
-					 unsigned bMode,
-					 const char *branch1Name,
-					 const char *branch2Name)
+static struct merge_file_info merge_file(struct diff_filespec *o,
+		struct diff_filespec *a, struct diff_filespec *b,
+		const char *branch1Name, const char *branch2Name)
 {
 	struct merge_file_info result;
 	result.merge = 0;
 	result.clean = 1;
 
-	if ( (S_IFMT & aMode) != (S_IFMT & bMode) ) {
+	if ((S_IFMT & a->mode) != (S_IFMT & b->mode)) {
 		result.clean = 0;
-		if ( S_ISREG(aMode) ) {
-			result.mode = aMode;
-			memcpy(result.sha, aSha, 20);
+		if (S_ISREG(a->mode)) {
+			result.mode = a->mode;
+			memcpy(result.sha, a->sha1, 20);
 		} else {
-			result.mode = bMode;
-			memcpy(result.sha, bSha, 20);
+			result.mode = b->mode;
+			memcpy(result.sha, b->sha1, 20);
 		}
 	} else {
-		if ( memcmp(aSha, oSha, 20) != 0 && memcmp(bSha, oSha, 20) != 0 )
+		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
 			result.merge = 1;
 
-		result.mode = aMode == oMode ? bMode: aMode;
-
-		if ( memcmp(aSha, oSha, 20) == 0 )
-			memcpy(result.sha, bSha, 20);
-		else if ( memcmp(bSha, oSha, 20) == 0 )
-			memcpy(result.sha, aSha, 20);
-		else if ( S_ISREG(aMode) ) {
+		result.mode = a->mode == o->mode ? b->mode: a->mode;
 
-			int code = 1;
+		if (sha_eq(a->sha1, o->sha1))
+			memcpy(result.sha, b->sha1, 20);
+		else if (sha_eq(b->sha1, o->sha1))
+			memcpy(result.sha, a->sha1, 20);
+		else if (S_ISREG(a->mode)) {
+			int code = 1, fd;
+			struct stat st;
 			char orig[PATH_MAX];
 			char src1[PATH_MAX];
 			char src2[PATH_MAX];
-
-			git_unpack_file(oSha, orig);
-			git_unpack_file(aSha, src1);
-			git_unpack_file(bSha, src2);
-
 			const char *argv[] = {
 				"merge", "-L", NULL, "-L", NULL, "-L", NULL,
 				src1, orig, src2,
 				NULL
 			};
 			char *la, *lb, *lo;
-			argv[2] = la = strdup(mkpath("%s/%s", branch1Name, aPath));
-			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, bPath));
-			argv[4] = lo = strdup(mkpath("orig/%s", oPath));
+
+			git_unpack_file(o->sha1, orig);
+			git_unpack_file(a->sha1, src1);
+			git_unpack_file(b->sha1, src2);
+
+			argv[2] = la = strdup(mkpath("%s/%s", branch1Name, a->path));
+			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, b->path));
+			argv[4] = lo = strdup(mkpath("orig/%s", o->path));
 
 #if 0
 			printf("%s %s %s %s %s %s %s %s %s %s\n",
@@ -888,17 +746,15 @@ #endif
 			free(la);
 			free(lb);
 			free(lo);
-			if ( code && code < -256 ) {
+			if (code && code < -256) {
 				die("Failed to execute 'merge'. merge(1) is used as the "
 				    "file-level merge tool. Is 'merge' in your path?");
 			}
-			struct stat st;
-			int fd = open(src1, O_RDONLY);
+			fd = open(src1, O_RDONLY);
 			if (fd < 0 || fstat(fd, &st) < 0 ||
 					index_fd(result.sha, fd, &st, 1,
 						"blob"))
 				die("Unable to add %s to database", src1);
-			close(fd);
 
 			unlink(orig);
 			unlink(src1);
@@ -906,12 +762,12 @@ #endif
 
 			result.clean = WEXITSTATUS(code) == 0;
 		} else {
-			if ( !(S_ISLNK(aMode) || S_ISLNK(bMode)) )
+			if (!(S_ISLNK(a->mode) || S_ISLNK(b->mode)))
 				die("cannot merge modes?");
 
-			memcpy(result.sha, aSha, 20);
+			memcpy(result.sha, a->sha1, 20);
 
-			if ( memcmp(aSha, bSha, 20) != 0 )
+			if (!sha_eq(a->sha1, b->sha1))
 				result.clean = 0;
 		}
 	}
@@ -942,17 +798,9 @@ static void conflict_rename_rename(struc
 		       ren2_dst, branch1, dstName2);
 		remove_file(0, ren2_dst);
 	}
-	update_stages(dstName1,
-		      NULL, 0,
-		      ren1->pair->two->sha1, ren1->pair->two->mode,
-		      NULL, 0,
-		      1 /* clear */);
-	update_stages(dstName2,
-		      NULL, 0,
-		      NULL, 0,
-		      ren2->pair->two->sha1, ren2->pair->two->mode,
-		      1 /* clear */);
-	while ( delp-- )
+	update_stages(dstName1, NULL, ren1->pair->two, NULL, 1);
+	update_stages(dstName2, NULL, NULL, ren2->pair->two, 1);
+	while (delp--)
 		free(del[delp]);
 }
 
@@ -989,66 +837,73 @@ static int process_renames(struct path_l
 			   const char *branchNameA,
 			   const char *branchNameB)
 {
-	int cleanMerge = 1, i;
-	struct path_list srcNames = {NULL, 0, 0, 0}, byDstA = {NULL, 0, 0, 0}, byDstB = {NULL, 0, 0, 0};
+	int cleanMerge = 1, i, j;
+	struct path_list byDstA = {NULL, 0, 0, 0}, byDstB = {NULL, 0, 0, 0};
 	const struct rename *sre;
 
-	/*
-	 * TODO: think about a saner way to do this.
-	 * Since both renamesA and renamesB are sorted, it should
-	 * be much more efficient to traverse both simultaneously,
-	 * only byDstA and byDstB should be needed.
-	 */
-	debug("processRenames...\n");
 	for (i = 0; i < renamesA->nr; i++) {
 		sre = renamesA->items[i].util;
-		path_list_insert(sre->pair->one->path, &srcNames);
 		path_list_insert(sre->pair->two->path, &byDstA)->util
 			= sre->dst_entry;
 	}
 	for (i = 0; i < renamesB->nr; i++) {
 		sre = renamesB->items[i].util;
-		path_list_insert(sre->pair->one->path, &srcNames);
 		path_list_insert(sre->pair->two->path, &byDstB)->util
 			= sre->dst_entry;
 	}
 
-	for (i = 0; i < srcNames.nr; i++) {
-		char *src = srcNames.items[i].path;
+	for (i = 0, j = 0; i < renamesA->nr || j < renamesB->nr;) {
+		int compare;
+		char *src;
 		struct path_list *renames1, *renames2, *renames2Dst;
-		struct rename *ren1, *ren2;
+		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branchName1, *branchName2;
-		ren1 = find_rename_bysrc(renamesA, src);
-		ren2 = find_rename_bysrc(renamesB, src);
+		const char *ren1_src, *ren1_dst;
+
+		if (i >= renamesA->nr) {
+			compare = 1;
+			ren2 = renamesB->items[j++].util;
+		} else if (j >= renamesB->nr) {
+			compare = -1;
+			ren1 = renamesA->items[i++].util;
+		} else {
+			compare = strcmp(renamesA->items[i].path,
+					renamesB->items[j].path);
+			ren1 = renamesA->items[i++].util;
+			ren2 = renamesB->items[j++].util;
+		}
+
 		/* TODO: refactor, so that 1/2 are not needed */
-		if ( ren1 ) {
+		if (ren1) {
 			renames1 = renamesA;
 			renames2 = renamesB;
 			renames2Dst = &byDstB;
 			branchName1 = branchNameA;
 			branchName2 = branchNameB;
 		} else {
+			struct rename *tmp;
 			renames1 = renamesB;
 			renames2 = renamesA;
 			renames2Dst = &byDstA;
 			branchName1 = branchNameB;
 			branchName2 = branchNameA;
-			struct rename *tmp = ren2;
+			tmp = ren2;
 			ren2 = ren1;
 			ren1 = tmp;
 		}
+		src = ren1->pair->one->path;
 
 		ren1->dst_entry->processed = 1;
 		ren1->src_entry->processed = 1;
 
-		if ( ren1->processed )
+		if (ren1->processed)
 			continue;
 		ren1->processed = 1;
 
-		const char *ren1_src = ren1->pair->one->path;
-		const char *ren1_dst = ren1->pair->two->path;
+		ren1_src = ren1->pair->one->path;
+		ren1_dst = ren1->pair->two->path;
 
-		if ( ren2 ) {
+		if (ren2) {
 			const char *ren2_src = ren2->pair->one->path;
 			const char *ren2_dst = ren2->pair->two->path;
 			/* Renamed in 1 and renamed in 2 */
@@ -1067,57 +922,48 @@ static int process_renames(struct path_l
 			} else {
 				remove_file(1, ren1_src);
 				struct merge_file_info mfi;
-				mfi = merge_file(ren1_src,
-						 ren1->pair->one->sha1,
-						 ren1->pair->one->mode,
-						 ren1_dst,
-						 ren1->pair->two->sha1,
-						 ren1->pair->two->mode,
-						 ren2_dst,
-						 ren2->pair->two->sha1,
-						 ren2->pair->two->mode,
+				mfi = merge_file(ren1->pair->one,
+						 ren1->pair->two,
+						 ren2->pair->two,
 						 branchName1,
 						 branchName2);
-				if ( mfi.merge || !mfi.clean )
+				if (mfi.merge || !mfi.clean)
 					output("Renaming %s->%s", src, ren1_dst);
 
-				if ( mfi.merge )
+				if (mfi.merge)
 					output("Auto-merging %s", ren1_dst);
 
-				if ( !mfi.clean ) {
+				if (!mfi.clean) {
 					output("CONFLICT (content): merge conflict in %s",
 					       ren1_dst);
 					cleanMerge = 0;
 
-					if ( !index_only )
+					if (!index_only)
 						update_stages(ren1_dst,
-							      ren1->pair->one->sha1,
-							      ren1->pair->one->mode,
-							      ren1->pair->two->sha1,
-							      ren1->pair->two->mode,
-							      ren2->pair->two->sha1,
-							      ren2->pair->two->mode,
+							      ren1->pair->one,
+							      ren1->pair->two,
+							      ren2->pair->two,
 							      1 /* clear */);
 				}
 				update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
-			remove_file(1, ren1_src);
-
-			unsigned char srcShaOtherBranch[20], dstShaOtherBranch[20];
-			unsigned srcModeOtherBranch, dstModeOtherBranch;
-
-			int stage = renamesA == renames1 ? 3: 2;
+			struct path_list_item *item;
+			/* we only use sha1 and mode of these */
+			struct diff_filespec src_other, dst_other;
+			int tryMerge, stage = renamesA == renames1 ? 3: 2;
 
-			memcpy(srcShaOtherBranch, ren1->src_entry->stages[stage].sha, 20);
-			srcModeOtherBranch = ren1->src_entry->stages[stage].mode;
+			remove_file(1, ren1_src);
 
-			memcpy(dstShaOtherBranch, ren1->dst_entry->stages[stage].sha, 20);
-			dstModeOtherBranch = ren1->dst_entry->stages[stage].mode;
+			memcpy(src_other.sha1,
+					ren1->src_entry->stages[stage].sha, 20);
+			src_other.mode = ren1->src_entry->stages[stage].mode;
+			memcpy(dst_other.sha1,
+					ren1->dst_entry->stages[stage].sha, 20);
+			dst_other.mode = ren1->dst_entry->stages[stage].mode;
 
-			int tryMerge = 0;
-			char *newPath;
+			tryMerge = 0;
 
 			if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
 				cleanMerge = 0;
@@ -1126,14 +972,15 @@ static int process_renames(struct path_l
 				       ren1_src, ren1_dst, branchName1,
 				       ren1_dst, branchName2);
 				conflict_rename_dir(ren1, branchName1);
-			} else if ( memcmp(srcShaOtherBranch, null_sha1, 20) == 0 ) {
+			} else if (sha_eq(src_other.sha1, null_sha1)) {
 				cleanMerge = 0;
 				output("CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
 				       ren1_src, ren1_dst, branchName1,
 				       branchName2);
 				update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
-			} else if ( memcmp(dstShaOtherBranch, null_sha1, 20) != 0 ) {
+			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
+				const char *newPath;
 				cleanMerge = 0;
 				tryMerge = 1;
 				output("CONFLICT (rename/add): Rename %s->%s in %s. "
@@ -1142,8 +989,9 @@ static int process_renames(struct path_l
 				       ren1_dst, branchName2);
 				newPath = unique_path(ren1_dst, branchName2);
 				output("Adding as %s instead", newPath);
-				update_file(0, dstShaOtherBranch, dstModeOtherBranch, newPath);
-			} else if ( (ren2 = find_rename_bysrc(renames2Dst, ren1_dst)) ) {
+				update_file(0, dst_other.sha1, dst_other.mode, newPath);
+			} else if ((item = path_list_lookup(ren1_dst, renames2Dst))) {
+				ren2 = item->util;
 				cleanMerge = 0;
 				ren2->processed = 1;
 				output("CONFLICT (rename/rename): Rename %s->%s in %s. "
@@ -1154,53 +1002,41 @@ static int process_renames(struct path_l
 			} else
 				tryMerge = 1;
 
-			if ( tryMerge ) {
-				const char *oname = ren1_src;
-				const char *aname = ren1_dst;
-				const char *bname = ren1_src;
-				unsigned char osha[20], asha[20], bsha[20];
-				unsigned omode = ren1->pair->one->mode;
-				unsigned amode = ren1->pair->two->mode;
-				unsigned bmode = srcModeOtherBranch;
-				memcpy(osha, ren1->pair->one->sha1, 20);
-				memcpy(asha, ren1->pair->two->sha1, 20);
-				memcpy(bsha, srcShaOtherBranch, 20);
-				const char *aBranch = branchName1;
-				const char *bBranch = branchName2;
-
-				if ( renamesA != renames1 ) {
-					memswp(&aname, &bname, sizeof(aname));
-					memswp(asha, bsha, 20);
-					memswp(&aBranch, &bBranch, sizeof(aBranch));
-				}
+			if (tryMerge) {
+				struct diff_filespec *o, *a, *b;
 				struct merge_file_info mfi;
-				mfi = merge_file(oname, osha, omode,
-						 aname, asha, amode,
-						 bname, bsha, bmode,
-						 aBranch, bBranch);
+				src_other.path = (char *)ren1_src;
+
+				o = ren1->pair->one;
+				if (renamesA == renames1) {
+					a = ren1->pair->two;
+					b = &src_other;
+				} else {
+					b = ren1->pair->two;
+					a = &src_other;
+				}
+				mfi = merge_file(o, a, b,
+						branchNameA, branchNameB);
 
-				if ( mfi.merge || !mfi.clean )
+				if (mfi.merge || !mfi.clean)
 					output("Renaming %s => %s", ren1_src, ren1_dst);
-				if ( mfi.merge )
+				if (mfi.merge)
 					output("Auto-merging %s", ren1_dst);
-				if ( !mfi.clean ) {
+				if (!mfi.clean) {
 					output("CONFLICT (rename/modify): Merge conflict in %s",
 					       ren1_dst);
 					cleanMerge = 0;
 
-					if ( !index_only )
+					if (!index_only)
 						update_stages(ren1_dst,
-							      osha, omode,
-							      asha, amode,
-							      bsha, bmode,
-							      1 /* clear */);
+								o, a, b, 1);
 				}
 				update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		}
 	}
-	path_list_clear(&srcNames, 0);
-	debug("  processRenames done\n");
+	path_list_clear(&byDstA, 0);
+	path_list_clear(&byDstB, 0);
 
 	if (cache_dirty)
 		flush_cache();
@@ -1229,20 +1065,20 @@ static int process_entry(const char *pat
 	unsigned aMode = entry->stages[2].mode;
 	unsigned bMode = entry->stages[3].mode;
 
-	if ( oSha && (!aSha || !bSha) ) {
+	if (oSha && (!aSha || !bSha)) {
 		/* Case A: Deleted in one */
-		if ( (!aSha && !bSha) ||
-		     (sha_eq(aSha, oSha) && !bSha) ||
-		     (!aSha && sha_eq(bSha, oSha)) ) {
+		if ((!aSha && !bSha) ||
+		    (sha_eq(aSha, oSha) && !bSha) ||
+		    (!aSha && sha_eq(bSha, oSha))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
-			if ( aSha )
+			if (aSha)
 				output("Removing %s", path);
 			remove_file(1, path);
 		} else {
 			/* Deleted in one and changed in the other */
 			cleanMerge = 0;
-			if ( !aSha ) {
+			if (!aSha) {
 				output("CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, branch1Name,
@@ -1257,8 +1093,8 @@ static int process_entry(const char *pat
 			}
 		}
 
-	} else if ( (!oSha && aSha && !bSha) ||
-		    (!oSha && !aSha && bSha) ) {
+	} else if ((!oSha && aSha && !bSha) ||
+		   (!oSha && !aSha && bSha)) {
 		/* Case B: Added in one. */
 		const char *addBranch;
 		const char *otherBranch;
@@ -1266,7 +1102,7 @@ static int process_entry(const char *pat
 		const unsigned char *sha;
 		const char *conf;
 
-		if ( aSha ) {
+		if (aSha) {
 			addBranch = branch1Name;
 			otherBranch = branch2Name;
 			mode = aMode;
@@ -1279,9 +1115,9 @@ static int process_entry(const char *pat
 			sha = bSha;
 			conf = "directory/file";
 		}
-		if ( path_list_has_path(&currentDirectorySet, path) ) {
-			cleanMerge = 0;
+		if (path_list_has_path(&currentDirectorySet, path)) {
 			const char *newPath = unique_path(path, addBranch);
+			cleanMerge = 0;
 			output("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, otherBranch, path, newPath);
@@ -1291,10 +1127,10 @@ static int process_entry(const char *pat
 			output("Adding %s", path);
 			update_file(1, sha, mode, path);
 		}
-	} else if ( !oSha && aSha && bSha ) {
+	} else if (!oSha && aSha && bSha) {
 		/* Case C: Added in both (check for same permissions). */
-		if ( sha_eq(aSha, bSha) ) {
-			if ( aMode != bMode ) {
+		if (sha_eq(aSha, bSha)) {
+			if (aMode != bMode) {
 				cleanMerge = 0;
 				output("CONFLICT: File %s added identically in both branches, "
 				       "but permissions conflict %06o->%06o",
@@ -1306,9 +1142,10 @@ static int process_entry(const char *pat
 				assert(0 && "This case must be handled by git-read-tree");
 			}
 		} else {
+			const char *newPath1, *newPath2;
 			cleanMerge = 0;
-			const char *newPath1 = unique_path(path, branch1Name);
-			const char *newPath2 = unique_path(path, branch2Name);
+			newPath1 = unique_path(path, branch1Name);
+			newPath2 = unique_path(path, branch2Name);
 			output("CONFLICT (add/add): File %s added non-identically "
 			       "in both branches. Adding as %s and %s instead.",
 			       path, newPath1, newPath2);
@@ -1317,22 +1154,30 @@ static int process_entry(const char *pat
 			update_file(0, bSha, bMode, newPath2);
 		}
 
-	} else if ( oSha && aSha && bSha ) {
+	} else if (oSha && aSha && bSha) {
 		/* case D: Modified in both, but differently. */
-		output("Auto-merging %s", path);
 		struct merge_file_info mfi;
-		mfi = merge_file(path, oSha, oMode,
-				 path, aSha, aMode,
-				 path, bSha, bMode,
+		struct diff_filespec o, a, b;
+
+		output("Auto-merging %s", path);
+		o.path = a.path = b.path = (char *)path;
+		memcpy(o.sha1, oSha, 20);
+		o.mode = oMode;
+		memcpy(a.sha1, aSha, 20);
+		a.mode = aMode;
+		memcpy(b.sha1, bSha, 20);
+		b.mode = bMode;
+		
+		mfi = merge_file(&o, &a, &b,
 				 branch1Name, branch2Name);
 
-		if ( mfi.clean )
+		if (mfi.clean)
 			update_file(1, mfi.sha, mfi.mode, path);
 		else {
 			cleanMerge = 0;
 			output("CONFLICT (content): Merge conflict in %s", path);
 
-			if ( index_only )
+			if (index_only)
 				update_file(0, mfi.sha, mfi.mode, path);
 			else
 				update_file_flags(mfi.sha, mfi.mode, path,
@@ -1347,73 +1192,68 @@ static int process_entry(const char *pat
 	return cleanMerge;
 }
 
-static struct merge_tree_result merge_trees(struct tree *head,
-					    struct tree *merge,
-					    struct tree *common,
-					    const char *branch1Name,
-					    const char *branch2Name)
+static int merge_trees(struct tree *head,
+		       struct tree *merge,
+		       struct tree *common,
+		       const char *branch1Name,
+		       const char *branch2Name,
+		       struct tree **result)
 {
-	int code;
-	struct merge_tree_result result = { NULL, 0 };
-	if ( !memcmp(common->object.sha1, merge->object.sha1, 20) ) {
+	int code, clean;
+	if (sha_eq(common->object.sha1, merge->object.sha1)) {
 		output("Already uptodate!");
-		result.tree = head;
-		result.clean = 1;
-		return result;
+		*result = head;
+		return 1;
 	}
 
-	debug("merge_trees ...\n");
 	code = git_merge_trees(index_only ? "-i": "-u", common, head, merge);
 
-	if ( code != 0 )
+	if (code != 0)
 		die("merging of trees %s and %s failed",
 		    sha1_to_hex(head->object.sha1),
 		    sha1_to_hex(merge->object.sha1));
 
-	result.tree = git_write_tree();
+	*result = git_write_tree();
 
-	if ( !result.tree ) {
+	if (!*result) {
+		struct path_list *entries, *re_head, *re_merge;
+		int i;
 		path_list_clear(&currentFileSet, 1);
 		path_list_clear(&currentDirectorySet, 1);
-		get_files_dirs(head, &currentFileSet, &currentDirectorySet);
-		get_files_dirs(merge, &currentFileSet, &currentDirectorySet);
+		get_files_dirs(head);
+		get_files_dirs(merge);
 
-		struct path_list *entries = get_unmerged();
-		struct path_list *re_head, *re_merge;
+		entries = get_unmerged();
 		re_head  = get_renames(head, common, head, merge, entries);
 		re_merge = get_renames(merge, common, head, merge, entries);
-		result.clean = process_renames(re_head, re_merge,
-					       branch1Name, branch2Name);
-		debug("\tprocessing entries...\n");
-		int i;
+		clean = process_renames(re_head, re_merge,
+				branch1Name, branch2Name);
 		for (i = 0; i < entries->nr; i++) {
 			const char *path = entries->items[i].path;
 			struct stage_data *e = entries->items[i].util;
 			if (e->processed)
 				continue;
 			if (!process_entry(path, e, branch1Name, branch2Name))
-				result.clean = 0;
+				clean = 0;
 		}
 
-		free_rename_entries(&re_merge);
-		free_rename_entries(&re_head);
-		free_index_entries(&entries);
+		path_list_clear(re_merge, 0);
+		path_list_clear(re_head, 0);
+		path_list_clear(entries, 1);
 
-		if (result.clean || index_only)
-			result.tree = git_write_tree();
+		if (clean || index_only)
+			*result = git_write_tree();
 		else
-			result.tree = NULL;
-		debug("\t  processing entries done\n");
+			*result = NULL;
 	} else {
-		result.clean = 1;
+		clean = 1;
 		printf("merging of trees %s and %s resulted in %s\n",
 		       sha1_to_hex(head->object.sha1),
 		       sha1_to_hex(merge->object.sha1),
-		       sha1_to_hex(result.tree->object.sha1));
+		       sha1_to_hex((*result)->object.sha1));
 	}
 
-	debug("  merge_trees done\n");
-	return result;
+	return clean;
 }
 
 /*
@@ -1421,87 +1261,86 @@ static struct merge_tree_result merge_tr
  * commit object and a flag indicating the cleaness of the merge.
  */
 static
-struct merge_result merge(struct commit *h1,
+int merge(struct commit *h1,
 			  struct commit *h2,
 			  const char *branch1Name,
 			  const char *branch2Name,
 			  int callDepth /* =0 */,
-			  struct commit *ancestor /* =None */)
+			  struct commit *ancestor /* =None */,
+			  struct commit **result)
 {
-	struct merge_result result = { NULL, 0 };
-	const char *msg;
-	int msglen;
 	struct commit_list *ca = NULL, *iter;
 	struct commit *mergedCA;
-	struct merge_tree_result mtr;
+	struct tree *mrtree;
+	int clean;
 
 	output("Merging:");
-	msg = commit_title(h1, &msglen);
-	/* TODO: refactor. we always show the sha1 with the title */
-	output("%s %.*s", commit_hex_sha1(h1), msglen, msg);
-	msg = commit_title(h2, &msglen);
-	output("%s %.*s", commit_hex_sha1(h2), msglen, msg);
+	output_commit_title(h1);
+	output_commit_title(h2);
 
-	if ( ancestor )
+	if (ancestor)
 		commit_list_insert(ancestor, &ca);
 	else
 		ca = get_merge_bases(h1, h2, 1);
 
 	output("found %u common ancestor(s):", commit_list_count(ca));
-	for (iter = ca; iter; iter = iter->next) {
-		msg = commit_title(iter->item, &msglen);
-		output("%s %.*s", commit_hex_sha1(iter->item), msglen, msg);
-	}
+	for (iter = ca; iter; iter = iter->next)
+		output_commit_title(iter->item);
 
 	mergedCA = pop_commit(&ca);
 
-	/* TODO: what happens when merge with virtual commits fails? */
 	for (iter = ca; iter; iter = iter->next) {
 		output_indent = callDepth + 1;
-		result = merge(mergedCA, iter->item,
-			       "Temporary merge branch 1",
-			       "Temporary merge branch 2",
-			       callDepth + 1,
-			       NULL);
-		mergedCA = result.commit;
+		/*
+		 * When the merge fails, the result contains files
+		 * with conflict markers. The cleanness flag is
+		 * ignored, it was never acutally used, as result of
+		 * merge_trees has always overwritten it: the commited
+		 * "conflicts" were already resolved. 
+		 */
+		merge(mergedCA, iter->item,
+		      "Temporary merge branch 1",
+		      "Temporary merge branch 2",
+		      callDepth + 1,
+		      NULL,
+		      &mergedCA);
 		output_indent = callDepth;
 
-		if ( !mergedCA )
+		if (!mergedCA)
 			die("merge returned no commit");
 	}
 
-	if ( callDepth == 0 ) {
-		setup_index(0);
+	if (callDepth == 0) {
+		setup_index(0 /* $GIT_DIR/index */);
 		index_only = 0;
 	} else {
-		setup_index(1);
+		setup_index(1 /* temporary index */);
 		git_read_tree(h1->tree);
 		index_only = 1;
 	}
 
-	mtr = merge_trees(h1->tree, h2->tree,
-			  mergedCA->tree, branch1Name, branch2Name);
+	clean = merge_trees(h1->tree, h2->tree, mergedCA->tree,
+			    branch1Name, branch2Name, &mrtree);
 
-	if ( !ancestor && (mtr.clean || index_only) ) {
-		result.commit = make_virtual_commit(mtr.tree, "merged tree");
-		commit_list_insert(h1, &result.commit->parents);
-		commit_list_insert(h2, &result.commit->parents->next);
+	if (!ancestor && (clean || index_only)) {
+		*result = make_virtual_commit(mrtree, "merged tree");
+		commit_list_insert(h1, &(*result)->parents);
+		commit_list_insert(h2, &(*result)->parents->next);
 	} else
-		result.commit = NULL;
+		*result = NULL;
 
-	result.clean = mtr.clean;
-	return result;
+	return clean;
 }
 
 static struct commit *get_ref(const char *ref)
 {
 	unsigned char sha1[20];
 	struct object *object;
-
+	
 	if (get_sha1(ref, sha1))
 		die("Could not resolve ref '%s'", ref);
 	object = deref_tag(parse_object(sha1), ref, strlen(ref));
-	if (object->type != OBJ_COMMIT)
+	if (object->type != TYPE_COMMIT)
 		return NULL;
 	if (parse_commit((struct commit *)object))
 		die("Could not parse commit '%s'", sha1_to_hex(object->sha1));
@@ -1512,6 +1351,9 @@ int main(int argc, char *argv[])
 {
 	static const char *bases[2];
 	static unsigned bases_count = 0;
+	int i, clean;
+	const char *branch1, *branch2;
+	struct commit *result, *h1, *h2;
 
 	original_index_file = getenv("GIT_INDEX_FILE");
 
@@ -1523,7 +1365,6 @@ int main(int argc, char *argv[])
 	if (argc < 4)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
 
-	int i;
 	for (i = 1; i < argc; ++i) {
 		if (!strcmp(argv[i], "--"))
 			break;
@@ -1533,26 +1374,23 @@ int main(int argc, char *argv[])
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
 
-	const char *branch1, *branch2;
-
 	branch1 = argv[++i];
 	branch2 = argv[++i];
 	printf("Merging %s with %s\n", branch1, branch2);
 
-	struct merge_result result;
-	struct commit *h1 = get_ref(branch1);
-	struct commit *h2 = get_ref(branch2);
+	h1 = get_ref(branch1);
+	h2 = get_ref(branch2);
 
 	if (bases_count == 1) {
 		struct commit *ancestor = get_ref(bases[0]);
-		result = merge(h1, h2, branch1, branch2, 0, ancestor);
+		clean = merge(h1, h2, branch1, branch2, 0, ancestor, &result);
 	} else
-		result = merge(h1, h2, branch1, branch2, 0, NULL);
+		clean = merge(h1, h2, branch1, branch2, 0, NULL, &result);
 
 	if (cache_dirty)
 		flush_cache();
 
-	return result.clean ? 0: 1;
+	return clean ? 0: 1;
 }
 
 /*

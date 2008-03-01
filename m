From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/6] Rename path_list to string_list
Date: Sat, 1 Mar 2008 13:15:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803011315180.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802290214150.22527@racer.site> <alpine.LSU.1.00.0803011313020.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVRaD-0007MQ-Ra
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbYCANQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbYCANQT
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:16:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:46361 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755799AbYCANQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:16:16 -0500
Received: (qmail invoked by alias); 01 Mar 2008 13:16:13 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp055) with SMTP; 01 Mar 2008 14:16:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ByThrYAuBTUhnPOZRXz5G05FSKFIe33Y5CCqHnd
	Y0Na971L8YULpL
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803011313020.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75666>


The name path_list was correct for the first usage of that data structure,
but it really is a general-purpose string list.

$ perl -i -pe 's/path-list/string-list/g' $(git grep -l path-list)
$ perl -i -pe 's/path_list/string_list/g' $(git grep -l path_list)
$ git mv path-list.h string-list.h
$ git mv path-list.c string-list.c
$ perl -i -pe 's/has_path/has_string/g' $(git grep -l has_path)
$ perl -i -pe 's/path/string/g' string-list.[ch]

... and then fix all users of string-list to access the member "string"
instead of "path"...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/CodingGuidelines            |    2 +-
 Documentation/technical/api-path-list.txt |    4 +-
 Makefile                                  |    4 +-
 builtin-blame.c                           |    4 +-
 builtin-commit.c                          |   20 +++---
 builtin-fast-export.c                     |   14 ++--
 builtin-fetch.c                           |   16 +++---
 builtin-mailsplit.c                       |   12 ++--
 builtin-merge-recursive.c                 |   96 ++++++++++++++--------------
 builtin-mv.c                              |   39 ++++++------
 builtin-rerere.c                          |   48 +++++++-------
 builtin-shortlog.c                        |   42 ++++++------
 builtin-show-ref.c                        |   10 ++--
 diff-lib.c                                |   22 +++---
 mailmap.c                                 |   12 ++--
 mailmap.h                                 |    4 +-
 path-list.h                               |   22 -------
 reflog-walk.c                             |   10 ++--
 shortlog.h                                |    6 +-
 path-list.c => string-list.c              |   41 ++++++------
 string-list.h                             |   22 +++++++
 21 files changed, 226 insertions(+), 224 deletions(-)
 delete mode 100644 path-list.h
 rename path-list.c => string-list.c (53%)
 create mode 100644 string-list.h

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 3b042db..fe7c74b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -91,7 +91,7 @@ For C programs:
 
  - Use the API.  No, really.  We have a strbuf (variable length
    string), several arrays with the ALLOC_GROW() macro, a
-   path_list for sorted string lists, a hash map (mapping struct
+   string_list for sorted string lists, a hash map (mapping struct
    objects) named "struct decorate", amongst other things.
 
  - When you come up with an API, document it.
diff --git a/Documentation/technical/api-path-list.txt b/Documentation/technical/api-path-list.txt
index d077683..8892cf0 100644
--- a/Documentation/technical/api-path-list.txt
+++ b/Documentation/technical/api-path-list.txt
@@ -1,7 +1,7 @@
-path-list API
+string-list API
 =============
 
-Talk about <path-list.h>, things like
+Talk about <string-list.h>, things like
 
 * it is not just paths but strings in general;
 * the calling sequence.
diff --git a/Makefile b/Makefile
index 88f1c7e..ad214d3 100644
--- a/Makefile
+++ b/Makefile
@@ -302,7 +302,7 @@ LIB_H = \
 	archive.h blob.h cache.h cache-tree.h commit.h csum-file.h delta.h grep.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
+	tree-walk.h log-tree.h dir.h string-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
 	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h ll-merge.h
 
@@ -324,7 +324,7 @@ LIB_OBJS = \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
-	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
+	alloc.o merge-file.o string-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
 	transport.o bundle.o walker.o parse-options.o ws.o archive.o branch.o \
diff --git a/builtin-blame.c b/builtin-blame.c
index bfd562d..25c7996 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -16,7 +16,7 @@
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "cache-tree.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "mailmap.h"
 
 static char blame_usage[] =
@@ -47,7 +47,7 @@ static int blank_boundary;
 static int incremental;
 static int cmd_is_annotate;
 static int xdl_opts = XDF_NEED_MINIMAL;
-static struct path_list mailmap;
+static struct string_list mailmap;
 
 #ifndef DEBUG
 #define DEBUG 0
diff --git a/builtin-commit.c b/builtin-commit.c
index f49c22e..380dcdc 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -21,7 +21,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "unpack-trees.h"
 
 static const char * const builtin_commit_usage[] = {
@@ -146,7 +146,7 @@ static int commit_index_files(void)
  * Take a union of paths in the index and the named tree (typically, "HEAD"),
  * and return the paths that match the given pattern in list.
  */
-static int list_paths(struct path_list *list, const char *with_tree,
+static int list_paths(struct string_list *list, const char *with_tree,
 		      const char *prefix, const char **pattern)
 {
 	int i;
@@ -165,21 +165,21 @@ static int list_paths(struct path_list *list, const char *with_tree,
 			continue;
 		if (!pathspec_match(pattern, m, ce->name, 0))
 			continue;
-		path_list_insert(ce->name, list);
+		string_list_insert(ce->name, list);
 	}
 
 	return report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
 }
 
-static void add_remove_files(struct path_list *list)
+static void add_remove_files(struct string_list *list)
 {
 	int i;
 	for (i = 0; i < list->nr; i++) {
-		struct path_list_item *p = &(list->items[i]);
-		if (file_exists(p->path))
-			add_file_to_cache(p->path, 0);
+		struct string_list_item *p = &(list->items[i]);
+		if (file_exists(p->string))
+			add_file_to_cache(p->string, 0);
 		else
-			remove_file_from_cache(p->path);
+			remove_file_from_cache(p->string);
 	}
 }
 
@@ -212,7 +212,7 @@ static void create_base_index(void)
 static char *prepare_index(int argc, const char **argv, const char *prefix)
 {
 	int fd;
-	struct path_list partial;
+	struct string_list partial;
 	const char **pathspec = NULL;
 
 	if (interactive) {
@@ -294,7 +294,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		die("cannot do a partial commit during a merge.");
 
 	memset(&partial, 0, sizeof(partial));
-	partial.strdup_paths = 1;
+	partial.strdup_strings = 1;
 	if (list_paths(&partial, initial_commit ? NULL : "HEAD", prefix, pathspec))
 		exit(1);
 
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index e1c5630..a705029 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -13,7 +13,7 @@
 #include "log-tree.h"
 #include "revision.h"
 #include "decorate.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
 
@@ -286,7 +286,7 @@ static void handle_tag(const char *name, struct tag *tag)
 }
 
 static void get_tags_and_duplicates(struct object_array *pending,
-				    struct path_list *extra_refs)
+				    struct string_list *extra_refs)
 {
 	struct tag *tag;
 	int i;
@@ -307,7 +307,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		case OBJ_TAG:
 			tag = (struct tag *)e->item;
 			while (tag && tag->object.type == OBJ_TAG) {
-				path_list_insert(full_name, extra_refs)->util = tag;
+				string_list_insert(full_name, extra_refs)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
 			if (!tag)
@@ -327,19 +327,19 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		}
 		if (commit->util)
 			/* more than one name for the same object */
-			path_list_insert(full_name, extra_refs)->util = commit;
+			string_list_insert(full_name, extra_refs)->util = commit;
 		else
 			commit->util = full_name;
 	}
 }
 
-static void handle_tags_and_duplicates(struct path_list *extra_refs)
+static void handle_tags_and_duplicates(struct string_list *extra_refs)
 {
 	struct commit *commit;
 	int i;
 
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
-		const char *name = extra_refs->items[i].path;
+		const char *name = extra_refs->items[i].string;
 		struct object *object = extra_refs->items[i].util;
 		switch (object->type) {
 		case OBJ_TAG:
@@ -360,7 +360,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = { 0, 0, NULL };
-	struct path_list extra_refs = { NULL, 0, 0, 0 };
+	struct string_list extra_refs = { NULL, 0, 0, 0 };
 	struct commit *commit;
 	struct option options[] = {
 		OPT_INTEGER(0, "progress", &progress,
diff --git a/builtin-fetch.c b/builtin-fetch.c
index ac335f2..94e3e74 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "builtin.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "remote.h"
 #include "transport.h"
 #include "run-command.h"
@@ -447,16 +447,16 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 static int add_existing(const char *refname, const unsigned char *sha1,
 			int flag, void *cbdata)
 {
-	struct path_list *list = (struct path_list *)cbdata;
-	path_list_insert(refname, list);
+	struct string_list *list = (struct string_list *)cbdata;
+	string_list_insert(refname, list);
 	return 0;
 }
 
 static struct ref *find_non_local_tags(struct transport *transport,
 				       struct ref *fetch_map)
 {
-	static struct path_list existing_refs = { NULL, 0, 0, 0 };
-	struct path_list new_refs = { NULL, 0, 0, 1 };
+	static struct string_list existing_refs = { NULL, 0, 0, 0 };
+	struct string_list new_refs = { NULL, 0, 0, 1 };
 	char *ref_name;
 	int ref_name_len;
 	const unsigned char *ref_sha1;
@@ -487,10 +487,10 @@ static struct ref *find_non_local_tags(struct transport *transport,
 			}
 		}
 
-		if (!path_list_has_path(&existing_refs, ref_name) &&
-		    !path_list_has_path(&new_refs, ref_name) &&
+		if (!string_list_has_string(&existing_refs, ref_name) &&
+		    !string_list_has_string(&new_refs, ref_name) &&
 		    has_sha1_file(ref->old_sha1)) {
-			path_list_insert(ref_name, &new_refs);
+			string_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
 			strcpy(rm->name, ref_name);
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 46b27cd..29df10f 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -6,7 +6,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
-#include "path-list.h"
+#include "string-list.h"
 
 static const char git_mailsplit_usage[] =
 "git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
@@ -97,7 +97,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	exit(1);
 }
 
-static int populate_maildir_list(struct path_list *list, const char *path)
+static int populate_maildir_list(struct string_list *list, const char *path)
 {
 	DIR *dir;
 	struct dirent *dent;
@@ -118,7 +118,7 @@ static int populate_maildir_list(struct path_list *list, const char *path)
 			if (dent->d_name[0] == '.')
 				continue;
 			snprintf(name, sizeof(name), "%s/%s", *sub, dent->d_name);
-			path_list_insert(name, list);
+			string_list_insert(name, list);
 		}
 
 		closedir(dir);
@@ -134,14 +134,14 @@ static int split_maildir(const char *maildir, const char *dir,
 	char name[PATH_MAX];
 	int ret = -1;
 	int i;
-	struct path_list list = {NULL, 0, 0, 1};
+	struct string_list list = {NULL, 0, 0, 1};
 
 	if (populate_maildir_list(&list, maildir) < 0)
 		goto out;
 
 	for (i = 0; i < list.nr; i++) {
 		FILE *f;
-		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].path);
+		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
 		f = fopen(file, "r");
 		if (!f) {
 			error("cannot open mail %s (%s)", file, strerror(errno));
@@ -161,7 +161,7 @@ static int split_maildir(const char *maildir, const char *dir,
 
 	ret = skip;
 out:
-	path_list_clear(&list, 1);
+	string_list_clear(&list, 1);
 	return ret;
 }
 
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 5a0a7b5..8e77e8b 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -13,7 +13,7 @@
 #include "diffcore.h"
 #include "tag.h"
 #include "unpack-trees.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "interpolate.h"
@@ -87,8 +87,8 @@ struct stage_data
 	unsigned processed:1;
 };
 
-static struct path_list current_file_set = {NULL, 0, 0, 1};
-static struct path_list current_directory_set = {NULL, 0, 0, 1};
+static struct string_list current_file_set = {NULL, 0, 0, 1};
+static struct string_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
 static int verbosity = 2;
@@ -262,9 +262,9 @@ static int save_files_dirs(const unsigned char *sha1,
 	newpath[baselen + len] = '\0';
 
 	if (S_ISDIR(mode))
-		path_list_insert(newpath, &current_directory_set);
+		string_list_insert(newpath, &current_directory_set);
 	else
-		path_list_insert(newpath, &current_file_set);
+		string_list_insert(newpath, &current_file_set);
 	free(newpath);
 
 	return READ_TREE_RECURSIVE;
@@ -285,9 +285,9 @@ static int get_files_dirs(struct tree *tree)
  */
 static struct stage_data *insert_stage_data(const char *path,
 		struct tree *o, struct tree *a, struct tree *b,
-		struct path_list *entries)
+		struct string_list *entries)
 {
-	struct path_list_item *item;
+	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
 	get_tree_entry(o->object.sha1, path,
 			e->stages[1].sha, &e->stages[1].mode);
@@ -295,7 +295,7 @@ static struct stage_data *insert_stage_data(const char *path,
 			e->stages[2].sha, &e->stages[2].mode);
 	get_tree_entry(b->object.sha1, path,
 			e->stages[3].sha, &e->stages[3].mode);
-	item = path_list_insert(path, entries);
+	item = string_list_insert(path, entries);
 	item->util = e;
 	return e;
 }
@@ -304,23 +304,23 @@ static struct stage_data *insert_stage_data(const char *path,
  * Create a dictionary mapping file names to stage_data objects. The
  * dictionary contains one entry for every path with a non-zero stage entry.
  */
-static struct path_list *get_unmerged(void)
+static struct string_list *get_unmerged(void)
 {
-	struct path_list *unmerged = xcalloc(1, sizeof(struct path_list));
+	struct string_list *unmerged = xcalloc(1, sizeof(struct string_list));
 	int i;
 
-	unmerged->strdup_paths = 1;
+	unmerged->strdup_strings = 1;
 
 	for (i = 0; i < active_nr; i++) {
-		struct path_list_item *item;
+		struct string_list_item *item;
 		struct stage_data *e;
 		struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
 			continue;
 
-		item = path_list_lookup(ce->name, unmerged);
+		item = string_list_lookup(ce->name, unmerged);
 		if (!item) {
-			item = path_list_insert(ce->name, unmerged);
+			item = string_list_insert(ce->name, unmerged);
 			item->util = xcalloc(1, sizeof(struct stage_data));
 		}
 		e = item->util;
@@ -345,17 +345,17 @@ struct rename
  * 'b_tree') to be able to associate the correct cache entries with
  * the rename information. 'tree' is always equal to either a_tree or b_tree.
  */
-static struct path_list *get_renames(struct tree *tree,
+static struct string_list *get_renames(struct tree *tree,
 					struct tree *o_tree,
 					struct tree *a_tree,
 					struct tree *b_tree,
-					struct path_list *entries)
+					struct string_list *entries)
 {
 	int i;
-	struct path_list *renames;
+	struct string_list *renames;
 	struct diff_options opts;
 
-	renames = xcalloc(1, sizeof(struct path_list));
+	renames = xcalloc(1, sizeof(struct string_list));
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	opts.detect_rename = DIFF_DETECT_RENAME;
@@ -366,7 +366,7 @@ static struct path_list *get_renames(struct tree *tree,
 	diff_tree_sha1(o_tree->object.sha1, tree->object.sha1, "", &opts);
 	diffcore_std(&opts);
 	for (i = 0; i < diff_queued_diff.nr; ++i) {
-		struct path_list_item *item;
+		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
 		if (pair->status != 'R') {
@@ -376,20 +376,20 @@ static struct path_list *get_renames(struct tree *tree,
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
 		re->pair = pair;
-		item = path_list_lookup(re->pair->one->path, entries);
+		item = string_list_lookup(re->pair->one->path, entries);
 		if (!item)
 			re->src_entry = insert_stage_data(re->pair->one->path,
 					o_tree, a_tree, b_tree, entries);
 		else
 			re->src_entry = item->util;
 
-		item = path_list_lookup(re->pair->two->path, entries);
+		item = string_list_lookup(re->pair->two->path, entries);
 		if (!item)
 			re->dst_entry = insert_stage_data(re->pair->two->path,
 					o_tree, a_tree, b_tree, entries);
 		else
 			re->dst_entry = item->util;
-		item = path_list_insert(pair->one->path, renames);
+		item = string_list_insert(pair->one->path, renames);
 		item->util = re;
 	}
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -466,12 +466,12 @@ static char *unique_path(const char *path, const char *branch)
 	for (; *p; ++p)
 		if ('/' == *p)
 			*p = '_';
-	while (path_list_has_path(&current_file_set, newpath) ||
-	       path_list_has_path(&current_directory_set, newpath) ||
+	while (string_list_has_string(&current_file_set, newpath) ||
+	       string_list_has_string(&current_directory_set, newpath) ||
 	       lstat(newpath, &st) == 0)
 		sprintf(p, "_%d", suffix++);
 
-	path_list_insert(newpath, &current_file_set);
+	string_list_insert(newpath, &current_file_set);
 	return newpath;
 }
 
@@ -716,13 +716,13 @@ static void conflict_rename_rename(struct rename *ren1,
 	const char *ren2_dst = ren2->pair->two->path;
 	const char *dst_name1 = ren1_dst;
 	const char *dst_name2 = ren2_dst;
-	if (path_list_has_path(&current_directory_set, ren1_dst)) {
+	if (string_list_has_string(&current_directory_set, ren1_dst)) {
 		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
 		output(1, "%s is a directory in %s added as %s instead",
 		       ren1_dst, branch2, dst_name1);
 		remove_file(0, ren1_dst, 0);
 	}
-	if (path_list_has_path(&current_directory_set, ren2_dst)) {
+	if (string_list_has_string(&current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
 		output(1, "%s is a directory in %s added as %s instead",
 		       ren2_dst, branch1, dst_name2);
@@ -772,30 +772,30 @@ static void conflict_rename_rename_2(struct rename *ren1,
 	free(new_path1);
 }
 
-static int process_renames(struct path_list *a_renames,
-			   struct path_list *b_renames,
+static int process_renames(struct string_list *a_renames,
+			   struct string_list *b_renames,
 			   const char *a_branch,
 			   const char *b_branch)
 {
 	int clean_merge = 1, i, j;
-	struct path_list a_by_dst = {NULL, 0, 0, 0}, b_by_dst = {NULL, 0, 0, 0};
+	struct string_list a_by_dst = {NULL, 0, 0, 0}, b_by_dst = {NULL, 0, 0, 0};
 	const struct rename *sre;
 
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
-		path_list_insert(sre->pair->two->path, &a_by_dst)->util
+		string_list_insert(sre->pair->two->path, &a_by_dst)->util
 			= sre->dst_entry;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
-		path_list_insert(sre->pair->two->path, &b_by_dst)->util
+		string_list_insert(sre->pair->two->path, &b_by_dst)->util
 			= sre->dst_entry;
 	}
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
 		int compare;
 		char *src;
-		struct path_list *renames1, *renames2, *renames2Dst;
+		struct string_list *renames1, *renames2, *renames2Dst;
 		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branch1, *branch2;
 		const char *ren1_src, *ren1_dst;
@@ -807,8 +807,8 @@ static int process_renames(struct path_list *a_renames,
 			compare = -1;
 			ren1 = a_renames->items[i++].util;
 		} else {
-			compare = strcmp(a_renames->items[i].path,
-					b_renames->items[j].path);
+			compare = strcmp(a_renames->items[i].string,
+					b_renames->items[j].string);
 			if (compare <= 0)
 				ren1 = a_renames->items[i++].util;
 			if (compare >= 0)
@@ -897,7 +897,7 @@ static int process_renames(struct path_list *a_renames,
 			}
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
-			struct path_list_item *item;
+			struct string_list_item *item;
 			/* we only use sha1 and mode of these */
 			struct diff_filespec src_other, dst_other;
 			int try_merge, stage = a_renames == renames1 ? 3: 2;
@@ -911,7 +911,7 @@ static int process_renames(struct path_list *a_renames,
 
 			try_merge = 0;
 
-			if (path_list_has_path(&current_directory_set, ren1_dst)) {
+			if (string_list_has_string(&current_directory_set, ren1_dst)) {
 				clean_merge = 0;
 				output(1, "CONFLICT (rename/directory): Renamed %s->%s in %s "
 				       " directory %s added in %s",
@@ -936,7 +936,7 @@ static int process_renames(struct path_list *a_renames,
 				new_path = unique_path(ren1_dst, branch2);
 				output(1, "Added as %s instead", new_path);
 				update_file(0, dst_other.sha1, dst_other.mode, new_path);
-			} else if ((item = path_list_lookup(ren1_dst, renames2Dst))) {
+			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
@@ -992,8 +992,8 @@ static int process_renames(struct path_list *a_renames,
 			}
 		}
 	}
-	path_list_clear(&a_by_dst, 0);
-	path_list_clear(&b_by_dst, 0);
+	string_list_clear(&a_by_dst, 0);
+	string_list_clear(&b_by_dst, 0);
 
 	return clean_merge;
 }
@@ -1071,7 +1071,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			sha = b_sha;
 			conf = "directory/file";
 		}
-		if (path_list_has_path(&current_directory_set, path)) {
+		if (string_list_has_string(&current_directory_set, path)) {
 			const char *new_path = unique_path(path, add_branch);
 			clean_merge = 0;
 			output(1, "CONFLICT (%s): There is a directory with name %s in %s. "
@@ -1162,10 +1162,10 @@ int merge_trees(struct tree *head,
 		    sha1_to_hex(merge->object.sha1));
 
 	if (unmerged_cache()) {
-		struct path_list *entries, *re_head, *re_merge;
+		struct string_list *entries, *re_head, *re_merge;
 		int i;
-		path_list_clear(&current_file_set, 1);
-		path_list_clear(&current_directory_set, 1);
+		string_list_clear(&current_file_set, 1);
+		string_list_clear(&current_directory_set, 1);
 		get_files_dirs(head);
 		get_files_dirs(merge);
 
@@ -1175,16 +1175,16 @@ int merge_trees(struct tree *head,
 		clean = process_renames(re_head, re_merge,
 				branch1, branch2);
 		for (i = 0; i < entries->nr; i++) {
-			const char *path = entries->items[i].path;
+			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed
 				&& !process_entry(path, e, branch1, branch2))
 				clean = 0;
 		}
 
-		path_list_clear(re_merge, 0);
-		path_list_clear(re_head, 0);
-		path_list_clear(entries, 1);
+		string_list_clear(re_merge, 0);
+		string_list_clear(re_head, 0);
+		string_list_clear(entries, 1);
 
 	}
 	else
diff --git a/builtin-mv.c b/builtin-mv.c
index 68aa2a6..6d22106 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -7,7 +7,7 @@
 #include "builtin.h"
 #include "dir.h"
 #include "cache-tree.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "parse-options.h"
 
 static const char * const builtin_mv_usage[] = {
@@ -40,13 +40,14 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 	return result;
 }
 
-static void show_list(const char *label, struct path_list *list)
+static void show_list(const char *label, struct string_list *list)
 {
 	if (list->nr > 0) {
 		int i;
 		printf("%s", label);
 		for (i = 0; i < list->nr; i++)
-			printf("%s%s", i > 0 ? ", " : "", list->items[i].path);
+			printf("%s%s", i > 0 ? ", " : "",
+					list->items[i].string);
 		putchar('\n');
 	}
 }
@@ -79,11 +80,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	const char **source, **destination, **dest_path;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
-	struct path_list overwritten = {NULL, 0, 0, 0};
-	struct path_list src_for_dst = {NULL, 0, 0, 0};
-	struct path_list added = {NULL, 0, 0, 0};
-	struct path_list deleted = {NULL, 0, 0, 0};
-	struct path_list changed = {NULL, 0, 0, 0};
+	struct string_list overwritten = {NULL, 0, 0, 0};
+	struct string_list src_for_dst = {NULL, 0, 0, 0};
+	struct string_list added = {NULL, 0, 0, 0};
+	struct string_list deleted = {NULL, 0, 0, 0};
+	struct string_list changed = {NULL, 0, 0, 0};
 
 	git_config(git_default_config);
 
@@ -193,16 +194,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 							" will overwrite!\n",
 							bad);
 					bad = NULL;
-					path_list_insert(dst, &overwritten);
+					string_list_insert(dst, &overwritten);
 				} else
 					bad = "Cannot overwrite";
 			}
 		} else if (cache_name_pos(src, length) < 0)
 			bad = "not under version control";
-		else if (path_list_has_path(&src_for_dst, dst))
+		else if (string_list_has_string(&src_for_dst, dst))
 			bad = "multiple sources for the same target";
 		else
-			path_list_insert(dst, &src_for_dst);
+			string_list_insert(dst, &src_for_dst);
 
 		if (bad) {
 			if (ignore_errors) {
@@ -232,15 +233,15 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			continue;
 
 		if (cache_name_pos(src, strlen(src)) >= 0) {
-			path_list_insert(src, &deleted);
+			string_list_insert(src, &deleted);
 
 			/* destination can be a directory with 1 file inside */
-			if (path_list_has_path(&overwritten, dst))
-				path_list_insert(dst, &changed);
+			if (string_list_has_string(&overwritten, dst))
+				string_list_insert(dst, &changed);
 			else
-				path_list_insert(dst, &added);
+				string_list_insert(dst, &added);
 		} else
-			path_list_insert(dst, &added);
+			string_list_insert(dst, &added);
 	}
 
 	if (show_only) {
@@ -249,7 +250,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		show_list("Deleting : ", &deleted);
 	} else {
 		for (i = 0; i < changed.nr; i++) {
-			const char *path = changed.items[i].path;
+			const char *path = changed.items[i].string;
 			int j = cache_name_pos(path, strlen(path));
 			struct cache_entry *ce = active_cache[j];
 
@@ -259,12 +260,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 
 		for (i = 0; i < added.nr; i++) {
-			const char *path = added.items[i].path;
+			const char *path = added.items[i].string;
 			add_file_to_cache(path, verbose);
 		}
 
 		for (i = 0; i < deleted.nr; i++)
-			remove_file_from_cache(deleted.items[i].path);
+			remove_file_from_cache(deleted.items[i].string);
 
 		if (active_cache_changed) {
 			if (write_cache(newfd, active_cache, active_nr) ||
diff --git a/builtin-rerere.c b/builtin-rerere.c
index c607aad..963b19e 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
@@ -23,7 +23,7 @@ static const char *rr_path(const char *name, const char *file)
 	return git_path("rr-cache/%s/%s", name, file);
 }
 
-static void read_rr(struct path_list *rr)
+static void read_rr(struct string_list *rr)
 {
 	unsigned char sha1[20];
 	char buf[PATH_MAX];
@@ -43,18 +43,18 @@ static void read_rr(struct path_list *rr)
 			; /* do nothing */
 		if (i == sizeof(buf))
 			die("filename too long");
-		path_list_insert(buf, rr)->util = xstrdup(name);
+		string_list_insert(buf, rr)->util = xstrdup(name);
 	}
 	fclose(in);
 }
 
 static struct lock_file write_lock;
 
-static int write_rr(struct path_list *rr, int out_fd)
+static int write_rr(struct string_list *rr, int out_fd)
 {
 	int i;
 	for (i = 0; i < rr->nr; i++) {
-		const char *path = rr->items[i].path;
+		const char *path = rr->items[i].string;
 		int length = strlen(path) + 1;
 		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
 		    write_in_full(out_fd, "\t", 1) != 1 ||
@@ -138,7 +138,7 @@ static int handle_file(const char *path,
 	return hunk_no;
 }
 
-static int find_conflict(struct path_list *conflict)
+static int find_conflict(struct string_list *conflict)
 {
 	int i;
 	if (read_cache() < 0)
@@ -151,7 +151,7 @@ static int find_conflict(struct path_list *conflict)
 		    ce_same_name(e2, e3) &&
 		    S_ISREG(e2->ce_mode) &&
 		    S_ISREG(e3->ce_mode)) {
-			path_list_insert((const char *)e2->name, conflict);
+			string_list_insert((const char *)e2->name, conflict);
 			i++; /* skip over both #2 and #3 */
 		}
 	}
@@ -198,9 +198,9 @@ static void unlink_rr_item(const char *name)
 	rmdir(git_path("rr-cache/%s", name));
 }
 
-static void garbage_collect(struct path_list *rr)
+static void garbage_collect(struct string_list *rr)
 {
-	struct path_list to_remove = { NULL, 0, 0, 1 };
+	struct string_list to_remove = { NULL, 0, 0, 1 };
 	char buf[1024];
 	DIR *dir;
 	struct dirent *e;
@@ -226,12 +226,12 @@ static void garbage_collect(struct path_list *rr)
 		cutoff = stat(buf, &st) ? cutoff_noresolve : cutoff_resolve;
 		if (then < now - cutoff * 86400) {
 			buf[len + i] = '\0';
-			path_list_insert(xstrdup(name), &to_remove);
+			string_list_insert(xstrdup(name), &to_remove);
 		}
 	}
 	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].path);
-	path_list_clear(&to_remove, 0);
+		unlink_rr_item(to_remove.items[i].string);
+	string_list_clear(&to_remove, 0);
 }
 
 static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
@@ -267,9 +267,9 @@ static int diff_two(const char *file1, const char *label1,
 	return 0;
 }
 
-static int do_plain_rerere(struct path_list *rr, int fd)
+static int do_plain_rerere(struct string_list *rr, int fd)
 {
-	struct path_list conflict = { NULL, 0, 0, 1 };
+	struct string_list conflict = { NULL, 0, 0, 1 };
 	int i;
 
 	find_conflict(&conflict);
@@ -282,8 +282,8 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 	 */
 
 	for (i = 0; i < conflict.nr; i++) {
-		const char *path = conflict.items[i].path;
-		if (!path_list_has_path(rr, path)) {
+		const char *path = conflict.items[i].string;
+		if (!string_list_has_string(rr, path)) {
 			unsigned char sha1[20];
 			char *hex;
 			int ret;
@@ -291,7 +291,7 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 			if (ret < 1)
 				continue;
 			hex = xstrdup(sha1_to_hex(sha1));
-			path_list_insert(path, rr)->util = hex;
+			string_list_insert(path, rr)->util = hex;
 			if (mkdir(git_path("rr-cache/%s", hex), 0755))
 				continue;;
 			handle_file(path, NULL, rr_path(hex, "preimage"));
@@ -308,7 +308,7 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 	for (i = 0; i < rr->nr; i++) {
 		struct stat st;
 		int ret;
-		const char *path = rr->items[i].path;
+		const char *path = rr->items[i].string;
 		const char *name = (const char *)rr->items[i].util;
 
 		if (!stat(rr_path(name, "preimage"), &st) &&
@@ -372,7 +372,7 @@ static int is_rerere_enabled(void)
 	return 1;
 }
 
-static int setup_rerere(struct path_list *merge_rr)
+static int setup_rerere(struct string_list *merge_rr)
 {
 	int fd;
 
@@ -388,7 +388,7 @@ static int setup_rerere(struct path_list *merge_rr)
 
 int rerere(void)
 {
-	struct path_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = { NULL, 0, 0, 1 };
 	int fd;
 
 	fd = setup_rerere(&merge_rr);
@@ -399,7 +399,7 @@ int rerere(void)
 
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
-	struct path_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = { NULL, 0, 0, 1 };
 	int i, fd;
 
 	fd = setup_rerere(&merge_rr);
@@ -422,16 +422,16 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[1], "status"))
 		for (i = 0; i < merge_rr.nr; i++)
-			printf("%s\n", merge_rr.items[i].path);
+			printf("%s\n", merge_rr.items[i].string);
 	else if (!strcmp(argv[1], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
-			const char *path = merge_rr.items[i].path;
+			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
 			diff_two(rr_path(name, "preimage"), path, path, path);
 		}
 	else
 		usage(git_rerere_usage);
 
-	path_list_clear(&merge_rr, 1);
+	string_list_clear(&merge_rr, 1);
 	return 0;
 }
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index af31aba..fe37515 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "diff.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "revision.h"
 #include "utf8.h"
 #include "mailmap.h"
@@ -13,8 +13,8 @@ static const char shortlog_usage[] =
 
 static int compare_by_number(const void *a1, const void *a2)
 {
-	const struct path_list_item *i1 = a1, *i2 = a2;
-	const struct path_list *l1 = i1->util, *l2 = i2->util;
+	const struct string_list_item *i1 = a1, *i2 = a2;
+	const struct string_list *l1 = i1->util, *l2 = i2->util;
 
 	if (l1->nr < l2->nr)
 		return 1;
@@ -30,8 +30,8 @@ static void insert_one_record(struct shortlog *log,
 {
 	const char *dot3 = log->common_repo_prefix;
 	char *buffer, *p;
-	struct path_list_item *item;
-	struct path_list *onelines;
+	struct string_list_item *item;
+	struct string_list *onelines;
 	char namebuf[1024];
 	size_t len;
 	const char *eol;
@@ -64,9 +64,9 @@ static void insert_one_record(struct shortlog *log,
 	}
 
 	buffer = xstrdup(namebuf);
-	item = path_list_insert(buffer, &log->list);
+	item = string_list_insert(buffer, &log->list);
 	if (item->util == NULL)
-		item->util = xcalloc(1, sizeof(struct path_list));
+		item->util = xcalloc(1, sizeof(struct string_list));
 	else
 		free(buffer);
 
@@ -103,11 +103,11 @@ static void insert_one_record(struct shortlog *log,
 		onelines->alloc = alloc_nr(onelines->nr);
 		onelines->items = xrealloc(onelines->items,
 				onelines->alloc
-				* sizeof(struct path_list_item));
+				* sizeof(struct string_list_item));
 	}
 
 	onelines->items[onelines->nr].util = NULL;
-	onelines->items[onelines->nr++].path = buffer;
+	onelines->items[onelines->nr++].string = buffer;
 }
 
 static void read_from_stdin(struct shortlog *log)
@@ -218,7 +218,7 @@ void shortlog_init(struct shortlog *log)
 
 	read_mailmap(&log->mailmap, ".mailmap", &log->common_repo_prefix);
 
-	log->list.strdup_paths = 1;
+	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
@@ -274,17 +274,17 @@ void shortlog_output(struct shortlog *log)
 {
 	int i, j;
 	if (log->sort_by_number)
-		qsort(log->list.items, log->list.nr, sizeof(struct path_list_item),
+		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
 			compare_by_number);
 	for (i = 0; i < log->list.nr; i++) {
-		struct path_list *onelines = log->list.items[i].util;
+		struct string_list *onelines = log->list.items[i].util;
 
 		if (log->summary) {
-			printf("%6d\t%s\n", onelines->nr, log->list.items[i].path);
+			printf("%6d\t%s\n", onelines->nr, log->list.items[i].string);
 		} else {
-			printf("%s (%d):\n", log->list.items[i].path, onelines->nr);
+			printf("%s (%d):\n", log->list.items[i].string, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--) {
-				const char *msg = onelines->items[j].path;
+				const char *msg = onelines->items[j].string;
 
 				if (log->wrap_lines) {
 					int col = print_wrapped_text(msg, log->in1, log->in2, log->wrap);
@@ -297,14 +297,14 @@ void shortlog_output(struct shortlog *log)
 			putchar('\n');
 		}
 
-		onelines->strdup_paths = 1;
-		path_list_clear(onelines, 1);
+		onelines->strdup_strings = 1;
+		string_list_clear(onelines, 1);
 		free(onelines);
 		log->list.items[i].util = NULL;
 	}
 
-	log->list.strdup_paths = 1;
-	path_list_clear(&log->list, 1);
-	log->mailmap.strdup_paths = 1;
-	path_list_clear(&log->mailmap, 1);
+	log->list.strdup_strings = 1;
+	string_list_clear(&log->list, 1);
+	log->mailmap.strdup_strings = 1;
+	string_list_clear(&log->mailmap, 1);
 }
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index a323633..add1600 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -3,7 +3,7 @@
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
-#include "path-list.h"
+#include "string-list.h"
 
 static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] < ref-list";
 
@@ -98,8 +98,8 @@ match:
 
 static int add_existing(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
 {
-	struct path_list *list = (struct path_list *)cbdata;
-	path_list_insert(refname, list);
+	struct string_list *list = (struct string_list *)cbdata;
+	string_list_insert(refname, list);
 	return 0;
 }
 
@@ -114,7 +114,7 @@ static int add_existing(const char *refname, const unsigned char *sha1, int flag
  */
 static int exclude_existing(const char *match)
 {
-	static struct path_list existing_refs = { NULL, 0, 0, 0 };
+	static struct string_list existing_refs = { NULL, 0, 0, 0 };
 	char buf[1024];
 	int matchlen = match ? strlen(match) : 0;
 
@@ -143,7 +143,7 @@ static int exclude_existing(const char *match)
 			fprintf(stderr, "warning: ref '%s' ignored\n", ref);
 			continue;
 		}
-		if (!path_list_has_path(&existing_refs, ref)) {
+		if (!string_list_has_string(&existing_refs, ref)) {
 			printf("%s\n", buf);
 		}
 	}
diff --git a/diff-lib.c b/diff-lib.c
index 94b150e..42e012f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -8,14 +8,14 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "cache-tree.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "unpack-trees.h"
 
 /*
  * diff-files
  */
 
-static int read_directory(const char *path, struct path_list *list)
+static int read_directory(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -25,7 +25,7 @@ static int read_directory(const char *path, struct path_list *list)
 
 	while ((e = readdir(dir)))
 		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
-			path_list_insert(e->d_name, list);
+			string_list_insert(e->d_name, list);
 
 	closedir(dir);
 	return 0;
@@ -59,13 +59,13 @@ static int queue_diff(struct diff_options *o,
 
 	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
 		char buffer1[PATH_MAX], buffer2[PATH_MAX];
-		struct path_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
+		struct string_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
 		int len1 = 0, len2 = 0, i1, i2, ret = 0;
 
 		if (name1 && read_directory(name1, &p1))
 			return -1;
 		if (name2 && read_directory(name2, &p2)) {
-			path_list_clear(&p1, 0);
+			string_list_clear(&p1, 0);
 			return -1;
 		}
 
@@ -94,14 +94,14 @@ static int queue_diff(struct diff_options *o,
 			else if (i2 == p2.nr)
 				comp = -1;
 			else
-				comp = strcmp(p1.items[i1].path,
-					p2.items[i2].path);
+				comp = strcmp(p1.items[i1].string,
+					p2.items[i2].string);
 
 			if (comp > 0)
 				n1 = NULL;
 			else {
 				n1 = buffer1;
-				strncpy(buffer1 + len1, p1.items[i1++].path,
+				strncpy(buffer1 + len1, p1.items[i1++].string,
 						PATH_MAX - len1);
 			}
 
@@ -109,14 +109,14 @@ static int queue_diff(struct diff_options *o,
 				n2 = NULL;
 			else {
 				n2 = buffer2;
-				strncpy(buffer2 + len2, p2.items[i2++].path,
+				strncpy(buffer2 + len2, p2.items[i2++].string,
 						PATH_MAX - len2);
 			}
 
 			ret = queue_diff(o, n1, n2);
 		}
-		path_list_clear(&p1, 0);
-		path_list_clear(&p2, 0);
+		string_list_clear(&p1, 0);
+		string_list_clear(&p2, 0);
 
 		return ret;
 	} else {
diff --git a/mailmap.c b/mailmap.c
index f017255..88fc6f3 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,8 +1,8 @@
 #include "cache.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "mailmap.h"
 
-int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev)
+int read_mailmap(struct string_list *map, const char *filename, char **repo_abbrev)
 {
 	char buffer[1024];
 	FILE *f = fopen(filename, "r");
@@ -54,16 +54,16 @@ int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev
 		for (i = 0; i < right_bracket - left_bracket - 1; i++)
 			email[i] = tolower(left_bracket[i + 1]);
 		email[right_bracket - left_bracket - 1] = '\0';
-		path_list_insert(email, map)->util = name;
+		string_list_insert(email, map)->util = name;
 	}
 	fclose(f);
 	return 0;
 }
 
-int map_email(struct path_list *map, const char *email, char *name, int maxlen)
+int map_email(struct string_list *map, const char *email, char *name, int maxlen)
 {
 	char *p;
-	struct path_list_item *item;
+	struct string_list_item *item;
 	char buf[1024], *mailbuf;
 	int i;
 
@@ -80,7 +80,7 @@ int map_email(struct path_list *map, const char *email, char *name, int maxlen)
 	for (i = 0; i < p - email; i++)
 		mailbuf[i] = tolower(email[i]);
 	mailbuf[i] = 0;
-	item = path_list_lookup(mailbuf, map);
+	item = string_list_lookup(mailbuf, map);
 	if (mailbuf != buf)
 		free(mailbuf);
 	if (item != NULL) {
diff --git a/mailmap.h b/mailmap.h
index 3503fd2..6e48f83 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,7 +1,7 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
 
-int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev);
-int map_email(struct path_list *mailmap, const char *email, char *name, int maxlen);
+int read_mailmap(struct string_list *map, const char *filename, char **repo_abbrev);
+int map_email(struct string_list *mailmap, const char *email, char *name, int maxlen);
 
 #endif
diff --git a/path-list.h b/path-list.h
deleted file mode 100644
index 5931e2c..0000000
--- a/path-list.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef PATH_LIST_H
-#define PATH_LIST_H
-
-struct path_list_item {
-	char *path;
-	void *util;
-};
-struct path_list
-{
-	struct path_list_item *items;
-	unsigned int nr, alloc;
-	unsigned int strdup_paths:1;
-};
-
-void print_path_list(const char *text, const struct path_list *p);
-
-int path_list_has_path(const struct path_list *list, const char *path);
-void path_list_clear(struct path_list *list, int free_util);
-struct path_list_item *path_list_insert(const char *path, struct path_list *list);
-struct path_list_item *path_list_lookup(const char *path, struct path_list *list);
-
-#endif /* PATH_LIST_H */
diff --git a/reflog-walk.c b/reflog-walk.c
index ee1456b..f751fdc 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -3,7 +3,7 @@
 #include "refs.h"
 #include "diff.h"
 #include "revision.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "reflog-walk.h"
 
 struct complete_reflogs {
@@ -127,7 +127,7 @@ struct commit_reflog {
 
 struct reflog_walk_info {
 	struct commit_info_lifo reflogs;
-	struct path_list complete_reflogs;
+	struct string_list complete_reflogs;
 	struct commit_reflog *last_commit_reflog;
 };
 
@@ -141,7 +141,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 {
 	unsigned long timestamp = 0;
 	int recno = -1;
-	struct path_list_item *item;
+	struct string_list_item *item;
 	struct complete_reflogs *reflogs;
 	char *branch, *at = strchr(name, '@');
 	struct commit_reflog *commit_reflog;
@@ -161,7 +161,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	} else
 		recno = 0;
 
-	item = path_list_lookup(branch, &info->complete_reflogs);
+	item = string_list_lookup(branch, &info->complete_reflogs);
 	if (item)
 		reflogs = item->util;
 	else {
@@ -189,7 +189,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		}
 		if (!reflogs || reflogs->nr == 0)
 			return -1;
-		path_list_insert(branch, &info->complete_reflogs)->util
+		string_list_insert(branch, &info->complete_reflogs)->util
 			= reflogs;
 	}
 
diff --git a/shortlog.h b/shortlog.h
index 31ff491..46a0991 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -1,10 +1,10 @@
 #ifndef SHORTLOG_H
 #define SHORTLOG_H
 
-#include "path-list.h"
+#include "string-list.h"
 
 struct shortlog {
-	struct path_list list;
+	struct string_list list;
 	int summary;
 	int wrap_lines;
 	int sort_by_number;
@@ -14,7 +14,7 @@ struct shortlog {
 
 	char *common_repo_prefix;
 	int email;
-	struct path_list mailmap;
+	struct string_list mailmap;
 };
 
 void shortlog_init(struct shortlog *log);
diff --git a/path-list.c b/string-list.c
similarity index 53%
rename from path-list.c
rename to string-list.c
index 3d83b7b..699e754 100644
--- a/path-list.c
+++ b/string-list.c
@@ -1,16 +1,16 @@
 #include "cache.h"
-#include "path-list.h"
+#include "string-list.h"
 
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
-static int get_entry_index(const struct path_list *list, const char *path,
+static int get_entry_index(const struct string_list *list, const char *string,
 		int *exact_match)
 {
 	int left = -1, right = list->nr;
 
 	while (left + 1 < right) {
 		int middle = (left + right) / 2;
-		int compare = strcmp(path, list->items[middle].path);
+		int compare = strcmp(string, list->items[middle].string);
 		if (compare < 0)
 			right = middle;
 		else if (compare > 0)
@@ -26,10 +26,10 @@ static int get_entry_index(const struct path_list *list, const char *path,
 }
 
 /* returns -1-index if already exists */
-static int add_entry(struct path_list *list, const char *path)
+static int add_entry(struct string_list *list, const char *string)
 {
 	int exact_match;
-	int index = get_entry_index(list, path, &exact_match);
+	int index = get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
 		return -1 - index;
@@ -37,23 +37,23 @@ static int add_entry(struct path_list *list, const char *path)
 	if (list->nr + 1 >= list->alloc) {
 		list->alloc += 32;
 		list->items = xrealloc(list->items, list->alloc
-				* sizeof(struct path_list_item));
+				* sizeof(struct string_list_item));
 	}
 	if (index < list->nr)
 		memmove(list->items + index + 1, list->items + index,
 				(list->nr - index)
-				* sizeof(struct path_list_item));
-	list->items[index].path = list->strdup_paths ?
-		xstrdup(path) : (char *)path;
+				* sizeof(struct string_list_item));
+	list->items[index].string = list->strdup_strings ?
+		xstrdup(string) : (char *)string;
 	list->items[index].util = NULL;
 	list->nr++;
 
 	return index;
 }
 
-struct path_list_item *path_list_insert(const char *path, struct path_list *list)
+struct string_list_item *string_list_insert(const char *string, struct string_list *list)
 {
-	int index = add_entry(list, path);
+	int index = add_entry(list, string);
 
 	if (index < 0)
 		index = -1 - index;
@@ -61,28 +61,28 @@ struct path_list_item *path_list_insert(const char *path, struct path_list *list
 	return list->items + index;
 }
 
-int path_list_has_path(const struct path_list *list, const char *path)
+int string_list_has_string(const struct string_list *list, const char *string)
 {
 	int exact_match;
-	get_entry_index(list, path, &exact_match);
+	get_entry_index(list, string, &exact_match);
 	return exact_match;
 }
 
-struct path_list_item *path_list_lookup(const char *path, struct path_list *list)
+struct string_list_item *string_list_lookup(const char *string, struct string_list *list)
 {
-	int exact_match, i = get_entry_index(list, path, &exact_match);
+	int exact_match, i = get_entry_index(list, string, &exact_match);
 	if (!exact_match)
 		return NULL;
 	return list->items + i;
 }
 
-void path_list_clear(struct path_list *list, int free_util)
+void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
 		int i;
-		if (list->strdup_paths) {
+		if (list->strdup_strings) {
 			for (i = 0; i < list->nr; i++)
-				free(list->items[i].path);
+				free(list->items[i].string);
 		}
 		if (free_util) {
 			for (i = 0; i < list->nr; i++)
@@ -94,11 +94,12 @@ void path_list_clear(struct path_list *list, int free_util)
 	list->nr = list->alloc = 0;
 }
 
-void print_path_list(const char *text, const struct path_list *p)
+void print_string_list(const char *text, const struct string_list *p)
 {
 	int i;
 	if ( text )
 		printf("%s\n", text);
 	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].path, p->items[i].util);
+		printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
+
diff --git a/string-list.h b/string-list.h
new file mode 100644
index 0000000..6195791
--- /dev/null
+++ b/string-list.h
@@ -0,0 +1,22 @@
+#ifndef PATH_LIST_H
+#define PATH_LIST_H
+
+struct string_list_item {
+	char *string;
+	void *util;
+};
+struct string_list
+{
+	struct string_list_item *items;
+	unsigned int nr, alloc;
+	unsigned int strdup_strings:1;
+};
+
+void print_string_list(const char *text, const struct string_list *p);
+
+int string_list_has_string(const struct string_list *list, const char *string);
+void string_list_clear(struct string_list *list, int free_util);
+struct string_list_item *string_list_insert(const char *string, struct string_list *list);
+struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
+
+#endif /* PATH_LIST_H */
-- 
1.5.4.3.446.gbe8932



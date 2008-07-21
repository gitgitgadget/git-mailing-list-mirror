From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH for master] Rename path_list to string_list
Date: Mon, 21 Jul 2008 19:03:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807211858330.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 21 20:05:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzkm-0007GN-7y
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbYGUSDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYGUSDz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:03:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:56115 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750794AbYGUSDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:03:51 -0400
Received: (qmail invoked by alias); 21 Jul 2008 18:03:48 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp024) with SMTP; 21 Jul 2008 20:03:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DyOI9M9DDyFon6ZjIL8cwgUsmYCmLk+dzEJ9XCf
	3zSpqbXs5hgQX1
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89372>


The name path_list was correct for the first usage of that data structure,
but it really is a general-purpose string list.

$ perl -i -pe 's/path-list/string-list/g' $(git grep -l path-list)
$ perl -i -pe 's/path_list/string_list/g' $(git grep -l path_list)
$ git mv path-list.h string-list.h
$ git mv path-list.c string-list.c
$ perl -i -pe 's/has_path/has_string/g' $(git grep -l has_path)
$ perl -i -pe 's/path/string/g' string-list.[ch]
$ git mv Documentation/technical/api-path-list.txt \
	Documentation/technical/api-string-list.txt
$ perl -i -pe 's/strdup_paths/strdup_strings/g' $(git grep -l strdup_paths)

... and then fix all users of string-list to access the member "string"
instead of "path".

Documentation/technical/api-string-list.txt needed some rewrapping, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Since master and next are not far apart currently...

	Will reply with the interdiff between the tree after said commands 
	and the tree with this patch, i.e. the non-automatic replacements.

 Documentation/CodingGuidelines              |    2 +-
 Documentation/technical/api-path-list.txt   |  126 -------------------------
 Documentation/technical/api-string-list.txt |  128 +++++++++++++++++++++++++
 Makefile                                    |    4 +-
 builtin-apply.c                             |   16 ++--
 builtin-blame.c                             |   10 +-
 builtin-commit.c                            |   20 ++--
 builtin-fast-export.c                       |   14 ++--
 builtin-fetch.c                             |   20 ++--
 builtin-mailsplit.c                         |   12 +-
 builtin-merge-recursive.c                   |   96 ++++++++++----------
 builtin-mv.c                                |   39 ++++----
 builtin-remote.c                            |  124 ++++++++++++------------
 builtin-rerere.c                            |   20 ++--
 builtin-shortlog.c                          |   42 ++++----
 builtin-show-ref.c                          |   10 +-
 diff-no-index.c                             |   22 ++--
 mailmap.c                                   |   12 +-
 mailmap.h                                   |    4 +-
 path-list.c                                 |  134 ---------------------------
 path-list.h                                 |   28 ------
 pretty.c                                    |    4 +-
 reflog-walk.c                               |   10 +-
 rerere.c                                    |   40 ++++----
 rerere.h                                    |    4 +-
 shortlog.h                                  |    6 +-
 string-list.c                               |  134 +++++++++++++++++++++++++++
 string-list.h                               |   28 ++++++
 28 files changed, 556 insertions(+), 553 deletions(-)
 delete mode 100644 Documentation/technical/api-path-list.txt
 create mode 100644 Documentation/technical/api-string-list.txt
 delete mode 100644 path-list.c
 delete mode 100644 path-list.h
 create mode 100644 string-list.c
 create mode 100644 string-list.h

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index d2a0a76..f628c1f 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -105,7 +105,7 @@ For C programs:
 
  - Use the API.  No, really.  We have a strbuf (variable length
    string), several arrays with the ALLOC_GROW() macro, a
-   path_list for sorted string lists, a hash map (mapping struct
+   string_list for sorted string lists, a hash map (mapping struct
    objects) named "struct decorate", amongst other things.
 
  - When you come up with an API, document it.
diff --git a/Documentation/technical/api-path-list.txt b/Documentation/technical/api-path-list.txt
deleted file mode 100644
index 9dbedd0..0000000
--- a/Documentation/technical/api-path-list.txt
+++ /dev/null
@@ -1,126 +0,0 @@
-path-list API
-=============
-
-The path_list API offers a data structure and functions to handle sorted
-and unsorted string lists.
-
-The name is a bit misleading, a path_list may store not only paths but
-strings in general.
-
-The caller:
-
-. Allocates and clears a `struct path_list` variable.
-
-. Initializes the members. You might want to set the flag `strdup_paths`
-  if the strings should be strdup()ed. For example, this is necessary
-  when you add something like git_path("..."), since that function returns
-  a static buffer that will change with the next call to git_path().
-+
-If you need something advanced, you can manually malloc() the `items`
-member (you need this if you add things later) and you should set the
-`nr` and `alloc` members in that case, too.
-
-. Adds new items to the list, using `path_list_append` or `path_list_insert`.
-
-. Can check if a string is in the list using `path_list_has_path` or
-  `unsorted_path_list_has_path` and get it from the list using
-  `path_list_lookup` for sorted lists.
-
-. Can sort an unsorted list using `sort_path_list`.
-
-. Finally it should free the list using `path_list_clear`.
-
-Example:
-
-----
-struct path_list list;
-int i;
-
-memset(&list, 0, sizeof(struct path_list));
-path_list_append("foo", &list);
-path_list_append("bar", &list);
-for (i = 0; i < list.nr; i++)
-	printf("%s\n", list.items[i].path)
-----
-
-NOTE: It is more efficient to build an unsorted list and sort it
-afterwards, instead of building a sorted list (`O(n log n)` instead of
-`O(n^2)`).
-+
-However, if you use the list to check if a certain string was added
-already, you should not do that (using unsorted_path_list_has_path()),
-because the complexity would be quadratic again (but with a worse factor).
-
-Functions
----------
-
-* General ones (works with sorted and unsorted lists as well)
-
-`print_path_list`::
-
-	Dump a path_list to stdout, useful mainly for debugging purposes. It
-	can take an optional header argument and it writes out the
-	string-pointer pairs of the path_list, each one in its own line.
-
-`path_list_clear`::
-
-	Free a path_list. The `path` pointer of the items will be freed in case
-	the `strdup_paths` member of the path_list is set. The second parameter
-	controls if the `util` pointer of the items should be freed or not.
-
-* Functions for sorted lists only
-
-`path_list_has_path`::
-
-	Determine if the path_list has a given string or not.
-
-`path_list_insert`::
-
-	Insert a new element to the path_list. The returned pointer can be handy
-	if you want to write something to the `util` pointer of the
-	path_list_item containing the just added string.
-+
-Since this function uses xrealloc() (which die()s if it fails) if the
-list needs to grow, it is safe not to check the pointer. I.e. you may
-write `path_list_insert(...)->util = ...;`.
-
-`path_list_lookup`::
-
-	Look up a given string in the path_list, returning the containing
-	path_list_item. If the string is not found, NULL is returned.
-
-* Functions for unsorted lists only
-
-`path_list_append`::
-
-	Append a new string to the end of the path_list.
-
-`sort_path_list`::
-
-	Make an unsorted list sorted.
-
-`unsorted_path_list_has_path`::
-
-	It's like `path_list_has_path()` but for unsorted lists.
-+
-This function needs to look through all items, as opposed to its
-counterpart for sorted lists, which performs a binary search.
-
-Data structures
----------------
-
-* `struct path_list_item`
-
-Represents an item of the list. The `path` member is a pointer to the
-string, and you may use the `util` member for any purpose, if you want.
-
-* `struct path_list`
-
-Represents the list itself.
-
-. The array of items are available via the `items` member.
-. The `nr` member contains the number of items stored in the list.
-. The `alloc` member is used to avoid reallocating at every insertion.
-  You should not tamper with it.
-. Setting the `strdup_paths` member to 1 will strdup() the strings
-  before adding them, see above.
diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
new file mode 100644
index 0000000..8557f9a
--- /dev/null
+++ b/Documentation/technical/api-string-list.txt
@@ -0,0 +1,128 @@
+string-list API
+===============
+
+The string_list API offers a data structure and functions to handle sorted
+and unsorted string lists.
+
+The 'string_list' struct used to be called 'path_list', but was renamed
+because it is not specific to paths.
+
+The caller:
+
+. Allocates and clears a `struct string_list` variable.
+
+. Initializes the members. You might want to set the flag `strdup_strings`
+  if the strings should be strdup()ed. For example, this is necessary
+  when you add something like git_path("..."), since that function returns
+  a static buffer that will change with the next call to git_path().
++
+If you need something advanced, you can manually malloc() the `items`
+member (you need this if you add things later) and you should set the
+`nr` and `alloc` members in that case, too.
+
+. Adds new items to the list, using `string_list_append` or
+  `string_list_insert`.
+
+. Can check if a string is in the list using `string_list_has_string` or
+  `unsorted_string_list_has_string` and get it from the list using
+  `string_list_lookup` for sorted lists.
+
+. Can sort an unsorted list using `sort_string_list`.
+
+. Finally it should free the list using `string_list_clear`.
+
+Example:
+
+----
+struct string_list list;
+int i;
+
+memset(&list, 0, sizeof(struct string_list));
+string_list_append("foo", &list);
+string_list_append("bar", &list);
+for (i = 0; i < list.nr; i++)
+	printf("%s\n", list.items[i].path)
+----
+
+NOTE: It is more efficient to build an unsorted list and sort it
+afterwards, instead of building a sorted list (`O(n log n)` instead of
+`O(n^2)`).
++
+However, if you use the list to check if a certain string was added
+already, you should not do that (using unsorted_string_list_has_string()),
+because the complexity would be quadratic again (but with a worse factor).
+
+Functions
+---------
+
+* General ones (works with sorted and unsorted lists as well)
+
+`print_string_list`::
+
+	Dump a string_list to stdout, useful mainly for debugging purposes. It
+	can take an optional header argument and it writes out the
+	string-pointer pairs of the string_list, each one in its own line.
+
+`string_list_clear`::
+
+	Free a string_list. The `path` pointer of the items will be freed in
+	case the `strdup_strings` member of the string_list is set. The second
+	parameter controls if the `util` pointer of the items should be freed
+	or not.
+
+* Functions for sorted lists only
+
+`string_list_has_string`::
+
+	Determine if the string_list has a given string or not.
+
+`string_list_insert`::
+
+	Insert a new element to the string_list. The returned pointer can be
+	handy if you want to write something to the `util` pointer of the
+	string_list_item containing the just added string.
++
+Since this function uses xrealloc() (which die()s if it fails) if the
+list needs to grow, it is safe not to check the pointer. I.e. you may
+write `string_list_insert(...)->util = ...;`.
+
+`string_list_lookup`::
+
+	Look up a given string in the string_list, returning the containing
+	string_list_item. If the string is not found, NULL is returned.
+
+* Functions for unsorted lists only
+
+`string_list_append`::
+
+	Append a new string to the end of the string_list.
+
+`sort_string_list`::
+
+	Make an unsorted list sorted.
+
+`unsorted_string_list_has_string`::
+
+	It's like `string_list_has_string()` but for unsorted lists.
++
+This function needs to look through all items, as opposed to its
+counterpart for sorted lists, which performs a binary search.
+
+Data structures
+---------------
+
+* `struct string_list_item`
+
+Represents an item of the list. The `path` member is a pointer to the
+string, and you may use the `util` member for any purpose, if you want.
+
+* `struct string_list`
+
+Represents the list itself.
+
+. The array of items are available via the `items` member.
+. The `nr` member contains the number of items stored in the list.
+. The `alloc` member is used to avoid reallocating at every insertion.
+  You should not tamper with it.
+. Setting the `strdup_strings` member to 1 will strdup() the strings
+  before adding them, see above.
diff --git a/Makefile b/Makefile
index 4ce7053..bd2ae64 100644
--- a/Makefile
+++ b/Makefile
@@ -356,7 +356,7 @@ LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
-LIB_H += path-list.h
+LIB_H += string-list.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
 LIB_H += quote.h
@@ -437,7 +437,7 @@ LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
-LIB_OBJS += path-list.o
+LIB_OBJS += string-list.o
 LIB_OBJS += path.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += pretty.o
diff --git a/builtin-apply.c b/builtin-apply.c
index e15471b..2216a0b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -12,7 +12,7 @@
 #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
-#include "path-list.h"
+#include "string-list.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -194,7 +194,7 @@ struct image {
  * the case where more than one patches touch the same file.
  */
 
-static struct path_list fn_table;
+static struct string_list fn_table;
 
 static uint32_t hash_line(const char *cp, size_t len)
 {
@@ -2250,12 +2250,12 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 
 static struct patch *in_fn_table(const char *name)
 {
-	struct path_list_item *item;
+	struct string_list_item *item;
 
 	if (name == NULL)
 		return NULL;
 
-	item = path_list_lookup(name, &fn_table);
+	item = string_list_lookup(name, &fn_table);
 	if (item != NULL)
 		return (struct patch *)item->util;
 
@@ -2264,7 +2264,7 @@ static struct patch *in_fn_table(const char *name)
 
 static void add_to_fn_table(struct patch *patch)
 {
-	struct path_list_item *item;
+	struct string_list_item *item;
 
 	/*
 	 * Always add new_name unless patch is a deletion
@@ -2272,7 +2272,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * file creations and copies
 	 */
 	if (patch->new_name != NULL) {
-		item = path_list_insert(patch->new_name, &fn_table);
+		item = string_list_insert(patch->new_name, &fn_table);
 		item->util = patch;
 	}
 
@@ -2281,7 +2281,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * later chunks shouldn't patch old names
 	 */
 	if ((patch->new_name == NULL) || (patch->is_rename)) {
-		item = path_list_insert(patch->old_name, &fn_table);
+		item = string_list_insert(patch->old_name, &fn_table);
 		item->util = (struct patch *) -1;
 	}
 }
@@ -3051,7 +3051,7 @@ static int apply_patch(int fd, const char *filename, int options)
 	int skipped_patch = 0;
 
 	/* FIXME - memory leak when using multiple patch files as inputs */
-	memset(&fn_table, 0, sizeof(struct path_list));
+	memset(&fn_table, 0, sizeof(struct string_list));
 	strbuf_init(&buf, 0);
 	patch_input_file = filename;
 	read_patch_file(&buf, fd);
diff --git a/builtin-blame.c b/builtin-blame.c
index 9bced3b..8b6b09b 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -16,7 +16,7 @@
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "cache-tree.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "mailmap.h"
 #include "parse-options.h"
 
@@ -40,7 +40,7 @@ static int blank_boundary;
 static int incremental;
 static int cmd_is_annotate;
 static int xdl_opts = XDF_NEED_MINIMAL;
-static struct path_list mailmap;
+static struct string_list mailmap;
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -1926,7 +1926,7 @@ static void sanity_check_refcnt(struct scoreboard *sb)
  * Used for the command line parsing; check if the path exists
  * in the working tree.
  */
-static int has_path_in_work_tree(const char *path)
+static int has_string_in_work_tree(const char *path)
 {
 	struct stat st;
 	return !lstat(path, &st);
@@ -2390,14 +2390,14 @@ parse_done:
 		if (argc < 2)
 			usage_with_options(blame_opt_usage, options);
 		path = add_prefix(prefix, argv[argc - 1]);
-		if (argc == 3 && !has_path_in_work_tree(path)) { /* (2b) */
+		if (argc == 3 && !has_string_in_work_tree(path)) { /* (2b) */
 			path = add_prefix(prefix, argv[1]);
 			argv[1] = argv[2];
 		}
 		argv[argc - 1] = "--";
 
 		setup_work_tree();
-		if (!has_path_in_work_tree(path))
+		if (!has_string_in_work_tree(path))
 			die("cannot stat path %s: %s", path, strerror(errno));
 	}
 
diff --git a/builtin-commit.c b/builtin-commit.c
index ed3fe3f..97e64de 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -21,7 +21,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
 
@@ -150,7 +150,7 @@ static int commit_index_files(void)
  * Take a union of paths in the index and the named tree (typically, "HEAD"),
  * and return the paths that match the given pattern in list.
  */
-static int list_paths(struct path_list *list, const char *with_tree,
+static int list_paths(struct string_list *list, const char *with_tree,
 		      const char *prefix, const char **pattern)
 {
 	int i;
@@ -169,24 +169,24 @@ static int list_paths(struct path_list *list, const char *with_tree,
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
 		struct stat st;
-		struct path_list_item *p = &(list->items[i]);
+		struct string_list_item *p = &(list->items[i]);
 
-		if (!lstat(p->path, &st)) {
-			if (add_to_cache(p->path, &st, 0))
+		if (!lstat(p->string, &st)) {
+			if (add_to_cache(p->string, &st, 0))
 				die("updating files failed");
 		} else
-			remove_file_from_cache(p->path);
+			remove_file_from_cache(p->string);
 	}
 }
 
@@ -221,7 +221,7 @@ static void create_base_index(void)
 static char *prepare_index(int argc, const char **argv, const char *prefix)
 {
 	int fd;
-	struct path_list partial;
+	struct string_list partial;
 	const char **pathspec = NULL;
 
 	if (interactive) {
@@ -305,7 +305,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		die("cannot do a partial commit during a merge.");
 
 	memset(&partial, 0, sizeof(partial));
-	partial.strdup_paths = 1;
+	partial.strdup_strings = 1;
 	if (list_paths(&partial, initial_commit ? NULL : "HEAD", prefix, pathspec))
 		exit(1);
 
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index a443d59..e508ced 100644
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
 
@@ -309,7 +309,7 @@ static void handle_tag(const char *name, struct tag *tag)
 }
 
 static void get_tags_and_duplicates(struct object_array *pending,
-				    struct path_list *extra_refs)
+				    struct string_list *extra_refs)
 {
 	struct tag *tag;
 	int i;
@@ -330,7 +330,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		case OBJ_TAG:
 			tag = (struct tag *)e->item;
 			while (tag && tag->object.type == OBJ_TAG) {
-				path_list_insert(full_name, extra_refs)->util = tag;
+				string_list_insert(full_name, extra_refs)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
 			if (!tag)
@@ -350,19 +350,19 @@ static void get_tags_and_duplicates(struct object_array *pending,
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
@@ -445,7 +445,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = { 0, 0, NULL };
-	struct path_list extra_refs = { NULL, 0, 0, 0 };
+	struct string_list extra_refs = { NULL, 0, 0, 0 };
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	struct option options[] = {
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 61de50a..7eec4a0 100644
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
@@ -465,8 +465,8 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 static int add_existing(const char *refname, const unsigned char *sha1,
 			int flag, void *cbdata)
 {
-	struct path_list *list = (struct path_list *)cbdata;
-	path_list_insert(refname, list);
+	struct string_list *list = (struct string_list *)cbdata;
+	string_list_insert(refname, list);
 	return 0;
 }
 
@@ -485,8 +485,8 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
-	struct path_list existing_refs = { NULL, 0, 0, 0 };
-	struct path_list new_refs = { NULL, 0, 0, 1 };
+	struct string_list existing_refs = { NULL, 0, 0, 0 };
+	struct string_list new_refs = { NULL, 0, 0, 1 };
 	char *ref_name;
 	int ref_name_len;
 	const unsigned char *ref_sha1;
@@ -515,11 +515,11 @@ static void find_non_local_tags(struct transport *transport,
 			}
 		}
 
-		if (!path_list_has_path(&existing_refs, ref_name) &&
-		    !path_list_has_path(&new_refs, ref_name) &&
+		if (!string_list_has_string(&existing_refs, ref_name) &&
+		    !string_list_has_string(&new_refs, ref_name) &&
 		    (has_sha1_file(ref->old_sha1) ||
 		     will_fetch(head, ref->old_sha1))) {
-			path_list_insert(ref_name, &new_refs);
+			string_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref_from_str(ref_name);
 			rm->peer_ref = alloc_ref_from_str(ref_name);
@@ -530,8 +530,8 @@ static void find_non_local_tags(struct transport *transport,
 		}
 		free(ref_name);
 	}
-	path_list_clear(&existing_refs, 0);
-	path_list_clear(&new_refs, 0);
+	string_list_clear(&existing_refs, 0);
+	string_list_clear(&new_refs, 0);
 }
 
 static int do_fetch(struct transport *transport,
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 13c60c3..71f3b3b 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -6,7 +6,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
-#include "path-list.h"
+#include "string-list.h"
 
 static const char git_mailsplit_usage[] =
 "git mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> [<mbox>|<Maildir>...]";
@@ -115,7 +115,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	exit(1);
 }
 
-static int populate_maildir_list(struct path_list *list, const char *path)
+static int populate_maildir_list(struct string_list *list, const char *path)
 {
 	DIR *dir;
 	struct dirent *dent;
@@ -136,7 +136,7 @@ static int populate_maildir_list(struct path_list *list, const char *path)
 			if (dent->d_name[0] == '.')
 				continue;
 			snprintf(name, sizeof(name), "%s/%s", *sub, dent->d_name);
-			path_list_insert(name, list);
+			string_list_insert(name, list);
 		}
 
 		closedir(dir);
@@ -152,14 +152,14 @@ static int split_maildir(const char *maildir, const char *dir,
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
@@ -179,7 +179,7 @@ static int split_maildir(const char *maildir, const char *dir,
 
 	ret = skip;
 out:
-	path_list_clear(&list, 1);
+	string_list_clear(&list, 1);
 	return ret;
 }
 
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 652a2c3..43e55bf 100644
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
@@ -79,8 +79,8 @@ struct stage_data
 	unsigned processed:1;
 };
 
-static struct path_list current_file_set = {NULL, 0, 0, 1};
-static struct path_list current_directory_set = {NULL, 0, 0, 1};
+static struct string_list current_file_set = {NULL, 0, 0, 1};
+static struct string_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
 static int verbosity = 2;
@@ -257,9 +257,9 @@ static int save_files_dirs(const unsigned char *sha1,
 	newpath[baselen + len] = '\0';
 
 	if (S_ISDIR(mode))
-		path_list_insert(newpath, &current_directory_set);
+		string_list_insert(newpath, &current_directory_set);
 	else
-		path_list_insert(newpath, &current_file_set);
+		string_list_insert(newpath, &current_file_set);
 	free(newpath);
 
 	return READ_TREE_RECURSIVE;
@@ -280,9 +280,9 @@ static int get_files_dirs(struct tree *tree)
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
@@ -290,7 +290,7 @@ static struct stage_data *insert_stage_data(const char *path,
 			e->stages[2].sha, &e->stages[2].mode);
 	get_tree_entry(b->object.sha1, path,
 			e->stages[3].sha, &e->stages[3].mode);
-	item = path_list_insert(path, entries);
+	item = string_list_insert(path, entries);
 	item->util = e;
 	return e;
 }
@@ -299,23 +299,23 @@ static struct stage_data *insert_stage_data(const char *path,
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
@@ -340,17 +340,17 @@ struct rename
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
@@ -364,7 +364,7 @@ static struct path_list *get_renames(struct tree *tree,
 	diff_tree_sha1(o_tree->object.sha1, tree->object.sha1, "", &opts);
 	diffcore_std(&opts);
 	for (i = 0; i < diff_queued_diff.nr; ++i) {
-		struct path_list_item *item;
+		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
 		if (pair->status != 'R') {
@@ -374,20 +374,20 @@ static struct path_list *get_renames(struct tree *tree,
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
@@ -464,12 +464,12 @@ static char *unique_path(const char *path, const char *branch)
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
 
@@ -727,13 +727,13 @@ static void conflict_rename_rename(struct rename *ren1,
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
@@ -783,30 +783,30 @@ static void conflict_rename_rename_2(struct rename *ren1,
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
@@ -818,8 +818,8 @@ static int process_renames(struct path_list *a_renames,
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
@@ -908,7 +908,7 @@ static int process_renames(struct path_list *a_renames,
 			}
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
-			struct path_list_item *item;
+			struct string_list_item *item;
 			/* we only use sha1 and mode of these */
 			struct diff_filespec src_other, dst_other;
 			int try_merge, stage = a_renames == renames1 ? 3: 2;
@@ -922,7 +922,7 @@ static int process_renames(struct path_list *a_renames,
 
 			try_merge = 0;
 
-			if (path_list_has_path(&current_directory_set, ren1_dst)) {
+			if (string_list_has_string(&current_directory_set, ren1_dst)) {
 				clean_merge = 0;
 				output(1, "CONFLICT (rename/directory): Renamed %s->%s in %s "
 				       " directory %s added in %s",
@@ -947,7 +947,7 @@ static int process_renames(struct path_list *a_renames,
 				new_path = unique_path(ren1_dst, branch2);
 				output(1, "Added as %s instead", new_path);
 				update_file(0, dst_other.sha1, dst_other.mode, new_path);
-			} else if ((item = path_list_lookup(ren1_dst, renames2Dst))) {
+			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
@@ -1003,8 +1003,8 @@ static int process_renames(struct path_list *a_renames,
 			}
 		}
 	}
-	path_list_clear(&a_by_dst, 0);
-	path_list_clear(&b_by_dst, 0);
+	string_list_clear(&a_by_dst, 0);
+	string_list_clear(&b_by_dst, 0);
 
 	return clean_merge;
 }
@@ -1082,7 +1082,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			sha = b_sha;
 			conf = "directory/file";
 		}
-		if (path_list_has_path(&current_directory_set, path)) {
+		if (string_list_has_string(&current_directory_set, path)) {
 			const char *new_path = unique_path(path, add_branch);
 			clean_merge = 0;
 			output(1, "CONFLICT (%s): There is a directory with name %s in %s. "
@@ -1173,10 +1173,10 @@ int merge_trees(struct tree *head,
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
 
@@ -1186,16 +1186,16 @@ int merge_trees(struct tree *head,
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
index ba9ceda..736a0b8 100644
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
@@ -36,13 +36,14 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 	return get_pathspec(prefix, result);
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
@@ -75,11 +76,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
 
 	git_config(git_default_config, NULL);
 
@@ -189,16 +190,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
@@ -228,15 +229,15 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
@@ -245,7 +246,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		show_list("Deleting : ", &deleted);
 	} else {
 		for (i = 0; i < changed.nr; i++) {
-			const char *path = changed.items[i].path;
+			const char *path = changed.items[i].string;
 			int j = cache_name_pos(path, strlen(path));
 			struct cache_entry *ce = active_cache[j];
 
@@ -255,13 +256,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 
 		for (i = 0; i < added.nr; i++) {
-			const char *path = added.items[i].path;
+			const char *path = added.items[i].string;
 			if (add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0))
 				die("updating index entries failed");
 		}
 
 		for (i = 0; i < deleted.nr; i++)
-			remove_file_from_cache(deleted.items[i].path);
+			remove_file_from_cache(deleted.items[i].string);
 
 		if (active_cache_changed) {
 			if (write_cache(newfd, active_cache, active_nr) ||
diff --git a/builtin-remote.c b/builtin-remote.c
index db12668..54d1c3e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -2,7 +2,7 @@
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
@@ -31,11 +31,11 @@ static inline int postfixcmp(const char *string, const char *postfix)
 
 static int opt_parse_track(const struct option *opt, const char *arg, int not)
 {
-	struct path_list *list = opt->value;
+	struct string_list *list = opt->value;
 	if (not)
-		path_list_clear(list, 0);
+		string_list_clear(list, 0);
 	else
-		path_list_append(arg, list);
+		string_list_append(arg, list);
 	return 0;
 }
 
@@ -51,7 +51,7 @@ static int fetch_remote(const char *name)
 static int add(int argc, const char **argv)
 {
 	int fetch = 0, mirror = 0;
-	struct path_list track = { NULL, 0, 0 };
+	struct string_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
 	struct strbuf buf, buf2;
@@ -96,18 +96,18 @@ static int add(int argc, const char **argv)
 	strbuf_addf(&buf, "remote.%s.fetch", name);
 
 	if (track.nr == 0)
-		path_list_append("*", &track);
+		string_list_append("*", &track);
 	for (i = 0; i < track.nr; i++) {
-		struct path_list_item *item = track.items + i;
+		struct string_list_item *item = track.items + i;
 
 		strbuf_reset(&buf2);
 		strbuf_addch(&buf2, '+');
 		if (mirror)
 			strbuf_addf(&buf2, "refs/%s:refs/%s",
-					item->path, item->path);
+					item->string, item->string);
 		else
 			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
-					item->path, name, item->path);
+					item->string, name, item->string);
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return 1;
 	}
@@ -135,17 +135,17 @@ static int add(int argc, const char **argv)
 
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
-	path_list_clear(&track, 0);
+	string_list_clear(&track, 0);
 
 	return 0;
 }
 
 struct branch_info {
 	char *remote;
-	struct path_list merge;
+	struct string_list merge;
 };
 
-static struct path_list branch_list;
+static struct string_list branch_list;
 
 static const char *abbrev_ref(const char *name, const char *prefix)
 {
@@ -160,7 +160,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 {
 	if (!prefixcmp(key, "branch.")) {
 		char *name;
-		struct path_list_item *item;
+		struct string_list_item *item;
 		struct branch_info *info;
 		enum { REMOTE, MERGE } type;
 
@@ -174,7 +174,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else
 			return 0;
 
-		item = path_list_insert(name, &branch_list);
+		item = string_list_insert(name, &branch_list);
 
 		if (!item->util)
 			item->util = xcalloc(sizeof(struct branch_info), 1);
@@ -189,11 +189,11 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			while (space) {
 				char *merge;
 				merge = xstrndup(value, space - value);
-				path_list_append(merge, &info->merge);
+				string_list_append(merge, &info->merge);
 				value = abbrev_branch(space + 1);
 				space = strchr(value, ' ');
 			}
-			path_list_append(xstrdup(value), &info->merge);
+			string_list_append(xstrdup(value), &info->merge);
 		}
 	}
 	return 0;
@@ -204,12 +204,12 @@ static void read_branches(void)
 	if (branch_list.nr)
 		return;
 	git_config(config_read_branches, NULL);
-	sort_path_list(&branch_list);
+	sort_string_list(&branch_list);
 }
 
 struct ref_states {
 	struct remote *remote;
-	struct path_list new, stale, tracked;
+	struct string_list new, stale, tracked;
 };
 
 static int handle_one_branch(const char *refname,
@@ -221,16 +221,16 @@ static int handle_one_branch(const char *refname,
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec)) {
-		struct path_list_item *item;
+		struct string_list_item *item;
 		const char *name = abbrev_branch(refspec.src);
 		/* symbolic refs pointing nowhere were handled already */
 		if ((flags & REF_ISSYMREF) ||
-				unsorted_path_list_has_path(&states->tracked,
+				unsorted_string_list_has_string(&states->tracked,
 					name) ||
-				unsorted_path_list_has_path(&states->new,
+				unsorted_string_list_has_string(&states->new,
 					name))
 			return 0;
-		item = path_list_append(name, &states->stale);
+		item = string_list_append(name, &states->stale);
 		item->util = xstrdup(refname);
 	}
 	return 0;
@@ -246,9 +246,9 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 			die("Could not get fetch map for refspec %s",
 				states->remote->fetch_refspec[i]);
 
-	states->new.strdup_paths = states->tracked.strdup_paths = 1;
+	states->new.strdup_strings = states->tracked.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
-		struct path_list *target = &states->tracked;
+		struct string_list *target = &states->tracked;
 		unsigned char sha1[20];
 		void *util = NULL;
 
@@ -259,12 +259,12 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 			if (hashcmp(sha1, ref->new_sha1))
 				util = &states;
 		}
-		path_list_append(abbrev_branch(ref->name), target)->util = util;
+		string_list_append(abbrev_branch(ref->name), target)->util = util;
 	}
 	free_refs(fetch_map);
 
 	for_each_ref(handle_one_branch, states);
-	sort_path_list(&states->stale);
+	sort_string_list(&states->stale);
 
 	return 0;
 }
@@ -296,7 +296,7 @@ static int add_known_remote(struct remote *remote, void *cb_data)
 
 struct branches_for_remote {
 	struct remote *remote;
-	struct path_list *branches;
+	struct string_list *branches;
 	struct known_remotes *keep;
 };
 
@@ -305,7 +305,7 @@ static int add_branch_for_removal(const char *refname,
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec refspec;
-	struct path_list_item *item;
+	struct string_list_item *item;
 	struct known_remote *kr;
 
 	memset(&refspec, 0, sizeof(refspec));
@@ -325,19 +325,19 @@ static int add_branch_for_removal(const char *refname,
 	if (flags & REF_ISSYMREF)
 		return unlink(git_path(refname));
 
-	item = path_list_append(refname, branches->branches);
+	item = string_list_append(refname, branches->branches);
 	item->util = xmalloc(20);
 	hashcpy(item->util, sha1);
 
 	return 0;
 }
 
-static int remove_branches(struct path_list *branches)
+static int remove_branches(struct string_list *branches)
 {
 	int i, result = 0;
 	for (i = 0; i < branches->nr; i++) {
-		struct path_list_item *item = branches->items + i;
-		const char *refname = item->path;
+		struct string_list_item *item = branches->items + i;
+		const char *refname = item->string;
 		unsigned char *sha1 = item->util;
 
 		if (delete_ref(refname, sha1))
@@ -354,7 +354,7 @@ static int rm(int argc, const char **argv)
 	struct remote *remote;
 	struct strbuf buf;
 	struct known_remotes known_remotes = { NULL, NULL };
-	struct path_list branches = { NULL, 0, 0, 1 };
+	struct string_list branches = { NULL, 0, 0, 1 };
 	struct branches_for_remote cb_data = { NULL, &branches, &known_remotes };
 	int i;
 
@@ -375,14 +375,14 @@ static int rm(int argc, const char **argv)
 
 	read_branches();
 	for (i = 0; i < branch_list.nr; i++) {
-		struct path_list_item *item = branch_list.items + i;
+		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
 		if (info->remote && !strcmp(info->remote, remote->name)) {
 			const char *keys[] = { "remote", "merge", NULL }, **k;
 			for (k = keys; *k; k++) {
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
-						item->path, *k);
+						item->string, *k);
 				if (git_config_set(buf.buf, NULL)) {
 					strbuf_release(&buf);
 					return -1;
@@ -402,12 +402,12 @@ static int rm(int argc, const char **argv)
 
 	if (!i)
 		i = remove_branches(&branches);
-	path_list_clear(&branches, 1);
+	string_list_clear(&branches, 1);
 
 	return i;
 }
 
-static void show_list(const char *title, struct path_list *list)
+static void show_list(const char *title, struct string_list *list)
 {
 	int i;
 
@@ -417,7 +417,7 @@ static void show_list(const char *title, struct path_list *list)
 	printf(title, list->nr > 1 ? "es" : "");
 	printf("\n    ");
 	for (i = 0; i < list->nr; i++)
-		printf("%s%s", i ? " " : "", list->items[i].path);
+		printf("%s%s", i ? " " : "", list->items[i].string);
 	printf("\n");
 }
 
@@ -455,7 +455,7 @@ static int append_ref_to_tracked_list(const char *refname,
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec))
-		path_list_append(abbrev_branch(refspec.src), &states->tracked);
+		string_list_append(abbrev_branch(refspec.src), &states->tracked);
 
 	return 0;
 }
@@ -487,7 +487,7 @@ static int show(int argc, const char **argv)
 				states.remote->url[0] : "(no URL)");
 
 		for (i = 0; i < branch_list.nr; i++) {
-			struct path_list_item *branch = branch_list.items + i;
+			struct string_list_item *branch = branch_list.items + i;
 			struct branch_info *info = branch->util;
 			int j;
 
@@ -496,9 +496,9 @@ static int show(int argc, const char **argv)
 			printf("  Remote branch%s merged with 'git pull' "
 				"while on branch %s\n   ",
 				info->merge.nr > 1 ? "es" : "",
-				branch->path);
+				branch->string);
 			for (j = 0; j < info->merge.nr; j++)
-				printf(" %s", info->merge.items[j].path);
+				printf(" %s", info->merge.items[j].string);
 			printf("\n");
 		}
 
@@ -531,9 +531,9 @@ static int show(int argc, const char **argv)
 		}
 
 		/* NEEDSWORK: free remote */
-		path_list_clear(&states.new, 0);
-		path_list_clear(&states.stale, 0);
-		path_list_clear(&states.tracked, 0);
+		string_list_clear(&states.new, 0);
+		string_list_clear(&states.stale, 0);
+		string_list_clear(&states.tracked, 0);
 	}
 
 	return result;
@@ -579,9 +579,9 @@ static int prune(int argc, const char **argv)
 		}
 
 		/* NEEDSWORK: free remote */
-		path_list_clear(&states.new, 0);
-		path_list_clear(&states.stale, 0);
-		path_list_clear(&states.tracked, 0);
+		string_list_clear(&states.new, 0);
+		string_list_clear(&states.stale, 0);
+		string_list_clear(&states.tracked, 0);
 	}
 
 	return result;
@@ -589,15 +589,15 @@ static int prune(int argc, const char **argv)
 
 static int get_one_remote_for_update(struct remote *remote, void *priv)
 {
-	struct path_list *list = priv;
+	struct string_list *list = priv;
 	if (!remote->skip_default_update)
-		path_list_append(xstrdup(remote->name), list);
+		string_list_append(xstrdup(remote->name), list);
 	return 0;
 }
 
 struct remote_group {
 	const char *name;
-	struct path_list *list;
+	struct string_list *list;
 } remote_group;
 
 static int get_remote_group(const char *key, const char *value, void *cb)
@@ -608,7 +608,7 @@ static int get_remote_group(const char *key, const char *value, void *cb)
 		int space = strcspn(value, " \t\n");
 		while (*value) {
 			if (space > 1)
-				path_list_append(xstrndup(value, space),
+				string_list_append(xstrndup(value, space),
 						remote_group.list);
 			value += space + (value[space] != '\0');
 			space = strcspn(value, " \t\n");
@@ -621,7 +621,7 @@ static int get_remote_group(const char *key, const char *value, void *cb)
 static int update(int argc, const char **argv)
 {
 	int i, result = 0;
-	struct path_list list = { NULL, 0, 0, 0 };
+	struct string_list list = { NULL, 0, 0, 0 };
 	static const char *default_argv[] = { NULL, "default", NULL };
 
 	if (argc < 2) {
@@ -639,20 +639,20 @@ static int update(int argc, const char **argv)
 		result = for_each_remote(get_one_remote_for_update, &list);
 
 	for (i = 0; i < list.nr; i++)
-		result |= fetch_remote(list.items[i].path);
+		result |= fetch_remote(list.items[i].string);
 
 	/* all names were strdup()ed or strndup()ed */
-	list.strdup_paths = 1;
-	path_list_clear(&list, 0);
+	list.strdup_strings = 1;
+	string_list_clear(&list, 0);
 
 	return result;
 }
 
 static int get_one_entry(struct remote *remote, void *priv)
 {
-	struct path_list *list = priv;
+	struct string_list *list = priv;
 
-	path_list_append(remote->name, list)->util = remote->url_nr ?
+	string_list_append(remote->name, list)->util = remote->url_nr ?
 		(void *)remote->url[0] : NULL;
 	if (remote->url_nr > 1)
 		warning("Remote %s has more than one URL", remote->name);
@@ -662,16 +662,16 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct path_list list = { NULL, 0, 0 };
+	struct string_list list = { NULL, 0, 0 };
 	int result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
 		int i;
 
-		sort_path_list(&list);
+		sort_string_list(&list);
 		for (i = 0; i < list.nr; i++) {
-			struct path_list_item *item = list.items + i;
-			printf("%s%s%s\n", item->path,
+			struct string_list_item *item = list.items + i;
+			printf("%s%s%s\n", item->string,
 				verbose ? "\t" : "",
 				verbose && item->util ?
 					(const char *)item->util : "");
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 5805805..dd4573f 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
@@ -48,9 +48,9 @@ static int git_rerere_gc_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static void garbage_collect(struct path_list *rr)
+static void garbage_collect(struct string_list *rr)
 {
-	struct path_list to_remove = { NULL, 0, 0, 1 };
+	struct string_list to_remove = { NULL, 0, 0, 1 };
 	DIR *dir;
 	struct dirent *e;
 	int i, cutoff;
@@ -69,11 +69,11 @@ static void garbage_collect(struct path_list *rr)
 		cutoff = (has_resolution(name)
 			  ? cutoff_resolve : cutoff_noresolve);
 		if (then < now - cutoff * 86400)
-			path_list_append(name, &to_remove);
+			string_list_append(name, &to_remove);
 	}
 	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].path);
-	path_list_clear(&to_remove, 0);
+		unlink_rr_item(to_remove.items[i].string);
+	string_list_clear(&to_remove, 0);
 }
 
 static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
@@ -111,7 +111,7 @@ static int diff_two(const char *file1, const char *label1,
 
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
-	struct path_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = { NULL, 0, 0, 1 };
 	int i, fd;
 
 	if (argc < 2)
@@ -132,16 +132,16 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
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
index 94c4723..d03f14f 100644
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
@@ -18,8 +18,8 @@ static char const * const shortlog_usage[] = {
 
 static int compare_by_number(const void *a1, const void *a2)
 {
-	const struct path_list_item *i1 = a1, *i2 = a2;
-	const struct path_list *l1 = i1->util, *l2 = i2->util;
+	const struct string_list_item *i1 = a1, *i2 = a2;
+	const struct string_list *l1 = i1->util, *l2 = i2->util;
 
 	if (l1->nr < l2->nr)
 		return 1;
@@ -35,8 +35,8 @@ static void insert_one_record(struct shortlog *log,
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
@@ -69,9 +69,9 @@ static void insert_one_record(struct shortlog *log,
 	}
 
 	buffer = xstrdup(namebuf);
-	item = path_list_insert(buffer, &log->list);
+	item = string_list_insert(buffer, &log->list);
 	if (item->util == NULL)
-		item->util = xcalloc(1, sizeof(struct path_list));
+		item->util = xcalloc(1, sizeof(struct string_list));
 	else
 		free(buffer);
 
@@ -109,11 +109,11 @@ static void insert_one_record(struct shortlog *log,
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
@@ -231,7 +231,7 @@ void shortlog_init(struct shortlog *log)
 
 	read_mailmap(&log->mailmap, ".mailmap", &log->common_repo_prefix);
 
-	log->list.strdup_paths = 1;
+	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
@@ -299,17 +299,17 @@ void shortlog_output(struct shortlog *log)
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
@@ -322,14 +322,14 @@ void shortlog_output(struct shortlog *log)
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
diff --git a/diff-no-index.c b/diff-no-index.c
index f6994cf..7d68b7f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -14,9 +14,9 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
-#include "path-list.h"
+#include "string-list.h"
 
-static int read_directory(const char *path, struct path_list *list)
+static int read_directory(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -26,7 +26,7 @@ static int read_directory(const char *path, struct path_list *list)
 
 	while ((e = readdir(dir)))
 		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
-			path_list_insert(e->d_name, list);
+			string_list_insert(e->d_name, list);
 
 	closedir(dir);
 	return 0;
@@ -60,13 +60,13 @@ static int queue_diff(struct diff_options *o,
 
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
 
@@ -95,14 +95,14 @@ static int queue_diff(struct diff_options *o,
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
 
@@ -110,14 +110,14 @@ static int queue_diff(struct diff_options *o,
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
diff --git a/path-list.c b/path-list.c
deleted file mode 100644
index 92e5cf2..0000000
--- a/path-list.c
+++ /dev/null
@@ -1,134 +0,0 @@
-#include "cache.h"
-#include "path-list.h"
-
-/* if there is no exact match, point to the index where the entry could be
- * inserted */
-static int get_entry_index(const struct path_list *list, const char *path,
-		int *exact_match)
-{
-	int left = -1, right = list->nr;
-
-	while (left + 1 < right) {
-		int middle = (left + right) / 2;
-		int compare = strcmp(path, list->items[middle].path);
-		if (compare < 0)
-			right = middle;
-		else if (compare > 0)
-			left = middle;
-		else {
-			*exact_match = 1;
-			return middle;
-		}
-	}
-
-	*exact_match = 0;
-	return right;
-}
-
-/* returns -1-index if already exists */
-static int add_entry(struct path_list *list, const char *path)
-{
-	int exact_match;
-	int index = get_entry_index(list, path, &exact_match);
-
-	if (exact_match)
-		return -1 - index;
-
-	if (list->nr + 1 >= list->alloc) {
-		list->alloc += 32;
-		list->items = xrealloc(list->items, list->alloc
-				* sizeof(struct path_list_item));
-	}
-	if (index < list->nr)
-		memmove(list->items + index + 1, list->items + index,
-				(list->nr - index)
-				* sizeof(struct path_list_item));
-	list->items[index].path = list->strdup_paths ?
-		xstrdup(path) : (char *)path;
-	list->items[index].util = NULL;
-	list->nr++;
-
-	return index;
-}
-
-struct path_list_item *path_list_insert(const char *path, struct path_list *list)
-{
-	int index = add_entry(list, path);
-
-	if (index < 0)
-		index = -1 - index;
-
-	return list->items + index;
-}
-
-int path_list_has_path(const struct path_list *list, const char *path)
-{
-	int exact_match;
-	get_entry_index(list, path, &exact_match);
-	return exact_match;
-}
-
-struct path_list_item *path_list_lookup(const char *path, struct path_list *list)
-{
-	int exact_match, i = get_entry_index(list, path, &exact_match);
-	if (!exact_match)
-		return NULL;
-	return list->items + i;
-}
-
-void path_list_clear(struct path_list *list, int free_util)
-{
-	if (list->items) {
-		int i;
-		if (list->strdup_paths) {
-			for (i = 0; i < list->nr; i++)
-				free(list->items[i].path);
-		}
-		if (free_util) {
-			for (i = 0; i < list->nr; i++)
-				free(list->items[i].util);
-		}
-		free(list->items);
-	}
-	list->items = NULL;
-	list->nr = list->alloc = 0;
-}
-
-void print_path_list(const char *text, const struct path_list *p)
-{
-	int i;
-	if ( text )
-		printf("%s\n", text);
-	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].path, p->items[i].util);
-}
-
-struct path_list_item *path_list_append(const char *path, struct path_list *list)
-{
-	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
-	list->items[list->nr].path =
-		list->strdup_paths ? xstrdup(path) : (char *)path;
-	return list->items + list->nr++;
-}
-
-static int cmp_items(const void *a, const void *b)
-{
-	const struct path_list_item *one = a;
-	const struct path_list_item *two = b;
-	return strcmp(one->path, two->path);
-}
-
-void sort_path_list(struct path_list *list)
-{
-	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
-}
-
-int unsorted_path_list_has_path(struct path_list *list, const char *path)
-{
-	int i;
-	for (i = 0; i < list->nr; i++)
-		if (!strcmp(path, list->items[i].path))
-			return 1;
-	return 0;
-}
-
diff --git a/path-list.h b/path-list.h
deleted file mode 100644
index ca2cbba..0000000
--- a/path-list.h
+++ /dev/null
@@ -1,28 +0,0 @@
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
-void path_list_clear(struct path_list *list, int free_util);
-
-/* Use these functions only on sorted lists: */
-int path_list_has_path(const struct path_list *list, const char *path);
-struct path_list_item *path_list_insert(const char *path, struct path_list *list);
-struct path_list_item *path_list_lookup(const char *path, struct path_list *list);
-
-/* Use these functions only on unsorted lists: */
-struct path_list_item *path_list_append(const char *path, struct path_list *list);
-void sort_path_list(struct path_list *list);
-int unsorted_path_list_has_path(struct path_list *list, const char *path);
-
-#endif /* PATH_LIST_H */
diff --git a/pretty.c b/pretty.c
index 628a520..33ef34a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -3,7 +3,7 @@
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "mailmap.h"
 
 static char *user_format;
@@ -292,7 +292,7 @@ static char *logmsg_reencode(const struct commit *commit,
 
 static int mailmap_name(struct strbuf *sb, const char *email)
 {
-	static struct path_list *mail_map;
+	static struct string_list *mail_map;
 	char buffer[1024];
 
 	if (!mail_map) {
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
 
diff --git a/rerere.c b/rerere.c
index 0456aa6..323e493 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "path-list.h"
+#include "string-list.h"
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
@@ -23,7 +23,7 @@ static int has_resolution(const char *name)
 	return !stat(rr_path(name, "postimage"), &st);
 }
 
-static void read_rr(struct path_list *rr)
+static void read_rr(struct string_list *rr)
 {
 	unsigned char sha1[20];
 	char buf[PATH_MAX];
@@ -43,14 +43,14 @@ static void read_rr(struct path_list *rr)
 			; /* do nothing */
 		if (i == sizeof(buf))
 			die("filename too long");
-		path_list_insert(buf, rr)->util = name;
+		string_list_insert(buf, rr)->util = name;
 	}
 	fclose(in);
 }
 
 static struct lock_file write_lock;
 
-static int write_rr(struct path_list *rr, int out_fd)
+static int write_rr(struct string_list *rr, int out_fd)
 {
 	int i;
 	for (i = 0; i < rr->nr; i++) {
@@ -58,7 +58,7 @@ static int write_rr(struct path_list *rr, int out_fd)
 		int length;
 		if (!rr->items[i].util)
 			continue;
-		path = rr->items[i].path;
+		path = rr->items[i].string;
 		length = strlen(path) + 1;
 		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
 		    write_in_full(out_fd, "\t", 1) != 1 ||
@@ -154,7 +154,7 @@ static int handle_file(const char *path,
 	return hunk_no;
 }
 
-static int find_conflict(struct path_list *conflict)
+static int find_conflict(struct string_list *conflict)
 {
 	int i;
 	if (read_cache() < 0)
@@ -167,7 +167,7 @@ static int find_conflict(struct path_list *conflict)
 		    ce_same_name(e2, e3) &&
 		    S_ISREG(e2->ce_mode) &&
 		    S_ISREG(e3->ce_mode)) {
-			path_list_insert((const char *)e2->name, conflict);
+			string_list_insert((const char *)e2->name, conflict);
 			i++; /* skip over both #2 and #3 */
 		}
 	}
@@ -208,7 +208,7 @@ static int merge(const char *name, const char *path)
 
 static struct lock_file index_lock;
 
-static int update_paths(struct path_list *update)
+static int update_paths(struct string_list *update)
 {
 	int i;
 	int fd = hold_locked_index(&index_lock, 0);
@@ -218,8 +218,8 @@ static int update_paths(struct path_list *update)
 		return -1;
 
 	for (i = 0; i < update->nr; i++) {
-		struct path_list_item *item = &update->items[i];
-		if (add_file_to_cache(item->path, ADD_CACHE_IGNORE_ERRORS))
+		struct string_list_item *item = &update->items[i];
+		if (add_file_to_cache(item->string, ADD_CACHE_IGNORE_ERRORS))
 			status = -1;
 	}
 
@@ -232,10 +232,10 @@ static int update_paths(struct path_list *update)
 	return status;
 }
 
-static int do_plain_rerere(struct path_list *rr, int fd)
+static int do_plain_rerere(struct string_list *rr, int fd)
 {
-	struct path_list conflict = { NULL, 0, 0, 1 };
-	struct path_list update = { NULL, 0, 0, 1 };
+	struct string_list conflict = { NULL, 0, 0, 1 };
+	struct string_list update = { NULL, 0, 0, 1 };
 	int i;
 
 	find_conflict(&conflict);
@@ -248,8 +248,8 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 	 */
 
 	for (i = 0; i < conflict.nr; i++) {
-		const char *path = conflict.items[i].path;
-		if (!path_list_has_path(rr, path)) {
+		const char *path = conflict.items[i].string;
+		if (!string_list_has_string(rr, path)) {
 			unsigned char sha1[20];
 			char *hex;
 			int ret;
@@ -257,7 +257,7 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 			if (ret < 1)
 				continue;
 			hex = xstrdup(sha1_to_hex(sha1));
-			path_list_insert(path, rr)->util = hex;
+			string_list_insert(path, rr)->util = hex;
 			if (mkdir(git_path("rr-cache/%s", hex), 0755))
 				continue;;
 			handle_file(path, NULL, rr_path(hex, "preimage"));
@@ -273,13 +273,13 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 
 	for (i = 0; i < rr->nr; i++) {
 		int ret;
-		const char *path = rr->items[i].path;
+		const char *path = rr->items[i].string;
 		const char *name = (const char *)rr->items[i].util;
 
 		if (has_resolution(name)) {
 			if (!merge(name, path)) {
 				if (rerere_autoupdate)
-					path_list_insert(path, &update);
+					string_list_insert(path, &update);
 				fprintf(stderr,
 					"%s '%s' using previous resolution.\n",
 					rerere_autoupdate
@@ -337,7 +337,7 @@ static int is_rerere_enabled(void)
 	return 1;
 }
 
-int setup_rerere(struct path_list *merge_rr)
+int setup_rerere(struct string_list *merge_rr)
 {
 	int fd;
 
@@ -353,7 +353,7 @@ int setup_rerere(struct path_list *merge_rr)
 
 int rerere(void)
 {
-	struct path_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = { NULL, 0, 0, 1 };
 	int fd;
 
 	fd = setup_rerere(&merge_rr);
diff --git a/rerere.h b/rerere.h
index 35b0fa8..f9b0386 100644
--- a/rerere.h
+++ b/rerere.h
@@ -1,9 +1,9 @@
 #ifndef RERERE_H
 #define RERERE_H
 
-#include "path-list.h"
+#include "string-list.h"
 
-extern int setup_rerere(struct path_list *);
+extern int setup_rerere(struct string_list *);
 extern int rerere(void);
 
 #endif
diff --git a/shortlog.h b/shortlog.h
index 6608ee8..bc02cc2 100644
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
@@ -15,7 +15,7 @@ struct shortlog {
 
 	char *common_repo_prefix;
 	int email;
-	struct path_list mailmap;
+	struct string_list mailmap;
 };
 
 void shortlog_init(struct shortlog *log);
diff --git a/string-list.c b/string-list.c
new file mode 100644
index 0000000..ddd83c8
--- /dev/null
+++ b/string-list.c
@@ -0,0 +1,134 @@
+#include "cache.h"
+#include "string-list.h"
+
+/* if there is no exact match, point to the index where the entry could be
+ * inserted */
+static int get_entry_index(const struct string_list *list, const char *string,
+		int *exact_match)
+{
+	int left = -1, right = list->nr;
+
+	while (left + 1 < right) {
+		int middle = (left + right) / 2;
+		int compare = strcmp(string, list->items[middle].string);
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
+static int add_entry(struct string_list *list, const char *string)
+{
+	int exact_match;
+	int index = get_entry_index(list, string, &exact_match);
+
+	if (exact_match)
+		return -1 - index;
+
+	if (list->nr + 1 >= list->alloc) {
+		list->alloc += 32;
+		list->items = xrealloc(list->items, list->alloc
+				* sizeof(struct string_list_item));
+	}
+	if (index < list->nr)
+		memmove(list->items + index + 1, list->items + index,
+				(list->nr - index)
+				* sizeof(struct string_list_item));
+	list->items[index].string = list->strdup_strings ?
+		xstrdup(string) : (char *)string;
+	list->items[index].util = NULL;
+	list->nr++;
+
+	return index;
+}
+
+struct string_list_item *string_list_insert(const char *string, struct string_list *list)
+{
+	int index = add_entry(list, string);
+
+	if (index < 0)
+		index = -1 - index;
+
+	return list->items + index;
+}
+
+int string_list_has_string(const struct string_list *list, const char *string)
+{
+	int exact_match;
+	get_entry_index(list, string, &exact_match);
+	return exact_match;
+}
+
+struct string_list_item *string_list_lookup(const char *string, struct string_list *list)
+{
+	int exact_match, i = get_entry_index(list, string, &exact_match);
+	if (!exact_match)
+		return NULL;
+	return list->items + i;
+}
+
+void string_list_clear(struct string_list *list, int free_util)
+{
+	if (list->items) {
+		int i;
+		if (list->strdup_strings) {
+			for (i = 0; i < list->nr; i++)
+				free(list->items[i].string);
+		}
+		if (free_util) {
+			for (i = 0; i < list->nr; i++)
+				free(list->items[i].util);
+		}
+		free(list->items);
+	}
+	list->items = NULL;
+	list->nr = list->alloc = 0;
+}
+
+void print_string_list(const char *text, const struct string_list *p)
+{
+	int i;
+	if ( text )
+		printf("%s\n", text);
+	for (i = 0; i < p->nr; i++)
+		printf("%s:%p\n", p->items[i].string, p->items[i].util);
+}
+
+struct string_list_item *string_list_append(const char *string, struct string_list *list)
+{
+	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
+	list->items[list->nr].string =
+		list->strdup_strings ? xstrdup(string) : (char *)string;
+	return list->items + list->nr++;
+}
+
+static int cmp_items(const void *a, const void *b)
+{
+	const struct string_list_item *one = a;
+	const struct string_list_item *two = b;
+	return strcmp(one->string, two->string);
+}
+
+void sort_string_list(struct string_list *list)
+{
+	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
+}
+
+int unsorted_string_list_has_string(struct string_list *list, const char *string)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		if (!strcmp(string, list->items[i].string))
+			return 1;
+	return 0;
+}
+
diff --git a/string-list.h b/string-list.h
new file mode 100644
index 0000000..4d6a705
--- /dev/null
+++ b/string-list.h
@@ -0,0 +1,28 @@
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
+void string_list_clear(struct string_list *list, int free_util);
+
+/* Use these functions only on sorted lists: */
+int string_list_has_string(const struct string_list *list, const char *string);
+struct string_list_item *string_list_insert(const char *string, struct string_list *list);
+struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
+
+/* Use these functions only on unsorted lists: */
+struct string_list_item *string_list_append(const char *string, struct string_list *list);
+void sort_string_list(struct string_list *list);
+int unsorted_string_list_has_string(struct string_list *list, const char *string);
+
+#endif /* PATH_LIST_H */
-- 
1.6.0.rc0.196.gb5b33

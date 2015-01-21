From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 01/19] fsck: Introduce fsck options
Date: Wed, 21 Jan 2015 20:24:06 +0100
Organization: gmx
Message-ID: <2ba8ef18e22fb7d9a7e7b513422dc1f3a2716061.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0sy-0001ix-37
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbbAUTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:24:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:58854 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbbAUTYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:24:10 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lb5GD-1XTMTP3qC9-00ki1e; Wed, 21 Jan 2015 20:24:06
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:2VzY+7ojpMIJ+qHJbODxBjp6AdutKgo+AaKY+mhAb+UWm6Xvv/7
 Hh5F1fsIZgAE4u2cFs6ESF4bpy285zifYjPGhrLojx4vmwBpT+pJygkwrARA2N5G2iurnLi
 qW15KvIgP09Vz3RK0Cw4MttaVREHqjJeOd3xldSmreGZmfOq1M7u5X1OdkdkytKoz8Lwbje
 D4qDQq/F4fER8UtS41owQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262746>

Just like the diff machinery, we are about to introduce more settings,
therefore it makes sense to carry them around as a (pointer to a) struct
containing all of them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsck.c           |  20 +++++--
 builtin/index-pack.c     |   9 +--
 builtin/unpack-objects.c |  11 ++--
 fsck.c                   | 150 +++++++++++++++++++++++------------------------
 fsck.h                   |  17 +++++-
 5 files changed, 114 insertions(+), 93 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index a27515a..2241e29 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -25,6 +25,8 @@ static int include_reflogs = 1;
 static int check_full = 1;
 static int check_strict;
 static int keep_cache_objects;
+static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
+static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
 static unsigned char head_sha1[20];
 static const char *head_points_at;
 static int errors_found;
@@ -76,7 +78,7 @@ static int fsck_error_func(struct object *obj, int type, const char *err, ...)
 
 static struct object_array pending;
 
-static int mark_object(struct object *obj, int type, void *data)
+static int mark_object(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	struct object *parent = data;
 
@@ -119,7 +121,7 @@ static int mark_object(struct object *obj, int type, void *data)
 
 static void mark_object_reachable(struct object *obj)
 {
-	mark_object(obj, OBJ_ANY, NULL);
+	mark_object(obj, OBJ_ANY, NULL, NULL);
 }
 
 static int traverse_one_object(struct object *obj)
@@ -132,7 +134,7 @@ static int traverse_one_object(struct object *obj)
 		if (parse_tree(tree) < 0)
 			return 1; /* error already displayed */
 	}
-	result = fsck_walk(obj, mark_object, obj);
+	result = fsck_walk(obj, obj, &fsck_walk_options);
 	if (tree)
 		free_tree_buffer(tree);
 	return result;
@@ -158,7 +160,7 @@ static int traverse_reachable(void)
 	return !!result;
 }
 
-static int mark_used(struct object *obj, int type, void *data)
+static int mark_used(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	if (!obj)
 		return 1;
@@ -296,9 +298,9 @@ static int fsck_obj(struct object *obj)
 		fprintf(stderr, "Checking %s %s\n",
 			typename(obj->type), sha1_to_hex(obj->sha1));
 
-	if (fsck_walk(obj, mark_used, NULL))
+	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(obj, "broken links");
-	if (fsck_object(obj, NULL, 0, check_strict, fsck_error_func))
+	if (fsck_object(obj, NULL, 0, &fsck_obj_options))
 		return -1;
 
 	if (obj->type == OBJ_TREE) {
@@ -630,6 +632,12 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
+	fsck_walk_options.walk = mark_object;
+	fsck_obj_options.walk = mark_used;
+	fsck_obj_options.error_func = fsck_error_func;
+	if (check_strict)
+		fsck_obj_options.strict = 1;
+
 	if (show_progress == -1)
 		show_progress = isatty(2);
 	if (verbose)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4632117..925f7b5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -74,6 +74,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int do_fsck_object;
+static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static int verbose;
 static int show_stat;
 static int check_self_contained_and_connected;
@@ -191,7 +192,7 @@ static void cleanup_thread(void)
 #endif
 
 
-static int mark_link(struct object *obj, int type, void *data)
+static int mark_link(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	if (!obj)
 		return -1;
@@ -782,10 +783,10 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (!obj)
 				die(_("invalid %s"), typename(type));
 			if (do_fsck_object &&
-			    fsck_object(obj, buf, size, 1,
-				    fsck_error_function))
+			    fsck_object(obj, buf, size, &fsck_options))
 				die(_("Error in object"));
-			if (fsck_walk(obj, mark_link, NULL))
+			fsck_options.walk = mark_link;
+			if (fsck_walk(obj, NULL, &fsck_options))
 				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));
 
 			if (obj->type == OBJ_TREE) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index ac66672..6d17040 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -20,6 +20,7 @@ static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static git_SHA_CTX ctx;
+static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 /*
  * When running under --strict mode, objects whose reachability are
@@ -178,7 +179,7 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
  * that have reachability requirements and calls this function.
  * Verify its reachability and validity recursively and write it out.
  */
-static int check_object(struct object *obj, int type, void *data)
+static int check_object(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	struct obj_buffer *obj_buf;
 
@@ -203,10 +204,10 @@ static int check_object(struct object *obj, int type, void *data)
 	obj_buf = lookup_object_buffer(obj);
 	if (!obj_buf)
 		die("Whoops! Cannot find object '%s'", sha1_to_hex(obj->sha1));
-	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, 1,
-			fsck_error_function))
+	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
 		die("Error in object");
-	if (fsck_walk(obj, check_object, NULL))
+	fsck_options.walk = check_object;
+	if (fsck_walk(obj, NULL, &fsck_options))
 		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
 	write_cached_object(obj, obj_buf);
 	return 0;
@@ -217,7 +218,7 @@ static void write_rest(void)
 	unsigned i;
 	for (i = 0; i < nr_objects; i++) {
 		if (obj_list[i].obj)
-			check_object(obj_list[i].obj, OBJ_ANY, NULL);
+			check_object(obj_list[i].obj, OBJ_ANY, NULL, NULL);
 	}
 }
 
diff --git a/fsck.c b/fsck.c
index 10bcb65..d83b811 100644
--- a/fsck.c
+++ b/fsck.c
@@ -9,7 +9,7 @@
 #include "refs.h"
 #include "utf8.h"
 
-static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
+static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -25,9 +25,9 @@ static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 		if (S_ISGITLINK(entry.mode))
 			continue;
 		if (S_ISDIR(entry.mode))
-			result = walk(&lookup_tree(entry.sha1)->object, OBJ_TREE, data);
+			result = options->walk(&lookup_tree(entry.sha1)->object, OBJ_TREE, data, options);
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
-			result = walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data);
+			result = options->walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data, options);
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
 					sha1_to_hex(tree->object.sha1), entry.path, entry.mode);
@@ -40,7 +40,7 @@ static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 	return res;
 }
 
-static int fsck_walk_commit(struct commit *commit, fsck_walk_func walk, void *data)
+static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_options *options)
 {
 	struct commit_list *parents;
 	int res;
@@ -49,14 +49,14 @@ static int fsck_walk_commit(struct commit *commit, fsck_walk_func walk, void *da
 	if (parse_commit(commit))
 		return -1;
 
-	result = walk((struct object *)commit->tree, OBJ_TREE, data);
+	result = options->walk((struct object *)commit->tree, OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
 	res = result;
 
 	parents = commit->parents;
 	while (parents) {
-		result = walk((struct object *)parents->item, OBJ_COMMIT, data);
+		result = options->walk((struct object *)parents->item, OBJ_COMMIT, data, options);
 		if (result < 0)
 			return result;
 		if (!res)
@@ -66,14 +66,14 @@ static int fsck_walk_commit(struct commit *commit, fsck_walk_func walk, void *da
 	return res;
 }
 
-static int fsck_walk_tag(struct tag *tag, fsck_walk_func walk, void *data)
+static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *options)
 {
 	if (parse_tag(tag))
 		return -1;
-	return walk(tag->tagged, OBJ_ANY, data);
+	return options->walk(tag->tagged, OBJ_ANY, data, options);
 }
 
-int fsck_walk(struct object *obj, fsck_walk_func walk, void *data)
+int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 {
 	if (!obj)
 		return -1;
@@ -81,11 +81,11 @@ int fsck_walk(struct object *obj, fsck_walk_func walk, void *data)
 	case OBJ_BLOB:
 		return 0;
 	case OBJ_TREE:
-		return fsck_walk_tree((struct tree *)obj, walk, data);
+		return fsck_walk_tree((struct tree *)obj, data, options);
 	case OBJ_COMMIT:
-		return fsck_walk_commit((struct commit *)obj, walk, data);
+		return fsck_walk_commit((struct commit *)obj, data, options);
 	case OBJ_TAG:
-		return fsck_walk_tag((struct tag *)obj, walk, data);
+		return fsck_walk_tag((struct tag *)obj, data, options);
 	default:
 		error("Unknown object type for %s", sha1_to_hex(obj->sha1));
 		return -1;
@@ -138,7 +138,7 @@ static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, con
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }
 
-static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
+static int fsck_tree(struct tree *item, struct fsck_options *options)
 {
 	int retval;
 	int has_null_sha1 = 0;
@@ -194,7 +194,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 		 * bits..
 		 */
 		case S_IFREG | 0664:
-			if (!strict)
+			if (!options->strict)
 				break;
 		default:
 			has_bad_modes = 1;
@@ -219,30 +219,30 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 
 	retval = 0;
 	if (has_null_sha1)
-		retval += error_func(&item->object, FSCK_WARN, "contains entries pointing to null sha1");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += error_func(&item->object, FSCK_WARN, "contains full pathnames");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains full pathnames");
 	if (has_empty_name)
-		retval += error_func(&item->object, FSCK_WARN, "contains empty pathname");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains empty pathname");
 	if (has_dot)
-		retval += error_func(&item->object, FSCK_WARN, "contains '.'");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains '.'");
 	if (has_dotdot)
-		retval += error_func(&item->object, FSCK_WARN, "contains '..'");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains '..'");
 	if (has_dotgit)
-		retval += error_func(&item->object, FSCK_WARN, "contains '.git'");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains '.git'");
 	if (has_zero_pad)
-		retval += error_func(&item->object, FSCK_WARN, "contains zero-padded file modes");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += error_func(&item->object, FSCK_WARN, "contains bad file modes");
+		retval += options->error_func(&item->object, FSCK_WARN, "contains bad file modes");
 	if (has_dup_entries)
-		retval += error_func(&item->object, FSCK_ERROR, "contains duplicate file entries");
+		retval += options->error_func(&item->object, FSCK_ERROR, "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += error_func(&item->object, FSCK_ERROR, "not properly sorted");
+		retval += options->error_func(&item->object, FSCK_ERROR, "not properly sorted");
 	return retval;
 }
 
 static int require_end_of_header(const void *data, unsigned long size,
-	struct object *obj, fsck_error error_func)
+	struct object *obj, struct fsck_options *options)
 {
 	const char *buffer = (const char *)data;
 	unsigned long i;
@@ -250,7 +250,7 @@ static int require_end_of_header(const void *data, unsigned long size,
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
-			return error_func(obj, FSCK_ERROR,
+			return options->error_func(obj, FSCK_ERROR,
 				"unterminated header: NUL at offset %d", i);
 		case '\n':
 			if (i + 1 < size && buffer[i + 1] == '\n')
@@ -258,36 +258,36 @@ static int require_end_of_header(const void *data, unsigned long size,
 		}
 	}
 
-	return error_func(obj, FSCK_ERROR, "unterminated header");
+	return options->error_func(obj, FSCK_ERROR, "unterminated header");
 }
 
-static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
+static int fsck_ident(const char **ident, struct object *obj, struct fsck_options *options)
 {
 	char *end;
 
 	if (**ident == '<')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
 	*ident += strcspn(*ident, "<>\n");
 	if (**ident == '>')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad name");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad name");
 	if (**ident != '<')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing email");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing email");
 	if ((*ident)[-1] != ' ')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
 	(*ident)++;
 	*ident += strcspn(*ident, "<>\n");
 	if (**ident != '>')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad email");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad email");
 	(*ident)++;
 	if (**ident != ' ')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before date");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before date");
 	(*ident)++;
 	if (**ident == '0' && (*ident)[1] != ' ')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - zero-padded date");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - zero-padded date");
 	if (date_overflows(strtoul(*ident, &end, 10)))
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - date causes integer overflow");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - date causes integer overflow");
 	if (end == *ident || *end != ' ')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad date");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad date");
 	*ident = end + 1;
 	if ((**ident != '+' && **ident != '-') ||
 	    !isdigit((*ident)[1]) ||
@@ -295,30 +295,30 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 	    !isdigit((*ident)[3]) ||
 	    !isdigit((*ident)[4]) ||
 	    ((*ident)[5] != '\n'))
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad time zone");
+		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad time zone");
 	(*ident) += 6;
 	return 0;
 }
 
 static int fsck_commit_buffer(struct commit *commit, const char *buffer,
-	unsigned long size, fsck_error error_func)
+	unsigned long size, struct fsck_options *options)
 {
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	unsigned parent_count, parent_line_count = 0;
 	int err;
 
-	if (require_end_of_header(buffer, size, &commit->object, error_func))
+	if (require_end_of_header(buffer, size, &commit->object, options))
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
-		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
+		return options->error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
-		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
+		return options->error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
 	buffer += 41;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
 		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
-			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
+			return options->error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
 		buffer += 41;
 		parent_line_count++;
 	}
@@ -328,39 +328,39 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		if (graft->nr_parent == -1 && !parent_count)
 			; /* shallow commit */
 		else if (graft->nr_parent != parent_count)
-			return error_func(&commit->object, FSCK_ERROR, "graft objects missing");
+			return options->error_func(&commit->object, FSCK_ERROR, "graft objects missing");
 	} else {
 		if (parent_count != parent_line_count)
-			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
+			return options->error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
 	if (!skip_prefix(buffer, "author ", &buffer))
-		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
-	err = fsck_ident(&buffer, &commit->object, error_func);
+		return options->error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
+	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
-		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, &commit->object, error_func);
+		return options->error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
+	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
 	if (!commit->tree)
-		return error_func(&commit->object, FSCK_ERROR, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
+		return options->error_func(&commit->object, FSCK_ERROR, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
 
 	return 0;
 }
 
 static int fsck_commit(struct commit *commit, const char *data,
-	unsigned long size, fsck_error error_func)
+	unsigned long size, struct fsck_options *options)
 {
 	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
-	int ret = fsck_commit_buffer(commit, buffer, size, error_func);
+	int ret = fsck_commit_buffer(commit, buffer, size, options);
 	if (!data)
 		unuse_commit_buffer(commit, buffer);
 	return ret;
 }
 
 static int fsck_tag_buffer(struct tag *tag, const char *data,
-	unsigned long size, fsck_error error_func)
+	unsigned long size, struct fsck_options *options)
 {
 	unsigned char sha1[20];
 	int ret = 0;
@@ -376,65 +376,65 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		buffer = to_free =
 			read_sha1_file(tag->object.sha1, &type, &size);
 		if (!buffer)
-			return error_func(&tag->object, FSCK_ERROR,
+			return options->error_func(&tag->object, FSCK_ERROR,
 				"cannot read tag object");
 
 		if (type != OBJ_TAG) {
-			ret = error_func(&tag->object, FSCK_ERROR,
+			ret = options->error_func(&tag->object, FSCK_ERROR,
 				"expected tag got %s",
 			    typename(type));
 			goto done;
 		}
 	}
 
-	if (require_end_of_header(buffer, size, &tag->object, error_func))
+	if (require_end_of_header(buffer, size, &tag->object, options))
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {
-		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
+		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
 		goto done;
 	}
 	if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n') {
-		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'object' line format - bad sha1");
+		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid 'object' line format - bad sha1");
 		goto done;
 	}
 	buffer += 41;
 
 	if (!skip_prefix(buffer, "type ", &buffer)) {
-		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'type' line");
+		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'type' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
+		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
-		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'type' value");
+		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid 'type' value");
 	if (ret)
 		goto done;
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tag ", &buffer)) {
-		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
+		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
+		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0))
-		error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %.*s",
+		options->error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %.*s",
 			   (int)(eol - buffer), buffer);
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tagger ", &buffer))
 		/* early tags do not contain 'tagger' lines; warn only */
-		error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
+		options->error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
 	else
-		ret = fsck_ident(&buffer, &tag->object, error_func);
+		ret = fsck_ident(&buffer, &tag->object, options);
 
 done:
 	strbuf_release(&sb);
@@ -443,34 +443,34 @@ done:
 }
 
 static int fsck_tag(struct tag *tag, const char *data,
-	unsigned long size, fsck_error error_func)
+	unsigned long size, struct fsck_options *options)
 {
 	struct object *tagged = tag->tagged;
 
 	if (!tagged)
-		return error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
+		return options->error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
 
-	return fsck_tag_buffer(tag, data, size, error_func);
+	return fsck_tag_buffer(tag, data, size, options);
 }
 
 int fsck_object(struct object *obj, void *data, unsigned long size,
-	int strict, fsck_error error_func)
+	struct fsck_options *options)
 {
 	if (!obj)
-		return error_func(obj, FSCK_ERROR, "no valid object to fsck");
+		return options->error_func(obj, FSCK_ERROR, "no valid object to fsck");
 
 	if (obj->type == OBJ_BLOB)
 		return 0;
 	if (obj->type == OBJ_TREE)
-		return fsck_tree((struct tree *) obj, strict, error_func);
+		return fsck_tree((struct tree *) obj, options);
 	if (obj->type == OBJ_COMMIT)
 		return fsck_commit((struct commit *) obj, (const char *) data,
-			size, error_func);
+			size, options);
 	if (obj->type == OBJ_TAG)
 		return fsck_tag((struct tag *) obj, (const char *) data,
-			size, error_func);
+			size, options);
 
-	return error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck error)",
+	return options->error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck error)",
 			  obj->type);
 }
 
diff --git a/fsck.h b/fsck.h
index d1e6387..07d0ab2 100644
--- a/fsck.h
+++ b/fsck.h
@@ -4,6 +4,8 @@
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
 
+struct fsck_options;
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -12,7 +14,7 @@
  *     <0	error signaled and abort
  *     >0	error signaled and do not abort
  */
-typedef int (*fsck_walk_func)(struct object *obj, int type, void *data);
+typedef int (*fsck_walk_func)(struct object *obj, int type, void *data, struct fsck_options *options);
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct object *obj, int type, const char *err, ...);
@@ -20,6 +22,15 @@ typedef int (*fsck_error)(struct object *obj, int type, const char *err, ...);
 __attribute__((format (printf, 3, 4)))
 int fsck_error_function(struct object *obj, int type, const char *fmt, ...);
 
+struct fsck_options {
+	fsck_walk_func walk;
+	fsck_error error_func;
+	unsigned strict:1;
+};
+
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0 }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1 }
+
 /* descend in all linked child objects
  * the return value is:
  *    -1	error in processing the object
@@ -27,9 +38,9 @@ int fsck_error_function(struct object *obj, int type, const char *fmt, ...);
  *    >0	return value of the first signaled error >0 (in the case of no other errors)
  *    0		everything OK
  */
-int fsck_walk(struct object *obj, fsck_walk_func walk, void *data);
+int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 /* If NULL is passed for data, we assume the object is local and read it. */
 int fsck_object(struct object *obj, void *data, unsigned long size,
-	int strict, fsck_error error_func);
+	struct fsck_options *options);
 
 #endif
-- 
2.2.0.33.gc18b867

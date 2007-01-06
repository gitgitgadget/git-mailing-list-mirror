From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/5] Move traversal of reachable objects into a separate library.
Date: Sat, 06 Jan 2007 02:16:17 -0800
Message-ID: <7vtzz45uku.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 11:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38b8-0001Rd-1N
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbXAFKQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXAFKQT
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:16:19 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49828 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXAFKQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:16:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106101618.GGBH16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 05:16:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7mGY1W00X1kojtg0000000; Sat, 06 Jan 2007 05:16:33 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36080>

This moves major part of builtin-prune into a separate file,
reachable.c.  It is used to mark the objects that are reachable
from refs, and optionally from reflogs.

The patch looks very large, but if you look at it with diff -C,
which this message is formatted in, most of them are copied
lines and there are very little additions.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile                       |    1 +
 builtin-prune.c                |  195 +---------------------------------------
 builtin-prune.c => reachable.c |  123 +++----------------------
 reachable.h                    |    6 ++
 4 files changed, 22 insertions(+), 303 deletions(-)
 copy builtin-prune.c => reachable.c (69%)
 create mode 100644 reachable.h

diff --git a/Makefile b/Makefile
index 180e1e0..d8bfb6b 100644
--- a/Makefile
+++ b/Makefile
@@ -251,6 +251,7 @@ LIB_OBJS = \
 	interpolate.o \
 	lockfile.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o sideband.o \
+	reachable.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
diff --git a/builtin-prune.c b/builtin-prune.c
index cd079b4..6f0ba0d 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -1,14 +1,9 @@
 #include "cache.h"
-#include "refs.h"
-#include "tag.h"
 #include "commit.h"
-#include "tree.h"
-#include "blob.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "builtin.h"
-#include "cache-tree.h"
+#include "reachable.h"
 
 static const char prune_usage[] = "git-prune [-n]";
 static int show_only;
@@ -84,168 +79,6 @@ static void prune_object_dir(const char *path)
 	}
 }
 
-static void process_blob(struct blob *blob,
-			 struct object_array *p,
-			 struct name_path *path,
-			 const char *name)
-{
-	struct object *obj = &blob->object;
-
-	if (obj->flags & SEEN)
-		return;
-	obj->flags |= SEEN;
-	/* Nothing to do, really .. The blob lookup was the important part */
-}
-
-static void process_tree(struct tree *tree,
-			 struct object_array *p,
-			 struct name_path *path,
-			 const char *name)
-{
-	struct object *obj = &tree->object;
-	struct tree_desc desc;
-	struct name_entry entry;
-	struct name_path me;
-
-	if (obj->flags & SEEN)
-		return;
-	obj->flags |= SEEN;
-	if (parse_tree(tree) < 0)
-		die("bad tree object %s", sha1_to_hex(obj->sha1));
-	name = xstrdup(name);
-	add_object(obj, p, path, name);
-	me.up = path;
-	me.elem = name;
-	me.elem_len = strlen(name);
-
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
-
-	while (tree_entry(&desc, &entry)) {
-		if (S_ISDIR(entry.mode))
-			process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
-		else
-			process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
-	}
-	free(tree->buffer);
-	tree->buffer = NULL;
-}
-
-static void process_tag(struct tag *tag, struct object_array *p, const char *name)
-{
-	struct object *obj = &tag->object;
-	struct name_path me;
-
-	if (obj->flags & SEEN)
-		return;
-	obj->flags |= SEEN;
-
-	me.up = NULL;
-	me.elem = "tag:/";
-	me.elem_len = 5;
-
-	if (parse_tag(tag) < 0)
-		die("bad tag object %s", sha1_to_hex(obj->sha1));
-	add_object(tag->tagged, p, NULL, name);
-}
-
-static void walk_commit_list(struct rev_info *revs)
-{
-	int i;
-	struct commit *commit;
-	struct object_array objects = { 0, 0, NULL };
-
-	/* Walk all commits, process their trees */
-	while ((commit = get_revision(revs)) != NULL)
-		process_tree(commit->tree, &objects, NULL, "");
-
-	/* Then walk all the pending objects, recursively processing them too */
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object_array_entry *pending = revs->pending.objects + i;
-		struct object *obj = pending->item;
-		const char *name = pending->name;
-		if (obj->type == OBJ_TAG) {
-			process_tag((struct tag *) obj, &objects, name);
-			continue;
-		}
-		if (obj->type == OBJ_TREE) {
-			process_tree((struct tree *)obj, &objects, NULL, name);
-			continue;
-		}
-		if (obj->type == OBJ_BLOB) {
-			process_blob((struct blob *)obj, &objects, NULL, name);
-			continue;
-		}
-		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
-	}
-}
-
-static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *datail, void *cb_data)
-{
-	struct object *object;
-	struct rev_info *revs = (struct rev_info *)cb_data;
-
-	object = parse_object(osha1);
-	if (object)
-		add_pending_object(revs, object, "");
-	object = parse_object(nsha1);
-	if (object)
-		add_pending_object(revs, object, "");
-	return 0;
-}
-
-static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct object *object = parse_object(sha1);
-	struct rev_info *revs = (struct rev_info *)cb_data;
-
-	if (!object)
-		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
-	add_pending_object(revs, object, "");
-
-	return 0;
-}
-
-static int add_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
-{
-	for_each_reflog_ent(path, add_one_reflog_ent, cb_data);
-	return 0;
-}
-
-static void add_one_tree(const unsigned char *sha1, struct rev_info *revs)
-{
-	struct tree *tree = lookup_tree(sha1);
-	add_pending_object(revs, &tree->object, "");
-}
-
-static void add_cache_tree(struct cache_tree *it, struct rev_info *revs)
-{
-	int i;
-
-	if (it->entry_count >= 0)
-		add_one_tree(it->sha1, revs);
-	for (i = 0; i < it->subtree_nr; i++)
-		add_cache_tree(it->down[i]->cache_tree, revs);
-}
-
-static void add_cache_refs(struct rev_info *revs)
-{
-	int i;
-
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		lookup_blob(active_cache[i]->sha1);
-		/*
-		 * We could add the blobs to the pending list, but quite
-		 * frankly, we don't care. Once we've looked them up, and
-		 * added them as objects, we've really done everything
-		 * there is to do for a blob
-		 */
-	}
-	if (active_cache_tree)
-		add_cache_tree(active_cache_tree, revs);
-}
-
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -261,32 +94,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	}
 
 	save_commit_buffer = 0;
-
-	/*
-	 * Set up revision parsing, and mark us as being interested
-	 * in all object types, not just commits.
-	 */
 	init_revisions(&revs, prefix);
-	revs.tag_objects = 1;
-	revs.blob_objects = 1;
-	revs.tree_objects = 1;
-
-	/* Add all external refs */
-	for_each_ref(add_one_ref, &revs);
-
-	/* Add all refs from the index file */
-	add_cache_refs(&revs);
-
-	/* Add all reflog info from refs */
-	for_each_ref(add_one_reflog, &revs);
-
-	/*
-	 * Set up the revision walk - this will move all commits
-	 * from the pending list to the commit walking list.
-	 */
-	prepare_revision_walk(&revs);
-
-	walk_commit_list(&revs);
+	mark_reachable_objects(&revs, 1);
 
 	prune_object_dir(get_object_directory());
 
diff --git a/builtin-prune.c b/reachable.c
similarity index 69%
copy from builtin-prune.c
copy to reachable.c
index cd079b4..4dfee1d 100644
--- a/builtin-prune.c
+++ b/reachable.c
@@ -2,88 +2,12 @@
 #include "refs.h"
 #include "tag.h"
 #include "commit.h"
-#include "tree.h"
 #include "blob.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
-#include "builtin.h"
+#include "reachable.h"
 #include "cache-tree.h"
 
-static const char prune_usage[] = "git-prune [-n]";
-static int show_only;
-
-static int prune_object(char *path, const char *filename, const unsigned char *sha1)
-{
-	char buf[20];
-	const char *type;
-
-	if (show_only) {
-		if (sha1_object_info(sha1, buf, NULL))
-			type = "unknown";
-		else
-			type = buf;
-		printf("%s %s\n", sha1_to_hex(sha1), type);
-		return 0;
-	}
-	unlink(mkpath("%s/%s", path, filename));
-	rmdir(path);
-	return 0;
-}
-
-static int prune_dir(int i, char *path)
-{
-	DIR *dir = opendir(path);
-	struct dirent *de;
-
-	if (!dir)
-		return 0;
-
-	while ((de = readdir(dir)) != NULL) {
-		char name[100];
-		unsigned char sha1[20];
-		int len = strlen(de->d_name);
-
-		switch (len) {
-		case 2:
-			if (de->d_name[1] != '.')
-				break;
-		case 1:
-			if (de->d_name[0] != '.')
-				break;
-			continue;
-		case 38:
-			sprintf(name, "%02x", i);
-			memcpy(name+2, de->d_name, len+1);
-			if (get_sha1_hex(name, sha1) < 0)
-				break;
-
-			/*
-			 * Do we know about this object?
-			 * It must have been reachable
-			 */
-			if (lookup_object(sha1))
-				continue;
-
-			prune_object(path, de->d_name, sha1);
-			continue;
-		}
-		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
-	}
-	closedir(dir);
-	return 0;
-}
-
-static void prune_object_dir(const char *path)
-{
-	int i;
-	for (i = 0; i < 256; i++) {
-		static char dir[4096];
-		sprintf(dir, "%s/%02x", path, i);
-		prune_dir(i, dir);
-	}
-}
-
 static void process_blob(struct blob *blob,
 			 struct object_array *p,
 			 struct name_path *path,
@@ -246,51 +170,30 @@ static void add_cache_refs(struct rev_info *revs)
 		add_cache_tree(active_cache_tree, revs);
 }
 
-int cmd_prune(int argc, const char **argv, const char *prefix)
+void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
 {
-	int i;
-	struct rev_info revs;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "-n")) {
-			show_only = 1;
-			continue;
-		}
-		usage(prune_usage);
-	}
-
-	save_commit_buffer = 0;
-
 	/*
 	 * Set up revision parsing, and mark us as being interested
 	 * in all object types, not just commits.
 	 */
-	init_revisions(&revs, prefix);
-	revs.tag_objects = 1;
-	revs.blob_objects = 1;
-	revs.tree_objects = 1;
-
-	/* Add all external refs */
-	for_each_ref(add_one_ref, &revs);
+	revs->tag_objects = 1;
+	revs->blob_objects = 1;
+	revs->tree_objects = 1;
 
 	/* Add all refs from the index file */
-	add_cache_refs(&revs);
+	add_cache_refs(revs);
+
+	/* Add all external refs */
+	for_each_ref(add_one_ref, revs);
 
 	/* Add all reflog info from refs */
-	for_each_ref(add_one_reflog, &revs);
+	if (mark_reflog)
+		for_each_ref(add_one_reflog, revs);
 
 	/*
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
 	 */
-	prepare_revision_walk(&revs);
-
-	walk_commit_list(&revs);
-
-	prune_object_dir(get_object_directory());
-
-	sync();
-	prune_packed_objects(show_only);
-	return 0;
+	prepare_revision_walk(revs);
+	walk_commit_list(revs);
 }
diff --git a/reachable.h b/reachable.h
new file mode 100644
index 0000000..4075181
--- /dev/null
+++ b/reachable.h
@@ -0,0 +1,6 @@
+#ifndef REACHEABLE_H
+#define REACHEABLE_H
+
+extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog);
+
+#endif

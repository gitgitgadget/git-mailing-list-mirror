From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Separate object listing routines out of rev-list
Date: Tue, 05 Sep 2006 00:30:27 -0700
Message-ID: <7vd5aakbxo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 05 09:33:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKVR7-00059r-3W
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 09:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWIEHda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 03:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWIEHd3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 03:33:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35533 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751236AbWIEHaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 03:30:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905073000.MDLD18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 03:30:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JXW01V00b1kojtg0000000
	Tue, 05 Sep 2006 03:30:01 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26464>

Create a separate file, list-objects.c, and move object listing
routines from rev-list to it.  The next round will use it in
pack-objects directly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile           |    4 +-
 builtin-rev-list.c |  110 ++++++----------------------------------------------
 list-objects.c     |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++
 list-objects.h     |    8 ++++
 4 files changed, 130 insertions(+), 99 deletions(-)

diff --git a/Makefile b/Makefile
index 7b3114f..18cd79e 100644
--- a/Makefile
+++ b/Makefile
@@ -233,7 +233,7 @@ XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
 	blob.h cache.h commit.h csum-file.h delta.h \
-	diff.h object.h pack.h pkt-line.h quote.h refs.h \
+	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
 
@@ -250,7 +250,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	write_or_die.o trace.o \
+	write_or_die.o trace.o list-objects.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8437454..d6dcba2 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -7,6 +7,7 @@ #include "blob.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
+#include "list-objects.h"
 #include "builtin.h"
 
 /* bits #0-15 in revision.h */
@@ -97,104 +98,19 @@ static void show_commit(struct commit *c
 	commit->buffer = NULL;
 }
 
-static void process_blob(struct blob *blob,
-			 struct object_array *p,
-			 struct name_path *path,
-			 const char *name)
+static void show_object(struct object_array_entry *p)
 {
-	struct object *obj = &blob->object;
-
-	if (!revs.blob_objects)
-		return;
-	if (obj->flags & (UNINTERESTING | SEEN))
-		return;
-	obj->flags |= SEEN;
-	name = xstrdup(name);
-	add_object(obj, p, path, name);
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
-	if (!revs.tree_objects)
-		return;
-	if (obj->flags & (UNINTERESTING | SEEN))
-		return;
-	if (parse_tree(tree) < 0)
-		die("bad tree object %s", sha1_to_hex(obj->sha1));
-	obj->flags |= SEEN;
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
-static void show_commit_list(struct rev_info *revs)
-{
-	int i;
-	struct commit *commit;
-	struct object_array objects = { 0, 0, NULL };
-
-	while ((commit = get_revision(revs)) != NULL) {
-		process_tree(commit->tree, &objects, NULL, "");
-		show_commit(commit);
-	}
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object_array_entry *pending = revs->pending.objects + i;
-		struct object *obj = pending->item;
-		const char *name = pending->name;
-		if (obj->flags & (UNINTERESTING | SEEN))
-			continue;
-		if (obj->type == OBJ_TAG) {
-			obj->flags |= SEEN;
-			add_object_array(obj, name, &objects);
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
-	for (i = 0; i < objects.nr; i++) {
-		struct object_array_entry *p = objects.objects + i;
-
-		/* An object with name "foo\n0000000..." can be used to
-		 * confuse downstream git-pack-objects very badly.
-		 */
-		const char *ep = strchr(p->name, '\n');
-		if (ep) {
-			printf("%s %.*s\n", sha1_to_hex(p->item->sha1),
-			       (int) (ep - p->name),
-			       p->name);
-		}
-		else
-			printf("%s %s\n", sha1_to_hex(p->item->sha1), p->name);
+	/* An object with name "foo\n0000000..." can be used to
+	 * confuse downstream git-pack-objects very badly.
+	 */
+	const char *ep = strchr(p->name, '\n');
+	if (ep) {
+		printf("%s %.*s\n", sha1_to_hex(p->item->sha1),
+		       (int) (ep - p->name),
+		       p->name);
 	}
+	else
+		printf("%s %s\n", sha1_to_hex(p->item->sha1), p->name);
 }
 
 /*
@@ -364,7 +280,7 @@ int cmd_rev_list(int argc, const char **
 	if (bisect_list)
 		revs.commits = find_bisection(revs.commits);
 
-	show_commit_list(&revs);
+	traverse_commit_list(&revs, show_commit, show_object);
 
 	return 0;
 }
diff --git a/list-objects.c b/list-objects.c
new file mode 100644
index 0000000..adaf997
--- /dev/null
+++ b/list-objects.c
@@ -0,0 +1,107 @@
+#include "cache.h"
+#include "tag.h"
+#include "commit.h"
+#include "tree.h"
+#include "blob.h"
+#include "diff.h"
+#include "tree-walk.h"
+#include "revision.h"
+#include "list-objects.h"
+
+static void process_blob(struct rev_info *revs,
+			 struct blob *blob,
+			 struct object_array *p,
+			 struct name_path *path,
+			 const char *name)
+{
+	struct object *obj = &blob->object;
+
+	if (!revs->blob_objects)
+		return;
+	if (obj->flags & (UNINTERESTING | SEEN))
+		return;
+	obj->flags |= SEEN;
+	name = xstrdup(name);
+	add_object(obj, p, path, name);
+}
+
+static void process_tree(struct rev_info *revs,
+			 struct tree *tree,
+			 struct object_array *p,
+			 struct name_path *path,
+			 const char *name)
+{
+	struct object *obj = &tree->object;
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct name_path me;
+
+	if (!revs->tree_objects)
+		return;
+	if (obj->flags & (UNINTERESTING | SEEN))
+		return;
+	if (parse_tree(tree) < 0)
+		die("bad tree object %s", sha1_to_hex(obj->sha1));
+	obj->flags |= SEEN;
+	name = xstrdup(name);
+	add_object(obj, p, path, name);
+	me.up = path;
+	me.elem = name;
+	me.elem_len = strlen(name);
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode))
+			process_tree(revs,
+				     lookup_tree(entry.sha1),
+				     p, &me, entry.path);
+		else
+			process_blob(revs,
+				     lookup_blob(entry.sha1),
+				     p, &me, entry.path);
+	}
+	free(tree->buffer);
+	tree->buffer = NULL;
+}
+
+void traverse_commit_list(struct rev_info *revs,
+			  void (*show_commit)(struct commit *),
+			  void (*show_object)(struct object_array_entry *))
+{
+	int i;
+	struct commit *commit;
+	struct object_array objects = { 0, 0, NULL };
+
+	while ((commit = get_revision(revs)) != NULL) {
+		process_tree(revs, commit->tree, &objects, NULL, "");
+		show_commit(commit);
+	}
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object_array_entry *pending = revs->pending.objects + i;
+		struct object *obj = pending->item;
+		const char *name = pending->name;
+		if (obj->flags & (UNINTERESTING | SEEN))
+			continue;
+		if (obj->type == OBJ_TAG) {
+			obj->flags |= SEEN;
+			add_object_array(obj, name, &objects);
+			continue;
+		}
+		if (obj->type == OBJ_TREE) {
+			process_tree(revs, (struct tree *)obj, &objects,
+				     NULL, name);
+			continue;
+		}
+		if (obj->type == OBJ_BLOB) {
+			process_blob(revs, (struct blob *)obj, &objects,
+				     NULL, name);
+			continue;
+		}
+		die("unknown pending object %s (%s)",
+		    sha1_to_hex(obj->sha1), name);
+	}
+	for (i = 0; i < objects.nr; i++)
+		show_object(&objects.objects[i]);
+}
diff --git a/list-objects.h b/list-objects.h
new file mode 100644
index 0000000..8a5fae6
--- /dev/null
+++ b/list-objects.h
@@ -0,0 +1,8 @@
+#ifndef LIST_OBJECTS_H
+#define LIST_OBJECTS_H
+
+void traverse_commit_list(struct rev_info *revs,
+			  void (*show_commit)(struct commit *),
+			  void (*show_object)(struct object_array_entry *));
+
+#endif
-- 
1.4.2.g552e5

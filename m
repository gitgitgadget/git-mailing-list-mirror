From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 01/10] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 22:54:51 +0100
Message-ID: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlIj-0006Td-Tl
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809AbYBYVzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759630AbYBYVzJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:09 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55590 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759490AbYBYVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 56FB6680BF95;
	Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gU73d2gYQSMp; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 26892680B59A; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75072>

The requirements are:
* it may not crash on NULL pointers
* a callback function is needed, as index-pack/unpack-objects
  need to do different things
* the type information is needed to check the expected <-> real type
  and print better error messages

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Makefile |    4 +-
 cache.h  |    1 +
 fsck.c   |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck.h   |   23 +++++++++++++++
 4 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 fsck.c
 create mode 100644 fsck.h

diff --git a/Makefile b/Makefile
index 021520f..3bb2034 100644
--- a/Makefile
+++ b/Makefile
@@ -304,7 +304,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h fsck.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -327,7 +327,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o ws.o archive.o
+	transport.o bundle.o walker.o parse-options.o ws.o archive.o fsck.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/cache.h b/cache.h
index 4fa69f0..3001bc3 100644
--- a/cache.h
+++ b/cache.h
@@ -273,6 +273,7 @@ enum object_type {
 	/* 5 for future expansion */
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
+	OBJ_ANY,
 	OBJ_MAX,
 };
 
diff --git a/fsck.c b/fsck.c
new file mode 100644
index 0000000..b7f9354
--- /dev/null
+++ b/fsck.c
@@ -0,0 +1,91 @@
+#include "cache.h"
+#include "object.h"
+#include "blob.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "commit.h"
+#include "tag.h"
+#include "fsck.h"
+
+static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	int res = 0;
+
+	if (parse_tree(tree))
+		return -1;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		int result;
+		
+		if (S_ISGITLINK(entry.mode))
+			continue;
+		if (S_ISDIR(entry.mode))
+			result = walk(&lookup_tree(entry.sha1)->object, OBJ_TREE, data);
+		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
+			result = walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data);
+		else {
+			result = error("in tree %s: entry %s has bad mode %.6o\n",
+			               sha1_to_hex(tree->object.sha1), entry.path, entry.mode);
+		}
+		if (result < 0)
+			return result;
+		if (!res)
+			res = result;
+	}
+	return res;
+}
+
+static int fsck_walk_commit(struct commit *commit, fsck_walk_func walk, void *data)
+{
+	struct commit_list *parents;
+	int res;
+	int result;
+
+	if (parse_commit(commit))
+		return -1;
+
+	result = walk((struct object*)commit->tree, OBJ_TREE, data);
+	if (result < 0)
+		return result;
+	res = result;
+
+	parents = commit->parents;
+	while (parents) {
+		result = walk((struct object*)parents->item, OBJ_COMMIT, data);
+		if (result < 0)
+			return result;
+		if (!res)
+			res = result;
+		parents = parents->next;
+	}
+	return res;
+}
+
+static int fsck_walk_tag(struct tag *tag, fsck_walk_func walk, void *data)
+{
+	if (parse_tag(tag))
+		return -1;
+	return walk(tag->tagged, OBJ_ANY, data);
+}
+
+int fsck_walk(struct object *obj, fsck_walk_func walk, void *data)
+{
+	if (!obj)
+		return -1;
+	switch(obj->type) {
+	case OBJ_BLOB:
+		return 0;
+	case OBJ_TREE:
+		return fsck_walk_tree((struct tree*)obj, walk, data);
+	case OBJ_COMMIT:
+		return fsck_walk_commit((struct commit*)obj, walk, data);
+	case OBJ_TAG:
+		return fsck_walk_tag((struct tag*)obj, walk, data);
+	default:
+		error("Unknown object type for %s", sha1_to_hex(obj->sha1));
+		return -1;
+	}
+}
diff --git a/fsck.h b/fsck.h
new file mode 100644
index 0000000..4a1f02a
--- /dev/null
+++ b/fsck.h
@@ -0,0 +1,23 @@
+#ifndef GIT_FSCK_H
+#define GIT_FSCK_H
+
+/* 
+ * callback function for fsck_walk
+ * type is the expected type of the object or OBJ_ANY
+ * the return value is:
+ *     0	everything OK
+ *     <0	error signaled and abort
+ *     >0	error signaled and do not abort
+ */
+typedef int (*fsck_walk_func)(struct object *obj, int type, void *data);
+
+/* descend in all linked child objects
+ * the return value is:
+ *    -1	error in processing the object
+ *    <0	return value of the callback, which lead to an abort
+ *    >0	return value of the first sigaled error >0 (in the case of no other errors)
+ *    0		everything OK
+ */
+int fsck_walk(struct object *obj, fsck_walk_func walk, void *data);
+
+#endif
-- 
1.5.4.3.g3c5f

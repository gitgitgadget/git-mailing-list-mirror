From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/4] add generic, type aware object chain walker
Date: Sun, 24 Feb 2008 15:43:54 +0100
Message-ID: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 15:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTI6G-00042C-0B
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 15:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYBXOoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 09:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYBXOoB
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 09:44:01 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:34917 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbYBXOn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 09:43:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 8ECC36CF0060;
	Sun, 24 Feb 2008 15:43:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MsHv2whaHEkD; Sun, 24 Feb 2008 15:43:57 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 62AB5680BB31; Sun, 24 Feb 2008 15:43:57 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74933>

The requirements are:
* it may not crash on NULL pointers
* a callback function is needed, as index-pack/unpack-objects
  need to do different things
* the type information is needed to check the expected <-> real type
  and print better error messages

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Makefile |    4 +-
 fsck.c   |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck.h   |   10 +++++++
 3 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 fsck.c
 create mode 100644 fsck.h

diff --git a/Makefile b/Makefile
index a9b5a67..3b356f8 100644
--- a/Makefile
+++ b/Makefile
@@ -303,7 +303,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h ll-merge.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h ll-merge.h fsck.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -327,7 +327,7 @@ LIB_OBJS = \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
 	transport.o bundle.o walker.o parse-options.o ws.o archive.o branch.o \
-	ll-merge.o
+	ll-merge.o fsck.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/fsck.c b/fsck.c
new file mode 100644
index 0000000..92254fb
--- /dev/null
+++ b/fsck.c
@@ -0,0 +1,84 @@
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
+
+	if(parse_tree(tree))
+		return -1;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while(tree_entry(&desc, &entry)) {
+		int result;
+		
+		if (S_ISGITLINK(entry.mode))
+			continue;
+		if (S_ISDIR(entry.mode))
+			result = walk(&lookup_tree(entry.sha1)->object, OBJ_TREE, data);
+		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
+			result = walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data);
+		else {
+			error("in tree %s: entry %s has bad mode %.6o\n",
+			      sha1_to_hex(tree->object.sha1), entry.path, entry.mode);
+			result = -1;
+		}
+		if (result)
+			return result;
+	}
+	return 0;
+}
+
+static int fsck_walk_commit(struct commit *commit, fsck_walk_func walk, void *data)
+{
+	struct commit_list *parents = commit->parents;
+	int result;
+
+	if(parse_commit(commit))
+		return -1;
+
+	result = walk((struct object*)commit->tree, OBJ_TREE, data);
+	if (result)
+		return result;
+
+	while (parents) {
+		result = walk((struct object*)parents->item, OBJ_COMMIT, data);
+		if (result)
+			return result;
+		parents = parents->next;
+	}
+	return 0;
+}
+
+static int fsck_walk_tag(struct tag *tag, fsck_walk_func walk, void *data)
+{
+	if(parse_tag(tag))
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
index 0000000..fccc89f
--- /dev/null
+++ b/fsck.h
@@ -0,0 +1,10 @@
+#ifndef GIT_FSCK_H
+#define GIT_FSCK_H
+
+#define OBJ_ANY OBJ_BAD
+
+typedef int (*fsck_walk_func)(struct object *obj, int type, void *data);
+
+int fsck_walk(struct object *obj, fsck_walk_func walk, void *data);
+
+#endif
-- 
1.5.4.2.gf624.dirty

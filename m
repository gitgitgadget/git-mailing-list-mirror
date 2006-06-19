From: Linus Torvalds <torvalds@osdl.org>
Subject: Add specialized object allocator
Date: Mon, 19 Jun 2006 10:44:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606191028540.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jun 19 19:45:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsNnf-0002uy-BU
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 19:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWFSRo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 13:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWFSRo0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 13:44:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751241AbWFSRo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 13:44:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5JHiGgt030315
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Jun 2006 10:44:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5JHiFi9004670;
	Mon, 19 Jun 2006 10:44:16 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22131>


This creates a simple specialized object allocator for basic
objects.

This avoids wasting space with malloc overhead (metadata and
extra alignment), since the specialized allocator knows the
alignment, and that objects, once allocated, are never freed.

It also allows us to track some basic statistics about object
allocations. For example, for the mozilla import, it shows
object usage as follows:

     blobs:   627629 (14710 kB)
     trees:  1119035 (34969 kB)
   commits:   196423  (8440 kB)
      tags:     1336    (46 kB)

and the simpler allocator shaves off about 2.5% off the memory
footprint off a "git-rev-list --all --objects", and is a bit
faster too.

[ Side note: this concludes the series of "save memory in object storage". 
  The thing is, there simply isn't much more to be saved on the objects.

  Doing "git-rev-list --all --objects" on the mozilla archive has a final 
  total RSS of 131498 pages for me: that's about 513MB. Of that, the 
  object overhead is now just 56MB, the rest is going somewhere else (put 
  another way: the fact that this patch shaves off 2.5% of the total 
  memory overhead, considering that objects are now not much more than 10% 
  of the total shows how big the wasted space really was: this makes 
  object allocations much more memory- and time-efficient).

  I haven't looked at where the rest is, but I suspect the bulk of it is 
  just the pack-file loading. It may be that we should pack the tree 
  objects separately from the blob objects: for git-rev-list --objects, we 
  don't actually ever need to even look at the blobs, but since trees and 
  blobs are interspersed in the pack-file, we end up not being dense in 
  the tree accesses, so we end up looking at more pages than we strictly 
  need to.

  So with a 535MB pack-file, it's entirely possible - even likely - that 
  most of the remaining RSS is just the mmap of the pack-file itself. We 
  don't need to map in _all_ of it, but we do end up mapping a fair 
  amount. ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---


 Makefile |    2 +-
 alloc.c  |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 blob.c   |    2 +-
 cache.h  |   11 +++++++++++
 commit.c |    2 +-
 tag.c    |    2 +-
 tree.c   |    2 +-
 7 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index ea8cd28..0887945 100644
--- a/Makefile
+++ b/Makefile
@@ -216,7 +216,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	$(DIFF_OBJS)
+	alloc.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
diff --git a/alloc.c b/alloc.c
new file mode 100644
index 0000000..65ec0cc
--- /dev/null
+++ b/alloc.c
@@ -0,0 +1,51 @@
+/*
+ * alloc.c  - specialized allocator for internal objects
+ *
+ * Copyright (C) 2006 Linus Torvalds
+ *
+ * The standard malloc/free wastes too much space for objects, partly because
+ * it maintains all the allocation infrastructure (which isn't needed, since
+ * we never free an object descriptor anyway), but even more because it ends
+ * up with maximal alignment because it doesn't know what the object alignment
+ * for the new allocation is.
+ */
+#include "cache.h"
+#include "object.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "tag.h"
+
+#define BLOCKING 1024
+
+#define DEFINE_ALLOCATOR(name)					\
+static unsigned int name##_allocs;				\
+struct name *alloc_##name##_node(void)				\
+{								\
+	static int nr;						\
+	static struct name *block;				\
+								\
+	if (!nr) {						\
+		nr = BLOCKING;					\
+		block = xcalloc(BLOCKING, sizeof(struct name));	\
+	}							\
+	nr--;							\
+	name##_allocs++;					\
+	return block++;						\
+}
+
+DEFINE_ALLOCATOR(blob);
+DEFINE_ALLOCATOR(tree);
+DEFINE_ALLOCATOR(commit);
+DEFINE_ALLOCATOR(tag);
+
+#define REPORT(name)	\
+	fprintf(stderr, "%10s: %8u (%zu kB)\n", #name, name##_allocs, name##_allocs*sizeof(struct name) >> 10)
+
+void alloc_report(void)
+{
+	REPORT(blob);
+	REPORT(tree);
+	REPORT(commit);
+	REPORT(tag);
+}
diff --git a/blob.c b/blob.c
index 7377008..496f270 100644
--- a/blob.c
+++ b/blob.c
@@ -8,7 +8,7 @@ struct blob *lookup_blob(const unsigned 
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct blob *ret = xcalloc(1, sizeof(struct blob));
+		struct blob *ret = alloc_blob_node();
 		created_object(sha1, &ret->object);
 		ret->object.type = TYPE_BLOB;
 		return ret;
diff --git a/cache.h b/cache.h
index 7fcb6d4..eaa5c0c 100644
--- a/cache.h
+++ b/cache.h
@@ -384,4 +384,15 @@ extern void setup_pager(void);
 int decode_85(char *dst, char *line, int linelen);
 void encode_85(char *buf, unsigned char *data, int bytes);
 
+/* alloc.c */
+struct blob;
+struct tree;
+struct commit;
+struct tag;
+extern struct blob *alloc_blob_node(void);
+extern struct tree *alloc_tree_node(void);
+extern struct commit *alloc_commit_node(void);
+extern struct tag *alloc_tag_node(void);
+extern void alloc_report(void);
+
 #endif /* CACHE_H */
diff --git a/commit.c b/commit.c
index 5914200..0fa1198 100644
--- a/commit.c
+++ b/commit.c
@@ -84,7 +84,7 @@ struct commit *lookup_commit(const unsig
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct commit *ret = xcalloc(1, sizeof(struct commit));
+		struct commit *ret = alloc_commit_node();
 		created_object(sha1, &ret->object);
 		ret->object.type = TYPE_COMMIT;
 		return ret;
diff --git a/tag.c b/tag.c
index 9191333..5f70a5b 100644
--- a/tag.c
+++ b/tag.c
@@ -19,7 +19,7 @@ struct tag *lookup_tag(const unsigned ch
 {
         struct object *obj = lookup_object(sha1);
         if (!obj) {
-                struct tag *ret = xcalloc(1, sizeof(struct tag));
+                struct tag *ret = alloc_tag_node();
                 created_object(sha1, &ret->object);
                 ret->object.type = TYPE_TAG;
                 return ret;
diff --git a/tree.c b/tree.c
index 64422fd..1023655 100644
--- a/tree.c
+++ b/tree.c
@@ -129,7 +129,7 @@ struct tree *lookup_tree(const unsigned 
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct tree *ret = xcalloc(1, sizeof(struct tree));
+		struct tree *ret = alloc_tree_node();
 		created_object(sha1, &ret->object);
 		ret->object.type = TYPE_TREE;
 		return ret;

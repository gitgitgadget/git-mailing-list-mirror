From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] Use proper object allocators for unknown object nodes
 too
Date: Mon, 16 Apr 2007 21:13:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704162112560.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdf4K-0007kj-5Q
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXDQENZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbXDQENZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:13:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34432 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbXDQENY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:13:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3H4DLIs016527
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 21:13:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3H4DK3I019799;
	Mon, 16 Apr 2007 21:13:21 -0700
In-Reply-To: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.952 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44716>


We used to use a different allocator scheme for when we didn't know the
object type.  That meant that objects that were created without any
up-front knowledge of the type would not go through the same allocation
paths as normal object allocations, and would miss out on the statistics.

But perhaps more importantly than the statistics (that are useful when
looking at memory usage but not much else), if we want to make the
object hash tables use a denser object pointer representation, we need
to make sure that they all go through the same blocking allocator.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 alloc.c  |   21 +++++++++++++++------
 cache.h  |    1 +
 object.c |   15 +++------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/alloc.c b/alloc.c
index 460db19..c73aeec 100644
--- a/alloc.c
+++ b/alloc.c
@@ -18,7 +18,7 @@
 
 #define BLOCKING 1024
 
-#define DEFINE_ALLOCATOR(name)					\
+#define DEFINE_ALLOCATOR(name, type)				\
 static unsigned int name##_allocs;				\
 struct name *alloc_##name##_node(void)				\
 {								\
@@ -27,17 +27,26 @@ struct name *alloc_##name##_node(void)				\
 								\
 	if (!nr) {						\
 		nr = BLOCKING;					\
-		block = xcalloc(BLOCKING, sizeof(struct name));	\
+		block = xcalloc(BLOCKING, sizeof(type));	\
 	}							\
 	nr--;							\
 	name##_allocs++;					\
 	return block++;						\
 }
 
-DEFINE_ALLOCATOR(blob)
-DEFINE_ALLOCATOR(tree)
-DEFINE_ALLOCATOR(commit)
-DEFINE_ALLOCATOR(tag)
+union any_object {
+	struct object object;
+	struct blob blob;
+	struct tree tree;
+	struct commit commit;
+	struct tag tag;
+};
+
+DEFINE_ALLOCATOR(blob, struct blob)
+DEFINE_ALLOCATOR(tree, struct tree)
+DEFINE_ALLOCATOR(commit, struct commit)
+DEFINE_ALLOCATOR(tag, struct tag)
+DEFINE_ALLOCATOR(object, union any_object)
 
 #ifdef NO_C99_FORMAT
 #define SZ_FMT "%u"
diff --git a/cache.h b/cache.h
index b1bd9e4..aa72791 100644
--- a/cache.h
+++ b/cache.h
@@ -484,6 +484,7 @@ extern struct blob *alloc_blob_node(void);
 extern struct tree *alloc_tree_node(void);
 extern struct commit *alloc_commit_node(void);
 extern struct tag *alloc_tag_node(void);
+extern struct object *alloc_object_node(void);
 extern void alloc_report(void);
 
 /* trace.c */
diff --git a/object.c b/object.c
index 78a44a6..153ebac 100644
--- a/object.c
+++ b/object.c
@@ -120,22 +120,13 @@ void created_object(const unsigned char *sha1, struct object *obj)
 	nr_objs++;
 }
 
-union any_object {
-	struct object object;
-	struct commit commit;
-	struct tree tree;
-	struct blob blob;
-	struct tag tag;
-};
-
 struct object *lookup_unknown_object(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		union any_object *ret = xcalloc(1, sizeof(*ret));
-		created_object(sha1, &ret->object);
-		ret->object.type = OBJ_NONE;
-		return &ret->object;
+		obj = alloc_object_node();
+		created_object(sha1, obj);
+		obj->type = OBJ_NONE;
 	}
 	return obj;
 }
-- 
1.5.1.1.107.g7a15

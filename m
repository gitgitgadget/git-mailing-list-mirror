From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [FIXED PATCH 1/3] Use proper object allocators for unknown object
 nodes too
Date: Mon, 16 Apr 2007 22:10:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704162208290.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
 <7vfy6zskb4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704162200420.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 07:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfxW-0004XZ-EA
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 07:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031090AbXDQFKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 01:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031095AbXDQFKZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 01:10:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36003 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031090AbXDQFKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 01:10:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3H5AKIs018174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 22:10:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3H5AJ83020863;
	Mon, 16 Apr 2007 22:10:20 -0700
In-Reply-To: <Pine.LNX.4.64.0704162200420.5473@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44730>


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

Gaah. So this should be the properly working version. Not a lot of code 
actually uses the "allocate unknown object", which is why nothing obvious 
broke with the previous version that effectively only allocated a "struct 
object", but it was still a bad bug.

Somebody should triple-check that I didn't screw up *again*.

 alloc.c  |   28 ++++++++++++++++++++--------
 cache.h  |    1 +
 object.c |   15 +++------------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 460db19..53eba37 100644
--- a/alloc.c
+++ b/alloc.c
@@ -18,26 +18,38 @@
 
 #define BLOCKING 1024
 
-#define DEFINE_ALLOCATOR(name)					\
+#define DEFINE_ALLOCATOR(name, type)				\
 static unsigned int name##_allocs;				\
 struct name *alloc_##name##_node(void)				\
 {								\
 	static int nr;						\
-	static struct name *block;				\
+	static type *block;					\
+	void *ret;						\
 								\
 	if (!nr) {						\
 		nr = BLOCKING;					\
-		block = xcalloc(BLOCKING, sizeof(struct name));	\
+		block = xmalloc(BLOCKING * sizeof(type));	\
 	}							\
 	nr--;							\
 	name##_allocs++;					\
-	return block++;						\
+	ret = block++;						\
+	memset(ret, 0, sizeof(type));				\
+	return ret;						\
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

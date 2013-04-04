From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/7] link.c, link.h: introduce fifth object type
Date: Fri,  5 Apr 2013 00:00:37 +0530
Message-ID: <1365100243-13676-2-git-send-email-artagnon@gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNouz-0007TW-TU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764528Ab3DDS3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:18 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35597 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764524Ab3DDS3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:15 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so1555678pdi.8
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hSHw8knxZWPj6VOQuEDA0CjdBHEIpR/+SQYFF1vX7cY=;
        b=jhQpue7i2+Zn1+PvUT61kCnIspcJ7SAS3Spe6VEppF3g1uDjcZXMBMED9iuyOisutd
         O3gO6C5uwx4WsSRHeOidMJAz7GR5qBNHMz2PX5/PAMzVgOdNFcMi4O9Vk6tMgoG7wh2c
         W4KAM+NTGKfsgMh591hMJNGC/EfWEGERqW8WCwHuqmrZmNY2joCuufa4shZE1UK+RoZe
         BSJhrcT6z+6YieRNwwTR8Ep0hVTow+/P/gok4T/eAgTTcwGP9tuMVDhkmbJ7yybtmrIh
         Zjm9+m/cDr3UCr2sVCul+fZTY90UzrLjjSBa9O/IOwI3HY3WE57V8HoTsmAFmKpMrdbz
         NNbA==
X-Received: by 10.68.253.230 with SMTP id ad6mr10268970pbd.116.1365100154711;
        Thu, 04 Apr 2013 11:29:14 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.12
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220049>

Submodules suffer from one major design flaw: they are represented as
commit objects in the tree.  There are several problems with this:

1. Since the object is actually part of the submodule's object
   store (you can't even cat-file the commit), the superproject knows
   very little about the submodule.  We currently work around this by
   having an ugly .gitmodules file in the toplevel directory mapping
   upstream URLs to submodule paths.

2. We are restricted to having a concrete SHA-1 to convey what the
   subproject's HEAD should point to.  As a result, it is impossible
   to have true floating submodules.

3. It is impossible to initialize a nested submodule without
   initializing the containing submodule first.  This is a consequence
   of our .gitmodules hack, and we should really fix it.

4. Always stat'ing all subproject worktrees can be problematic if
   there are very large subprojects; we should be able to turn it off
   for some submodules selectively.  A good future direction would be
   to add more submodule-specific properties, instead of assuming that
   all submodules are equal.  Stuffing more properties into
   .gitmodules is really not a solution.

5. Finally, the git-submodule shell script has lots of horrible warts
   (like cd-to-toplevel for any operation) that are non-trivial to
   fix, and introduces a very unnatural layer of abstraction.

There are various specialized tools like mr, repo, gitslave, and
git-subtree, which offer different compositions solving some problems
while introducing limitations of their own.

We propose to fix the problem for good.  More specifically, introduce
a new object type corresponding to mode 16000 (gitlink).  This new
object will convey all the required information about the individual
submodules to the superproject.  Rework git core to get rid of
.gitmodules and git-submodule altogether.

This patch doesn't do anything by itself: although it is possible to
create link objects using 'git hash-object -t link',
parse_link_buffer() is unimplemented.  In future patches, we intend to
flesh out how core git will handle this object.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile |  2 ++
 alloc.c  |  3 +++
 cache.h  |  3 ++-
 link.c   | 27 +++++++++++++++++++++++++++
 link.h   | 26 ++++++++++++++++++++++++++
 object.c |  9 +++++++++
 6 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 link.c
 create mode 100644 link.h

diff --git a/Makefile b/Makefile
index 0f931a2..cd4b6f9 100644
--- a/Makefile
+++ b/Makefile
@@ -673,6 +673,7 @@ LIB_H += help.h
 LIB_H += http.h
 LIB_H += kwset.h
 LIB_H += levenshtein.h
+LIB_H += link.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
@@ -801,6 +802,7 @@ LIB_OBJS += hex.o
 LIB_OBJS += ident.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
+LIB_OBJS += link.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
diff --git a/alloc.c b/alloc.c
index aeae55c..1445879 100644
--- a/alloc.c
+++ b/alloc.c
@@ -15,6 +15,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "link.h"
 
 #define BLOCKING 1024
 
@@ -49,6 +50,7 @@ DEFINE_ALLOCATOR(blob, struct blob)
 DEFINE_ALLOCATOR(tree, struct tree)
 DEFINE_ALLOCATOR(commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
+DEFINE_ALLOCATOR(link, struct link)
 DEFINE_ALLOCATOR(object, union any_object)
 
 static void report(const char *name, unsigned int count, size_t size)
@@ -66,4 +68,5 @@ void alloc_report(void)
 	REPORT(tree);
 	REPORT(commit);
 	REPORT(tag);
+	REPORT(link);
 }
diff --git a/cache.h b/cache.h
index ec2fd7a..ca0583f 100644
--- a/cache.h
+++ b/cache.h
@@ -317,7 +317,7 @@ enum object_type {
 	OBJ_TREE = 2,
 	OBJ_BLOB = 3,
 	OBJ_TAG = 4,
-	/* 5 for future expansion */
+	OBJ_LINK = 5,
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
 	OBJ_ANY,
@@ -1241,6 +1241,7 @@ extern void *alloc_blob_node(void);
 extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
+extern void *alloc_link_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
 
diff --git a/link.c b/link.c
new file mode 100644
index 0000000..bb20a51
--- /dev/null
+++ b/link.c
@@ -0,0 +1,27 @@
+#include "cache.h"
+#include "link.h"
+
+const char *link_type = "link";
+
+struct link *lookup_link(const unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+	if (!obj)
+		return create_object(sha1, OBJ_LINK, alloc_link_node());
+	if (!obj->type)
+		obj->type = OBJ_LINK;
+	if (obj->type != OBJ_LINK) {
+		error("Object %s is a %s, not a link",
+		      sha1_to_hex(sha1), typename(obj->type));
+		return NULL;
+	}
+	return (struct link *) obj;
+}
+
+int parse_link_buffer(struct link *item, void *buffer, unsigned long size)
+{
+	if (item->object.parsed)
+		return 0;
+	item->object.parsed = 1;
+	return 0;
+}
diff --git a/link.h b/link.h
new file mode 100644
index 0000000..64dd19d
--- /dev/null
+++ b/link.h
@@ -0,0 +1,26 @@
+#ifndef LINK_H
+#define LINK_H
+
+#include "object.h"
+
+extern const char *link_type;
+
+struct link {
+	struct object object;
+	const char *upstream_url;
+	const char *checkout_rev;
+	const char *ref_name;
+	unsigned int floating:1;
+	unsigned int statthrough:1;
+};
+
+struct link *lookup_link(const unsigned char *sha1);
+
+int parse_link_buffer(struct link *item, void *buffer, unsigned long size);
+
+/**
+ * Links do not contain references to other objects, but have
+ * structured data that needs parsing.
+ **/
+
+#endif /* LINK_H */
diff --git a/object.c b/object.c
index 20703f5..d3674ea 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "link.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -24,6 +25,7 @@ static const char *object_type_strings[] = {
 	"tree",		/* OBJ_TREE = 2 */
 	"blob",		/* OBJ_BLOB = 3 */
 	"tag",		/* OBJ_TAG = 4 */
+	"link",		/* OBJ_LINK = 5 */
 };
 
 const char *typename(unsigned int type)
@@ -175,6 +177,13 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			       return NULL;
 			obj = &tag->object;
 		}
+	} else if (type == OBJ_LINK) {
+		struct link *link = lookup_link(sha1);
+		if (link) {
+			if (parse_link_buffer(link, buffer, size))
+			       return NULL;
+			obj = &link->object;
+		}
 	} else {
 		warning("object %s has unknown type id %d", sha1_to_hex(sha1), type);
 		obj = NULL;
-- 
1.8.2.380.g0d4e79b

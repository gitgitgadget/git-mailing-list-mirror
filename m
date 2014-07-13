From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/8] move setting of object->type to alloc_* functions
Date: Sun, 13 Jul 2014 02:41:55 -0400
Message-ID: <20140713064155.GC4852@sigill.intra.peff.net>
References: <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:42:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DU2-0008P1-In
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbaGMGl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:41:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:32932 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752391AbaGMGl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:41:57 -0400
Received: (qmail 30908 invoked by uid 102); 13 Jul 2014 06:41:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:41:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:41:55 -0400
Content-Disposition: inline
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253439>

The "struct object" type implements basic object
polymorphism.  Individual instances are allocated as
concrete types (or as a union type that can store any
object), and a "struct object *" can be cast into its real
type after examining its "type" enum.  This means it is
dangerous to have a type field that does not match the
allocation (e.g., setting the type field of a "struct blob"
to "OBJ_COMMIT" would mean that a reader might read past the
allocated memory).

In most of the current code this is not a problem; the first
thing we do after allocating an object is usually to set its
type field by passing it to create_object. However, the
virtual commits we create in merge-recursive.c do not ever
get their type set. This does not seem to have caused
problems in practice, though (presumably because we always
pass around a "struct commit" pointer and never even look at
the type).

We can fix this oversight and also make it harder for future
code to get it wrong by setting the type directly in the
object allocation functions.

This will also make it easier to fix problems with commit
index allocation, as we know that any object allocated by
alloc_commit_node will meet the invariant that an object
with an OBJ_COMMIT type field will have a unique index
number.

Signed-off-by: Jeff King <peff@peff.net>
---
 alloc.c         | 5 +++++
 blob.c          | 2 +-
 builtin/blame.c | 1 -
 commit.c        | 6 ++----
 object.c        | 5 ++---
 object.h        | 2 +-
 tag.c           | 2 +-
 tree.c          | 2 +-
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/alloc.c b/alloc.c
index 03e458b..fd2e32d 100644
--- a/alloc.c
+++ b/alloc.c
@@ -52,6 +52,7 @@ static struct alloc_state blob_state;
 void *alloc_blob_node(void)
 {
 	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
+	b->object.type = OBJ_BLOB;
 	return b;
 }
 
@@ -59,6 +60,7 @@ static struct alloc_state tree_state;
 void *alloc_tree_node(void)
 {
 	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
+	t->object.type = OBJ_TREE;
 	return t;
 }
 
@@ -66,6 +68,7 @@ static struct alloc_state tag_state;
 void *alloc_tag_node(void)
 {
 	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
+	t->object.type = OBJ_TAG;
 	return t;
 }
 
@@ -73,6 +76,7 @@ static struct alloc_state object_state;
 void *alloc_object_node(void)
 {
 	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
+	obj->type = OBJ_NONE;
 	return obj;
 }
 
@@ -82,6 +86,7 @@ void *alloc_commit_node(void)
 {
 	static int commit_count;
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
+	c->object.type = OBJ_COMMIT;
 	c->index = commit_count++;
 	return c;
 }
diff --git a/blob.c b/blob.c
index ae320bd..5720a38 100644
--- a/blob.c
+++ b/blob.c
@@ -7,7 +7,7 @@ struct blob *lookup_blob(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
-		return create_object(sha1, OBJ_BLOB, alloc_blob_node());
+		return create_object(sha1, alloc_blob_node());
 	if (!obj->type)
 		obj->type = OBJ_BLOB;
 	if (obj->type != OBJ_BLOB) {
diff --git a/builtin/blame.c b/builtin/blame.c
index d3b256e..8f3e311 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2287,7 +2287,6 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit = alloc_commit_node();
 	commit->object.parsed = 1;
 	commit->date = now;
-	commit->object.type = OBJ_COMMIT;
 	parent_tail = &commit->parents;
 
 	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
diff --git a/commit.c b/commit.c
index acb74b5..c1815c8 100644
--- a/commit.c
+++ b/commit.c
@@ -61,10 +61,8 @@ struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_n
 struct commit *lookup_commit(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
-	if (!obj) {
-		struct commit *c = alloc_commit_node();
-		return create_object(sha1, OBJ_COMMIT, c);
-	}
+	if (!obj)
+		return create_object(sha1, alloc_commit_node());
 	if (!obj->type)
 		obj->type = OBJ_COMMIT;
 	return check_commit(obj, sha1, 0);
diff --git a/object.c b/object.c
index 9c31e9a..a950b85 100644
--- a/object.c
+++ b/object.c
@@ -141,13 +141,12 @@ static void grow_object_hash(void)
 	obj_hash_size = new_hash_size;
 }
 
-void *create_object(const unsigned char *sha1, int type, void *o)
+void *create_object(const unsigned char *sha1, void *o)
 {
 	struct object *obj = o;
 
 	obj->parsed = 0;
 	obj->used = 0;
-	obj->type = type;
 	obj->flags = 0;
 	hashcpy(obj->sha1, sha1);
 
@@ -163,7 +162,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
-		obj = create_object(sha1, OBJ_NONE, alloc_object_node());
+		obj = create_object(sha1, alloc_object_node());
 	return obj;
 }
 
diff --git a/object.h b/object.h
index 6e12f2c..8020ace 100644
--- a/object.h
+++ b/object.h
@@ -79,7 +79,7 @@ extern struct object *get_indexed_object(unsigned int);
  */
 struct object *lookup_object(const unsigned char *sha1);
 
-extern void *create_object(const unsigned char *sha1, int type, void *obj);
+extern void *create_object(const unsigned char *sha1, void *obj);
 
 /*
  * Returns the object, having parsed it to find out what it is.
diff --git a/tag.c b/tag.c
index 7b07921..79552c7 100644
--- a/tag.c
+++ b/tag.c
@@ -40,7 +40,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
-		return create_object(sha1, OBJ_TAG, alloc_tag_node());
+		return create_object(sha1, alloc_tag_node());
 	if (!obj->type)
 		obj->type = OBJ_TAG;
 	if (obj->type != OBJ_TAG) {
diff --git a/tree.c b/tree.c
index c8c49d7..ed66575 100644
--- a/tree.c
+++ b/tree.c
@@ -183,7 +183,7 @@ struct tree *lookup_tree(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
-		return create_object(sha1, OBJ_TREE, alloc_tree_node());
+		return create_object(sha1, alloc_tree_node());
 	if (!obj->type)
 		obj->type = OBJ_TREE;
 	if (obj->type != OBJ_TREE) {
-- 
2.0.0.566.gfe3e6b2

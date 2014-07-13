From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/8] add object_as_type helper for casting objects
Date: Sun, 13 Jul 2014 02:42:03 -0400
Message-ID: <20140713064203.GE4852@sigill.intra.peff.net>
References: <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:42:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DUD-00009x-F6
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbaGMGmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:42:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:32939 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752817AbaGMGmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:42:05 -0400
Received: (qmail 30942 invoked by uid 102); 13 Jul 2014 06:42:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:42:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:42:03 -0400
Content-Disposition: inline
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253442>

When we call lookup_commit, lookup_tree, etc, the logic goes
something like:

  1. Look for an existing object struct. If we don't have
     one, allocate and return a new one.

  2. Double check that any object we have is the expected
     type (and complain and return NULL otherwise).

  3. Convert an object with type OBJ_NONE (from a prior
     call to lookup_unknown_object) to the expected type.

We can encapsulate steps 2 and 3 in a helper function which
checks whether we have the expected object type, converts
OBJ_NONE as appropriate, and returns the object.

Not only does this shorten the code, but it also provides
one central location for converting OBJ_NONE objects into
objects of other types. Future patches will use that to
enforce type-specific invariants.

Since this is a refactoring, we would want it to behave
exactly as the current code. It takes a little reasoning to
see that this is the case:

  - for lookup_{commit,tree,etc} functions, we are just
    pulling steps 2 and 3 into a function that does the same
    thing.

  - for the call in peel_object, we currently only do step 3
    (but we want to consolidate it with the others, as
    mentioned above). However, step 2 is a noop here, as the
    surrounding conditional makes sure we have OBJ_NONE
    (which we want to keep to avoid an extraneous call to
    sha1_object_info).

  - for the call in lookup_commit_reference_gently, we are
    currently doing step 2 but not step 3. However, step 3
    is a noop here. The object we got will have just come
    from deref_tag, which must have figured out the type for
    each object in order to know when to stop peeling.
    Therefore the type will never be OBJ_NONE.

Signed-off-by: Jeff King <peff@peff.net>
---
 blob.c   |  9 +--------
 commit.c | 19 ++-----------------
 object.c | 17 +++++++++++++++++
 object.h |  2 ++
 refs.c   |  3 +--
 tag.c    |  9 +--------
 tree.c   |  9 +--------
 7 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/blob.c b/blob.c
index 5720a38..1fcb8e4 100644
--- a/blob.c
+++ b/blob.c
@@ -8,14 +8,7 @@ struct blob *lookup_blob(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
 		return create_object(sha1, alloc_blob_node());
-	if (!obj->type)
-		obj->type = OBJ_BLOB;
-	if (obj->type != OBJ_BLOB) {
-		error("Object %s is a %s, not a blob",
-		      sha1_to_hex(sha1), typename(obj->type));
-		return NULL;
-	}
-	return (struct blob *) obj;
+	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
diff --git a/commit.c b/commit.c
index c1815c8..08816d3 100644
--- a/commit.c
+++ b/commit.c
@@ -18,19 +18,6 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
-static struct commit *check_commit(struct object *obj,
-				   const unsigned char *sha1,
-				   int quiet)
-{
-	if (obj->type != OBJ_COMMIT) {
-		if (!quiet)
-			error("Object %s is a %s, not a commit",
-			      sha1_to_hex(sha1), typename(obj->type));
-		return NULL;
-	}
-	return (struct commit *) obj;
-}
-
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 					      int quiet)
 {
@@ -38,7 +25,7 @@ struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 
 	if (!obj)
 		return NULL;
-	return check_commit(obj, sha1, quiet);
+	return object_as_type(obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference(const unsigned char *sha1)
@@ -63,9 +50,7 @@ struct commit *lookup_commit(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
 		return create_object(sha1, alloc_commit_node());
-	if (!obj->type)
-		obj->type = OBJ_COMMIT;
-	return check_commit(obj, sha1, 0);
+	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/object.c b/object.c
index 472aa8d..b2319f6 100644
--- a/object.c
+++ b/object.c
@@ -158,6 +158,23 @@ void *create_object(const unsigned char *sha1, void *o)
 	return obj;
 }
 
+void *object_as_type(struct object *obj, enum object_type type, int quiet)
+{
+	if (obj->type == type)
+		return obj;
+	else if (obj->type == OBJ_NONE) {
+		obj->type = type;
+		return obj;
+	}
+	else {
+		if (!quiet)
+			error("object %s is a %s, not a %s",
+			      sha1_to_hex(obj->sha1),
+			      typename(obj->type), typename(type));
+		return NULL;
+	}
+}
+
 struct object *lookup_unknown_object(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
diff --git a/object.h b/object.h
index 8020ace..5e8d8ee 100644
--- a/object.h
+++ b/object.h
@@ -81,6 +81,8 @@ struct object *lookup_object(const unsigned char *sha1);
 
 extern void *create_object(const unsigned char *sha1, void *obj);
 
+void *object_as_type(struct object *obj, enum object_type type, int quiet);
+
 /*
  * Returns the object, having parsed it to find out what it is.
  *
diff --git a/refs.c b/refs.c
index 82e4842..7f8960d 100644
--- a/refs.c
+++ b/refs.c
@@ -1730,9 +1730,8 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
 
 	if (o->type == OBJ_NONE) {
 		int type = sha1_object_info(name, NULL);
-		if (type < 0)
+		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
-		o->type = type;
 	}
 
 	if (o->type != OBJ_TAG)
diff --git a/tag.c b/tag.c
index 79552c7..82d841b 100644
--- a/tag.c
+++ b/tag.c
@@ -41,14 +41,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
 		return create_object(sha1, alloc_tag_node());
-	if (!obj->type)
-		obj->type = OBJ_TAG;
-	if (obj->type != OBJ_TAG) {
-		error("Object %s is a %s, not a tag",
-		      sha1_to_hex(sha1), typename(obj->type));
-		return NULL;
-	}
-	return (struct tag *) obj;
+	return object_as_type(obj, OBJ_TAG, 0);
 }
 
 static unsigned long parse_tag_date(const char *buf, const char *tail)
diff --git a/tree.c b/tree.c
index ed66575..bb02c1c 100644
--- a/tree.c
+++ b/tree.c
@@ -184,14 +184,7 @@ struct tree *lookup_tree(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
 		return create_object(sha1, alloc_tree_node());
-	if (!obj->type)
-		obj->type = OBJ_TREE;
-	if (obj->type != OBJ_TREE) {
-		error("Object %s is a %s, not a tree",
-		      sha1_to_hex(sha1), typename(obj->type));
-		return NULL;
-	}
-	return (struct tree *) obj;
+	return object_as_type(obj, OBJ_TREE, 0);
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
-- 
2.0.0.566.gfe3e6b2

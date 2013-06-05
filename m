From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] clear parsed flag when we free tree buffers
Date: Wed, 5 Jun 2013 18:37:39 -0400
Message-ID: <20130605223739.GA15607@sigill.intra.peff.net>
References: <20130605223551.GF8664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Harvey <iharvey@good.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 00:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkMKw-0004Un-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 00:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045Ab3FEWhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 18:37:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:54324 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757840Ab3FEWhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 18:37:42 -0400
Received: (qmail 16836 invoked by uid 102); 5 Jun 2013 22:38:28 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 17:38:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 18:37:39 -0400
Content-Disposition: inline
In-Reply-To: <20130605223551.GF8664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226472>

Many code paths will free a tree object's buffer and set it
to NULL after finishing with it in order to keep memory
usage down during a traversal. However, out of 8 sites that
do this, only one actually unsets the "parsed" flag back.
Those sites that don't are setting a trap for later users of
the tree object; even after calling parse_tree, the buffer
will remain NULL, causing potential segfaults.

It is not known whether this is triggerable in the current
code. Most commands do not do an in-memory traversal
followed by actually using the objects again. However, it
does not hurt to be safe for future callers.

In most cases, we can abstract this out to a
"free_tree_buffer" helper. However, there are two
exceptions:

  1. The fsck code relies on the parsed flag to know that we
     were able to parse the object at one point. We can
     switch this to using a flag in the "flags" field.

  2. The index-pack code sets the buffer to NULL but does
     not free it (it is freed by a caller). We should still
     unset the parsed flag here, but we cannot use our
     helper, as we do not want to free the buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
This shouldn't have any behavior change, but I'd worry a bit that I
missed some case in builtin/fsck.c where the new HAS_OBJ flag would need
set.

 builtin/fsck.c       | 17 ++++++++---------
 builtin/index-pack.c |  1 +
 builtin/reflog.c     |  3 +--
 http-push.c          |  3 +--
 list-objects.c       |  3 +--
 reachable.c          |  3 +--
 revision.c           |  3 +--
 tree.c               |  8 ++++++++
 tree.h               |  1 +
 walker.c             |  5 +----
 10 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb9a2cd..579fdcc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -16,6 +16,7 @@
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
+#define HAS_OBJ   0x0004
 
 static int show_root;
 static int show_tags;
@@ -101,7 +102,7 @@ static int mark_object(struct object *obj, int type, void *data)
 	if (obj->flags & REACHABLE)
 		return 0;
 	obj->flags |= REACHABLE;
-	if (!obj->parsed) {
+	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_sha1_file(obj->sha1)) {
 			printf("broken link from %7s %s\n",
 				 typename(parent->type), sha1_to_hex(parent->sha1));
@@ -127,16 +128,13 @@ static int traverse_one_object(struct object *obj)
 	struct tree *tree = NULL;
 
 	if (obj->type == OBJ_TREE) {
-		obj->parsed = 0;
 		tree = (struct tree *)obj;
 		if (parse_tree(tree) < 0)
 			return 1; /* error already displayed */
 	}
 	result = fsck_walk(obj, mark_object, obj);
-	if (tree) {
-		free(tree->buffer);
-		tree->buffer = NULL;
-	}
+	if (tree)
+		free_tree_buffer(tree);
 	return result;
 }
 
@@ -178,7 +176,7 @@ static void check_reachable_object(struct object *obj)
 	 * except if it was in a pack-file and we didn't
 	 * do a full fsck
 	 */
-	if (!obj->parsed) {
+	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->sha1))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
@@ -306,8 +304,7 @@ static int fsck_obj(struct object *obj)
 	if (obj->type == OBJ_TREE) {
 		struct tree *item = (struct tree *) obj;
 
-		free(item->buffer);
-		item->buffer = NULL;
+		free_tree_buffer(item);
 	}
 
 	if (obj->type == OBJ_COMMIT) {
@@ -340,6 +337,7 @@ static int fsck_sha1(const unsigned char *sha1)
 		return error("%s: object corrupt or missing",
 			     sha1_to_hex(sha1));
 	}
+	obj->flags |= HAS_OBJ;
 	return fsck_obj(obj);
 }
 
@@ -352,6 +350,7 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 		errors_found |= ERROR_OBJECT;
 		return error("%s: object corrupt or missing", sha1_to_hex(sha1));
 	}
+	obj->flags = HAS_OBJ;
 	return fsck_obj(obj);
 }
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 79dfe47..20cf284 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -765,6 +765,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (obj->type == OBJ_TREE) {
 				struct tree *item = (struct tree *) obj;
 				item->buffer = NULL;
+				obj->parsed = 0;
 			}
 			if (obj->type == OBJ_COMMIT) {
 				struct commit *commit = (struct commit *) obj;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 54184b3..ba27f7c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -94,8 +94,7 @@ static int tree_is_complete(const unsigned char *sha1)
 			complete = 0;
 		}
 	}
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_tree_buffer(tree);
 
 	if (complete)
 		tree->object.flags |= SEEN;
diff --git a/http-push.c b/http-push.c
index 395a8cf..c13b441 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1330,8 +1330,7 @@ static struct object_list **process_tree(struct tree *tree,
 			break;
 		}
 
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_tree_buffer(tree);
 	return p;
 }
 
diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..c8c3463 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -123,8 +123,7 @@ static void process_tree(struct rev_info *revs,
 				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_tree_buffer(tree);
 }
 
 static void mark_edge_parents_uninteresting(struct commit *commit,
diff --git a/reachable.c b/reachable.c
index e7e6a1e..654a8c5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -80,8 +80,7 @@ static void process_tree(struct tree *tree,
 		else
 			process_blob(lookup_blob(entry.sha1), p, &me, entry.path, cp);
 	}
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_tree_buffer(tree);
 }
 
 static void process_tag(struct tag *tag, struct object_array *p,
diff --git a/revision.c b/revision.c
index 518cd08..eb988ee 100644
--- a/revision.c
+++ b/revision.c
@@ -135,8 +135,7 @@ void mark_tree_uninteresting(struct tree *tree)
 	 * We don't care about the tree any more
 	 * after it has been marked uninteresting.
 	 */
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_tree_buffer(tree);
 }
 
 void mark_parents_uninteresting(struct commit *commit)
diff --git a/tree.c b/tree.c
index 62fed63..1cbf60e 100644
--- a/tree.c
+++ b/tree.c
@@ -225,6 +225,14 @@ int parse_tree(struct tree *item)
 	return parse_tree_buffer(item, buffer, size);
 }
 
+void free_tree_buffer(struct tree *tree)
+{
+	free(tree->buffer);
+	tree->buffer = NULL;
+	tree->size = 0;
+	tree->object.parsed = 0;
+}
+
 struct tree *parse_tree_indirect(const unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
diff --git a/tree.h b/tree.h
index 69bcb5e..601ab9c 100644
--- a/tree.h
+++ b/tree.h
@@ -16,6 +16,7 @@ int parse_tree(struct tree *tree);
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
 int parse_tree(struct tree *tree);
+void free_tree_buffer(struct tree *tree);
 
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const unsigned char *sha1);
diff --git a/walker.c b/walker.c
index be389dc..633596e 100644
--- a/walker.c
+++ b/walker.c
@@ -56,10 +56,7 @@ static int process_tree(struct walker *walker, struct tree *tree)
 		if (!obj || process(walker, obj))
 			return -1;
 	}
-	free(tree->buffer);
-	tree->buffer = NULL;
-	tree->size = 0;
-	tree->object.parsed = 0;
+	free_tree_buffer(tree);
 	return 0;
 }
 
-- 
1.8.3.rc2.14.g7eee6b3

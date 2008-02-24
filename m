From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/4] builtin-fsck: move away from object-refs
Date: Sun, 24 Feb 2008 15:43:55 +0100
Message-ID: <1203864237774-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 15:45:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTI6F-00042C-4y
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 15:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbYBXOoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 09:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYBXOoA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 09:44:00 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:34915 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYBXOn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 09:43:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id A293D680BB31;
	Sun, 24 Feb 2008 15:43:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K+cPfu8Q6dML; Sun, 24 Feb 2008 15:43:57 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7476D680BF8C; Sun, 24 Feb 2008 15:43:57 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74934>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
reachable.c is not the optimal thing for checking a repository.
Some problems are ignored by it while it bails out on other errors.

fsck should not bail out at the first error (well, there are some
die in tree-walk.c), so the fsck_walk callbacks return 0, even in
the case of an error. The error is propagated via errors_found.

The patch is slightly tested.

 builtin-fsck.c |   95 +++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cc7524b..512346a 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -8,6 +8,7 @@
 #include "pack.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
+#include "fsck.h"
 #include "parse-options.h"
 
 #define REACHABLE 0x0001
@@ -63,13 +64,70 @@ static int objwarning(struct object *obj, const char *err, ...)
 	return -1;
 }
 
+static int mark_object(struct object *obj, int type, void *data)
+{
+	struct tree *tree = NULL;
+	struct object *parent = data;
+
+	if (!obj) {
+		printf("broken link from %7s %s\n",
+			   typename(parent->type), sha1_to_hex(parent->sha1));
+		printf("broken link from %7s %s\n",
+			   (type==OBJ_ANY?"unknown":typename(type)), "unknown");
+		errors_found |= ERROR_REACHABLE;
+		return 0;
+	}
+
+	if (type != OBJ_ANY && obj->type != type) {
+		objerror(parent, "wrong object type in link");
+	}
+
+	if (obj->flags & REACHABLE)
+		return 0;
+	obj->flags |= REACHABLE;
+	if (!obj->parsed) {
+		if (parent && !has_sha1_file(obj->sha1)) {
+			printf("broken link from %7s %s\n",
+				 typename(parent->type), sha1_to_hex(parent->sha1));
+			printf("              to %7s %s\n",
+				 typename(obj->type), sha1_to_hex(obj->sha1));
+			errors_found |= ERROR_REACHABLE;
+		}
+		return 0;
+	}
+
+	if (obj->type == OBJ_TREE) {
+		obj->parsed = 0;
+		tree = (struct tree*)obj;
+		if (parse_tree(tree) < 0)
+			return 0; /* error already displayed */
+	}
+	fsck_walk(obj, mark_object, obj);
+	if (tree) {
+		free(tree->buffer);
+		tree->buffer=NULL;
+	}
+	return 0;
+}
+
+static void mark_object_reachable(struct object *obj)
+{
+	mark_object(obj, OBJ_ANY, 0);
+}
+
+static int mark_used(struct object *obj, int type, void *data)
+{
+	if (!obj)
+		return 0;
+	obj->used = 1;
+	return 0;
+}
+
 /*
  * Check a single reachable object
  */
 static void check_reachable_object(struct object *obj)
 {
-	const struct object_refs *refs;
-
 	/*
 	 * We obviously want the object to be parsed,
 	 * except if it was in a pack-file and we didn't
@@ -82,25 +140,6 @@ static void check_reachable_object(struct object *obj)
 		errors_found |= ERROR_REACHABLE;
 		return;
 	}
-
-	/*
-	 * Check that everything that we try to reference is also good.
-	 */
-	refs = lookup_object_refs(obj);
-	if (refs) {
-		unsigned j;
-		for (j = 0; j < refs->count; j++) {
-			struct object *ref = refs->ref[j];
-			if (ref->parsed ||
-			    (has_sha1_file(ref->sha1)))
-				continue;
-			printf("broken link from %7s %s\n",
-			       typename(obj->type), sha1_to_hex(obj->sha1));
-			printf("              to %7s %s\n",
-			       typename(ref->type), sha1_to_hex(ref->sha1));
-			errors_found |= ERROR_REACHABLE;
-		}
-	}
 }
 
 /*
@@ -414,6 +453,7 @@ static int fsck_sha1(const unsigned char *sha1)
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |= SEEN;
+	fsck_walk (obj, mark_used, 0);
 	if (obj->type == OBJ_BLOB)
 		return 0;
 	if (obj->type == OBJ_TREE)
@@ -538,13 +578,13 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		obj = lookup_object(osha1);
 		if (obj) {
 			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 		}
 	}
 	obj = lookup_object(nsha1);
 	if (obj) {
 		obj->used = 1;
-		mark_reachable(obj, REACHABLE);
+		mark_object_reachable(obj);
 	}
 	return 0;
 }
@@ -574,7 +614,7 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 		error("%s: not a commit", refname);
 	default_refs++;
 	obj->used = 1;
-	mark_reachable(obj, REACHABLE);
+	mark_object_reachable(obj);
 
 	return 0;
 }
@@ -660,7 +700,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 			      sha1_to_hex(it->sha1));
 			return 1;
 		}
-		mark_reachable(obj, REACHABLE);
+		mark_object_reachable(obj);
 		obj->used = 1;
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
@@ -693,7 +733,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
 
-	track_object_refs = 1;
 	errors_found = 0;
 
 	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
@@ -741,7 +780,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 
 			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 			heads++;
 			continue;
 		}
@@ -773,7 +812,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 			obj = &blob->object;
 			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 		}
 		if (active_cache_tree)
 			fsck_cache_tree(active_cache_tree);
-- 
1.5.4.2.gf624.dirty

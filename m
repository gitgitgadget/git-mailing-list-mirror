From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 02/10] builtin-fsck: move away from object-refs to fsck_walk
Date: Mon, 25 Feb 2008 22:54:52 +0100
Message-ID: <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlIl-0006Td-DE
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148AbYBYVzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759490AbYBYVzN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:13 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55592 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493AbYBYVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 622CA684E78A;
	Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ITQvtedwsNxP; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2D78F680B59E; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75073>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |  100 ++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cc7524b..a2e6f53 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -8,6 +8,7 @@
 #include "pack.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
+#include "fsck.h"
 #include "parse-options.h"
 
 #define REACHABLE 0x0001
@@ -63,13 +64,74 @@ static int objwarning(struct object *obj, const char *err, ...)
 	return -1;
 }
 
+static int mark_object(struct object *obj, int type, void *data)
+{
+	struct tree *tree = NULL;
+	struct object *parent = data;
+	int result;
+
+	if (!obj) {
+		printf("broken link from %7s %s\n",
+			   typename(parent->type), sha1_to_hex(parent->sha1));
+		printf("broken link from %7s %s\n",
+			   (type==OBJ_ANY?"unknown":typename(type)), "unknown");
+		errors_found |= ERROR_REACHABLE;
+		return 1;
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
+		return 1;
+	}
+
+	if (obj->type == OBJ_TREE) {
+		obj->parsed = 0;
+		tree = (struct tree*)obj;
+		if (parse_tree(tree) < 0)
+			return 1; /* error already displayed */
+	}
+	result = fsck_walk(obj, mark_object, obj);
+	if (tree) {
+		free(tree->buffer);
+		tree->buffer=NULL;
+	}
+	if (result < 0) 
+		result = 1;
+	
+	return result;
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
+		return 1;
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
@@ -82,25 +144,6 @@ static void check_reachable_object(struct object *obj)
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
@@ -414,6 +457,8 @@ static int fsck_sha1(const unsigned char *sha1)
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |= SEEN;
+	if (fsck_walk(obj, mark_used, 0))
+		objerror(obj, "broken links");
 	if (obj->type == OBJ_BLOB)
 		return 0;
 	if (obj->type == OBJ_TREE)
@@ -538,13 +583,13 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
@@ -574,7 +619,7 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 		error("%s: not a commit", refname);
 	default_refs++;
 	obj->used = 1;
-	mark_reachable(obj, REACHABLE);
+	mark_object_reachable(obj);
 
 	return 0;
 }
@@ -660,7 +705,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 			      sha1_to_hex(it->sha1));
 			return 1;
 		}
-		mark_reachable(obj, REACHABLE);
+		mark_object_reachable(obj);
 		obj->used = 1;
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
@@ -693,7 +738,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
 
-	track_object_refs = 1;
 	errors_found = 0;
 
 	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
@@ -741,7 +785,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 
 			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 			heads++;
 			continue;
 		}
@@ -773,7 +817,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 			obj = &blob->object;
 			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 		}
 		if (active_cache_tree)
 			fsck_cache_tree(active_cache_tree);
-- 
1.5.4.3.g3c5f

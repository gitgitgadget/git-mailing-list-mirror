From: Jeff King <peff@peff.net>
Subject: [PATCH v2 06/25] reachable: use traverse_commit_list instead of
 custom walk
Date: Wed, 15 Oct 2014 18:37:28 -0400
Message-ID: <20141015223728.GF25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:37:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXCJ-0005am-IO
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbaJOWhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:37:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:58939 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbaJOWhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:37:31 -0400
Received: (qmail 2227 invoked by uid 102); 15 Oct 2014 22:37:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:37:31 -0500
Received: (qmail 27947 invoked by uid 107); 15 Oct 2014 22:37:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:37:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:37:28 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To find the set of reachable objects, we add a bunch of
possible sources to our rev_info, call prepare_revision_walk,
and then launch into a custom walker that handles each
object top. This is a subset of what traverse_commit_list
does, so we can just reuse that code (it can also handle
more complex cases like UNINTERESTING commits and pathspecs,
but we don't use those features).

Signed-off-by: Jeff King <peff@peff.net>
---
I was concerned this would be slower because traverse_commit_list is
more featureful. To my surprise, it was consistently about 3-4% faster!
The major difference is that traverse_commit_list will hit all of the
commits first, and then the trees. For reachability that doesn't matter
either way, but I suspect the new way has slightly better cache
locality, leading to the minor speedup.

 reachable.c | 130 ++++++++----------------------------------------------------
 1 file changed, 17 insertions(+), 113 deletions(-)

diff --git a/reachable.c b/reachable.c
index 6f6835b..02bf6c2 100644
--- a/reachable.c
+++ b/reachable.c
@@ -8,6 +8,7 @@
 #include "reachable.h"
 #include "cache-tree.h"
 #include "progress.h"
+#include "list-objects.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -21,118 +22,6 @@ static void update_progress(struct connectivity_progress *cp)
 		display_progress(cp->progress, cp->count);
 }
 
-static void process_blob(struct blob *blob,
-			 struct object_array *p,
-			 struct name_path *path,
-			 const char *name,
-			 struct connectivity_progress *cp)
-{
-	struct object *obj = &blob->object;
-
-	if (!blob)
-		die("bad blob object");
-	if (obj->flags & SEEN)
-		return;
-	obj->flags |= SEEN;
-	update_progress(cp);
-	/* Nothing to do, really .. The blob lookup was the important part */
-}
-
-static void process_gitlink(const unsigned char *sha1,
-			    struct object_array *p,
-			    struct name_path *path,
-			    const char *name)
-{
-	/* I don't think we want to recurse into this, really. */
-}
-
-static void process_tree(struct tree *tree,
-			 struct object_array *p,
-			 struct name_path *path,
-			 const char *name,
-			 struct connectivity_progress *cp)
-{
-	struct object *obj = &tree->object;
-	struct tree_desc desc;
-	struct name_entry entry;
-	struct name_path me;
-
-	if (!tree)
-		die("bad tree object");
-	if (obj->flags & SEEN)
-		return;
-	obj->flags |= SEEN;
-	update_progress(cp);
-	if (parse_tree(tree) < 0)
-		die("bad tree object %s", sha1_to_hex(obj->sha1));
-	add_object(obj, p, path, name);
-	me.up = path;
-	me.elem = name;
-	me.elem_len = strlen(name);
-
-	init_tree_desc(&desc, tree->buffer, tree->size);
-
-	while (tree_entry(&desc, &entry)) {
-		if (S_ISDIR(entry.mode))
-			process_tree(lookup_tree(entry.sha1), p, &me, entry.path, cp);
-		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(entry.sha1, p, &me, entry.path);
-		else
-			process_blob(lookup_blob(entry.sha1), p, &me, entry.path, cp);
-	}
-	free_tree_buffer(tree);
-}
-
-static void process_tag(struct tag *tag, struct object_array *p,
-			const char *name, struct connectivity_progress *cp)
-{
-	struct object *obj = &tag->object;
-
-	if (obj->flags & SEEN)
-		return;
-	obj->flags |= SEEN;
-	update_progress(cp);
-
-	if (parse_tag(tag) < 0)
-		die("bad tag object %s", sha1_to_hex(obj->sha1));
-	if (tag->tagged)
-		add_object(tag->tagged, p, NULL, name);
-}
-
-static void walk_commit_list(struct rev_info *revs,
-			     struct connectivity_progress *cp)
-{
-	int i;
-	struct commit *commit;
-	struct object_array objects = OBJECT_ARRAY_INIT;
-
-	/* Walk all commits, process their trees */
-	while ((commit = get_revision(revs)) != NULL) {
-		process_tree(commit->tree, &objects, NULL, "", cp);
-		update_progress(cp);
-	}
-
-	/* Then walk all the pending objects, recursively processing them too */
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object_array_entry *pending = revs->pending.objects + i;
-		struct object *obj = pending->item;
-		const char *name = pending->name;
-		if (obj->type == OBJ_TAG) {
-			process_tag((struct tag *) obj, &objects, name, cp);
-			continue;
-		}
-		if (obj->type == OBJ_TREE) {
-			process_tree((struct tree *)obj, &objects, NULL, name, cp);
-			continue;
-		}
-		if (obj->type == OBJ_BLOB) {
-			process_blob((struct blob *)obj, &objects, NULL, name, cp);
-			continue;
-		}
-		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
-	}
-}
-
 static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
@@ -210,6 +99,21 @@ static void add_cache_refs(struct rev_info *revs)
 		add_cache_tree(active_cache_tree, revs);
 }
 
+/*
+ * The traversal will have already marked us as SEEN, so we
+ * only need to handle any progress reporting here.
+ */
+static void mark_object(struct object *obj, const struct name_path *path,
+			const char *name, void *data)
+{
+	update_progress(data);
+}
+
+static void mark_commit(struct commit *c, void *data)
+{
+	mark_object(&c->object, NULL, NULL, data);
+}
+
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    struct progress *progress)
 {
@@ -245,6 +149,6 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	 */
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
-	walk_commit_list(revs, &cp);
+	traverse_commit_list(revs, mark_commit, mark_object, &cp);
 	display_progress(cp.progress, cp.count);
 }
-- 
2.1.2.596.g7379948

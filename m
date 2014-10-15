From: Jeff King <peff@peff.net>
Subject: [PATCH v2 19/25] traverse_commit_list: support pending blobs/trees
 with paths
Date: Wed, 15 Oct 2014 18:43:19 -0400
Message-ID: <20141015224318.GS25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:43:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXHx-0000nY-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbaJOWnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:43:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:59010 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbaJOWnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:43:21 -0400
Received: (qmail 2630 invoked by uid 102); 15 Oct 2014 22:43:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:43:21 -0500
Received: (qmail 28206 invoked by uid 107); 15 Oct 2014 22:43:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:43:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:43:19 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we call traverse_commit_list, we may have trees and
blobs in the pending array. As we process these, we pass the
"name" field from the pending entry as the path of the
object within the tree (which then becomes the root path if
we recurse into subtrees).

When we set up the traversal in prepare_revision_walk,
though, the "name" field of any pending trees and blobs is
likely to be the ref at which we found the object. We would
not want to make this part of the path (e.g., doing so would
make "git rev-list --objects v2.6.11-tree" in linux.git show
paths like "v2.6.11-tree/Makefile", which is nonsensical).
Therefore prepare_revision_walk sets the name field of each
pending tree and blobs to the empty string.

However, this leaves no room for a caller who does know the
correct path of a pending object to propagate that
information to the revision walker. We can fix this by
making two related changes:

  1. Use the "path" field as the path instead of the "name"
     field in traverse_commit_list. If the path is not set,
     default to "" (which is what we always ended up with in
     the current code, because of prepare_revision_walk).

  2. In prepare_revision_walk, make a complete copy of the
     entry. This makes the path field available to the
     walker (if there is one), solving our problem.
     Leaving the name field intact is now OK, as we do not
     use it as a path due to point (1) above (and we can use
     it to make more meaningful error messages if we want).
     We also make the original "mode" field available to the
     walker, though it does not actually use it.

Note that we still re-add the pending objects and free the
old ones (so we may strdup the path and name only to free
the old ones). This could be made more efficient by simply
copying the object_array entries that we are keeping.
However, that would require more restructuring of the code,
and is not done here.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c |  7 +++++--
 revision.c     | 30 +++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index fad6808..2910bec 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -208,6 +208,7 @@ void traverse_commit_list(struct rev_info *revs,
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
+		const char *path = pending->path;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
@@ -215,14 +216,16 @@ void traverse_commit_list(struct rev_info *revs,
 			show_object(obj, NULL, name, data);
 			continue;
 		}
+		if (!path)
+			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, &base, name, data);
+				     NULL, &base, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     NULL, name, data);
+				     NULL, path, data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
diff --git a/revision.c b/revision.c
index b8e02e2..9a0f99a 100644
--- a/revision.c
+++ b/revision.c
@@ -198,9 +198,10 @@ void mark_parents_uninteresting(struct commit *commit)
 	}
 }
 
-static void add_pending_object_with_mode(struct rev_info *revs,
+static void add_pending_object_with_path(struct rev_info *revs,
 					 struct object *obj,
-					 const char *name, unsigned mode)
+					 const char *name, unsigned mode,
+					 const char *path)
 {
 	if (!obj)
 		return;
@@ -220,7 +221,20 @@ static void add_pending_object_with_mode(struct rev_info *revs,
 		if (st)
 			return;
 	}
-	add_object_array_with_mode(obj, name, &revs->pending, mode);
+	add_object_array_with_path(obj, name, &revs->pending, mode, path);
+}
+
+static void add_pending_object_with_mode(struct rev_info *revs,
+					 struct object *obj,
+					 const char *name, unsigned mode)
+{
+	add_pending_object_with_path(revs, obj, name, mode, NULL);
+}
+
+static void add_pending_object_from_entry(struct rev_info *revs,
+					  struct object_array_entry *e)
+{
+	add_pending_object_with_path(revs, e->item, e->name, e->mode, e->path);
 }
 
 void add_pending_object(struct rev_info *revs,
@@ -265,8 +279,10 @@ void add_pending_sha1(struct rev_info *revs, const char *name,
 }
 
 static struct commit *handle_commit(struct rev_info *revs,
-				    struct object *object, const char *name)
+				    struct object_array_entry *entry)
 {
+	struct object *object = entry->item;
+	const char *name = entry->name;
 	unsigned long flags = object->flags;
 
 	/*
@@ -316,7 +332,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			mark_tree_contents_uninteresting(tree);
 			return NULL;
 		}
-		add_pending_object(revs, object, "");
+		add_pending_object_from_entry(revs, entry);
 		return NULL;
 	}
 
@@ -328,7 +344,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			return NULL;
 		if (flags & UNINTERESTING)
 			return NULL;
-		add_pending_object(revs, object, "");
+		add_pending_object_from_entry(revs, entry);
 		return NULL;
 	}
 	die("%s is unknown object", name);
@@ -2666,7 +2682,7 @@ int prepare_revision_walk(struct rev_info *revs)
 	revs->pending.objects = NULL;
 	for (i = 0; i < old_pending.nr; i++) {
 		struct object_array_entry *e = old_pending.objects + i;
-		struct commit *commit = handle_commit(revs, e->item, e->name);
+		struct commit *commit = handle_commit(revs, e);
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
-- 
2.1.2.596.g7379948

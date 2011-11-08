From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] reachable: per-object progress
Date: Tue, 8 Nov 2011 00:37:00 -0500
Message-ID: <20111108053700.GB16852@sigill.intra.peff.net>
References: <20111108053149.GA29643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:37:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeMu-0000De-FF
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab1KHFhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:37:03 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36067
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1KHFhC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:37:02 -0500
Received: (qmail 958 invoked by uid 107); 8 Nov 2011 05:37:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 00:37:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 00:37:00 -0500
Content-Disposition: inline
In-Reply-To: <20111108053149.GA29643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185069>

The current progress code really just counts commits.
This patch makes it count all objects, giving us a "total"
count close to what a repack would show. This is nice when
using "git gc", which will usually have just repacked the
whole repo.

Signed-off-by: Jeff King <peff@peff.net>
---
This makes the change a lot more invasive, but it is at least confined
to reachable.c. I think matching repack's numbers is worth it. I did a
few basic measurements, and with "& 1023" trick and reasonable
optimizations, it doesn't seem to make prune any slower.

Again, I'd be OK if this is squashed into your original patch.

 reachable.c |   51 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/reachable.c b/reachable.c
index 293d37d..bf79706 100644
--- a/reachable.c
+++ b/reachable.c
@@ -9,10 +9,23 @@
 #include "cache-tree.h"
 #include "progress.h"
 
+struct connectivity_progress {
+	struct progress *progress;
+	unsigned long count;
+};
+
+static void update_progress(struct connectivity_progress *cp)
+{
+	cp->count++;
+	if ((cp->count & 1023) == 0)
+		display_progress(cp->progress, cp->count);
+}
+
 static void process_blob(struct blob *blob,
 			 struct object_array *p,
 			 struct name_path *path,
-			 const char *name)
+			 const char *name,
+			 struct connectivity_progress *cp)
 {
 	struct object *obj = &blob->object;
 
@@ -21,6 +34,7 @@ static void process_blob(struct blob *blob,
 	if (obj->flags & SEEN)
 		return;
 	obj->flags |= SEEN;
+	update_progress(cp);
 	/* Nothing to do, really .. The blob lookup was the important part */
 }
 
@@ -35,7 +49,8 @@ static void process_gitlink(const unsigned char *sha1,
 static void process_tree(struct tree *tree,
 			 struct object_array *p,
 			 struct name_path *path,
-			 const char *name)
+			 const char *name,
+			 struct connectivity_progress *cp)
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
@@ -47,6 +62,7 @@ static void process_tree(struct tree *tree,
 	if (obj->flags & SEEN)
 		return;
 	obj->flags |= SEEN;
+	update_progress(cp);
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	add_object(obj, p, path, name);
@@ -58,23 +74,25 @@ static void process_tree(struct tree *tree,
 
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
-			process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
+			process_tree(lookup_tree(entry.sha1), p, &me, entry.path, cp);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(entry.sha1, p, &me, entry.path);
 		else
-			process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
+			process_blob(lookup_blob(entry.sha1), p, &me, entry.path, cp);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
 }
 
-static void process_tag(struct tag *tag, struct object_array *p, const char *name)
+static void process_tag(struct tag *tag, struct object_array *p,
+			const char *name, struct connectivity_progress *cp)
 {
 	struct object *obj = &tag->object;
 
 	if (obj->flags & SEEN)
 		return;
 	obj->flags |= SEEN;
+	update_progress(cp);
 
 	if (parse_tag(tag) < 0)
 		die("bad tag object %s", sha1_to_hex(obj->sha1));
@@ -82,17 +100,17 @@ static void process_tag(struct tag *tag, struct object_array *p, const char *nam
 		add_object(tag->tagged, p, NULL, name);
 }
 
-static void walk_commit_list(struct rev_info *revs, struct progress *progress)
+static void walk_commit_list(struct rev_info *revs,
+			     struct connectivity_progress *cp)
 {
 	int i;
 	struct commit *commit;
 	struct object_array objects = OBJECT_ARRAY_INIT;
-	uint32_t count = 0;
 
 	/* Walk all commits, process their trees */
 	while ((commit = get_revision(revs)) != NULL) {
-		process_tree(commit->tree, &objects, NULL, "");
-		display_progress(progress, ++count);
+		process_tree(commit->tree, &objects, NULL, "", cp);
+		update_progress(cp);
 	}
 
 	/* Then walk all the pending objects, recursively processing them too */
@@ -100,17 +118,16 @@ static void walk_commit_list(struct rev_info *revs, struct progress *progress)
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
-		display_progress(progress, ++count);
 		if (obj->type == OBJ_TAG) {
-			process_tag((struct tag *) obj, &objects, name);
+			process_tag((struct tag *) obj, &objects, name, cp);
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
-			process_tree((struct tree *)obj, &objects, NULL, name);
+			process_tree((struct tree *)obj, &objects, NULL, name, cp);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob((struct blob *)obj, &objects, NULL, name);
+			process_blob((struct blob *)obj, &objects, NULL, name, cp);
 			continue;
 		}
 		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
@@ -199,6 +216,8 @@ static void add_cache_refs(struct rev_info *revs)
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    struct progress *progress)
 {
+	struct connectivity_progress cp;
+
 	/*
 	 * Set up revision parsing, and mark us as being interested
 	 * in all object types, not just commits.
@@ -217,11 +236,15 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	if (mark_reflog)
 		for_each_reflog(add_one_reflog, revs);
 
+	cp.progress = progress;
+	cp.count = 0;
+
 	/*
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
 	 */
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
-	walk_commit_list(revs, progress);
+	walk_commit_list(revs, &cp);
+	display_progress(cp.progress, cp.count);
 }
-- 
1.7.7.2.7.g9f96f.dirty

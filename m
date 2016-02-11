From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] http-push: stop using name_path
Date: Thu, 11 Feb 2016 17:23:48 -0500
Message-ID: <20160211222347.GA586@sigill.intra.peff.net>
References: <20160211222314.GA31625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:23:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzeU-0003wF-UC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbcBKWXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:23:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:40752 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751671AbcBKWXu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:23:50 -0500
Received: (qmail 24443 invoked by uid 102); 11 Feb 2016 22:23:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:23:50 -0500
Received: (qmail 11718 invoked by uid 107); 11 Feb 2016 22:23:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:23:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:23:48 -0500
Content-Disposition: inline
In-Reply-To: <20160211222314.GA31625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286009>

The graph traversal code here passes along a name_path to
build up the pathname at which we find each blob. But we
never actually do anything with the resulting names, making
it a waste of code and memory.

This usage came in aa1dbc9 (Update http-push functionality,
2006-03-07), and originally the result was passed to
"add_object" (which stored it, but didn't really use it,
either). But we stopped using that function in 1f1e895 (Add
"named object array" concept, 2006-06-19) in favor of
storing just the objects themselves.

Moreover, the generation of the name in process_tree() is
buggy. It sticks "name" onto the end of the name_path linked
list, and then passes it down again as it recurses (instead
of "entry.path"). So it's a good thing this was unused, as
the resulting path for "a/b/c/d" would end up as "a/a/a/a".

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/http-push.c b/http-push.c
index d857b13..bd60668 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1277,9 +1277,7 @@ static struct object_list **add_one_object(struct object *obj, struct object_lis
 }
 
 static struct object_list **process_blob(struct blob *blob,
-					 struct object_list **p,
-					 struct name_path *path,
-					 const char *name)
+					 struct object_list **p)
 {
 	struct object *obj = &blob->object;
 
@@ -1293,14 +1291,11 @@ static struct object_list **process_blob(struct blob *blob,
 }
 
 static struct object_list **process_tree(struct tree *tree,
-					 struct object_list **p,
-					 struct name_path *path,
-					 const char *name)
+					 struct object_list **p)
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
 	struct name_entry entry;
-	struct name_path me;
 
 	obj->flags |= LOCAL;
 
@@ -1310,21 +1305,17 @@ static struct object_list **process_tree(struct tree *tree,
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 
 	obj->flags |= SEEN;
-	name = xstrdup(name);
 	p = add_one_object(obj, p);
-	me.up = path;
-	me.elem = name;
-	me.elem_len = strlen(name);
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry))
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			p = process_tree(lookup_tree(entry.sha1), p, &me, name);
+			p = process_tree(lookup_tree(entry.sha1), p);
 			break;
 		case OBJ_BLOB:
-			p = process_blob(lookup_blob(entry.sha1), p, &me, name);
+			p = process_blob(lookup_blob(entry.sha1), p);
 			break;
 		default:
 			/* Subproject commit - not in this repository */
@@ -1343,7 +1334,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 	int count = 0;
 
 	while ((commit = get_revision(revs)) != NULL) {
-		p = process_tree(commit->tree, p, NULL, "");
+		p = process_tree(commit->tree, p);
 		commit->object.flags |= LOCAL;
 		if (!(commit->object.flags & UNINTERESTING))
 			count += add_send_request(&commit->object, lock);
@@ -1362,11 +1353,11 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
-			p = process_tree((struct tree *)obj, p, NULL, name);
+			p = process_tree((struct tree *)obj, p);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			p = process_blob((struct blob *)obj, p, NULL, name);
+			p = process_blob((struct blob *)obj, p);
 			continue;
 		}
 		die("unknown pending object %s (%s)", oid_to_hex(&obj->oid), name);
-- 
2.7.1.550.gf5fcbd3

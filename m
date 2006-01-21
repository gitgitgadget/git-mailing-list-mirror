From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] rev-list: understand bound commits.
Date: Sat, 21 Jan 2006 00:23:14 -0800
Message-ID: <7vslrirnv1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 09:23:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0E1o-0007ZB-4d
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 09:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWAUIXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 03:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAUIXR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 03:23:17 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:17623 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751152AbWAUIXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 03:23:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121082155.PNMC20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 03:21:55 -0500
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14990>

This adds support for "bind" lines in commit objects, so that
"rev-list --objects piped to pack-objects" pattern can be used
for git native transports.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Linus, I would really appreciate if you can proofread and
   comment on this patch.  I am reasonably sure that I did not
   break things when no commit with "bind" lines are involved,
   but I am not sure if this makes --objects do the right thing
   to produce correct packs.  The goal is still to have:

   $ git rev-list --objects A..B

   to produce list of objects that are needed to complete B for
   somebody who has A, taking into account the objects contained
   in the subproject commits, while:

   $ git rev-list A..B

   should not worry anything about subproject commits.

 rev-list.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 61 insertions(+), 4 deletions(-)

e0571c156e9abd75473c6c85e224965dae842a65
diff --git a/rev-list.c b/rev-list.c
index f2534fd..339926a 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -201,6 +201,37 @@ static struct object_list **process_tree
 	return p;
 }
 
+static struct object_list **process_commit_part(struct commit *, struct object_list **, const char *);
+
+static struct object_list **process_bound_commit(struct commit *bound, struct object_list **p, const char *name)
+{
+	struct object *obj = &bound->object;
+
+	if (!list_objects)
+		return p;
+	if (obj->flags & (UNINTERESTING|SEEN))
+		return p;
+	if (parse_commit(bound) < 0)
+		die("bad commit object %s", sha1_to_hex(obj->sha1));
+	obj->flags |= SEEN;
+	p = add_object(obj, p, name);
+	return process_commit_part(bound, p, name);
+}
+
+static struct object_list **process_commit_part(struct commit *commit, struct object_list **p, const char *name)
+{
+	p = process_tree(commit->tree, p, name);
+	if (commit->binds) {
+		struct commit_list *bp = commit->binds;
+		while (bp) {
+			struct commit *bound = bp->item;
+			bp = bp->next;
+			p = process_bound_commit(bound, p, name);
+		}
+	}
+	return p;
+}
+
 static struct object_list *pending_objects = NULL;
 
 static void show_commit_list(struct commit_list *list)
@@ -209,7 +240,7 @@ static void show_commit_list(struct comm
 	while (list) {
 		struct commit *commit = pop_most_recent_commit(&list, SEEN);
 
-		p = process_tree(commit->tree, p, "");
+		p = process_commit_part(commit, p, "");
 		if (process_commit(commit) == STOP)
 			break;
 	}
@@ -231,6 +262,10 @@ static void show_commit_list(struct comm
 			p = process_blob((struct blob *)obj, p, name);
 			continue;
 		}
+		if (obj->type == commit_type) {
+			p = process_bound_commit((struct commit *)obj, p, name);
+			continue;
+		}
 		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
 	}
 	while (objects) {
@@ -285,6 +320,16 @@ static void mark_tree_uninteresting(stru
 	}
 }
 
+static void mark_bound_commits(struct commit *commit, int flags)
+{
+	struct commit_list *clist = commit->binds;
+	while (clist) {
+		struct commit *bound = clist->item;
+		bound->object.flags |= flags;
+		clist = clist->next;
+	}
+}
+
 static void mark_parents_uninteresting(struct commit *commit)
 {
 	struct commit_list *parents = commit->parents;
@@ -305,6 +350,13 @@ static void mark_parents_uninteresting(s
 			mark_parents_uninteresting(commit);
 
 		/*
+		 * Subproject commits bound to an uninteresting
+		 * parent is not interesting.
+		 */
+		if (commit->binds)
+			mark_bound_commits(commit, UNINTERESTING);
+
+		/*
 		 * A missing commit is ok iff its parent is marked 
 		 * uninteresting.
 		 *
@@ -520,6 +572,7 @@ static void add_parents_to_list(struct c
 			p->object.flags |= UNINTERESTING;
 			if (p->parents)
 				mark_parents_uninteresting(p);
+			mark_bound_commits(p, UNINTERESTING);
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
@@ -599,9 +652,12 @@ static struct commit_list *limit_list(st
 			obj->flags |= UNINTERESTING;
 		if (unpacked && has_sha1_pack(obj->sha1))
 			obj->flags |= UNINTERESTING;
-		add_parents_to_list(commit, &list);
+		if (commit->parents)
+			add_parents_to_list(commit, &list);
 		if (obj->flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			if (commit->parents)
+				mark_parents_uninteresting(commit);
+			mark_bound_commits(commit, UNINTERESTING);
 			if (everybody_uninteresting(list))
 				break;
 			continue;
@@ -654,8 +710,9 @@ static struct commit *get_commit_referen
 		object->flags |= flags;
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
-		if (flags & UNINTERESTING)
+		if ((flags & UNINTERESTING) && commit->parents)
 			mark_parents_uninteresting(commit);
+		mark_bound_commits(commit, flags);
 		return commit;
 	}
 
-- 
1.1.4.g5a4c

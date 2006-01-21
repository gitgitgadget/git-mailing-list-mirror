From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] rev-list: simplify --object list generation.
Date: Sat, 21 Jan 2006 00:24:34 -0800
Message-ID: <7vmzhqrnst.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Jan 21 09:24:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0E34-0007md-PH
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 09:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWAUIYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 03:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWAUIYg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 03:24:36 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40577 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751146AbWAUIYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 03:24:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121082207.REIF17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 03:22:07 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14991>

We have a provision to list only blobs (or tags or trees)
separately, but that was never exercised.  Simplify the code by
using a single variable to control either listing of all objects
or nothing but the commit ancestry chain.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I think there isn't much controversial about this.  I am
   sending this out only because the other one applies on top of
   this.

 rev-list.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

8ac50f00d0799f8f235d2993c18e8d49e035d0cd
diff --git a/rev-list.c b/rev-list.c
index d060966..f2534fd 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -37,9 +37,7 @@ static const char rev_list_usage[] =
 static int dense = 1;
 static int unpacked = 0;
 static int bisect_list = 0;
-static int tag_objects = 0;
-static int tree_objects = 0;
-static int blob_objects = 0;
+static int list_objects = 0;
 static int verbose_header = 0;
 static int show_parents = 0;
 static int hdr_termination = 0;
@@ -168,7 +166,7 @@ static struct object_list **process_blob
 {
 	struct object *obj = &blob->object;
 
-	if (!blob_objects)
+	if (!list_objects)
 		return p;
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return p;
@@ -181,7 +179,7 @@ static struct object_list **process_tree
 	struct object *obj = &tree->object;
 	struct tree_entry_list *entry;
 
-	if (!tree_objects)
+	if (!list_objects)
 		return p;
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return p;
@@ -253,7 +251,7 @@ static void show_commit_list(struct comm
 
 static void mark_blob_uninteresting(struct blob *blob)
 {
-	if (!blob_objects)
+	if (!list_objects)
 		return;
 	if (blob->object.flags & UNINTERESTING)
 		return;
@@ -265,7 +263,7 @@ static void mark_tree_uninteresting(stru
 	struct object *obj = &tree->object;
 	struct tree_entry_list *entry;
 
-	if (!tree_objects)
+	if (!list_objects)
 		return;
 	if (obj->flags & UNINTERESTING)
 		return;
@@ -612,7 +610,7 @@ static struct commit_list *limit_list(st
 			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
-	if (tree_objects)
+	if (list_objects)
 		mark_edges_uninteresting(newlist);
 	if (paths && dense)
 		compress_list(newlist);
@@ -640,7 +638,7 @@ static struct commit *get_commit_referen
 	while (object->type == tag_type) {
 		struct tag *tag = (struct tag *) object;
 		object->flags |= flags;
-		if (tag_objects && !(object->flags & UNINTERESTING))
+		if (list_objects && !(object->flags & UNINTERESTING))
 			add_pending_object(object, tag->tag);
 		object = parse_object(tag->tagged->sha1);
 		if (!object)
@@ -667,7 +665,7 @@ static struct commit *get_commit_referen
 	 */
 	if (object->type == tree_type) {
 		struct tree *tree = (struct tree *)object;
-		if (!tree_objects)
+		if (!list_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
 			mark_tree_uninteresting(tree);
@@ -682,7 +680,7 @@ static struct commit *get_commit_referen
 	 */
 	if (object->type == blob_type) {
 		struct blob *blob = (struct blob *)object;
-		if (!blob_objects)
+		if (!list_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
 			mark_blob_uninteresting(blob);
@@ -777,9 +775,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "--objects")) {
-			tag_objects = 1;
-			tree_objects = 1;
-			blob_objects = 1;
+			list_objects = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--unpacked")) {
@@ -850,8 +846,7 @@ int main(int argc, const char **argv)
 		handle_one_commit(commit, &list);
 	}
 
-	if (!list &&
-	    (!(tag_objects||tree_objects||blob_objects) && !pending_objects))
+	if (!list && !list_objects && !pending_objects)
 		usage(rev_list_usage);
 
 	paths = get_pathspec(prefix, argv + i);
@@ -865,8 +860,7 @@ int main(int argc, const char **argv)
 
 	if (!merge_order) {		
 		sort_by_date(&list);
-		if (list && !limited && max_count == 1 &&
-		    !tag_objects && !tree_objects && !blob_objects) {
+		if (list && !limited && max_count == 1 && !list_objects) {
 			show_commit(list->item);
 			return 0;
 		}
-- 
1.1.4.g5a4c

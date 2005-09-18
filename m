From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Improve the safety check used in fetch.c
Date: Sun, 18 Sep 2005 10:38:39 -0700
Message-ID: <7vbr2q46ow.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
	<7vhdckceas.fsf@assigned-by-dhcp.cox.net>
	<7vacicccxl.fsf@assigned-by-dhcp.cox.net>
	<7vvf10axia.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509171235330.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:39:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH37q-00057s-PC
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVIRRis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVIRRis
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:38:48 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:47812 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932111AbVIRRip (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 13:38:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918173841.OCSV24382.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 13:38:41 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509171235330.23242@iabervon.org> (Daniel
	Barkalow's message of "Sat, 17 Sep 2005 13:37:16 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8796>

The recent safety check to trust only the commits we have made
things impossibly slow and wastes a lot of memory.

This commit fixes it with the following improvements:

 - mark already scanned objects and avoid rescanning the same
   object again;

 - free the tree entries when we have scanned the tree entries;
   this is the same as b0d8923ec01fd91b75ab079034f89ced91500157
   which reduced memory usage by rev-list;

 - plug memory leak from the object_list dequeuing code;

 - use the process_queue not just for fetching but for scanning,
   to make things tail recursive to avoid deep recursion; the
   deep recursion was especially prominent when we cloned a big
   pack.

 - avoid has_sha1_file() call when we already know we do not have
   that object.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 fetch.c |   76 ++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 32 deletions(-)

85d106c267ec26f398e0aaf352d8011f661c459a
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -33,36 +33,33 @@ static void report_missing(const char *w
 		what, missing_hex, sha1_to_hex(current_commit_sha1));
 }
 
-static int make_sure_we_have_it(const char *what, unsigned char *sha1)
-{
-	int status = 0;
-
-	if (!has_sha1_file(sha1)) {
-		status = fetch(sha1);
-		if (status && what)
-			report_missing(what, sha1);
-	}
-	return status;
-}
-
 static int process(unsigned char *sha1, const char *type);
 
 static int process_tree(struct tree *tree)
 {
-	struct tree_entry_list *entries;
+	struct tree_entry_list *entry;
 
 	if (parse_tree(tree))
 		return -1;
 
-	for (entries = tree->entries; entries; entries = entries->next) {
-		if (process(entries->item.any->sha1,
-			    entries->directory ? tree_type : blob_type))
+	entry = tree->entries;
+	tree->entries = NULL;
+	while (entry) {
+		struct tree_entry_list *next = entry->next;
+		if (process(entry->item.any->sha1,
+			    entry->directory ? tree_type : blob_type))
 			return -1;
+		free(entry);
+		entry = next;
 	}
 	return 0;
 }
 
 #define COMPLETE	1U
+#define TO_FETCH	2U
+#define TO_SCAN		4U
+#define SCANNED		8U
+
 static struct commit_list *complete = NULL;
 
 static int process_commit(struct commit *commit)
@@ -73,13 +70,14 @@ static int process_commit(struct commit 
 	while (complete && complete->item->date >= commit->date) {
 		pop_most_recent_commit(&complete, COMPLETE);
 	}
-		
 
 	if (commit->object.flags & COMPLETE)
 		return 0;
 
 	memcpy(current_commit_sha1, commit->object.sha1, 20);
 
+	pull_say("walk %s\n", sha1_to_hex(commit->object.sha1));
+
 	if (get_tree) {
 		if (process(commit->tree->object.sha1, tree_type))
 			return -1;
@@ -89,8 +87,7 @@ static int process_commit(struct commit 
 	if (get_history) {
 		struct commit_list *parents = commit->parents;
 		for (; parents; parents = parents->next) {
-			if (process(parents->item->object.sha1,
-				    commit_type))
+			if (process(parents->item->object.sha1, commit_type))
 				return -1;
 		}
 	}
@@ -109,6 +106,10 @@ static struct object_list **process_queu
 
 static int process_object(struct object *obj)
 {
+	if (obj->flags & SCANNED)
+		return 0;
+	obj->flags |= SCANNED;
+
 	if (obj->type == commit_type) {
 		if (process_commit((struct commit *)obj))
 			return -1;
@@ -139,14 +140,19 @@ static int process(unsigned char *sha1, 
 	if (has_sha1_file(sha1)) {
 		parse_object(sha1);
 		/* We already have it, so we should scan it now. */
-		return process_object(obj);
+		if (obj->flags & (SCANNED | TO_SCAN))
+			return 0;
+		object_list_insert(obj, process_queue_end);
+		process_queue_end = &(*process_queue_end)->next;
+		obj->flags |= TO_SCAN;
+		return 0;
 	}
-	if (object_list_contains(process_queue, obj))
+	if (obj->flags & (COMPLETE | TO_FETCH))
 		return 0;
 	object_list_insert(obj, process_queue_end);
 	process_queue_end = &(*process_queue_end)->next;
+	obj->flags |= TO_FETCH;
 
-	//fprintf(stderr, "prefetch %s\n", sha1_to_hex(sha1));
 	prefetch(sha1);
 		
 	return 0;
@@ -154,21 +160,27 @@ static int process(unsigned char *sha1, 
 
 static int loop(void)
 {
+	struct object_list *elem;
+
 	while (process_queue) {
 		struct object *obj = process_queue->item;
-		/*
-		fprintf(stderr, "%d objects to pull\n", 
-			object_list_length(process_queue));
-		*/
-		process_queue = process_queue->next;
+		elem = process_queue;
+		process_queue = elem->next;
+		free(elem);
 		if (!process_queue)
 			process_queue_end = &process_queue;
 
-		//fprintf(stderr, "fetch %s\n", sha1_to_hex(obj->sha1));
-		
-		if (make_sure_we_have_it(obj->type ? obj->type : "object", 
-					 obj->sha1))
-			return -1;
+		/* If we are not scanning this object, we placed it in
+		 * the queue because we needed to fetch it first.
+		 */
+		if (! (obj->flags & TO_SCAN)) {
+			if (fetch(obj->sha1)) {
+				report_missing(obj->type
+					       ? obj->type
+					       : "object", obj->sha1);
+				return -1;
+			}
+		}
 		if (!obj->type)
 			parse_object(obj->sha1);
 		if (process_object(obj))

From: barkalow@iabervon.org
Subject: [PATCH 2/2] Parallelize pull algorithm (no change to behavior).
Date: Sun, 31 Jul 2005 21:32:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507312129430.23721@iabervon.org>
References: <Pine.LNX.4.62.0507312055030.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:30:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzP7t-0004kH-52
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 03:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVHAB3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 21:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVHAB3v
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 21:29:51 -0400
Received: from iabervon.org ([66.92.72.58]:26885 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262288AbVHAB3u (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 21:29:50 -0400
Received: (qmail 25067 invoked by uid 1000); 31 Jul 2005 21:32:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2005 21:32:46 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0507312055030.23721@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch makes the core pull algorithm request all of the objects it can 
(with prefetch()) before actually reading them (with fetch()). Future 
patches (in a later series) will make use of this behavior to have 
multiple requests in flight at the same time, reducing the need for 
round-trips.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 http-pull.c  |    4 ++
 local-pull.c |    4 ++
 pull.c       |  128 ++++++++++++++++++++++++++++++++++------------------------
 pull.h       |    7 +++
 ssh-pull.c   |    4 ++
 5 files changed, 93 insertions(+), 54 deletions(-)

02aae5a570341c5b86b914d59732009f015800d8
diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -68,6 +68,10 @@ static size_t fwrite_sha1_file(void *ptr
 	return size;
 }
 
+void prefetch(unsigned char *sha1)
+{
+}
+
 int fetch(unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -11,6 +11,10 @@ static int use_filecopy = 1;
 
 static char *path; /* "Remote" git repository */
 
+void prefetch(unsigned char *sha1)
+{
+}
+
 int fetch(unsigned char *sha1)
 {
 	static int object_name_start = -1;
diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -17,11 +17,8 @@ int get_all = 0;
 int get_verbosely = 0;
 static unsigned char current_commit_sha1[20];
 
-static const char commitS[] = "commit";
-static const char treeS[] = "tree";
-static const char blobS[] = "blob";
-
-void pull_say(const char *fmt, const char *hex) {
+void pull_say(const char *fmt, const char *hex) 
+{
 	if (get_verbosely)
 		fprintf(stderr, fmt, hex);
 }
@@ -48,93 +45,114 @@ static int make_sure_we_have_it(const ch
 	return status;
 }
 
-static int process_unknown(unsigned char *sha1);
+static int process(unsigned char *sha1, const char *type);
 
-static int process_tree(unsigned char *sha1)
+static int process_tree(struct tree *tree)
 {
-	struct tree *tree = lookup_tree(sha1);
 	struct tree_entry_list *entries;
 
 	if (parse_tree(tree))
 		return -1;
 
 	for (entries = tree->entries; entries; entries = entries->next) {
-		const char *what = entries->directory ? treeS : blobS;
-		if (make_sure_we_have_it(what, entries->item.tree->object.sha1))
+		if (process(entries->item.any->sha1,
+			    entries->directory ? tree_type : blob_type))
 			return -1;
-		if (entries->directory) {
-			if (process_tree(entries->item.tree->object.sha1))
-				return -1;
-		}
 	}
 	return 0;
 }
 
-static int process_commit(unsigned char *sha1)
+static int process_commit(struct commit *commit)
 {
-	struct commit *obj = lookup_commit(sha1);
-
-	if (make_sure_we_have_it(commitS, sha1))
+	if (parse_commit(commit))
 		return -1;
 
-	if (parse_commit(obj))
-		return -1;
+	memcpy(current_commit_sha1, commit->object.sha1, 20);
 
 	if (get_tree) {
-		if (make_sure_we_have_it(treeS, obj->tree->object.sha1))
-			return -1;
-		if (process_tree(obj->tree->object.sha1))
+		if (process(commit->tree->object.sha1, tree_type))
 			return -1;
 		if (!get_all)
 			get_tree = 0;
 	}
 	if (get_history) {
-		struct commit_list *parents = obj->parents;
+		struct commit_list *parents = commit->parents;
 		for (; parents; parents = parents->next) {
 			if (has_sha1_file(parents->item->object.sha1))
 				continue;
-			if (make_sure_we_have_it(NULL,
-						 parents->item->object.sha1)) {
-				/* The server might not have it, and
-				 * we don't mind. 
-				 */
-				continue;
-			}
-			if (process_commit(parents->item->object.sha1))
+			if (process(parents->item->object.sha1,
+				    commit_type))
 				return -1;
-			memcpy(current_commit_sha1, sha1, 20);
 		}
 	}
 	return 0;
 }
 
-static int process_tag(unsigned char *sha1)
+static int process_tag(struct tag *tag)
 {
-	struct tag *obj = lookup_tag(sha1);
-
-	if (parse_tag(obj))
+	if (parse_tag(tag))
 		return -1;
-	return process_unknown(obj->tagged->sha1);
+	return process(tag->tagged->sha1, NULL);
 }
 
-static int process_unknown(unsigned char *sha1)
+static struct object_list *process_queue = NULL;
+static struct object_list **process_queue_end = &process_queue;
+
+static int process(unsigned char *sha1, const char *type)
 {
 	struct object *obj;
-	if (make_sure_we_have_it("object", sha1))
-		return -1;
-	obj = parse_object(sha1);
-	if (!obj)
-		return error("Unable to parse object %s", sha1_to_hex(sha1));
-	if (obj->type == commit_type)
-		return process_commit(sha1);
-	if (obj->type == tree_type)
-		return process_tree(sha1);
-	if (obj->type == blob_type)
+	if (has_sha1_file(sha1))
 		return 0;
-	if (obj->type == tag_type)
-		return process_tag(sha1);
-	return error("Unable to determine requirement of type %s for %s",
-		     obj->type, sha1_to_hex(sha1));
+	obj = lookup_object_type(sha1, type);
+	object_list_insert(obj, process_queue_end);
+	process_queue_end = &(*process_queue_end)->next;
+
+	fprintf(stderr, "prefetch %s\n", sha1_to_hex(sha1));
+	prefetch(sha1);
+		
+	return 0;
+}
+
+static int loop(void)
+{
+	while (process_queue) {
+		struct object *obj = process_queue->item;
+		fprintf(stderr, "%d objects to pull\n", 
+			object_list_length(process_queue));
+		process_queue = process_queue->next;
+		if (!process_queue)
+			process_queue_end = &process_queue;
+
+		fprintf(stderr, "fetch %s\n", sha1_to_hex(obj->sha1));
+		
+		if (make_sure_we_have_it(obj->type ?: "object", 
+					 obj->sha1))
+			return -1;
+		if (!obj->type)
+			parse_object(obj->sha1);
+		if (obj->type == commit_type) {
+			if (process_commit((struct commit *)obj))
+				return -1;
+			continue;
+		}
+		if (obj->type == tree_type) {
+			if (process_tree((struct tree *)obj))
+				return -1;
+			continue;
+		}
+		if (obj->type == blob_type) {
+			continue;
+		}
+		if (obj->type == tag_type) {
+			if (process_tag((struct tag *)obj))
+				return -1;
+			continue;
+		}
+		return error("Unable to determine requirements "
+			     "of type %s for %s",
+			     obj->type, sha1_to_hex(obj->sha1));
+	};
+	return 0;
 }
 
 static int interpret_target(char *target, unsigned char *sha1)
@@ -164,7 +182,9 @@ int pull(char *target)
 	if (interpret_target(target, sha1))
 		return error("Could not interpret %s as something to pull",
 			     target);
-	if (process_unknown(sha1))
+	if (process(sha1, NULL))
+		return -1;
+	if (loop())
 		return -1;
 	
 	if (write_ref) {
diff --git a/pull.h b/pull.h
--- a/pull.h
+++ b/pull.h
@@ -9,6 +9,13 @@
 extern int fetch(unsigned char *sha1);
 
 /*
+ * Fetch the specified object and store it locally; fetch() will be
+ * called later to determine success. To be provided by the particular
+ * implementation.
+ */
+extern void prefetch(unsigned char *sha1);
+
+/*
  * Fetch ref (relative to $GIT_DIR/refs) from the remote, and store
  * the 20-byte SHA1 in sha1.  Return 0 on success, -1 on failure.  To
  * be provided by the particular implementation.
diff --git a/ssh-pull.c b/ssh-pull.c
--- a/ssh-pull.c
+++ b/ssh-pull.c
@@ -10,6 +10,10 @@ static int fd_out;
 static unsigned char remote_version = 0;
 static unsigned char local_version = 1;
 
+void prefetch(unsigned char *sha1)
+{
+}
+
 int fetch(unsigned char *sha1)
 {
 	int ret;

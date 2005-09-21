From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 1/8] fetch.c: Remove useless lookup_object_type() call in process()
Date: Wed, 21 Sep 2005 20:18:55 +0400 (MSD)
Message-ID: <20050921161855.896F1E010FC@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:22:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7JM-0006Bd-O4
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVIUQS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVIUQS5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:18:57 -0400
Received: from mivlgu.ru ([81.18.140.87]:646 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751115AbVIUQS5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:18:57 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 896F1E010FC; Wed, 21 Sep 2005 20:18:55 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9056>

In all places where process() is called except the one in pull() (which
is executed only once) the pointer to the object is already available,
so pass it as the argument to process() instead of sha1 and avoid an
unneeded call to lookup_object_type().

---

 fetch.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

3a0ec5d22a2f9828bebae9b13e5848291685e4c5
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -33,7 +33,7 @@ static void report_missing(const char *w
 		what, missing_hex, sha1_to_hex(current_commit_sha1));
 }
 
-static int process(unsigned char *sha1, const char *type);
+static int process(struct object *obj);
 
 static int process_tree(struct tree *tree)
 {
@@ -46,8 +46,7 @@ static int process_tree(struct tree *tre
 	tree->entries = NULL;
 	while (entry) {
 		struct tree_entry_list *next = entry->next;
-		if (process(entry->item.any->sha1,
-			    entry->directory ? tree_type : blob_type))
+		if (process(entry->item.any))
 			return -1;
 		free(entry);
 		entry = next;
@@ -79,7 +78,7 @@ static int process_commit(struct commit 
 	pull_say("walk %s\n", sha1_to_hex(commit->object.sha1));
 
 	if (get_tree) {
-		if (process(commit->tree->object.sha1, tree_type))
+		if (process(&commit->tree->object))
 			return -1;
 		if (!get_all)
 			get_tree = 0;
@@ -87,7 +86,7 @@ static int process_commit(struct commit 
 	if (get_history) {
 		struct commit_list *parents = commit->parents;
 		for (; parents; parents = parents->next) {
-			if (process(parents->item->object.sha1, commit_type))
+			if (process(&parents->item->object))
 				return -1;
 		}
 	}
@@ -98,7 +97,7 @@ static int process_tag(struct tag *tag)
 {
 	if (parse_tag(tag))
 		return -1;
-	return process(tag->tagged->sha1, NULL);
+	return process(tag->tagged);
 }
 
 static struct object_list *process_queue = NULL;
@@ -133,12 +132,10 @@ static int process_object(struct object 
 		     obj->type, sha1_to_hex(obj->sha1));
 }
 
-static int process(unsigned char *sha1, const char *type)
+static int process(struct object *obj)
 {
-	struct object *obj = lookup_object_type(sha1, type);
-
-	if (has_sha1_file(sha1)) {
-		parse_object(sha1);
+	if (has_sha1_file(obj->sha1)) {
+		parse_object(obj->sha1);
 		/* We already have it, so we should scan it now. */
 		if (obj->flags & (SCANNED | TO_SCAN))
 			return 0;
@@ -153,7 +150,7 @@ static int process(unsigned char *sha1, 
 	process_queue_end = &(*process_queue_end)->next;
 	obj->flags |= TO_FETCH;
 
-	prefetch(sha1);
+	prefetch(obj->sha1);
 		
 	return 0;
 }
@@ -228,7 +225,7 @@ int pull(char *target)
 	if (interpret_target(target, sha1))
 		return error("Could not interpret %s as something to pull",
 			     target);
-	if (process(sha1, NULL))
+	if (process(lookup_unknown_object(sha1)))
 		return -1;
 	if (loop())
 		return -1;

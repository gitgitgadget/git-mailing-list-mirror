From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix fetch completeness assumptions
Date: Wed, 14 Sep 2005 21:31:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 03:27:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFiXM-00038E-15
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 03:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVIOB1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 21:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbVIOB1e
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 21:27:34 -0400
Received: from iabervon.org ([66.92.72.58]:15110 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030325AbVIOB1d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 21:27:33 -0400
Received: (qmail 9902 invoked by uid 1000); 14 Sep 2005 21:31:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 21:31:42 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8577>

Don't assume that any commit we have is complete; assume that any ref
we have is complete.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
Only lightly tested, but it seems to work. Marks all of the commits in 
refs, and their ancestors back as far as the date of the commit it's 
processing. If the commit it's processing is marked, it doesn't recurse 
into it.

This should make it very difficult to get it to produce a situation where 
it completes without giving you complete information, and it shouldn't 
process commits that are accessible from refs.

 fetch.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

39216139abc4f2759f7b55d11fa2f7e7c155898c
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -62,11 +62,21 @@ static int process_tree(struct tree *tre
 	return 0;
 }
 
+struct commit_list *complete = NULL;
+
 static int process_commit(struct commit *commit)
 {
 	if (parse_commit(commit))
 		return -1;
 
+	while (complete && complete->item->date >= commit->date) {
+		pop_most_recent_commit(&complete, 1);
+	}
+		
+
+	if (commit->object.flags & 1)
+		return 0;
+
 	memcpy(current_commit_sha1, commit->object.sha1, 20);
 
 	if (get_tree) {
@@ -78,8 +88,6 @@ static int process_commit(struct commit 
 	if (get_history) {
 		struct commit_list *parents = commit->parents;
 		for (; parents; parents = parents->next) {
-			if (has_sha1_file(parents->item->object.sha1))
-				continue;
 			if (process(parents->item->object.sha1,
 				    commit_type))
 				return -1;
@@ -126,6 +134,7 @@ static int process_object(struct object 
 static int process(unsigned char *sha1, const char *type)
 {
 	struct object *obj = lookup_object_type(sha1, type);
+
 	if (has_sha1_file(sha1)) {
 		parse_object(sha1);
 		/* We already have it, so we should scan it now. */
@@ -179,6 +188,19 @@ static int interpret_target(char *target
 	return -1;
 }
 
+static int mark_complete(const char *path, const unsigned char *sha1)
+{
+	struct object *obj = parse_object(sha1);
+	while (obj->type == tag_type) {
+		obj = ((struct tag *) obj)->tagged;
+		parse_object(obj->sha1);
+	}
+	if (obj->type == commit_type) {
+		obj->flags |= 1;
+		insert_by_date((struct commit *) obj, &complete);
+	}
+	return 0;
+}
 
 int pull(char *target)
 {
@@ -191,6 +213,8 @@ int pull(char *target)
 			return -1;
 	}
 
+	for_each_ref(mark_complete);
+
 	if (interpret_target(target, sha1))
 		return error("Could not interpret %s as something to pull",
 			     target);

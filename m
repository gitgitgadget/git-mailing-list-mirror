From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix ref_newer() in send-pack.
Date: Fri, 05 Aug 2005 23:18:38 -0700
Message-ID: <7v7jezbnb5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 06 08:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1I1E-0002pG-UO
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 08:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVHFGSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 02:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVHFGSk
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 02:18:40 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37773 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262270AbVHFGSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 02:18:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806061839.BBKT550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 02:18:39 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When more than two references need to be checked with
ref_newer() function, the second and later calls did not work
correctly.  This was because the later calls found commits
retained by the "struct object" layer that still had smudges
made by earlier calls.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 send-pack.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

51b0fca012310910783de76f2eacfd10b0f2f9fc
diff --git a/send-pack.c b/send-pack.c
--- a/send-pack.c
+++ b/send-pack.c
@@ -105,12 +105,23 @@ static int pack_objects(int fd, struct r
 	return 0;
 }
 
+static void unmark_and_free(struct commit_list *list, unsigned int mark)
+{
+	while (list) {
+		struct commit_list *temp = list;
+		temp->item->object.flags &= ~mark;
+		list = temp->next;
+		free(temp);
+	}
+}
+
 static int ref_newer(const unsigned char *new_sha1,
 		     const unsigned char *old_sha1)
 {
 	struct object *o;
 	struct commit *old, *new;
-	struct commit_list *list;
+	struct commit_list *list, *used;
+	int found = 0;
 
 	/* Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
@@ -127,14 +138,20 @@ static int ref_newer(const unsigned char
 
 	if (parse_commit(new) < 0)
 		return 0;
-	list = NULL;
+
+	used = list = NULL;
 	commit_list_insert(new, &list);
 	while (list) {
 		new = pop_most_recent_commit(&list, 1);
-		if (new == old)
-			return 1;
+		commit_list_insert(new, &used);
+		if (new == old) {
+			found = 1;
+			break;
+		}
 	}
-	return 0;
+	unmark_and_free(list, 1);
+	unmark_and_free(used, 1);
+	return found;
 }
 
 static struct ref *local_refs, **local_tail;

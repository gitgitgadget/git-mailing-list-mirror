From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/6] in_merge_bases(): optimization
Date: Tue, 09 Jan 2007 02:41:28 -0800
Message-ID: <7virfgo52f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 11:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EQM-0003nM-VL
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXAIKlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXAIKlc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:41:32 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45343 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXAIKl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:41:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109104129.BBSF3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:41:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yhk1W00F1kojtg0000000; Tue, 09 Jan 2007 05:41:45 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36349>

The callers of in_merge_bases() are interested in finding out if
the given commit is reachable from others, and we do not have to
compute the true merge base.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 commit.c |   48 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index 53f43e3..72f6980 100644
--- a/commit.c
+++ b/commit.c
@@ -1034,7 +1034,7 @@ static struct commit *interesting(struct commit_list *list)
 	return NULL;
 }
 
-static struct commit_list *base_traverse(struct commit_list *list)
+static struct commit_list *base_traverse(struct commit_list *list, struct commit *stop)
 {
 	struct commit_list *result = NULL;
 
@@ -1068,10 +1068,20 @@ static struct commit_list *base_traverse(struct commit_list *list)
 			p->object.flags |= flags;
 			insert_by_date(p, &list);
 		}
+		if (stop && (stop->object.flags & PARENT2)) {
+			free_commit_list(list);
+			list = NULL;
+			insert_by_date(stop, &list);
+			return list;
+		}
 	}
 
 	/* Clean up the result to remove stale ones */
 	free_commit_list(list);
+
+	if (stop)
+		return NULL;
+
 	list = result; result = NULL;
 	while (list) {
 		struct commit_list *n = list->next;
@@ -1101,7 +1111,7 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	insert_by_date(one, &list);
 	insert_by_date(two, &list);
 
-	return base_traverse(list);
+	return base_traverse(list, NULL);
 }
 
 struct commit_list *get_merge_bases(struct commit *one,
@@ -1166,20 +1176,30 @@ struct commit_list *get_merge_bases(struct commit *one,
 
 int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 {
-	struct commit_list *bases, *b;
-	int ret = 0;
+	struct commit_list *result, *list;
+	int i;
 
-	if (num == 1)
-		bases = get_merge_bases(commit, *reference, 1);
-	else
-		die("not yet");
-	for (b = bases; b; b = b->next) {
-		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
-			ret = 1;
-			break;
+	list = NULL;
+	parse_commit(commit);
+	commit->object.flags |= PARENT1;
+	insert_by_date(commit, &list);
+
+	for (i = 0; i < num; i++) {
+		struct commit *two = reference[i];
+		parse_commit(two);
+		if (!(two->object.flags & PARENT2)) {
+			two->object.flags |= PARENT2;
+			insert_by_date(two, &list);
 		}
 	}
+	result = base_traverse(list, commit);
+	i = !!result;
+	free_commit_list(result);
 
-	free_commit_list(bases);
-	return ret;
+	clear_commit_marks(commit, all_flags);
+	for (i = 0; i < num; i++) {
+		struct commit *two = reference[i];
+		clear_commit_marks(two, all_flags);
+	}
+	return i;
 }
-- 
1.4.4.4.g564d

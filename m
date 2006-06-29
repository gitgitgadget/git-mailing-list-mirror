From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] refactor merge_bases() as preparation to libify merge-base
Date: Thu, 29 Jun 2006 15:16:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606291516150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060627223249.GA8177@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 15:17:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvwON-0007NK-Cr
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 15:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWF2NQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 09:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWF2NQt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 09:16:49 -0400
Received: from mail.gmx.net ([213.165.64.21]:49071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750778AbWF2NQs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 09:16:48 -0400
Received: (qmail invoked by alias); 29 Jun 2006 13:16:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 29 Jun 2006 15:16:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060627223249.GA8177@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22860>


---
 merge-base.c |   64 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/merge-base.c b/merge-base.c
index 4856ca0..7d87c20 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -124,8 +124,6 @@ static struct commit *interesting(struct
  * to contaminate D and E.
  */
 
-static int show_all = 0;
-
 static void mark_reachable_commits(struct commit_list *result,
 				   struct commit_list *list)
 {
@@ -167,34 +165,33 @@ static void mark_reachable_commits(struc
 	}
 }
 
-static int merge_base(struct commit *rev1, struct commit *rev2)
+struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
 	struct commit_list *tmp = NULL;
 
-	if (rev1 == rev2) {
-		printf("%s\n", sha1_to_hex(rev1->object.sha1));
-		return 0;
-	}
+	if (rev1 == rev2)
+		return commit_list_insert(rev1, &result);
 
 	parse_commit(rev1);
 	parse_commit(rev2);
 
-	rev1->object.flags |= 1;
-	rev2->object.flags |= 2;
+	rev1->object.flags |= PARENT1;
+	rev2->object.flags |= PARENT2;
 	insert_by_date(rev1, &list);
 	insert_by_date(rev2, &list);
 
 	while (interesting(list)) {
 		struct commit *commit = list->item;
 		struct commit_list *parents;
-		int flags = commit->object.flags & 7;
+		int flags = commit->object.flags
+			& (PARENT1 | PARENT2 | UNINTERESTING);
 
 		tmp = list;
 		list = list->next;
 		free(tmp);
-		if (flags == 3) {
+		if (flags == (PARENT1 | PARENT2)) {
 			insert_by_date(commit, &result);
 
 			/* Mark parents of a found merge uninteresting */
@@ -213,21 +210,52 @@ static int merge_base(struct commit *rev
 	}
 
 	if (!result)
-		return 1;
+		return NULL;
 
 	if (result->next && list)
 		mark_reachable_commits(result, list);
 
+	/* cull duplicates */
+	for (tmp = result, list = NULL; tmp; ) {
+		struct commit *commit = tmp->item;
+		struct commit_list *next = tmp->next;
+		if (commit->object.flags & UNINTERESTING) {
+			if (list != NULL)
+				list->next = next;
+			free(tmp);
+		} else {
+			if (list == NULL)
+				result = tmp;
+			list = tmp;
+			commit->object.flags |= UNINTERESTING;
+		}
+
+		tmp = next;
+	}
+
+	/* reset flags */
+	clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
+	clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
+
+	return result;
+}
+
+static int show_all = 0;
+
+static int merge_base(struct commit *rev1, struct commit *rev2)
+{
+	struct commit_list *result = get_merge_bases(rev1, rev2);
+
+	if (!result)
+		return 1;
+
 	while (result) {
-		struct commit *commit = result->item;
-		result = result->next;
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		printf("%s\n", sha1_to_hex(commit->object.sha1));
+		printf("%s\n", sha1_to_hex(result->item->object.sha1));
 		if (!show_all)
 			return 0;
-		commit->object.flags |= UNINTERESTING;
+		result = result->next;
 	}
+
 	return 0;
 }
 
-- 
1.4.1.rc1.g87c00-dirty

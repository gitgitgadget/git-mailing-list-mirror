From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/6] merge_base(): move traversal into a separate function.
Date: Tue, 09 Jan 2007 02:41:27 -0800
Message-ID: <7vtzz0o52g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 11:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EQM-0003nM-Bu
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbXAIKla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXAIKla
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:41:30 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45648 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXAIKl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:41:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109104128.FNWV19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:41:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yhj1W0091kojtg0000000; Tue, 09 Jan 2007 05:41:43 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36347>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 commit.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index aa14c5a..53f43e3 100644
--- a/commit.c
+++ b/commit.c
@@ -1034,25 +1034,10 @@ static struct commit *interesting(struct commit_list *list)
 	return NULL;
 }
 
-static struct commit_list *merge_bases(struct commit *one, struct commit *two)
+static struct commit_list *base_traverse(struct commit_list *list)
 {
-	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
 
-	if (one == two)
-		/* We do not mark this even with RESULT so we do not
-		 * have to clean it up.
-		 */
-		return commit_list_insert(one, &result);
-
-	parse_commit(one);
-	parse_commit(two);
-
-	one->object.flags |= PARENT1;
-	two->object.flags |= PARENT2;
-	insert_by_date(one, &list);
-	insert_by_date(two, &list);
-
 	while (interesting(list)) {
 		struct commit *commit;
 		struct commit_list *parents;
@@ -1098,6 +1083,27 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return result;
 }
 
+static struct commit_list *merge_bases(struct commit *one, struct commit *two)
+{
+	struct commit_list *list = NULL;
+
+	if (one == two)
+		/* We do not mark this even with RESULT so we do not
+		 * have to clean it up.
+		 */
+		return commit_list_insert(one, &list);
+
+	parse_commit(one);
+	parse_commit(two);
+
+	one->object.flags |= PARENT1;
+	two->object.flags |= PARENT2;
+	insert_by_date(one, &list);
+	insert_by_date(two, &list);
+
+	return base_traverse(list);
+}
+
 struct commit_list *get_merge_bases(struct commit *one,
 				    struct commit *two,
                                     int cleanup)
-- 
1.4.4.4.g564d

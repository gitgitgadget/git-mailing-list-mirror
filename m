From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/6] Allow in_merge_bases() to take more than one reference commits.
Date: Tue, 09 Jan 2007 02:41:26 -0800
Message-ID: <7vzm8so52h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 11:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EQL-0003nM-QB
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbXAIKl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXAIKl3
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:41:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47975 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbXAIKl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:41:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109104127.MVNU25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:41:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yhi1W00G1kojtg0000000; Tue, 09 Jan 2007 05:41:43 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36344>

The internal function in_merge_bases(A, B) is used to make sure
that commit A is an ancestor of commit B.  This changes the
signature of it to take an array of B's and updates its current
callers.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-branch.c |    2 +-
 builtin-reflog.c |    4 ++--
 commit.c         |    9 ++++++---
 commit.h         |    2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index c760e18..daca603 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -134,7 +134,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		 */
 
 		if (!force &&
-		    !in_merge_bases(rev, head_rev)) {
+		    !in_merge_bases(rev, &head_rev, 1)) {
 			error("The branch '%s' is not a strict subset of "
 				"your current HEAD.\n"
 				"If you are sure you want to delete it, "
diff --git a/builtin-reflog.c b/builtin-reflog.c
index a967117..fb37984 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -217,8 +217,8 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	if ((timestamp < cb->cmd->expire_unreachable) &&
 	    (!cb->ref_commit ||
-	     (old && !in_merge_bases(old, cb->ref_commit)) ||
-	     (new && !in_merge_bases(new, cb->ref_commit))))
+	     (old && !in_merge_bases(old, &cb->ref_commit, 1)) ||
+	     (new && !in_merge_bases(new, &cb->ref_commit, 1))))
 		goto prune;
 
 	if (cb->newlog)
diff --git a/commit.c b/commit.c
index 496d37a..aa14c5a 100644
--- a/commit.c
+++ b/commit.c
@@ -1158,14 +1158,17 @@ struct commit_list *get_merge_bases(struct commit *one,
 	return result;
 }
 
-int in_merge_bases(struct commit *rev1, struct commit *rev2)
+int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 {
 	struct commit_list *bases, *b;
 	int ret = 0;
 
-	bases = get_merge_bases(rev1, rev2, 1);
+	if (num == 1)
+		bases = get_merge_bases(commit, *reference, 1);
+	else
+		die("not yet");
 	for (b = bases; b; b = b->next) {
-		if (!hashcmp(rev1->object.sha1, b->item->object.sha1)) {
+		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
 			ret = 1;
 			break;
 		}
diff --git a/commit.h b/commit.h
index 936f8fc..b8e6e18 100644
--- a/commit.h
+++ b/commit.h
@@ -114,5 +114,5 @@ extern int is_repository_shallow();
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
-int in_merge_bases(struct commit *rev1, struct commit *rev2);
+int in_merge_bases(struct commit *, struct commit **, int);
 #endif /* COMMIT_H */
-- 
1.4.4.4.g564d

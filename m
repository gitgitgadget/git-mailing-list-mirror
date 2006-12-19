X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Move in_merge_bases() to commit.c
Date: Tue, 19 Dec 2006 00:25:02 -0800
Message-ID: <7vbqm0thr5.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
	<20061218140813.GA32446@spearce.org>
	<7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 08:25:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34797>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwaHk-0002tb-KZ for gcvg-git@gmane.org; Tue, 19 Dec
 2006 09:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932669AbWLSIZF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 03:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWLSIZF
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 03:25:05 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34837 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932670AbWLSIZE (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 03:25:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219082503.JTIR20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 03:25:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0YRE1W00p1kojtg0000000; Tue, 19 Dec 2006
 03:25:15 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

This reasonably useful function was hidden inside builtin-branch.c
---

 * This is used by the next one, which is why this is part of
   the 'reflog entry and pruning' series.

 builtin-branch.c |   21 +--------------------
 commit.c         |   17 +++++++++++++++++
 commit.h         |    1 +
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 560309c..12eebc0 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -70,25 +70,6 @@ const char *branch_get_color(enum color_branch ix)
 	return "";
 }
 
-static int in_merge_bases(const unsigned char *sha1,
-			  struct commit *rev1,
-			  struct commit *rev2)
-{
-	struct commit_list *bases, *b;
-	int ret = 0;
-
-	bases = get_merge_bases(rev1, rev2, 1);
-	for (b = bases; b; b = b->next) {
-		if (!hashcmp(sha1, b->item->object.sha1)) {
-			ret = 1;
-			break;
-		}
-	}
-
-	free_commit_list(bases);
-	return ret;
-}
-
 static void delete_branches(int argc, const char **argv, int force)
 {
 	struct commit *rev, *head_rev = head_rev;
@@ -119,7 +100,7 @@ static void delete_branches(int argc, const char **argv, int force)
 		 */
 
 		if (!force &&
-		    !in_merge_bases(sha1, rev, head_rev)) {
+		    !in_merge_bases(rev, head_rev)) {
 			fprintf(stderr,
 				"The branch '%s' is not a strict subset of your current HEAD.\n"
 				"If you are sure you want to delete it, run 'git branch -D %s'.\n",
diff --git a/commit.c b/commit.c
index a6d543e..4bddcbe 100644
--- a/commit.c
+++ b/commit.c
@@ -1009,3 +1009,20 @@ struct commit_list *get_merge_bases(struct commit *one,
 	free(rslt);
 	return result;
 }
+
+int in_merge_bases(struct commit *rev1, struct commit *rev2)
+{
+	struct commit_list *bases, *b;
+	int ret = 0;
+
+	bases = get_merge_bases(rev1, rev2, 1);
+	for (b = bases; b; b = b->next) {
+		if (!hashcmp(rev1->object.sha1, b->item->object.sha1)) {
+			ret = 1;
+			break;
+		}
+	}
+
+	free_commit_list(bases);
+	return ret;
+}
diff --git a/commit.h b/commit.h
index fc13de9..10eea9f 100644
--- a/commit.h
+++ b/commit.h
@@ -107,4 +107,5 @@ int read_graft_file(const char *graft_file);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 
+int in_merge_bases(struct commit *rev1, struct commit *rev2);
 #endif /* COMMIT_H */
-- 
1.4.4.2.g688739


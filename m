X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-branch -D: make it work even when on a yet-to-be-born branch
Date: Fri, 24 Nov 2006 23:12:41 -0800
Message-ID: <7vr6vs579y.fsf_-_@assigned-by-dhcp.cox.net>
References: <1164409429445-git-send-email-hjemli@gmail.com>
	<7v1wns6q41.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 07:12:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v1wns6q41.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 24 Nov 2006 21:40:30 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32261>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnriU-0004Ys-Rj for gcvg-git@gmane.org; Sat, 25 Nov
 2006 08:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933429AbWKYHMn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 02:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934284AbWKYHMn
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 02:12:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:29608 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S933429AbWKYHMm
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 02:12:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125071242.YHUD296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 02:12:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qvCp1V0111kojtg0000000; Sat, 25 Nov 2006
 02:12:50 -0500
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

This makes "git branch -D other_branch" work even when HEAD
points at a yet-to-be-born branch.

Earlier, we checked the HEAD ref for the purpose of "subset"
check even when the deletion was forced (i.e. not -d but -D).
Because of this, you cannot delete a branch even with -D while
on a yet-to-be-born branch.

With this change, the following sequence that now works:

	mkdir newdir && cd newdir
	git init-db
	git fetch -k $other_repo refs/heads/master:refs/heads/othre
	# oops, typo
	git branch other othre
	git branch -D othre

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Junio C Hamano <junkio@cox.net> writes:

  > When forcing a deletion, we do not care about ancestry relation
  > between the HEAD and the branch being deleted, so we should not
  > even bother checking if HEAD is already valid.  The original
  > code before your patch shares the same problem.

  And here is a fix for that.  This is on top of your -v change
  which I've applied.

 builtin-branch.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 69b7b55..3d5cb0e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -38,12 +38,16 @@ static int in_merge_bases(const unsigned char *sha1,
 
 static void delete_branches(int argc, const char **argv, int force)
 {
-	struct commit *rev, *head_rev;
+	struct commit *rev, *head_rev = head_rev;
 	unsigned char sha1[20];
 	char *name;
 	int i;
 
-	head_rev = lookup_commit_reference(head_sha1);
+	if (!force) {
+		head_rev = lookup_commit_reference(head_sha1);
+		if (!head_rev)
+			die("Couldn't look up commit object for HEAD");
+	}
 	for (i = 0; i < argc; i++) {
 		if (!strcmp(head, argv[i]))
 			die("Cannot delete the branch you are currently on.");
@@ -53,8 +57,8 @@ static void delete_branches(int argc, const char **argv, int force)
 			die("Branch '%s' not found.", argv[i]);
 
 		rev = lookup_commit_reference(sha1);
-		if (!rev || !head_rev)
-			die("Couldn't look up commit objects.");
+		if (!rev)
+			die("Couldn't look up commit object for '%s'", name);
 
 		/* This checks whether the merge bases of branch and
 		 * HEAD contains branch -- which means that the HEAD
-- 
1.4.4.1.g61fba


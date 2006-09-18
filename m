From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fsck-objects: adjust to resolve_ref() clean-up.
Date: Mon, 18 Sep 2006 11:44:25 -0700
Message-ID: <7vac4xovzq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Sep 18 20:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPO6Y-0005vB-Bt
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 20:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWIRSo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 14:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWIRSo1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 14:44:27 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27089 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751138AbWIRSo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 14:44:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918184425.YIEQ12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 14:44:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PukC1V00R1kojtg0000000
	Mon, 18 Sep 2006 14:44:13 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27258>

Clean-up the same "ref to path and then back to ref" confusion.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 fsck-objects.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fsck-objects.c b/fsck-objects.c
index 4d994f3..456c17e 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -458,15 +458,13 @@ static void fsck_object_dir(const char *
 static int fsck_head_link(void)
 {
 	unsigned char sha1[20];
-	const char *git_HEAD = xstrdup(git_path("HEAD"));
-	const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1, 1);
-	int pfxlen = strlen(git_HEAD) - 4; /* strip .../.git/ part */
+	const char *head_points_at = resolve_ref("HEAD", sha1, 1);
 
-	if (!git_refs_heads_master)
+	if (!head_points_at)
 		return error("HEAD is not a symbolic ref");
-	if (strncmp(git_refs_heads_master + pfxlen, "refs/heads/", 11))
+	if (strncmp(head_points_at, "refs/heads/", 11))
 		return error("HEAD points to something strange (%s)",
-			     git_refs_heads_master + pfxlen);
+			     head_points_at);
 	if (is_null_sha1(sha1))
 		return error("HEAD: not a valid git pointer");
 	return 0;
-- 
1.4.2.1.g01ff

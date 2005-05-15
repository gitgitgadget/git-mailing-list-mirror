From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Tweak diff output further to make it a bit less
 distracting.
Date: Sun, 15 May 2005 11:10:12 -0700
Message-ID: <7vzmuwtl6j.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
	<7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
	<20050513233354.GK32232@pasky.ji.cz>
	<7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
	<7voebe63zs.fsf@assigned-by-dhcp.cox.net>
	<20050514150356.GK3905@pasky.ji.cz>
	<7vu0l5zsb4.fsf@assigned-by-dhcp.cox.net>
	<20050514233538.GY3905@pasky.ji.cz>
	<7vr7g9uhsl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 20:11:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXNZR-0001Lr-UR
	for gcvg-git@gmane.org; Sun, 15 May 2005 20:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEOSKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 14:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVEOSKl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 14:10:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5017 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261186AbVEOSKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 14:10:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515181012.VDVU23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 14:10:12 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Seriously...

Adds an newline between each diff.  Also change "#mode : "
string, which was misleading in that we are not showing just
mode when we talk about a file changing into a symlink.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c                 |   18 ++++++++++--------
t/t4000-diff-format.sh |    6 ++++--
2 files changed, 14 insertions(+), 10 deletions(-)

--- a/diff.c
+++ b/diff.c
@@ -83,7 +83,7 @@
 			 struct diff_tempfile *temp)
 {
 	int i, next_at;
-	const char *git_prefix = "# mode: ";
+	const char *git_prefix = "\n@. ";
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
 	const char *diff_arg  = "'%s' '%s'||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
@@ -128,15 +128,17 @@
 	else if (!path1[1][0])
 		printf("%s%s . %s\n", git_prefix, temp[0].mode, name);
 	else {
-		if (strcmp(temp[0].mode, temp[1].mode))
+		if (strcmp(temp[0].mode, temp[1].mode)) {
 			printf("%s%s %s %s\n", git_prefix,
 			       temp[0].mode, temp[1].mode, name);
-
-		if (strncmp(temp[0].mode, temp[1].mode, 3))
-			/* we do not run diff between different kind
-			 * of objects.
-			 */
-			exit(0);
+			if (strncmp(temp[0].mode, temp[1].mode, 3))
+				/* we do not run diff between different kind
+				 * of objects.
+				 */
+				exit(0);
+		}
+		else
+			putchar('\n');
 	}
 	fflush(NULL);
 	execlp("/bin/sh","sh", "-c", cmd, NULL);
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -26,7 +26,8 @@
     'git-diff-files -p after editing work tree.' \
     'git-diff-files -p >current'
 cat >expected <<\EOF
-# mode: 100644 100755 path0
+
+@. 100644 100755 path0
 --- a/path0
 +++ b/path0
 @@ -1,3 +1,3 @@
@@ -34,7 +35,8 @@
  Line 2
 -line 3
 +Line 3
-# mode: 100755 . path1
+
+@. 100755 . path1
 --- a/path1
 +++ /dev/null
 @@ -1,3 +0,0 @@
------------------------------------------------


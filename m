From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix diff output take #3.
Date: Mon, 16 May 2005 17:11:19 -0700
Message-ID: <7voebalniw.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
	<20050516220559.GC8609@pasky.ji.cz>
	<7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 02:13:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXphS-0000jy-NI
	for gcvg-git@gmane.org; Tue, 17 May 2005 02:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVEQAMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 20:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVEQAMn
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 20:12:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60143 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261343AbVEQALV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 20:11:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517001120.SZSB7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 20:11:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 16 May 2005 16:28:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This implements the output format suggested by Linus in
<Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c                 |   14 +++++++-------
t/t4000-diff-format.sh |    7 +++++--
2 files changed, 12 insertions(+), 9 deletions(-)

diff -git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -83,7 +83,6 @@
 			 struct diff_tempfile *temp)
 {
 	int i, next_at;
-	const char *git_prefix = "# mode: ";
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
 	const char *diff_arg  = "'%s' '%s'||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
@@ -123,15 +122,16 @@
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    diff_arg, input_name_sq[0], input_name_sq[1]);
 
+	printf("diff -git a/%s b/%s\n", name, name);
 	if (!path1[0][0])
-		printf("%s. %s %s\n", git_prefix, temp[1].mode, name);
+		printf("new file mode %s\n", temp[1].mode);
 	else if (!path1[1][0])
-		printf("%s%s . %s\n", git_prefix, temp[0].mode, name);
+		printf("deleted file mode %s\n", temp[0].mode);
 	else {
-		if (strcmp(temp[0].mode, temp[1].mode))
-			printf("%s%s %s %s\n", git_prefix,
-			       temp[0].mode, temp[1].mode, name);
-
+		if (strcmp(temp[0].mode, temp[1].mode)) {
+			printf("old mode %s\n", temp[0].mode);
+			printf("new mode %s\n", temp[1].mode);
+		}
 		if (strncmp(temp[0].mode, temp[1].mode, 3))
 			/* we do not run diff between different kind
 			 * of objects.
diff -git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -26,7 +26,9 @@
     'git-diff-files -p after editing work tree.' \
     'git-diff-files -p >current'
 cat >expected <<\EOF
-# mode: 100644 100755 path0
+diff -git a/path0 b/path0
+old mode 100644
+new mode 100755
 --- a/path0
 +++ b/path0
 @@ -1,3 +1,3 @@
@@ -34,7 +36,8 @@
  Line 2
 -line 3
 +Line 3
-# mode: 100755 . path1
+diff -git a/path1 b/path1
+deleted file mode 100755
 --- a/path1
 +++ /dev/null
 @@ -1,3 +0,0 @@
------------------------------------------------


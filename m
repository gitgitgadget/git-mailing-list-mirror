From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix diff output take #4.
Date: Wed, 18 May 2005 09:10:47 -0700
Message-ID: <7vpsvopla0.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
	<20050516220559.GC8609@pasky.ji.cz>
	<7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
	<7vsm0mlosf.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.05.18.13.40.32.907488@smurf.noris.de>
	<Pine.LNX.4.58.0505180819190.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 18 18:16:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYRAQ-0004JB-RN
	for gcvg-git@gmane.org; Wed, 18 May 2005 18:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVERQNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVERQMv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 12:12:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:2558 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261996AbVERQKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 12:10:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518161049.NNIQ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 12:10:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505180819190.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 18 May 2005 08:20:35 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Yes, that makes sense. It's not three flags "g" "i" and "t", it's the 
LT> "git" flag.

Concurred.  This is against the tip of your tree.  Pasky already
has a version with '-git' in his tree but I trust he can deal
with that single byte change locally.

------------
[PATCH] Fix diff output take #4.

This implements the output format suggested by Linus in
<Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>, except the
imaginary diff option is spelled "diff --git" with double
dashes.

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
 
+	printf("diff --git a/%s b/%s\n", name, name);
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
+diff --git a/path0 b/path0
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
+diff --git a/path1 b/path1
+deleted file mode 100755
 --- a/path1
 +++ /dev/null
 @@ -1,3 +0,0 @@
------------------------------------------------



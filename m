From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] builtin-rerere: fix conflict markers parsing
Date: Mon,  7 Jul 2008 14:42:48 +0200
Message-ID: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 14:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFq48-0000Bg-Qk
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 14:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYGGMmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 08:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbYGGMmj
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 08:42:39 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:56926 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbYGGMmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 08:42:38 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id E433A12B6E0;
	Mon,  7 Jul 2008 14:42:36 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A89D512B6D7;
	Mon,  7 Jul 2008 14:42:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.346.gddd7f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87602>

From: Olivier Marin <dkr@freesurf.fr>

When a conflicting file contains a line that begin with "=======", rerere
failed to parse conflict markers. This result to a wrong preimage file and
an unexpected error for the user.

This patch enforce parsing rules so that markers match in the right order
and update tests to match the above fix.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---

 This happend to me with a conflict in Documentation/git-remote.txt.

 The bug seems to have always been there but nobody noticed probably because
 before a1b32fdc3d1d05395f186bfa06e92174519dab8d parsing errors were ignored
 and (I think) it does not affect the way git rerere works.

 builtin-rerere.c  |    7 ++++---
 t/t4200-rerere.sh |   26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 839b26e..e618862 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -112,11 +112,12 @@ static int handle_file(const char *path,
 	strbuf_init(&one, 0);
 	strbuf_init(&two,  0);
 	while (fgets(buf, sizeof(buf), f)) {
-		if (!prefixcmp(buf, "<<<<<<< "))
+		if (hunk == 0 && !prefixcmp(buf, "<<<<<<< "))
 			hunk = 1;
-		else if (!prefixcmp(buf, "======="))
+		else if (hunk == 1 && !prefixcmp(buf, "=======") &&
+			 isspace(buf[7]))
 			hunk = 2;
-		else if (!prefixcmp(buf, ">>>>>>> ")) {
+		else if (hunk == 2 && !prefixcmp(buf, ">>>>>>> ")) {
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
 			hunk_no++;
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index a64727d..cf10557 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -9,6 +9,8 @@ test_description='git rerere
 . ./test-lib.sh
 
 cat > a1 << EOF
+Some title
+==========
 Whether 'tis nobler in the mind to suffer
 The slings and arrows of outrageous fortune,
 Or to take arms against a sea of troubles,
@@ -24,6 +26,8 @@ git commit -q -a -m initial
 
 git checkout -b first
 cat >> a1 << EOF
+Some title
+==========
 To die, to sleep;
 To sleep: perchance to dream: ay, there's the rub;
 For in that sleep of death what dreams may come
@@ -35,7 +39,7 @@ git commit -q -a -m first
 
 git checkout -b second master
 git show first:a1 |
-sed -e 's/To die, t/To die! T/' > a1
+sed -e 's/To die, t/To die! T/' -e 's/Some title/Some Title/' > a1
 echo "* END *" >>a1
 git commit -q -a -m second
 
@@ -55,14 +59,14 @@ test_expect_success 'conflicting merge' '
 
 sha1=$(sed -e 's/	.*//' .git/rr-cache/MERGE_RR)
 rr=.git/rr-cache/$sha1
-test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
+test_expect_success 'recorded preimage' "grep ^=======$ $rr/preimage"
 
 test_expect_success 'rerere.enabled works, too' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled true &&
 	git reset --hard &&
 	! git merge first &&
-	grep ======= $rr/preimage
+	grep ^=======$ $rr/preimage
 '
 
 test_expect_success 'no postimage or thisimage yet' \
@@ -71,7 +75,7 @@ test_expect_success 'no postimage or thisimage yet' \
 test_expect_success 'preimage has right number of lines' '
 
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
-	test $cnt = 9
+	test $cnt = 13
 
 '
 
@@ -80,13 +84,23 @@ git show first:a1 > a1
 cat > expect << EOF
 --- a/a1
 +++ b/a1
-@@ -6,17 +6,9 @@
+@@ -1,4 +1,4 @@
+-Some Title
++Some title
+ ==========
+ Whether 'tis nobler in the mind to suffer
+ The slings and arrows of outrageous fortune,
+@@ -8,21 +8,11 @@
  The heart-ache and the thousand natural shocks
  That flesh is heir to, 'tis a consummation
  Devoutly to be wish'd.
 -<<<<<<<
+-Some Title
+-==========
 -To die! To sleep;
 -=======
+ Some title
+ ==========
  To die, to sleep;
 ->>>>>>>
  To sleep: perchance to dream: ay, there's the rub;
@@ -124,7 +138,7 @@ test_expect_success 'another conflicting merge' '
 '
 
 git show first:a1 | sed 's/To die: t/To die! T/' > expect
-test_expect_success 'rerere kicked in' "! grep ======= a1"
+test_expect_success 'rerere kicked in' "! grep ^=======$ a1"
 
 test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
 
-- 
1.5.6.2.346.gddd7f

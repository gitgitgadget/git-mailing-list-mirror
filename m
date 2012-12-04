From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] t9402: sed -i is not portable
Date: Tue, 4 Dec 2012 20:44:48 +0100
Message-ID: <201212042044.49477.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org, mmogilvi_git@miniinfo.net
X-From: git-owner@vger.kernel.org Tue Dec 04 20:45:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfyQb-0005I4-3h
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 20:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab2LDTo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2012 14:44:57 -0500
Received: from mout.web.de ([212.227.17.12]:49607 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab2LDTo4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2012 14:44:56 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LvSU3-1TFOyr21GF-00zvIm; Tue, 04 Dec 2012 20:44:54 +0100
X-Provags-ID: V02:K0:xtEk9X+gVO/kQzSQCDnZ301LyeIde96q0lFPLXiPj2F
 vj1gSnVRc3aJUEE0tDdIvPgPxUarDFfiMj8uen1sPbv/VaatHY
 ZEMTZ4UZ89WUNXwkB/e5xS5YWtaqHxlP1wRhHSjh2I04Dexj3c
 sn8bWkV0SrMZmlp6sjp7zrN9X85aHRNcIpAXtBIk2a6RzBVgJ2
 +RABmT5jJLJmUM9jbmJFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211093>

On some systems sed allows the usage of e.g.
sed -i -e "s/line1/line2/" afile
to edit the file "in place".
Other systems don't allow that: one observed behaviour is that
sed -i -e "s/line1/line2/" afile
creates a backup file called afile-e, which breaks the test.
As sed -i is not part of POSIX, avoid it.

Use test_cmp, makes the test easier to debug.
Chain all shell commands with && to detect all kinds of failure.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v1:
No correction of TABs to make it easier to review

If this is OK:
Matthew would you like to send a complete re-roll,
because the credit should be on you ?

 t/t9402-git-cvsserver-refs.sh | 44 ++++++++++++++++++++++-------------=
--------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index 858ef0f..5138f14 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -28,27 +28,26 @@ check_file() {
 }
=20
 check_end_tree() {
-    sandbox=3D"$1"
-    expectCount=3D$(wc -l < "$WORKDIR/check.list")
-    cvsCount=3D$(find "$sandbox" -name CVS -prune -o -type f -print | =
wc -l)
-    test x"$cvsCount" =3D x"$expectCount"
-    stat=3D$?
-    echo "check_end $sandbox : $stat cvs=3D$cvsCount expect=3D$expectC=
ount" \
-	>> "$WORKDIR/check.log"
-    return $stat
+    sandbox=3D"$1" &&
+    wc -l < "$WORKDIR/check.list" > expected &&
+    find "$sandbox" -type f | grep -v "/CVS" > "$WORKDIR/check.cvsCoun=
t" &&
+    wc -l < "$WORKDIR/check.cvsCount" >actual &&
+    test_cmp expected actual &&
+		rm expected actual &&
+		sort < "$WORKDIR/check.list" > expected &&
+		sort < "$WORKDIR/check.cvsCount" | sed -e "s%cvswork/%%" >actual &&
+    test_cmp expected actual &&
+		rm expected actual
 }
=20
 check_end_full_tree() {
-    sandbox=3D"$1"
-    ver=3D"$2"
-    expectCount=3D$(wc -l < "$WORKDIR/check.list")
-    cvsCount=3D$(find "$sandbox" -name CVS -prune -o -type f -print | =
wc -l)
-    gitCount=3D$(git ls-tree -r "$2" | wc -l)
-    test x"$cvsCount" =3D x"$expectCount" -a x"$gitCount" =3D x"$expec=
tCount"
-    stat=3D$?
-    echo "check_end $sandbox : $stat cvs=3D$cvsCount git=3D$gitCount e=
xpect=3D$expectCount" \
-	>> "$WORKDIR/check.log"
-    return $stat
+    sandbox=3D"$1" &&
+    sort < "$WORKDIR/check.list" >expected &&
+    find "$sandbox" -name CVS -prune -o -type f -print | sed -e "s%$sa=
ndbox/%%" | sort >act1 &&
+		test_cmp expected act1 &&
+    git ls-tree -r "$2" | sed -e "s/^.*blob [0-9a-fA-F]*[	 ]*//" | sor=
t > act2 &&
+		test_cmp expected act2 &&
+    rm expected act1 act2
 }
=20
 #########
@@ -155,7 +154,8 @@ test_expect_success 'cvs co b1 [cvswork3]' '
=20
 test_expect_success 'edit cvswork3 and save diff' '
     ( cd cvswork3 &&
-      sed -i -e "s/line1/line1 - data/" adir/afile &&
+      sed -e "s/line1/line1 - data/" adir/afile >adir/afileNEW &&
+			mv -f adir/afileNEW adir/afile &&
       echo "afile5" > adir/afile5 &&
       rm t2 &&
       cvs -f add adir/afile5 &&
@@ -168,7 +168,8 @@ test_expect_success 'setup v1.2 on b1' '
     git checkout b1 &&
     echo "new v1.2" > t3 &&
     rm t2 &&
-    sed -i -e "s/line3/line3 - more data/" adir/afile &&
+    sed -e "s/line3/line3 - more data/" adir/afile >adir/afileNEW &&
+		mv -f adir/afileNEW adir/afile &&
     rm adir/a2file &&
     echo "a3file" >> adir/a3file &&
     echo "bfile line 3" >> adir/bdir/bfile &&
@@ -300,7 +301,8 @@ test_expect_success 'root dir rm file [cvswork2]' '
=20
 test_expect_success 'subdir edit/add/rm files [cvswork2' '
     ( cd cvswork2 &&
-      sed -i -e "s/line 1/line 1 (v2)/" adir/bdir/bfile &&
+      sed -e "s/line 1/line 1 (v2)/" adir/bdir/bfile >adir/bdir/bfileN=
EW &&
+      mv -f adir/bdir/bfileNEW adir/bdir/bfile &&
       rm adir/bdir/b2file &&
       cd adir &&
       cvs -f rm bdir/b2file &&
--=20
1.8.0.197.g5a90748

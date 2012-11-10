From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t9402: sed -i is not portable
Date: Sat, 10 Nov 2012 09:01:44 +0100
Message-ID: <201211100901.45223.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mmogilvi_git@miniinfo.net, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 09:02:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX60z-0001Zc-UT
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 09:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab2KJIBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 03:01:53 -0500
Received: from mout.web.de ([212.227.15.3]:61541 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab2KJIBw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 03:01:52 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LyUgM-1TIVhI1Tpm-015E48; Sat, 10 Nov 2012 09:01:50 +0100
X-Provags-ID: V02:K0:SuK+dI5F227eLe3PGaoEgmcc+Kk+0KEdHCB6jDeq/Ox
 EZROwYN1zzsUEMjse9MsZfSKw8cERLrtZG8xfuIVVjYioKLbJR
 lMpAlAGl4kdUAAsipW/skhVoilp5DgmIBjRBPyhl9gXr7rlBbK
 Yxeo+ZrZkYABe8JKzMQBA0aYTlXg/OOVu+QpRXuoBNXe5/w7Qb
 exm8v8hr29M9W6j4vgj2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209262>

The command line
sed -i -e "s/foo/bar/" filename
works as expected under GNU/Linux:
all "foo" are replaced by "bar" in the file "filename"

sed on other systems like e.g. Mac OS X creates a backup file
called filename-e, because the -i must be followed by a file name.
As the -i is not in POSIX either, avoid it completely

Improve check_end_tree() and check_end_full_tree() to use test_cmp,
and use the && between each line.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
This must be applied on peff/pu

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
1.7.12

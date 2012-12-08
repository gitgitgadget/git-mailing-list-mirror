From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/8] t9402: improve check_end_tree() and check_end_full_tree()
Date: Sat, 8 Dec 2012 22:33:55 +0100
Message-ID: <201212082233.56082.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:34:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS2Q-0000qW-2o
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185Ab2LHVeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:34:05 -0500
Received: from mout.web.de ([212.227.15.3]:65203 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2LHVeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:34:04 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MduAD-1TXLGx0BkD-00QH1z; Sat, 08 Dec 2012 22:34:02 +0100
X-Provags-ID: V02:K0:6Jd+ZzDSwVraZMw112CjUfF2fDbqso0MFH6DyovRuwE
 +ktBDSWyjCduFKs9VKXJvN0jivR+WEXoRLDetKqJUGIdSZb73M
 CtUcJAXO7VSFCkT0voA2ba2Vgdzrwh9lrvPaZ8Xr150BZ7CHUi
 68keLzMUxKdL9sUvbpFjigXEXL5LGh/0SNMvCn+zXnRKNw8pM4
 4vSRebfGZU4jcsNq8UPtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211216>

check_end_tree():
- Instead of counting lines using wc in expectCount and cvsCount:
   Sort and compare the files byte by byte with test_cmp,
   which is more exact and easier to debug
- Chain all shell comands together using &&

check_end_full_tree()
- Instead of counting lines using wc in expectCount, cvsCount and gitCo=
unt:
   Sort and compare the files byte by byte with test_cmp,
   which is more exact and easier to debug
- Break the test using two conditions anded together with -a
  into to call to test_cmp
- Chain all shell comands together using &&

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9402-git-cvsserver-refs.sh | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index c01748a..f1bea0f 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -28,27 +28,22 @@ check_file() {
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
+    find "$sandbox" -name CVS -prune -o -type f -print >"$WORKDIR/chec=
k.cvsCount" &&
+		sort <"$WORKDIR/check.list" >expected &&
+		sort <"$WORKDIR/check.cvsCount" | sed -e "s%cvswork/%%" >actual &&
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
+    sort <"$WORKDIR/check.list" >expected &&
+    find "$sandbox" -name CVS -prune -o -type f -print | sed -e "s%$sa=
ndbox/%%" | sort >act1 &&
+		test_cmp expected act1 &&
+    git ls-tree -r "$2" | sed -e "s/^.*blob [0-9a-fA-F]*[	 ]*//" | sor=
t >act2 &&
+		test_cmp expected act2 &&
+    rm expected act1 act2
 }
=20
 #########
--=20
1.8.0.197.g5a90748

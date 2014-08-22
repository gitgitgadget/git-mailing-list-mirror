From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2 2/3] MinGW: Update tests to handle a native eol of crlf
Date: Fri, 22 Aug 2014 21:19:06 +0200
Message-ID: <53F797AA.1030504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 21:19:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKuMm-0000nK-OC
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 21:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbaHVTTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2014 15:19:11 -0400
Received: from mout.web.de ([212.227.17.12]:59755 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbaHVTTK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 15:19:10 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0M4I6Z-1WTDLj2xWd-00rp3r; Fri, 22 Aug 2014 21:19:08
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:4Qjp2uoAtxBQ1/Qcv8Xznp8UQKZxVMviUa0pM5spRKe+lO9v/QF
 D1IZkBWmtNa0ER8gVtajLGXanfYifrA5TU50TI1zyzLDaAyeiTdaQ5g0tOZXHRipZZsq94B
 OdYInNPZnxWfw0fAyAKrwud9ht6bF1PFnsxbZDcLap/uWJbjYbSxflngiUS/d0UtD6IAkza
 WVdd9riPmON3P/RBmypWg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255694>

Some of the tests were written with the assumption that the native eol =
would
always be lf. After defining NATIVE_CRLF on MinGW, these tests began fa=
iling.
This change will update the tests to also handle a native eol of crlf.

Signed-off-by: Brice Lambson <bricelam@live.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t6038-merge-text-auto.sh | 54 +++++++++++++++++++++++++++++---------=
--------
 t/test-lib.sh              |  1 +
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index d9c2d38..85c10b0 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -72,6 +72,10 @@ test_expect_success 'Merge after setting text=3Dauto=
' '
 	same line
 	EOF
=20
+	if test_have_prereq NATIVE_CRLF; then
+		append_cr <expected >expected.temp &&
+		mv expected.temp expected
+	fi &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -86,6 +90,10 @@ test_expect_success 'Merge addition of text=3Dauto' =
'
 	same line
 	EOF
=20
+	if test_have_prereq NATIVE_CRLF; then
+		append_cr <expected >expected.temp &&
+		mv expected.temp expected
+	fi &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -95,16 +103,19 @@ test_expect_success 'Merge addition of text=3Dauto=
' '
 '
=20
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
-	q_to_cr <<-\EOF >expected &&
-	<<<<<<<
-	first line
-	same line
-	=3D=3D=3D=3D=3D=3D=3D
-	first lineQ
-	same lineQ
-	>>>>>>>
-	EOF
-
+	echo "<<<<<<<" >expected &&
+	if test_have_prereq NATIVE_CRLF; then
+		echo first line | append_cr >>expected &&
+		echo same line | append_cr >>expected &&
+		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected
+	else
+		echo first line >>expected &&
+		echo same line >>expected &&
+		echo =3D=3D=3D=3D=3D=3D=3D >>expected
+	fi &&
+	echo first line | append_cr >>expected &&
+	echo same line | append_cr >>expected &&
+	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
 	git reset --hard a &&
@@ -114,16 +125,19 @@ test_expect_success 'Detect CRLF/LF conflict afte=
r setting text=3Dauto' '
 '
=20
 test_expect_success 'Detect LF/CRLF conflict from addition of text=3Da=
uto' '
-	q_to_cr <<-\EOF >expected &&
-	<<<<<<<
-	first lineQ
-	same lineQ
-	=3D=3D=3D=3D=3D=3D=3D
-	first line
-	same line
-	>>>>>>>
-	EOF
-
+	echo "<<<<<<<" >expected &&
+	echo first line | append_cr >>expected &&
+	echo same line | append_cr >>expected &&
+	if test_have_prereq NATIVE_CRLF; then
+		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
+		echo first line | append_cr >>expected &&
+		echo same line | append_cr >>expected
+	else
+		echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
+		echo first line >>expected &&
+		echo same line >>expected
+	fi &&
+	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
 	git reset --hard b &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1bc65b..aceb418 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -871,6 +871,7 @@ case $(uname -s) in
 	# exec does not inherit the PID
 	test_set_prereq MINGW
 	test_set_prereq NOT_CYGWIN
+	test_set_prereq NATIVE_CRLF
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	GIT_TEST_CMP=3Dmingw_test_cmp
--=20
2.1.0.rc2.210.g636bceb

From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v5 1/3] blame,cat-file: Prepare --textconv tests for correctly-failing conversion program
Date: Wed, 29 Sep 2010 15:35:22 +0400
Message-ID: <6b9535a19651c2354eac6634ba88b6fb3442044b.1285758714.git.kirr@mns.spb.ru>
References: <cover.1285758714.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 13:34:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0uvb-00072Z-Nr
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122Ab0I2Ld4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 07:33:56 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:58926 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab0I2Ldz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 07:33:55 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1P0uuM-0003f0-Oz; Wed, 29 Sep 2010 15:33:11 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1P0uwZ-0001QW-Jk; Wed, 29 Sep 2010 15:35:27 +0400
X-Mailer: git-send-email 1.7.3.19.g3fe0a
In-Reply-To: <cover.1285758714.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1285758714.git.kirr@mns.spb.ru>
References: <cover.1285758714.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157554>

=46rom: Kirill Smelkov <kirr@landau.phys.spbu.ru>

The textconv filter is sometimes incorrectly ran on a temporary file
whose content is the target of a symbolic link, instead of actual file
content. Prepare to test this by marking the content of the file to
convert with "bin:", and let the helper die if "bin:" is not found in
the file content.

NOTE: I've changed $@ to $1 in helper becase textconv program "should
take a single argument" (see Documentation/gitattributes.txt), so
making this more explicit makes sense and also helps to avoid
problems with feeding arguments to echo.

(Description partly by Matthieu Moy)

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

v5:

 o Avoid touching t4042-diff-textconv-caching.sh at all.
 o Use $1 instead of $@ in textconv helper

v4:

 o Use consistent pattern for detecting and converting binaries (was 'b=
in:' and
   'bin: ')

v3:

 o Add Matthieu's Reviewed-by, and move secondary note to the end to av=
oid
   distracting an intrested reader.

v2:

 o Changed patch description as suggested by Matthieu



 t/t8006-blame-textconv.sh    |   15 ++++++++-------
 t/t8007-cat-file-textconv.sh |   11 ++++++-----
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 9ad96d4..3619f8a 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -9,22 +9,23 @@ find_blame() {
=20
 cat >helper <<'EOF'
 #!/bin/sh
-sed 's/^/converted: /' "$@"
+grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; e=
xit 1; }
+sed 's/^bin: /converted: /' "$1"
 EOF
 chmod +x helper
=20
 test_expect_success 'setup ' '
-	echo test 1 >one.bin &&
-	echo test number 2 >two.bin &&
+	echo "bin: test 1" >one.bin &&
+	echo "bin: test number 2" >two.bin &&
 	git add . &&
 	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
-	echo test 1 version 2 >one.bin &&
-	echo test number 2 version 2 >>two.bin &&
+	echo "bin: test 1 version 2" >one.bin &&
+	echo "bin: test number 2 version 2" >>two.bin &&
 	GIT_AUTHOR_NAME=3DNumber2 git commit -a -m Second --date=3D"2010-01-0=
1 20:00:00"
 '
=20
 cat >expected <<EOF
-(Number2 2010-01-01 20:00:00 +0000 1) test 1 version 2
+(Number2 2010-01-01 20:00:00 +0000 1) bin: test 1 version 2
 EOF
=20
 test_expect_success 'no filter specified' '
@@ -67,7 +68,7 @@ test_expect_success 'blame --textconv going through r=
evisions' '
 '
=20
 test_expect_success 'make a new commit' '
-	echo "test number 2 version 3" >>two.bin &&
+	echo "bin: test number 2 version 3" >>two.bin &&
 	GIT_AUTHOR_NAME=3DNumber3 git commit -a -m Third --date=3D"2010-01-01=
 22:00:00"
 '
=20
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.s=
h
index 38ac05e..71f4145 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -5,15 +5,16 @@ test_description=3D'git cat-file textconv support'
=20
 cat >helper <<'EOF'
 #!/bin/sh
-sed 's/^/converted: /' "$@"
+grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; e=
xit 1; }
+sed 's/^bin: /converted: /' "$1"
 EOF
 chmod +x helper
=20
 test_expect_success 'setup ' '
-	echo test >one.bin &&
+	echo "bin: test" >one.bin &&
 	git add . &&
 	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
-	echo test version 2 >one.bin &&
+	echo "bin: test version 2" >one.bin &&
 	GIT_AUTHOR_NAME=3DNumber2 git commit -a -m Second --date=3D"2010-01-0=
1 20:00:00"
 '
=20
@@ -33,7 +34,7 @@ test_expect_success 'setup textconv filters' '
 '
=20
 cat >expected <<EOF
-test version 2
+bin: test version 2
 EOF
=20
 test_expect_success 'cat-file without --textconv' '
@@ -42,7 +43,7 @@ test_expect_success 'cat-file without --textconv' '
 '
=20
 cat >expected <<EOF
-test
+bin: test
 EOF
=20
 test_expect_success 'cat-file without --textconv on previous commit' '
--=20
1.7.3.19.g3fe0a

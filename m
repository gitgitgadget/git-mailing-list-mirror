From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Sat, 18 Sep 2010 21:25:04 +0400
Message-ID: <26d0544dac2515e76bee0608881cfd8c23bf1ebf.1284830388.git.kirr@landau.phys.spbu.ru>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 19:24:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox193-0005Oh-PK
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 19:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0IRRXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 13:23:44 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:33044 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab0IRRXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 13:23:37 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 2B6C7FF6F3; Sat, 18 Sep 2010 21:23:36 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1Ox1A9-0001ci-Oy; Sat, 18 Sep 2010 21:25:21 +0400
X-Mailer: git-send-email 1.7.3.rc2
In-Reply-To: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156467>

Recently I've spot a bug in git blame --textconv, which was wrongly
calling pdftotext (my *.pdf conversion program) on a symlink.pdf, and I
was getting something like

    $ git blame -C -C regular-file.pdf
    Error: May not be a PDF file (continuing anyway)
    Error: PDF file is damaged - attempting to reconstruct xref table..=
=2E
    Error: Couldn't find trailer dictionary
    Error: Couldn't read xref table
    Warning: program returned non-zero exit code #1
    fatal: unable to read files to diff

That errors come from pdftotext run on symlink.pdf being extracted to
/tmp/ with one-line plain-text content pointing to link destination.

So git-blame is wrong here, and I'm going to write problem-demonstratio=
n
tests + try to fix it, but first we have to convert existing textconv
converter, so it will mimic pdftext behaviour -- if there is no '^bin:'
in input -- it's not a "binary" file and helper exits with error.

No other semantic changes at this stage.

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 t/t4042-diff-textconv-caching.sh |   25 +++++++++++++------------
 t/t8006-blame-textconv.sh        |   15 ++++++++-------
 t/t8007-cat-file-textconv.sh     |   11 ++++++-----
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-c=
aching.sh
index 91f8198..7668099 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -5,18 +5,19 @@ test_description=3D'test textconv caching'
=20
 cat >helper <<'EOF'
 #!/bin/sh
-sed 's/^/converted: /' "$@" >helper.out
+grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; e=
xit 1; }
+sed 's/^bin:/converted:/' "$@" >helper.out
 cat helper.out
 EOF
 chmod +x helper
=20
 test_expect_success 'setup' '
-	echo foo content 1 >foo.bin &&
-	echo bar content 1 >bar.bin &&
+	echo "bin: foo content 1" >foo.bin &&
+	echo "bin: bar content 1" >bar.bin &&
 	git add . &&
 	git commit -m one &&
-	echo foo content 2 >foo.bin &&
-	echo bar content 2 >bar.bin &&
+	echo "bin: foo content 2" >foo.bin &&
+	echo "bin: bar content 2" >bar.bin &&
 	git commit -a -m two &&
 	echo "*.bin diff=3Dmagic" >.gitattributes &&
 	git config diff.magic.textconv ./helper &&
@@ -25,14 +26,14 @@ test_expect_success 'setup' '
=20
 cat >expect <<EOF
 diff --git a/bar.bin b/bar.bin
-index fcf9166..28283d5 100644
+index 628fb83..f64d847 100644
 --- a/bar.bin
 +++ b/bar.bin
 @@ -1 +1 @@
 -converted: bar content 1
 +converted: bar content 2
 diff --git a/foo.bin b/foo.bin
-index d5b9fe3..1345db2 100644
+index 255496b..ad450ff 100644
 --- a/foo.bin
 +++ b/foo.bin
 @@ -1 +1 @@
@@ -59,7 +60,7 @@ test_expect_success 'cached textconv does not run hel=
per' '
=20
 cat >expect <<EOF
 diff --git a/bar.bin b/bar.bin
-index fcf9166..28283d5 100644
+index 628fb83..f64d847 100644
 --- a/bar.bin
 +++ b/bar.bin
 @@ -1,2 +1,2 @@
@@ -67,7 +68,7 @@ index fcf9166..28283d5 100644
 -converted: bar content 1
 +converted: bar content 2
 diff --git a/foo.bin b/foo.bin
-index d5b9fe3..1345db2 100644
+index 255496b..ad450ff 100644
 --- a/foo.bin
 +++ b/foo.bin
 @@ -1,2 +1,2 @@
@@ -76,7 +77,7 @@ index d5b9fe3..1345db2 100644
 +converted: foo content 2
 EOF
 test_expect_success 'changing textconv invalidates cache' '
-	echo other >other &&
+	echo "bin: other" >other &&
 	git config diff.magic.textconv "./helper other" &&
 	git diff HEAD^ HEAD >actual &&
 	test_cmp expect actual
@@ -84,7 +85,7 @@ test_expect_success 'changing textconv invalidates ca=
che' '
=20
 cat >expect <<EOF
 diff --git a/bar.bin b/bar.bin
-index fcf9166..28283d5 100644
+index 628fb83..f64d847 100644
 --- a/bar.bin
 +++ b/bar.bin
 @@ -1,2 +1,2 @@
@@ -92,7 +93,7 @@ index fcf9166..28283d5 100644
 -converted: bar content 1
 +converted: bar content 2
 diff --git a/foo.bin b/foo.bin
-index d5b9fe3..1345db2 100644
+index 255496b..ad450ff 100644
 --- a/foo.bin
 +++ b/foo.bin
 @@ -1 +1 @@
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 9ad96d4..d0f8d62 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -9,22 +9,23 @@ find_blame() {
=20
 cat >helper <<'EOF'
 #!/bin/sh
-sed 's/^/converted: /' "$@"
+grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; e=
xit 1; }
+sed 's/^bin:/converted:/' "$@"
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
index 38ac05e..413d623 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -5,15 +5,16 @@ test_description=3D'git cat-file textconv support'
=20
 cat >helper <<'EOF'
 #!/bin/sh
-sed 's/^/converted: /' "$@"
+grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; e=
xit 1; }
+sed 's/^bin:/converted:/' "$@"
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
1.7.3.rc2

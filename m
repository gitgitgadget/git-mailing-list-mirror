From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v5 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Wed, 29 Sep 2010 15:35:23 +0400
Message-ID: <c9b37682aedf2b29b1a774c4cfb1630543df41a6.1285758714.git.kirr@mns.spb.ru>
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
	id 1P0uvc-00072Z-8t
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab0I2LeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 07:34:01 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:58944 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab0I2Ld7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 07:33:59 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1P0uuN-0003f3-L0; Wed, 29 Sep 2010 15:33:11 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1P0uwa-0001QZ-LV; Wed, 29 Sep 2010 15:35:28 +0400
X-Mailer: git-send-email 1.7.3.19.g3fe0a
In-Reply-To: <cover.1285758714.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1285758714.git.kirr@mns.spb.ru>
References: <cover.1285758714.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157555>

=46rom: Kirill Smelkov <kirr@landau.phys.spbu.ru>

git blame --textconv is wrongly calling the textconv filter on
symlinks: symlinks are stored as blobs whose content is the target of
the link, and blame calls the textconv filter on a temporary file
filled-in with the content of this blob.

=46or example:

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

So several failures are demonstrated here:

  - git cat-file --textconv :symlink.bin    # also HEAD:symlink.bin
  - git blame --textconv symlink.bin
  - git blame -C -C --textconv regular-file # but also looks on symlink=
=2Ebin

At present they all fail with something like.

    E: /tmp/j3ELEs_symlink.bin is not "binary" file

NOTE: git diff doesn't try to textconv the pathnames, it runs the
textual diff without textconv, which is the expected behavior.

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

 o No changes

v4:

 o As noticed by Junio add prereq on SYMLINKS where appropriate

v3:

 o Slight cleanup of the description
 o Reviewed-by: Matthieu

v2:

 (As suggested by Matthieu)
 o Changed patch descriptio
 o Moved most of >expected preparation into test_expect_*
 o Changed multiple echo'es into cat <<EOF
 o Use printf "%s" instead echo -n, since latter is said to be not very
   portable


 t/t8006-blame-textconv.sh    |   49 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t8007-cat-file-textconv.sh |   29 ++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 3619f8a..7c35959 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -17,10 +17,16 @@ chmod +x helper
 test_expect_success 'setup ' '
 	echo "bin: test 1" >one.bin &&
 	echo "bin: test number 2" >two.bin &&
+	if test_have_prereq SYMLINKS; then
+		ln -s one.bin symlink.bin
+	fi &&
 	git add . &&
 	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
 	echo "bin: test 1 version 2" >one.bin &&
 	echo "bin: test number 2 version 2" >>two.bin &&
+	if test_have_prereq SYMLINKS; then
+		ln -sf two.bin symlink.bin
+	fi &&
 	GIT_AUTHOR_NAME=3DNumber2 git commit -a -m Second --date=3D"2010-01-0=
1 20:00:00"
 '
=20
@@ -78,4 +84,47 @@ test_expect_success 'blame from previous revision' '
 	test_cmp expected result
 '
=20
+cat >expected <<EOF
+(Number2 2010-01-01 20:00:00 +0000 1) two.bin
+EOF
+
+test_expect_success SYMLINKS 'blame with --no-textconv (on symlink)' '
+	git blame --no-textconv symlink.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
+# fails with '...symlink.bin is not "binary" file'
+test_expect_failure SYMLINKS 'blame --textconv (on symlink)' '
+	git blame --textconv symlink.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
+# cp two.bin three.bin  and make small tweak
+# (this will direct blame -C -C three.bin to consider two.bin and syml=
ink.bin)
+test_expect_success SYMLINKS 'make another new commit' '
+	cat >three.bin <<\EOF &&
+bin: test number 2
+bin: test number 2 version 2
+bin: test number 2 version 3
+bin: test number 3
+EOF
+	git add three.bin &&
+	GIT_AUTHOR_NAME=3DNumber4 git commit -a -m Fourth --date=3D"2010-01-0=
1 23:00:00"
+'
+
+# fails with '...symlink.bin is not "binary" file'
+test_expect_failure SYMLINKS 'blame on last commit (-C -C, symlink)' '
+	git blame -C -C three.bin >blame &&
+	find_blame <blame >result &&
+	cat >expected <<\EOF &&
+(Number1 2010-01-01 18:00:00 +0000 1) converted: test number 2
+(Number2 2010-01-01 20:00:00 +0000 2) converted: test number 2 version=
 2
+(Number3 2010-01-01 22:00:00 +0000 3) converted: test number 2 version=
 3
+(Number4 2010-01-01 23:00:00 +0000 4) converted: test number 3
+EOF
+	test_cmp expected result
+'
+
 test_done
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.s=
h
index 71f4145..98a3e1f 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -12,6 +12,9 @@ chmod +x helper
=20
 test_expect_success 'setup ' '
 	echo "bin: test" >one.bin &&
+	if test_have_prereq SYMLINKS; then
+		ln -s one.bin symlink.bin
+	fi &&
 	git add . &&
 	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
 	echo "bin: test version 2" >one.bin &&
@@ -68,4 +71,30 @@ test_expect_success 'cat-file --textconv on previous=
 commit' '
 	git cat-file --textconv HEAD^:one.bin >result &&
 	test_cmp expected result
 '
+
+test_expect_success SYMLINKS 'cat-file without --textconv (symlink)' '
+	git cat-file blob :symlink.bin >result &&
+	printf "%s" "one.bin" >expected
+	test_cmp expected result
+'
+
+
+# fails because cat-file tries to run converter on symlink.bin
+test_expect_failure SYMLINKS 'cat-file --textconv on index (symlink)' =
'
+	! git cat-file --textconv :symlink.bin 2>result &&
+	cat >expected <<\EOF &&
+fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
+EOF
+	test_cmp expected result
+'
+
+# fails because cat-file tries to run converter on symlink.bin
+test_expect_failure SYMLINKS 'cat-file --textconv on HEAD (symlink)' '
+	! git cat-file --textconv HEAD:symlink.bin 2>result &&
+	cat >expected <<EOF &&
+fatal: git cat-file --textconv: unable to run textconv on HEAD:symlink=
=2Ebin
+EOF
+	test_cmp expected result
+'
+
 test_done
--=20
1.7.3.19.g3fe0a

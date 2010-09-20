From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH v2 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Tue, 21 Sep 2010 00:39:45 +0400
Message-ID: <3c344d9b8f014ccb96dc37dc42668426fb5a3c30.1285013802.git.kirr@landau.phys.spbu.ru>
References: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 22:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxn8I-0002Dn-5i
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574Ab0ITUiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 16:38:13 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:39293 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558Ab0ITUiL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 16:38:11 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id D3D8FFF728; Tue, 21 Sep 2010 00:38:09 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1Oxn9Y-0006MO-98; Tue, 21 Sep 2010 00:39:56 +0400
X-Mailer: git-send-email 1.7.3.rc2
In-Reply-To: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
References: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156663>

(Description partly by Matthieu Moy)

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

~~~~

NOTE: git diff doesn't try to textconv the pathnames, it runs the
textual diff without textconv, which is the expected behavior.

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---

v2:

 (As suggested by Matthieu)
 o Changed patch descriptio=20
 o Moved most of >expected preparation into test_expect_*
 o Changed multiple echo'es into cat <<EOF
 o Use printf "%s" instead echo -n, since latter is said to be not very
   portable


 t/t8006-blame-textconv.sh    |   45 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t8007-cat-file-textconv.sh |   27 +++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index d0f8d62..7d42e96 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -17,10 +17,12 @@ chmod +x helper
 test_expect_success 'setup ' '
 	echo "bin: test 1" >one.bin &&
 	echo "bin: test number 2" >two.bin &&
+	ln -s one.bin symlink.bin &&
 	git add . &&
 	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
 	echo "bin: test 1 version 2" >one.bin &&
 	echo "bin: test number 2 version 2" >>two.bin &&
+	ln -sf two.bin symlink.bin &&
 	GIT_AUTHOR_NAME=3DNumber2 git commit -a -m Second --date=3D"2010-01-0=
1 20:00:00"
 '
=20
@@ -78,4 +80,47 @@ test_expect_success 'blame from previous revision' '
 	test_cmp expected result
 '
=20
+cat >expected <<EOF
+(Number2 2010-01-01 20:00:00 +0000 1) two.bin
+EOF
+
+test_expect_success 'blame with --no-textconv (on symlink)' '
+	git blame --no-textconv symlink.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
+# fails with '...symlink.bin is not "binary" file'
+test_expect_failure 'blame --textconv (on symlink)' '
+	git blame --textconv symlink.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
+# cp two.bin three.bin  and make small tweak
+# (this will direct blame -C -C three.bin to consider two.bin and syml=
ink.bin)
+test_expect_success 'make another new commit' '
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
+test_expect_failure 'blame on last commit (-C -C, symlink)' '
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
index 413d623..f747c05 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -12,6 +12,7 @@ chmod +x helper
=20
 test_expect_success 'setup ' '
 	echo "bin: test" >one.bin &&
+	ln -s one.bin symlink.bin &&
 	git add . &&
 	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
 	echo "bin: test version 2" >one.bin &&
@@ -68,4 +69,30 @@ test_expect_success 'cat-file --textconv on previous=
 commit' '
 	git cat-file --textconv HEAD^:one.bin >result &&
 	test_cmp expected result
 '
+
+test_expect_success 'cat-file without --textconv (symlink)' '
+	git cat-file blob :symlink.bin >result &&
+	printf "%s" "one.bin" >expected
+	test_cmp expected result
+'
+
+
+# fails because cat-file tries to run converter on symlink.bin
+test_expect_failure 'cat-file --textconv on index (symlink)' '
+	! git cat-file --textconv :symlink.bin 2>result &&
+	cat >expected <<\EOF &&
+fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
+EOF
+	test_cmp expected result
+'
+
+# fails because cat-file tries to run converter on symlink.bin
+test_expect_failure 'cat-file --textconv on HEAD (symlink)' '
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
1.7.3.rc2

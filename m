From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Sat, 18 Sep 2010 21:25:05 +0400
Message-ID: <000c991c7a0673e26ee3ecc19ea3c8a7b437fecf.1284830388.git.kirr@landau.phys.spbu.ru>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 19:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox18e-0005BL-IJ
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 19:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab0IRRXp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 13:23:45 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:33049 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab0IRRXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 13:23:41 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 5F37EFF714; Sat, 18 Sep 2010 21:23:40 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1Ox1AD-0001co-OS; Sat, 18 Sep 2010 21:25:25 +0400
X-Mailer: git-send-email 1.7.3.rc2
In-Reply-To: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156466>

Because as described in previous patch - it should not.

Several failures are demonstrated here:

  - git cat-file --textconv :symlink.bin    # also HEAD:symlink.bin
  - git blame --textconv symlink.bin
  - git blame -C -C --textconv regular-file # but also looks on symlink=
=2Ebin

At present they all fail with something like.

    E: /tmp/j3ELEs_symlink.bin is not "binary" file

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 t/t8006-blame-textconv.sh    |   44 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t8007-cat-file-textconv.sh |   29 +++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index d0f8d62..3ed6155 100755
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
@@ -78,4 +80,46 @@ test_expect_success 'blame from previous revision' '
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
+	echo "bin: test number 2" >three.bin &&
+	echo "bin: test number 2 version 2" >>three.bin &&
+	echo "bin: test number 2 version 3" >>three.bin &&
+	echo "bin: test number 3" >>three.bin &&
+	git add three.bin &&
+	GIT_AUTHOR_NAME=3DNumber4 git commit -a -m Fourth --date=3D"2010-01-0=
1 23:00:00"
+'
+
+cat >expected <<EOF
+(Number1 2010-01-01 18:00:00 +0000 1) converted: test number 2
+(Number2 2010-01-01 20:00:00 +0000 2) converted: test number 2 version=
 2
+(Number3 2010-01-01 22:00:00 +0000 3) converted: test number 2 version=
 3
+(Number4 2010-01-01 23:00:00 +0000 4) converted: test number 3
+EOF
+
+# fails with '...symlink.bin is not "binary" file'
+test_expect_failure 'blame on last commit (-C -C, symlink)' '
+	git blame -C -C three.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
 test_done
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.s=
h
index 413d623..dfb2b04 100755
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
@@ -68,4 +69,32 @@ test_expect_success 'cat-file --textconv on previous=
 commit' '
 	git cat-file --textconv HEAD^:one.bin >result &&
 	test_cmp expected result
 '
+
+echo -n "one.bin" >expected
+
+test_expect_success 'cat-file without --textconv (symlink)' '
+	git cat-file blob :symlink.bin >result &&
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
+EOF
+
+# fails because cat-file tries to run converter on symlink.bin
+test_expect_failure 'cat-file --textconv on index (symlink)' '
+	! git cat-file --textconv :symlink.bin 2>result &&
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+fatal: git cat-file --textconv: unable to run textconv on HEAD:symlink=
=2Ebin
+EOF
+
+# fails because cat-file tries to run converter on symlink.bin
+test_expect_failure 'cat-file --textconv on HEAD (symlink)' '
+	! git cat-file --textconv HEAD:symlink.bin 2>result &&
+	test_cmp expected result
+'
+
 test_done
--=20
1.7.3.rc2

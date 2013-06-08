From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t0070: Use precondition CANNOTWRITE
Date: Sat, 8 Jun 2013 08:51:15 +0200
Message-ID: <201306080851.17044.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 08:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlCzo-0007Kk-Vi
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 08:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab3FHGvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 02:51:25 -0400
Received: from mout.web.de ([212.227.17.12]:56143 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab3FHGvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 02:51:24 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MKZy7-1Um24j1pPr-0016dC for <git@vger.kernel.org>; Sat,
 08 Jun 2013 08:51:22 +0200
X-Provags-ID: V02:K0:8MZKRDcnAmcE/WgEHVzchrj5uDFos+3zrDbquMV1M/b
 RPqNLJtHwbJ0myLE2Zx00GHZOA5Yg4p8q4fRpZaloparob2RYz
 jdphvB0M/0n9NjedlLdrks+KOtg3VgPdXCr2d2oMW/YmbQOsYU
 OXqm200OrYVP70350K+iIJfCGVFBGsL9f6mXEVjH5Zi2lQC4lt
 MXNQN7MWMWcrCHp/IjIpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226785>

POSIX like file systems allows to create a file when the user has
write permissions to the directory.

=46ilesystems like VFAT or NTFS allow to create files regardless of
the write permissions of the directory.

Therefore "mktemp to unwritable directory" in t0700 will always fail on
Windows using NTFS.
This TC has been disabled for MINGW, and needs to be disabled for CYGWI=
N.

Use the precondition CANNOTWRITE which is probing the file system and
works for MINGW, CYGWIN and even for Linux using VFAT.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0070-fundamental.sh | 19 ++++++++++++-------
 t/test-lib.sh          | 12 ++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index da2c504..a907445 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -17,13 +17,18 @@ test_expect_success 'mktemp to nonexistent director=
y prints filename' '
 	grep "doesnotexist/test" err
 '
=20
-test_expect_success POSIXPERM 'mktemp to unwritable directory prints f=
ilename' '
-	mkdir cannotwrite &&
-	chmod -w cannotwrite &&
-	test_when_finished "chmod +w cannotwrite" &&
-	test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
-	grep "cannotwrite/test" err
-'
+if test_have_prereq CANNOTWRITE
+then
+	test_expect_success 'mktemp to unwritable directory prints filename' =
'
+		mkdir cannotwrite &&
+		chmod -w cannotwrite &&
+		test_when_finished "chmod +w cannotwrite" &&
+		test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
+		grep "cannotwrite/test" err
+	'
+else
+	say "Skipping mktemp to unwritable directory prints filename"
+fi
=20
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=3D1
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ca6bdef..1342630 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -770,6 +770,18 @@ test_lazy_prereq AUTOIDENT '
 	git var GIT_AUTHOR_IDENT
 '
=20
+test_lazy_prereq CANNOTWRITE '
+	chmod -w .
+	>e || :
+	chmod +w .
+	case "$(echo *)" in
+	e)
+		false ;;
+	*)
+		true ;;
+	esac
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
--=20
1.8.2.411.g65a544e

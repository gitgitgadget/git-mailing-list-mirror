From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Tue, 1 Jan 2013 22:40:08 +0100
Message-ID: <201301012240.10722.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 22:41:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9a2-0000CF-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab3AAVkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 16:40:43 -0500
Received: from mout.web.de ([212.227.17.11]:63433 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab3AAVkl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 16:40:41 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0LwqHA-1SxFbr3sXw-016eEu; Tue, 01 Jan 2013 22:40:40 +0100
X-Provags-ID: V02:K0:STrt8P+RlHaNyNPJa4h6LUZCqAZAw7Zgz5eFCKgdWBq
 zCkM3RIEA9RZPsAmxxKFmp50Kq64BUzpxT84l+3SnPBoh1RJNT
 0RwKDVTG48EgokClBcN9Rwlm/QXXjTOPzFBVi21lCPFFv8z5fc
 /kBNSblWHur+G6ZoMi4D6dFrK338fd+UmhNDP+PkKeBVTxF2r7
 w+u4VBHc7YmbfzwDzL0kQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212446>

Add the perl script "check-non-portable-shell.pl" to detect non-portabl=
e
shell syntax
Many systems use gnu tools which accept an extended syntax in shell scr=
ipts,
which is not portable on all systems and causes the test suite to fail.

To prevent contributors using e.g. Linux to add non-portable test code,
"check-non-portable-shell.pl" is run as part of
"make test" or "make in the t/ directory.

"echo -n" is an example of a statement working on Linux,
but not on e.g. Mac OS X.

Beside "echo -n" we check for
"sed -i",
arrays in shell scripts (declare statement),
"which" (use type instead),
or "=3D=3D" (bash style of =3D)

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/Makefile                    |  7 +++--
 t/check-non-portable-shell.pl | 67 +++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100755 t/check-non-portable-shell.pl

diff --git a/t/Makefile b/t/Makefile
index 88e289f..7b0c4dc 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -23,7 +23,7 @@ TGITWEB =3D $(sort $(wildcard t95[0-9][0-9]-*.sh))
=20
 all: $(DEFAULT_TEST_TARGET)
=20
-test: pre-clean $(TEST_LINT)
+test: pre-clean test-lint-shell-syntax $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
=20
 prove: pre-clean $(TEST_LINT)
@@ -43,7 +43,7 @@ clean-except-prove-cache:
 clean: clean-except-prove-cache
 	$(RM) .prove
=20
-test-lint: test-lint-duplicates test-lint-executable
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-s=
yntax
=20
 test-lint-duplicates:
 	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` &&=
 \
@@ -55,6 +55,9 @@ test-lint-executable:
 		test -z "$$bad" || { \
 		echo >&2 "non-executable tests:" $$bad; exit 1; }
=20
+test-lint-shell-syntax:
+	$(PERL_PATH) check-non-portable-shell.pl $(T)
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
new file mode 100755
index 0000000..de62ef0
--- /dev/null
+++ b/t/check-non-portable-shell.pl
@@ -0,0 +1,67 @@
+#!/usr/bin/perl -w
+######################################################################
+# Test t0000..t9999.sh for non portable shell scripts                #
+# Examples are "echo -n" or "sed -i"                                 #
+# This script can be called with one or more filenames as parameters #
+#
+######################################################################
+use strict;
+my $exitcode=3D0;
+
+sub check_one_file($) {
+	my $lineno=3D1;
+	my $filename=3Dshift;
+
+	open(FINPUT, "<$filename") || die "Couldn't open filename $filename";
+	my @fdata =3D <FINPUT>;
+	close(FINPUT);
+
+	while (my $line =3D shift @fdata) {
+    do {
+      chomp $line;
+      # sed -i
+      if ($line =3D~ /^\s*sed\s+-i/) {
+        printf("%s:%d:error: \"sed -i not portable\" %s\n", $filename,=
 $lineno, $line);
+				$exitcode=3D1;
+      }
+      # echo -n
+      if ($line =3D~ /^\s*echo\s+-n/) {
+        printf("%s:%d:error: \"echo -n not portable\" %s\n", $filename=
, $lineno, $line);
+				$exitcode=3D1;
+      }
+      # arrays (declare statement)
+      if ($line =3D~ /^\s*declare\s+/) {
+        printf("%s:%d:error: \"arrays/declare not portable\" %s\n", $f=
ilename, $lineno, $line);
+				$exitcode=3D1;
+      }
+      # which
+      if ($line =3D~ /^\s*[^#]\s*which\s/) {
+        printf("%s:%d:error: \"which is not portable (use type)\" %s\n=
", $filename, $lineno, $line);
+				$exitcode=3D1;
+      }
+
+      # =3D=3D (bash style comparison)
+      if ($line =3D~ /test\s+[^=3D]*=3D=3D/) {
+        printf("%s:%d:error: \"=3D=3D is not portable (use =3D)\" %s\n=
", $filename, $lineno, $line);
+				$exitcode=3D1;
+      }
+
+			$lineno=3D$lineno+1;
+		}
+  }
+}
+
+
+if ($#ARGV <=3D 0) {
+	print STDERR  "$0: Check shell scripts for non portable syntax\n";
+	print STDERR  "Example: $0 t[0-9]*.sh\n";
+
+	exit(2);
+}
+
+while (@ARGV) {
+	my $arg =3D shift @ARGV;
+  check_one_file($arg);
+}
+
+exit($exitcode);
--=20
1.8.0.197.g5a90748

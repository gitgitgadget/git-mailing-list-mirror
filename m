From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC]  test-lib.sh: preprocess to use PERL_PATH
Date: Sat, 23 Jun 2012 07:04:37 +0200
Message-ID: <201206230704.38648.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 07:05:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiIXP-0008Hz-Fw
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 07:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab2FWFEp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jun 2012 01:04:45 -0400
Received: from mout.web.de ([212.227.15.3]:50468 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337Ab2FWFEo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jun 2012 01:04:44 -0400
Received: from appes.localnet ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0M57Ra-1Rxccn23SQ-00zPe3; Sat, 23 Jun 2012 07:04:43 +0200
X-Provags-ID: V02:K0:SYlaTq4bd6UqNC9QbxcibEQwLJJLGwPqgVv9h+hp/uM
 EnMcOND2AQo1zyaFoUGGupOhlfWo/9dlkgSJiuqSgsBqeIz5ZQ
 eaSLueozokP1TTCctP5DpS8XvbJcLZy4ZcYzCA49NP7Zq5pWmr
 +lQsp/qBOgfC0o3nxrpHtNmRCZwfgz2n/u823vUPp7Ywioe8LI
 af7kbN7hEYcfGc5lvpfgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200490>

All test cases found in t/*.sh must include test-lib instead of test-li=
b.sh

Replace the inclusion of GIT-BUILD-OPTIONS with definitions that are fi=
lled in
during preprocessing.

The new test-lib doesn't need to to open GIT-BUILD-OPTIONS for each
test script, which speeds up the execution a bit.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Note: The diff of all files in t/* is not here in this patch - the mail=
 seems not to got through when I add
all the diffs here.

So this patch is incomplete and should show the idea.

I ran the following script to do the changes:
sedmulti.sh t/*
(where sedmulti.sh is below:)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#!/bin/sh

if [ $# -lt 3 ]; then
  echo "usage sedmulti <fromtext> <totext> filename ..." >&2
        exit 1;
fi

fromtext=3D$1;
shift;
totext=3D$1;
shift;

for f in "$@"; do
  echo sed -ire "s%$fromtext%$totext%g" $f
  sed -ire "s%$fromtext%$totext%g" $f
done
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


 .gitignore    |    1 +
 Makefile      |    4 ++++
 t/README      |    8 ++++----
 t/test-lib.sh |   11 ++++++++---
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index bf66648..62c60ce 100644
--- a/.gitignore
+++ b/.gitignore
@@ -192,6 +192,7 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
+t/test-lib
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 0914133..d540ab6 100644
--- a/Makefile
+++ b/Makefile
@@ -442,6 +442,7 @@ SCRIPT_LIB +=3D git-rebase--interactive
 SCRIPT_LIB +=3D git-rebase--merge
 SCRIPT_LIB +=3D git-sh-setup
 SCRIPT_LIB +=3D git-sh-i18n
+SCRIPT_LIB +=3D t/test-lib
=20
 SCRIPT_PERL +=3D git-add--interactive.perl
 SCRIPT_PERL +=3D git-difftool.perl
@@ -2018,6 +2019,9 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
+    -e 's|@@PERL_PATH@@|$(PERL_PATH)|g' \
+    -e 's|@@PYTHON_PATH@@|$(PYTHON_PATH)|g' \
+    -e 's|@@TAR@@|$(TAR)|g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
 endef
diff --git a/t/README b/t/README
index 4c3ea25..fa23726 100644
--- a/t/README
+++ b/t/README
@@ -203,7 +203,7 @@ the top-level test script, never name the file to m=
atch the above
 pattern.  The Makefile here considers all such files as the
 top-level test script and tries to run all of them.  Care is
 especially needed if you are creating a common test library
-file, similar to test-lib.sh, because such a library file may
+file, similar to test-lib, because such a library file may
 not be suitable for standalone execution.
=20
=20
@@ -225,13 +225,13 @@ assignment to variable 'test_description', like t=
his:
 	and tries to run git-ls-files with option --frotz.'
=20
=20
-Source 'test-lib.sh'
+Source 'test-lib'
 --------------------
=20
 After assigning test_description, the test script should source
-test-lib.sh like this:
+test-lib like this:
=20
-	. ./test-lib.sh
+	. ./test-lib
=20
 This test harness library does the following things:
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9e2b711..306fcd9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -46,7 +46,7 @@ EDITOR=3D:
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE COLUMNS $(perl -e '
+unset VISUAL EMAIL LANGUAGE COLUMNS $(@@PERL_PATH@@ -e '
 	my @env =3D keys %ENV;
 	my $ok =3D join("|", qw(
 		TRACE
@@ -107,7 +107,7 @@ export _x05 _x40 _z40 LF
 # test_description=3D'Description of this test...
 # This test checks if command xyzzy does the right thing...
 # '
-# . ./test-lib.sh
+# . ./test-lib
 [ "x$ORIGINAL_TERM" !=3D "xdumb" ] && (
 		TERM=3D$ORIGINAL_TERM &&
 		export TERM &&
@@ -492,7 +492,12 @@ GIT_CONFIG_NOSYSTEM=3D1
 GIT_ATTR_NOSYSTEM=3D1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATT=
R_NOSYSTEM
=20
-. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+SHELL_PATH=3D'@SHELL_PATH@'
+PERL_PATH=3D'@@PERL_PATH@@'
+DIFF=3D'@@DIFF@@'
+PYTHON_PATH=3D'@@PYTHON_PATH@@'
+TAR=3D'@@TAR@@'
+export PERL_PATH=20
=20
 if test -z "$GIT_TEST_CMP"
 then
--=20
1.7.9.1.3.gd6f4c.dirty

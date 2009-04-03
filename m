From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] tests: skip perl tests if NO_PERL is defined
Date: Fri, 3 Apr 2009 15:33:59 -0400
Message-ID: <20090403193359.GD5547@coredump.intra.peff.net>
References: <20090403192700.GA14965@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 21:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LppB6-0004rI-Fi
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 21:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759284AbZDCTeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 15:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757889AbZDCTeQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 15:34:16 -0400
Received: from peff.net ([208.65.91.99]:59657 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757247AbZDCTeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 15:34:16 -0400
Received: (qmail 1138 invoked by uid 107); 3 Apr 2009 19:34:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 15:34:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 15:33:59 -0400
Content-Disposition: inline
In-Reply-To: <20090403192700.GA14965@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115558>

These scripts all test git programs that are written in
perl, and thus obviously won't work if NO_PERL is defined.
We pass NO_PERL to the scripts from the building Makefile
via the GIT-BUILD-OPTIONS file.

Signed-off-by: Jeff King <peff@peff.net>
---
This touches every test that Robin's patch touched except for
t5505-remote. There is no need to skip those tests, as these days
"git remote" is a builtin.

 Makefile                               |    1 +
 t/lib-git-svn.sh                       |    4 ++++
 t/t3701-add-interactive.sh             |    5 +++++
 t/t7501-commit.sh                      |    4 ++--
 t/t9001-send-email.sh                  |    5 +++++
 t/t9200-git-cvsexportcommit.sh         |    5 +++++
 t/t9400-git-cvsserver-server.sh        |    4 ++++
 t/t9500-gitweb-standalone-no-errors.sh |    5 +++++
 t/t9600-cvsimport.sh                   |    5 +++++
 t/t9700-perl-git.sh                    |    5 +++++
 t/test-lib.sh                          |    2 ++
 11 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d7b0837..584a757 100644
--- a/Makefile
+++ b/Makefile
@@ -1417,6 +1417,7 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
+	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index cdd7ccd..773d47c 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -8,6 +8,10 @@ then
 	say 'skipping git svn tests, NO_SVN_TESTS defined'
 	test_done
 fi
+if ! test_have_prereq PERL; then
+	say 'skipping git svn tests, perl not available'
+	test_done
+fi
 
 GIT_DIR=$PWD/.git
 GIT_SVN_DIR=$GIT_DIR/svn/git-svn
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fe01783..dfc6560 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -3,6 +3,11 @@
 test_description='add -i basic tests'
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping git add -i tests, perl not available'
+	test_done
+fi
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b4e2b4d..e2ef532 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -38,7 +38,7 @@ test_expect_success \
 	"echo King of the bongo >file &&
 	test_must_fail git commit -m foo -a file"
 
-test_expect_success \
+test_expect_success PERL \
 	"using paths with --interactive" \
 	"echo bong-o-bong >file &&
 	! (echo 7 | git commit -m foo --interactive file)"
@@ -119,7 +119,7 @@ test_expect_success \
 	"echo 'gak' >file && \
 	 git commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
 
-test_expect_success \
+test_expect_success PERL \
 	"interactive add" \
 	"echo 7 | git commit --interactive | grep 'What now'"
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 192b97b..4281ce2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -3,6 +3,11 @@
 test_description='git send-email'
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping git send-email tests, perl not available'
+	test_done
+fi
+
 PROG='git send-email'
 test_expect_success \
     'prepare reference tree' \
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 3665692..56b7c06 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -6,6 +6,11 @@ test_description='Test export of commits to CVS'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping git cvsexportcommit tests, perl not available'
+	test_done
+fi
+
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 39185db..64f947d 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -10,6 +10,10 @@ cvs CLI client via git-cvsserver server'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping git cvsserver tests, perl not available'
+	test_done
+fi
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 0bd332c..f4210fb 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -65,6 +65,11 @@ gitweb_run () {
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping gitweb tests, perl not available'
+	test_done
+fi
+
 perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
     say 'skipping gitweb tests, perl version is too old'
     test_done
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 33eb519..4322a0c 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,6 +3,11 @@
 test_description='git cvsimport basic tests'
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping git cvsimport tests, perl not available'
+	test_done
+fi
+
 CVSROOT=$(pwd)/cvsroot
 export CVSROOT
 unset CVS_SERVER
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 4a501c6..b4ca244 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -6,6 +6,11 @@
 test_description='perl interface (Git.pm)'
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping perl interface tests, perl not available'
+	test_done
+fi
+
 perl -MTest::More -e 0 2>/dev/null || {
 	say "Perl Test::More unavailable, skipping test"
 	test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b050196..4bd986f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -698,6 +698,8 @@ case $(uname -s) in
 	;;
 esac
 
+test -z "$NO_PERL" && test_set_prereq PERL
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
 rm -f y
-- 
1.6.2.2.569.g2d4b2

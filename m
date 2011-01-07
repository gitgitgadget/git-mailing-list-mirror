From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] git-cvs*: Make building (and testing) of CVS interface scripts optionally selectable
Date: Fri,  7 Jan 2011 20:48:10 +0000
Message-ID: <1294433290-9262-1-git-send-email-robbat2@gentoo.org>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 21:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJES-000260-FZ
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab1AGUsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 15:48:15 -0500
Received: from mail.isohunt.com ([208.95.172.20]:60988 "EHLO mail.as30085.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab1AGUsO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 15:48:14 -0500
Received: (qmail 18683 invoked from network); 7 Jan 2011 20:48:12 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.as30085.net (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPS; Fri, 07 Jan 2011 20:48:12 +0000
Received: (qmail 9298 invoked by uid 0); 7 Jan 2011 20:48:10 -0000
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164761>

Presently, the CVS interface scripts are always built, and their
test-suites run based on a binary named 'cvs' happening to return zero.
If there something other than the real CVS there, bad things happened
during the test-suite run.

This patch implements NO_CVS in the manner of NO_PERL, and ensures that
the CVS scripts get the unimplemented variant when appropriate, as well
as making sure that the tests properly declare CVS as a prerequisite
(shortcut to test_done like the Perl prerequisites).

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
X-Gentoo-Bug: 350330
X-Gentoo-Bug-URL: https://bugs.gentoo.org/show_bug.cgi?id=350330
---
 Makefile                           |   37 ++++++++++++++++++++++++--------
 t/t9200-git-cvsexportcommit.sh     |    5 ++++
 t/t9400-git-cvsserver-server.sh    |    8 ++++++-
 t/t9401-git-cvsserver-crlf.sh      |   15 ++++++++----
 t/t9600-cvsimport.sh               |   41 ++++++++++++++++++++++-------------
 t/t9601-cvsimport-vendor-branch.sh |   11 +++++++++
 t/t9602-cvsimport-branches-tags.sh |   11 +++++++++
 t/t9603-cvsimport-patchsets.sh     |   11 +++++++++
 t/test-lib.sh                      |    1 +
 9 files changed, 110 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
index 775ee83..158489a 100644
--- a/Makefile
+++ b/Makefile
@@ -188,6 +188,8 @@ all::
 #
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
+# Define NO_CVS if you do not want any CVS interface utilities.
+#
 # The TCL_PATH variable governs the location of the Tcl interpreter
 # used to optimize git-gui for your system.  Only used if NO_TCLTK
 # is not set.  Defaults to the bare 'tclsh'.
@@ -347,6 +349,7 @@ LIB_OBJS =
 PROGRAM_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
+SCRIPT_PERL_CVS =
 SCRIPT_PYTHON =
 SCRIPT_SH =
 SCRIPT_LIB =
@@ -384,17 +387,18 @@ SCRIPT_LIB += git-sh-setup
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
-SCRIPT_PERL += git-cvsexportcommit.perl
-SCRIPT_PERL += git-cvsimport.perl
-SCRIPT_PERL += git-cvsserver.perl
 SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
+SCRIPT_PERL_CVS += git-cvsexportcommit.perl
+SCRIPT_PERL_CVS += git-cvsimport.perl
+SCRIPT_PERL_CVS += git-cvsserver.perl
+
 SCRIPT_PYTHON += git-remote-testgit.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
-	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	  $(patsubst %.perl,%,$(SCRIPT_PERL) $(SCRIPT_PERL_CVS)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
@@ -1721,13 +1725,25 @@ $(SCRIPT_LIB) : % : %.sh
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
+_SCRIPT_PERL_BUILD = 
+_SCRIPT_PERL_NOBUILD = 
+
 ifndef NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
+
+_SCRIPT_PERL_BUILD += $(SCRIPT_PERL)
+
+ifndef NO_CVS
+_SCRIPT_PERL_BUILD += $(SCRIPT_PERL_CVS)
+else # NO_CVS
+_SCRIPT_PERL_NOBUILD += $(SCRIPT_PERL_CVS)
+endif # NO_CVS
+
+$(patsubst %.perl,%,$(_SCRIPT_PERL_BUILD)): perl/perl.mak
 
 perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
+$(patsubst %.perl,%,$(_SCRIPT_PERL_BUILD)): % : %.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
@@ -1784,14 +1800,17 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
+_SCRIPT_PERL_NOBUILD += $(SCRIPT_PERL) $(SCRIPT_PERL_CVS) git-instaweb
+endif # NO_PERL
+
+# This is any perl scripts that were disabled it might be empty...
+$(patsubst %.perl,%,$(_SCRIPT_PERL_NOBUILD)): % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
-endif # NO_PERL
 
 ifndef NO_PYTHON
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
@@ -1826,7 +1845,7 @@ configure: configure.ac
 # These can record GIT_VERSION
 git.o git.spec \
 	$(patsubst %.sh,%,$(SCRIPT_SH)) \
-	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	$(patsubst %.perl,%,$(SCRIPT_PERL) $(SCRIPT_PERL_CVS)) \
 	: GIT-VERSION-FILE
 
 TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index e5da65b..4b3f010 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -12,6 +12,11 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
+if ! test_have_prereq CVS; then
+	skip_all='skipping git cvsexportcommit tests, cvs not available'
+	test_done
+fi
+
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9199550..52ea99d 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -11,9 +11,15 @@ cvs CLI client via git-cvsserver server'
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
-	skip_all='skipping git cvsserver tests, perl not available'
+	skip_all='skipping git-cvsserver tests, perl not available'
 	test_done
 fi
+
+if ! test_have_prereq CVS; then
+	skip_all='skipping git-cvsserver tests, cvs not available'
+	test_done
+fi
+
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index ff6d6fb..f0d7aad 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -38,15 +38,20 @@ not_present() {
     fi
 }
 
-cvs >/dev/null 2>&1
-if test $? -ne 1
+if ! test_have_prereq PERL
 then
-    skip_all='skipping git-cvsserver tests, cvs not found'
+    skip_all='skipping git-cvsserver tests, perl not available'
     test_done
 fi
-if ! test_have_prereq PERL
+if ! test_have_prereq CVS
 then
-    skip_all='skipping git-cvsserver tests, perl not available'
+    skip_all='skipping git-cvsserver tests, cvs not available'
+    test_done
+fi
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    skip_all='skipping git-cvsserver tests, cvs not found'
     test_done
 fi
 "$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 4c384ff..d601f32 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,14 +3,25 @@
 test_description='git cvsimport basic tests'
 . ./lib-cvs.sh
 
-test_expect_success PERL 'setup cvsroot environment' '
+if ! test_have_prereq PERL
+then
+    skip_all='skipping git cvsimport tests, perl not available'
+    test_done
+fi
+if ! test_have_prereq CVS
+then
+    skip_all='skipping git cvsimport tests, cvs not available'
+    test_done
+fi
+
+test_expect_success 'setup cvsroot environment' '
 	CVSROOT=$(pwd)/cvsroot &&
 	export CVSROOT
 '
 
-test_expect_success PERL 'setup cvsroot' '$CVS init'
+test_expect_success 'setup cvsroot' '$CVS init'
 
-test_expect_success PERL 'setup a cvs module' '
+test_expect_success 'setup a cvs module' '
 
 	mkdir "$CVSROOT/module" &&
 	$CVS co -d module-cvs module &&
@@ -42,23 +53,23 @@ EOF
 	)
 '
 
-test_expect_success PERL 'import a trivial module' '
+test_expect_success 'import a trivial module' '
 
 	git cvsimport -a -R -z 0 -C module-git module &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
 '
 
-test_expect_success PERL 'pack refs' '(cd module-git && git gc)'
+test_expect_success 'pack refs' '(cd module-git && git gc)'
 
-test_expect_success PERL 'initial import has correct .git/cvs-revisions' '
+test_expect_success 'initial import has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1) > expected &&
 	test_cmp expected module-git/.git/cvs-revisions
 '
 
-test_expect_success PERL 'update cvs module' '
+test_expect_success 'update cvs module' '
 	(cd module-cvs &&
 	cat <<EOF >o_fortuna &&
 O Fortune,
@@ -86,7 +97,7 @@ EOF
 	)
 '
 
-test_expect_success PERL 'update git module' '
+test_expect_success 'update git module' '
 
 	(cd module-git &&
 	git config cvsimport.trackRevisions true &&
@@ -97,7 +108,7 @@ test_expect_success PERL 'update git module' '
 
 '
 
-test_expect_success PERL 'update has correct .git/cvs-revisions' '
+test_expect_success 'update has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1 HEAD^ &&
@@ -105,7 +116,7 @@ test_expect_success PERL 'update has correct .git/cvs-revisions' '
 	test_cmp expected module-git/.git/cvs-revisions
 '
 
-test_expect_success PERL 'update cvs module' '
+test_expect_success 'update cvs module' '
 
 	(cd module-cvs &&
 		echo 1 >tick &&
@@ -114,7 +125,7 @@ test_expect_success PERL 'update cvs module' '
 	)
 '
 
-test_expect_success PERL 'cvsimport.module config works' '
+test_expect_success 'cvsimport.module config works' '
 
 	(cd module-git &&
 		git config cvsimport.module module &&
@@ -126,7 +137,7 @@ test_expect_success PERL 'cvsimport.module config works' '
 
 '
 
-test_expect_success PERL 'second update has correct .git/cvs-revisions' '
+test_expect_success 'second update has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1 HEAD^^ &&
@@ -135,7 +146,7 @@ test_expect_success PERL 'second update has correct .git/cvs-revisions' '
 	test_cmp expected module-git/.git/cvs-revisions
 '
 
-test_expect_success PERL 'import from a CVS working tree' '
+test_expect_success 'import from a CVS working tree' '
 
 	$CVS co -d import-from-wt module &&
 	(cd import-from-wt &&
@@ -148,12 +159,12 @@ test_expect_success PERL 'import from a CVS working tree' '
 
 '
 
-test_expect_success PERL 'no .git/cvs-revisions created by default' '
+test_expect_success 'no .git/cvs-revisions created by default' '
 
 	! test -e import-from-wt/.git/cvs-revisions
 
 '
 
-test_expect_success PERL 'test entire HEAD' 'test_cmp_branch_tree master'
+test_expect_success 'test entire HEAD' 'test_cmp_branch_tree master'
 
 test_done
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index 827d39f..d730a41 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -34,6 +34,17 @@
 test_description='git cvsimport handling of vendor branches'
 . ./lib-cvs.sh
 
+if ! test_have_prereq PERL
+then
+    skip_all='skipping git cvsimport tests, perl not available'
+    test_done
+fi
+if ! test_have_prereq CVS
+then
+    skip_all='skipping git cvsimport tests, cvs not available'
+    test_done
+fi
+
 setup_cvs_test_repository t9601
 
 test_expect_success PERL 'import a module with a vendor branch' '
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
index e1db323..68f0974 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -6,6 +6,17 @@
 test_description='git cvsimport handling of branches and tags'
 . ./lib-cvs.sh
 
+if ! test_have_prereq PERL
+then
+    skip_all='skipping git cvsimport tests, perl not available'
+    test_done
+fi
+if ! test_have_prereq CVS
+then
+    skip_all='skipping git cvsimport tests, cvs not available'
+    test_done
+fi
+
 setup_cvs_test_repository t9602
 
 test_expect_success PERL 'import module' '
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 52034c8..db4d682 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -14,6 +14,17 @@
 test_description='git cvsimport testing for correct patchset estimation'
 . ./lib-cvs.sh
 
+if ! test_have_prereq PERL
+then
+    skip_all='skipping git cvsimport tests, perl not available'
+    test_done
+fi
+if ! test_have_prereq CVS
+then
+    skip_all='skipping git cvsimport tests, cvs not available'
+    test_done
+fi
+
 setup_cvs_test_repository t9603
 
 test_expect_failure 'import with criss cross times on revisions' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index cb1ca97..d594c95 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1066,6 +1066,7 @@ case $(uname -s) in
 	;;
 esac
 
+test -z "$NO_CVS" && test_set_prereq CVS
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
-- 
1.7.3.4

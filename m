From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 08/10] run test suite without dashed git-commands in PATH
Date: Sat, 24 Jan 2009 16:43:19 -0700
Message-ID: <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>,
	<Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsJw-0008RY-Ks
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZAXXwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbZAXXwX
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:52:23 -0500
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:38663 "EHLO
	QMTA04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752996AbZAXXwW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:52:22 -0500
Received: from OMTA07.emeryville.ca.mail.comcast.net ([76.96.30.59])
	by QMTA04.emeryville.ca.mail.comcast.net with comcast
	id 7Tw71b00C1GXsucA4bsNW0; Sat, 24 Jan 2009 23:52:22 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA07.emeryville.ca.mail.comcast.net with comcast
	id 7bsL1b00M1TYyYj8TbsMgE; Sat, 24 Jan 2009 23:52:22 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 9688C8911C;
	Sat, 24 Jan 2009 16:43:25 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107026>

Exclude GIT_EXEC_PATH from PATH, to emulate the default user environment,
and ensure all the programs (especially scripts) run correctly in
such an environment.

This works by creating a test-bin directory with wrapper scripts for
the programs normally installed in "bin", and only including that
directory in the PATH.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

Valgrind conflict:  As I was preparing this email, I noticed that a patch
for running the test suite under valgrind has been under discussion
in the mailing list.  The valgrind patch probably conflicts with this
one.  I've thought of some possible ways to resolve it:

   1. Extend this patch to support valgrind by adding
environment-variable controlled hook to test-bin-wrapper.sh,
and enhance the makefile rules to disable the valgrind hook
for instances of the script that are wrapping other scripts.
(This allows dashless, valgrind, or both.)

   2. Or change the valgrind patch to only add executables typically
found in bindir (not GIT_EXEC_PATH) to the symlink directory.  To
support dashless by itself, it would need to do a similar symlink
when asked for dashless without valgrind.

   3. Or keep the core of both patches, and just fix up the setup
in test-lib.sh to only enable one or the other (never both).

Thoughts?

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

 .gitignore          |    1 +
 Makefile            |   42 +++++++++++++++++++++++++++++++-----------
 t/test-lib.sh       |   14 +++++++++++++-
 test-bin-wrapper.sh |   12 ++++++++++++
 4 files changed, 57 insertions(+), 12 deletions(-)
 create mode 100644 test-bin-wrapper.sh

diff --git a/.gitignore b/.gitignore
index d9adce5..13a0d33 100644
--- a/.gitignore
+++ b/.gitignore
@@ -143,6 +143,7 @@ git-write-tree
 git-core-*/?*
 gitk-wish
 gitweb/gitweb.cgi
+test-bin
 test-chmtime
 test-date
 test-delta
diff --git a/Makefile b/Makefile
index b4d9cb4..197a6f0 100644
--- a/Makefile
+++ b/Makefile
@@ -330,6 +330,15 @@ ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X gitweb/gitweb.cgi
 
+# what test wrappers are needed and 'install' will install, in bindir
+BINDIR_PROGRAMS_NEED_X += git
+BINDIR_PROGRAMS_NEED_X += git-upload-pack
+BINDIR_PROGRAMS_NEED_X += git-receive-pack
+BINDIR_PROGRAMS_NEED_X += git-upload-archive
+BINDIR_PROGRAMS_NEED_X += git-shell
+
+BINDIR_PROGRAMS_NO_X += git-cvsserver
+
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
@@ -1356,17 +1365,25 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS += test-chmtime$X
-TEST_PROGRAMS += test-ctype$X
-TEST_PROGRAMS += test-date$X
-TEST_PROGRAMS += test-delta$X
-TEST_PROGRAMS += test-genrandom$X
-TEST_PROGRAMS += test-match-trees$X
-TEST_PROGRAMS += test-parse-options$X
-TEST_PROGRAMS += test-path-utils$X
-TEST_PROGRAMS += test-sha1$X
+TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-ctype
+TEST_PROGRAMS_NEED_X += test-date
+TEST_PROGRAMS_NEED_X += test-delta
+TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-match-trees
+TEST_PROGRAMS_NEED_X += test-parse-options
+TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-sha1
+
+TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS)
+test_bindir_programs := $(patsubst %,test-bin/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+
+all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+
+test-bin/%: test-bin-wrapper.sh
+	@mkdir -p test-bin
+	$(QUIET_GEN)sed -e 's|__GIT_EXEC_PATH__|$(shell pwd)|' -e 's|__PROG__|$(@F)|' < $< > $@ && chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
@@ -1425,11 +1442,13 @@ endif
 gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
 export gitexec_instdir
 
+install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
@@ -1533,6 +1552,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
+	$(RM) -r test-bin
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 41d5a59..2f42b5b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -89,6 +89,8 @@ do
 		verbose=t; shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t; shift ;;
+	--with-dashes)
+		with_dashes=t; shift ;;
 	--no-color)
 		color=; shift ;;
 	--no-python)
@@ -467,8 +469,18 @@ test_done () {
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 TEST_DIRECTORY=$(pwd)
-PATH=$TEST_DIRECTORY/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
+git_bin_dir="$TEST_DIRECTORY/../test-bin"
+if ! test -x "$git_bin_dir/git" ; then
+	if test -z "$with_dashes" ; then
+		say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
+	fi
+	with_dashes=t
+fi
+PATH="$git_bin_dir:$PATH"
+if test -n "$with_dashes" ; then
+	PATH="$TEST_DIRECTORY/..:$PATH"
+fi
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
diff --git a/test-bin-wrapper.sh b/test-bin-wrapper.sh
new file mode 100644
index 0000000..199d098
--- /dev/null
+++ b/test-bin-wrapper.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+# test-bin-wrapper.sh: Template for git executable wrapper scripts
+# to run test suite against sandbox, but with only bindir-installed
+# executables in PATH.  The Makefile copies this into various
+# files in test-bin, substituting __GIT_EXEC_PATH__ and __PROG__.
+
+GIT_EXEC_PATH="__GIT_EXEC_PATH__"
+GIT_TEMPLATE_DIR="__GIT_EXEC_PATH__/templates/blt"
+export GIT_EXEC_PATH GIT_TEMPLATE_DIR
+
+exec "${GIT_EXEC_PATH}/__PROG__" "$@"
-- 
1.6.1.81.g9833d.dirty

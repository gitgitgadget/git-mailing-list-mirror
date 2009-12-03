From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v3 1/3] build dashless "bin-wrappers" directory similar to installed bindir
Date: Wed,  2 Dec 2009 22:14:05 -0700
Message-ID: <1259817247-3724-2-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259817247-3724-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 06:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG41U-00031Q-AX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 06:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbZLCFO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 00:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbZLCFO0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 00:14:26 -0500
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:51550 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974AbZLCFOZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 00:14:25 -0500
Received: from OMTA15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id CV8b1d0071Y3wxoA7VEZTb; Thu, 03 Dec 2009 05:14:33 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA15.emeryville.ca.mail.comcast.net with comcast
	id CVEX1d0075FCJCg8bVEYd4; Thu, 03 Dec 2009 05:14:32 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 2C17789114;
	Wed,  2 Dec 2009 22:14:31 -0700 (MST)
X-Mailer: git-send-email 1.6.6.rc1
In-Reply-To: <1259817247-3724-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134431>

The new bin-wrappers directory contains wrapper scripts
for executables that will be installed into the standard
bindir.  It explicitly does not contain most dashed-commands.
The scripts automatically set environment variables to run out
of the source tree, not the installed directory.

This will allow running the test suite without dashed commands in
the PATH.  It also provides a simplified way to test run custom
built git executables without installing them first.

bin-wrappers also contains wrappers for some test suite support
executables, where the test suite will soon make use of them.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 .gitignore      |    1 +
 Makefile        |   49 ++++++++++++++++++++++++++++++++++++-------------
 wrap-for-bin.sh |   15 +++++++++++++++
 3 files changed, 52 insertions(+), 13 deletions(-)
 create mode 100644 wrap-for-bin.sh

diff --git a/.gitignore b/.gitignore
index ac02a58..5d32289 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /GIT-CFLAGS
 /GIT-GUI-VARS
 /GIT-VERSION-FILE
+/bin-wrappers/
 /git
 /git-add
 /git-add--interactive
diff --git a/Makefile b/Makefile
index 4a1e5bc..378962e 100644
--- a/Makefile
+++ b/Makefile
@@ -427,6 +427,15 @@ ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X
 
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
@@ -1714,19 +1723,30 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS += test-chmtime$X
-TEST_PROGRAMS += test-ctype$X
-TEST_PROGRAMS += test-date$X
-TEST_PROGRAMS += test-delta$X
-TEST_PROGRAMS += test-dump-cache-tree$X
-TEST_PROGRAMS += test-genrandom$X
-TEST_PROGRAMS += test-match-trees$X
-TEST_PROGRAMS += test-parse-options$X
-TEST_PROGRAMS += test-path-utils$X
-TEST_PROGRAMS += test-sha1$X
-TEST_PROGRAMS += test-sigchain$X
+TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-ctype
+TEST_PROGRAMS_NEED_X += test-date
+TEST_PROGRAMS_NEED_X += test-delta
+TEST_PROGRAMS_NEED_X += test-dump-cache-tree
+TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-match-trees
+TEST_PROGRAMS_NEED_X += test-parse-options
+TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-sha1
+TEST_PROGRAMS_NEED_X += test-sigchain
+
+TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS)
+test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+
+all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+
+bin-wrappers/%: wrap-for-bin.sh
+	@mkdir -p bin-wrappers
+	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
+	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
+	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
@@ -1787,11 +1807,13 @@ endif
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
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
@@ -1902,6 +1924,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
+	$(RM) -r bin-wrappers
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
new file mode 100644
index 0000000..c5075c9
--- /dev/null
+++ b/wrap-for-bin.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+# wrap-for-bin.sh: Template for git executable wrapper scripts
+# to run test suite against sandbox, but with only bindir-installed
+# executables in PATH.  The Makefile copies this into various
+# files in bin-wrappers, substituting
+# @@BUILD_DIR@@ and @@PROG@@.
+
+GIT_EXEC_PATH='@@BUILD_DIR@@'
+GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
+GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
+PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
+export GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB PATH
+
+exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
-- 
1.6.6.rc1

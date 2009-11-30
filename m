From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v2 4/6] build dashless "bin-wrappers" directory similar to installed bindir
Date: Sun, 29 Nov 2009 23:19:29 -0700
Message-ID: <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 30 07:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzcK-0000qX-1l
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbZK3GUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZK3GUA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:20:00 -0500
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:46325 "EHLO
	QMTA10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752688AbZK3GT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 01:19:57 -0500
Received: from OMTA06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by QMTA10.emeryville.ca.mail.comcast.net with comcast
	id BJHh1d00216AWCUAAJL5Yi; Mon, 30 Nov 2009 06:20:05 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA06.emeryville.ca.mail.comcast.net with comcast
	id BJL31d0055FCJCg8SJL4qM; Mon, 30 Nov 2009 06:20:04 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 05D9989115;
	Sun, 29 Nov 2009 23:20:03 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134049>

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

There was some discussion of only building bin-wrappers when
actually running tests, but I don't think it is worth the
extra complexity.  See the cover letter (0/6).

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
index 5a0b3d4..77892ec 100644
--- a/Makefile
+++ b/Makefile
@@ -416,6 +416,15 @@ ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
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
@@ -1690,19 +1699,30 @@ endif
 
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
+	     -e 's|__GIT_EXEC_PATH__|$(shell pwd)|' \
+	     -e 's|__PROG__|$(@F)|' < $< > $@ && \
+	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
@@ -1763,11 +1783,13 @@ endif
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
@@ -1878,6 +1900,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
+	$(RM) -r bin-wrappers
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
new file mode 100644
index 0000000..ee2bc98
--- /dev/null
+++ b/wrap-for-bin.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+# wrap-for-bin.sh: Template for git executable wrapper scripts
+# to run test suite against sandbox, but with only bindir-installed
+# executables in PATH.  The Makefile copies this into various
+# files in bin-wrappers, substituting
+# __GIT_EXEC_PATH__ and __PROG__.
+
+GIT_EXEC_PATH="__GIT_EXEC_PATH__"
+GIT_TEMPLATE_DIR="__GIT_EXEC_PATH__/templates/blt"
+GITPERLLIB="__GIT_EXEC_PATH__/perl/blib/lib"
+PATH="__GIT_EXEC_PATH__/bin-wrappers:$PATH"
+export GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB PATH
+
+exec "${GIT_EXEC_PATH}/__PROG__" "$@"
-- 
1.6.4.GIT

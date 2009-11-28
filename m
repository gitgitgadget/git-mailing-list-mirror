From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 3/4] build dashless "test-bin" directory similar to installed bindir
Date: Sat, 28 Nov 2009 11:38:56 -0700
Message-ID: <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 28 19:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NESH9-0005ra-JK
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 19:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZK1Snn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 13:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbZK1Snm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 13:43:42 -0500
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:34379
	"EHLO QMTA12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753074AbZK1Snf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 13:43:35 -0500
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA12.emeryville.ca.mail.comcast.net with comcast
	id AicF1d0030EPchoACijje5; Sat, 28 Nov 2009 18:43:43 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id Aijh1d0095FCJCg8Mijiqm; Sat, 28 Nov 2009 18:43:42 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id CC84B89115;
	Sat, 28 Nov 2009 11:43:40 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133969>

The new test-bin directory contains wrapper scripts
for executables that will be installed into the standard
bindir.  It explicitly does not contain most dashed-commands.
The scripts automatically set environment variables to run out
of the source tree, not the installed directory.

This will allow running the test suite without dashed commands in
the PATH, and provides a simplified way to run custom built git
executables without installing them first.

test-bin also contains wrappers for some test suite support executables,
where the test suite will soon make use of them.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 .gitignore          |    1 +
 INSTALL             |    8 +++++++-
 Makefile            |   46 +++++++++++++++++++++++++++++++++-------------
 test-bin-wrapper.sh |   13 +++++++++++++
 4 files changed, 54 insertions(+), 14 deletions(-)
 create mode 100644 test-bin-wrapper.sh

diff --git a/.gitignore b/.gitignore
index ac02a58..c981e4c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@
 /git-apply
 /git-archimport
 /git-archive
+/test-bin/
 /git-bisect
 /git-bisect--helper
 /git-blame
diff --git a/INSTALL b/INSTALL
index be504c9..d092d33 100644
--- a/INSTALL
+++ b/INSTALL
@@ -39,7 +39,13 @@ Issues of note:
    with --disable-transition option to avoid this.
 
  - You can use git after building but without installing if you
-   wanted to.  Various git commands need to find other git
+   want to.
+
+   The simplest option is to use the wrapper scripts that are built
+   and saved into `pwd`/test-bin, by either putting test-bin in your
+   PATH, or invoking the scripts in test-bin using their full paths.
+
+   Alternatively, various git commands need to find other git
    commands and scripts to do their work, so you would need to
    arrange a few environment variables to tell them that their
    friends will be found in your built source area instead of at
diff --git a/Makefile b/Makefile
index 5a0b3d4..e153ff0 100644
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
@@ -1690,19 +1699,27 @@ endif
 
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
+test_bindir_programs := $(patsubst %,test-bin/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+
+all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+
+test-bin/%: test-bin-wrapper.sh GIT-CFLAGS
+	@mkdir -p test-bin
+	$(QUIET_GEN)sed -e 's|__GIT_EXEC_PATH__|$(shell pwd)|' -e 's|__PROG__|$(@F)|' < $< > $@ && chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
@@ -1763,11 +1780,13 @@ endif
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
@@ -1878,6 +1897,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
+	$(RM) -r test-bin
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
diff --git a/test-bin-wrapper.sh b/test-bin-wrapper.sh
new file mode 100644
index 0000000..a01eee1
--- /dev/null
+++ b/test-bin-wrapper.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+# test-bin-wrapper.sh: Template for git executable wrapper scripts
+# to run test suite against sandbox, but with only bindir-installed
+# executables in PATH.  The Makefile copies this into various
+# files in test-bin, substituting __GIT_EXEC_PATH__ and __PROG__.
+
+GIT_EXEC_PATH="__GIT_EXEC_PATH__"
+GIT_TEMPLATE_DIR="__GIT_EXEC_PATH__/templates/blt"
+GITPERLLIB="__GIT_EXEC_PATH__/perl/blib/lib"
+export GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB
+
+exec "${GIT_EXEC_PATH}/__PROG__" "$@"
-- 
1.6.4.GIT

From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/2] Makefile: detect when PYTHON_PATH changes
Date: Sun, 16 Dec 2012 20:38:49 +0100
Message-ID: <20121216193850.23461.10354.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:40:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkK4C-0002xs-4m
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 20:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab2LPTjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 14:39:47 -0500
Received: from [194.158.122.134] ([194.158.122.134]:43516 "EHLO
	mail-4d.bbox.fr" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753129Ab2LPTjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 14:39:46 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-4d.bbox.fr (Postfix) with ESMTP id 0D7C6C8;
	Sun, 16 Dec 2012 20:39:24 +0100 (CET)
X-git-sha1: 87400351ef5f1f4068f85abb1421b01d02bea90a 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211610>

When make is run, the python scripts are created from *.py files that
are changed to use the python given by PYTHON_PATH. And PYTHON_PATH
is set by default to /usr/bin/python on Linux.

This is nice except when you run make another time setting a
different PYTHON_PATH, because, as the python scripts have already
been created, make finds nothing to do.

The goal of this patch is to detect when the PYTHON_PATH changes and
to create the python scripts again when this happens. To do that we
use the same trick that is done to track other variables like prefix,
flags, tcl/tk path and shell path. We update a GIT-PYTHON-VARS file
with the PYTHON_PATH and check if it changed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore |  1 +
 Makefile   | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6d69ae1..086c5af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /GIT-CFLAGS
 /GIT-LDFLAGS
 /GIT-PREFIX
+/GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
diff --git a/Makefile b/Makefile
index 585b2eb..7db8445 100644
--- a/Makefile
+++ b/Makefile
@@ -2245,7 +2245,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 endif # NO_PERL
 
 ifndef NO_PYTHON
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS GIT-PREFIX
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
@@ -2624,6 +2624,18 @@ ifdef GIT_PERF_MAKE_OPTS
 	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@
 endif
 
+### Detect Python interpreter path changes
+ifndef NO_PYTHON
+TRACK_PYTHON = $(subst ','\'',-DPYTHON_PATH='$(PYTHON_PATH_SQ)')
+
+GIT-PYTHON-VARS: FORCE
+	@VARS='$(TRACK_PYTHON)'; \
+	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo 1>&2 "    * new Python interpreter location"; \
+		echo "$$VARS" >$@; \
+            fi
+endif
+
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
@@ -2899,7 +2911,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
-	$(RM) GIT-USER-AGENT GIT-PREFIX GIT-SCRIPT-DEFINES
+	$(RM) GIT-USER-AGENT GIT-PREFIX GIT-SCRIPT-DEFINES GIT-PYTHON-VARS
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.8.1.rc1.2.g8740035

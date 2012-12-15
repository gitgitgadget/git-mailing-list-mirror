From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Makefile: detect when PYTHON_PATH changes
Date: Sat, 15 Dec 2012 15:07:18 +0100
Message-ID: <20121215140719.2409.27365.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 15:09:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjsQK-00052Z-O8
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 15:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab2LOOIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 09:08:41 -0500
Received: from mail-2d.bbox.fr ([194.158.122.57]:55097 "EHLO mail-2d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab2LOOIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 09:08:40 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2d.bbox.fr (Postfix) with ESMTP id BFC9A85;
	Sat, 15 Dec 2012 15:08:37 +0100 (CET)
X-git-sha1: 9537e17cf80df56ed8bbea937bea36ef3cfc2676 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211532>

When make is run the python script are created from *.py files that
are changed to use the python given by PYTHON_PATH. And PYTHON_PATH
is set by default to /usr/bin/python on Linux.

This is nice except when you run make another time setting a
different PYTHON_PATH, because, as the python scripts have already
been created, make finds nothing to do.

The goal of this patch is to detect when the PYTHON_PATH changes and
to create the python scripts again when this happens. To do that we
use the same trick that is done to track prefix, flags and tcl/tk
path. We update a GIT-PYTHON-VARS file with the PYTHON_PATH and check
if it changed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4ad6fbd..bd86063 100644
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
@@ -2636,6 +2636,18 @@ GIT-GUI-VARS: FORCE
             fi
 endif
 
+### Detect Python interpreter path changes
+ifndef NO_PYTHON
+TRACK_VARS = $(subst ','\'',-DPYTHON_PATH='$(PYTHON_PATH_SQ)')
+
+GIT-PYTHON-VARS: FORCE
+	@VARS='$(TRACK_VARS)'; \
+	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo 1>&2 "    * new Python interpreter location"; \
+		echo "$$VARS" >$@; \
+            fi
+endif
+
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
-- 
1.8.1.rc1.1.g9537e17

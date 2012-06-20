From: Jeff King <peff@peff.net>
Subject: [PATCHv3 09/11] Makefile: update scripts when build-time parameters
 change
Date: Wed, 20 Jun 2012 14:32:16 -0400
Message-ID: <20120620183216.GI30995@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:32:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPhj-00082g-1b
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503Ab2FTScY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:32:24 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39033
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2FTScU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:32:20 -0400
Received: (qmail 27009 invoked by uid 107); 20 Jun 2012 18:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:32:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:32:16 -0400
Content-Disposition: inline
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200326>

Currently, running:

  make SHELL_PATH=/bin/bash &&
  make SHELL_PATH=/bin/sh

will not rebuild any shell scripts in the second command,
leading to incorrect results when building from an unclean
working directory.

This patch introduces a new dependency meta-file to notice
the change.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore |  1 +
 Makefile   | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index c60c5a3..6535cd7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,7 @@
 /GIT-LDFLAGS
 /GIT-GUI-VARS
 /GIT-PREFIX
+/GIT-SCRIPT-DEFINES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index b977903..ea55179 100644
--- a/Makefile
+++ b/Makefile
@@ -2011,6 +2011,8 @@ common-cmds.h: ./generate-cmdlist.sh command-list.txt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
+SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
+	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2023,12 +2025,20 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     $@.sh >$@+
 endef
 
-$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
+GIT-SCRIPT-DEFINES: FORCE
+	@FLAGS='$(SCRIPT_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo 1>&2 "    * new script parameters"; \
+		echo "$$FLAGS" >$@; \
+            fi
+
+
+$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-$(SCRIPT_LIB) : % : %.sh
+$(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
@@ -2739,7 +2749,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
-	$(RM) GIT-USER-AGENT GIT-PREFIX
+	$(RM) GIT-USER-AGENT GIT-PREFIX GIT-SCRIPT-DEFINES
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.7.11.5.gc0eeaa8

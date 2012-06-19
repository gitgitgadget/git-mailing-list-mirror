From: Jeff King <peff@peff.net>
Subject: [PATCHv2 6/8] Makefile: update scripts when build-time parameters
 change
Date: Tue, 19 Jun 2012 19:28:45 -0400
Message-ID: <20120619232845.GF6496@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:29:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7qu-0007SV-5B
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab2FSX2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:28:48 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33154
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab2FSX2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:28:48 -0400
Received: (qmail 15881 invoked by uid 107); 19 Jun 2012 23:28:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 19:28:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 19:28:45 -0400
Content-Disposition: inline
In-Reply-To: <20120619232231.GA6328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200271>

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
I suspect nobody complained because the parameters replace in shell
files tend not to change. I think perl scripts have a similar problem,
but I decided not to tackle them today.

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
index c0bf3ad..979ba31 100644
--- a/Makefile
+++ b/Makefile
@@ -2010,6 +2010,8 @@ common-cmds.h: ./generate-cmdlist.sh command-list.txt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
+SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
+	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2022,12 +2024,20 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
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
 
@@ -2752,7 +2762,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
-	$(RM) GIT-USER-AGENT GIT-PREFIX
+	$(RM) GIT-USER-AGENT GIT-PREFIX GIT-SCRIPT-DEFINES
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.7.11.rc3.5.g201460b

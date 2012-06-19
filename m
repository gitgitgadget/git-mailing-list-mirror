From: Jeff King <peff@peff.net>
Subject: [PATCHv2 7/8] Makefile: build instaweb similar to other scripts
Date: Tue, 19 Jun 2012 19:29:09 -0400
Message-ID: <20120619232909.GG6496@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:29:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7rM-0008D9-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab2FSX3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:29:14 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33159
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974Ab2FSX3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:29:11 -0400
Received: (qmail 15912 invoked by uid 107); 19 Jun 2012 23:29:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 19:29:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 19:29:09 -0400
Content-Disposition: inline
In-Reply-To: <20120619232231.GA6328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200272>

Instaweb would not properly rebuild if the build-time
parameters changed. Fix this by depending on the
GIT-SCRIPT-DEFINES meta-file and using $(cmd_munge_script)
like all the other shell scripts. This requires adding a few
new parametres to cmd_munge_script, but that doesn't hurt
existing scripts.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 979ba31..ad183d9 100644
--- a/Makefile
+++ b/Makefile
@@ -2011,7 +2011,8 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
-	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)
+	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
+	$(gitwebdir_SQ):$(PERL_PATH_SQ)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2021,6 +2022,8 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
+    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
+    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
     $@.sh >$@+
 endef
 
@@ -2067,13 +2070,8 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
-git-instaweb: git-instaweb.sh gitweb
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
-	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
-	    $@.sh > $@+ && \
+git-instaweb: git-instaweb.sh gitweb GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-- 
1.7.11.rc3.5.g201460b

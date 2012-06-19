From: Jeff King <peff@peff.net>
Subject: [PATCHv2 3/8] Makefile: split GIT_USER_AGENT from GIT-CFLAGS
Date: Tue, 19 Jun 2012 19:25:29 -0400
Message-ID: <20120619232529.GC6496@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:25:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7ni-0000ys-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab2FSXZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:25:31 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33143
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab2FSXZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:25:31 -0400
Received: (qmail 15791 invoked by uid 107); 19 Jun 2012 23:25:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 19:25:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 19:25:29 -0400
Content-Disposition: inline
In-Reply-To: <20120619232231.GA6328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200268>

The default user-agent depends on the GIT_VERSION, which
means that anytime you switch versions, it causes a full
rebuild. Instead, let's split it out into its own file and
restrict the dependency to version.o.

Signed-off-by: Jeff King <peff@peff.net>
---
v1 forgot to add a line to "make clean" to remove the meta-file.

 .gitignore |  1 +
 Makefile   | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index bf66648..7329cfe 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /GIT-CFLAGS
 /GIT-LDFLAGS
 /GIT-GUI-VARS
+/GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
 /git
diff --git a/Makefile b/Makefile
index 23c289d..8ff61c5 100644
--- a/Makefile
+++ b/Makefile
@@ -1924,7 +1924,11 @@ endif
 GIT_USER_AGENT_SQ = $(subst ','\'',$(GIT_USER_AGENT))
 GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
 GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
-BASIC_CFLAGS += -DGIT_USER_AGENT='$(GIT_USER_AGENT_CQ_SQ)'
+GIT-USER-AGENT: FORCE
+	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat GIT-USER-AGENT 2>/dev/null`"; then \
+		echo >&2 "    * new user-agent flag"; \
+		echo '$(GIT_USER_AGENT_SQ)' >GIT-USER-AGENT; \
+	fi
 
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
@@ -1990,8 +1994,10 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
+version.sp version.s version.o: GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
-	'-DGIT_VERSION="$(GIT_VERSION)"'
+	'-DGIT_VERSION="$(GIT_VERSION)"' \
+	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -2736,6 +2742,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
+	$(RM) GIT-USER-AGENT
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.7.11.rc3.5.g201460b

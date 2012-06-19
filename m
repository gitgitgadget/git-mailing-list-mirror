From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] Makefile: split GIT_USER_AGENT from GIT-CFLAGS
Date: Tue, 19 Jun 2012 16:01:47 -0400
Message-ID: <20120619200147.GB14714@sigill.intra.peff.net>
References: <20120619195229.GA14692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4cq-00084r-6d
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab2FSUBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:01:50 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:32956
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650Ab2FSUBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:01:49 -0400
Received: (qmail 12782 invoked by uid 107); 19 Jun 2012 20:01:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 16:01:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 16:01:47 -0400
Content-Disposition: inline
In-Reply-To: <20120619195229.GA14692@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200234>

The default user-agent depends on the GIT_VERSION, which
means that anytime you switch versions, it causes a full
rebuild. Instead, let's split it out into its own file and
restrict the dependency to version.o.

Signed-off-by: Jeff King <peff@peff.net>
---
This can't just depend on GIT-VERSION-FILE, since the user may have set
GIT_USER_AGENT independently, and we would want to trigger a rebuild in
that case.

I'm not happy about adding an extra built file and 4 lines of ugly shell
script per variable, but I don't see a good way around it. It would be
slightly nicer if we actually just built auto/user-agent.h with the
value, #included it from version.c, and then let the automatic
dependency checker pick it up. But we'd still have to do the "only
update it if the value is actually changed" dance.

I've worked on systems in the past which use a file per variable, which
lets make handle the dependencies normally. Something like:

  $ echo my-value >config/foo
  $ cat Makefile
  auto/foo.o: config/foo
          ./build-cstr $<

but that is a radical departure from the current config procedure. It
also doesn't play all that well with version control (are config/* files
versioned? If not, where do the defaults come from? If so, how do you
override without the vcs wanting to commit changes?).

We are pretty well tied to GNU make. So there might be some GNU-specific
way of templating GIT-CFLAGS, GIT-LDFLAGS, GIT-USER-AGENT etc.

 .gitignore |  1 +
 Makefile   | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

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
index 537d2ea..42ce2dd 100644
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
-- 
1.7.11.rc3.5.g201460b

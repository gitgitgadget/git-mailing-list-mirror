From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] version: add git_user_agent function
Date: Sat, 2 Jun 2012 15:01:12 -0400
Message-ID: <20120602190112.GB14369@sigill.intra.peff.net>
References: <20120602184948.GA14269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 21:01:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SatZg-0002zC-G8
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 21:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965513Ab2FBTBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 15:01:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41288
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965489Ab2FBTBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 15:01:15 -0400
Received: (qmail 16572 invoked by uid 107); 2 Jun 2012 19:01:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 15:01:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 15:01:12 -0400
Content-Disposition: inline
In-Reply-To: <20120602184948.GA14269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199057>

This is basically a fancy way of saying "git/$GIT_VERSION",
except that it is overridable at build-time and through the
environment. Which means that people who don't want to
advertise their git version (for privacy or security
reasons) can tweak it.

Signed-off-by: Jeff King <peff@peff.net>
---
The next patch adapts http.c to use this, and of course the one after
that adds support for the git protocol itself. There are a few other
places where the git version leaks publicly, including at least:

  1. in the x-mailer header of send-email

  2. at the bottom of format-patch emails

  3. in the mime boundaries (!) of format-patch emails

Since the default here is functionally identical, and the only people
who would care are those interested in masking their version, and nobody
has actually come forward and said they want to do that, I am inclined
not to worry about it. I'd consider the masking to be more important (if
it is important at all) on the server side.  Perhaps this series will
catch the attention of people who do care, and they can decide if they
would like to take it farther.

 Makefile  | 11 +++++++++++
 version.c | 13 +++++++++++++
 version.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/Makefile b/Makefile
index b394f85..e6e65ca 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,9 @@ all::
 # the diff algorithm.  It gives a nice speedup if your processor has
 # fast unaligned word loads.  Does NOT work on big-endian systems!
 # Enabled by default on x86_64.
+#
+# Define GIT_USER_AGENT if you want to change how git identifies itself during
+# network interactions.  The default is "git/$(GIT_VERSION)".
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -905,6 +908,8 @@ BUILTIN_OBJS += builtin/write-tree.o
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
+GIT_USER_AGENT = git/$(GIT_VERSION)
+
 #
 # Platform specific tweaks
 #
@@ -1916,6 +1921,11 @@ SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
 BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
 endif
 
+GIT_USER_AGENT_SQ = $(subst ','\'',$(GIT_USER_AGENT))
+GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
+GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
+BASIC_CFLAGS += -DGIT_USER_AGENT='$(GIT_USER_AGENT_CQ_SQ)'
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
@@ -2000,6 +2010,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+    -e 's|@@GIT_USER_AGENT@@|$(GIT_USER_AGENT_SQ)|g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
diff --git a/version.c b/version.c
index ca68653..f98d5a6 100644
--- a/version.c
+++ b/version.c
@@ -2,3 +2,16 @@
 #include "version.h"
 
 const char git_version_string[] = GIT_VERSION;
+
+const char *git_user_agent(void)
+{
+	static const char *agent = NULL;
+
+	if (!agent) {
+		agent = getenv("GIT_USER_AGENT");
+		if (!agent)
+			agent = GIT_USER_AGENT;
+	}
+
+	return agent;
+}
diff --git a/version.h b/version.h
index 8d6c413..fd9cdd6 100644
--- a/version.h
+++ b/version.h
@@ -3,4 +3,6 @@
 
 extern const char git_version_string[];
 
+const char *git_user_agent(void);
+
 #endif /* VERSION_H */
-- 
1.7.7.7.32.g4b73117

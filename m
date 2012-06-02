From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] move git_version_string into version.c
Date: Sat, 2 Jun 2012 14:51:42 -0400
Message-ID: <20120602185142.GA14369@sigill.intra.peff.net>
References: <20120602184948.GA14269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 20:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SatQT-000602-9y
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 20:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360Ab2FBSvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 14:51:45 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41278
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965083Ab2FBSvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 14:51:45 -0400
Received: (qmail 16410 invoked by uid 107); 2 Jun 2012 18:51:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 14:51:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 14:51:42 -0400
Content-Disposition: inline
In-Reply-To: <20120602184948.GA14269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199056>

The global git_version_string currently lives in git.c, but
doesn't have anything to do with the git wrapper. Let's move
it into its own file, where it will be more appropriate to
build more version-related functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile      | 8 ++++++--
 builtin.h     | 1 -
 builtin/log.c | 1 +
 git.c         | 2 --
 help.c        | 1 +
 version.c     | 4 ++++
 version.h     | 6 ++++++
 7 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 version.c
 create mode 100644 version.h

diff --git a/Makefile b/Makefile
index 4592f1f..b394f85 100644
--- a/Makefile
+++ b/Makefile
@@ -799,6 +799,7 @@ LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
 LIB_OBJS += varint.o
+LIB_OBJS += version.o
 LIB_OBJS += walker.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
@@ -1962,7 +1963,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 git.o: common-cmds.h
-git.sp git.s git.o: EXTRA_CPPFLAGS = -DGIT_VERSION='"$(GIT_VERSION)"' \
+git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
@@ -1979,6 +1980,9 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
+version.sp version.s version.o: EXTRA_CPPFLAGS = \
+	'-DGIT_VERSION="$(GIT_VERSION)"'
+
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln git$X $@ 2>/dev/null || \
@@ -2089,7 +2093,7 @@ configure: configure.ac
 	$(RM) $<+
 
 # These can record GIT_VERSION
-git.o git.spec http.o \
+version.o git.spec http.o \
 	$(patsubst %.sh,%,$(SCRIPT_SH)) \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
diff --git a/builtin.h b/builtin.h
index 338f540..dea1643 100644
--- a/builtin.h
+++ b/builtin.h
@@ -9,7 +9,6 @@
 
 #define DEFAULT_MERGE_LOG_LEN 20
 
-extern const char git_version_string[];
 extern const char git_usage_string[];
 extern const char git_more_info_string[];
 
diff --git a/builtin/log.c b/builtin/log.c
index 906dca4..4f1b42a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -21,6 +21,7 @@
 #include "parse-options.h"
 #include "branch.h"
 #include "streaming.h"
+#include "version.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
diff --git a/git.c b/git.c
index d232de9..4da3db5 100644
--- a/git.c
+++ b/git.c
@@ -256,8 +256,6 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
-const char git_version_string[] = GIT_VERSION;
-
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
 #define USE_PAGER		(1<<2)
diff --git a/help.c b/help.c
index 6012c07..662349d 100644
--- a/help.c
+++ b/help.c
@@ -6,6 +6,7 @@
 #include "common-cmds.h"
 #include "string-list.h"
 #include "column.h"
+#include "version.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
diff --git a/version.c b/version.c
new file mode 100644
index 0000000..ca68653
--- /dev/null
+++ b/version.c
@@ -0,0 +1,4 @@
+#include "git-compat-util.h"
+#include "version.h"
+
+const char git_version_string[] = GIT_VERSION;
diff --git a/version.h b/version.h
new file mode 100644
index 0000000..8d6c413
--- /dev/null
+++ b/version.h
@@ -0,0 +1,6 @@
+#ifndef VERSION_H
+#define VERSION_H
+
+extern const char git_version_string[];
+
+#endif /* VERSION_H */
-- 
1.7.7.7.32.g4b73117

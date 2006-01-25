From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Add compat/unsetenv.c .
Date: Wed, 25 Jan 2006 12:38:36 -0800
Message-ID: <10812.1138221516@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 25 21:38:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1rPc-0001fp-Dc
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 21:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWAYUih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 15:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWAYUih
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 15:38:37 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:909 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750808AbWAYUih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 15:38:37 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k0PKcaxV010818
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 12:38:36 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k0PKcauv010817
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 12:38:36 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15137>

Implement a (slow) unsetenv() for older systems.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 Makefile          |    5 +++++
 compat/unsetenv.c |   26 ++++++++++++++++++++++++++
 connect.c         |    1 +
 git-compat-util.h |    5 +++++
 4 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 compat/unsetenv.c

30e532bf9194724ac7923b07236ec8d3cdfe4a8a
diff --git a/Makefile b/Makefile
index 245f658..2e95353 100644
--- a/Makefile
+++ b/Makefile
@@ -232,6 +232,7 @@ ifeq ($(uname_S),SunOS)
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
 	ifeq ($(uname_R),5.8)
+		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 	endif
 	INSTALL = ginstall
@@ -355,6 +356,10 @@ ifdef NO_SETENV
 	COMPAT_CFLAGS += -DNO_SETENV
 	COMPAT_OBJS += compat/setenv.o
 endif
+ifdef NO_SETENV
+	COMPAT_CFLAGS += -DNO_UNSETENV
+	COMPAT_OBJS += compat/unsetenv.o
+endif
 ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
diff --git a/compat/unsetenv.c b/compat/unsetenv.c
new file mode 100644
index 0000000..3a5e4ec
--- /dev/null
+++ b/compat/unsetenv.c
@@ -0,0 +1,26 @@
+#include <stdlib.h>
+#include <string.h>
+
+void gitunsetenv (const char *name)
+{
+     extern char **environ;
+     int src, dst;
+     size_t nmln;
+
+     nmln = strlen(name);
+
+     for (src = dst = 0; environ[src]; ++src) {
+	  size_t enln;
+	  enln = strlen(environ[src]);
+	  if (enln > nmln) {
+               /* might match, and can test for '=' safely */
+	       if (0 == strncmp (environ[src], name, nmln)
+		   && '=' == environ[src][nmln])
+		    /* matches, so skip */
+		    continue;
+	  }
+	  environ[dst] = environ[src];
+	  ++dst;
+     }
+     environ[dst] = NULL;
+}
diff --git a/connect.c b/connect.c
index e1c04e1..3f2d65c 100644
--- a/connect.c
+++ b/connect.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "cache.h"
 #include "pkt-line.h"
 #include "quote.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 12ce659..f982b8e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -63,6 +63,11 @@ extern int gitfakemunmap(void *start, si
 extern int gitsetenv(const char *, const char *, int);
 #endif
 
+#ifdef NO_UNSETENV
+#define unsetenv gitunsetenv
+extern void gitunsetenv(const char *);
+#endif
+
 #ifdef NO_STRCASESTR
 #define strcasestr gitstrcasestr
 extern char *gitstrcasestr(const char *haystack, const char *needle);
-- 
1.0.GIT

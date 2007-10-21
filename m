From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Define compat version of mkdtemp for systems lacking it
Date: Sun, 21 Oct 2007 01:30:15 -0400
Message-ID: <20071021053015.GA31995@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 07:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjTOd-0002PD-K2
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 07:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXJUFaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 01:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXJUFaU
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 01:30:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33408 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbXJUFaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 01:30:18 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjTOC-0007db-Fk
	for git@vger.kernel.org; Sun, 21 Oct 2007 01:30:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 225FD20FBAE; Sun, 21 Oct 2007 01:30:15 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61879>

Solaris 9 doesn't have mkdtemp() so we need to emulate it for the
rsync transport implementation.  Since Solaris 9 is lacking this
function we can also reasonably assume it is not available on
Solaris 8 either.  The new Makfile definition NO_MKDTEMP can be
set to enable the git compat version.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 On top of 'next' so that the db/fetch-pack series will actually
 build on Solaris 9.

 Makefile          |    8 ++++++++
 compat/mkdtemp.c  |    8 ++++++++
 git-compat-util.h |    5 +++++
 3 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 compat/mkdtemp.c

diff --git a/Makefile b/Makefile
index bb4873d..6287418 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,8 @@ all::
 #
 # Define NO_SETENV if you don't have setenv in the C library.
 #
+# Define NO_MKDTEMP if you don't have mkdtemp in the C library.
+#
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
@@ -414,12 +416,14 @@ ifeq ($(uname_S),SunOS)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
+		NO_MKDTEMP = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
+		NO_MKDTEMP = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
@@ -610,6 +614,10 @@ ifdef NO_SETENV
 	COMPAT_CFLAGS += -DNO_SETENV
 	COMPAT_OBJS += compat/setenv.o
 endif
+ifdef NO_MKDTEMP
+	COMPAT_CFLAGS += -DNO_MKDTEMP
+	COMPAT_OBJS += compat/mkdtemp.o
+endif
 ifdef NO_UNSETENV
 	COMPAT_CFLAGS += -DNO_UNSETENV
 	COMPAT_OBJS += compat/unsetenv.o
diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
new file mode 100644
index 0000000..34d4b49
--- /dev/null
+++ b/compat/mkdtemp.c
@@ -0,0 +1,8 @@
+#include "../git-compat-util.h"
+
+char *gitmkdtemp(char *template)
+{
+	if (!mktemp(template) || mkdir(template, 0700))
+		return NULL;
+	return template;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index f23d934..474f1d1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -147,6 +147,11 @@ extern ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 extern int gitsetenv(const char *, const char *, int);
 #endif
 
+#ifdef NO_MKDTEMP
+#define mkdtemp gitmkdtemp
+extern char *gitmkdtemp(char *);
+#endif
+
 #ifdef NO_UNSETENV
 #define unsetenv gitunsetenv
 extern void gitunsetenv(const char *);
-- 
1.5.3.4.1270.g2fe543

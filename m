From: mduft@s01en22.salomon.at
Subject: [PATCH] add support for the SUA layer (interix; windows)
Date: Fri, 22 Oct 2010 11:56:41 +0200
Message-ID: <1287741401-17941-1-git-send-email-mduft@gentoo.org>
Cc: Markus Duft <mduft@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 12:09:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9EZ7-0007Da-Ve
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 12:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab0JVKJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 06:09:24 -0400
Received: from smtp.salomon.at ([193.186.16.13]:52075 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752606Ab0JVKJX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 06:09:23 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2010 06:09:23 EDT
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id o9M9wJRL019095;
	Fri, 22 Oct 2010 11:59:17 +0200 (METDST)
Received: from s01en22 ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 22 Oct 2010 11:59:02 +0200
Received: by s01en22 (sSMTP sendmail emulation); Fri, 22 Oct 2010 11:57:29 +0200
X-Mailer: git-send-email 1.7.2.2
X-OriginalArrivalTime: 22 Oct 2010 09:59:02.0751 (UTC) FILETIME=[C16D0EF0:01CB71CF]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159673>

* add required build options to Makefile.
* introduce new NO_INTTYPES_H for systems lacking inttypes; code
  includes stdint.h instead, if this is set.
* introduce new NO_SYS_POLL_H for systems lacking sys/poll.h; code
  includes poll.h instead, if this is set.
* introduce NO_INITGROUPS. initgroups() call is simply omitted.

Signed-off-by: Markus Duft <mduft@gentoo.org>
---
 Makefile          |   28 ++++++++++++++++++++++++++++
 daemon.c          |    6 +++++-
 git-compat-util.h |    8 ++++++++
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..c9d8c9e 100644
--- a/Makefile
+++ b/Makefile
@@ -1096,6 +1096,25 @@ else
 endif
 	X = .exe
 endif
+ifeq ($(uname_S),Interix)
+	NO_SYS_POLL_H = YesPlease
+	NO_INTTYPES_H = YesPlease
+	NO_INITGROUPS = YesPlease
+	NO_IPV6 = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_NSEC = YesPlease
+	NO_MKSTEMPS = YesPlease
+	ifeq ($(uname_R),3.5)
+		NO_INET_NTOP = YesPlease
+		NO_INET_PTON = YesPlease
+	endif
+	ifeq ($(uname_R),5.2)
+		NO_INET_NTOP = YesPlease
+		NO_INET_PTON = YesPlease
+	endif
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -1360,6 +1379,15 @@ endif
 ifdef NO_SYS_SELECT_H
 	BASIC_CFLAGS += -DNO_SYS_SELECT_H
 endif
+ifdef NO_SYS_POLL_H
+	BASIC_CFLAGS += -DNO_SYS_POLL_H
+endif
+ifdef NO_INTTYPES_H
+	BASIC_CFLAGS += -DNO_INTTYPES_H
+endif
+ifdef NO_INITGROUPS
+	BASIC_CFLAGS += -DNO_INITGROUPS
+endif
 ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
diff --git a/daemon.c b/daemon.c
index 9326d3a..d68a31f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -956,7 +956,11 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
 		    listen_addr, listen_port);
 
 	if (pass && gid &&
-	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
+	    (
+#ifndef NO_INITGROUPS
+		    initgroups(pass->pw_name, gid) || 
+#endif
+	     setgid (gid) ||
 	     setuid(pass->pw_uid)))
 		die("cannot drop privileges");
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..625b2e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -106,7 +106,11 @@
 #include <utime.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
+#ifndef NO_SYS_POLL_H
 #include <sys/poll.h>
+#else
+#include <poll.h>
+#endif
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
@@ -118,7 +122,11 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+#ifndef NO_INTTYPES_H
 #include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
-- 
1.7.2.2

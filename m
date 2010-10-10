From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 13/14] mingw: use poll-emulation from gnulib
Date: Sun, 10 Oct 2010 15:20:53 +0200
Message-ID: <1286716854-5744-14-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vs2-0005GO-WF
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697Ab0JJNXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:23:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab0JJNXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:23:19 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RLLiAsz9pqllj5tTh7d0M3Kd8jsas0bWpySVTsGVc1c=;
        b=iH1ZjyzIFYdLyKz/9E5pibyB0zISp03vmCx1TeCv8a9DXiKfam2E1tvi40acFSnSNm
         XIezaHCsMmVWFlpEIjslCxQRabD1sX8qa7UJTMvPb1MXV2f+S+KBM77bNwAu+mxEeWD4
         iY4fLHd1kHfKimSs7xWyjFNVFS0Q7e5xNKgtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x8dGGoBjFtZ8W5RIRNqZGngy1in7OhHzBcGGIAlXgOvMVyKuoed4Bs5Lc0AvP2dh2q
         utZflO4lDNteTIQm+S+x/BZbDXVZM4Z4WQ+PkFtw9uRV8RkKdBSJDkUVfrTyMD8P1DEQ
         9RvjDCnJNX5sE225iJFIISyKX7358TAmEW11U=
Received: by 10.213.27.76 with SMTP id h12mr1172606ebc.60.1286716998201;
        Sun, 10 Oct 2010 06:23:18 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v59sm9035815eeh.16.2010.10.10.06.23.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:23:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158671>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile            |    2 +-
 compat/mingw.c      |   65 ---------------------------------------------------
 compat/mingw.h      |   11 --------
 compat/win32/poll.c |    3 +-
 git-compat-util.h   |    1 +
 5 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/Makefile b/Makefile
index ebb51e3..42baa4d 100644
--- a/Makefile
+++ b/Makefile
@@ -1131,7 +1131,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
-		compat/win32/pthread.o
+		compat/win32/pthread.o compat/win32/poll.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/mingw.c b/compat/mingw.c
index 32ca664..bbe45d0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -408,71 +408,6 @@ int pipe(int filedes[2])
 	return 0;
 }
 
-int poll(struct pollfd *ufds, unsigned int nfds, int timeout)
-{
-	int i, pending;
-
-	if (timeout >= 0) {
-		if (nfds == 0) {
-			Sleep(timeout);
-			return 0;
-		}
-		return errno = EINVAL, error("poll timeout not supported");
-	}
-
-	/* When there is only one fd to wait for, then we pretend that
-	 * input is available and let the actual wait happen when the
-	 * caller invokes read().
-	 */
-	if (nfds == 1) {
-		if (!(ufds[0].events & POLLIN))
-			return errno = EINVAL, error("POLLIN not set");
-		ufds[0].revents = POLLIN;
-		return 0;
-	}
-
-repeat:
-	pending = 0;
-	for (i = 0; i < nfds; i++) {
-		DWORD avail = 0;
-		HANDLE h = (HANDLE) _get_osfhandle(ufds[i].fd);
-		if (h == INVALID_HANDLE_VALUE)
-			return -1;	/* errno was set */
-
-		if (!(ufds[i].events & POLLIN))
-			return errno = EINVAL, error("POLLIN not set");
-
-		/* this emulation works only for pipes */
-		if (!PeekNamedPipe(h, NULL, 0, NULL, &avail, NULL)) {
-			int err = GetLastError();
-			if (err == ERROR_BROKEN_PIPE) {
-				ufds[i].revents = POLLHUP;
-				pending++;
-			} else {
-				errno = EINVAL;
-				return error("PeekNamedPipe failed,"
-					" GetLastError: %u", err);
-			}
-		} else if (avail) {
-			ufds[i].revents = POLLIN;
-			pending++;
-		} else
-			ufds[i].revents = 0;
-	}
-	if (!pending) {
-		/* The only times that we spin here is when the process
-		 * that is connected through the pipes is waiting for
-		 * its own input data to become available. But since
-		 * the process (pack-objects) is itself CPU intensive,
-		 * it will happily pick up the time slice that we are
-		 * relinquishing here.
-		 */
-		Sleep(0);
-		goto repeat;
-	}
-	return 0;
-}
-
 struct tm *gmtime_r(const time_t *timep, struct tm *result)
 {
 	/* gmtime() in MSVCRT.DLL is thread-safe, but not reentrant */
diff --git a/compat/mingw.h b/compat/mingw.h
index 2218043..aed49d8 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -72,16 +72,6 @@ struct passwd {
 
 extern char *getpass(const char *prompt);
 
-#ifndef POLLIN
-struct pollfd {
-	int fd;           /* file descriptor */
-	short events;     /* requested events */
-	short revents;    /* returned events */
-};
-#define POLLIN 1
-#define POLLHUP 2
-#endif
-
 typedef void (__cdecl *sig_handler_t)(int);
 struct sigaction {
 	sig_handler_t sa_handler;
@@ -188,7 +178,6 @@ int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
 int mkstemp(char *template);
 int gettimeofday(struct timeval *tv, void *tz);
-int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 struct tm *localtime_r(const time_t *timep, struct tm *result);
 int getpagesize(void);	/* defined in MinGW's libgcc.a */
diff --git a/compat/win32/poll.c b/compat/win32/poll.c
index 7c52cb6..c1ca0d2 100644
--- a/compat/win32/poll.c
+++ b/compat/win32/poll.c
@@ -24,8 +24,7 @@
 # pragma GCC diagnostic ignored "-Wtype-limits"
 #endif
 
-#include <config.h>
-#include <alloca.h>
+#include <malloc.h>
 
 #include <sys/types.h>
 #include "poll.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 100197f..f16a092 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -82,6 +82,7 @@
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+#include "compat/win32/poll.h"
 #endif
 
 #include <unistd.h>
-- 
1.7.3.1.51.ge462f.dirty

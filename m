From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 05:10:43 -0500
Message-ID: <20100527101043.GA4390@progeny.tock>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
 <1274948384-167-2-git-send-email-abcd@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mduft@gentoo.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Callen <abcd@gentoo.org>
X-From: git-owner@vger.kernel.org Thu May 27 12:10:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHa34-0001W0-GJ
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 12:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab0E0KKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 06:10:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59491 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010Ab0E0KKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 06:10:39 -0400
Received: by gyg13 with SMTP id 13so3812086gyg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PGQu2sWj1TaimiMMOQN2u3qPwwNwEcnzDteZlI5h0O4=;
        b=JSqcHsk9MxWI1p2PKtsadN45v8ws491EmwjbfsjqVSdpNarRdg6EeW4ZOAnZLpQBKL
         qtiZIvaU2Ah8XCrAddvL+oP2YNrSGluz1dejamPbMVDnTBOor2qzH2rPAAOC4Z1rwR+0
         EEjfY47DW8NT2UEGZGQD/hYHfFqFcROUaYi7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sUGt92U+RSikr9Q/DqaICa9t5pQT2IZobbWDc99oJTRv1X7JQ1H2Qk5AeajK0RxcEB
         ZNYT1qQzzYnnLIVTB6MBocyQwmKwvvgI88fV4j4IIQ20GLe2Hhs1J+PWCObF9nxpQjsx
         37mjA/apaw+2Z6ZMlm4sFYD8l/wK1AsRsxnZY=
Received: by 10.231.183.19 with SMTP id ce19mr2083568ibb.35.1274955038155;
        Thu, 27 May 2010 03:10:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm4861166ibi.2.2010.05.27.03.10.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 03:10:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274948384-167-2-git-send-email-abcd@gentoo.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147842>

Implement the subset of poll() semantics needed by git in terms of
select(), for use by the Interix port.  Inspired by commit 6ed807f
(Windows: A rudimentary poll() emulation, 2007-12-01).

Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Jonathan Callen <abcd@gentoo.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Callen wrote:

> Some systems do not have sys/poll.h or poll(2).

Maybe this could help.  Thanks to DrNick on IRC for the suggestion.

Warning: untested.

 Makefile          |    8 ++++++++
 compat/poll.c     |   33 +++++++++++++++++++++++++++++++++
 compat/poll.h     |   13 +++++++++++++
 git-compat-util.h |    6 +++++-
 4 files changed, 59 insertions(+), 1 deletions(-)
 create mode 100644 compat/poll.c
 create mode 100644 compat/poll.h

diff --git a/Makefile b/Makefile
index 2f5d631..6715528 100644
--- a/Makefile
+++ b/Makefile
@@ -111,6 +111,9 @@ all::
 #
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
+# Define NO_POLL if you have a problem with the poll() system call (e.g.
+# Interix).
+#
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
@@ -470,6 +473,7 @@ LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
+LIB_H += compat/poll.h
 LIB_H += compat/win32/pthread.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
@@ -1284,6 +1288,10 @@ endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
+ifdef NO_POLL
+	BASIC_CFLAGS += -DNO_POLL
+	COMPAT_OBJS += compat/poll.o
+endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
diff --git a/compat/poll.c b/compat/poll.c
new file mode 100644
index 0000000..33c6ae0
--- /dev/null
+++ b/compat/poll.c
@@ -0,0 +1,33 @@
+#include "../git-compat-util.h"
+
+int git_poll(struct git_pollfd *ufds, int nfds, int timeout)
+{
+	int i, maxfd, result;
+	fd_set fds;
+
+	if (timeout >= 0) {
+		if (nfds == 0) {
+			sleep(timeout);
+			return 0;
+		}
+		return errno = EINVAL, error("poll timeout not supported");
+	}
+
+	FD_ZERO(&fds);
+	maxfd = 0;
+	for (i = 0; i < nfds; i++) {
+		if (ufds[i].events != POLLIN)
+			return errno = EINVAL, error("poll: unsupported events");
+		maxfd = (ufds[i].fd > maxfd) ? ufds[i].fd : maxfd;
+		FD_SET(ufds[i].fd, &fds);
+	}
+
+	result = select(maxfd + 1, &fds, NULL, NULL, NULL);
+	if (result == -1)
+		return result;
+	for (i = 0; i < nfds; i++) {
+		if (FD_ISSET(ufds[i].fd, &fds))
+			ufds[i].revents |= POLLIN;
+	}
+	return result;
+}
diff --git a/compat/poll.h b/compat/poll.h
new file mode 100644
index 0000000..65775ab
--- /dev/null
+++ b/compat/poll.h
@@ -0,0 +1,13 @@
+#ifndef POLLIN
+#define POLLIN 1
+#define POLLHUP 2
+#endif
+
+#define pollfd git_pollfd
+#define poll git_poll
+struct git_pollfd {
+	int fd;		/* file descriptor */
+	short events;	/* requested events */
+	short revents;	/* returned events */
+};
+extern int git_poll(struct git_pollfd *fds, int nfds, int timeout);
diff --git a/git-compat-util.h b/git-compat-util.h
index 824c175..2494378 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -94,13 +94,17 @@
 #include <utime.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
-#include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
 #endif
+#ifdef NO_POLL
+#include "compat/poll.h"
+#else
+#include <sys/poll.h>
+#endif
 #include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <arpa/inet.h>
-- 
1.7.1

From: Shawn Landden <shawn@churchofgit.com>
Subject: [PATCH] systemd socket activation support
Date: Wed,  1 Apr 2015 23:09:11 -0700
Message-ID: <1427954951-17649-1-git-send-email-shawn@churchofgit.com>
Cc: Shawn Landden <shawnlandden@gmail.com>,
	Shawn Landden <shawn@churchofgit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 08:09:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdYK5-0007JB-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 08:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbbDBGJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 02:09:44 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35798 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbDBGJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 02:09:43 -0400
Received: by pddn5 with SMTP id n5so79206814pdd.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=nlnWfdt0SM3LJ78dsfWuo0ArZL9zDxAKYheBNXwKI0o=;
        b=DykNRWIZ6jiNrc9fDGINP9V5UxG5ZDwnLGgJVFkdg8IvlV0yz/PR6wQhrUBpn/9zmx
         B9Wh5nu6Ylualx1znN1fLcj0zH2zXN/ksjThtHXWDSwXQEHbhfttrUXvDcS/wAMWeMAq
         Dl9DQtMcOjPg7fSxS0J8bVeVjG5AxlVuKAKJXMNzu5EB5MTTNXC4BICydTTt0FlXdOPT
         b/crq2Bqsb+6KRxc//N9ElV/0emSJ7MAk803Eku5n1IJpe17h4MEh7wmX6LdtML64Wzc
         lfuOlBXDIJPwJkPxhfKzfmxU1lyQaF0mNR8QmqjbVcrwS49rufqw46j/qdEMOjbvwN9v
         nfXg==
X-Received: by 10.70.91.37 with SMTP id cb5mr2309434pdb.151.1427954983313;
        Wed, 01 Apr 2015 23:09:43 -0700 (PDT)
Received: from zephyr.churchofgit.com (c-73-42-216-173.hsd1.wa.comcast.net. [73.42.216.173])
        by mx.google.com with ESMTPSA id nn6sm3718438pdb.79.2015.04.01.23.09.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Apr 2015 23:09:42 -0700 (PDT)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266632>

From: Shawn Landden <shawnlandden@gmail.com>

v1.1: actually test...

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
 daemon.c           |  35 +++++++++++---
 git-daemon.service |   7 +++
 git-daemon.socket  |   9 ++++
 sd-daemon.c        | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 sd-daemon.h        |  91 ++++++++++++++++++++++++++++++++++++
 5 files changed, 268 insertions(+), 6 deletions(-)
 create mode 100644 git-daemon.service
 create mode 100644 git-daemon.socket
 create mode 100644 sd-daemon.c
 create mode 100644 sd-daemon.h

diff --git a/daemon.c b/daemon.c
index 9ee2187..4677058 100644
--- a/daemon.c
+++ b/daemon.c
@@ -5,6 +5,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 
+#include "sd-daemon.c"
+
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
@@ -29,6 +31,7 @@ static const char daemon_usage[] =
 "           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
+"           [--systemd]\n"
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
@@ -1176,11 +1179,21 @@ static void store_pid(const char *path)
 }
 
 static int serve(struct string_list *listen_addr, int listen_port,
-    struct credentials *cred)
+    struct credentials *cred, int systemd_mode)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
+	int i;
+	int n;
+
+	if (systemd_mode) {
+		n = sd_listen_fds(0);
+		ALLOC_GROW(socklist.list, socklist.nr + n, socklist.alloc);
+		for (i = 0; i < n; i++)
+			socklist.list[socklist.nr++] = SD_LISTEN_FDS_START + i;
+	}
 
-	socksetup(listen_addr, listen_port, &socklist);
+	if (listen_addr->nr > 0 || !systemd_mode)
+		socksetup(listen_addr, listen_port, &socklist);
 	if (socklist.nr == 0)
 		die("unable to allocate any listen sockets on port %u",
 		    listen_port);
@@ -1196,7 +1209,7 @@ int main(int argc, char **argv)
 {
 	int listen_port = 0;
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
-	int serve_mode = 0, inetd_mode = 0;
+	int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct credentials *cred = NULL;
@@ -1331,6 +1344,10 @@ int main(int argc, char **argv)
 			informative_errors = 0;
 			continue;
 		}
+		if (!strcmp(arg, "--systemd")) {
+			systemd_mode = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -1349,14 +1366,20 @@ int main(int argc, char **argv)
 		/* avoid splitting a message in the middle */
 		setvbuf(stderr, NULL, _IOFBF, 4096);
 
-	if (inetd_mode && (detach || group_name || user_name))
-		die("--detach, --user and --group are incompatible with --inetd");
+	if ((inetd_mode || systemd_mode) && (detach || group_name || user_name))
+		die("--detach, --user and --group are incompatible with --inetd and --systemd");
+
+	if (systemd_mode && inetd_mode)
+		die("--inetd is incompatible with --systemd");
 
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
 	else if (listen_port == 0)
 		listen_port = DEFAULT_GIT_PORT;
 
+	if (systemd_mode && !sd_booted())
+		die("--systemd passed and not running from systemd");
+
 	if (group_name && !user_name)
 		die("--group supplied without --user");
 
@@ -1395,5 +1418,5 @@ int main(int argc, char **argv)
 		cld_argv[i+1] = argv[i];
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, cred);
+	return serve(&listen_addr, listen_port, cred, systemd_mode);
 }
diff --git a/git-daemon.service b/git-daemon.service
new file mode 100644
index 0000000..b0c99f3
--- /dev/null
+++ b/git-daemon.service
@@ -0,0 +1,7 @@
+[Unit]
+Description=Git Daemon
+
+[Service]
+ExecStart=/usr/lib/git-core/git-daemon --systemd --reuseaddr --base-path=/var/lib /var/lib/git
+User=gitdaemon
+
diff --git a/git-daemon.socket b/git-daemon.socket
new file mode 100644
index 0000000..b3dd981
--- /dev/null
+++ b/git-daemon.socket
@@ -0,0 +1,9 @@
+[Unit]
+Description=Git Daemon socket
+
+[Socket]
+ListenStream=9418
+
+[Install]
+WantedBy=sockets.target
+
diff --git a/sd-daemon.c b/sd-daemon.c
new file mode 100644
index 0000000..653fbf5
--- /dev/null
+++ b/sd-daemon.c
@@ -0,0 +1,132 @@
+/* stripped down version */
+/***
+  Copyright 2010 Lennart Poettering
+
+  Permission is hereby granted, free of charge, to any person
+  obtaining a copy of this software and associated documentation files
+  (the "Software"), to deal in the Software without restriction,
+  including without limitation the rights to use, copy, modify, merge,
+  publish, distribute, sublicense, and/or sell copies of the Software,
+  and to permit persons to whom the Software is furnished to do so,
+  subject to the following conditions:
+
+  The above copyright notice and this permission notice shall be
+  included in all copies or substantial portions of the Software.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+***/
+
+#ifndef _GNU_SOURCE
+#  define _GNU_SOURCE
+#endif
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include "sd-daemon.h"
+
+#if (__GNUC__ >= 4)
+#  ifdef SD_EXPORT_SYMBOLS
+/* Export symbols */
+#    define _sd_export_ __attribute__ ((visibility("default")))
+#  else
+/* Don't export the symbols */
+#    define _sd_export_ __attribute__ ((visibility("hidden")))
+#  endif
+#else
+#  define _sd_export_
+#endif
+
+_sd_export_ int sd_listen_fds(int unset_environment) {
+
+#if defined(DISABLE_SYSTEMD) || !defined(__linux__)
+        return 0;
+#else
+        int r, fd;
+        const char *e;
+        char *p = NULL;
+        unsigned long l;
+
+        e = getenv("LISTEN_PID");
+        if (!e) {
+                r = 0;
+                goto finish;
+        }
+
+        errno = 0;
+        l = strtoul(e, &p, 10);
+
+        if (errno > 0) {
+                r = -errno;
+                goto finish;
+        }
+
+        if (!p || p == e || *p || l <= 0) {
+                r = -EINVAL;
+                goto finish;
+        }
+
+        /* Is this for us? */
+        if (getpid() != (pid_t) l) {
+                r = 0;
+                goto finish;
+        }
+
+        e = getenv("LISTEN_FDS");
+        if (!e) {
+                r = 0;
+                goto finish;
+        }
+
+        errno = 0;
+        l = strtoul(e, &p, 10);
+
+        if (errno > 0) {
+                r = -errno;
+                goto finish;
+        }
+
+        if (!p || p == e || *p) {
+                r = -EINVAL;
+                goto finish;
+        }
+
+        for (fd = SD_LISTEN_FDS_START; fd < SD_LISTEN_FDS_START + (int) l; fd ++) {
+                int flags;
+
+                flags = fcntl(fd, F_GETFD);
+                if (flags < 0) {
+                        r = -errno;
+                        goto finish;
+                }
+
+                if (flags & FD_CLOEXEC)
+                        continue;
+
+                if (fcntl(fd, F_SETFD, flags | FD_CLOEXEC) < 0) {
+                        r = -errno;
+                        goto finish;
+                }
+        }
+
+        r = (int) l;
+
+finish:
+        if (unset_environment) {
+                unsetenv("LISTEN_PID");
+                unsetenv("LISTEN_FDS");
+        }
+
+        return r;
+#endif
+}
+
diff --git a/sd-daemon.h b/sd-daemon.h
new file mode 100644
index 0000000..f6f2959
--- /dev/null
+++ b/sd-daemon.h
@@ -0,0 +1,91 @@
+/* stripped down version */
+
+#ifndef foosddaemonhfoo
+#define foosddaemonhfoo
+
+/***
+  Copyright 2010 Lennart Poettering
+
+  Permission is hereby granted, free of charge, to any person
+  obtaining a copy of this software and associated documentation files
+  (the "Software"), to deal in the Software without restriction,
+  including without limitation the rights to use, copy, modify, merge,
+  publish, distribute, sublicense, and/or sell copies of the Software,
+  and to permit persons to whom the Software is furnished to do so,
+  subject to the following conditions:
+
+  The above copyright notice and this permission notice shall be
+  included in all copies or substantial portions of the Software.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+***/
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+  Reference implementation of a few systemd related interfaces for
+  writing daemons. These interfaces are trivial to implement. To
+  simplify porting we provide this reference implementation.
+  Applications are welcome to reimplement the algorithms described
+  here if they do not want to include these two source files.
+
+  The following functionality is provided:
+
+  - Support for logging with log levels on stderr
+  - File descriptor passing for socket-based activation
+  - Daemon startup and status notification
+  - Detection of systemd boots
+
+  You may compile this with -DDISABLE_SYSTEMD to disable systemd
+  support. This makes all those calls NOPs that are directly related to
+  systemd (i.e. only sd_is_xxx() will stay useful).
+
+  Since this is drop-in code we don't want any of our symbols to be
+  exported in any case. Hence we declare hidden visibility for all of
+  them.
+
+  You may find an up-to-date version of these source files online:
+
+  http://cgit.freedesktop.org/systemd/systemd/plain/src/systemd/sd-daemon.h
+  http://cgit.freedesktop.org/systemd/systemd/plain/src/libsystemd-daemon/sd-daemon.c
+
+  This should compile on non-Linux systems, too, but with the
+  exception of the sd_is_xxx() calls all functions will become NOPs.
+
+  See sd-daemon(3) for more information.
+*/
+
+/* The first passed file descriptor is fd 3 */
+#define SD_LISTEN_FDS_START 3
+
+/*
+  Returns how many file descriptors have been passed, or a negative
+  errno code on failure. Optionally, removes the $LISTEN_FDS and
+  $LISTEN_PID file descriptors from the environment (recommended, but
+  problematic in threaded environments). If r is the return value of
+  this function you'll find the file descriptors passed as fds
+  SD_LISTEN_FDS_START to SD_LISTEN_FDS_START+r-1. Returns a negative
+  errno style error code on failure. This function call ensures that
+  the FD_CLOEXEC flag is set for the passed file descriptors, to make
+  sure they are not passed on to child processes. If FD_CLOEXEC shall
+  not be set, the caller needs to unset it after this call for all file
+  descriptors that are used.
+
+  See sd_listen_fds(3) for more information.
+*/
+int sd_listen_fds(int unset_environment);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.2.1.209.g41e5f3a

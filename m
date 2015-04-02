From: Shawn Landden <shawn@churchofgit.com>
Subject: [RFC 2] systemd socket activation support
Date: Thu,  2 Apr 2015 09:15:10 -0700
Message-ID: <1427991310-19754-1-git-send-email-shawn@churchofgit.com>
Cc: Shawn Landden <shawn@churchofgit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 18:15:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdhmD-0003Bn-9A
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 18:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbbDBQPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 12:15:22 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35024 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbbDBQPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 12:15:20 -0400
Received: by patj18 with SMTP id j18so88604019pat.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MI4hXjSEW0TJpQPjIg6wWFpA85/v1a7a/OKgVDbeEOM=;
        b=kyJlAjFU+LRCHFBVcLn3Qd3Xpb9MkQBGs7E7s4bpDolUHaVkFsLB4ZbAOezeeOOdR4
         1wodvSXa5fHalfVbpLpJZPzOOjy+3HwstZr+pZsWYM7VGXWNk0cefxl2uGhK0250Ux6j
         VhjUNrHLxnOGhJO2oc5G/s7Y/0cuaNjdjQfu5Jz1xeEo90s6ucq5AUryYM8r5EESnnbq
         1bukIjIRWK5Gm2UDe8uGZR0QVY/oA57UkBdZRpg6kr183rEU59ad/BvkRLC7HV8hDfhj
         DIDb+RqcIoFlW7K6kYPWHQ9RP1IZaAb4lCbiKt/FlcZ4ToDLaFxanP3IRMFNoVeq8Izm
         sHcg==
X-Received: by 10.70.131.38 with SMTP id oj6mr89189094pdb.150.1427991320082;
        Thu, 02 Apr 2015 09:15:20 -0700 (PDT)
Received: from zephyr.churchofgit.com (c-73-42-216-173.hsd1.wa.comcast.net. [73.42.216.173])
        by mx.google.com with ESMTPSA id xj1sm5623552pbb.92.2015.04.02.09.15.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 09:15:18 -0700 (PDT)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266646>

systemd support git-daemon's --inetd mode as well.

v2: actually test...

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
 Documentation/git-daemon.txt |  25 +++++++
 Makefile                     |   1 +
 daemon.c                     |  35 ++++++++--
 sd-daemon.c                  | 152 +++++++++++++++++++++++++++++++++++++++++++
 sd-daemon.h                  | 104 +++++++++++++++++++++++++++++
 5 files changed, 311 insertions(+), 6 deletions(-)
 create mode 100644 sd-daemon.c
 create mode 100644 sd-daemon.h

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a69b361..898e01f 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 	     [--inetd |
 	      [--listen=<host_or_ipaddr>] [--port=<n>]
 	      [--user=<user> [--group=<group>]]]
+	      [--systemd]
 	     [<directory>...]
 
 DESCRIPTION
@@ -190,6 +191,12 @@ Git configuration files in that directory are readable by `<user>`.
 	exiting with a zero status).  It can also look at the $REMOTE_ADDR
 	and $REMOTE_PORT environment variables to learn about the
 	requestor when making this decision.
+--systemd::
+	For running git-daemon under systemd(1) which will pass
+	an open connection. This is similar to --inetd, except
+	that more than one address/port can be listened to at once
+	both through systemd and through --listen, and git-daemon doesn't get
+	invoked for every connection. For more details see systemd.socket(5).
 +
 The external command can optionally write a single line to its
 standard output to be sent to the requestor as an error message when
@@ -304,7 +311,25 @@ selectively enable/disable services per repository::
 		uploadpack = false
 		uploadarch = true
 ----------------------------------------------------------------
++
+systemd configuration example:
+
+# /etc/systemd/system/git-daemon.socket
+[Unit]
+Description=Git Daemon socket
+
+[Socket]
+ListenStream=9418
+
+[Install]
+WantedBy=sockets.target
+# /etc/systemd/system/git-daemon.service
+[Unit]
+Description=Git Daemon
 
+[Service]
+ExecStart=/usr/lib/git-core/git-daemon --systemd --reuseaddr --base-path=/var/lib /var/lib/git
+User=gitdaemon
 
 ENVIRONMENT
 -----------
diff --git a/Makefile b/Makefile
index 5f3987f..4a813b9 100644
--- a/Makefile
+++ b/Makefile
@@ -765,6 +765,7 @@ LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
+LIB_OBJS += sd-daemon.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
 LIB_OBJS += server-info.o
diff --git a/daemon.c b/daemon.c
index 9ee2187..e809a4c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,6 +4,7 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "sd-daemon.h"
 
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
@@ -29,6 +30,7 @@ static const char daemon_usage[] =
 "           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
+"           [--systemd]\n"
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
@@ -1176,11 +1178,22 @@ static void store_pid(const char *path)
 }
 
 static int serve(struct string_list *listen_addr, int listen_port,
-    struct credentials *cred)
+    struct credentials *cred, int systemd_mode)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
-	socksetup(listen_addr, listen_port, &socklist);
+	if (systemd_mode) {
+		int i;
+		int n;
+
+		n = sd_listen_fds(0);
+		ALLOC_GROW(socklist.list, socklist.nr + n, socklist.alloc);
+		for (i = 0; i < n; i++)
+			socklist.list[socklist.nr++] = SD_LISTEN_FDS_START + i;
+	}
+
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
+		die("--systemd passed and not invoked from systemd");
+
 	if (group_name && !user_name)
 		die("--group supplied without --user");
 
@@ -1395,5 +1418,5 @@ int main(int argc, char **argv)
 		cld_argv[i+1] = argv[i];
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, cred);
+	return serve(&listen_addr, listen_port, cred, systemd_mode);
 }
diff --git a/sd-daemon.c b/sd-daemon.c
new file mode 100644
index 0000000..1d43904
--- /dev/null
+++ b/sd-daemon.c
@@ -0,0 +1,152 @@
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
+#include <sys/types.h>
+#include <sys/stat.h>
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
+_sd_export_ int sd_booted(void) {
+
+#if defined(DISABLE_SYSTEMD) || !defined(__linux__)
+        return 0;
+#else
+        struct stat st;
+
+        /* We test whether the runtime unit file directory has been
+         * created. This takes place in mount-setup.c, so is
+         * guaranteed to happen very early during boot. */
+
+        if (lstat("/run/systemd/system/", &st) < 0)
+                return 0;
+
+        return !!S_ISDIR(st.st_mode);
+#endif
+}
+
diff --git a/sd-daemon.h b/sd-daemon.h
new file mode 100644
index 0000000..e297955
--- /dev/null
+++ b/sd-daemon.h
@@ -0,0 +1,104 @@
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
+/*
+  Returns > 0 if the system was booted with systemd. Returns < 0 on
+  error. Returns 0 if the system was not booted with systemd. Note
+  that all of the functions above handle non-systemd boots just
+  fine. You should NOT protect them with a call to this function. Also
+  note that this function checks whether the system, not the user
+  session is controlled by systemd. However the functions above work
+  for both user and system services.
+
+  See sd_booted(3) for more information.
+*/
+int sd_booted(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.2.1.209.g41e5f3a

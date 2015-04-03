From: Shawn Landden <shawn@churchofgit.com>
Subject: [v3RFC] systemd socket activation support
Date: Fri,  3 Apr 2015 15:30:24 -0700
Message-ID: <1428100224-29441-1-git-send-email-shawn@churchofgit.com>
Cc: Shawn Landden <shawn@churchofgit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 00:30:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeA6q-0002jQ-1W
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbbDCWad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:30:33 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34936 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbDCWab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:30:31 -0400
Received: by patj18 with SMTP id j18so128700780pat.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=mWLML2Aipzg9XIxSZA7E9ul6H+lPKQsR/eNrO3Hn/Ng=;
        b=fJZz5iE72AlObWZIWKh4sDOJvgoqIAxI8//eGO+x9jKXCOxTcuSU7/E8JAgukMQ/Jq
         nh4PBFafnR+VtZangx9+Qr6Y2gXnVAzfH5Gqt/+ru3vc0Sg+6tn8lzYeRatZBPRRRcuV
         SXl9+mXO0d8gnYBnf4T3EwePhyCQmq+WNBNzncgR1A+JKQBgZlcv29qlc+xIp5SQ69Qh
         JvwIKR7NN4cAWkcmyLtPVTkObRHRK6yVmwx7IvhsSygaLMYiPvaQdDIsFlJ8w+sUXoz0
         ARIheFqzdOgw92VSipvJnfwy3kue8x2Gu6uARw5NPqjkpju55kGeEfweNG0IBpRNArnt
         MPmA==
X-Received: by 10.66.122.204 with SMTP id lu12mr7646715pab.52.1428100231323;
        Fri, 03 Apr 2015 15:30:31 -0700 (PDT)
Received: from zephyr.churchofgit.com (c-73-42-216-173.hsd1.wa.comcast.net. [73.42.216.173])
        by mx.google.com with ESMTPSA id dh3sm9071909pdb.69.2015.04.03.15.30.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2015 15:30:30 -0700 (PDT)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266743>

systemd supports git-daemon's existing --inetd mode as well.

v2: actually test...
v3: make optional, switch to libsystemd

shawn@zephyr:~/git/git$ ldd /lib/x86_64-linux-gnu/libsystemd.so.0
	linux-vdso.so.1 (0x00007ffeba7ec000)
	libcap.so.2 => /lib/x86_64-linux-gnu/libcap.so.2 (0x00007fea158fe000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fea155f9000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fea153f0000)
	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007fea151cb000)
	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007fea14fa8000)
	libgcrypt.so.20 => /lib/x86_64-linux-gnu/libgcrypt.so.20 (0x00007fea14cc5000)
	libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007fea14aae000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fea148aa000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fea1468b000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fea142e7000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fea15d5b000)
	libattr.so.1 => /lib/x86_64-linux-gnu/libattr.so.1 (0x00007fea140e2000)
	libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007fea13e73000)
	libgpg-error.so.0 => /lib/x86_64-linux-gnu/libgpg-error.so.0 (0x00007fea13c61000)

ewwwww...and only for two tiny functions.

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
 Documentation/git-daemon.txt | 25 ++++++++++++++++++++++++
 Makefile                     | 14 ++++++++++++--
 daemon.c                     | 46 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 77 insertions(+), 8 deletions(-)

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
index 5f3987f..362af94 100644
--- a/Makefile
+++ b/Makefile
@@ -42,6 +42,9 @@ all::
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports (dumb).
 #
+# Define NO_SYSTEMD to prevent systemd socket activation support from being
+# built into git-daemon.
+#
 # Define EXPATDIR=/foo/bar if your expat header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
@@ -995,6 +998,13 @@ ifeq ($(uname_S),Darwin)
 	PTHREAD_LIBS =
 endif
 
+ifndef NO_SYSTEMD
+	ifeq ($(shell echo "\#include <systemd/sd-daemon.h>" | $(CC) -E - -o /dev/null && echo y),y)
+		BASIC_CFLAGS += -DHAVE_SYSTEMD
+		EXTLIBS += -lsystemd
+	endif
+endif
+
 ifndef CC_LD_DYNPATH
 	ifdef NO_R_TO_GCC_LINKER
 		# Some gcc does not accept and pass -R to the linker to specify
@@ -1403,8 +1413,8 @@ ifdef NATIVE_CRLF
 endif
 
 ifdef USE_NED_ALLOCATOR
-       COMPAT_CFLAGS += -Icompat/nedmalloc
-       COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
+	COMPAT_CFLAGS += -Icompat/nedmalloc
+	COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 endif
 
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
diff --git a/daemon.c b/daemon.c
index 9ee2187..16b9eda 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,3 +1,7 @@
+#ifdef HAVE_SYSTEMD
+#  include <systemd/sd-daemon.h>
+#endif
+
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
@@ -29,6 +33,9 @@ static const char daemon_usage[] =
 "           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
+#ifdef HAVE_SYSTEMD
+"           [--systemd]\n"
+#endif
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
@@ -1176,11 +1183,24 @@ static void store_pid(const char *path)
 }
 
 static int serve(struct string_list *listen_addr, int listen_port,
-    struct credentials *cred)
+    struct credentials *cred, int systemd_mode)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
-	socksetup(listen_addr, listen_port, &socklist);
+#ifdef HAVE_SYSTEMD
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
+#endif
+		socksetup(listen_addr, listen_port, &socklist);
 	if (socklist.nr == 0)
 		die("unable to allocate any listen sockets on port %u",
 		    listen_port);
@@ -1196,7 +1216,7 @@ int main(int argc, char **argv)
 {
 	int listen_port = 0;
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
-	int serve_mode = 0, inetd_mode = 0;
+	int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct credentials *cred = NULL;
@@ -1331,6 +1351,12 @@ int main(int argc, char **argv)
 			informative_errors = 0;
 			continue;
 		}
+#ifdef HAVE_SYSTEMD
+		if (!strcmp(arg, "--systemd")) {
+			systemd_mode = 1;
+			continue;
+		}
+#endif
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -1349,8 +1375,16 @@ int main(int argc, char **argv)
 		/* avoid splitting a message in the middle */
 		setvbuf(stderr, NULL, _IOFBF, 4096);
 
-	if (inetd_mode && (detach || group_name || user_name))
-		die("--detach, --user and --group are incompatible with --inetd");
+	if ((inetd_mode || systemd_mode) && (detach || group_name || user_name))
+		die("--detach, --user and --group are incompatible with --inetd and --systemd");
+
+#ifdef HAVE_SYSTEMD
+	if (systemd_mode && inetd_mode)
+		die("--inetd is incompatible with --systemd");
+
+	if (systemd_mode && !sd_booted())
+		die("--systemd passed and not invoked from systemd");
+#endif
 
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
@@ -1395,5 +1429,5 @@ int main(int argc, char **argv)
 		cld_argv[i+1] = argv[i];
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, cred);
+	return serve(&listen_addr, listen_port, cred, systemd_mode);
 }
-- 
2.2.1.209.g41e5f3a

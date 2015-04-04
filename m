From: Shawn Landden <shawn@churchofgit.com>
Subject: [RFCv4 PATCH] daemon: add systemd support
Date: Fri,  3 Apr 2015 20:19:40 -0700
Message-ID: <1428117580-32289-1-git-send-email-shawn@churchofgit.com>
Cc: Shawn Landden <shawn@churchofgit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 05:19:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeEcl-0007FZ-3u
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 05:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbbDDDTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 23:19:50 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34643 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbDDDTt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 23:19:49 -0400
Received: by pactp5 with SMTP id tp5so134417532pac.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AKDp+Iisx4z36Qu+1kEcZ+kbQ+yG1Pq1XExp/R8fr38=;
        b=qvalQ+PcWD04PiErvrFWfaijXs5kpek97Hnu0BfD/woPJfVf0FRnswf1ZhNialO3cf
         NoZkSOpY1180s52AqjUzAimSpGkwjuGsZTy0MBtgntQgFznlle1/gst2JhUppcX0nvVA
         D+TXmyq5hyd4tvTe5gxwmDwkLE0f4iS31vvdAvHAAeZKH8sIiWV39ivXnVVmEVZ8tCUq
         6O/zA+pyfKHFLgT4snsUto64b3kQRb2oemlCKHSINAOzoMGKBTufIVdZNP5JoHjo9CS0
         +yX8IDmJy/7u9p1tbWtscE76jQT+4vHQMHaZLe41hPCFz0fqwnYl9wAg3ylNzcCTYW9I
         g7Qg==
X-Received: by 10.68.93.194 with SMTP id cw2mr8785597pbb.129.1428117589000;
        Fri, 03 Apr 2015 20:19:49 -0700 (PDT)
Received: from zephyr.churchofgit.com (c-73-42-216-173.hsd1.wa.comcast.net. [73.42.216.173])
        by mx.google.com with ESMTPSA id xt9sm9421410pbc.14.2015.04.03.20.19.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2015 20:19:47 -0700 (PDT)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266758>

systemd supports git-daemon's existing --inetd mode as well.

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
 Documentation/git-daemon.txt | 41 +++++++++++++++++++++++++++++++++++-----
 Makefile                     | 14 ++++++++++++--
 daemon.c                     | 45 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 87 insertions(+), 13 deletions(-)

Respond to review in http://article.gmane.org/gmane.comp.version-control.git/266650
I did not indent the example documents as that was for inetd, and that would break copy/paste.

These are all documentation changes, no functional differences. (Well, the example
gained StandardError=null to match --inetd)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a69b361..a273565 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	     [--allow-override=<service>] [--forbid-override=<service>]
 	     [--access-hook=<path>] [--[no-]informative-errors]
 	     [--inetd |
-	      [--listen=<host_or_ipaddr>] [--port=<n>]
+	      [--listen=<host_or_ipaddr>] [--port=<n>] [--systemd]
 	      [--user=<user> [--group=<group>]]]
 	     [<directory>...]
 
@@ -81,8 +81,8 @@ OPTIONS
 
 --inetd::
 	Have the server run as an inetd service. Implies --syslog.
-	Incompatible with --detach, --port, --listen, --user and --group
-	options.
+	Incompatible with --systemd, --detach, --port, --listen, --user and
+	--group options.
 
 --listen=<host_or_ipaddr>::
 	Listen on a specific IP address or hostname.  IP addresses can
@@ -146,8 +146,8 @@ OPTIONS
 	the option are given to `getpwnam(3)` and `getgrnam(3)`
 	and numeric IDs are not supported.
 +
-Giving these options is an error when used with `--inetd`; use
-the facility of inet daemon to achieve the same before spawning
+Giving these options is an error when used with `--inetd` or `--systemd`; use
+the facility of systemd or the inet daemon to achieve the same before spawning
 'git daemon' if needed.
 +
 Like many programs that switch user id, the daemon does not reset
@@ -180,6 +180,14 @@ Git configuration files in that directory are readable by `<user>`.
 	errors are not enabled, all errors report "access denied" to the
 	client. The default is --no-informative-errors.
 
+--systemd::
+	For running git-daemon under systemd(1) which will pass
+	an open connection. This is similar to --inetd, except
+	that more than one address/port can be listened to at once
+	both through systemd and through --listen, and git-daemon doesn't get
+	invoked for every connection. For more details see systemd.socket(5).
+	Incompatible with --inetd, --detach, --user and --group options.
+
 --access-hook=<path>::
 	Every time a client connects, first run an external command
 	specified by the <path> with service name (e.g. "upload-pack"),
@@ -304,7 +312,30 @@ selectively enable/disable services per repository::
 		uploadpack = false
 		uploadarch = true
 ----------------------------------------------------------------
++
+
+systemd configuration example::
++
+----------------------------------------------------------------
+# /etc/systemd/system/git-daemon.socket
+[Unit]
+Description=Git Daemon socket
 
+[Socket]
+ListenStream=9418
+
+[Install]
+WantedBy=sockets.target
+
+# /etc/systemd/system/git-daemon.service
+[Unit]
+Description=Git Daemon
+
+[Service]
+ExecStart=/usr/lib/git-core/git-daemon --systemd --reuseaddr --base-path=/var/lib /var/lib/git
+User=git-daemon
+StandardError=null
+----------------------------------------------------------------
 
 ENVIRONMENT
 -----------
diff --git a/Makefile b/Makefile
index 5f3987f..644db71 100644
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
+        COMPAT_CFLAGS += -Icompat/nedmalloc
+        COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 endif
 
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
diff --git a/daemon.c b/daemon.c
index 9ee2187..ad8a79a 100644
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
@@ -1176,11 +1183,23 @@ static void store_pid(const char *path)
 }
 
 static int serve(struct string_list *listen_addr, int listen_port,
-    struct credentials *cred)
+    struct credentials *cred, int systemd_mode)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
-	socksetup(listen_addr, listen_port, &socklist);
+#ifdef HAVE_SYSTEMD
+	if (systemd_mode) {
+		int i, n;
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
@@ -1196,7 +1215,7 @@ int main(int argc, char **argv)
 {
 	int listen_port = 0;
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
-	int serve_mode = 0, inetd_mode = 0;
+	int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct credentials *cred = NULL;
@@ -1331,6 +1350,12 @@ int main(int argc, char **argv)
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
@@ -1349,8 +1374,16 @@ int main(int argc, char **argv)
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
@@ -1395,5 +1428,5 @@ int main(int argc, char **argv)
 		cld_argv[i+1] = argv[i];
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, cred);
+	return serve(&listen_addr, listen_port, cred, systemd_mode);
 }
-- 
2.2.1.209.g41e5f3a

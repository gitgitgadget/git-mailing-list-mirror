From: Shawn Landden <shawn@churchofgit.com>
Subject: [v7 PATCH] daemon: add systemd support
Date: Wed,  8 Apr 2015 12:14:51 -0700
Message-ID: <1428520491-74980-1-git-send-email-shawn@churchofgit.com>
References: <CABPQNSa-45ZsUX54Ym3dQa+HU63abcQ9O3v8maRe9e_-38Ef+Q@mail.gmail.com>
Cc: Shawn Landden <shawn@churchofgit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 21:15:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfvRJ-0006TY-VA
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 21:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbbDHTPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 15:15:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34553 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbbDHTO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 15:14:59 -0400
Received: by pacyx8 with SMTP id yx8so123375880pac.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42Hq1RXVevV7wKix2jA0Kt0WrAy6w9yVSIEN/q5k1J8=;
        b=0sSk175s/GV+7mbXEyDfy+IEYi4YlHau67veIzxf4IQ6NyMn/aqFqg2akJydsSIc/k
         3E/ozDyjjFpNGwrifGWVgiu+65DbKXibfCdmTlHAyhbgPNcBCR8RTw+lFgQZkq6+G2QI
         P0PXIaxs+aAtJfFzg2a6VRyfuFnT8O4krYqgZHo8uq2QKh1t9NOiGLMUT6xxb0nLLteT
         rOHnAMN8mGZ0DWVWhBIVYFiXsvUe9p5EeVpFxKlaRZZEcH/N1+tFA9jDLu51fzPgxiyO
         1Z5m5oOeM9glv9Onrj3tZyk8/dCqNqmQ3C1Vu3Aw6Rnvec74xKv6KF9q9oLvzzM01cdF
         qUUQ==
X-Received: by 10.68.135.4 with SMTP id po4mr9796624pbb.12.1428520498667;
        Wed, 08 Apr 2015 12:14:58 -0700 (PDT)
Received: from zephyr.hsd1.wa.comcast.net (c-67-161-116-247.hsd1.wa.comcast.net. [67.161.116.247])
        by mx.google.com with ESMTPSA id c1sm12077462pdc.45.2015.04.08.12.14.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Apr 2015 12:14:57 -0700 (PDT)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <CABPQNSa-45ZsUX54Ym3dQa+HU63abcQ9O3v8maRe9e_-38Ef+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266969>

git-daemon's --systemd mode allows git-daemon to be connect-activated
on one or more addresses or ports. Unlike --inetd[1], git-daemon is
not spawned for every connection.

[1]which systemd is compatible with using its Accept=yes mode

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
Repond to Eric Sunshine's review of v6
More documentation.
 Documentation/git-daemon.txt | 49 +++++++++++++++++++++++++++++++++++++++-----
 Makefile                     | 10 +++++++++
 daemon.c                     | 46 +++++++++++++++++++++++++++++++++++------
 3 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a69b361..0eab51b 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -19,7 +19,8 @@ SYNOPSIS
 	     [--access-hook=<path>] [--[no-]informative-errors]
 	     [--inetd |
 	      [--listen=<host_or_ipaddr>] [--port=<n>]
-	      [--user=<user> [--group=<group>]]]
+	      [--systemd |
+	       [--user=<user> [--group=<group>]]]
 	     [<directory>...]
 
 DESCRIPTION
@@ -81,8 +82,8 @@ OPTIONS
 
 --inetd::
 	Have the server run as an inetd service. Implies --syslog.
-	Incompatible with --detach, --port, --listen, --user and --group
-	options.
+	Incompatible with --systemd, --detach, --port, --listen, --user and
+	--group options.
 
 --listen=<host_or_ipaddr>::
 	Listen on a specific IP address or hostname.  IP addresses can
@@ -146,8 +147,8 @@ OPTIONS
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
@@ -180,6 +181,16 @@ Git configuration files in that directory are readable by `<user>`.
 	errors are not enabled, all errors report "access denied" to the
 	client. The default is --no-informative-errors.
 
+--systemd::
+	For running git-daemon under systemd(1) which will pass
+	an open connection. This is similar to --inetd, except
+	that more than one address/port can be listened to at once
+	both through systemd and through --listen/--port, and git-daemon
+	doesn't get invoked for every connection, but only the first.
+	For more details see systemd.socket(5). Incompatible with
+	--inetd, --detach, --user and --group options.
+	Works with the session manager (systemd --user) too.
+
 --access-hook=<path>::
 	Every time a client connects, first run an external command
 	specified by the <path> with service name (e.g. "upload-pack"),
@@ -305,6 +316,34 @@ selectively enable/disable services per repository::
 		uploadarch = true
 ----------------------------------------------------------------
 
+systemd configuration example::
+Example systemd configuration files, typically placed in `/etc/systemd/system`
+or `$HOME/.config/systemd/user`.
++
+`git-daemon.socket`
++
+----------------------------------------------------------------
+[Unit]
+Description=Git Daemon socket
+
+[Socket]
+ListenStream=9418
+
+[Install]
+WantedBy=sockets.target
+----------------------------------------------------------------
++
+`git-daemon.service`
++
+----------------------------------------------------------------
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
index 5f3987f..415ac21 100644
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
+	ifeq ($(shell echo "\#include <systemd/sd-daemon.h>" | $(CC) -E - -o /dev/null 2>/dev/null && echo y),y)
+		BASIC_CFLAGS += -DHAVE_SYSTEMD
+		EXTLIBS += -lsystemd
+	endif
+endif
+
 ifndef CC_LD_DYNPATH
 	ifdef NO_R_TO_GCC_LINKER
 		# Some gcc does not accept and pass -R to the linker to specify
diff --git a/daemon.c b/daemon.c
index 9ee2187..9880858 100644
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
@@ -28,7 +32,11 @@ static const char daemon_usage[] =
 "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
 "           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
+#ifdef HAVE_SYSTEMD
+"                      [--systemd | [--detach] [--user=<user> [--group=<group>]]]\n" /* exactly 80 characters */
+#else
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
+#endif
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
@@ -1176,11 +1184,23 @@ static void store_pid(const char *path)
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

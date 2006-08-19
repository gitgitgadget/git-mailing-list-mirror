From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 14:27:40 +0200
Message-ID: <1155990772.6591@hammerfest>
X-From: git-owner@vger.kernel.org Sat Aug 19 14:33:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEQ0Z-0007vZ-FU
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 14:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWHSMc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 08:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbWHSMc4
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 08:32:56 -0400
Received: from code-monkey.de ([81.169.170.126]:9484 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S1751743AbWHSMcz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 08:32:55 -0400
Received: from hammerfest (c-180-198-91.bi.dial.de.ignite.net [62.180.198.91])
	by code-monkey.de (Postfix) with ESMTP id CDAB7B428
	for <git@vger.kernel.org>; Sat, 19 Aug 2006 14:32:52 +0200 (CEST)
X-Mailbox-Line: From 0b74140471efe73479ca65dba32e819c132a4062 Mon Sep 17 00:00:00 2001
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25718>

Signed-off-by: Tilman Sauerbeck <tilman@code-monkey.de>
---

 I'm not sure how useful this is. I'd like to start git-daemon as root,
 so it can store it's PID in /var/run, but I don't want it to keep root
 privileges. My git repos are world readable, so for serving them, root
 privileges aren't needed at all.

 What do you think?


 Documentation/git-daemon.txt |    8 +++++++-
 daemon.c                     |   39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 0f7d274..a8d75d9 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
-	     [--reuseaddr] [--detach] [--pid-file=file] [directory...]
+	     [--reuseaddr] [--detach] [--pid-file=file]
+	     [--user=u] [--group=g] [directory...]
 
 DESCRIPTION
 -----------
@@ -93,6 +94,11 @@ OPTIONS
 --pid-file=file::
 	Save the process id in 'file'.
 
+--user=u::
+--group=g::
+	If both options are given, `git-daemon` will change it's uid and gid to
+	the ones of 'u' and 'g' before entering the server loop.
+
 <directory>::
 	A directory to add to the whitelist of allowed directories. Unless
 	--strict-paths is specified this will also include subdirectories
diff --git a/daemon.c b/daemon.c
index 012936f..78658c1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -7,6 +7,8 @@ #include <netdb.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <syslog.h>
+#include <pwd.h>
+#include <grp.h>
 #include "pkt-line.h"
 #include "cache.h"
 #include "exec_cmd.h"
@@ -14,12 +16,15 @@ #include "exec_cmd.h"
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
+static const char *user;
+static const char *group;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
-"           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
+"           [--reuseaddr] [--detach] [--pid-file=file]\n"
+"           [--user=u] [--group=g] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths;
@@ -701,6 +706,24 @@ static void store_pid(const char *path)
 	fclose(f);
 }
 
+static void drop_privileges()
+{
+	struct passwd *p;
+	struct group *g;
+
+	p = getpwnam (user);
+	if (!p)
+		die("user not found - %s", user);
+
+	g = getgrnam (group);
+	if (!g)
+		die("group not found - %s", group);
+
+	if (initgroups (p->pw_name, g->gr_gid) || setgid (g->gr_gid) ||
+	    setuid (p->pw_uid))
+		die("cannot drop privileges");
+}
+
 static int serve(int port)
 {
 	int socknum, *socklist;
@@ -709,6 +732,9 @@ static int serve(int port)
 	if (socknum == 0)
 		die("unable to allocate any listen sockets on port %u", port);
 
+	if (user && group)
+		drop_privileges();
+
 	return service_loop(socknum, socklist);
 }
 
@@ -791,6 +817,14 @@ int main(int argc, char **argv)
 			log_syslog = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--user=", 7)) {
+			user = arg + 7;
+			continue;
+		}
+		if (!strncmp(arg, "--group=", 8)) {
+			group = arg + 8;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -802,6 +836,9 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	if (!user ^ !group)
+		die("either set both user and group or none of them");
+
 	if (log_syslog) {
 		openlog("git-daemon", 0, LOG_DAEMON);
 		set_die_routine(daemon_die);
-- 
1.4.2

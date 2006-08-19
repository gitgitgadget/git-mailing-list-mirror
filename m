From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 14:27:40 +0200
Message-ID: <1156079371.28098@hammerfest>
References: <20060819172533.GB64962@gaz.sfgoth.com>
X-From: git-owner@vger.kernel.org Sun Aug 20 15:09:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEn3f-0006tN-Pg
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 15:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWHTNJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 09:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWHTNJe
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 09:09:34 -0400
Received: from code-monkey.de ([81.169.170.126]:4112 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S1750762AbWHTNJd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 09:09:33 -0400
Received: from hammerfest (c-180-198-10.bi.dial.de.ignite.net [62.180.198.10])
	by code-monkey.de (Postfix) with ESMTP id 5B9E1B428
	for <git@vger.kernel.org>; Sun, 20 Aug 2006 15:09:30 +0200 (CEST)
X-Mailbox-Line: From f905b665e9a3bd5982cfb6002babd148ea4960b7 Mon Sep 17 00:00:00 2001
To: git@vger.kernel.org
In-Reply-To: <20060819172533.GB64962@gaz.sfgoth.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25752>

Signed-off-by: Tilman Sauerbeck <tilman@code-monkey.de>
---

 My idea was to keep the code simple :)

 Anyway, this patch has the code you proposed.

 Documentation/git-daemon.txt |   11 +++++++++-
 daemon.c                     |   45 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 0f7d274..3c1bc85 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
-	     [--reuseaddr] [--detach] [--pid-file=file] [directory...]
+	     [--reuseaddr] [--detach] [--pid-file=file]
+	     [--user=u [--group=g]] [directory...]
 
 DESCRIPTION
 -----------
@@ -93,6 +94,14 @@ OPTIONS
 --pid-file=file::
 	Save the process id in 'file'.
 
+--user=u::
+--group=g::
+	These two options may be used to make `git-daemon` change its uid and
+	gid	before entering the server loop.
+	The uid that's used is the one of 'u'. If `group` is specified,
+	the gid is set to the one of 'g', otherwise, the default gid
+	of 'u' is used.
+
 <directory>::
 	A directory to add to the whitelist of allowed directories. Unless
 	--strict-paths is specified this will also include subdirectories
diff --git a/daemon.c b/daemon.c
index 012936f..70be10f 100644
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
@@ -701,6 +706,30 @@ static void store_pid(const char *path)
 	fclose(f);
 }
 
+static void drop_privileges()
+{
+	struct passwd *p;
+	struct group *g;
+	gid_t gid;
+
+	p = getpwnam (user);
+	if (!p)
+		die("user not found - %s", user);
+
+	if (!group)
+		gid = p->pw_gid;
+	else {
+		g = getgrnam (group);
+		if (!g)
+			die("group not found - %s", group);
+
+		gid = g->gr_gid;
+	}
+
+	if (initgroups (p->pw_name, gid) || setgid (gid) || setuid (p->pw_uid))
+		die("cannot drop privileges");
+}
+
 static int serve(int port)
 {
 	int socknum, *socklist;
@@ -709,6 +738,9 @@ static int serve(int port)
 	if (socknum == 0)
 		die("unable to allocate any listen sockets on port %u", port);
 
+	if (user)
+		drop_privileges();
+
 	return service_loop(socknum, socklist);
 }
 
@@ -791,6 +823,14 @@ int main(int argc, char **argv)
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
@@ -802,6 +842,9 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	if (group && !user)
+		die("--group supplied without --user");
+
 	if (log_syslog) {
 		openlog("git-daemon", 0, LOG_DAEMON);
 		set_die_routine(daemon_die);
-- 
1.4.2

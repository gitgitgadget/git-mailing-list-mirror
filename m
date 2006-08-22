From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: [PATCH] Added support for dropping privileges to git-daemon.
Date: Tue, 22 Aug 2006 19:37:41 +0200
Message-ID: <1156268432.16120@hammerfest>
References: <7vhd05s2b5.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 22 19:40:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFaF1-0007Ae-4C
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 19:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWHVRkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 13:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWHVRkg
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 13:40:36 -0400
Received: from code-monkey.de ([81.169.170.126]:11280 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S1750739AbWHVRkf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 13:40:35 -0400
Received: from hammerfest (c-180-198-86.bi.dial.de.ignite.net [62.180.198.86])
	by code-monkey.de (Postfix) with ESMTP id 479EAB428
	for <git@vger.kernel.org>; Tue, 22 Aug 2006 19:40:31 +0200 (CEST)
X-Mailbox-Line: From ebeb656335bed783ca2183b1a5e49a8263248f70 Mon Sep 17 00:00:00 2001
To: git@vger.kernel.org
In-Reply-To: <7vhd05s2b5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25864>

Signed-off-by: Tilman Sauerbeck <tilman@code-monkey.de>
---

 This one got the changes you proposed.

 Not sure whether the documentation is good enough, I'm not that good at
 writing tech docs in english :(


 Documentation/git-daemon.txt |   18 ++++++++++++++++
 daemon.c                     |   46 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 0f7d274..b591895 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
-	     [--reuseaddr] [--detach] [--pid-file=file] [directory...]
+	     [--reuseaddr] [--detach] [--pid-file=file]
+	     [--user=user [--group=group]] [directory...]
 
 DESCRIPTION
 -----------
@@ -93,6 +94,21 @@ OPTIONS
 --pid-file=file::
 	Save the process id in 'file'.
 
+--user=user::
+--group=group::
+	These two options may be used to make `git-daemon` change its uid and
+	gid	before entering the server loop.
+	The uid that's used is the one of 'user'. If `group` is specified,
+	the gid is set to the one of 'group', otherwise, the default gid
+	of 'user' is used.
+
+	Both `group` and `user` need to be passed as the name of the resp of
+	the group, ie you'll get unexpected results if you pass an uid/a gid.
+
+	Note that you probably don't want to use these options if you run
+	git-daemon in inetd mode, since inetd can do the privilege dropping
+	for you.
+
 <directory>::
 	A directory to add to the whitelist of allowed directories. Unless
 	--strict-paths is specified this will also include subdirectories
diff --git a/daemon.c b/daemon.c
index 012936f..4e94210 100644
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
@@ -19,7 +21,8 @@ static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
-"           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
+"           [--reuseaddr] [--detach] [--pid-file=file]\n"
+"           [--user=user [[--group=group]] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths;
@@ -701,7 +704,7 @@ static void store_pid(const char *path)
 	fclose(f);
 }
 
-static int serve(int port)
+static int serve(int port, struct passwd *pass, gid_t gid)
 {
 	int socknum, *socklist;
 
@@ -709,6 +712,11 @@ static int serve(int port)
 	if (socknum == 0)
 		die("unable to allocate any listen sockets on port %u", port);
 
+	if (pass && gid &&
+	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
+	     setuid(pass->pw_uid)))
+		die("cannot drop privileges");
+
 	return service_loop(socknum, socklist);
 }
 
@@ -716,8 +724,11 @@ int main(int argc, char **argv)
 {
 	int port = DEFAULT_GIT_PORT;
 	int inetd_mode = 0;
-	const char *pid_file = NULL;
+	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
+	struct passwd *pass = NULL;
+	struct group *group;
+	gid_t gid = 0;
 	int i;
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -791,6 +802,14 @@ int main(int argc, char **argv)
 			log_syslog = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--user=", 7)) {
+			user_name = arg + 7;
+			continue;
+		}
+		if (!strncmp(arg, "--group=", 8)) {
+			group_name = arg + 8;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -802,6 +821,25 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	if (group_name && !user_name)
+		die("--group supplied without --user");
+
+	if (user_name) {
+		pass = getpwnam(user_name);
+		if (!pass)
+			die("user not found - %s", user_name);
+
+		if (!group_name)
+			gid = pass->pw_gid;
+		else {
+			group = getgrnam(group_name);
+			if (!group)
+				die("group not found - %s", group_name);
+
+			gid = group->gr_gid;
+		}
+	}
+
 	if (log_syslog) {
 		openlog("git-daemon", 0, LOG_DAEMON);
 		set_die_routine(daemon_die);
@@ -831,5 +869,5 @@ int main(int argc, char **argv)
 	if (pid_file)
 		store_pid(pid_file);
 
-	return serve(port);
+	return serve(port, pass, gid);
 }
-- 
1.4.2

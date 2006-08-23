From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-daemon virtual hosting implementation.
Date: Wed, 23 Aug 2006 20:52:37 +0200
Message-ID: <11563591572194-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 20:53:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFxqF-0005OA-VC
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 20:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWHWSwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 14:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWHWSwk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 14:52:40 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:18089 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S965032AbWHWSwk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 14:52:40 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 0276DD80DA;
	Wed, 23 Aug 2006 20:52:38 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id B7BD53FE07; Wed, 23 Aug 2006 20:52:37 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25923>

just add the hostname in the path when using --base-path and --user-path.
this should be enough for most needs.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Here is a proposal for daemon side virtualhosting support.

 This is quite simple, and just uses the hostname in the path where it looks
 for the git repository. Only works in conjuction of --base-path or
 --user-path btw.

 Documentation/git-daemon.txt |   12 +++++++
 daemon.c                     |   73 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 0f7d274..ab5b232 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -79,6 +79,18 @@ OPTIONS
 	taken as a request to access `path/foo` repository in
 	the home directory of user `alice`.
 
+--use-vhosts::
+	Use git daemon cheap virtual hosting scheme.
++
+Used with --base-path=/foo, it will search the repositories in /foo/HOSTNAME
+instead of /foo - if you try to pull git://git.example.com/hello.git, it will
+search into /foo/git.example.com/hello.git.
++
+When using --user-path the HOSTNAME is appended to the path as well, so for
+--user-path=some/path, request to git://git.example.com/~alice/foo is taken as
+a request to access some/path/git.example.com/foo in the home directory of
+user `alice`.
+
 --verbose::
 	Log details about the incoming connections and requested files.
 
diff --git a/daemon.c b/daemon.c
index 012936f..146482c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -17,7 +17,7 @@ static int reuseaddr;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
+"           [--timeout=n] [--init-timeout=n] [--use-vhosts] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
 
@@ -25,6 +25,8 @@ static const char daemon_usage[] =
 static char **ok_paths;
 static int strict_paths;
 
+static int use_vhosts;
+
 /* If this is set, git-daemon-export-ok is not required */
 static int export_all_trees;
 
@@ -148,7 +150,7 @@ static int avoid_alias(char *p)
 	}
 }
 
-static char *path_ok(char *dir)
+static char *path_ok(char *dir, char *vhost)
 {
 	static char rpath[PATH_MAX];
 	char *path;
@@ -158,6 +160,11 @@ static char *path_ok(char *dir)
 		return NULL;
 	}
 
+	if (use_vhosts && !vhost) {
+		logerror("using virtual hosting, and not host= was specified !");
+		return NULL;
+	}
+
 	if (*dir == '~') {
 		if (!user_path) {
 			logerror("'%s': User-path not allowed", dir);
@@ -174,9 +181,25 @@ static char *path_ok(char *dir)
 				slash = dir + restlen;
 			namlen = slash - dir;
 			restlen -= namlen;
-			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
-			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
-				 namlen, dir, user_path, restlen, slash);
+
+			if (use_vhosts) {
+				loginfo("host <%s>, "
+					"userpath <%s>, request <%s>, "
+					"namlen %d, restlen %d, slash <%s>",
+					vhost,
+					user_path, dir,
+					namlen, restlen, slash);
+				snprintf(rpath, PATH_MAX, "%.*s/%s/%s%.*s",
+					 namlen, dir, user_path, vhost,
+					 restlen, slash);
+			} else {
+				loginfo("userpath <%s>, request <%s>, "
+					"namlen %d, restlen %d, slash <%s>",
+					user_path, dir,
+					namlen, restlen, slash);
+				snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
+					 namlen, dir, user_path, restlen, slash);
+			}
 			dir = rpath;
 		}
 	}
@@ -187,7 +210,11 @@ static char *path_ok(char *dir)
 			return NULL;
 		}
 		else {
-			snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
+			if (use_vhosts) {
+				snprintf(rpath, PATH_MAX, "%s/%s%s", base_path, vhost, dir);
+			} else {
+				snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
+			}
 			dir = rpath;
 		}
 	}
@@ -229,15 +256,19 @@ static char *path_ok(char *dir)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int upload(char *dir)
+static int upload(char *dir, char *vhost)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
 	const char *path;
 
-	loginfo("Request for '%s'", dir);
+	if (vhost) {
+		loginfo("Request for '%s' (host = %s)", dir, vhost);
+	} else {
+		loginfo("Request for '%s'", dir);
+	}
 
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(dir, vhost)))
 		return -1;
 
 	/*
@@ -274,6 +305,7 @@ static int execute(struct sockaddr *addr
 {
 	static char line[1000];
 	int pktlen, len;
+        char *vhost = NULL;
 
 	if (addr) {
 		char addrbuf[256] = "";
@@ -303,15 +335,28 @@ #endif
 	alarm(0);
 
 	len = strlen(line);
-	if (pktlen != len)
+	if (pktlen != len) {
+		int arg_pos = len + 1;
+
 		loginfo("Extended attributes (%d bytes) exist <%.*s>",
 			(int) pktlen - len,
-			(int) pktlen - len, line + len + 1);
+			(int) pktlen - len, line + arg_pos);
+
+		while (arg_pos < pktlen) {
+			int arg_len = strlen(line + arg_pos);
+
+			if (!strncmp("host=", line + arg_pos, 5)) {
+				vhost = line + arg_pos + 5;
+			}
+
+			arg_pos += arg_len + 1;
+		}
+	}
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
 	if (!strncmp("git-upload-pack ", line, 16))
-		return upload(line+16);
+		return upload(line+16, vhost);
 
 	logerror("Protocol error: '%s'", line);
 	return -1;
@@ -762,6 +807,10 @@ int main(int argc, char **argv)
 			init_timeout = atoi(arg+15);
 			continue;
 		}
+		if (!strcmp(arg, "--use-vhosts")) {
+			use_vhosts = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--strict-paths")) {
 			strict_paths = 1;
 			continue;
-- 
1.4.1.1

From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 4/4] git-daemon support for user-relative paths.
Date: Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Message-ID: <20051101225921.3E7455BF74@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 02 00:00:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX56G-0003RJ-G1
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVKAW7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVKAW7Z
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:59:25 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:49132 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751396AbVKAW7X
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:59:23 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 6F3106BD17
	for <git@vger.kernel.org>; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 3E7455BF74; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10962>

Dropped a fair amount of redundant functionality in favour of the library
code in path.c. git-upload-pack is now called with canonicalized paths.

Added option --strict-paths to retain old behaviour (documented).

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-daemon.txt |   17 +++++-
 daemon.c                     |  128 ++++++++++++++----------------------------
 2 files changed, 58 insertions(+), 87 deletions(-)

applies-to: c40ce0cb704af8d7d1d655bcf709e7621db60e0e
e35eb905a06718894a6c79f73d763122fff2a61a
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 67c5f22..25f03df 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -8,7 +8,7 @@ git-daemon - A really simple server for 
 SYNOPSIS
 --------
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
-             [--timeout=n] [--init-timeout=n] [directory...]
+             [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]
 
 DESCRIPTION
 -----------
@@ -29,10 +29,16 @@ This is ideally suited for read-only upd
 
 OPTIONS
 -------
+--strict-paths::
+	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
+	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
+	git-daemon will refuse to start when this option is enabled and no
+	whitelist is specified.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
-	(have the 'objects' subdirectory and a 'HEAD' file), even if they
-	do not have the 'git-daemon-export-ok' file.
+	(have the 'objects' and 'refs' subdirectories as well as a 'HEAD' file),
+	even if they do not have the 'git-daemon-export-ok' file.
 
 --inetd::
 	Have the server run as an inetd service.
@@ -57,6 +63,11 @@ OPTIONS
 --verbose::
 	Log details about the incoming connections and requested files.
 
+<directory>::
+	A directory to add to the whitelist of allowed directory. Unless
+	--strict-paths is specified this will also include subdirectories
+	of each named directory.
+	
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
diff --git a/daemon.c b/daemon.c
index c3f8641..7b36363 100644
--- a/daemon.c
+++ b/daemon.c
@@ -10,16 +10,18 @@
 #include "pkt-line.h"
 #include "cache.h"
 
-static int log_syslog;
+static int log_syslog = 0;
 static int verbose;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [directory...]";
+"           [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
 
+static int strict_paths = 0;
+
 /* If this is set, git-daemon-export-ok is not required */
 static int export_all_trees = 0;
 
@@ -81,69 +83,49 @@ static void loginfo(const char *err, ...
 	va_end(params);
 }
 
-static int path_ok(const char *dir)
+static const char *path_ok(const char *dir)
 {
-	const char *p = dir;
-	char **pp;
-	int sl, ndot;
-
-	/* The pathname here should be an absolute path. */
-	if ( *p++ != '/' )
-		return 0;
-
-	sl = 1;  ndot = 0;
-
-	for (;;) {
-		if ( *p == '.' ) {
-			ndot++;
-		} else if ( *p == '\0' ) {
-			/* Reject "." and ".." at the end of the path */
-			if ( sl && ndot > 0 && ndot < 3 )
-				return 0;
+	const char *path = is_git_repo(dir, strict_paths);
 
-			/* Otherwise OK */
-			break;
-		} else if ( *p == '/' ) {
-			/* Refuse "", "." or ".." */
-			if ( sl && ndot < 3 )
-				return 0;
-			sl = 1;
-			ndot = 0;
-		} else {
-			sl = ndot = 0;
-		}
-		p++;
+	/* No such directory or not a git archive */
+	if(!path) {
+		logerror("'%s': unable to chdir or not a git archive", dir);
+		return NULL;
 	}
 
 	if ( ok_paths && *ok_paths ) {
-		int ok = 0;
-		int dirlen = strlen(dir);
+		char **pp = NULL;
+		int dirlen = strlen(path);
 
 		for ( pp = ok_paths ; *pp ; pp++ ) {
 			int len = strlen(*pp);
-			if ( len <= dirlen &&
-			     !strncmp(*pp, dir, len) &&
-			     (dir[len] == '/' || dir[len] == '\0') ) {
-				ok = 1;
-				break;
+			if ( len <= dirlen && !strncmp(*pp, path, len) ) {
+				if( path[len] == '\0' || (!strict_paths && path[len] == '/') )
+					return path;
 			}
 		}
-
-		if ( !ok )
-			return 0; /* Path not in whitelist */
+	}
+	else {
+		/* Be backwards compatible */
+		if(!strict_paths)
+			return path;
 	}
 
-	return 1;		/* Path acceptable */
+	logerror("'%s': not in whitelist", path);
+	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int set_dir(const char *dir)
+static int upload(char *dir)
 {
-	if (!path_ok(dir)) {
-		errno = EACCES;
-		return -1;
-	}
+	/* Timeout as string */
+	char timeout_buf[64];
+	const char *path;
+
+	loginfo("Request for '%s'", dir);
 
-	if ( chdir(dir) )
+	/* path_ok() canonicalizes the path, chdir()'s
+	 * and does whitelist checking */
+	if(!(path = path_ok(dir)))
 		return -1;
 
 	/*
@@ -152,45 +134,16 @@ static int set_dir(const char *dir)
 	 * We want a readable HEAD, usable "objects" directory, and
 	 * a "git-daemon-export-ok" flag that says that the other side
 	 * is ok with us doing this.
+	 *
+	 * path_ok() uses is_git_repo() though, so we only need to
+	 * check if the path is exported.
 	 */
 	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
+		logerror("'%s': not exported", path);
 		errno = EACCES;
 		return -1;
 	}
 
-	if (access("objects/", X_OK) || access("HEAD", R_OK)) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	/* If all this passed, we're OK */
-	return 0;
-}
-
-static int upload(char *dir)
-{
-	/* Try paths in this order */
-	static const char *paths[] = { "%s", "%s/.git", "%s.git", "%s.git/.git", NULL };
-	const char **pp;
-	/* Enough for the longest path above including final null */
-	int buflen = strlen(dir)+10;
-	char *dirbuf = xmalloc(buflen);
-	/* Timeout as string */
-	char timeout_buf[64];
-
-	loginfo("Request for '%s'", dir);
-
-	for ( pp = paths ; *pp ; pp++ ) {
-		snprintf(dirbuf, buflen, *pp, dir);
-		if ( !set_dir(dirbuf) )
-			break;
-	}
-
-	if ( !*pp ) {
-		logerror("Cannot set directory '%s': %s", dir, strerror(errno));
-		return -1;
-	}
-
 	/*
 	 * We'll ignore SIGTERM from now on, we have a
 	 * good client.
@@ -200,7 +153,7 @@ static int upload(char *dir)
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
 	/* git-upload-pack only ever reads stuff, so this is safe */
-	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf, ".", NULL);
+	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf, path, NULL);
 	return -1;
 }
 
@@ -216,7 +169,7 @@ static int execute(void)
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack /", line, 17))
+	if (!strncmp("git-upload-pack ", line, 16))
 		return upload(line+16);
 
 	logerror("Protocol error: '%s'", line);
@@ -615,6 +568,10 @@ int main(int argc, char **argv)
 		if (!strncmp(arg, "--init-timeout=", 15)) {
 			init_timeout = atoi(arg+15);
 		}
+		if (!strcmp(arg, "--strict-paths")) {
+			strict_paths = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -626,6 +583,9 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	if(strict_paths && (!ok_paths || !*ok_paths))
+		die("git-daemon: option --strict-paths requires a whitelist");
+
 	if (inetd_mode) {
 		fclose(stderr); //FIXME: workaround
 		return execute();
---
0.99.9.GIT

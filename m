From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Message-ID: <20051117193714.428785C7FA@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 20:39:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpZl-0000lW-Dw
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVKQThT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVKQThT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:37:19 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:37338 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964822AbVKQThQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:37:16 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 9717C6BD17
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 428785C7FA; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12147>


Dropped a fair amount of reundant code in favour of the library code
in path.c

Added option --strict-paths with documentation, with backwards
compatibility for whitelist entries with symlinks.

Everything that worked earlier still works insofar as I have
remembered testing it.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-daemon.txt       |   16 ++++
 Documentation/pull-fetch-param.txt |    7 +-
 daemon.c                           |  136 ++++++++++++++----------------------
 3 files changed, 72 insertions(+), 87 deletions(-)

applies-to: d1e53de141c477b0b7dd2c6bd5897ea6239a7b20
4c4049426e6202bdb1429f5aeb4e5429df41c015
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 3783858..972e0e1 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -29,9 +29,15 @@ This is ideally suited for read-only upd
 
 OPTIONS
 -------
++--strict-paths::
+	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
+	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
+	git-daemon will refuse to start when this option is enabled and no
+	whitelist is specified.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
-	(have the 'objects' subdirectory and a 'HEAD' file), even if they
+	(have the 'objects' and 'refs' subdirectories), even if they
 	do not have the 'git-daemon-export-ok' file.
 
 --inetd::
@@ -57,9 +63,15 @@ OPTIONS
 --verbose::
 	Log details about the incoming connections and requested files.
 
+<directory>::
+	A directory to add to the whitelist of allowed directories. Unless
+	--strict-paths is specified this will also include subdirectories
+	of each named directory.
+
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org> and YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
+Written by Linus Torvalds <torvalds@osdl.org>, YOSHIFUJI Hideaki
+<yoshfuji@linux-ipv6.org> and the git-list <git@vger.kernel.org>
 
 Documentation
 --------------
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index a7628aa..6413d52 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -9,15 +9,16 @@
 - http://host.xz/path/to/repo.git/
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
+- git://host.xz/~user/path/to/repo.git/
 - ssh://host.xz/path/to/repo.git/
 - ssh://host.xz/~user/path/to/repo.git/
 - ssh://host.xz/~/path/to/repo.git
 ===============================================================
 +
 	SSH Is the default transport protocol and also supports an
-	scp-like syntax.  Both syntaxes support username expansion.
-	The following three are identical to the last three above,
-	respectively:
+	scp-like syntax.  Both syntaxes support username expansion,
+	as does the native git protocol. The following three are
+	identical to the last three above, respectively:
 +
 ===============================================================
 - host.xz:/path/to/repo.git/
diff --git a/daemon.c b/daemon.c
index 2b81152..ac4c94b 100644
--- a/daemon.c
+++ b/daemon.c
@@ -15,10 +15,11 @@ static int verbose;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [directory...]";
+"           [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
+static int strict_paths = 0;
 
 /* If this is set, git-daemon-export-ok is not required */
 static int export_all_trees = 0;
@@ -81,69 +82,56 @@ static void loginfo(const char *err, ...
 	va_end(params);
 }
 
-static int path_ok(const char *dir)
+static char *path_ok(char *dir)
 {
-	const char *p = dir;
-	char **pp;
-	int sl, ndot;
+	char *path = enter_repo(dir, strict_paths);
 
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
-
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
+	if (!path) {
+		logerror("'%s': unable to chdir or not a git archive", dir);
+		return NULL;
 	}
 
 	if ( ok_paths && *ok_paths ) {
-		int ok = 0;
+		char **pp = NULL;
 		int dirlen = strlen(dir);
+		int pathlen = strlen(path);
 
 		for ( pp = ok_paths ; *pp ; pp++ ) {
 			int len = strlen(*pp);
-			if ( len <= dirlen &&
-			     !strncmp(*pp, dir, len) &&
-			     (dir[len] == '/' || dir[len] == '\0') ) {
-				ok = 1;
-				break;
+			/* because of symlinks we must match both what the
+			 * user passed and the canonicalized path, otherwise
+			 * the user can send a string matching either a whitelist
+			 * entry or an actual directory exactly and still not
+			 * get through */
+			if (len <= pathlen && !memcmp(*pp, path, len)) {
+				if (path[len] == '\0' || (!strict_paths && path[len] == '/'))
+					return path;
+			}
+			if (len <= dirlen && !memcmp(*pp, dir, len)) {
+				if (dir[len] == '\0' || (!strict_paths && dir[len] == '/'))
+					return path;
 			}
 		}
-
-		if ( !ok )
-			return 0; /* Path not in whitelist */
+	}
+	else {
+		/* be backwards compatible */
+		if (!strict_paths)
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
 
-	if ( chdir(dir) )
+	loginfo("Request for '%s'", dir);
+
+	if (!(path = path_ok(dir)))
 		return -1;
 
 	/*
@@ -152,45 +140,17 @@ static int set_dir(const char *dir)
 	 * We want a readable HEAD, usable "objects" directory, and
 	 * a "git-daemon-export-ok" flag that says that the other side
 	 * is ok with us doing this.
+	 *
+	 * path_ok() uses enter_repo() and does whitelist checking.
+	 * We only need to make sure the repository is exported.
 	 */
+
 	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
+		logerror("'%s': repository not exported.", path);
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
@@ -200,7 +160,7 @@ static int upload(char *dir)
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
 	/* git-upload-pack only ever reads stuff, so this is safe */
-	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf, ".", NULL);
+	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf, path, NULL);
 	return -1;
 }
 
@@ -216,7 +176,7 @@ static int execute(void)
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack /", line, 17))
+	if (!strncmp("git-upload-pack ", line, 16))
 		return upload(line+16);
 
 	logerror("Protocol error: '%s'", line);
@@ -617,6 +577,10 @@ int main(int argc, char **argv)
 			init_timeout = atoi(arg+15);
 			continue;
 		}
+		if (!strcmp(arg, "--strict-paths")) {
+			strict_paths = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -631,6 +595,14 @@ int main(int argc, char **argv)
 	if (log_syslog)
 		openlog("git-daemon", 0, LOG_DAEMON);
 
+	if (strict_paths && (!ok_paths || !*ok_paths)) {
+		if (!inetd_mode)
+			die("git-daemon: option --strict-paths requires a whitelist");
+
+		logerror("option --strict-paths requires a whitelist");
+		exit (1);
+	}
+
 	if (inetd_mode) {
 		fclose(stderr); //FIXME: workaround
 		return execute();
---
0.99.9.GIT

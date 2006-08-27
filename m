From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] full featured formating function of the --{base,user}_path arguments,
Date: Sun, 27 Aug 2006 13:39:18 +0200
Message-ID: <11566787581030-git-send-email-madcoder@debian.org>
Reply-To: Pierre Habouzit <madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 13:39:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHIzO-0001wY-8b
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 13:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWH0LjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 07:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWH0LjW
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 07:39:22 -0400
Received: from pan.madism.org ([88.191.16.128]:41885 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S932081AbWH0LjV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 07:39:21 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id 6561DB008A;
	Sun, 27 Aug 2006 13:39:19 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id F0F5EB0089;
	Sun, 27 Aug 2006 13:39:18 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id F3F5A62126; Sun, 27 Aug 2006 13:39:18 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.1
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26094>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-daemon.txt |   54 +++++++++++
 daemon.c                     |  207 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 240 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 0f7d274..796ae7e 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -11,6 +11,8 @@ SYNOPSIS
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
+             [--base-path-fmt=pathfmt] [--user-path-fmt=pathfmt]
+             [--default-hostname=hostname]
 	     [--reuseaddr] [--detach] [--pid-file=file] [directory...]
 
 DESCRIPTION
@@ -45,6 +47,10 @@ OPTIONS
 	'git://example.com/hello.git', `git-daemon` will interpret the path
 	as '/srv/git/hello.git'.
 
+--base-path-fmt=pathfmt::
+	Works like --base-path, but uses a format instead. See Path
+	Formats section below.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
@@ -79,9 +85,20 @@ OPTIONS
 	taken as a request to access `path/foo` repository in
 	the home directory of user `alice`.
 
+--user-path-fmt=pathfmt::
+	Allow ~user notation to be used in requests. The path used to look
+	for the git repository is a format string, see Path Formats
+	section below.
+
 --verbose::
 	Log details about the incoming connections and requested files.
 
+--default-hostname=hostname::
+	Backward compatibility switch: argument is used as a fallback
+	hostname to use with virtual hosting (to fill the `%h` format in
+	path formats) when the client is too old to provide the information
+	in the query (older than 1.4.0 series).
+
 --reuseaddr::
 	Use SO_REUSEADDR when binding the listening socket.
 	This allows the server to restart without waiting for
@@ -98,10 +115,45 @@ OPTIONS
 	--strict-paths is specified this will also include subdirectories
 	of each named directory.
 
+Path Formats
+------------
+
+%h::
+	requested hostname. That won't work with clients older than 1.4.0
+	that do not pass the hostname in their query, and in that case, the
+	value of --default-hostname (if any) is used.
+
+%p::
+	requested path.
+
+%P::
+	requested path without the first slash when exists (`/`).
+
+%u::
+	requested username (only allowed for --user-path-fmt).
+
+%%::
+	plain `%`.
+
+Examples
+~~~~~~~~
+
+* `--base-path-fmt=/srv/git/%P` emulates `--base-path=/srv/git`
+
+* `--base-path-fmt=/srv/git/%h%p` will look into
+  `/srv/git/git.example.com/foo` if the request goes to
+  git://git.example.com/foo
+
+* `--user-path-fmt=/home/%u/public_git/%P` works mostly like
+  `--user-path=public_git` (the difference is that it assumes that home
+  directories live in `/home/username` instead of using the real `username`
+  home).
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>, YOSHIFUJI Hideaki
-<yoshfuji@linux-ipv6.org> and the git-list <git@vger.kernel.org>
+<yoshfuji@linux-ipv6.org>, Pierre Habouzit <madcoder@debian.org>,
+and the git-list <git@vger.kernel.org>
 
 Documentation
 --------------
diff --git a/daemon.c b/daemon.c
index 012936f..a2fb9b4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -19,6 +19,8 @@ static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
+"           [--base-path-fmt=pathfmt] [--user-path-fmt=pathfmt]\n"
+"           [--default-hostname=hostname]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -29,18 +31,27 @@ static int strict_paths;
 static int export_all_trees;
 
 /* Take all paths relative to this one if non-NULL */
-static char *base_path;
+static struct {
+	const char *path;
+	int use_as_fmt;
+} base_path;
 
 /* If defined, ~user notation is allowed and the string is inserted
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
  * go to /home/alice/pub_git/frotz with --user-path=pub_git.
  */
-static const char *user_path;
+static struct {
+	const char *path;
+	int use_as_fmt;
+} user_path;
 
 /* Timeout, and initial timeout */
 static unsigned int timeout;
 static unsigned int init_timeout;
 
+/* default host used when the client is old and does not provides host= */
+static char *default_host;
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	/* We should do a single write so that it is atomic and output
@@ -148,7 +159,107 @@ static int avoid_alias(char *p)
 	}
 }
 
-static char *path_ok(char *dir)
+static void check_path_fmt(const char *check, int allow_user)
+{
+	const char *p = check;
+
+	while (*p) {
+		if (*p++ != '%')
+			continue;
+
+		switch (*p) {
+		case '\0':
+			die("invalid format: <%s> ends with an unescaped %%",
+			    check);
+
+		case '%':
+		case 'p': case 'P':
+		case 'h':
+			break;
+
+		case 'u':
+			if (allow_user)
+				break;
+			/* fallthrough */
+
+		default:
+			die("invalid format: <%s> uses unknown specifier %%%c",
+			    check, *p);
+		}
+
+		p++;
+	}
+}
+
+static char *
+git_path_fmt(char rpath[PATH_MAX], const char *fmt,
+             const char *vhost, const char *path,
+             const char *username, int namlen)
+{
+	const char *p = fmt;
+	int pos = 0;
+
+	while (*p && pos < PATH_MAX) {
+		if (*p != '%') {
+			rpath[pos++] = *p++;
+			continue;
+		}
+
+		switch (*++p) {
+		case '%':
+			rpath[pos++] = *p;
+			break;
+
+		case 'h':
+			if (!vhost && !default_host) {
+				logerror("abort: missing host=, no --default-host given, client is too old");
+				return NULL;
+			}
+			
+			if (!vhost) {
+				logerror("old client without host=, using <%s>", default_host);
+				pos += strlcpy(rpath + pos, default_host, PATH_MAX - pos);
+			} else {
+				pos += strlcpy(rpath + pos, vhost, PATH_MAX - pos);
+			}
+			break;
+
+		case 'P':
+			pos += strlcpy(rpath + pos, path + (*path == '/'),
+				       PATH_MAX - pos);
+			break;
+
+		case 'p':
+			pos += strlcpy(rpath + pos, path, PATH_MAX - pos);
+			break;
+
+		case 'u':
+			pos += snprintf(rpath + pos, PATH_MAX - pos, "%.*s",
+					namlen, username);
+			break;
+		}
+
+		p++;
+	}
+
+	if (pos >= PATH_MAX) {
+		logerror("generated path is too long");
+		return NULL;
+	}
+
+	rpath[pos] = '\0';
+
+	return rpath;
+}
+
+static inline char *
+git_base_path_fmt(char rpath[PATH_MAX], const char *fmt,
+                  const char *vhost, const char *path)
+{
+	return git_path_fmt(rpath, fmt, vhost, path, NULL, 0);
+}
+
+static char *path_ok(char *dir, char *vhost)
 {
 	static char rpath[PATH_MAX];
 	char *path;
@@ -159,11 +270,11 @@ static char *path_ok(char *dir)
 	}
 
 	if (*dir == '~') {
-		if (!user_path) {
+		if (!user_path.path) {
 			logerror("'%s': User-path not allowed", dir);
 			return NULL;
 		}
-		if (*user_path) {
+		if (*user_path.path) {
 			/* Got either "~alice" or "~alice/foo";
 			 * rewrite them to "~alice/%s" or
 			 * "~alice/%s/foo".
@@ -174,24 +285,45 @@ static char *path_ok(char *dir)
 				slash = dir + restlen;
 			namlen = slash - dir;
 			restlen -= namlen;
-			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
-			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
-				 namlen, dir, user_path, restlen, slash);
-			dir = rpath;
+
+			if (user_path.use_as_fmt) {
+				loginfo("host <%s>, "
+					"userpathfmt <%s>, request <%s>, "
+					"namlen %d, restlen %d, slash <%s>",
+					vhost,
+					user_path.path, dir,
+					namlen, restlen, slash);
+				dir = git_path_fmt(rpath, user_path.path, vhost,
+						   slash, dir + 1, namlen - 1);
+			} else {
+				loginfo("userpath <%s>, request <%s>, "
+					"namlen %d, restlen %d, slash <%s>",
+					user_path.path, dir,
+					namlen, restlen, slash);
+				snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
+					 namlen, dir, user_path.path, restlen, slash);
+				dir = rpath;
+			}
 		}
 	}
-	else if (base_path) {
+	else if (base_path.path) {
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
-		else {
-			snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
+
+		if (base_path.use_as_fmt) {
+			dir = git_base_path_fmt(rpath, base_path.path, vhost, dir);
+		} else {
+			snprintf(rpath, PATH_MAX, "%s%s", base_path.path, dir);
 			dir = rpath;
 		}
 	}
 
+	if (!dir)
+		return NULL;
+
 	path = enter_repo(dir, strict_paths);
 
 	if (!path) {
@@ -229,7 +361,7 @@ static char *path_ok(char *dir)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int upload(char *dir)
+static int upload(char *dir, char *vhost)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
@@ -237,7 +369,7 @@ static int upload(char *dir)
 
 	loginfo("Request for '%s'", dir);
 
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(dir, vhost)))
 		return -1;
 
 	/*
@@ -274,6 +406,7 @@ static int execute(struct sockaddr *addr
 {
 	static char line[1000];
 	int pktlen, len;
+	char *vhost = NULL;
 
 	if (addr) {
 		char addrbuf[256] = "";
@@ -303,15 +436,30 @@ #endif
 	alarm(0);
 
 	len = strlen(line);
-	if (pktlen != len)
+
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
+
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
 	if (!strncmp("git-upload-pack ", line, 16))
-		return upload(line+16);
+		return upload(line+16, vhost);
 
 	logerror("Protocol error: '%s'", line);
 	return -1;
@@ -767,19 +915,38 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "--base-path=", 12)) {
-			base_path = arg+12;
+			base_path.path = arg+12;
+			base_path.use_as_fmt = 0;
+			continue;
+		}
+		if (!strncmp(arg, "--base-path-fmt=", 16)) {
+			base_path.path = arg+16;
+			base_path.use_as_fmt = 1;
+			check_path_fmt(base_path.path, 0);
 			continue;
 		}
 		if (!strcmp(arg, "--reuseaddr")) {
 			reuseaddr = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--default-hostname=", 19)) {
+			default_host = arg + 19;
+			continue;
+		}
 		if (!strcmp(arg, "--user-path")) {
-			user_path = "";
+			user_path.path = "";
+			user_path.use_as_fmt = 0;
 			continue;
 		}
 		if (!strncmp(arg, "--user-path=", 12)) {
-			user_path = arg + 12;
+			user_path.path = arg + 12;
+			user_path.use_as_fmt = 0;
+			continue;
+		}
+		if (!strncmp(arg, "--user-path-fmt=", 16)) {
+			user_path.path = arg + 16;
+			user_path.use_as_fmt = 1;
+			check_path_fmt(user_path.path, 1);
 			continue;
 		}
 		if (!strncmp(arg, "--pid-file=", 11)) {
-- 
1.4.1.1

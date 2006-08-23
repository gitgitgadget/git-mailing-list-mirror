From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Thu, 24 Aug 2006 01:32:54 +0200
Message-ID: <115637597423-git-send-email-madcoder@debian.org>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 24 01:33:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG2DU-0005s3-L5
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 01:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWHWXc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWHWXc5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 19:32:57 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:63962 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S965181AbWHWXc5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 19:32:57 -0400
Received: from olympe.madism.org (olympe.madism.org [82.243.245.108])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 710E6735DF
	for <git@vger.kernel.org>; Thu, 24 Aug 2006 01:32:55 +0200 (CEST)
Received: from olympe.madism.org (localhost [127.0.0.1])
	by olympe.madism.org (Postfix) with ESMTP id 20124BC7B0;
	Thu, 24 Aug 2006 01:32:55 +0200 (CEST)
Received: from hades.madism.org (hades.madism.org [192.168.0.10])
	by olympe.madism.org (Postfix) with ESMTP id C9639BC7AE;
	Thu, 24 Aug 2006 01:32:54 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 847EF62126; Thu, 24 Aug 2006 01:32:54 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g44c10-dirty
In-Reply-To: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by ClamAV (using ClamSMTP) at hermes.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25934>

Allow a form of virtualhosting, when %h format is used.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    This is intended to be a more flexible solution, that also gives virtual
    hosting as a bonus. I still see no way to deal with older clients when
    virtual hosting is used by the admin though, having a "default" hostname
    won't solve anything at all anyway.

 Documentation/git-daemon.txt |   42 ++++++++++
 daemon.c                     |  170 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 201 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 0f7d274..0aa34d4 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
+             [--base-path-fmt=pathfmt] [--user-path-fmt=pathfmt]
 	     [--reuseaddr] [--detach] [--pid-file=file] [directory...]
 
 DESCRIPTION
@@ -45,6 +46,10 @@ OPTIONS
 	'git://example.com/hello.git', `git-daemon` will interpret the path
 	as '/srv/git/hello.git'.
 
+--base-path-fmt=pathfmt::
+	Works like --base-path, but uses a format instead. See Path
+	Formats section below.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
@@ -79,6 +84,11 @@ OPTIONS
 	taken as a request to access `path/foo` repository in
 	the home directory of user `alice`.
 
+--user-path-fmt=pathfmt::
+	Allow ~user notation to be used in requests. The path used to look
+	for the git repository is a format string, see Path Formats
+	section below.
+
 --verbose::
 	Log details about the incoming connections and requested files.
 
@@ -98,6 +108,38 @@ OPTIONS
 	--strict-paths is specified this will also include subdirectories
 	of each named directory.
 
+Path Formats
+------------
+
+%h::
+	requested hostname (won't work with clients older than 1.4.0).
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
+	plain '%'
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
diff --git a/daemon.c b/daemon.c
index 012936f..1ffebd6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -19,6 +19,7 @@ static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
+"           [--base-path-fmt=pathfmt] [--user-path-fmt=pathfmt]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -29,12 +30,14 @@ static int strict_paths;
 static int export_all_trees;
 
 /* Take all paths relative to this one if non-NULL */
+int is_base_path_fmt;
 static char *base_path;
 
 /* If defined, ~user notation is allowed and the string is inserted
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
  * go to /home/alice/pub_git/frotz with --user-path=pub_git.
  */
+int is_user_path_fmt;
 static const char *user_path;
 
 /* Timeout, and initial timeout */
@@ -148,7 +151,100 @@ static int avoid_alias(char *p)
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
+		  case '\0':
+		    die("invalid format: <%s> ends with an unescaped %%", check);
+
+		  case '%':
+		  case 'p': case 'P':
+		  case 'h':
+		    break;
+
+		  case 'u':
+		    if (allow_user)
+			    break;
+		    /* fallthrough */
+
+		  default:
+		    die("invalid format: <%s> uses unknown specifier %%%c",
+			check, *p);
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
+	while (*p) {
+		if (*p != '%') {
+			rpath[pos++] = *p++;
+			continue;
+		}
+
+		switch (*++p) {
+		  case '%':
+		    rpath[pos++] = *p;
+		    break;
+
+		  case 'h':
+                    if (!vhost) {
+                        logerror("missing host=, client is too old");
+                        return NULL;
+                    }
+		    pos += strlcpy(rpath + pos, vhost, PATH_MAX - pos);
+		    break;
+
+		  case 'P':
+		    pos += strlcpy(rpath + pos, path + (*path == '/'),
+				   PATH_MAX - pos);
+		    break;
+
+		  case 'p':
+		    pos += strlcpy(rpath + pos, path, PATH_MAX - pos);
+		    break;
+
+		  case 'u':
+		    pos += snprintf(rpath + pos, PATH_MAX - pos, "%.*s",
+				    namlen, username);
+		    break;
+		}
+
+		p++;
+
+		if (pos >= PATH_MAX) {
+                        logerror("generated path is too long");
+			return NULL;
+		}
+	}
+
+	rpath[pos] = '\0';
+
+        return rpath;
+}
+
+static inline char *
+git_base_path_fmt(char rpath[PATH_MAX], const char *fmt,
+                  const char *vhost, const char *path)
+{
+    return git_path_fmt(rpath, fmt, vhost, path, NULL, 0);
+}
+
+static char *path_ok(char *dir, char *vhost)
 {
 	static char rpath[PATH_MAX];
 	char *path;
@@ -174,10 +270,25 @@ static char *path_ok(char *dir)
 				slash = dir + restlen;
 			namlen = slash - dir;
 			restlen -= namlen;
-			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
-			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
-				 namlen, dir, user_path, restlen, slash);
-			dir = rpath;
+
+			if (is_user_path_fmt) {
+				loginfo("host <%s>, "
+					"userpathfmt <%s>, request <%s>, "
+					"namlen %d, restlen %d, slash <%s>",
+					vhost,
+					user_path, dir,
+					namlen, restlen, slash);
+                                dir = git_path_fmt(rpath, user_path, vhost,
+                                                   slash, dir + 1, namlen - 1);
+			} else {
+				loginfo("userpath <%s>, request <%s>, "
+					"namlen %d, restlen %d, slash <%s>",
+					user_path, dir,
+					namlen, restlen, slash);
+				snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
+					 namlen, dir, user_path, restlen, slash);
+				dir = rpath;
+			}
 		}
 	}
 	else if (base_path) {
@@ -186,12 +297,18 @@ static char *path_ok(char *dir)
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
-		else {
+
+		if (is_base_path_fmt) {
+                        dir = git_base_path_fmt(rpath, base_path, vhost, dir);
+		} else {
 			snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
 			dir = rpath;
 		}
 	}
 
+	if (!dir)
+		return NULL;
+
 	path = enter_repo(dir, strict_paths);
 
 	if (!path) {
@@ -229,7 +346,7 @@ static char *path_ok(char *dir)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int upload(char *dir)
+static int upload(char *dir, char *vhost)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
@@ -237,7 +354,7 @@ static int upload(char *dir)
 
 	loginfo("Request for '%s'", dir);
 
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(dir, vhost)))
 		return -1;
 
 	/*
@@ -274,6 +391,7 @@ static int execute(struct sockaddr *addr
 {
 	static char line[1000];
 	int pktlen, len;
+	char *vhost = NULL;
 
 	if (addr) {
 		char addrbuf[256] = "";
@@ -303,15 +421,30 @@ #endif
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
@@ -768,6 +901,13 @@ int main(int argc, char **argv)
 		}
 		if (!strncmp(arg, "--base-path=", 12)) {
 			base_path = arg+12;
+			is_base_path_fmt = 0;
+			continue;
+		}
+		if (!strncmp(arg, "--base-path-fmt=", 16)) {
+			base_path = arg+16;
+			is_base_path_fmt = 1;
+			check_path_fmt(base_path, 0);
 			continue;
 		}
 		if (!strcmp(arg, "--reuseaddr")) {
@@ -776,10 +916,18 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "--user-path")) {
 			user_path = "";
+			is_user_path_fmt = 0;
 			continue;
 		}
 		if (!strncmp(arg, "--user-path=", 12)) {
 			user_path = arg + 12;
+			is_user_path_fmt = 0;
+			continue;
+		}
+		if (!strncmp(arg, "--user-path-fmt=", 16)) {
+			user_path = arg + 16;
+			is_user_path_fmt = 1;
+			check_path_fmt(user_path, 1);
 			continue;
 		}
 		if (!strncmp(arg, "--pid-file=", 11)) {
-- 
1.4.2.g44c10-dirty

From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH 3/3] daemon: Support a --user-path option.
Date: Sat, 4 Feb 2006 19:13:53 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndu9v7h.2i8.mdw@metalzone.distorted.org.uk>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk> <20060203202706.1895.70864.stgit@metalzone.distorted.org.uk> <7vr76kcggx.fsf@assigned-by-dhcp.cox.net> <slrndu8utr.2i8.mdw@metalzone.distorted.org.uk> <7v8xsrz49e.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 20:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5SrT-0001wr-3J
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 20:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWBDTON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 14:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWBDTOM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 14:14:12 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:29231 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751565AbWBDTOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 14:14:11 -0500
Received: (qmail 18406 invoked by uid 110); 4 Feb 2006 19:13:53 -0000
To: git@vger.kernel.org
Received: (qmail 18392 invoked by uid 9); 4 Feb 2006 19:13:53 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139080433 18388 172.29.199.2 (4 Feb 2006 19:13:53 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sat, 4 Feb 2006 19:13:53 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15597>

Junio C Hamano <junkio@cox.net> wrote:

> In my simplistic view, --base-path serves something like /pub
> hierarchy of an ftp server or /var/www of an http server. 

Yes, that's the way I think of it too.  I'll probably point it at
/var/www/git or something when I finally get my tuits.

> For ~user/ based paths, it is natural to wish to limit the parts of
> home directories but there currently is not a good way to do so.  We
> could probably extend the whitelist to take path glob patterns and say
> "~*/public-git/" or something silly like that, but that still means
> the request must be in the form
> "git://host/~alice/public-git/frotz.git/" (which may not be such a bad
> thing); "git://host/~alice/frotz.git/" might look nicer. 

Putting `public-git' in the URLs seems to exposing an unnecessary
detail.  Or it's saying something utterly obvious -- of course it's a
public GIT -- otherwise you wouldn't be asking for it.

> Your path munging idea is one way to do so.  Another would be for
> alice to have $HOME/frotz.git/git-daemon-export-ok.  Personally I do
> not think either would make too much of a difference from usability
> point of view.

The idea of filling my home directory with all my GIT repositories isn't
one I'm particularly keen on.  For one thing, I can just tell that I'm
going to get confused between ~/src/foo/.git and ~/foo.git some day; and
besides, I like `ls ~' to be nice and short.

> So I am not dismissing what you are trying to achieve here.
> However, I am not happy about having <pwd.h> there and majorly
> duplicating what enter_repo() does in that part of the code.

OK, then: how about putting the user_path logic into enter_repo?  Like
this, perhaps:


 Documentation/git-daemon.txt |   11 +++++++++--
 cache.h                      |    2 +-
 daemon.c                     |   16 +++++++++++-----
 path.c                       |   34 ++++++++++++++++++++++++++++------
 receive-pack.c               |    2 +-
 upload-pack.c                |    2 +-
 6 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a20e053..2e48a10 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
-             [--base-path=path] [directory...]
+             [--base-path=path] [--user-path=path] [directory...]
 
 DESCRIPTION
 -----------
@@ -43,7 +43,7 @@ OPTIONS
 	'--base-path=/srv/git' on example.com, then if you later try to pull
 	'git://example.com/hello.git', `git-daemon` will interpret the path
 	as '/srv/git/hello.git'. Home directories (the '~login' notation)
-	access is disabled.
+	access is disabled unless '--user-path' is also given.
 
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
@@ -70,6 +70,13 @@ OPTIONS
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.
 
+--user-path::
+	Rewrite a request for "~user/something" to
+	"home/user-path/something".  Useful in conjunction with
+	'--base-path', if you want to restrict the daemon from roaming
+	the entire filesystem without preventing users from publishing
+	their own repositories.
+
 --verbose::
 	Log details about the incoming connections and requested files.
 
diff --git a/cache.h b/cache.h
index bdbe2d6..b6c9cda 100644
--- a/cache.h
+++ b/cache.h
@@ -191,7 +191,7 @@ int git_mkstemp(char *path, size_t n, co
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 char *safe_strncpy(char *, const char *, size_t);
-char *enter_repo(char *path, int strict);
+char *enter_repo(char *path, const char *u_path, int strict);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
diff --git a/daemon.c b/daemon.c
index bb014fa..22d133d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -17,7 +17,7 @@ static int verbose;
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [directory...]";
+"           [--base-path=path] [--user-path=path] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
@@ -28,6 +28,7 @@ static int export_all_trees = 0;
 
 /* Take all paths relative to this one if non-NULL */
 static char *base_path = NULL;
+static char *user_path = NULL;
 
 /* Timeout, and initial timeout */
 static unsigned int timeout = 0;
@@ -137,14 +138,16 @@ static int avoid_alias(char *p)
 static char *path_ok(char *dir)
 {
 	char *path;
+	static char rpath[PATH_MAX];
 
 	if (avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
 		return NULL;
 	}
 
-	if (base_path) {
-		static char rpath[PATH_MAX];
+	if (user_path && dir[0] == '~')
+		/* okay */;
+	else if (base_path) {
 		if (*dir != '/') {
 			/* Forbid possible base-path evasion using ~paths. */
 			logerror("'%s': Non-absolute path denied (base-path active)");
@@ -154,7 +157,7 @@ static char *path_ok(char *dir)
 		dir = rpath;
 	}
 
-	path = enter_repo(dir, strict_paths);
+	path = enter_repo(dir, user_path, strict_paths);
 
 	if (!path) {
 		logerror("'%s': unable to chdir or not a git archive", dir);
@@ -490,7 +493,6 @@ static int socksetup(int port, int **soc
 			/* Note: error is not fatal */
 		}
 #endif
-
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			close(sockfd);
 			continue;	/* not fatal */
@@ -659,6 +661,10 @@ int main(int argc, char **argv)
 			base_path = arg+12;
 			continue;
 		}
+		if (!strncmp(arg, "--user-path=", 12)) {
+			user_path = arg+12;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
diff --git a/path.c b/path.c
index 334b2bd..596e37e 100644
--- a/path.c
+++ b/path.c
@@ -131,7 +131,17 @@ int validate_symref(const char *path)
 	return -1;
 }
 
-static char *user_path(char *buf, char *path, int sz)
+static void kill_trailing_slashes(char *buf, int *lenp)
+{
+	int len = *lenp;
+	while ((1 < len) && (buf[len-1] == '/')) {
+		buf[len-1] = 0;
+		len--;
+	}
+	*lenp = len;
+}
+
+static char *user_path(char *buf, char *path, const char *u_path, int sz)
 {
 	struct passwd *pw;
 	char *slash;
@@ -157,9 +167,17 @@ static char *user_path(char *buf, char *
 		return NULL;
 	baselen = strlen(pw->pw_dir);
 	memcpy(buf, pw->pw_dir, baselen);
-	while ((1 < baselen) && (buf[baselen-1] == '/')) {
-		buf[baselen-1] = 0;
-		baselen--;
+	kill_trailing_slashes(buf, &baselen);
+	if (u_path) {
+		while (*u_path == '/')
+			u_path++;
+		len = strlen(u_path);
+		if (sz <= baselen + len + 1)
+			return NULL;
+		buf[baselen++] = '/';
+		memcpy(buf + baselen, u_path, len);
+		baselen += len;
+		kill_trailing_slashes(buf, &baselen);
 	}
 	if (slash && slash[1]) {
 		len = strlen(slash);
@@ -184,6 +202,10 @@ static char *user_path(char *buf, char *
  * "%s/.git", "%s.git", "%s" in this order.  The first one that exists is
  * what we try.
  *
+ * If "u_path" is given, and the path we're resolving has the form ~/path
+ * or ~user/path, then we resolve to home/u_path/path (where home is the
+ * appropriate user's home directory).
+ *
  * Second, we try chdir() to that.  Upon failure, we return NULL.
  *
  * Then, we try if the current directory is a valid git repository.
@@ -194,7 +216,7 @@ static char *user_path(char *buf, char *
  * links.  User relative paths are also returned as they are given,
  * except DWIM suffixing.
  */
-char *enter_repo(char *path, int strict)
+char *enter_repo(char *path, const char *u_path, int strict)
 {
 	static char used_path[PATH_MAX];
 	static char validated_path[PATH_MAX];
@@ -215,7 +237,7 @@ char *enter_repo(char *path, int strict)
 		if (PATH_MAX <= len)
 			return NULL;
 		if (path[0] == '~') {
-			if (!user_path(used_path, path, PATH_MAX))
+			if (!user_path(used_path, path, u_path, PATH_MAX))
 				return NULL;
 			strcpy(validated_path, path);
 			path = used_path;
diff --git a/receive-pack.c b/receive-pack.c
index eae31e3..d411ab2 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -317,7 +317,7 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	if(!enter_repo(dir, 0))
+	if(!enter_repo(dir, NULL, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
 	write_head_info();
diff --git a/upload-pack.c b/upload-pack.c
index d198055..3468de1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -276,7 +276,7 @@ int main(int argc, char **argv)
 		usage(upload_pack_usage);
 	dir = argv[i];
 
-	if (!enter_repo(dir, strict))
+	if (!enter_repo(dir, NULL, strict))
 		die("'%s': unable to chdir or not a git archive", dir);
 
 	upload_pack();


-- [mdw]

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull aborts in 50% of cases
Date: Sat, 03 Dec 2005 01:45:57 -0800
Message-ID: <7vpsoezf6y.fsf@assigned-by-dhcp.cox.net>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
	<43909963.60901@zytor.com>
	<20051202211250.GA11384@mipter.zuzino.mipt.ru>
	<4390B64E.20601@zytor.com>
	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 10:47:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiTyW-0005wN-MH
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 10:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVLCJqD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 04:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVLCJqD
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 04:46:03 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48033 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751230AbVLCJqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 04:46:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203094513.MKEB20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 04:45:13 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43911D9E.5030803@zytor.com> (H. Peter Anvin's message of "Fri,
	02 Dec 2005 20:22:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13148>

"H. Peter Anvin" <hpa@zytor.com> writes:

> /pub is a symbolic link.  We shouldn't rely on getcwd() for this kind of 
> stuff; it's bad for a whole bunch of reasons.

Well, if I recall correctly it was done this way because
DWIMmery needs to be done before the validation.

Anyway, here is a rewrite of tonight (I resurrected your "belts
and suspenders paranoia patch" for this).  Would appreciate it
if people can try this out (in the proposed updates branch).

The rules (in 0.99.9k and "master" so far) have been that if you
have symlinked public, whitelist should say what the canonical
names of them are (and the way canonical names are obtained were
getcwd()).  The rule of this patch is different: whitelist says
what the remote requestor can ask for.  So if your /pub is a
symlink to /mnt/mnt1/pub, you do not have to say /mnt/mnt1/pub
to export it.  Instead you whitelist /pub (or /pub/scm).  Also
if your ~bob is /home1/bob and ~alice is /home2/alice, you do
not say "/home1 /home2" -- instead, you say "~alice ~bob".

-- >8 --
Subject: [PATCH] daemon.c and path.enter_repo(): revamp path validation.

The whitelist of git-daemon is checked against return value from
enter_repo(), and enter_repo() used to return the value obtained
from getcwd() to avoid directory aliasing issues as discussed
earier (mid October 2005).

Unfortunately, it did not go well as we hoped.

For example, /pub on a kernel.org public machine is a symlink to
its real mountpoint, and it is understandable that the
administrator does not want to adjust the whitelist every time
/pub needs to point at a different partition for storage
allcation or whatever reasons.  Being able to keep using
/pub/scm as the whitelist is a desirable property.

So this version of enter_repo() reports what it used to chdir()
and validate, but does not use getcwd() to canonicalize the
directory name.  When it sees a user relative path ~user/path,
it internally resolves it to try chdir() there, but it still
reports ~user/path (possibly after appending .git if allowed to
do so, in which case it would report ~user/path.git).

What this means is that if a whitelist wants to allow a user
relative path, it needs to say "~" (for all users) or list user
home directories like "~alice" "~bob".  And no, you cannot say
/home if the advertised way to access user home directories are
~alice,~bob, etc.  The whole point of this is to avoid
unnecessary aliasing issues.

Anyway, because of this, daemon needs to do a bit more work to
guard itself.  Namely, it needs to make sure that the accessor
does not try to exploit its leading path match rule by inserting
/../ in the middle or hanging /.. at the end.  I resurrected the
belts and suspender paranoia code HPA did for this purpose.

This check cannot be done in the enter_repo() unconditionally,
because there are valid callers of enter_repo() that want to
honor /../; authorized users coming over ssh to run send-pack
and fetch-pack should be allowed to do so.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 daemon.c |   64 ++++++++++++++++++++++++--
 path.c   |  153 ++++++++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 159 insertions(+), 58 deletions(-)

018c8d740d18b7fe7d9d5a24fc1d008e29d70bc4
diff --git a/daemon.c b/daemon.c
index 91b9656..539f6e8 100644
--- a/daemon.c
+++ b/daemon.c
@@ -82,9 +82,63 @@ static void loginfo(const char *err, ...
 	va_end(params);
 }
 
+static int avoid_alias(char *p)
+{
+	int sl, ndot;
+
+	/* 
+	 * This resurrects the belts and suspenders paranoia check by HPA
+	 * done in <435560F7.4080006@zytor.com> thread, now enter_repo()
+	 * does not do getcwd() based path canonicalizations.
+	 *
+	 * sl becomes true immediately after seeing '/' and continues to
+	 * be true as long as dots continue after that without intervening
+	 * non-dot character.
+	 */
+	if (!p || (*p != '/' && *p != '~'))
+		return -1;
+	sl = 1; ndot = 0;
+	p++;
+
+	while (1) {
+		char ch = *p++;
+		if (sl) {
+			if (ch == '.')
+				ndot++;
+			else if (ch == '/') {
+				if (ndot < 3)
+					/* reject //, /./ and /../ */
+					return -1;
+				ndot = 0;
+			}
+			else if (ch == 0) {
+				if (0 < ndot && ndot < 3)
+					/* reject /.$ and /..$ */
+					return -1;
+				return 0;
+			}
+			else
+				sl = ndot = 0;
+		}
+		else if (ch == 0)
+			return 0;
+		else if (ch == '/') {
+			sl = 1;
+			ndot = 0;
+		}
+	}
+}
+
 static char *path_ok(char *dir)
 {
-	char *path = enter_repo(dir, strict_paths);
+	char *path;
+
+	if (avoid_alias(dir)) {
+		logerror("'%s': aliased", dir);
+		return NULL;
+	}
+
+	path = enter_repo(dir, strict_paths);
 
 	if (!path) {
 		logerror("'%s': unable to chdir or not a git archive", dir);
@@ -96,9 +150,11 @@ static char *path_ok(char *dir)
 		int pathlen = strlen(path);
 
 		/* The validation is done on the paths after enter_repo
-		 * canonicalization, so whitelist should be written in
-		 * terms of real pathnames (i.e. after ~user is expanded
-		 * and symlinks resolved).
+		 * appends optional {.git,.git/.git} and friends, but 
+		 * it does not use getcwd().  So if your /pub is
+		 * a symlink to /mnt/pub, you can whitelist /pub and
+		 * do not have to say /mnt/pub.
+		 * Do not say /pub/.
 		 */
 		for ( pp = ok_paths ; *pp ; pp++ ) {
 			int len = strlen(*pp);
diff --git a/path.c b/path.c
index 2c077c0..334b2bd 100644
--- a/path.c
+++ b/path.c
@@ -131,76 +131,121 @@ int validate_symref(const char *path)
 	return -1;
 }
 
-static char *current_dir(void)
+static char *user_path(char *buf, char *path, int sz)
 {
-	return getcwd(pathname, sizeof(pathname));
-}
-
-static int user_chdir(char *path)
-{
-	char *dir = path;
+	struct passwd *pw;
+	char *slash;
+	int len, baselen;
 
-	if(*dir == '~') {		/* user-relative path */
-		struct passwd *pw;
-		char *slash = strchr(dir, '/');
-
-		dir++;
-		/* '~/' and '~' (no slash) means users own home-dir */
-		if(!*dir || *dir == '/')
-			pw = getpwuid(getuid());
-		else {
-			if (slash) {
-				*slash = '\0';
-				pw = getpwnam(dir);
-				*slash = '/';
-			}
-			else
-				pw = getpwnam(dir);
+	if (!path || path[0] != '~')
+		return NULL;
+	path++;
+	slash = strchr(path, '/');
+	if (path[0] == '/' || !path[0]) {
+		pw = getpwuid(getuid());
+	}
+	else {
+		if (slash) {
+			*slash = 0;
+			pw = getpwnam(path);
+			*slash = '/';
 		}
-
-		/* make sure we got something back that we can chdir() to */
-		if(!pw || chdir(pw->pw_dir) < 0)
-			return -1;
-
-		if(!slash || !slash[1]) /* no path following username */
-			return 0;
-
-		dir = slash + 1;
+		else
+			pw = getpwnam(path);
 	}
-
-	/* ~foo/path/to/repo is now path/to/repo and we're in foo's homedir */
-	if(chdir(dir) < 0)
-		return -1;
-
-	return 0;
+	if (!pw || !pw->pw_dir || sz <= strlen(pw->pw_dir))
+		return NULL;
+	baselen = strlen(pw->pw_dir);
+	memcpy(buf, pw->pw_dir, baselen);
+	while ((1 < baselen) && (buf[baselen-1] == '/')) {
+		buf[baselen-1] = 0;
+		baselen--;
+	}
+	if (slash && slash[1]) {
+		len = strlen(slash);
+		if (sz <= baselen + len)
+			return NULL;
+		memcpy(buf + baselen, slash, len + 1);
+	}
+	return buf;
 }
 
+/*
+ * First, one directory to try is determined by the following algorithm.
+ *
+ * (0) If "strict" is given, the path is used as given and no DWIM is
+ *     done. Otherwise:
+ * (1) "~/path" to mean path under the running user's home directory;
+ * (2) "~user/path" to mean path under named user's home directory;
+ * (3) "relative/path" to mean cwd relative directory; or
+ * (4) "/absolute/path" to mean absolute directory.
+ *
+ * Unless "strict" is given, we try access() for existence of "%s.git/.git",
+ * "%s/.git", "%s.git", "%s" in this order.  The first one that exists is
+ * what we try.
+ *
+ * Second, we try chdir() to that.  Upon failure, we return NULL.
+ *
+ * Then, we try if the current directory is a valid git repository.
+ * Upon failure, we return NULL.
+ *
+ * If all goes well, we return the directory we used to chdir() (but
+ * before ~user is expanded), avoiding getcwd() resolving symbolic
+ * links.  User relative paths are also returned as they are given,
+ * except DWIM suffixing.
+ */
 char *enter_repo(char *path, int strict)
 {
-	if(!path)
+	static char used_path[PATH_MAX];
+	static char validated_path[PATH_MAX];
+
+	if (!path)
 		return NULL;
 
-	if (strict) {
-		if (chdir(path) < 0)
+	if (!strict) {
+		static const char *suffix[] = {
+			".git/.git", "/.git", ".git", "", NULL,
+		};
+		int len = strlen(path);
+		int i;
+		while ((1 < len) && (path[len-1] == '/')) {
+			path[len-1] = 0;
+			len--;
+		}
+		if (PATH_MAX <= len)
 			return NULL;
-	}
-	else {
-		if (!*path)
-			; /* happy -- no chdir */
-		else if (!user_chdir(path))
-			; /* happy -- as given */
-		else if (!user_chdir(mkpath("%s.git", path)))
-			; /* happy -- uemacs --> uemacs.git */
-		else
+		if (path[0] == '~') {
+			if (!user_path(used_path, path, PATH_MAX))
+				return NULL;
+			strcpy(validated_path, path);
+			path = used_path;
+		}
+		else if (PATH_MAX - 10 < len)
 			return NULL;
-		(void)chdir(".git");
+		else {
+			path = strcpy(used_path, path);
+			strcpy(validated_path, path);
+		}
+		len = strlen(path);
+		for (i = 0; suffix[i]; i++) {
+			strcpy(path + len, suffix[i]);
+			if (!access(path, F_OK)) {
+				strcat(validated_path, suffix[i]);
+				break;
+			}
+		}
+		if (!suffix[i] || chdir(path))
+			return NULL;
+		path = validated_path;
 	}
+	else if (chdir(path))
+		return NULL;
 
-	if(access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
-	   validate_symref("HEAD") == 0) {
+	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
+	    validate_symref("HEAD") == 0) {
 		putenv("GIT_DIR=.");
 		check_repository_format();
-		return current_dir();
+		return path;
 	}
 
 	return NULL;
-- 
0.99.9.GIT

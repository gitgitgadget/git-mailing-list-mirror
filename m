From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Fri, 18 Nov 2005 15:19:24 -0800
Message-ID: <7voe4hfssj.fsf@assigned-by-dhcp.cox.net>
References: <20051117193714.428785C7FA@nox.op5.se>
	<7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:01:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdFWd-0000TM-MD
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 00:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVKRXT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 18:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVKRXT1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 18:19:27 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32393 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbVKRXT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 18:19:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118231829.CFLM17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 18:18:29 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437DAA66.6070301@op5.se> (Andreas Ericsson's message of "Fri, 18
	Nov 2005 11:18:14 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12297>

Andreas Ericsson <ae@op5.se> writes:

>> I think this list was added relatively recently as a usability
>> measure.  Maybe we would want an equivalent in enter_repo()?
>
> It's already there but in a different format.

I noticed that after I asked that question.  Thanks.

>> Under strict-path, I think not doing any DWIM like this is fine,
>> but otherwise I suspect changing this would break existing
>> remotes/origin file people may have.  In addition enter_repo()
>> as posted does its own DWIM to chdir to ".git" unconditionally
>> as I pointed out...
>
> DWIM? That's an acronym I don't know.

I think you got HPA's message about it and its security
implications.

>> Needs a bit more thought, but I think otherwise the basic idea
>> is right.
>
> Anything I should change before "take four" ?

I think it might make sense to inserting something like the
attached untested patch in your series, between library and
upload-pack.  The validation done by path_ok() in git-daemon
probabaly needs to lose alternate checks and validate only the
path returned by enter_repo().  This would make writing
whitelist by git-daemon administrator a bit more cumbersome, but
I suspect at the same time would make auditing easier.  So the
series would become:

[1/6] Library code for user-relative paths, take three.
[2/6] Do not DWIM in userpath library under strict mode.
[3/6] Server-side support for user-relative paths.
[4/6] Client side support for user-relative paths.
[5/6] Documentation update for user-relative paths.
[6/6] git-daemon support for user-relative paths.

-- >8 -- cut here -- >8 --
Subject: [PATCH] Do not DWIM in userpath library under strict mode.

This should force git-daemon administrator's job a bit harder
because the exact paths need to be given in the whitelist, but
at the same time makes the auditing easier.

This moves validate_symref() from refs.c to path.c, because we
need to link git-daemon with path.c for its "enter_repo()", but
we do not want to link the daemon with the rest of git libraries
and its requirements.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 path.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 refs.c |   40 ---------------------------------
 2 files changed, 60 insertions(+), 57 deletions(-)

applies-to: 7223b28ede4511977d1e71f45fb2867780027235
bd8770050ee2c8d7aa5b2c3f138bc65d83a974e8
diff --git a/path.c b/path.c
index 5b61709..d635470 100644
--- a/path.c
+++ b/path.c
@@ -91,20 +91,55 @@ char *safe_strncpy(char *dest, const cha
 	return dest;
 }
 
+int validate_symref(const char *path)
+{
+	struct stat st;
+	char *buf, buffer[256];
+	int len, fd;
+
+	if (lstat(path, &st) < 0)
+		return -1;
+
+	/* Make sure it is a "refs/.." symlink */
+	if (S_ISLNK(st.st_mode)) {
+		len = readlink(path, buffer, sizeof(buffer)-1);
+		if (len >= 5 && !memcmp("refs/", buffer, 5))
+			return 0;
+		return -1;
+	}
+
+	/*
+	 * Anything else, just open it and try to see if it is a symbolic ref.
+	 */
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	len = read(fd, buffer, sizeof(buffer)-1);
+	close(fd);
+
+	/*
+	 * Is it a symbolic ref?
+	 */
+	if (len < 4 || memcmp("ref:", buffer, 4))
+		return -1;
+	buf = buffer + 4;
+	len -= 4;
+	while (len && isspace(*buf))
+		buf++, len--;
+	if (len >= 5 && !memcmp("refs/", buf, 5))
+		return 0;
+	return -1;
+}
+
 static char *current_dir()
 {
 	return getcwd(pathname, sizeof(pathname));
 }
 
-/* Take a raw path from is_git_repo() and canonicalize it using Linus'
- * idea of a blind chdir() and getcwd(). */
-static const char *canonical_path(char *path, int strict)
+static int user_chdir(char *path)
 {
 	char *dir = path;
 
-	if(strict && *dir != '/')
-		return NULL;
-
 	if(*dir == '~') {		/* user-relative path */
 		struct passwd *pw;
 		char *slash = strchr(dir, '/');
@@ -125,19 +160,19 @@ static const char *canonical_path(char *
 
 		/* make sure we got something back that we can chdir() to */
 		if(!pw || chdir(pw->pw_dir) < 0)
-			return NULL;
+			return -1;
 
 		if(!slash || !slash[1]) /* no path following username */
-			return current_dir();
+			return 0;
 
 		dir = slash + 1;
 	}
 
 	/* ~foo/path/to/repo is now path/to/repo and we're in foo's homedir */
 	if(chdir(dir) < 0)
-		return NULL;
+		return -1;
 
-	return current_dir();
+	return 0;
 }
 
 char *enter_repo(char *path, int strict)
@@ -145,16 +180,24 @@ char *enter_repo(char *path, int strict)
 	if(!path)
 		return NULL;
 
-	if(!canonical_path(path, strict)) {
-		if(strict || !canonical_path(mkpath("%s.git", path), strict))
+	if (strict) {
+		if((path[0] != '/') || chdir(path) < 0)
 			return NULL;
 	}
+	else {
+		if (!*path)
+			; /* happy -- no chdir */
+		else if (!user_chdir(path))
+			; /* happy -- as given */
+		else if (!user_chdir(mkpath("%s.git", path)))
+			; /* happy -- uemacs --> uemacs.git */
+		else
+			return NULL;
+		(void)chdir(".git");
+	}
 
-	/* This is perfectly safe, and people tend to think of the directory
-	 * where they ran git-init-db as their repository, so humour them. */
-	(void)chdir(".git");
-
-	if(access("objects", X_OK) == 0 && access("refs", X_OK) == 0) {
+	if(access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
+	   validate_symref("HEAD") == 0) {
 		putenv("GIT_DIR=.");
 		return current_dir();
 	}
diff --git a/refs.c b/refs.c
index f324be5..ac26198 100644
--- a/refs.c
+++ b/refs.c
@@ -10,46 +10,6 @@
 #define USE_SYMLINK_HEAD 1
 #endif
 
-int validate_symref(const char *path)
-{
-	struct stat st;
-	char *buf, buffer[256];
-	int len, fd;
-
-	if (lstat(path, &st) < 0)
-		return -1;
-
-	/* Make sure it is a "refs/.." symlink */
-	if (S_ISLNK(st.st_mode)) {
-		len = readlink(path, buffer, sizeof(buffer)-1);
-		if (len >= 5 && !memcmp("refs/", buffer, 5))
-			return 0;
-		return -1;
-	}
-
-	/*
-	 * Anything else, just open it and try to see if it is a symbolic ref.
-	 */
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
-		return -1;
-	len = read(fd, buffer, sizeof(buffer)-1);
-	close(fd);
-
-	/*
-	 * Is it a symbolic ref?
-	 */
-	if (len < 4 || memcmp("ref:", buffer, 4))
-		return -1;
-	buf = buffer + 4;
-	len -= 4;
-	while (len && isspace(*buf))
-		buf++, len--;
-	if (len >= 5 && !memcmp("refs/", buf, 5))
-		return 0;
-	return -1;
-}
-
 const char *resolve_ref(const char *path, unsigned char *sha1, int reading)
 {
 	int depth = MAXDEPTH, len;
---
0.99.9.GIT

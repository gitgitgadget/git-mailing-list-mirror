From: Karl Chen <quarl@cs.berkeley.edu>
Subject: [PATCH v4] Expand ~ and ~user in core.excludesfile, commit.template
Date: Fri, 29 Aug 2008 02:29:00 -0700
Message-ID: <quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>
References: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
	<20080824220854.GA27299@coredump.intra.peff.net>
	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
	<20080824231343.GC27619@coredump.intra.peff.net>
	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
	<quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
	<20080827002506.GB7347@coredump.intra.peff.net>
	<quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
	<7vy72jrr00.fsf@gitster.siamese.dyndns.org>
	<quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
	<20080829032630.GA7024@coredump.intra.peff.net>
	<7vod3ca2ey.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0J3-0002IJ-1r
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbYH2J3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbYH2J3G
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:29:06 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:34341 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbYH2J3E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:29:04 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 3067334410; Fri, 29 Aug 2008 02:29:00 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vod3ca2ey.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 28 Aug 2008 21\:08\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


These config variables are parsed to substitute ~ and ~user with getpw
entries.

user_path() refactored into new function expand_user_path(), to allow
dynamically allocating the return buffer.

Signed-off-by: Karl Chen <quarl@quarl.org>
---

>>>>> On 2008-08-28 20:26 PDT, Jeff King writes:

    Peff> Documentation?

Documentation added.

    Peff> I am not sure about !**dest here. This precludes
    Peff> somebody from using "".  While it might not matter here,
    Peff> if there are other users of git_config_userdir(), they
    Peff> might want to allow a blank entry.

Point taken.

    Peff> 1. There seem to be extra tabs in the second line,
    Peff>    pushing the end_username argument way too far to the
    Peff>    right.

I had assumed that you guys use tab-width 4 instead of
c-basic-offset 8.  This is one of the reasons I never use tabs
when I can help it.

    Peff> 2. I'm not sure "strspan" is a good name for this
    Peff>    helper, since it calls to mind the strspn C function,
    Peff>    which is not really related to this at all.

Changed to getpw_str().

    Peff> 3. Usually helper functions that take a non-terminated
    Peff>    string like this in git use the combination of (char
    Peff>    *begin, int len) instead of two pointers. While you
    Peff>    are currently the only user of the helper, I think it
    Peff>    makes sense to follow that convention for future
    Peff>    users.

Point taken, changed as suggested.

    Peff> Also, you do a lot of early returns in your code. I
    Peff> think this is good, because it makes it more
    Peff> readable. But that means you don't have to worry about
    Peff> "else"ing the other half of the conditional, because you
    Peff> have already returned. Which makes it even easier to
    Peff> read.

Personally I think early returns without "else"ing is appropriate
for error conditions but not when it's a "do this" or "do that"
switch.  (I wonder if indenting 8 spaces has a long-term effect on
things like this?)  Anyway, I accept the color you picked for this
bikeshed.

    Peff> This function seems a little superfluous, since its
    Peff> semantics are so specific to this usage. I am all for
    Peff> splitting into little functions, but I think it would be
    Peff> quite confusing for somebody to try reusing
    Peff> this. Perhaps it at least needs a comment explaining the
    Peff> semantics of buf?

Comment added.

    Peff> Also, some of this code seems duplicated with
    Peff> concatstr. Wouldn't it just be simpler to let concatstr
    Peff> take a NULL for one of the arguments, and then just use
    Peff> it again here? IOW, something like:

    Peff>   if (!path)
    Peff>     return NULL;
    Peff>   if (path[0] != '~')
    Peff>     return concatstr(path, NULL);

Refactored as suggested.

    >> - if (!user_path(used_path, path, PATH_MAX))
    >> + if (!expand_user_path(used_path, path, PATH_MAX))

    Peff> But these functions don't have the same semantics, do
    Peff> they? user_path used to return NULL if the path didn't
    Peff> start with ~, right?

Yes, but user_path was only called when the input starts with ~.

>>>>> On 2008-08-28 21:08 PDT, Junio C Hamano writes:
    >>> + return git_config_userdir(&template_file, k, v);

    Junio> It is more like "pathname"; "userdir" is stressing only
    Junio> one aspect of the magic we would do to a value that is
    Junio> a pathname compared to a value that is a string without
    Junio> any magic.

Renamed as suggested.

    Junio> Avoidance of alloca() and c99 dynamic array on stack is
    Junio> deliberate in the current codebase.  Portable use of
    Junio> alloca() is quite hard to get right.

Alloca replaced with xmalloc+free.

>>>>> On 2008-08-29 00:00 PDT, Johannes Sixt writes:

    Hannes> Use strchrnul() instead of a home-grown
    Hannes> strchr_or_end().

Didn't know about strchrnul, thanks.

    Hannes> You really should use the strbuf API here. Look for
    Hannes> strbuf_detach() in the existing code.

Unfortunately expand_user_path() needs to support both a fixed
buffer and mallocing return.  I don't think the strbuf API can do
that easily?


 Documentation/config.txt |    4 ++-
 builtin-commit.c         |    2 +-
 cache.h                  |    2 +
 config.c                 |   11 +++++-
 path.c                   |   86 +++++++++++++++++++++++++++++-----------------
 5 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af57d94..05e846d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -346,7 +346,8 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.  See
+	of files which are not meant to be tracked.  "~" and "~user"
+	are expanded to the user's home directory.  See
 	linkgit:gitignore[5].
 
 core.editor::
@@ -554,6 +555,7 @@ color.status.<slot>::
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
+	"~" and "~user" are expanded to the user's home directory.
 
 color.ui::
 	When set to `always`, always use colors in all git commands which
diff --git a/builtin-commit.c b/builtin-commit.c
index 649c8be..905ebde 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -891,7 +891,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "commit.template"))
-		return git_config_string(&template_file, k, v);
+		return git_config_pathname(&template_file, k, v);
 
 	return git_status_config(k, v, cb);
 }
diff --git a/cache.h b/cache.h
index ab9f97e..3e04794 100644
--- a/cache.h
+++ b/cache.h
@@ -527,6 +527,7 @@ int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
+extern char *expand_user_path(char *buf, const char *path, int sz);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
@@ -748,6 +749,7 @@ extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
+extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 53f04a0..55353d9 100644
--- a/config.c
+++ b/config.c
@@ -334,6 +334,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_pathname(const char **dest, const char *var, const char *value) {
+	if (!value)
+		return config_error_nonbool(var);
+	*dest = expand_user_path(NULL, value, 0);
+	if (!*dest)
+		die("Failed to expand user dir in: '%s'", value);
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -457,7 +466,7 @@ static int git_default_core_config(const char *var, const char *value)
 		return git_config_string(&editor_program, var, value);
 
 	if (!strcmp(var, "core.excludesfile"))
-		return git_config_string(&excludes_file, var, value);
+		return git_config_pathname(&excludes_file, var, value);
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git a/path.c b/path.c
index 76e8872..016d072 100644
--- a/path.c
+++ b/path.c
@@ -137,46 +137,68 @@ int validate_headref(const char *path)
 	return -1;
 }
 
-static char *user_path(char *buf, char *path, int sz)
+static inline struct passwd *getpw_str(const char *username, size_t len)
 {
+	if (len == 0)
+		return getpwuid(getuid());
+
 	struct passwd *pw;
-	char *slash;
-	int len, baselen;
+	char *username_z = xmalloc(len + 1);
+	memcpy(username_z, username, len);
+	username_z[len] = '\0';
+	pw = getpwnam(username_z);
+	free(username_z);
+	return pw;
+}
 
-	if (!path || path[0] != '~')
-		return NULL;
-	path++;
-	slash = strchr(path, '/');
-	if (path[0] == '/' || !path[0]) {
-		pw = getpwuid(getuid());
-	}
-	else {
-		if (slash) {
-			*slash = 0;
-			pw = getpwnam(path);
-			*slash = '/';
-		}
-		else
-			pw = getpwnam(path);
-	}
-	if (!pw || !pw->pw_dir || sz <= strlen(pw->pw_dir))
-		return NULL;
-	baselen = strlen(pw->pw_dir);
-	memcpy(buf, pw->pw_dir, baselen);
-	while ((1 < baselen) && (buf[baselen-1] == '/')) {
-		buf[baselen-1] = 0;
-		baselen--;
-	}
-	if (slash && slash[1]) {
-		len = strlen(slash);
-		if (sz <= baselen + len)
+/*
+ * Return a string with input strings concatenated.  If buf != NULL, then
+ * it is the output buffer with size bufsz (including terminator); else the
+ * return buffer is xmalloced.  Second string can be NULL, in which case the
+ * first string is simply strduped/strcpyed.  Returns NULL if bufsz is too
+ * small.
+ */
+static inline char *concatstr(char *buf, const char *str1, const char *str2,
+			      size_t bufsz)
+{
+	size_t len1 = strlen(str1);
+	size_t len2 = str ? strlen(str2) : 0;
+	size_t needbuflen = len1 + len2 + 1;
+	if (buf) {
+		if (needbuflen > bufsz)
 			return NULL;
-		memcpy(buf + baselen, slash, len + 1);
+	} else {
+		buf = xmalloc(needbuflen);
 	}
+	memcpy(buf, str1, len1);
+	if (str2)
+		memcpy(buf+len1, str2, len2+1);
 	return buf;
 }
 
 /*
+ * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL, then
+ * it is the output buffer with size bufsz (including terminator); else the
+ * return buffer is xmalloced.  Returns NULL on getpw failure or if the input
+ * buffer is too small.
+ */
+char *expand_user_path(char *buf, const char *path, int bufsz)
+{
+	if (path == NULL)
+		return NULL;
+
+	if (path[0] != '~')
+		return concatstr(buf, path, NULL, bufsz);
+
+	const char *username = path + 1;
+	size_t username_len = strchrnul(username, '/') - username;
+	struct passwd *pw = getpw_str(username, username_len);
+	if (!pw)
+		return NULL;
+	return concatstr(buf, pw->pw_dir, username+username_len, bufsz);
+}
+
+/*
  * First, one directory to try is determined by the following algorithm.
  *
  * (0) If "strict" is given, the path is used as given and no DWIM is
@@ -221,7 +243,7 @@ char *enter_repo(char *path, int strict)
 		if (PATH_MAX <= len)
 			return NULL;
 		if (path[0] == '~') {
-			if (!user_path(used_path, path, PATH_MAX))
+			if (!expand_user_path(used_path, path, PATH_MAX))
 				return NULL;
 			strcpy(validated_path, path);
 			path = used_path;
-- 
1.5.6.3

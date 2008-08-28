From: Karl Chen <quarl@cs.berkeley.edu>
Subject: [PATCH v3] Expand ~ and ~user in core.excludesfile, commit.template
Date: Thu, 28 Aug 2008 02:09:38 -0700
Message-ID: <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
	<7vsksw92nh.fsf@gitster.siamese.dyndns.org>
	<quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
	<7vprnyqo59.fsf@gitster.siamese.dyndns.org>
	<20080824220854.GA27299@coredump.intra.peff.net>
	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
	<20080824231343.GC27619@coredump.intra.peff.net>
	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
	<quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
	<20080827002506.GB7347@coredump.intra.peff.net>
	<quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
	<7vy72jrr00.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 11:10:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYdWk-0006bQ-3N
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 11:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbYH1JJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 05:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYH1JJo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 05:09:44 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:51078 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbYH1JJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 05:09:43 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 893F63441D; Thu, 28 Aug 2008 02:09:38 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vy72jrr00.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 26 Aug 2008 22\:01\:03 -0700")
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

>>>>> On 2008-08-26 22:01 PDT, Junio C Hamano writes:

>>>>> On 2008-08-26 17:25 PDT, Jeff King writes:
    >> 
    Jeff> 1. It should probably re-use path.c:user_path, as
    Jeff> Johannes mentioned.
    >> 
    >> That function has the wrong interface for this task
    >> (requires extra strdup, imposes PATH_MAX, conflates all
    >> error conditions into returning NULL, also returns NULL if
    >> input doesn't have "~").  Do you still think it should
    >> re-use that function?

    Junio> On the other hand you have a pair of ugly "casting a
    Junio> const pointer down, temporarily modifying what is
    Junio> const" in your version.

user_path() does the same thing; it's just obscured by the lack of
type qualifiers.  I rationalized it because git has much bigger
problems if threading support were added.  But I agree it's ugly.
The new patch avoids it.

    Junio> In any case, I think their point is that these two
    Junio> functions are meant to do the same thing, and a unified
    Junio> interface would be desirable.

There is a lot of refactoring I would do were I maintaining the
code.  I figured a minimally invasive change would be more easily
accepted.  Anyway here is a patch to unify "~" expansion.

 builtin-commit.c |    2 +-
 cache.h          |    2 +
 config.c         |   13 +++++++-
 path.c           |   88 +++++++++++++++++++++++++++++++++--------------------
 4 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 649c8be..e510207 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -891,7 +891,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "commit.template"))
-		return git_config_string(&template_file, k, v);
+		return git_config_userdir(&template_file, k, v);
 
 	return git_status_config(k, v, cb);
 }
diff --git a/cache.h b/cache.h
index ab9f97e..096fd9d 100644
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
+extern int git_config_userdir(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 53f04a0..3395283 100644
--- a/config.c
+++ b/config.c
@@ -334,6 +334,14 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_userdir(const char **dest, const char *var, const char *value) {
+	if (!value)
+		return config_error_nonbool(var);
+	*dest = expand_user_path(NULL, value, 0);
+	if (!*dest || !**dest) die("Failed to expand user dir in: '%s'", value);
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -456,8 +464,9 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
-	if (!strcmp(var, "core.excludesfile"))
-		return git_config_string(&excludes_file, var, value);
+	if (!strcmp(var, "core.excludesfile")) {
+		return git_config_userdir(&excludes_file, var, value);
+	}
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git a/path.c b/path.c
index 76e8872..ef6dbaa 100644
--- a/path.c
+++ b/path.c
@@ -137,43 +137,65 @@ int validate_headref(const char *path)
 	return -1;
 }
 
-static char *user_path(char *buf, char *path, int sz)
+static inline struct passwd *getpw_strspan(const char *begin_username,
+										   const char *end_username)
 {
-	struct passwd *pw;
-	char *slash;
-	int len, baselen;
-
-	if (!path || path[0] != '~')
-		return NULL;
-	path++;
-	slash = strchr(path, '/');
-	if (path[0] == '/' || !path[0]) {
-		pw = getpwuid(getuid());
+	if (begin_username == end_username) {
+		return getpwuid(getuid());
+	} else {
+		size_t username_len = end_username - begin_username;
+		char *username = alloca(username_len + 1);
+		memcpy(username, begin_username, username_len);
+		username[username_len] = '\0';
+		return getpwnam(username);
 	}
-	else {
-		if (slash) {
-			*slash = 0;
-			pw = getpwnam(path);
-			*slash = '/';
-		}
-		else
-			pw = getpwnam(path);
+}
+
+static inline char *concatstr(char *buf, const char *str1, const char *str2,
+							  size_t bufsz)
+{
+	size_t len1 = strlen(str1);
+	size_t len2 = strlen(str2);
+	size_t needbuflen = len1 + len2 + 1;
+	if (buf) {
+		if (needbuflen > bufsz) return NULL;
+	} else {
+		buf = xmalloc(needbuflen);
 	}
-	if (!pw || !pw->pw_dir || sz <= strlen(pw->pw_dir))
+	memcpy(buf, str1, len1);
+	memcpy(buf+len1, str2, len2+1);
+	return buf;
+}
+
+static inline const char *strchr_or_end(const char *str, char c)
+{
+	while (*str && *str != c) ++str;
+	return str;
+}
+
+/*
+ * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL, then
+ * it is the output buffer with size sz (including terminator); else the
+ * return buffer is xmalloced.  Returns NULL on getpw failure or if the input
+ * buffer is too small.
+ */
+char *expand_user_path(char *buf, const char *path, int sz)
+{
+	if (path == NULL) {
 		return NULL;
-	baselen = strlen(pw->pw_dir);
-	memcpy(buf, pw->pw_dir, baselen);
-	while ((1 < baselen) && (buf[baselen-1] == '/')) {
-		buf[baselen-1] = 0;
-		baselen--;
-	}
-	if (slash && slash[1]) {
-		len = strlen(slash);
-		if (sz <= baselen + len)
-			return NULL;
-		memcpy(buf + baselen, slash, len + 1);
+	} else if (path[0] != '~') {
+		if (buf == NULL) {
+			return xstrdup(path);
+		} else {
+			if (strlen(path)+1 > sz) return NULL;
+			return strcpy(buf, path);
+		}
+	} else {
+		const char *after_username = strchr_or_end(path+1, '/');
+		struct passwd *pw = getpw_strspan(path+1, after_username);
+		if (!pw) return NULL;
+		return concatstr(buf, pw->pw_dir, after_username, sz);
 	}
-	return buf;
 }
 
 /*
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

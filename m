From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 18:24:25 +0100
Message-ID: <1258478665-8635-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Karl Chen <quarl@quarl.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 17 18:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NARoC-0000Gw-Ra
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 18:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbZKQRZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 12:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbZKQRZ1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 12:25:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:32799 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756131AbZKQRZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 12:25:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAHHNkFY011353
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 18:23:46 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NARnL-0005Dh-U4; Tue, 17 Nov 2009 18:24:47 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NARnL-0002Fw-Qv; Tue, 17 Nov 2009 18:24:47 +0100
X-Mailer: git-send-email 1.6.5.2.152.gbbe9e
In-Reply-To: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Nov 2009 18:23:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAHHNkFY011353
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1259083429.81846@IauPH/4B7QXaEL+LMl1p5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133092>

These config variables are parsed to substitute ~ and ~user with getpw
entries.

user_path() refactored into new function expand_user_path(), to allow
dynamically allocating the return buffer.

Original patch by Karl Chen, modified by Matthieu Moy, and further
amended by Junio C Hamano.

Signed-off-by: Karl Chen <quarl@quarl.org>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Here's the new version, with Junio's modifications squashed in.

I just replaced "user" with "specified user" to make it clear one can
specify a user with ~foo/, but since the documentation appears in two
places (possibly more in the future), I prefered to Keep It Simple.

 Documentation/config.txt |    4 ++-
 builtin-commit.c         |    2 +-
 cache.h                  |    2 +
 config.c                 |   12 ++++++-
 path.c                   |   80 ++++++++++++++++++++++++++-------------------
 5 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1e2120..475d544 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -380,7 +380,8 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.  See
+	of files which are not meant to be tracked.  "~/" and "~user/"
+	are expanded to the specified user's home directory.  See
 	linkgit:gitignore[5].
 
 core.editor::
@@ -670,6 +671,7 @@ color.ui::
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
+	"~/" and "~user/" are expanded to the specified user's home directory.
 
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
diff --git a/builtin-commit.c b/builtin-commit.c
index d525b89..09d2840 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -999,7 +999,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	struct wt_status *s = cb;
 
 	if (!strcmp(k, "commit.template"))
-		return git_config_string(&template_file, k, v);
+		return git_config_pathname(&template_file, k, v);
 
 	return git_status_config(k, v, s);
 }
diff --git a/cache.h b/cache.h
index 71a731d..42f7cd8 100644
--- a/cache.h
+++ b/cache.h
@@ -645,6 +645,7 @@ int set_shared_perm(const char *path, int mode);
 #define adjust_shared_perm(path) set_shared_perm((path), 0)
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
+extern char *expand_user_path(const char *path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
@@ -903,6 +904,7 @@ extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
+extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index c644061..b3d1ff4 100644
--- a/config.c
+++ b/config.c
@@ -351,6 +351,16 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_pathname(const char **dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	*dest = expand_user_path(value);
+	if (!*dest)
+		die("Failed to expand user dir in: '%s'", value);
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -474,7 +484,7 @@ static int git_default_core_config(const char *var, const char *value)
 		return git_config_string(&editor_program, var, value);
 
 	if (!strcmp(var, "core.excludesfile"))
-		return git_config_string(&excludes_file, var, value);
+		return git_config_pathname(&excludes_file, var, value);
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git a/path.c b/path.c
index 047fdb0..2470f78 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "strbuf.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -207,43 +208,44 @@ int validate_headref(const char *path)
 	return -1;
 }
 
-static char *user_path(char *buf, char *path, int sz)
+static struct passwd *getpw_str(const char *username, size_t len)
 {
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
-			return NULL;
-		memcpy(buf + baselen, slash, len + 1);
+/*
+ * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL,
+ * then it is a newly allocated string. Returns NULL on getpw failure or
+ * if path is NULL.
+ */
+char *expand_user_path(const char *path)
+{
+	struct strbuf user_path = STRBUF_INIT;
+	const char *first_slash = strchrnul(path, '/');
+	const char *to_copy = path;
+
+	if (path == NULL)
+		goto return_null;
+	if (path[0] == '~') {
+		const char *username = path + 1;
+		size_t username_len = first_slash - username;
+		struct passwd *pw = getpw_str(username, username_len);
+		if (!pw)
+			goto return_null;
+		strbuf_add(&user_path, pw->pw_dir, strlen(pw->pw_dir));
+		to_copy = first_slash;
 	}
-	return buf;
+	strbuf_add(&user_path, to_copy, strlen(to_copy));
+	return strbuf_detach(&user_path, NULL);
+return_null:
+	strbuf_release(&user_path);
+	return NULL;
 }
 
 /*
@@ -291,8 +293,18 @@ char *enter_repo(char *path, int strict)
 		if (PATH_MAX <= len)
 			return NULL;
 		if (path[0] == '~') {
-			if (!user_path(used_path, path, PATH_MAX))
+			char *newpath = expand_user_path(path);
+			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
+				free(newpath);
 				return NULL;
+			}
+			/*
+			 * Copy back into the static buffer. A pity
+			 * since newpath was not bounded, but other
+			 * branches of the if are limited by PATH_MAX
+			 * anyway.
+			 */
+			strcpy(used_path, newpath); free(newpath);
 			strcpy(validated_path, path);
 			path = used_path;
 		}
-- 
1.6.5.2.152.gbbe9e

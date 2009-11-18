From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4] Expand ~ and ~user in core.excludesfile, commit.template
Date: Wed, 18 Nov 2009 09:58:13 +0100
Message-ID: <1258534693-7220-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1258529351-4045-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Karl Chen <quarl@quarl.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 18 09:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAgNl-00064F-Qh
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 09:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbZKRI7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 03:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754708AbZKRI7J
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 03:59:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47606 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbZKRI7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 03:59:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAI8vJIG002529
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Nov 2009 09:57:20 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NAgMp-0004vB-6C; Wed, 18 Nov 2009 09:58:23 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NAgMp-0001t3-52; Wed, 18 Nov 2009 09:58:23 +0100
X-Mailer: git-send-email 1.6.5.2.152.gbbe9e
In-Reply-To: <1258529351-4045-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Nov 2009 09:57:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAI8vJIG002529
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1259139443.42976@J7q/YiueWgZnLt1/qXGJ4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133157>

These config variables are parsed to substitute ~ and ~user with getpw
entries.

user_path() refactored into new function expand_user_path(), to allow
dynamically allocating the return buffer.

Original patch by Karl Chen, modified by Matthieu Moy, and further
amended by Junio C Hamano.

Signed-off-by: Karl Chen <quarl@quarl.org>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
"Oops, I did it again :-("

Just a style issue since v3 (char * home -> char *home), sorry for the noise.

 Documentation/config.txt |    7 +++-
 builtin-commit.c         |    2 +-
 cache.h                  |    2 +
 config.c                 |   12 ++++++-
 path.c                   |   83 +++++++++++++++++++++++++++------------------
 5 files changed, 69 insertions(+), 37 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 78ee906..b4fe843 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -380,8 +380,9 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.  See
-	linkgit:gitignore[5].
+	of files which are not meant to be tracked.  "~/" is expanded
+	to the value of `$HOME` and "~user/" to the specified user's
+	home directory.  See linkgit:gitignore[5].
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
@@ -681,6 +682,8 @@ color.ui::
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
+	"~/" is expanded to the value of `$HOME` and "~user/" to the
+	specified user's home directory.
 
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
diff --git a/builtin-commit.c b/builtin-commit.c
index 0fd7af6..87d1b90 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1175,7 +1175,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	struct wt_status *s = cb;
 
 	if (!strcmp(k, "commit.template"))
-		return git_config_string(&template_file, k, v);
+		return git_config_pathname(&template_file, k, v);
 
 	return git_status_config(k, v, s);
 }
diff --git a/cache.h b/cache.h
index f7533ff..2ba9690 100644
--- a/cache.h
+++ b/cache.h
@@ -649,6 +649,7 @@ int set_shared_perm(const char *path, int mode);
 #define adjust_shared_perm(path) set_shared_perm((path), 0)
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
+extern char *expand_user_path(const char *path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
@@ -909,6 +910,7 @@ extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
+extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 51f2208..37385ce 100644
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
@@ -479,7 +489,7 @@ static int git_default_core_config(const char *var, const char *value)
 		return git_config_string(&editor_program, var, value);
 
 	if (!strcmp(var, "core.excludesfile"))
-		return git_config_string(&excludes_file, var, value);
+		return git_config_pathname(&excludes_file, var, value);
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git a/path.c b/path.c
index c7679be..2ec950b 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "strbuf.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -207,43 +208,49 @@ int validate_headref(const char *path)
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
+		if (username_len == 0) {
+			const char *home = getenv("HOME");
+			strbuf_add(&user_path, home, strlen(home));
+		} else {
+			struct passwd *pw = getpw_str(username, username_len);
+			if (!pw)
+				goto return_null;
+			strbuf_add(&user_path, pw->pw_dir, strlen(pw->pw_dir));
 		}
-		else
-			pw = getpwnam(path);
+		to_copy = first_slash;
 	}
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
-	}
-	return buf;
+	strbuf_add(&user_path, to_copy, strlen(to_copy));
+	return strbuf_detach(&user_path, NULL);
+return_null:
+	strbuf_release(&user_path);
+	return NULL;
 }
 
 /*
@@ -291,8 +298,18 @@ char *enter_repo(char *path, int strict)
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

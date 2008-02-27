From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 10/40] Windows: Treat Windows style path names.
Date: Wed, 27 Feb 2008 19:54:33 +0100
Message-ID: <1204138503-6126-11-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVN-00022R-2x
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbYB0Szg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbYB0Sze
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:34 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40432 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300AbYB0SzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:08 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 9700997600;
	Wed, 27 Feb 2008 19:55:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75257>

GIT's guts work with a forward slash as a path separators. We do not change
that. Rather we make sure that only "normalized" paths enter the depths
of the machinery.

We have to translate backslashes to forward slashes in the prefix and in
command line arguments. Fortunately, all of them are passed through
functions in setup.c.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 cache.h           |    4 +++
 compat/mingw.c    |   16 ++++++++++++++
 git-compat-util.h |    3 ++
 setup.c           |   59 +++++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index e1000bc..3e4e10a 100644
--- a/cache.h
+++ b/cache.h
@@ -441,7 +441,11 @@ int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
+#ifndef __MINGW32__
 	return path[0] == '/';
+#else
+	return path[0] == '/' || (path[0] && path[1] == ':');
+#endif
 }
 const char *make_absolute_path(const char *path);
 
diff --git a/compat/mingw.c b/compat/mingw.c
index 733ef87..71bca96 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -60,6 +60,22 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 	return result;
 }
 
+#undef getcwd
+char *mingw_getcwd(char *pointer, int len)
+{
+	char *ret = getcwd(pointer, len);
+	if (!ret)
+		return ret;
+	if (pointer[0] != 0 && pointer[1] == ':') {
+		int i;
+		for (i = 2; pointer[i]; i++)
+			/* Thanks, Bill. You'll burn in hell for that. */
+			if (pointer[i] == '\\')
+				pointer[i] = '/';
+	}
+	return ret;
+}
+
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index f44a287..3b57464 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -592,6 +592,9 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
+char *mingw_getcwd(char *pointer, int len);
+#define getcwd mingw_getcwd
+
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
diff --git a/setup.c b/setup.c
index dc247a8..77cc461 100644
--- a/setup.c
+++ b/setup.c
@@ -4,13 +4,26 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
+#ifdef __MINGW32__
+static inline int is_dir_sep(char c) { return c == '/' || c == '\\'; }
+#else
+static inline int is_dir_sep(char c) { return c == '/'; }
+#endif
+
 static int sanitary_path_copy(char *dst, const char *src)
 {
 	char *dst0 = dst;
 
-	if (*src == '/') {
+#ifdef __MINGW32__
+	if (isalpha(*src) && src[1] == ':') {
+		*dst++ = *src++;
+		*dst++ = *src++;
+		dst0 = dst;
+	}
+#endif
+	if (is_dir_sep(*src)) {
 		*dst++ = '/';
-		while (*src == '/')
+		while (is_dir_sep(*src))
 			src++;
 	}
 
@@ -32,9 +45,12 @@ static int sanitary_path_copy(char *dst, const char *src)
 				src++;
 				break;
 			case '/':
+#ifdef __MINGW32__
+			case '\\':
+#endif
 				/* (2) */
 				src += 2;
-				while (*src == '/')
+				while (is_dir_sep(*src))
 					src++;
 				continue;
 			case '.':
@@ -44,9 +60,12 @@ static int sanitary_path_copy(char *dst, const char *src)
 					src += 2;
 					goto up_one;
 				case '/':
+#ifdef __MINGW32__
+				case '\\':
+#endif
 					/* (4) */
 					src += 3;
-					while (*src == '/')
+					while (is_dir_sep(*src))
 						src++;
 					goto up_one;
 				}
@@ -54,11 +73,11 @@ static int sanitary_path_copy(char *dst, const char *src)
 		}
 
 		/* copy up to the next '/', and eat all '/' */
-		while ((c = *src++) != '\0' && c != '/')
+		while ((c = *src++) != '\0' && !is_dir_sep(c))
 			*dst++ = c;
-		if (c == '/') {
-			*dst++ = c;
-			while (c == '/')
+		if (is_dir_sep(c)) {
+			*dst++ = '/';
+			while (is_dir_sep(c))
 				c = *src++;
 			src--;
 		} else if (!c)
@@ -77,7 +96,7 @@ static int sanitary_path_copy(char *dst, const char *src)
 			if (dst <= dst0)
 				break;
 			c = *dst--;
-			if (c == '/') {
+			if (c == '/') {	/* MinGW: cannot be '\\' anymore */
 				dst += 2;
 				break;
 			}
@@ -126,10 +145,23 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
+#ifndef __MINGW32__
 	if (!pfx || !*pfx || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
 	strcpy(path + pfx_len, arg);
+#else
+	char *p;
+	/* don't add prefix to absolute paths, but still replace '\' by '/' */
+	if (is_absolute_path(arg))
+		pfx_len = 0;
+	else
+		memcpy(path, pfx, pfx_len);
+	strcpy(path + pfx_len, arg);
+	for (p = path + pfx_len; *p; p++)
+		if (*p == '\\')
+			*p = '/';
+#endif
 	return path;
 }
 
@@ -322,6 +354,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	int len, offset;
+	int minoffset = 0;
 
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
@@ -364,6 +397,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
+#ifdef __MINGW32__
+	if (cwd[1] == ':')
+		minoffset = 2;
+#endif
 
 	/*
 	 * Test in the following order (relative to the cwd):
@@ -388,7 +425,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		chdir("..");
 		do {
-			if (!offset) {
+			if (offset <= minoffset) {
 				if (nongit_ok) {
 					if (chdir(cwd))
 						die("Cannot come back to cwd");
@@ -397,7 +434,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				}
 				die("Not a git repository");
 			}
-		} while (cwd[--offset] != '/');
+		} while (offset > minoffset && cwd[--offset] != '/');
 	}
 
 	inside_git_dir = 0;
-- 
1.5.4.1.126.ge5a7d

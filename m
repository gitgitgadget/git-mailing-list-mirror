From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 01:55:47 +0100
Message-ID: <201001250155.47664.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 01:58:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZDHj-000108-8Y
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 01:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab0AYA42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 19:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229Ab0AYA42
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 19:56:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:19328 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab0AYA41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 19:56:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2232C147E152;
	Mon, 25 Jan 2010 01:56:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ps-Zipks40fx; Mon, 25 Jan 2010 01:55:57 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 994B880034C;
	Mon, 25 Jan 2010 01:55:48 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137931>

>From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Mon, 25 Jan 2010 01:41:03 +0100
Subject: [PATCH] Handle UNC paths everywhere

In Windows paths beginning with // are knows as UNC paths. They are
absolute paths, usually referring to a shared resource on a server.

Examples of legal UNC paths

	\\hub\repos\repo
	\\?\unc\hub\repos
	\\?\d:\repo

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 cache.h           |    2 +-
 compat/basename.c |    2 +-
 compat/mingw.h    |    8 +++++++-
 connect.c         |    2 +-
 git-compat-util.h |    9 +++++++++
 path.c            |    2 +-
 setup.c           |    2 +-
 sha1_file.c       |   20 ++++++++++++++++++++
 transport.c       |    2 +-
 9 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 767a50e..8f63640 100644
--- a/cache.h
+++ b/cache.h
@@ -648,7 +648,7 @@ int safe_create_leading_directories_const(const char 
*path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
-	return path[0] == '/' || has_dos_drive_prefix(path);
+	return path[0] == '/' || has_win32_abs_prefix(path);
 }
 int is_directory(const char *);
 const char *make_absolute_path(const char *path);
diff --git a/compat/basename.c b/compat/basename.c
index d8f8a3c..c1d81f6 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -5,7 +5,7 @@ char *gitbasename (char *path)
 {
 	const char *base;
 	/* Skip over the disk name in MSDOS pathnames. */
-	if (has_dos_drive_prefix(path))
+	if (has_win32_abs_prefix(path))
 		path += 2;
 	for (base = path; *path; path++) {
 		if (is_dir_sep(*path))
diff --git a/compat/mingw.h b/compat/mingw.h
index 1b528da..d1aa8be 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -210,7 +210,13 @@ int winansi_fprintf(FILE *stream, const char *format, 
...) __attribute__((format
  * git specific compatibility
  */
 
-#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':')
+#define has_unc_prefix(path) \
+	(is_dir_sep((path)[0]) && is_dir_sep((path)[1]))
+#define has_win32_abs_prefix(path) \
+	(has_dos_drive_prefix(path) || has_unc_prefix(path))
+
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
diff --git a/connect.c b/connect.c
index 7945e38..9d4556c 100644
--- a/connect.c
+++ b/connect.c
@@ -535,7 +535,7 @@ struct child_process *git_connect(int fd[2], const char 
*url_orig,
 		end = host;
 
 	path = strchr(end, c);
-	if (path && !has_dos_drive_prefix(end)) {
+	if (path && !has_win32_abs_prefix(end)) {
 		if (c == ':') {
 			protocol = PROTO_SSH;
 			*path++ = '\0';
diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..0de9dac 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -170,6 +170,15 @@ extern char *gitbasename(char *);
 #define has_dos_drive_prefix(path) 0
 #endif
 
+#ifndef has_unc_prefix
+#define has_unc_prefix(path) 0
+#endif
+
+#ifndef has_win32_abs_prefix
+#error no abs
+#define has_win32_abs_prefix(path) 0
+#endif
+
 #ifndef is_dir_sep
 #define is_dir_sep(c) ((c) == '/')
 #endif
diff --git a/path.c b/path.c
index 047fdb0..79451a2 100644
--- a/path.c
+++ b/path.c
@@ -409,7 +409,7 @@ int normalize_path_copy(char *dst, const char *src)
 {
 	char *dst0;
 
-	if (has_dos_drive_prefix(src)) {
+	if (has_win32_abs_prefix(src)) {
 		*dst++ = *src++;
 		*dst++ = *src++;
 	}
diff --git a/setup.c b/setup.c
index 029371e..4f72817 100644
--- a/setup.c
+++ b/setup.c
@@ -342,7 +342,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno("Unable to read current working directory");
 
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
-	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
+	if (ceil_offset < 0 && has_win32_abs_prefix(cwd))
 		ceil_offset = 1;
 
 	/*
diff --git a/sha1_file.c b/sha1_file.c
index 4cc8939..f1ad3f5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -87,6 +87,26 @@ static inline int offset_1st_component(const char *path)
 {
 	if (has_dos_drive_prefix(path))
 		return 2 + (path[2] == '/');
+	if (has_unc_prefix(path)) {
+		int p = 2;
+		int skip;
+		if (path[p] == '?') {
+			if (path[p+1] && !has_dos_drive_prefix(path+p+2)) {
+				skip = 3;
+			} else {
+				skip = 2;
+			}
+		} else
+			skip = 2;
+
+		while (skip && path[p]) {
+			if (is_dir_sep(path[p]))
+				--skip;
+			++p;
+		}
+		printf("Left with %s\n", path+p);
+		return p;
+	}
 	return *path == '/';
 }
 
diff --git a/transport.c b/transport.c
index 644a30a..9f5b24e 100644
--- a/transport.c
+++ b/transport.c
@@ -797,7 +797,7 @@ static int is_local(const char *url)
 	const char *colon = strchr(url, ':');
 	const char *slash = strchr(url, '/');
 	return !colon || (slash && slash < colon) ||
-		has_dos_drive_prefix(url);
+		has_win32_abs_prefix(url);
 }
 
 static int is_file(const char *url)
-- 
1.6.4.msysgit.0.598.g37a74

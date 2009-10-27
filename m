From: Timur Sufiev <timur@iris-comp.ru>
Subject: [PATCH 4/4] Make mingw-compatibility layer to be aware of I18N-wrappers
Date: Tue, 27 Oct 2009 16:54:03 +0300
Message-ID: <1256651643-18382-4-git-send-email-timur@iris-comp.ru>
References: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
 <1256651643-18382-2-git-send-email-timur@iris-comp.ru>
 <1256651643-18382-3-git-send-email-timur@iris-comp.ru>
Cc: Timur Sufiev <timur@iris-comp.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 15:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2meL-00053H-N6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbZJ0ODI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZJ0ODH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:03:07 -0400
Received: from [195.93.180.178] ([195.93.180.178]:52019 "EHLO
	mail.iris-comp.ru" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755421AbZJ0ODF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:03:05 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2009 10:03:04 EDT
Received: from localhost (unknown [80.90.116.82])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.iris-comp.ru (Postfix) with ESMTPSA id 042B0E99B;
	Tue, 27 Oct 2009 16:54:46 +0300 (MSK)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256651643-18382-3-git-send-email-timur@iris-comp.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131338>

Signed-off-by: Timur Sufiev <timur@iris-comp.ru>
---
 compat/fopen.c       |    5 +++--
 compat/mingw.c       |   24 ++++++++++++++++++------
 compat/mingw.h       |   12 ++++++++++++
 compat/mkstemps.c    |    3 ++-
 compat/regex/regex.c |    9 ++++++++-
 compat/regex/regex.h |    3 +++
 compat/win32.h       |   13 +++++++++++--
 io-i18n.h            |    8 ++++++++
 8 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/compat/fopen.c b/compat/fopen.c
index b5ca142..9136a14 100644
--- a/compat/fopen.c
+++ b/compat/fopen.c
@@ -10,6 +10,7 @@
  */
 #undef FREAD_READS_DIRECTORIES
 #include "../git-compat-util.h"
+#include "io-i18n.h"
 
 FILE *git_fopen(const char *path, const char *mode)
 {
@@ -17,9 +18,9 @@ FILE *git_fopen(const char *path, const char *mode)
 	struct stat st;
 
 	if (mode[0] == 'w' || mode[0] == 'a')
-		return fopen(path, mode);
+		return fopen_i18n(path, mode);
 
-	if (!(fp = fopen(path, mode)))
+	if (!(fp = fopen_i18n(path, mode)))
 		return NULL;
 
 	if (fstat(fileno(fp), &st)) {
diff --git a/compat/mingw.c b/compat/mingw.c
index 6b5b5b2..9cb135a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -253,7 +253,7 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	int fh, rc;
 
 	/* must have write permission */
-	if ((fh = open(file_name, O_RDWR | O_BINARY)) < 0)
+	if ((fh = open_i18n(file_name, O_RDWR | O_BINARY, DEFAULT_OPEN_MODE)) < 0)
 		return -1;
 
 	time_t_to_filetime(times->modtime, &mft);
@@ -278,7 +278,7 @@ int mkstemp(char *template)
 	char *filename = mktemp(template);
 	if (filename == NULL)
 		return -1;
-	return open(filename, O_RDWR | O_CREAT, 0600);
+	return open_i18n(filename, O_RDWR | O_CREAT, 0600);
 }
 
 int gettimeofday(struct timeval *tv, void *tz)
@@ -519,7 +519,7 @@ static const char *parse_interpreter(const char *cmd)
 	if (n >= 4 && !strcasecmp(cmd+n-4, ".exe"))
 		return NULL;
 
-	fd = open(cmd, O_RDONLY);
+	fd = open_i18n(cmd, O_RDONLY, DEFAULT_OPEN_MODE);
 	if (fd < 0)
 		return NULL;
 	n = read(fd, buf, sizeof(buf)-1);
@@ -1135,10 +1135,14 @@ sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 static const char *make_backslash_path(const char *path)
 {
 	static char buf[PATH_MAX + 1];
+	char *out = filename_to_local(path);
 	char *c;
 
-	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-		die("Too long path: %.*s", 60, path);
+	if ( strlcpy(buf, out ? out : path, PATH_MAX) >= PATH_MAX) {
+	     die("Too long path: %.*s", 60, out ? out : path);
+	     free(out);
+	}
+	free(out);
 
 	for (c = buf; *c; c++) {
 		if (*c == '/')
@@ -1158,6 +1162,9 @@ int link(const char *oldpath, const char *newpath)
 {
 	typedef BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
+	char *old_out = filename_to_local(oldpath);
+	char *new_out = filename_to_local(newpath);
+
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
 			GetModuleHandle("kernel32.dll"), "CreateHardLinkA");
@@ -1168,10 +1175,15 @@ int link(const char *oldpath, const char *newpath)
 		errno = ENOSYS;
 		return -1;
 	}
-	if (!create_hard_link(newpath, oldpath, NULL)) {
+	if (!create_hard_link(new_out ? new_out : newpath,
+			      old_out ? old_out : oldpath, NULL)) {
+		free(new_out);
+		free(old_out);
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
+	free(new_out);
+	free(old_out);
 	return 0;
 }
 
diff --git a/compat/mingw.h b/compat/mingw.h
index 5b5258b..0d1dc83 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,5 +1,16 @@
+#ifndef GIT_MINGW_H
+#define GIT_MINGW_H
 #include <winsock2.h>
 
+/* 3 following lines are taken from io-i18n.h because we cannot
+   include it here: if we do so, readdir_i18n prototype will
+   be inconsistent with with other code which properly uses all
+   mingw defines
+*/
+char *filename_to_local (const char* filename);
+int open_i18n(const char *filename, int flags, mode_t mode);
+#define DEFAULT_OPEN_MODE 0
+
 /*
  * things that are not available in header files
  */
@@ -273,3 +284,4 @@ struct mingw_dirent
 #define readdir(x) mingw_readdir(x)
 struct dirent *mingw_readdir(DIR *dir);
 #endif // !NO_MINGW_REPLACE_READDIR
+#endif // GIT_MINGW_H
diff --git a/compat/mkstemps.c b/compat/mkstemps.c
index 14179c8..0cdd42d 100644
--- a/compat/mkstemps.c
+++ b/compat/mkstemps.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../io-i18n.h"
 
 /* Adapted from libiberty's mkstemp.c. */
 
@@ -47,7 +48,7 @@ int gitmkstemps(char *pattern, int suffix_len)
 		template[4] = letters[v % num_letters]; v /= num_letters;
 		template[5] = letters[v % num_letters]; v /= num_letters;
 
-		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, 0600);
+		fd = open_i18n(pattern, O_CREAT | O_EXCL | O_RDWR, 0600);
 		if (fd > 0)
 			return fd;
 		/*
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 67d5c37..2deec55 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -450,8 +450,15 @@ static int debug = 0;
 #define DEBUG_PRINT_DOUBLE_STRING(w, s1, sz1, s2, sz2)			\
   if (debug) print_double_string (w, s1, sz1, s2, sz2)
 
-
+#ifdef __USE_MINGW_ACCESS
+void
+ printchar(char c)
+{
+  putc(c, stderr);
+}
+#else
 extern void printchar ();
+#endif // __USE_MINGW_ACCESS
 
 /* Print the fastmap in human-readable form.  */
 
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 6eb64f1..a5f2809 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -29,6 +29,9 @@
 #include <stddef.h>
 #endif
 
+#ifdef __USE_MINGW_ACCESS
+#include <conio.h>
+#endif
 
 /* The following bits are used to determine the regexp syntax we
    recognize.  The set/not-set meanings are chosen so that Emacs syntax
diff --git a/compat/win32.h b/compat/win32.h
index 8ce9104..f71e36d 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -20,8 +20,17 @@ static inline int file_attr_to_st_mode (DWORD attr)
 
 static inline int get_file_attr(const char *fname, WIN32_FILE_ATTRIBUTE_DATA *fdata)
 {
-	if (GetFileAttributesExA(fname, GetFileExInfoStandard, fdata))
-		return 0;
+	char *out = filename_to_local(fname);
+	int ret;
+
+	if ( out != NULL ) {
+	     ret = GetFileAttributesExA(out, GetFileExInfoStandard, fdata);
+	     free(out);
+	} else
+	     ret = GetFileAttributesExA(fname, GetFileExInfoStandard, fdata);
+
+	if ( ret )
+	     return 0;
 
 	switch (GetLastError()) {
 	case ERROR_ACCESS_DENIED:
diff --git a/io-i18n.h b/io-i18n.h
index c386e20..7329105 100644
--- a/io-i18n.h
+++ b/io-i18n.h
@@ -6,6 +6,14 @@
 #include <sys/stat.h>
 #include <dirent.h>
 #include <stdio.h>
+#include <limits.h>
+
+#ifdef __USE_MINGW_ACCESS
+#include <windows.h>
+#define NAME_MAX MAX_PATH
+#define stat _stati64
+#define dirent mingw_dirent
+#endif
 
 #define DEFAULT_OPEN_MODE 0
 
-- 
1.6.5.1

From: Timur Sufiev <timur@iris-comp.ru>
Subject: [PATCH I18N filenames v2 3/3] Provide compatibility with MinGW
Date: Wed, 28 Oct 2009 21:01:40 +0300
Message-ID: <1256752900-2615-3-git-send-email-timur@iris-comp.ru>
References: <1256752900-2615-1-git-send-email-timur@iris-comp.ru>
 <1256752900-2615-2-git-send-email-timur@iris-comp.ru>
Cc: Timur Sufiev <timur@iris-comp.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 19:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3CqN-0005ni-LV
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbZJ1SBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbZJ1SBq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:01:46 -0400
Received: from [195.93.180.178] ([195.93.180.178]:58941 "EHLO
	mail.iris-comp.ru" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbZJ1SBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:01:44 -0400
Received: from localhost (unknown [80.90.116.82])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.iris-comp.ru (Postfix) with ESMTPSA id 98621E9AF;
	Wed, 28 Oct 2009 21:01:45 +0300 (MSK)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256752900-2615-2-git-send-email-timur@iris-comp.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131488>

Signed-off-by: Timur Sufiev <timur@iris-comp.ru>
---
 compat/fopen.c    |    5 +++--
 compat/mingw.c    |   37 ++++++++++++++++++++++++++++---------
 compat/mingw.h    |    6 +++++-
 compat/mkstemps.c |    3 ++-
 compat/win32.h    |   13 +++++++++++--
 io-i18n.c         |    5 +++++
 io-i18n.h         |    7 +++++++
 7 files changed, 61 insertions(+), 15 deletions(-)

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
index 6b5b5b2..2a2ebcb 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2,7 +2,7 @@
 #include "win32.h"
 #include <conio.h>
 #include "../strbuf.h"
-
+#include "../io-i18n.h"
 #include <shellapi.h>
 
 static int err_win_to_posix(DWORD winerr)
@@ -132,7 +132,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	if (!strcmp(filename, "/dev/null"))
 		filename = "nul";
 
-	fd = open(filename, oflags, mode);
+	fd = open_i18n(filename, oflags, mode);
 
 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
 		DWORD attrs = GetFileAttributes(filename);
@@ -253,7 +253,7 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	int fh, rc;
 
 	/* must have write permission */
-	if ((fh = open(file_name, O_RDWR | O_BINARY)) < 0)
+	if ((fh = open_i18n(file_name, O_RDWR | O_BINARY)) < 0)
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
+	fd = open_i18n(cmd, O_RDONLY);
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
 
@@ -1206,6 +1218,7 @@ struct dirent *mingw_readdir(DIR *dir)
 	WIN32_FIND_DATAA buf;
 	HANDLE handle;
 	struct mingw_DIR *mdir = (struct mingw_DIR*)dir;
+	char *out;
 
 	if (!dir->dd_handle) {
 		errno = EBADF; /* No set_errno for mingw */
@@ -1236,7 +1249,13 @@ struct dirent *mingw_readdir(DIR *dir)
 	}
 
 	/* We get here if `buf' contains valid data.  */
-	strcpy(dir->dd_dir.d_name, buf.cFileName);
+	out = filename_to_utf8(buf.cFileName);
+	if ( strlcpy(dir->dd_dir.d_name,
+		     out ? out : buf.cFileName, FILENAME_MAX) >= FILENAME_MAX) {
+	     die("Too long dir entry name: %.*s", 60,
+		 out ? out : buf.cFileName);
+	     free(out);
+	}
 	++dir->dd_stat;
 
 	/* Set file type, based on WIN32_FIND_DATA */
diff --git a/compat/mingw.h b/compat/mingw.h
index 5b5258b..2447aa7 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,4 +1,7 @@
+#ifndef GIT_MINGW_H
+#define GIT_MINGW_H
 #include <winsock2.h>
+#include "../io-i18n.h"
 
 /*
  * things that are not available in header files
@@ -112,7 +115,7 @@ static inline int mingw_unlink(const char *pathname)
 {
 	/* read-only files cannot be removed */
 	chmod(pathname, 0666);
-	return unlink(pathname);
+	return unlink_i18n(pathname);
 }
 #define unlink mingw_unlink
 
@@ -273,3 +276,4 @@ struct mingw_dirent
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
diff --git a/io-i18n.c b/io-i18n.c
index ed88a68..63e88b8 100644
--- a/io-i18n.c
+++ b/io-i18n.c
@@ -84,6 +84,7 @@ char *filename_to_local(const char *filename)
 #endif
 }
 
+#ifndef __USE_MINGW_ACCESS
 #undef stat
 int stat_i18n(const char *filename, struct stat *buf)
 {
@@ -127,6 +128,7 @@ int link_i18n(const char *oldname, const char *newname)
 		free(new_out);
 	return ret;
 }
+#endif // __USE_MINGW_ACCESS
 
 #undef open
 int open_i18n(const char *filename, int flags, ...)
@@ -165,6 +167,8 @@ int unlink_i18n(const char *filename)
 	return ret;
 }
 
+#if !defined(__USE_MINGW_ACCESS) || \
+     (defined(__USE_MINGW_ACCESS) && defined(NO_MINGW_REPLACE_READDIR))
 #undef readdir
 struct dirent *readdir_i18n(DIR * dirstream)
 {
@@ -187,6 +191,7 @@ struct dirent *readdir_i18n(DIR * dirstream)
 	} else
 		return NULL;
 }
+#endif
 
 #undef opendir
 DIR *opendir_i18n(const char *dirname)
diff --git a/io-i18n.h b/io-i18n.h
index 2369d31..38f73b3 100644
--- a/io-i18n.h
+++ b/io-i18n.h
@@ -23,11 +23,18 @@ int unlink_i18n(const char *filename);
 #define opendir(a) opendir_i18n(a)
 #define fopen(a, b) fopen_i18n(a, b)
 #define chmod(a, b) chmod_i18n(a, b)
+
+#ifndef __USE_MINGW_ACCESS
 #define open open_i18n
 #define stat(a, b) stat_i18n(a, b)
 #define lstat(a, b) lstat_i18n(a, b)
 #define readdir(a) readdir_i18n(a)
 #define unlink(a) unlink_i18n(a)
 #define link(a, b) link_i18n(a, b)
+#endif // __USE_MINGW_ACCESS
+
+#if defined(__USE_MINGW_ACCESS) && defined(NO_MINGW_REPLACE_READDIR)
+#define readdir(a) readdir_i18n(a)
+#endif
 
 #endif /* GIT_IO_I18N_H */
-- 
1.6.5.1

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [RFC PATCH 6/6] win32: use our own dirent.h
Date: Tue, 23 Nov 2010 18:30:44 +0100
Message-ID: <1290533444-3404-7-git-send-email-kusmabite@gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 18:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiy-00043t-L2
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab0KWRbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827Ab0KWRbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:35 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so4809402eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+2PMeCKWipGqra0UqesRJZHc3MPaUE4qKIl9fpgweLM=;
        b=LUs3NbWvSlQSbf3tpfQIab6qe3UFEE2R2b7YshsN/csU+PkA2cnEOdog33V0kLS/vh
         y1Sa6u2GrRmlnNAmuOCJzatt8/uTS7dryKQu9qQ/eoXNX3U7HVoo8/6VcVHopTGQKXLP
         UjlSb7o9M0PhUlpvtZjdC9enhTNej8yBc1Wys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=reF+z8mAFStNQat+B6YSxUKIl2cblPD2R5X9KevwmNF+4dev368DB4N/j+HaHTeRyE
         w6Kb9xLHHUokMSsmuQsTgDYbb1zTO9YRXPrejiRL1/va+1QAuXXj1HJy78EfFkfJtZ+g
         Ptnhu/DnPw5yt8RFKTdK4OADYb06Nw8rXGdQI=
Received: by 10.14.47.197 with SMTP id t45mr5900044eeb.22.1290533494023;
        Tue, 23 Nov 2010 09:31:34 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm6008590eeh.5.2010.11.23.09.31.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:31:33 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161989>

The mingw-runtime implemenation of opendir, readdir and closedir
sets errno to 0 on success, something that POSIX explicitly
forbids. 3ba7a06 ("A loose object is not corrupt if it cannot be
read due to EMFILE") introduce a dependency on this behaviour,
leading to a broken "git clone" on Windows.

compat/mingw.c contains an implementation of readdir, and
compat/msvc.c contains implementations of opendir and closedir.

Move these to compat/win32/dirent.[ch], and change to our own DIR
structure at the same time.

This provides a generic Win32-implementation of opendir, readdir
and closedir which works on both MinGW and MSVC and does not reset
errno, and as a result git clone is working again on Windows.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile                        |    7 ++-
 compat/mingw.c                  |   60 ------------------
 compat/mingw.h                  |   29 ---------
 compat/msvc.c                   |   49 ---------------
 compat/vcbuild/include/dirent.h |  128 ---------------------------------------
 compat/win32/dirent.c           |  105 ++++++++++++++++++++++++++++++++
 compat/win32/dirent.h           |   24 +++++++
 7 files changed, 134 insertions(+), 268 deletions(-)
 delete mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/win32/dirent.c
 create mode 100644 compat/win32/dirent.h

diff --git a/Makefile b/Makefile
index ca1d1fe..765aad4 100644
--- a/Makefile
+++ b/Makefile
@@ -499,6 +499,7 @@ LIB_H += compat/mingw.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
 LIB_H += compat/win32/sys/poll.h
+LIB_H += compat/win32/dirent.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -1086,7 +1087,9 @@ ifeq ($(uname_S),Windows)
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o compat/win32/sys/poll.o
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o \
+		compat/win32/pthread.o compat/win32/syslog.o \
+		compat/win32/sys/poll.o compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1158,7 +1161,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/sys/poll.o
+		compat/win32/sys/poll.o compat/win32/dirent.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/mingw.c b/compat/mingw.c
index d8fd5d8..bee6054 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1566,63 +1566,3 @@ pid_t waitpid(pid_t pid, int *status, unsigned options)
 	errno = EINVAL;
 	return -1;
 }
-
-#ifndef NO_MINGW_REPLACE_READDIR
-/* MinGW readdir implementation to avoid extra lstats for Git */
-struct mingw_DIR
-{
-	struct _finddata_t	dd_dta;		/* disk transfer area for this dir */
-	struct mingw_dirent	dd_dir;		/* Our own implementation, including d_type */
-	long			dd_handle;	/* _findnext handle */
-	int			dd_stat; 	/* 0 = next entry to read is first entry, -1 = off the end, positive = 0 based index of next entry */
-	char			dd_name[1]; 	/* given path for dir with search pattern (struct is extended) */
-};
-
-struct dirent *mingw_readdir(DIR *dir)
-{
-	WIN32_FIND_DATAA buf;
-	HANDLE handle;
-	struct mingw_DIR *mdir = (struct mingw_DIR*)dir;
-
-	if (!dir || !dir->dd_handle) {
-		errno = EBADF; /* No set_errno for mingw */
-		return NULL;
-	}
-
-	if (dir->dd_handle == (long)INVALID_HANDLE_VALUE && dir->dd_stat == 0)
-	{
-		DWORD lasterr;
-		handle = FindFirstFileA(dir->dd_name, &buf);
-		lasterr = GetLastError();
-		dir->dd_handle = (long)handle;
-		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
-			errno = err_win_to_posix(lasterr);
-			return NULL;
-		}
-	} else if (dir->dd_handle == (long)INVALID_HANDLE_VALUE) {
-		return NULL;
-	} else if (!FindNextFileA((HANDLE)dir->dd_handle, &buf)) {
-		DWORD lasterr = GetLastError();
-		FindClose((HANDLE)dir->dd_handle);
-		dir->dd_handle = (long)INVALID_HANDLE_VALUE;
-		/* POSIX says you shouldn't set errno when readdir can't
-		   find any more files; so, if another error we leave it set. */
-		if (lasterr != ERROR_NO_MORE_FILES)
-			errno = err_win_to_posix(lasterr);
-		return NULL;
-	}
-
-	/* We get here if `buf' contains valid data.  */
-	strcpy(dir->dd_dir.d_name, buf.cFileName);
-	++dir->dd_stat;
-
-	/* Set file type, based on WIN32_FIND_DATA */
-	mdir->dd_dir.d_type = 0;
-	if (buf.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
-		mdir->dd_dir.d_type |= DT_DIR;
-	else
-		mdir->dd_dir.d_type |= DT_REG;
-
-	return (struct dirent*)&dir->dd_dir;
-}
-#endif // !NO_MINGW_REPLACE_READDIR
diff --git a/compat/mingw.h b/compat/mingw.h
index 35d9813..2283071 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -322,35 +322,6 @@ int main(int argc, const char **argv) \
 } \
 static int mingw_main(c,v)
 
-#ifndef NO_MINGW_REPLACE_READDIR
-/*
- * A replacement of readdir, to ensure that it reads the file type at
- * the same time. This avoid extra unneeded lstats in git on MinGW
- */
-#undef DT_UNKNOWN
-#undef DT_DIR
-#undef DT_REG
-#undef DT_LNK
-#define DT_UNKNOWN	0
-#define DT_DIR		1
-#define DT_REG		2
-#define DT_LNK		3
-
-struct mingw_dirent
-{
-	long		d_ino;			/* Always zero. */
-	union {
-		unsigned short	d_reclen;	/* Always zero. */
-		unsigned char   d_type;		/* Reimplementation adds this */
-	};
-	unsigned short	d_namlen;		/* Length of name in d_name. */
-	char		d_name[FILENAME_MAX];	/* File name. */
-};
-#define dirent mingw_dirent
-#define readdir(x) mingw_readdir(x)
-struct dirent *mingw_readdir(DIR *dir);
-#endif // !NO_MINGW_REPLACE_READDIR
-
 /*
  * Used by Pthread API implementation for Windows
  */
diff --git a/compat/msvc.c b/compat/msvc.c
index 29fd877..71843d7 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -3,53 +3,4 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-DIR *opendir(const char *name)
-{
-	DWORD attrs = GetFileAttributes(name);
-	int len;
-	DIR *p;
-
-	/* check for valid path */
-	if (attrs == INVALID_FILE_ATTRIBUTES) {
-		errno = ENOENT;
-		return NULL;
-	}
-
-	/* check if it's a directory */
-	if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
-		errno = ENOTDIR;
-		return NULL;
-	}
-
-	/* check that the pattern won't be too long for FindFirstFileA */
-	len = strlen(name);
-	if (is_dir_sep(name[len - 1]))
-		len--;
-	if (len + 2 >= MAX_PATH) {
-		errno = ENAMETOOLONG;
-		return NULL;
-	}
-
-	p = xmalloc(sizeof(DIR) + len + 2);
-	memset(p, 0, sizeof(DIR) + len + 2);
-	strcpy(p->dd_name, name);
-	p->dd_name[len] = '/';
-	p->dd_name[len+1] = '*';
-
-	p->dd_handle = (long)INVALID_HANDLE_VALUE;
-	return p;
-}
-int closedir(DIR *dir)
-{
-	if (!dir) {
-		errno = EBADF;
-		return -1;
-	}
-
-	if (dir->dd_handle != (long)INVALID_HANDLE_VALUE)
-		FindClose((HANDLE)dir->dd_handle);
-	free(dir);
-	return 0;
-}
-
 #include "mingw.c"
diff --git a/compat/vcbuild/include/dirent.h b/compat/vcbuild/include/dirent.h
deleted file mode 100644
index 440618d..0000000
--- a/compat/vcbuild/include/dirent.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * DIRENT.H (formerly DIRLIB.H)
- * This file has no copyright assigned and is placed in the Public Domain.
- * This file is a part of the mingw-runtime package.
- *
- * The mingw-runtime package and its code is distributed in the hope that it
- * will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR
- * IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to
- * warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You are free to use this package and its code without limitation.
- */
-#ifndef _DIRENT_H_
-#define _DIRENT_H_
-#include <io.h>
-
-#define PATH_MAX 512
-
-#define __MINGW_NOTHROW
-
-#ifndef RC_INVOKED
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-struct dirent
-{
-	long		d_ino;		/* Always zero. */
-	unsigned short	d_reclen;	/* Always zero. */
-	unsigned short	d_namlen;	/* Length of name in d_name. */
-	char		d_name[FILENAME_MAX]; /* File name. */
-};
-
-/*
- * This is an internal data structure. Good programmers will not use it
- * except as an argument to one of the functions below.
- * dd_stat field is now int (was short in older versions).
- */
-typedef struct
-{
-	/* disk transfer area for this dir */
-	struct _finddata_t	dd_dta;
-
-	/* dirent struct to return from dir (NOTE: this makes this thread
-	 * safe as long as only one thread uses a particular DIR struct at
-	 * a time) */
-	struct dirent		dd_dir;
-
-	/* _findnext handle */
-	long			dd_handle;
-
-	/*
-	 * Status of search:
-	 *   0 = not started yet (next entry to read is first entry)
-	 *  -1 = off the end
-	 *   positive = 0 based index of next entry
-	 */
-	int			dd_stat;
-
-	/* given path for dir with search pattern (struct is extended) */
-	char			dd_name[PATH_MAX+3];
-} DIR;
-
-DIR* __cdecl __MINGW_NOTHROW opendir (const char*);
-struct dirent* __cdecl __MINGW_NOTHROW readdir (DIR*);
-int __cdecl __MINGW_NOTHROW closedir (DIR*);
-void __cdecl __MINGW_NOTHROW rewinddir (DIR*);
-long __cdecl __MINGW_NOTHROW telldir (DIR*);
-void __cdecl __MINGW_NOTHROW seekdir (DIR*, long);
-
-
-/* wide char versions */
-
-struct _wdirent
-{
-	long		d_ino;		/* Always zero. */
-	unsigned short	d_reclen;	/* Always zero. */
-	unsigned short	d_namlen;	/* Length of name in d_name. */
-	wchar_t		d_name[FILENAME_MAX]; /* File name. */
-};
-
-/*
- * This is an internal data structure. Good programmers will not use it
- * except as an argument to one of the functions below.
- */
-typedef struct
-{
-	/* disk transfer area for this dir */
-	//struct _wfinddata_t	dd_dta;
-
-	/* dirent struct to return from dir (NOTE: this makes this thread
-	 * safe as long as only one thread uses a particular DIR struct at
-	 * a time) */
-	struct _wdirent		dd_dir;
-
-	/* _findnext handle */
-	long			dd_handle;
-
-	/*
-	 * Status of search:
-	 *   0 = not started yet (next entry to read is first entry)
-	 *  -1 = off the end
-	 *   positive = 0 based index of next entry
-	 */
-	int			dd_stat;
-
-	/* given path for dir with search pattern (struct is extended) */
-	wchar_t			dd_name[1];
-} _WDIR;
-
-
-
-_WDIR* __cdecl __MINGW_NOTHROW _wopendir (const wchar_t*);
-struct _wdirent*  __cdecl __MINGW_NOTHROW _wreaddir (_WDIR*);
-int __cdecl __MINGW_NOTHROW _wclosedir (_WDIR*);
-void __cdecl __MINGW_NOTHROW _wrewinddir (_WDIR*);
-long __cdecl __MINGW_NOTHROW _wtelldir (_WDIR*);
-void __cdecl __MINGW_NOTHROW _wseekdir (_WDIR*, long);
-
-
-#ifdef	__cplusplus
-}
-#endif
-
-#endif	/* Not RC_INVOKED */
-
-#endif	/* Not _DIRENT_H_ */
diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
new file mode 100644
index 0000000..659e1d7
--- /dev/null
+++ b/compat/win32/dirent.c
@@ -0,0 +1,105 @@
+#include "../git-compat-util.h"
+#include "dirent.h"
+
+struct DIR {
+	struct dirent dd_dir; /* includes d_type */
+	HANDLE dd_handle;     /* FindFirstFile handle */
+	int dd_stat;          /* 0-based index */
+	char dd_name[1];      /* extend struct */
+};
+
+DIR *opendir(const char *name)
+{
+	DWORD attrs = GetFileAttributesA(name);
+	int len;
+	DIR *p;
+
+	/* check for valid path */
+	if (attrs == INVALID_FILE_ATTRIBUTES) {
+		errno = ENOENT;
+		return NULL;
+	}
+
+	/* check if it's a directory */
+	if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
+		errno = ENOTDIR;
+		return NULL;
+	}
+
+	/* check that the pattern won't be too long for FindFirstFileA */
+	len = strlen(name);
+	if (is_dir_sep(name[len - 1]))
+		len--;
+	if (len + 2 >= MAX_PATH) {
+		errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	p = xmalloc(sizeof(DIR) + len + 2);
+	memset(p, 0, sizeof(DIR) + len + 2);
+	strcpy(p->dd_name, name);
+	p->dd_name[len] = '/';
+	p->dd_name[len+1] = '*';
+
+	p->dd_handle = INVALID_HANDLE_VALUE;
+	return p;
+}
+
+struct dirent *readdir(DIR *dir)
+{
+	WIN32_FIND_DATAA buf;
+	HANDLE handle;
+
+	if (!dir || !dir->dd_handle) {
+		errno = EBADF; /* No set_errno for mingw */
+		return NULL;
+	}
+
+	if (dir->dd_handle == INVALID_HANDLE_VALUE && dir->dd_stat == 0) {
+		DWORD lasterr;
+		handle = FindFirstFileA(dir->dd_name, &buf);
+		lasterr = GetLastError();
+		dir->dd_handle = handle;
+		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
+			errno = err_win_to_posix(lasterr);
+			return NULL;
+		}
+	} else if (dir->dd_handle == INVALID_HANDLE_VALUE) {
+		return NULL;
+	} else if (!FindNextFileA(dir->dd_handle, &buf)) {
+		DWORD lasterr = GetLastError();
+		FindClose(dir->dd_handle);
+		dir->dd_handle = INVALID_HANDLE_VALUE;
+		/* POSIX says you shouldn't set errno when readdir can't
+		   find any more files; so, if another error we leave it set. */
+		if (lasterr != ERROR_NO_MORE_FILES)
+			errno = err_win_to_posix(lasterr);
+		return NULL;
+	}
+
+	/* We get here if `buf' contains valid data.  */
+	strcpy(dir->dd_dir.d_name, buf.cFileName);
+	++dir->dd_stat;
+
+	/* Set file type, based on WIN32_FIND_DATA */
+	dir->dd_dir.d_type = 0;
+	if (buf.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+		dir->dd_dir.d_type |= DT_DIR;
+	else
+		dir->dd_dir.d_type |= DT_REG;
+
+	return &dir->dd_dir;
+}
+
+int closedir(DIR *dir)
+{
+	if (!dir) {
+		errno = EBADF;
+		return -1;
+	}
+
+	if (dir->dd_handle != INVALID_HANDLE_VALUE)
+		FindClose(dir->dd_handle);
+	free(dir);
+	return 0;
+}
diff --git a/compat/win32/dirent.h b/compat/win32/dirent.h
new file mode 100644
index 0000000..927a25c
--- /dev/null
+++ b/compat/win32/dirent.h
@@ -0,0 +1,24 @@
+#ifndef DIRENT_H
+#define DIRENT_H
+
+typedef struct DIR DIR;
+
+#define DT_UNKNOWN 0
+#define DT_DIR     1
+#define DT_REG     2
+#define DT_LNK     3
+
+struct dirent {
+	long d_ino;                      /* Always zero. */
+	char d_name[FILENAME_MAX];       /* File name. */
+	union {
+		unsigned short d_reclen; /* Always zero. */
+		unsigned char  d_type;   /* Reimplementation adds this */
+	};
+};
+
+DIR *opendir(const char *dirname);
+struct dirent *readdir(DIR *dir);
+int closedir(DIR *dir);
+
+#endif /* DIRENT_H */
-- 
1.7.3.2.493.ge4bf7

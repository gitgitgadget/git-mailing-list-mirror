From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 08/11] MinGW readdir reimplementation to support d_type
Date: Sun, 31 May 2009 18:15:22 +0200
Message-ID: <1243786525-4493-9-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
 <1243786525-4493-4-git-send-email-prohaska@zib.de>
 <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de>
 <1243786525-4493-7-git-send-email-prohaska@zib.de>
 <1243786525-4493-8-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAniM-0001nG-Jy
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758865AbZEaQQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbZEaQQT
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:19 -0400
Received: from mailer.zib.de ([130.73.108.11]:58639 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758556AbZEaQQN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:13 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFWVW006801;
	Sun, 31 May 2009 18:15:41 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVF021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-8-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120414>

From: Marius Storm-Olsen <marius@trolltech.com>

The original readdir implementation was fast, but didn't
support the d_type. This means that git would do additional
lstats for each entry, to figure out if the entry was a
directory or not. This unneedingly slowed down many
operations, since Windows API provides this information
directly when walking the directories.

By running this implementation on Moe's repo structure:
  mkdir bummer && cd bummer; for ((i=0;i<100;i++)); do
    mkdir $i && pushd $i;
      for ((j=0;j<1000;j++)); do echo "$j" >$j; done;
    popd;
  done

We see the following speedups:
  git add .
  -------------------
  old: 00:00:23(.087)
  new: 00:00:21(.512) 1.07x

  git status
  -------------------
  old: 00:00:03(.306)
  new: 00:00:01(.684) 1.96x

  git clean -dxf
  -------------------
  old: 00:00:01(.918)
  new: 00:00:00(.295) 6.50x

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/mingw.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h |   29 +++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e190fdd..d85d680 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1171,3 +1171,62 @@ char *getpass(const char *prompt)
 	fputs("\n", stderr);
 	return strbuf_detach(&buf, NULL);
 }
+
+#ifndef NO_MINGW_REPLACE_READDIR
+/* MinGW readdir implementation to avoid extra lstats for Git */
+struct mingw_DIR
+{
+	struct _finddata_t	dd_dta;		/* disk transfer area for this dir */
+	struct mingw_dirent	dd_dir;		/* Our own implementation, including d_type */
+	long			dd_handle;	/* _findnext handle */
+	int			dd_stat; 	/* 0 = next entry to read is first entry, -1 = off the end, positive = 0 based index of next entry */
+	char			dd_name[1]; 	/* given path for dir with search pattern (struct is extended) */
+};
+
+struct dirent *mingw_readdir(DIR *dir)
+{
+	WIN32_FIND_DATAA buf;
+	HANDLE handle;
+	struct mingw_DIR *mdir = (struct mingw_DIR*)dir;
+
+	if (!dir->dd_handle) {
+		errno = EBADF; /* No set_errno for mingw */
+		return NULL;
+	}
+
+	if (dir->dd_handle == (long)INVALID_HANDLE_VALUE && dir->dd_stat == 0)
+	{
+		handle = FindFirstFileA(dir->dd_name, &buf);
+		DWORD lasterr = GetLastError();
+		dir->dd_handle = (long)handle;
+		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
+			errno = err_win_to_posix(lasterr);
+			return NULL;
+		}
+	} else if (dir->dd_handle == (long)INVALID_HANDLE_VALUE) {
+		return NULL;
+	} else if (!FindNextFileA((HANDLE)dir->dd_handle, &buf)) {
+		DWORD lasterr = GetLastError();
+		FindClose((HANDLE)dir->dd_handle);
+		dir->dd_handle = (long)INVALID_HANDLE_VALUE;
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
+	mdir->dd_dir.d_type = 0;
+	if (buf.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+		mdir->dd_dir.d_type |= DT_DIR;
+	else
+		mdir->dd_dir.d_type |= DT_REG;
+
+	return (struct dirent*)&dir->dd_dir;
+}
+#endif // !NO_MINGW_REPLACE_READDIR
diff --git a/compat/mingw.h b/compat/mingw.h
index 4c50f5b..4f7ba4c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -235,3 +235,32 @@ int main(int argc, const char **argv) \
 	return mingw_main(argc, argv); \
 } \
 static int mingw_main(c,v)
+
+#ifndef NO_MINGW_REPLACE_READDIR
+/*
+ * A replacement of readdir, to ensure that it reads the file type at
+ * the same time. This avoid extra unneeded lstats in git on MinGW
+ */
+#undef DT_UNKNOWN
+#undef DT_DIR
+#undef DT_REG
+#undef DT_LNK
+#define DT_UNKNOWN	0
+#define DT_DIR		1
+#define DT_REG		2
+#define DT_LNK		3
+
+struct mingw_dirent
+{
+	long		d_ino;			/* Always zero. */
+	union {
+		unsigned short	d_reclen;	/* Always zero. */
+		unsigned char   d_type;		/* Reimplementation adds this */
+	};
+	unsigned short	d_namlen;		/* Length of name in d_name. */
+	char		d_name[FILENAME_MAX];	/* File name. */
+};
+#define dirent mingw_dirent
+#define readdir(x) mingw_readdir(x)
+struct dirent *mingw_readdir(DIR *dir);
+#endif // !NO_MINGW_REPLACE_READDIR
-- 
1.6.3.1.54.g99dd

From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] MinGW readdir reimplementation to support d_type
Date: Wed,  8 Apr 2009 23:01:47 +0200
Message-ID: <1239224507-5372-1-git-send-email-marius@trolltech.com>
Cc: Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Apr 08 23:03:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lreva-0005jr-Qn
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 23:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbZDHVBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbZDHVBs
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 17:01:48 -0400
Received: from hoat.troll.no ([62.70.27.150]:45697 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbZDHVBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 17:01:48 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 2A8D42175B;
	Wed,  8 Apr 2009 23:01:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [172.20.1.78])
	by hoat.troll.no (Postfix) with ESMTP id EE925213A1;
	Wed,  8 Apr 2009 23:01:41 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.472.gf61f7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116122>

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
---
 It would be nice if MinGW/Windows people would give this a thorough
 testing to ensure that's it's pristine. It seems fine, and I've not
 stumbled over anything myself.

 Of course, if you have status.showUntrackedFiles = no, then you'll
 not get any speedups, since the read_directory_recursive loop is
 never entered. People with a standard setup, however, should
 experience a significant speedup.

 compat/mingw.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h |   28 ++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2839d9d..f52de3e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1139,3 +1139,62 @@ int link(const char *oldpath, const char *newpath)
 	}
 	return 0;
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
+  		   find any more files; so, if another error we leave it set. */
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
index 762eb14..104b310 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -233,3 +233,31 @@ int main(int argc, const char **argv) \
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
+#endif // !NO_MINGW_REPLACE_READDIR
--
1.6.2.2.472.gf61f7.dirty

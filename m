From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Sat, 27 Sep 2008 12:43:49 +0400
Message-ID: <20080927084349.GC21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 10:45:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjVQH-0004Um-O8
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 10:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYI0In5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 04:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYI0In5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 04:43:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:23379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYI0Inz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 04:43:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so874688fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=OMEw/mEVwnMhYIOHH8am8FT7hJs5L9F5y5kWcC/G3G0=;
        b=LaIHlRhQXc50/7z0HQinfZHl9fkl/1bw9v0YhfufAj8huUWGnybtZ3yAxbTMmlPUJL
         o9SdXESyltB5ygok5pWtK2Os6JoLoaPQUrKFT8w1dHQUoQGfdkknh+LUVZcY52Ppa+V6
         YKnbi+0TZtUPcd7LxDKJrTeaBMNqihBMmHdk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=aJWeWPVPwIIAljIymIvypB3mvKcpQolXUkRPzHNBf7kxSZnXUrZZoMSUtmZBOyqbXE
         +fw88FvwNvE2MXlJfyfZLCSL0xcQ3X1dy6Su/wuUMpGB92ATdNrPdkQQupCILb4vYb1E
         RAcBuoZH0rbHU9Aam4rAg/7HVuAaLJ8TJ7l+s=
Received: by 10.86.26.11 with SMTP id 11mr2130797fgz.12.1222505033679;
        Sat, 27 Sep 2008 01:43:53 -0700 (PDT)
Received: from localhost ( [85.141.151.122])
        by mx.google.com with ESMTPS id 4sm5682475fgg.4.2008.09.27.01.43.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 01:43:52 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96908>

lstat/stat functions in Cygwin are very slow, because they try to emulate
some *nix things that Git does not actually need. This patch adds Win32
specific implementation of these functions for Cygwin.

This implementation handles most situation directly but in some rare cases
it falls back on the implementation provided for Cygwin. This is necessary
for two reasons:

- Cygwin has its own file hierarchy, so absolute paths used in Cygwin is
  not suitable to be used Win32 API. cygwin_conv_to_win32_path can not be
  used because it automatically dereference Cygwin symbol links, also it
  causes extra syscall. Fortunately Git rarely use absolute paths, so we
  always use Cygwin implementation for absolute paths.

- Support of symbol links. Cygwin stores symbol links as ordinary using
  one of two possible formats. Therefore, the fast implementation falls
  back to Cygwin functions if it detects potential use of symbol links.

The speed of this implementation should be the same as mingw_lstat for
common cases, but it is considerable slower when the specified file name
does not exist.

Despite all efforts to make the fast implementation as robust as possible,
it may not work well for some very rare situations. I am aware only one
situation: use Cygwin mount to bind unrelated paths inside repository
together.  Therefore, the core.cygwinnativestat configuration option is
provided, which controls whether native or Cygwin version of stat is used.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/config.txt |    9 +++
 Makefile                 |    4 ++
 compat/cygwin.c          |  125 ++++++++++++++++++++++++++++++++++++++++++++++
 compat/cygwin.h          |    9 +++
 git-compat-util.h        |    1 +
 5 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100644 compat/cygwin.c
 create mode 100644 compat/cygwin.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bea867d..c198bc0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -117,6 +117,15 @@ core.fileMode::
 	the working copy are ignored; useful on broken filesystems like FAT.
 	See linkgit:git-update-index[1]. True by default.
 
+core.cygwinNativeStat::
+	This option is only used by Cygwin implementation of Git. If false,
+	the Cygwin stat() and lstat() functions are used. This may be useful
+	if your repository consists of a few separate directories joined in
+	one hierarchy using Cygwin mount. If true, Git uses native Win32 API
+	whenever it is possible and falls back to Cygwin functions only to
+	handle symbol links. The native mode is more than twice faster than
+	normal Cygwin l/stat() functions. True by default.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working copy are ignored; useful when the inode change time
diff --git a/Makefile b/Makefile
index 3c0664a..0708390 100644
--- a/Makefile
+++ b/Makefile
@@ -347,6 +347,7 @@ LIB_H += cache.h
 LIB_H += cache-tree.h
 LIB_H += commit.h
 LIB_H += compat/mingw.h
+LIB_H += compat/cygwin.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -747,6 +748,9 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
+ifneq (,$(findstring CYGWIN,$(uname_S)))
+	COMPAT_OBJS += compat/cygwin.o
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MMAP = YesPlease
 	NO_PREAD = YesPlease
diff --git a/compat/cygwin.c b/compat/cygwin.c
new file mode 100644
index 0000000..ad09b17
--- /dev/null
+++ b/compat/cygwin.c
@@ -0,0 +1,125 @@
+#define WIN32_LEAN_AND_MEAN
+#include "../git-compat-util.h"
+#include "win32.h"
+#include "../cache.h" /* to read configuration */
+
+static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
+{
+	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
+	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
+	ts->tv_sec = (time_t)(winTime/10000000); /* 100-nanosecond interval to seconds */
+	ts->tv_nsec = (long)(winTime - ts->tv_sec*10000000LL) * 100; /* nanoseconds */
+}
+
+#define size_to_blocks(s) (((s)+511)/512)
+
+/* do_stat is a common implementation for cygwin_lstat and cygwin_stat.
+ *
+ * To simplify its logic, in the case of cygwin symlinks, this implementation
+ * falls back to the cygwin version of stat/lstat, which is provided as the
+ * last argument.
+ */
+static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
+{
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
+
+	if (file_name[0] == '/')
+		return cygstat (file_name, buf);
+
+	if (!(errno = get_file_attr(file_name, &fdata))) {
+		/*
+		 * If the system attribute is set and it is not a directory then
+		 * it could be a symbol link created in the nowinsymlinks mode.
+		 * Normally, Cygwin works in the winsymlinks mode, so this situation
+		 * is very unlikely. For the sake of simplicity of our code, let's
+		 * Cygwin to handle it.
+		 */
+		if ((fdata.dwFileAttributes & FILE_ATTRIBUTE_SYSTEM) &&
+		    !(fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
+			return cygstat (file_name, buf);
+
+		/* fill out the stat structure */
+		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
+		buf->st_ino = 0;
+		buf->st_mode = file_attr_to_st_mode (fdata.dwFileAttributes);
+		buf->st_nlink = 1;
+		buf->st_uid = buf->st_gid = 0;
+#ifdef __CYGWIN_USE_BIG_TYPES__
+		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
+			fdata.nFileSizeLow;
+#else
+		buf->st_size = (off_t)fdata.nFileSizeLow;
+#endif
+		buf->st_blocks = size_to_blocks(buf->st_size);
+		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
+		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
+		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
+		return 0;
+	} else if (errno == ENOENT) {
+		/*
+		 * In the winsymlinks mode (which is the default), Cygwin
+		 * emulates symbol links using Windows shortcut files. These
+		 * files are formed by adding .lnk extension. So, if we have
+		 * not found the specified file name, it could be that it is
+		 * a symbol link. Let's Cygwin to deal with that.
+		 */
+		return cygstat (file_name, buf);
+	}
+	return -1;
+}
+
+/* We provide our own lstat/stat functions, since the provided Cygwin versions
+ * of these functions are too slow. These stat functions are tailored for Git's
+ * usage, and therefore they are not meant to be complete and correct emulation
+ * of lstat/stat functionality.
+ */
+static int cygwin_lstat(const char *path, struct stat *buf)
+{
+	return do_stat(path, buf, lstat);
+}
+
+static int cygwin_stat(const char *path, struct stat *buf)
+{
+	return do_stat(path, buf, stat);
+}
+
+
+/*
+ * At start up, we are trying to determine whether Win32 API or cygwin stat
+ * functions should be used. The choice is determined by core.cygwinnativestat.
+ * Reading this option is not always possible immediately as git_dir may be
+ * not be set yet. So until it is set, use cygwin lstat/stat functions.
+ */
+static int native_stat = 1;
+
+static int git_cygwin_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "core.cygwinnativestat"))
+		native_stat = git_config_bool(var, value);
+	return 0;
+}
+
+static int init_stat(void)
+{
+	if (have_git_dir()) {
+		git_config(git_cygwin_config, NULL);
+		cygwin_stat_fn = native_stat ? cygwin_stat : stat;
+		cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
+		return 0;
+	}
+	return 1;
+}
+
+static int cygwin_stat_stub(const char *file_name, struct stat *buf)
+{
+	return (init_stat() ? stat : *cygwin_stat_fn)(file_name, buf);
+}
+
+static int cygwin_lstat_stub(const char *file_name, struct stat *buf)
+{
+	return (init_stat() ? lstat : *cygwin_lstat_fn)(file_name, buf);
+}
+
+stat_fn_t cygwin_stat_fn = cygwin_stat_stub;
+stat_fn_t cygwin_lstat_fn = cygwin_lstat_stub;
+
diff --git a/compat/cygwin.h b/compat/cygwin.h
new file mode 100644
index 0000000..a3229f5
--- /dev/null
+++ b/compat/cygwin.h
@@ -0,0 +1,9 @@
+#include <sys/types.h>
+#include <sys/stat.h>
+
+typedef int (*stat_fn_t)(const char*, struct stat*);
+extern stat_fn_t cygwin_stat_fn;
+extern stat_fn_t cygwin_lstat_fn;
+
+#define stat(path, buf) (*cygwin_stat_fn)(path, buf)
+#define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
diff --git a/git-compat-util.h b/git-compat-util.h
index db2836f..cd9752c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,7 @@
 #undef _XOPEN_SOURCE
 #include <grp.h>
 #define _XOPEN_SOURCE 600
+#include "compat/cygwin.h"
 #else
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
-- 
1.6.0.2.237.g0297e5

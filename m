From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] MinGW: implement mmap
Date: Wed, 18 Mar 2009 08:36:02 +0100
Message-ID: <49C0A462.3060902@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Janos Laube <janos.dev@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:37:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjqLM-0007m3-Gj
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbZCRHgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 03:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbZCRHgK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:36:10 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56431 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbZCRHgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 03:36:09 -0400
Received: from [192.168.1.98] (cm56-163-160.liwest.at [86.56.163.160])
	by bsmtp.bon.at (Postfix) with ESMTP id A578A2C4029;
	Wed, 18 Mar 2009 08:36:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113593>

From: Janos Laube <janos.dev@gmail.com>
Date: Fri, 13 Mar 2009 16:50:45 +0100

Add USE_WIN32_MMAP which triggers the use of windows' native
file memory mapping functionality in git_mmap()/git_munmap() functions.

As git functions currently use mmap with MAP_PRIVATE set only, this
implementation supports only that mode for now.

On Windows, offsets for memory mapped files need to match the allocation
granularity. Take this into account when calculating the packed git-
windowsize and file offsets. At the moment, the only function which makes
use of offsets in conjunction with mmap is use_pack() in sha1-file.c.

Git fast-import's code path tries to map a portion of the temporary
packfile that exceeds the current filesize, i.e. offset+length is
greater than the filesize. The NO_MMAP code worked with that since pread()
just reads the file content until EOF and returns gracefully, while
MapViewOfFile() aborts the mapping and returns 'Access Denied'.
Working around that by determining the filesize and adjusting the length
parameter.

Signed-off-by: Janos Laube <janos.dev@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  Makefile           |    7 +++++-
  compat/mingw.h     |    5 ++++
  compat/win32mmap.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
  git-compat-util.h  |   12 ++++++++--
  4 files changed, 73 insertions(+), 4 deletions(-)
  create mode 100644 compat/win32mmap.c

diff --git a/Makefile b/Makefile
index 1087884..38e75e5 100644
--- a/Makefile
+++ b/Makefile
@@ -776,7 +776,6 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
  	COMPAT_OBJS += compat/cygwin.o
  endif
  ifneq (,$(findstring MINGW,$(uname_S)))
-	NO_MMAP = YesPlease
  	NO_PREAD = YesPlease
  	NO_OPENSSL = YesPlease
  	NO_CURL = YesPlease
@@ -799,6 +798,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
  	RUNTIME_PREFIX = YesPlease
  	NO_POSIX_ONLY_PROGRAMS = YesPlease
  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	USE_WIN32_MMAP = YesPlease
  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
  	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
@@ -967,6 +967,11 @@ endif
  ifdef NO_MMAP
  	COMPAT_CFLAGS += -DNO_MMAP
  	COMPAT_OBJS += compat/mmap.o
+else
+	ifdef USE_WIN32_MMAP
+		COMPAT_CFLAGS += -DUSE_WIN32_MMAP
+		COMPAT_OBJS += compat/win32mmap.o
+	endif
  endif
  ifdef NO_PREAD
  	COMPAT_CFLAGS += -DNO_PREAD
diff --git a/compat/mingw.h b/compat/mingw.h
index 6e24686..f5da647 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -160,6 +160,11 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
  int mingw_rename(const char*, const char*);
  #define rename mingw_rename

+#ifdef USE_WIN32_MMAP
+int mingw_getpagesize(void);
+#define getpagesize mingw_getpagesize
+#endif
+
  /* Use mingw_lstat() instead of lstat()/stat() and
   * mingw_fstat() instead of fstat() on Windows.
   */
diff --git a/compat/win32mmap.c b/compat/win32mmap.c
new file mode 100644
index 0000000..66314b8
--- /dev/null
+++ b/compat/win32mmap.c
@@ -0,0 +1,53 @@
+#include "../git-compat-util.h"
+
+/* Note that this doesn't return the actual pagesize, but
+ * the allocation granularity. If future Windows specific git code
+ * needs the real getpagesize function, we need to find another solution.
+ */
+int mingw_getpagesize(void)
+{
+	SYSTEM_INFO si;
+	GetSystemInfo(&si);
+	return si.dwAllocationGranularity;
+}
+
+void *git_mmap
+(void *start, size_t length, int prot, int flags, int fd, off_t offset)
+{
+	HANDLE hmap;
+	void *temp;
+	size_t len;
+	struct stat st;
+	uint64_t o = offset;
+	uint32_t l = o & 0xFFFFFFFF;
+	uint32_t h = (o >> 32) & 0xFFFFFFFF;
+
+	if (!fstat(fd, &st))
+		len = xsize_t(st.st_size);
+	else
+		die("mmap: could not determine filesize");
+
+	if ((length + offset) > len)
+		length = len - offset;
+
+	if (!(flags & MAP_PRIVATE))
+		die("Invalid usage of mmap when built with USE_WIN32_MMAP");
+
+	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), 0, PAGE_WRITECOPY,
+		0, 0, 0);
+
+	if (!hmap)
+		return MAP_FAILED;
+
+	temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
+
+	if (!CloseHandle(hmap))
+		warning("unable to close file mapping handle\n");
+
+	return temp ? temp : MAP_FAILED;
+}
+
+int git_munmap(void *start, size_t length)
+{
+	return !UnmapViewOfFile(start);
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 878d83d..1eef4eb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -166,7 +166,7 @@ static inline const char *skip_prefix(const char *str, const char *prefix)
  	return strncmp(str, prefix, len) ? NULL : str + len;
  }

-#ifdef NO_MMAP
+#if defined(NO_MMAP) || defined(USE_WIN32_MMAP)

  #ifndef PROT_READ
  #define PROT_READ 1
@@ -180,13 +180,19 @@ static inline const char *skip_prefix(const char *str, const char *prefix)
  extern void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
  extern int git_munmap(void *start, size_t length);

+#else /* NO_MMAP || USE_WIN32_MMAP */
+
+#include <sys/mman.h>
+
+#endif /* NO_MMAP || USE_WIN32_MMAP */
+
+#ifdef NO_MMAP
+
  /* This value must be multiple of (pagesize * 2) */
  #define DEFAULT_PACKED_GIT_WINDOW_SIZE (1 * 1024 * 1024)

  #else /* NO_MMAP */

-#include <sys/mman.h>
-
  /* This value must be multiple of (pagesize * 2) */
  #define DEFAULT_PACKED_GIT_WINDOW_SIZE \
  	(sizeof(void*) >= 8 \
-- 
1.6.2.rc2.971.g14d5

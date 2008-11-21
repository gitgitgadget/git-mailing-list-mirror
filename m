From: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH] mmap implementation for mingw.
Date: Fri, 21 Nov 2008 02:50:22 +0000 (UTC)
Message-ID: <loom.20081121T024302-370@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 03:56:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3MCD-0003RP-12
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 03:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYKUCzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 21:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbYKUCzO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 21:55:14 -0500
Received: from main.gmane.org ([80.91.229.2]:53134 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbYKUCzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 21:55:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1L3MAg-0005c1-UH
	for git@vger.kernel.org; Fri, 21 Nov 2008 02:55:02 +0000
Received: from fly.lviv.inobject.com ([217.65.240.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 02:55:02 +0000
Received: from vvavrychuk by fly.lviv.inobject.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 02:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.65.240.234 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/0.3.154.9 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101494>

Here is simple and restricted implementation of mmap using CreateFileMapping, 
MapViewOfFile.

---
 compat/mingw.c    |   27 +++++++++++++++++++++++++++
 compat/mingw.h    |    6 ++++++
 git-compat-util.h |    2 ++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b534a8a..a6a5081 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -994,3 +994,30 @@ void mingw_open_html(const char *unixpath)
 	printf("Launching default browser to display HTML ...\n");
 	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
 }
+
+void *mingw_mmap(void *start, size_t length, int prot, int flags, int fd, 
off_t offset)
+{
+	HANDLE handle;
+
+	if (start != NULL || !(flags & MAP_PRIVATE))
+		die("Invalid usage of mingw_mmap");
+
+	if (offset % getpagesize() != 0)
+		die("Offset does not match the memory allocation granularity");
+
+	handle = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL, 
PAGE_WRITECOPY,
+			0, 0, NULL);
+
+	if (handle != NULL) {
+		start = MapViewOfFile(handle, FILE_MAP_COPY, 0, offset, 
length);
+		CloseHandle(handle);
+	}
+
+	return start;
+}
+
+int mingw_munmap(void *start, size_t length)
+{
+	UnmapViewOfFile(start);
+	return 0;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index 4f275cb..1b2a098 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -183,6 +183,12 @@ static inline unsigned int git_ntohl(unsigned int x)
 sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
+void *mingw_mmap(void *start, size_t length, int prot, int flags, int fd, 
off_t offset);
+#define mmap mingw_mmap
+
+int mingw_munmap(void *start, size_t length);
+#define munmap mingw_munmap
+
 /*
  * ANSI emulation wrappers
  */
diff --git a/git-compat-util.h b/git-compat-util.h
index e20b1e8..8f3d070 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -175,10 +175,12 @@ static inline const char *skip_prefix(const char *str, 
const char *prefix)
 #define MAP_FAILED ((void*)-1)
 #endif
 
+#ifndef __MINGW32__
 #define mmap git_mmap
 #define munmap git_munmap
 extern void *git_mmap(void *start, size_t length, int prot, int flags, int fd, 
off_t offset);
 extern int git_munmap(void *start, size_t length);
+#endif
 
 /* This value must be multiple of (pagesize * 2) */
 #define DEFAULT_PACKED_GIT_WINDOW_SIZE (1 * 1024 * 1024)
-- 
1.5.6.1.1071.g76fb

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 3/4] MSVC: Add support for building with NO_MMAP
Date: Sat, 07 Nov 2009 20:10:31 +0000
Message-ID: <4AF5D437.8000307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 21:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6rqM-0000ib-B9
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 21:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbZKGUYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 15:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZKGUYu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 15:24:50 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:44624 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290AbZKGUYu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 15:24:50 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1N6rqA-0005pj-f6; Sat, 07 Nov 2009 20:24:55 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132375>


When the NO_MMAP build variable is set, the msvc linker complains:

    error LNK2001: unresolved external symbol _getpagesize

The msvc libraries do not define the getpagesize() function,
so we move the mingw_getpagesize() implementation from the
conditionally built win32mmap.c file to mingw.c.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Changes since v1:
    - re-worded the subject and commit message to, hopefully,
      make it a little clearer.

 compat/mingw.c     |   12 ++++++++++++
 compat/mingw.h     |    2 +-
 compat/win32mmap.c |   12 ------------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6b5b5b2..15fe33e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1000,6 +1000,18 @@ repeat:
 	return -1;
 }
 
+/*
+ * Note that this doesn't return the actual pagesize, but
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
 struct passwd *getpwuid(int uid)
 {
 	static char user_name[100];
diff --git a/compat/mingw.h b/compat/mingw.h
index 5b5258b..26c4027 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -166,7 +166,7 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
-#ifdef USE_WIN32_MMAP
+#if defined(USE_WIN32_MMAP) || defined(_MSC_VER)
 int mingw_getpagesize(void);
 #define getpagesize mingw_getpagesize
 #endif
diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index 779d796..1c5a149 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -1,17 +1,5 @@
 #include "../git-compat-util.h"
 
-/*
- * Note that this doesn't return the actual pagesize, but
- * the allocation granularity. If future Windows specific git code
- * needs the real getpagesize function, we need to find another solution.
- */
-int mingw_getpagesize(void)
-{
-	SYSTEM_INFO si;
-	GetSystemInfo(&si);
-	return si.dwAllocationGranularity;
-}
-
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
 	HANDLE hmap;
-- 
1.6.5

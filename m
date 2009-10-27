From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on cygwin
Date: Tue, 27 Oct 2009 19:03:36 +0000
Message-ID: <4AE74408.7080103@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rrQ-0003wp-8w
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715AbZJ0ThR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756693AbZJ0ThR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:37:17 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49874 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756681AbZJ0ThQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 15:37:16 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N2rr5-0002i6-Xd; Tue, 27 Oct 2009 19:37:20 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131375>


When the NO_MMAP build variable is set, which is the case by
default on cygwin, the msvc linker complains:

    error LNK2001: unresolved external symbol _getpagesize

The mingw build has a version of the getpagesize() function
defined in the libgcc.a library. In addition, this function
is replaced, if USE_WIN32_MMAP is defined, by a version more
suitable for use with the native mmap.

The msvc libraries do not define any getpagesize() function,
so we move the mingw_getpagesize() implementation from the
conditionally built win32mmap.c file to mingw.c, which will
always be included in the MSVC build.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

This alone won't make the MSVC build work on cygwin; I have to

    $ make MSVC=1 NEEDS_LIBICONV=

otherwise the linker complains about the absence of the iconv.lib.
(I have downloaded the win32 version of the library, but I haven't
got around to installing it! see http://gnuwin32.sourceforge.net/
packages/libiconv.htm)

The real problem, of course, is that the cygwin and MSVC configuration
sections are not mutually exclusive. (see patch 3/4)

ATB,
Ramsay Jones

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

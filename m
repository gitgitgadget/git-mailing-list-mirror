From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/7] Rename gitfakemmap to git_mmap.
Date: Sun, 24 Dec 2006 00:45:37 -0500
Message-ID: <20061224054537.GA8146@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:45:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMBG-0001QZ-9E
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbWLXFpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbWLXFpm
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:45:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53715 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbWLXFpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:45:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMB2-0008Ia-99; Sun, 24 Dec 2006 00:45:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DAB2420FB65; Sun, 24 Dec 2006 00:45:37 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35338>

This minor cleanup was suggested by Johannes Schindelin.

The mmap is still fake in the sense that we don't support PROT_WRITE
or MAP_SHARED with external modification at all, but that hasn't
stopped us from using mmap() thoughout the Git code.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 compat/mmap.c     |    6 +++---
 git-compat-util.h |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index 0fd46e7..bb34c7e 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -1,12 +1,12 @@
 #include "../git-compat-util.h"
 
-void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
+void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
 	int n = 0;
 	off_t current_offset = lseek(fd, 0, SEEK_CUR);
 
 	if (start != NULL || !(flags & MAP_PRIVATE))
-		die("Invalid usage of gitfakemmap.");
+		die("Invalid usage of mmap when built with NO_MMAP");
 
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		errno = EINVAL;
@@ -44,7 +44,7 @@ void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_
 	return start;
 }
 
-int gitfakemunmap(void *start, size_t length)
+int git_munmap(void *start, size_t length)
 {
 	free(start);
 	return 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index f79365b..5d9eb26 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -87,10 +87,10 @@ extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 #define MAP_FAILED ((void*)-1)
 #endif
 
-#define mmap gitfakemmap
-#define munmap gitfakemunmap
-extern void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
-extern int gitfakemunmap(void *start, size_t length);
+#define mmap git_mmap
+#define munmap git_munmap
+extern void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+extern int git_munmap(void *start, size_t length);
 
 #else /* NO_MMAP */
 
-- 
1.4.4.3.g2e63

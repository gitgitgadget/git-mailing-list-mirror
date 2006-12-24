From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/7] Switch git_mmap to use pread.
Date: Sun, 24 Dec 2006 00:45:47 -0500
Message-ID: <20061224054547.GB8146@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:45:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMBG-0001QZ-QX
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbWLXFpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbWLXFpv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:45:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53720 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbWLXFpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:45:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMBB-0008LO-23; Sun, 24 Dec 2006 00:45:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5077420FB65; Sun, 24 Dec 2006 00:45:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35339>

Now that Git depends on pread in index-pack its safe to say we can
also depend on it within the git_mmap emulation we activate when
NO_MMAP is set.  On most systems pread should be slightly faster
than an lseek/read/lseek sequence as its one system call vs. three
system calls.

We also now honor EAGAIN and EINTR error codes from pread and
restart the prior read.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 compat/mmap.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index bb34c7e..98056f0 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -2,17 +2,11 @@
 
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
-	int n = 0;
-	off_t current_offset = lseek(fd, 0, SEEK_CUR);
+	size_t n = 0;
 
 	if (start != NULL || !(flags & MAP_PRIVATE))
 		die("Invalid usage of mmap when built with NO_MMAP");
 
-	if (lseek(fd, offset, SEEK_SET) < 0) {
-		errno = EINVAL;
-		return MAP_FAILED;
-	}
-
 	start = xmalloc(length);
 	if (start == NULL) {
 		errno = ENOMEM;
@@ -20,7 +14,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	}
 
 	while (n < length) {
-		int count = read(fd, start+n, length-n);
+		ssize_t count = pread(fd, start + n, length - n, offset + n);
 
 		if (count == 0) {
 			memset(start+n, 0, length-n);
@@ -28,6 +22,8 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 		}
 
 		if (count < 0) {
+			if (errno == EAGAIN || errno == EINTR)
+				continue;
 			free(start);
 			errno = EACCES;
 			return MAP_FAILED;
@@ -36,11 +32,6 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 		n += count;
 	}
 
-	if (current_offset != lseek(fd, current_offset, SEEK_SET)) {
-		errno = EINVAL;
-		return MAP_FAILED;
-	}
-
 	return start;
 }
 
-- 
1.4.4.3.g2e63

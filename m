From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/5 maint] Fix "Out of memory? mmap failed" for files larger than 4GB on Windows
Date: Thu, 20 May 2010 20:57:51 +0200
Message-ID: <7289ab6b171efda2fbc0f5d5b0080c7f1afd529e.1274380838.git.j6t@kdbg.org>
References: <cover.1274380838.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Ian McLean <ian.mclean@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 21:01:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFAzL-0008GA-QO
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab0ETTAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 15:00:55 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15223 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751895Ab0ETTAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:00:53 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3466ECDF87;
	Thu, 20 May 2010 21:00:52 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B9CA519F5F0;
	Thu, 20 May 2010 20:58:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.64.ga1799.dirty
In-Reply-To: <cover.1274380838.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147407>

From: Ian McLean <ian.mclean@gmail.com>

The git_mmap implementation was broken for file sizes that wouldn't fit
into a size_t (32 bits).  This was caused by intermediate variables that
were only 32 bits wide when they should be 64 bits.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This patch is obviously correct. I have used it in production to verify
 that it doesn't break repositories that are smaller than 4GB.

 compat/win32mmap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index 1c5a149..b58aa69 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -4,19 +4,19 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 {
 	HANDLE hmap;
 	void *temp;
-	size_t len;
+	off_t len;
 	struct stat st;
 	uint64_t o = offset;
 	uint32_t l = o & 0xFFFFFFFF;
 	uint32_t h = (o >> 32) & 0xFFFFFFFF;
 
 	if (!fstat(fd, &st))
-		len = xsize_t(st.st_size);
+		len = st.st_size;
 	else
 		die("mmap: could not determine filesize");
 
 	if ((length + offset) > len)
-		length = len - offset;
+		length = xsize_t(len - offset);
 
 	if (!(flags & MAP_PRIVATE))
 		die("Invalid usage of mmap when built with USE_WIN32_MMAP");
-- 
1.7.1.64.ga1799.dirty

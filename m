From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 095/104] Fix "Out of memory? mmap failed" for files larger than 4GB on Windows
Date: Wed, 26 May 2010 18:01:05 +1200
Message-ID: <1274853674-18521-95-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Ian McLean <ian.mclean@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9mL-0005GU-MI
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934081Ab0EZGHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:07:32 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933975Ab0EZGGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 0F49533745;
	Wed, 26 May 2010 18:02:15 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yhX9gH3k+7xL; Wed, 26 May 2010 18:02:03 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 9797F337DB;
	Wed, 26 May 2010 18:01:38 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147768>

From: Ian McLean <ian.mclean@gmail.com>

The git_mmap implementation was broken for file sizes that wouldn't fit
into a size_t (32 bits).  This was caused by intermediate variables that
were only 32 bits wide when they should be 64 bits.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
1.7.1.rc2.333.gb2668

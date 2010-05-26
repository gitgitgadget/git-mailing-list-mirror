From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 087/104] hash_object: correction for zero length file
Date: Wed, 26 May 2010 18:00:57 +1200
Message-ID: <1274853674-18521-87-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:06:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lA-0004LR-4O
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454Ab0EZGGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:23 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab0EZGGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:23 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id CB36F3389A;
	Wed, 26 May 2010 18:02:01 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CdpLmfggw0k5; Wed, 26 May 2010 18:01:58 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 452E7338D0;
	Wed, 26 May 2010 18:01:36 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147751>

From: Dmitry Potapov <dpotapov@gmail.com>

The check whether size is zero was done after if size <= SMALL_FILE_SIZE,
as result, zero size case was never triggered. Instead zero length file
was treated as any other small file. This did not caused any problem, but
if we have a special case for size equal to zero, it is better to make it
work and avoid redundant malloc().

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ff65328..1b551e4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2448,6 +2448,8 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		else
 			ret = -1;
 		strbuf_release(&sbuf);
+	} else if (!size) {
+		ret = index_mem(sha1, NULL, size, write_object, type, path);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
@@ -2456,12 +2458,11 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		else
 			ret = error("short read %s", strerror(errno));
 		free(buf);
-	} else if (size) {
+	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 		ret = index_mem(sha1, buf, size, write_object, type, path);
 		munmap(buf, size);
-	} else
-		ret = index_mem(sha1, NULL, size, write_object, type, path);
+	}
 	close(fd);
 	return ret;
 }
-- 
1.7.1.rc2.333.gb2668

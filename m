From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v6 4/6] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Tue, 26 Aug 2014 17:23:23 +0200
Message-ID: <1409066605-4851-5-git-send-email-prohaska@zib.de>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:24:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMIbQ-0001Gq-3E
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 17:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302AbaHZPXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 11:23:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:35459 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbaHZPXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 11:23:54 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNeXG011312;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNcNd011272;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1409066605-4851-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53FCA67C.004 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FCA67C.004 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FCA67C.004 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255910>

Similar to testing expectations about malloc with GIT_ALLOC_LIMIT (see
commit d41489 and previous commit), it can be useful to test
expectations about mmap.

This introduces a new environment variable GIT_MMAP_LIMIT to limit the
largest allowed mmap length.  xmmap() is modified to check the limit.
Together with GIT_ALLOC_LIMIT tests can now easily confirm expectations
about memory consumption.

GIT_MMAP_LIMIT will be used in the next commit to test that data will be
streamed to an external filter without mmaping the entire file.

[commit d41489]: d41489a6424308dc9a0409bc2f6845aa08bd4f7d Add more large
    blob test cases

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 sha1_file.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 00c07f2..d9b5157 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -663,10 +663,26 @@ void release_pack_memory(size_t need)
 		; /* nothing */
 }
 
+static void mmap_limit_check(size_t length)
+{
+	static size_t limit = 0;
+	if (!limit) {
+		limit = git_env_ulong("GIT_MMAP_LIMIT", 0);
+		if (!limit)
+			limit = SIZE_MAX;
+	}
+	if (length > limit)
+		die("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX,
+		    (uintmax_t)length, (uintmax_t)limit);
+}
+
 void *xmmap(void *start, size_t length,
 	int prot, int flags, int fd, off_t offset)
 {
-	void *ret = mmap(start, length, prot, flags, fd, offset);
+	void *ret;
+
+	mmap_limit_check(length);
+	ret = mmap(start, length, prot, flags, fd, offset);
 	if (ret == MAP_FAILED) {
 		if (!length)
 			return NULL;
-- 
2.1.0.8.gf3a29c8

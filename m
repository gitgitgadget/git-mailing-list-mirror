From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v4 2/4] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Fri, 22 Aug 2014 16:01:21 +0200
Message-ID: <1408716083-9093-3-git-send-email-prohaska@zib.de>
References: <1408716083-9093-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 16:03:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKpRD-0002Js-G0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 16:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbaHVODZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 10:03:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:33655 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932158AbaHVODX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 10:03:23 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7ME1wEX009786;
	Fri, 22 Aug 2014 16:01:58 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7ME1vrT009676;
	Fri, 22 Aug 2014 16:01:58 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1408716083-9093-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53F74D56.002 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F74D56.002 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F74D56.002 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255675>

Similar to testing expectations about malloc with GIT_ALLOC_LIMIT (see
commit d41489), it can be useful to test expectations about mmap.

This introduces a new environment variable GIT_MMAP_LIMIT to limit the
largest allowed mmap length (in KB).  xmmap() is modified to check the
limit.  Together with GIT_ALLOC_LIMIT tests can now easily confirm
expectations about memory consumption.

GIT_MMAP_LIMIT will be used in the next commit to test that data will be
streamed to an external filter without mmaping the entire file.

[commit d41489]: d41489a6424308dc9a0409bc2f6845aa08bd4f7d Add more large
    blob test cases

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 sha1_file.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 00c07f2..603673b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -663,10 +663,25 @@ void release_pack_memory(size_t need)
 		; /* nothing */
 }
 
+static void mmap_limit_check(size_t length)
+{
+	static ssize_t limit = -1;
+	if (limit == -1) {
+		const char *env = getenv("GIT_MMAP_LIMIT");
+		limit = env ? atol(env) * 1024 : 0;
+	}
+	if (limit && length > limit)
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
2.1.0.6.gb452461

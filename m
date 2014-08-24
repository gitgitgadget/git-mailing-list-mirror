From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5 3/4] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Sun, 24 Aug 2014 18:07:45 +0200
Message-ID: <1408896466-23149-4-git-send-email-prohaska@zib.de>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 18:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLaM1-00046D-1V
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 18:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbaHXQJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 12:09:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:49908 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbaHXQJM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 12:09:12 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7OG81lc016861;
	Sun, 24 Aug 2014 18:08:02 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7OG81sF016835;
	Sun, 24 Aug 2014 18:08:01 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1408896466-23149-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53FA0DE1.003 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FA0DE1.003 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FA0DE1.003 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255801>

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
 sha1_file.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 00c07f2..3204f66 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -663,10 +663,29 @@ void release_pack_memory(size_t need)
 		; /* nothing */
 }
 
+static void mmap_limit_check(size_t length)
+{
+	static size_t limit = SIZE_MAX;
+	if (limit == SIZE_MAX) {
+		const char *var = "GIT_MMAP_LIMIT";
+		unsigned long val = 0;
+		const char *env = getenv(var);
+		if (env && !git_parse_ulong(env, &val))
+			die("Failed to parse %s", var);
+		limit = val;
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
2.1.0.8.gd3b6067

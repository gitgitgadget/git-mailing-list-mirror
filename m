From: Jeff King <peff@peff.net>
Subject: [PATCH v4 01/23] sha1write: make buffer const-correct
Date: Sat, 21 Dec 2013 08:59:27 -0500
Message-ID: <20131221135926.GA21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 14:59:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN5Z-0004Zw-B0
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab3LUN72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:59:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:48468 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754669Ab3LUN72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:59:28 -0500
Received: (qmail 7298 invoked by uid 102); 21 Dec 2013 13:59:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:59:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:59:27 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239594>

We are passed a "void *" and write it out without ever
touching it; let's indicate that by using "const".

Signed-off-by: Jeff King <peff@peff.net>
---
 csum-file.c | 6 +++---
 csum-file.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 53f5375..465971c 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,7 +11,7 @@
 #include "progress.h"
 #include "csum-file.h"
 
-static void flush(struct sha1file *f, void *buf, unsigned int count)
+static void flush(struct sha1file *f, const void *buf, unsigned int count)
 {
 	if (0 <= f->check_fd && count)  {
 		unsigned char check_buffer[8192];
@@ -86,13 +86,13 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 	return fd;
 }
 
-int sha1write(struct sha1file *f, void *buf, unsigned int count)
+int sha1write(struct sha1file *f, const void *buf, unsigned int count)
 {
 	while (count) {
 		unsigned offset = f->offset;
 		unsigned left = sizeof(f->buffer) - offset;
 		unsigned nr = count > left ? left : count;
-		void *data;
+		const void *data;
 
 		if (f->do_crc)
 			f->crc32 = crc32(f->crc32, buf, nr);
diff --git a/csum-file.h b/csum-file.h
index 3b540bd..9dedb03 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -34,7 +34,7 @@ extern struct sha1file *sha1fd(int fd, const char *name);
 extern struct sha1file *sha1fd_check(const char *name);
 extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
 extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
-extern int sha1write(struct sha1file *, void *, unsigned int);
+extern int sha1write(struct sha1file *, const void *, unsigned int);
 extern void sha1flush(struct sha1file *f);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);
-- 
1.8.5.1.399.g900e7cd

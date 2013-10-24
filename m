From: Jeff King <peff@peff.net>
Subject: [PATCH 01/19] sha1write: make buffer const-correct
Date: Thu, 24 Oct 2013 13:59:49 -0400
Message-ID: <20131024175949.GA24180@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 20:00:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZPCN-0002lI-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 19:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab3JXR7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 13:59:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:54858 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755407Ab3JXR7v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 13:59:51 -0400
Received: (qmail 436 invoked by uid 102); 24 Oct 2013 17:59:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 12:59:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 13:59:49 -0400
Content-Disposition: inline
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236588>

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
1.8.4.1.898.g8bf8a41.dirty

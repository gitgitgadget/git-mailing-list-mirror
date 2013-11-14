From: Jeff King <peff@peff.net>
Subject: [PATCH v3 01/21] sha1write: make buffer const-correct
Date: Thu, 14 Nov 2013 07:42:50 -0500
Message-ID: <20131114124249.GA10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:42:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwG7-0006gP-GY
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab3KNMmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:42:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:39099 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753146Ab3KNMmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:42:51 -0500
Received: (qmail 11287 invoked by uid 102); 14 Nov 2013 12:42:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:42:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:42:50 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237825>

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
1.8.5.rc0.443.g2df7f3f

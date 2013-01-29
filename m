From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] csum-file: make sha1write const-correct
Date: Tue, 29 Jan 2013 04:15:30 -0500
Message-ID: <20130129091530.GA9999@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 10:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U07IL-0007gA-45
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 10:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab3A2JPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 04:15:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53239 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab3A2JPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 04:15:34 -0500
Received: (qmail 19968 invoked by uid 107); 29 Jan 2013 09:16:56 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 04:16:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 04:15:30 -0500
Content-Disposition: inline
In-Reply-To: <20130129091434.GA6975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214917>

We do not modify the buffer we are asked to write; mark it
with const so that callers with const buffers do not get
unnecessary complaints from the compiler.

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
@@ -86,13 +86,13 @@ int sha1write(struct sha1file *f, void *buf, unsigned int count)
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
@@ -34,7 +34,7 @@ extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
 extern struct sha1file *sha1fd_check(const char *name);
 extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
 extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
-extern int sha1write(struct sha1file *, void *, unsigned int);
+extern int sha1write(struct sha1file *, const void *, unsigned int);
 extern void sha1flush(struct sha1file *f);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);
-- 
1.8.0.2.16.g72e2fc9

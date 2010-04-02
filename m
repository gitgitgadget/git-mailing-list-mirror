From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] fix const-correctness of write_sha1_file
Date: Thu, 1 Apr 2010 20:03:18 -0400
Message-ID: <20100402000318.GA16462@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:03:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUMJ-0007lm-DB
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758999Ab0DBADb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:03:31 -0400
Received: from peff.net ([208.65.91.99]:33405 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355Ab0DBADa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:03:30 -0400
Received: (qmail 5125 invoked by uid 107); 2 Apr 2010 00:04:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:04:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:03:18 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143762>

These should take const buffers as input data, but zlib's
next_in pointer is not const-correct. Let's fix it at the
zlib level, though, so the cast happens in one obvious
place. This should be safe, as a similar cast is used in
zlib's example code for a const array.

Signed-off-by: Jeff King <peff@peff.net>
---
This helps me avoid casting at a higher level in the code, but I also
think it's the right thing to do.

 cache.h     |    2 +-
 sha1_file.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 6dcb100..5eb0573 100644
--- a/cache.h
+++ b/cache.h
@@ -701,7 +701,7 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 	return read_sha1_file_repl(sha1, type, size, NULL);
 }
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
-extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 
diff --git a/sha1_file.c b/sha1_file.c
index a08a9d0..ff65328 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2271,7 +2271,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 }
 
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
-			      void *buf, unsigned long len, time_t mtime)
+			      const void *buf, unsigned long len, time_t mtime)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
@@ -2307,7 +2307,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA1_Update(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
-	stream.next_in = buf;
+	stream.next_in = (void *)buf;
 	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
@@ -2342,7 +2342,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	return move_temp_to_file(tmpfile, filename);
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	unsigned char sha1[20];
 	char hdr[32];
-- 
1.7.0.4.299.gba9d4

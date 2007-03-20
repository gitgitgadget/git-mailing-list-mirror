From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Be more careful about zlib return values
Date: Tue, 20 Mar 2007 11:38:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703201124260.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 19:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTjGe-0007iF-77
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 19:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965730AbXCTSjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 14:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965621AbXCTSjD
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 14:39:03 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52030 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965730AbXCTSir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 14:38:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2KIchcD016552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Mar 2007 11:38:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2KIcYof008213;
	Tue, 20 Mar 2007 10:38:39 -0800
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42756>


When creating a new object, we use "deflate(stream, Z_FINISH)" in a loop 
until it no longer returns Z_OK, and then we do "deflateEnd()" to finish 
up business.

That should all work, but the fact is, it's not how you're _supposed_ to 
use the zlib return values properly:

 - deflate() should never return Z_OK in the first place, except if we 
   need to increase the output buffer size (which we're not doing, and 
   should never need to do, since we pre-allocated a buffer that is 
   supposed to be able to hold the output in full). So the "while()" loop 
   was incorrect: Z_OK doesn't actually mean "ok, continue", it means "ok, 
   allocate more memory for me and continue"!

 - if we got an error return, we would consider it to be end-of-stream, 
   but it could be some internal zlib error.  In short, we should check 
   for Z_STREAM_END explicitly, since that's the only valid return value 
   anyway for the Z_FINISH case.

 - we never checked deflateEnd() return codes at all.

Now, admittedly, none of these issues should ever happen, unless there is 
some internal bug in zlib. So this patch should make zero difference, but 
it seems to be the right thing to do.

We should probablybe anal and check the return value of "deflateInit()" 
too!

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Somebody who has worked more with zlib should probably double-check me, 
but this is what <zlib.h> claims is the right thing to do.

		Linus

---
 sha1_file.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c445a24..bfcbbea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1947,7 +1947,7 @@ int hash_sha1_file(void *buf, unsigned long len, const char *type,
 
 int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
-	int size;
+	int size, ret;
 	unsigned char *compressed;
 	z_stream stream;
 	unsigned char sha1[20];
@@ -2007,9 +2007,14 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	/* Then the data itself.. */
 	stream.next_in = buf;
 	stream.avail_in = len;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&stream);
+	ret = deflate(&stream, Z_FINISH);
+	if (ret != Z_STREAM_END)
+		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
+
+	ret = deflateEnd(&stream);
+	if (ret != Z_OK)
+		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
+
 	size = stream.total_out;
 
 	if (write_buffer(fd, compressed, size) < 0)

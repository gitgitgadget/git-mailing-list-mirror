From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 12:48:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111241460.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607112031150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607111153170.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607112116270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 21:55:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0OJe-0006lf-JG
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 21:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWGKTyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 15:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWGKTyj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 15:54:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932111AbWGKTyj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 15:54:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BJm9nW021317
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 12:48:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BJm8tG004078;
	Tue, 11 Jul 2006 12:48:08 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607112116270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23731>



On Tue, 11 Jul 2006, Johannes Schindelin wrote:
> 
> > Or, more likely, the parse_sha1_header() function should just be changed 
> > to check the binary format first (and then add your comment about why that 
> > is safe).
> 
> Yes, exactly.

Here's a newer verson of [2/3], with these issues fixed. It actually fixes 
things twice: (a) by parsing the binary version first (which makes sense 
for a totally independent reason - if that is going to be the "default" 
version in the long run, we should just test it first anyway) and (b) by 
making the ASCII version parser stricter too.

This did, btw, also fix the test failure, so the fact that the ASCII 
header parser wasn't careful enough was actually a problem in real life.

So please throw away the old version.

		Linus

---
From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"

The pack-file format is slightly different from the traditional git
object format, in that it has a much denser binary header encoding.

The traditional format uses an ASCII string with type and length
information, which is somewhat wasteful.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 sha1_file.c |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8734d50..15ccf5e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -697,9 +697,9 @@ static int unpack_sha1_header(z_stream *
 	return inflate(stream, 0);
 }
 
-static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size)
+static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, unsigned int hdrlen)
 {
-	int bytes = strlen(buffer) + 1;
+	int bytes = hdrlen;
 	unsigned char *buf = xmalloc(1+size);
 
 	memcpy(buf, (char *) buffer + bytes, stream->total_out - bytes);
@@ -720,25 +720,40 @@ static void *unpack_sha1_rest(z_stream *
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
+static int parse_ascii_sha1_header(char *hdr, char *type, unsigned long *sizep)
 {
-	int i;
+	int bytes = 0;
 	unsigned long size;
 
 	/*
 	 * The type can be at most ten bytes (including the 
 	 * terminating '\0' that we add), and is followed by
 	 * a space. 
+	 *
+	 * We want at least three characters, and they should
+	 * all be normal lower-case letters.
 	 */
-	i = 10;
 	for (;;) {
-		char c = *hdr++;
+		unsigned char c = *hdr++;
+		bytes++;
 		if (c == ' ')
 			break;
-		if (!--i)
+		if (bytes >= 10)
 			return -1;
 		*type++ = c;
+
+		/*
+		 * The high nybble must be 6 of 7, see
+		 * parse_binary_header(). This covers
+		 * all ASCII lowercase characters.
+		 */
+		if (c < 0x60 || c > 0x7f)
+			return -1;
 	}
+
+	/* Minimum three letters and the space */
+	if (bytes < 4)
+		return -1;
 	*type = 0;
 
 	/*
@@ -746,6 +761,7 @@ static int parse_sha1_header(char *hdr, 
 	 * decimal format (ie "010" is not valid).
 	 */
 	size = *hdr++ - '0';
+	bytes++;
 	if (size > 9)
 		return -1;
 	if (size) {
@@ -754,6 +770,7 @@ static int parse_sha1_header(char *hdr, 
 			if (c > 9)
 				break;
 			hdr++;
+			bytes++;
 			size = size * 10 + c;
 		}
 	}
@@ -762,20 +779,74 @@ static int parse_sha1_header(char *hdr, 
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : 0;
+	bytes++;
+	return *hdr ? -1 : bytes;
+}
+
+/*
+ * We never confuse a binary header with an old ASCII one,
+ * because the ASCII one will always start with a lower-case
+ * letter, meaning that the first byte will be of the form
+ * 0x6? or 0x7?.
+ *
+ * That in turn would be parsed as object type 6 or 7, neither
+ * of which is valid for a unpacked object (object type 7 is
+ * a delta, and can only exist in a pack-file, while object type
+ * 6 is invalid).
+ */
+static int parse_binary_sha1_header(char *hdr, char *type, unsigned long *sizep)
+{
+	unsigned char c;
+	int bytes = 1;
+	unsigned long size;
+	unsigned object_type, bits;
+	static const char *typename[8] = {
+		NULL,	/* OBJ_EXT */
+		"commit", "tree", "blob", "tag",
+		NULL, NULL, NULL
+	};
+
+	c = *hdr++;
+	object_type = (c >> 4) & 7;
+	if (!typename[object_type])
+		return -1;
+	strcpy(type, typename[object_type]);
+	size = c & 15;
+	bits = 4;
+	while (!(c & 0x80)) {
+		if (bits >= 8*sizeof(unsigned long))
+			return -1;
+		c = *hdr++;
+		size += (unsigned long) (c & 0x7f) << bits;
+		bytes++;
+		bits += 7;
+	}
+	*sizep = size;
+	return bytes;
+}
+
+static int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
+{
+	int retval = parse_binary_sha1_header(hdr, type, sizep);
+	if (retval < 0)
+		retval = parse_ascii_sha1_header(hdr, type, sizep);
+	return retval;
 }
 
 void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
 {
-	int ret;
+	int ret, hdrlen;
 	z_stream stream;
 	char hdr[8192];
 
 	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
-	if (ret < Z_OK || parse_sha1_header(hdr, type, size) < 0)
+	if (ret < Z_OK)
+		return NULL;
+	hdrlen = parse_sha1_header(hdr, type, size);
+	if (hdrlen < 0)
 		return NULL;
 
-	return unpack_sha1_rest(&stream, hdr, *size);
+	return unpack_sha1_rest(&stream, hdr, *size, hdrlen);
 }
 
 /* forward declaration for a mutually recursive function */

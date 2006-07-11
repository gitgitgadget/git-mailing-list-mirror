From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 10:12:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 19:18:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Lsn-0004QZ-6X
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 19:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWGKRSe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 13:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGKRSe
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 13:18:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751138AbWGKRSd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 13:18:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BHC9nW011998
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 10:12:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BHC8Oh029649;
	Tue, 11 Jul 2006 10:12:08 -0700
To: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23718>


The pack-file format is slightly different from the traditional git
object format, in that it has a much denser binary header encoding.

The traditional format uses an ASCII string with type and length
information, which is somewhat wasteful.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This should probably be applied to the main tree asap if we think
this is at all a worthwhile exercise. But somebody should verify that I 
got the format right first!

 sha1_file.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8734d50..ca5f0c0 100644
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
@@ -720,9 +720,9 @@ static void *unpack_sha1_rest(z_stream *
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
+static int parse_ascii_sha1_header(char *hdr, char *type, unsigned long *sizep)
 {
-	int i;
+	int i, bytes = 0;
 	unsigned long size;
 
 	/*
@@ -733,6 +733,7 @@ static int parse_sha1_header(char *hdr, 
 	i = 10;
 	for (;;) {
 		char c = *hdr++;
+		bytes++;
 		if (c == ' ')
 			break;
 		if (!--i)
@@ -746,6 +747,7 @@ static int parse_sha1_header(char *hdr, 
 	 * decimal format (ie "010" is not valid).
 	 */
 	size = *hdr++ - '0';
+	bytes++;
 	if (size > 9)
 		return -1;
 	if (size) {
@@ -754,6 +756,7 @@ static int parse_sha1_header(char *hdr, 
 			if (c > 9)
 				break;
 			hdr++;
+			bytes++;
 			size = size * 10 + c;
 		}
 	}
@@ -762,20 +765,65 @@ static int parse_sha1_header(char *hdr, 
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : 0;
+	bytes++;
+	if (*hdr)
+		bytes = -1;
+	return bytes;
+}
+
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
+	int retval = parse_ascii_sha1_header(hdr, type, sizep);
+	if (retval < 0)
+		retval = parse_binary_sha1_header(hdr, type, sizep);
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
@@ -1192,7 +1240,7 @@ struct packed_git *find_sha1_pack(const 
 
 int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
 {
-	int status;
+	int status, hdrlen;
 	unsigned long mapsize, size;
 	void *map;
 	z_stream stream;

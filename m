From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/6] sha1_file.c: cleanup hdr usage
Date: Mon, 26 Feb 2007 14:55:55 -0500
Message-ID: <1172519760216-git-send-email-nico@cam.org>
References: <11725197603476-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:56:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlxC-000448-1O
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbXBZT4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbXBZT4F
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:56:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030495AbXBZT4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:56:03 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3007SW61CD1Q1@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 14:56:01 -0500 (EST)
In-reply-to: <11725197603476-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.572.ge86d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40652>

Let's have hdr be a simple char pointer/array when possible, and let's
reduce its storage to 32 bytes.  Especially for sha1_loose_object_info()
where 128 bytes is way excessive and wastes extra CPU cycles inflating.

The object type is already restricted to 10 bytes in parse_sha1_header()
and the size, even if it is 64 bits, will fit in 20 decimal numbers.  So
32 bytes is plenty.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9a1dee0..57a9b53 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1461,7 +1461,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, char *type, unsigne
 	unsigned long mapsize, size;
 	void *map;
 	z_stream stream;
-	char hdr[128];
+	char hdr[32];
 
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
@@ -1628,12 +1628,12 @@ void *read_object_with_reference(const unsigned char *sha1,
 
 static void write_sha1_file_prepare(void *buf, unsigned long len,
                                     const char *type, unsigned char *sha1,
-                                    unsigned char *hdr, int *hdrlen)
+                                    char *hdr, int *hdrlen)
 {
 	SHA_CTX c;
 
 	/* Generate the header */
-	*hdrlen = sprintf((char *)hdr, "%s %lu", type, len)+1;
+	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
 	SHA1_Init(&c);
@@ -1740,7 +1740,7 @@ static int write_binary_header(unsigned char *hdr, enum object_type type, unsign
 
 static void setup_object_header(z_stream *stream, const char *type, unsigned long len)
 {
-	int obj_type, hdr;
+	int obj_type, hdrlen;
 
 	if (use_legacy_headers) {
 		while (deflate(stream, 0) == Z_OK)
@@ -1757,16 +1757,16 @@ static void setup_object_header(z_stream *stream, const char *type, unsigned lon
 		obj_type = OBJ_TAG;
 	else
 		die("trying to generate bogus object of type '%s'", type);
-	hdr = write_binary_header(stream->next_out, obj_type, len);
-	stream->total_out = hdr;
-	stream->next_out += hdr;
-	stream->avail_out -= hdr;
+	hdrlen = write_binary_header(stream->next_out, obj_type, len);
+	stream->total_out = hdrlen;
+	stream->next_out += hdrlen;
+	stream->avail_out -= hdrlen;
 }
 
 int hash_sha1_file(void *buf, unsigned long len, const char *type,
                    unsigned char *sha1)
 {
-	unsigned char hdr[50];
+	char hdr[32];
 	int hdrlen;
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	return 0;
@@ -1780,7 +1780,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	unsigned char sha1[20];
 	char *filename;
 	static char tmpfile[PATH_MAX];
-	unsigned char hdr[50];
+	char hdr[32];
 	int fd, hdrlen;
 
 	/* Normally if we have it in the pack then we do not bother writing
@@ -1827,7 +1827,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	stream.avail_out = size;
 
 	/* First header.. */
-	stream.next_in = hdr;
+	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
 	setup_object_header(&stream, type, len);
 
@@ -1859,7 +1859,7 @@ static void *repack_object(const unsigned char *sha1, unsigned long *objsize)
 	unsigned char *unpacked;
 	unsigned long len;
 	char type[20];
-	char hdr[50];
+	char hdr[32];
 	int hdrlen;
 	void *buf;
 
-- 
1.5.0.572.ge86d

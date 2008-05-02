From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/7] pack-objects: move compression code in a separate function
Date: Fri, 02 May 2008 15:11:49 -0400
Message-ID: <1209755511-7840-6-git-send-email-nico@cam.org>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
 <1209755511-7840-2-git-send-email-nico@cam.org>
 <1209755511-7840-3-git-send-email-nico@cam.org>
 <1209755511-7840-4-git-send-email-nico@cam.org>
 <1209755511-7840-5-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0ha-00058j-1t
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936617AbYEBTMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936504AbYEBTMP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:12:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965183AbYEBTMF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:12:05 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:54 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
In-reply-to: <1209755511-7840-5-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81027>

A later patch will make use of that code too.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   53 ++++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 257002a..4319e7b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -124,6 +124,32 @@ static void *get_delta(struct object_entry *entry)
 	return delta_buf;
 }
 
+static unsigned long do_compress(void **pptr, unsigned long size)
+{
+	z_stream stream;
+	void *in, *out;
+	unsigned long maxsize;
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, pack_compression_level);
+	maxsize = deflateBound(&stream, size);
+
+	in = *pptr;
+	out = xmalloc(maxsize);
+	*pptr = out;
+
+	stream.next_in = in;
+	stream.avail_in = size;
+	stream.next_out = out;
+	stream.avail_out = maxsize;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+
+	free(in);
+	return stream.total_out;
+}
+
 /*
  * The per-object header is a pretty dense thing, which is
  *  - first byte: low four bits are "size", then three bits of "type",
@@ -226,11 +252,10 @@ static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry,
 				  off_t write_offset)
 {
-	unsigned long size, limit;
+	unsigned long size, limit, datalen;
 	void *buf;
 	unsigned char header[10], dheader[10];
 	unsigned hdrlen;
-	off_t datalen;
 	enum object_type type;
 	int usable_delta, to_reuse;
 
@@ -272,9 +297,6 @@ static unsigned long write_object(struct sha1file *f,
 				 */
 
 	if (!to_reuse) {
-		z_stream stream;
-		unsigned long maxsize;
-		void *out;
 		if (!usable_delta) {
 			buf = read_sha1_file(entry->idx.sha1, &type, &size);
 			if (!buf)
@@ -291,20 +313,7 @@ static unsigned long write_object(struct sha1file *f,
 			type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
-		/* compress the data to store and put compressed length in datalen */
-		memset(&stream, 0, sizeof(stream));
-		deflateInit(&stream, pack_compression_level);
-		maxsize = deflateBound(&stream, size);
-		out = xmalloc(maxsize);
-		/* Compress it */
-		stream.next_in = buf;
-		stream.avail_in = size;
-		stream.next_out = out;
-		stream.avail_out = maxsize;
-		while (deflate(&stream, Z_FINISH) == Z_OK)
-			/* nothing */;
-		deflateEnd(&stream);
-		datalen = stream.total_out;
+		datalen = do_compress(&buf, size);
 
 		/*
 		 * The object header is a byte of 'type' followed by zero or
@@ -324,7 +333,6 @@ static unsigned long write_object(struct sha1file *f,
 			while (ofs >>= 7)
 				dheader[--pos] = 128 | (--ofs & 127);
 			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
-				free(out);
 				free(buf);
 				return 0;
 			}
@@ -337,7 +345,6 @@ static unsigned long write_object(struct sha1file *f,
 			 * an additional 20 bytes for the base sha1.
 			 */
 			if (limit && hdrlen + 20 + datalen + 20 >= limit) {
-				free(out);
 				free(buf);
 				return 0;
 			}
@@ -346,14 +353,12 @@ static unsigned long write_object(struct sha1file *f,
 			hdrlen += 20;
 		} else {
 			if (limit && hdrlen + datalen + 20 >= limit) {
-				free(out);
 				free(buf);
 				return 0;
 			}
 			sha1write(f, header, hdrlen);
 		}
-		sha1write(f, out, datalen);
-		free(out);
+		sha1write(f, buf, datalen);
 		free(buf);
 	}
 	else {
-- 
1.5.5.1.226.g6f6e8

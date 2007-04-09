From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 05/10] compute object CRC32 with index-pack
Date: Mon, 09 Apr 2007 01:06:32 -0400
Message-ID: <11760952002687-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
 <11760951993409-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5v-00038I-QG
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbXDIFGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbXDIFGz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbXDIFGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:43 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:40 -0400 (EDT)
In-reply-to: <11760951993409-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44038>

Same as previous patch but for index-pack.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 66fb0bc..d33f723 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -15,6 +15,7 @@ struct object_entry
 	off_t offset;
 	unsigned long size;
 	unsigned int hdr_size;
+	uint32_t crc32;
 	enum object_type type;
 	enum object_type real_type;
 	unsigned char sha1[20];
@@ -86,6 +87,7 @@ static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static SHA_CTX input_ctx;
+static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
 
 /* Discard current buffer used content. */
@@ -128,6 +130,7 @@ static void use(int bytes)
 {
 	if (bytes > input_len)
 		die("used more bytes than were available");
+	input_crc32 = crc32(input_crc32, input_buffer + input_offset, bytes);
 	input_len -= bytes;
 	input_offset += bytes;
 
@@ -224,8 +227,10 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 	unsigned long size;
 	off_t base_offset;
 	unsigned shift;
+	void *data;
 
 	obj->offset = consumed_bytes;
+	input_crc32 = crc32(0, Z_NULL, 0);
 
 	p = fill(1);
 	c = *p;
@@ -276,7 +281,9 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 	}
 	obj->hdr_size = consumed_bytes - obj->offset;
 
-	return unpack_entry_data(obj->offset, obj->size);
+	data = unpack_entry_data(obj->offset, obj->size);
+	obj->crc32 = input_crc32;
+	return data;
 }
 
 static void *get_data_from_pack(struct object_entry *obj)
@@ -521,7 +528,7 @@ static void parse_pack_objects(unsigned char *sha1)
 		fputc('\n', stderr);
 }
 
-static int write_compressed(int fd, void *in, unsigned int size)
+static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_crc)
 {
 	z_stream stream;
 	unsigned long maxsize;
@@ -542,6 +549,7 @@ static int write_compressed(int fd, void *in, unsigned int size)
 
 	size = stream.total_out;
 	write_or_die(fd, out, size);
+	*obj_crc = crc32(*obj_crc, out, size);
 	free(out);
 	return size;
 }
@@ -562,8 +570,10 @@ static void append_obj_to_pack(const unsigned char *sha1, void *buf,
 	}
 	header[n++] = c;
 	write_or_die(output_fd, header, n);
+	obj[0].crc32 = crc32(0, Z_NULL, 0);
+	obj[0].crc32 = crc32(obj[0].crc32, header, n);
 	obj[1].offset = obj[0].offset + n;
-	obj[1].offset += write_compressed(output_fd, buf, size);
+	obj[1].offset += write_compressed(output_fd, buf, size, &obj[0].crc32);
 	hashcpy(obj->sha1, sha1);
 }
 
-- 
1.5.1.696.g6d352-dirty

From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 2/5] Use new compress helpers in git files
Date: Fri, 11 Jan 2008 08:37:15 +0100
Message-ID: <e5bfff550801102337w1afc6c88n2c60f26fa80d8da4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDESb-0007HJ-Iz
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYAKHhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbYAKHhT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:37:19 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:37828 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbYAKHhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:37:17 -0500
Received: by rv-out-0910.google.com with SMTP id k20so850972rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 23:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=gudrTe9eEtVmU4IBci05UXxp2CLKYfGIDcR/JF/S3L4=;
        b=WGgLIrssQuQU0BayMLvpJ2oUPX0j9+xcin4gRxU7CMdfDRXKhwHuoqwaHm4yamqzl+vS98mftBDH8/gf7oe9HW4qoXNDFpA5InCFX9g73IwBCcVP4/r4YQKT9EGWuwZ4SGY+5LEcjdIGK8mX2GFo5jc7DfWFXzTQ/sFJcAbH/ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Pq//77+V8NtXIENsn+ag+vxM+uQVYLdYTYEWJwNWTx9ZmaW4FYJ8PrZiLz03ak77mDDCL7GELjaHbHTFLCzItS4lmtWzLjN94OUITWzlsYL65lMlg45nlBPGiv9oG9GKD5SSscIJG+oGNSWkSWynv6CKcbscofJ4d7YVpsQCO6Q=
Received: by 10.141.62.15 with SMTP id p15mr1791192rvk.159.1200037035470;
        Thu, 10 Jan 2008 23:37:15 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 23:37:15 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70131>

These are the 'easy' ones, where a signgle step
compression is requested so that we can use only
one call to compress_all()

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 archive-zip.c          |   28 +++-------------------------
 builtin-pack-objects.c |   21 ++++-----------------
 diff.c                 |   22 +++++-----------------
 index-pack.c           |   20 +++-----------------
 4 files changed, 15 insertions(+), 76 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 74e30f6..9071b86 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "commit.h"
+#include "compress.h"
 #include "blob.h"
 #include "tree.h"
 #include "quote.h"
@@ -97,33 +98,10 @@ static void copy_le32(unsigned char *dest,
 static void *zlib_deflate(void *data, unsigned long size,
                           unsigned long *compressed_size)
 {
-	z_stream stream;
-	unsigned long maxsize;
-	void *buffer;
-	int result;
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	maxsize = deflateBound(&stream, size);
-	buffer = xmalloc(maxsize);
-
-	stream.next_in = data;
-	stream.avail_in = size;
-	stream.next_out = buffer;
-	stream.avail_out = maxsize;
-
-	do {
-		result = deflate(&stream, Z_FINISH);
-	} while (result == Z_OK);
-
-	if (result != Z_STREAM_END) {
-		free(buffer);
-		return NULL;
-	}

-	deflateEnd(&stream);
-	*compressed_size = stream.total_out;
+	unsigned char *buffer = NULL;

+	*compressed_size = compress_all(zlib_compression_level, data, size, &buffer);
 	return buffer;
 }

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a39cb82..66dedf9 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "compress.h"
 #include "attr.h"
 #include "object.h"
 #include "blob.h"
@@ -409,9 +410,7 @@ static unsigned long write_object(struct sha1file *f,
 				 */

 	if (!to_reuse) {
-		z_stream stream;
-		unsigned long maxsize;
-		void *out;
+		unsigned char *out = NULL;
 		if (!usable_delta) {
 			buf = read_sha1_file(entry->idx.sha1, &obj_type, &size);
 			if (!buf)
@@ -432,20 +431,8 @@ static unsigned long write_object(struct sha1file *f,
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
 		/* compress the data to store and put compressed length in datalen */
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
-		deflateEnd(&stream);
+		datalen = compress_all(pack_compression_level, buf, size, &out);
+
 		/*
 		 * The object header is a byte of 'type' followed by zero or
 		 * more bytes of length.
diff --git a/diff.c b/diff.c
index b18c140..43f537c 100644
--- a/diff.c
+++ b/diff.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "compress.h"
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -1037,23 +1038,10 @@ static unsigned char *deflate_it(char *data,
 				 unsigned long size,
 				 unsigned long *result_size)
 {
-	int bound;
-	unsigned char *deflated;
-	z_stream stream;
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	bound = deflateBound(&stream, size);
-	deflated = xmalloc(bound);
-	stream.next_out = deflated;
-	stream.avail_out = bound;
-
-	stream.next_in = (unsigned char *)data;
-	stream.avail_in = size;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		; /* nothing */
-	deflateEnd(&stream);
-	*result_size = stream.total_out;
+	unsigned char *deflated = NULL;
+
+	*result_size = compress_all(zlib_compression_level,
+                                   (unsigned char *)data, size, &deflated);
 	return deflated;
 }

diff --git a/index-pack.c b/index-pack.c
index 9fd6982..880088e 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "compress.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
@@ -494,24 +495,9 @@ static void parse_pack_objects(unsigned char

 static int write_compressed(int fd, void *in, unsigned int size,
uint32_t *obj_crc)
 {
-	z_stream stream;
-	unsigned long maxsize;
-	void *out;
+	unsigned char *out = NULL;

-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	maxsize = deflateBound(&stream, size);
-	out = xmalloc(maxsize);
-
-	/* Compress it */
-	stream.next_in = in;
-	stream.avail_in = size;
-	stream.next_out = out;
-	stream.avail_out = maxsize;
-	while (deflate(&stream, Z_FINISH) == Z_OK);
-	deflateEnd(&stream);
-
-	size = stream.total_out;
+	size = compress_all(zlib_compression_level, in, size, &out);
 	write_or_die(fd, out, size);
 	*obj_crc = crc32(*obj_crc, out, size);
 	free(out);
-- 
1.5.4.rc2.89.g1b3f-dirty

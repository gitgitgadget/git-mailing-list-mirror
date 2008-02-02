From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 02/11] Use new compress helpers in git files
Date: Sat,  2 Feb 2008 12:35:47 +0100
Message-ID: <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:37:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGga-0000Gr-AO
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbYBBLg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756313AbYBBLgz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:36:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbYBBLgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:44 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BElKhHpkTwCa+ZPSIqW83wjF9qj5eRx2HJE4/7R/Ie0=;
        b=eFntnM14reQUuKQXp/jwbGNWl1+URRxhZyHR0WqzW4LCZi9NJByoL5Ldxee5foRu+9qVL1S+KywRBQC4E4YQvbDq+Y66Fct7ik2S8NEEX+pRQkyEHos9097R/KyH2oY7BOrDaia3gPpFbNX8td5380oA/4uZIK9Y1qe7NrExkac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=spxQiz/OWjQXYrwpy5N8rHUml9jyjJVwNdPIHnIA9iFbvwPGvsRocPq4Cl6tutbAWlrZRoU7GSjYTKavDnYrsLqt+mYcW55guPjrQxo3cfngjVGn/ypOxF2+ttEmHUAKQLLKYZ4Nb0Z4XWXmU+duwWsUcxbutqmRISal+O4PfXg=
Received: by 10.86.91.12 with SMTP id o12mr4243441fgb.72.1201952203738;
        Sat, 02 Feb 2008 03:36:43 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.40
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:41 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72263>

These are the 'easy' ones, where a signgle step
compression is requested so that we can use only
one call to compress_all()

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 archive-zip.c          |   28 +++-------------------------
 builtin-pack-objects.c |   19 +++----------------
 diff.c                 |   22 +++++-----------------
 index-pack.c           |   20 +++-----------------
 4 files changed, 14 insertions(+), 75 deletions(-)

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
@@ -97,33 +98,10 @@ static void copy_le32(unsigned char *dest, unsigned int n)
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
index d3efeff..991a30f 100644
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
@@ -432,19 +431,7 @@ static unsigned long write_object(struct sha1file *f,
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
+		datalen = compress_all(pack_compression_level, buf, size, &out);
 
 		/*
 		 * The object header is a byte of 'type' followed by zero or
diff --git a/diff.c b/diff.c
index d464fe3..9eb9672 100644
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
@@ -494,24 +495,9 @@ static void parse_pack_objects(unsigned char *sha1)
 
 static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_crc)
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
1.5.4.rc4.39.g524a

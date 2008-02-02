From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 05/11] Use new compress helpers in sha1_file.c
Date: Sat,  2 Feb 2008 12:35:50 +0100
Message-ID: <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:38:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGhj-0000Z5-9t
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbYBBLhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756525AbYBBLhA
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:37:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbYBBLgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/g4f2jrcCVnGvMU3S9ua3Jo3PG8a+nX98hEqQCKLUDs=;
        b=RgI+ceHvTEGZRmSFj/RURL1QAR4rx+IsEfuls5RXI7JTKpdWJu3RkfmMDJI2Du91uuBxv+x4afSkIrxVDMGl+lMB9Mc48Tlh0GOdsJKX3An426baHeldtkfvBJla8Q4a3188IWAJNBVkIQV+Dt5ZPVO24dtYPypMSj6yNXivO8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l5F/cTkA2TNbueQmJO5WZoVuacsLuNC8DI4jbpSW5L6/cRUyOUoWDyr0l70GrWo0QDVZQFocrZOKv53w5PgsIuC+A0Qn386BTOqTl830ZZ3W8JEBlFbc1BDnlKNF7Qaxogg0g2rmRIe5X4RwFzNIPrW4qyY/gPRjZlrqKEAwZGg=
Received: by 10.86.79.19 with SMTP id c19mr4271967fgb.31.1201952209984;
        Sat, 02 Feb 2008 03:36:49 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.47
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:49 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72266>

A multistep compress is required here, so
we need the full arsenal of compress helpers.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 sha1_file.c |   41 ++++++++++++-----------------------------
 1 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 66a4e00..f48ad04 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -7,6 +7,7 @@
  * creation etc.
  */
 #include "cache.h"
+#include "compress.h"
 #include "delta.h"
 #include "pack.h"
 #include "blob.h"
@@ -2102,33 +2103,23 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	}
 
 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	size = 8 + deflateBound(&stream, len+hdrlen);
+	size = 8 + compress_alloc(&stream, zlib_compression_level, len+hdrlen);
 	compressed = xmalloc(size);
 
 	/* Compress it */
-	stream.next_out = compressed;
-	stream.avail_out = size;
+	compress_start(&stream, (unsigned char *)hdr, hdrlen, compressed, size);
 
 	/* First header.. */
-	stream.next_in = (unsigned char *)hdr;
-	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+	compress_next(&stream, Z_NO_FLUSH);
 
 	/* Then the data itself.. */
 	stream.next_in = buf;
 	stream.avail_in = len;
-	ret = deflate(&stream, Z_FINISH);
+	ret = compress_next(&stream, Z_FINISH);
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
 
-	ret = deflateEnd(&stream);
-	if (ret != Z_OK)
-		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
-
-	size = stream.total_out;
+	size = compress_free(&stream);
 
 	if (write_buffer(fd, compressed, size) < 0)
 		die("unable to write sha1 file");
@@ -2163,30 +2154,22 @@ static void *repack_object(const unsigned char *sha1, unsigned long *objsize)
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	size = deflateBound(&stream, len + hdrlen);
+	size = compress_alloc(&stream, zlib_compression_level, len + hdrlen);
 	buf = xmalloc(size);
 
 	/* Compress it */
-	stream.next_out = buf;
-	stream.avail_out = size;
+	compress_start(&stream, (unsigned char *)hdr, hdrlen, buf, size);
 
 	/* First header.. */
-	stream.next_in = (void *)hdr;
-	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+	compress_next(&stream, Z_NO_FLUSH);
 
 	/* Then the data itself.. */
 	stream.next_in = unpacked;
 	stream.avail_in = len;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&stream);
-	free(unpacked);
+	compress_next(&stream, Z_FINISH);
 
-	*objsize = stream.total_out;
+	*objsize = compress_free(&stream);
+	free(unpacked);
 	return buf;
 }
 
-- 
1.5.4.rc4.39.g524a

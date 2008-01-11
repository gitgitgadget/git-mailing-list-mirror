From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Use new compress helpers in sha1_file.c
Date: Fri, 11 Jan 2008 08:41:36 +0100
Message-ID: <e5bfff550801102341o5be9c1a7pedd94fb39b21b1ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:42:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDEWm-0008Kn-9q
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbYAKHli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYAKHli
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:41:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:44899 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbYAKHlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:41:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so852052rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vKnMuCfOxcuvFO/Ks6827Pvf4M4goevDza21EQvACr0=;
        b=HbTsQTQ1AH/5JdNoepQEYxNduh8zegEMQO3VtZDmnV2InEaPtliivjcKrQS1t/8yfcrITd+QM13NnDh0/uKS3wTDnYBJzUhAHVc4VtjTGysKW3w8VOxJQxnXK0H4FQZ8uMhN0wpHHRp5AMbrfGgBd+sBg+EMp/pkEBPXkiPxbXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uX5yDZrjOtRnZkNIvuERjYI+ZL6OtNizDzZKNuAu5X9AIYoBx6iyLbSdtl7zvo6jMbb1SGjAuBkG2W1fbyjjiTjkmIRNI8SITuPce13ZZ5SUbxWDUkpXy4c6Rt/5X3AGO66zv2r7zLCgHBdlyRwNB88aYFHwH8EXVnR/9DeT1q8=
Received: by 10.141.142.15 with SMTP id u15mr91069rvn.66.1200037296808;
        Thu, 10 Jan 2008 23:41:36 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 23:41:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70134>

A multistep compress is required here, so
we need the full arsenal of compress helpers.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 sha1_file.c |   41 ++++++++++++-----------------------------
 1 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6583797..6c94bd5 100644
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
@@ -2086,33 +2087,23 @@ int write_sha1_file(void *buf, unsigned long
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
@@ -2147,30 +2138,22 @@ static void *repack_object(const unsigned char *sha1,
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
1.5.4.rc2.89.g1b3f-dirty

From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 5/5] Use new decompress helpers in sha1_file.c
Date: Thu, 10 Jan 2008 22:09:20 +0100
Message-ID: <e5bfff550801101309p62f235beh776f0ffe521d2e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4er-0008FX-9R
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbYAJVJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYAJVJV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:09:21 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:56234 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbYAJVJU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:09:20 -0500
Received: by rv-out-0910.google.com with SMTP id k20so702474rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=fq6V/F5C+45SMv97NS6KysMFO1SBN8UOSUSo5Fn1W0s=;
        b=hGYdOwHaKBpt/4Vvkqb9iA72PIbgZ829omRTr/S70D/aaIMNOe+lIPVppD1OAjTtgtIOJGRbZPLZDdQUREZWM2aEQcpDGtk6/oRWgALGJl7+8vpxqzmBJ4I++866h516ofntKQ1vV6j7D0hfVwV3D8hHaoTSAblEGOf2cldhejU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EhPjT1U9mosklw2VbzUVviELaTlCz01tyrCnQikD3Oe9RUF1qlbNjKNMG1YfUrlPZnby6+xdEZIslnCPL3bmUK5gwIr2NX8wmduf15Z67JbZDib42UeRKGo7N34GkB1ardTzWNm/rNP+5ZigfQDyVNt6S9OFBVcCC2Tmy1rHHOY=
Received: by 10.141.75.6 with SMTP id c6mr1523712rvl.43.1199999360168;
        Thu, 10 Jan 2008 13:09:20 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 13:09:20 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70091>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 sha1_file.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6583797..2a76043 100644
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
@@ -2086,25 +2087,19 @@ int write_sha1_file(void *buf, unsigned long
len, const char *type, unsigned cha
 	}

 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	size = 8 + deflateBound(&stream, len+hdrlen);
+	size = 8 + z_deflate_init(&stream, zlib_compression_level, len+hdrlen);
 	compressed = xmalloc(size);

 	/* Compress it */
-	stream.next_out = compressed;
-	stream.avail_out = size;
+	z_deflate_start(&stream, (unsigned char *)hdr, hdrlen, compressed, size);

 	/* First header.. */
-	stream.next_in = (unsigned char *)hdr;
-	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+	z_deflate_next(&stream, Z_NO_FLUSH);

 	/* Then the data itself.. */
 	stream.next_in = buf;
 	stream.avail_in = len;
-	ret = deflate(&stream, Z_FINISH);
+	ret = z_deflate_next(&stream, Z_FINISH);
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);

-- 
1.5.4.rc2.89.g1b3f

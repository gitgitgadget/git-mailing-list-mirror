From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 4/5] Use new decompress helpers in http-push.c
Date: Thu, 10 Jan 2008 22:08:25 +0100
Message-ID: <e5bfff550801101308v2b89e935v428b1d0898277def@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4eR-00086H-HA
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYAJVI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756861AbYAJVI2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:08:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:53797 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbYAJVI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:08:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so702256rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QG9xz4p1sBR1Vx4E4FbEehFS5vkjarqy6DsWbuK5RJA=;
        b=nU+EvRyjlYnjOAnAbbMD2eCsKTCwrRkXrR4QVvLFVsXLAH/fBuWjBnrFp+NAxQe5LZSrTG/lJaMpv/MUUiTDpMpwa/+iyaaTF145DJTA2/EuEXUBkJZklU1jsYYvtpkI6osC0xWR9Upg7TWWRxypdKWNzobZxr18ROCHCQgVKYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PuAN8d6JBS1alV81vYqkvBvsJ0S1OosdA5neHidq5Jg2ThFThAwYIp5IpTBkZA4zH1U53iue4GcuyE4vOyWo6xdj7w1TC9xVz7GpVsrGwwd8yQzVuQ459YzQ1AFvyZHaEJkGScCh7LbAzUxLZdpODlRct3g2e1y7wtGb/frKVoo=
Received: by 10.140.188.10 with SMTP id l10mr1512622rvf.78.1199999305913;
        Thu, 10 Jan 2008 13:08:25 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 13:08:25 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70090>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 http-push.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/http-push.c b/http-push.c
index 55d0c94..03b2615 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "compress.h"
 #include "pack.h"
 #include "tag.h"
 #include "blob.h"
@@ -491,27 +492,22 @@ static void start_put(struct transfer_request
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;

 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	size = deflateBound(&stream, len + hdrlen);
+	size = z_deflate_init(&stream, zlib_compression_level, len + hdrlen);
 	strbuf_init(&request->buffer.buf, size);
 	request->buffer.posn = 0;

 	/* Compress it */
-	stream.next_out = (unsigned char *)request->buffer.buf.buf;
-	stream.avail_out = size;
+	z_deflate_start(&stream, (void *)hdr, hdrlen,
+                       (unsigned char *)request->buffer.buf.buf, size);

 	/* First header.. */
-	stream.next_in = (void *)hdr;
-	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+	z_deflate_next(&stream, Z_NO_FLUSH);

 	/* Then the data itself.. */
 	stream.next_in = unpacked;
 	stream.avail_in = len;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/* nothing */;
+	z_deflate_next(&stream, Z_FINISH);
+
 	deflateEnd(&stream);
 	free(unpacked);

-- 
1.5.4.rc2.89.g1b3f

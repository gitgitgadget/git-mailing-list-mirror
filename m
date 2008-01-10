From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 3/5] Use new decompress helpers in index-pack.c
Date: Thu, 10 Jan 2008 22:07:24 +0100
Message-ID: <e5bfff550801101307g1675b94an46c25d9de03d2b46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4d1-0007ZI-Si
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbYAJVH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYAJVH1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:07:27 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:52414 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbYAJVH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:07:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so702037rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=MnOY86xF/XrGqgyGJOWIdCTra1+NVFgFPteqWUJoGPk=;
        b=ZpHFK8m0zuOW8hhqOpLTfiR1GqWgZgatsI16q2X3/HUD3OpZSdpnz0+fGCwC0xHmrPcJ0VXKYLCIEpve+L8JXsnmQtymXDzRM9p0v5fsGhqngsuLUi82qGcwEr6IYrRWDcv+JXTP6KNrD1apUVaGp9h2xzSTCfOAakUfMuMRWR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fS60TJTsBqLU37eBvxf0bZM8utYY6sFs60K11KiKVkpIi+/Y5KImM0UPfBwSVgB9O+VaoDv2BJB/NQF6Sj09xOJkEG8aDQDk88OgqAOaGQ4s6oKFFkqGsKJNLG5QvYZtO+Xd/BYMMtY33Fupprm4N/5TZMkCa1uz89SR7hsEM0A=
Received: by 10.140.249.20 with SMTP id w20mr1515507rvh.66.1199999244639;
        Thu, 10 Jan 2008 13:07:24 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 13:07:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70089>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 index-pack.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 9fd6982..3c4ea51 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "compress.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
@@ -494,24 +495,9 @@ static void parse_pack_objects(unsigned char *sha1)

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
+	size = z_deflate_all(zlib_compression_level, in, size, &out);
 	write_or_die(fd, out, size);
 	*obj_crc = crc32(*obj_crc, out, size);
 	free(out);
-- 
1.5.4.rc2.89.g1b3f

From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 2/5] Use new decompress helpers in diff.c
Date: Thu, 10 Jan 2008 22:06:16 +0100
Message-ID: <e5bfff550801101306i4e62e339tb9e86414c3e7894e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4bw-00078a-Jo
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbYAJVGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYAJVGU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:06:20 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:13534 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbYAJVGT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:06:19 -0500
Received: by nz-out-0506.google.com with SMTP id s18so492667nze.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CF2hFhxjhn9ZsODWQ57BsWGdczoc199Vcdy16MWKr2o=;
        b=APYB1GWOwg0AZV1vbrKMZE/P2BCAR2HaSKnQfuJmjV/Hreky+fEYSkWGnzyKMCbymD3NBgCEaBtX3jelbzlORNqc+R8xw2DbHTMZ92mgfWWZbAoy0SAlJbbGxnChwJRPgRpaSFJLfhdO8QJhhFmcz8xSxRNX8eKARBNh23pzO4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=igppPA7xyGM89jIrfq0eHJEdA2u9OqodROfPBSpGf1K6NHRSP3soBScAZpzREjCnQvEnUwIxwlnbuC/lRB+HGv8bbNOS/IhGjEXBzbPkKIt3mTO0asJkWCziKg4iwWLFFpUbKASHAVEXga+5RBuJJEbG0R5krrbJjCwQuZbZaJ0=
Received: by 10.141.205.10 with SMTP id h10mr1508690rvq.138.1199999176458;
        Thu, 10 Jan 2008 13:06:16 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 13:06:16 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70088>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 diff.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index b18c140..ecfa721 100644
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
+	*result_size = z_deflate_all(zlib_compression_level,
+                                    (unsigned char *)data, size, &deflated);
 	return deflated;
 }

-- 
1.5.4.rc2.89.g1b3f

From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 4/5] Use new compress helpers in http-push.c
Date: Fri, 11 Jan 2008 08:39:45 +0100
Message-ID: <e5bfff550801102339o757eea62h40b5e00cd904f7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:40:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDEV6-0007uI-4f
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbYAKHjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYAKHjr
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:39:47 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:41789 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbYAKHjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:39:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so851607rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 23:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=E13WP1/egm1gIUKFgRa64B6IjLNHVI35w6bcE4vMxRU=;
        b=nwjD9VRwWiByKmy0GgIVwJWB4NqIPZqYT9zwTJ2dBHc4oQgJdJXbuK4dFg6MtCYN6vUXKRkkTi2ShpaLePrRgezmLFxy3hXQSbBl2nNKkG12q3fWE5PvHLC+0hFMu4cMdGbVpqZ0q7glndmGJpCzrf//h1tkXK/4y8AZERo+Fa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lIIMlNql090pKroXB07crlH+3auEugnxFQvru7fqKAlGPq0gGnSXIVWQmwADhx/8eUvZtAC2iQbpOVPriAKW4ZQ0A/kFYn6NiIFTzKYoHn5fI+2X+6HB7wHt8FbTf5NsQenNKbKhm+E1fRo58ZCj9HEWL/ZuHXwcQ6LWql2igSM=
Received: by 10.141.71.8 with SMTP id y8mr1807910rvk.32.1200037185198;
        Thu, 10 Jan 2008 23:39:45 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 23:39:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70133>

A multistep compress is required here, so
we need the full arsenal of compress helpers.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 http-push.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/http-push.c b/http-push.c
index 55d0c94..b7fe57f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "compress.h"
 #include "pack.h"
 #include "tag.h"
 #include "blob.h"
@@ -491,31 +492,24 @@ static void start_put(struct transfer_request
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;

 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
-	size = deflateBound(&stream, len + hdrlen);
+	size = compress_alloc(&stream, zlib_compression_level, len + hdrlen);
 	strbuf_init(&request->buffer.buf, size);
 	request->buffer.posn = 0;

 	/* Compress it */
-	stream.next_out = (unsigned char *)request->buffer.buf.buf;
-	stream.avail_out = size;
+	compress_start(&stream, (void *)hdr, hdrlen,
+                      (unsigned char *)request->buffer.buf.buf, size);

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

-	request->buffer.buf.len = stream.total_out;
+	request->buffer.buf.len = compress_free(&stream);
+	free(unpacked);

 	request->url = xmalloc(strlen(remote->url) +
 			       strlen(request->lock->token) + 51);
-- 
1.5.4.rc2.89.g1b3f-dirty

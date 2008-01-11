From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 3/5] Use new compress helpers in fast-import
Date: Fri, 11 Jan 2008 08:38:21 +0100
Message-ID: <e5bfff550801102338s6542be72r78029ecfc382559e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDETb-0007UV-BQ
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbYAKHiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbYAKHiX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:38:23 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:39173 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYAKHiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:38:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so851253rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 23:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=JGVka8e8I/3r04vZmU5sYBcm/8JcHJZ3EVpk/8ryoxU=;
        b=MmYl/oAbZHNwgG//ntF2H+Qb28SdWJt2ptQjtitimBykdA2xLhYsVlwNu9Vu9kasqtcSEQQQ/13PARdTMuNEDaMOHlsMRfRFeePFAhFrAjph7qp7jxNC/TuS/MimTN3omOyYqEuMM9LToBZSjckOZLbZ9qY5OmR3Of91BR950J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g9v8PrMgYYv4js1AMQDGfMlHco3tK3rh3mzIdCW9jsjL1T8tvfMNfHA+RZIEG6Dbs1RtLRT3lbuQDowJOX3dt0g9Ye1zcIT2XX0wbVRoFdvQp3gfL5LfGF8fkphwoss+LelTIgCpbFgfC/CDD6kOH0BDjysF4zMRnFo4cTOQo7o=
Received: by 10.141.185.3 with SMTP id m3mr1785716rvp.236.1200037101368;
        Thu, 10 Jan 2008 23:38:21 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 23:38:21 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70132>

Here is slightly more difficult, in particular
a xrealloc() has been substituted with a
free() + xmalloc() to keep the code simple.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 fast-import.c |   44 +++++++++++++++------------------------
 1 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 74597c9..6166d4a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -141,6 +141,7 @@ Format of STDIN stream:

 #include "builtin.h"
 #include "cache.h"
+#include "compress.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
@@ -994,13 +995,13 @@ static int store_object(
 	unsigned char *sha1out,
 	uintmax_t mark)
 {
-	void *out, *delta;
+	unsigned char *out, *delta;
 	struct object_entry *e;
 	unsigned char hdr[96];
 	unsigned char sha1[20];
 	unsigned long hdrlen, deltalen;
 	SHA_CTX c;
-	z_stream s;
+	int out_size;

 	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
@@ -1036,24 +1037,15 @@ static int store_object(
 	} else
 		delta = NULL;

-	memset(&s, 0, sizeof(s));
-	deflateInit(&s, zlib_compression_level);
-	if (delta) {
-		s.next_in = delta;
-		s.avail_in = deltalen;
-	} else {
-		s.next_in = (void *)dat->buf;
-		s.avail_in = dat->len;
-	}
-	s.avail_out = deflateBound(&s, s.avail_in);
-	s.next_out = out = xmalloc(s.avail_out);
-	while (deflate(&s, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&s);
+	if (delta)
+		out_size = compress_all(zlib_compression_level, delta, deltalen, &out);
+	else
+		out_size = compress_all(zlib_compression_level,
+                                       (unsigned char *)dat->buf,
dat->len, &out);

 	/* Determine if we should auto-checkpoint. */
-	if ((pack_size + 60 + s.total_out) > max_packsize
-		|| (pack_size + 60 + s.total_out) < pack_size) {
+	if ((pack_size + 60 + out_size) > max_packsize
+		|| (pack_size + 60 + out_size) < pack_size) {

 		/* This new object needs to *not* have the current pack_id. */
 		e->pack_id = pack_id + 1;
@@ -1064,15 +1056,9 @@ static int store_object(
 			free(delta);
 			delta = NULL;

-			memset(&s, 0, sizeof(s));
-			deflateInit(&s, zlib_compression_level);
-			s.next_in = (void *)dat->buf;
-			s.avail_in = dat->len;
-			s.avail_out = deflateBound(&s, s.avail_in);
-			s.next_out = out = xrealloc(out, s.avail_out);
-			while (deflate(&s, Z_FINISH) == Z_OK)
-				/* nothing */;
-			deflateEnd(&s);
+			free(out);
+			out_size = compress_all(zlib_compression_level,
+                                               (unsigned char
*)dat->buf, dat->len, &out);
 		}
 	}

@@ -1105,8 +1091,8 @@ static int store_object(
 		pack_size += hdrlen;
 	}

-	write_or_die(pack_data->pack_fd, out, s.total_out);
-	pack_size += s.total_out;
+	write_or_die(pack_data->pack_fd, out, out_size);
+	pack_size += out_size;

 	free(out);
 	free(delta);
-- 
1.5.4.rc2.89.g1b3f-dirty

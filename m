From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 03/11] Use new compress helpers in fast-import
Date: Sat,  2 Feb 2008 12:35:48 +0100
Message-ID: <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:37:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGga-0000Gr-W3
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbYBBLg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756316AbYBBLg4
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:36:56 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbYBBLgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:46 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZTlumvllv1kh0eV2uVJyPzxlnYcnXYY3POgeV3LuGvo=;
        b=edrvSbk5elr+FVHiT1bdznRmFCGjksUJymWkn6kTmfDVJw8tz0lhQvmQRrgrtUjYYp4JXK+3DjJs+D+owu3rZpFx5f7WrAqxbmTnvhTZMi8PKoQBFK3U3JbEtNEkBQdRgOx+KlegEKb5p1C5dWeyTka7CtDcBIVEWHOyg1Odg3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gHQv/Mq3UWVh0ML9l+dRt/MtG/QLelH52bjm1UgLmeIwQBytk4UhteWzpNsVCJifcsUX18oo3S48i50PMnUssLhXCwrqM6gwMCisAeih3PUZXLOcNCatPa1Th5I1GGwKJt9TTNA5FJgfpUHpN/TZk5NpztuAZ57fMh+LsdbOr2s=
Received: by 10.86.98.18 with SMTP id v18mr4261813fgb.43.1201952205800;
        Sat, 02 Feb 2008 03:36:45 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.43
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:45 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72264>

Here is slightly more difficult, in particular
a xrealloc() has been substituted with a
free() + xmalloc() to keep the code simple.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 fast-import.c |   45 +++++++++++++++------------------------------
 1 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a523b17..b6bb84c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -141,6 +141,7 @@ Format of STDIN stream:
 
 #include "builtin.h"
 #include "cache.h"
+#include "compress.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
@@ -997,13 +998,13 @@ static int store_object(
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
@@ -1039,24 +1040,15 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	memset(&s, 0, sizeof(s));
-	deflateInit(&s, pack_compression_level);
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
+		out_size = compress_all(pack_compression_level, delta, deltalen, &out);
+	else
+		out_size = compress_all(pack_compression_level,
+                                       (unsigned char *)dat->buf, dat->len, &out);
 
 	/* Determine if we should auto-checkpoint. */
-	if ((pack_size + 60 + s.total_out) > max_packsize
-		|| (pack_size + 60 + s.total_out) < pack_size) {
+	if ((pack_size + 60 + out_size) > max_packsize
+		|| (pack_size + 60 + out_size) < pack_size) {
 
 		/* This new object needs to *not* have the current pack_id. */
 		e->pack_id = pack_id + 1;
@@ -1066,16 +1058,9 @@ static int store_object(
 		if (delta) {
 			free(delta);
 			delta = NULL;
-
-			memset(&s, 0, sizeof(s));
-			deflateInit(&s, pack_compression_level);
-			s.next_in = (void *)dat->buf;
-			s.avail_in = dat->len;
-			s.avail_out = deflateBound(&s, s.avail_in);
-			s.next_out = out = xrealloc(out, s.avail_out);
-			while (deflate(&s, Z_FINISH) == Z_OK)
-				/* nothing */;
-			deflateEnd(&s);
+			free(out);
+			out_size = compress_all(pack_compression_level,
+                                               (unsigned char *)dat->buf, dat->len, &out);
 		}
 	}
 
@@ -1108,8 +1093,8 @@ static int store_object(
 		pack_size += hdrlen;
 	}
 
-	write_or_die(pack_data->pack_fd, out, s.total_out);
-	pack_size += s.total_out;
+	write_or_die(pack_data->pack_fd, out, out_size);
+	pack_size += out_size;
 
 	free(out);
 	free(delta);
-- 
1.5.4.rc4.39.g524a

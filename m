From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 04/11] Use new compress helpers in http-push.c
Date: Sat,  2 Feb 2008 12:35:49 +0100
Message-ID: <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGgb-0000Gr-Kb
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbYBBLg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbYBBLg7
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:36:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386AbYBBLgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:48 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SdmlZ4lujrzL28+vuDH8ffTRolLvTFIzG10yEKaksJU=;
        b=DT4Pd66QVl7QiLyWyNh0wjqaOUR1qv/hRpwtmUqoyh5Ccy60eLMVpwwNr1u8HJpZeCv3uo4LfxSffo9qiwXlAvuAtXKdDIva9496GRUg20qSpFduadAKSimiUeBSCWUCt3vQrU9svdTP3Jh3BccKPPVxm4qAUhUN/xmGgkYtILI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=haaAmUruamsvBVW4hQwZCB8Skt4jScfemv1CABBgxzqBxOgs0UDoEGjtAj7TgGZHu9dzcKysIVmMPb/g2kZPGznUlA80hGTgSbCqZXajSMvdAydvLnD92W1VsQsBCQZCmMcLTdhbTz/l2PkhVdYaK6ZFxnnIIhAou5pPa/DYaqg=
Received: by 10.86.91.12 with SMTP id o12mr4243497fgb.72.1201952207906;
        Sat, 02 Feb 2008 03:36:47 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.45
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:47 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72265>

A multistep compress is required here, so
we need the full arsenal of compress helpers.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 http-push.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/http-push.c b/http-push.c
index b2b410d..a7997ec 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "compress.h"
 #include "pack.h"
 #include "tag.h"
 #include "blob.h"
@@ -491,31 +492,24 @@ static void start_put(struct transfer_request *request)
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
1.5.4.rc4.39.g524a

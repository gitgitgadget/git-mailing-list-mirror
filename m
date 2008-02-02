From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 09/11] Convert http-push.c and http-walker.c
Date: Sat,  2 Feb 2008 12:35:54 +0100
Message-ID: <1201952156-6764-9-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-6-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-7-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-8-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGhl-0000Z5-Tw
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbYBBLhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756690AbYBBLhO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:37:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339AbYBBLg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:59 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f/RHk480VYp3QANKlqqgGREy1E7fs+MIAK/yU0n7Y58=;
        b=aFGPnlWs2qxgMIKBbInepyM9qv1WuFEFGSL/vJAy8HQO0Ky3e+zB7BR3ach1wgdRMk+F8rgE4cPB6t7yU6jN6FE6m09YYvzkQb+b/JH4RU8NiKkuMrSmu+DQ6RSg/x4Rt35l4XZMd8F0RaFiJLIvlaLXDL9iHFGQiLXWChXFNEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ej7Tpw0309If0toyOX0LBy9R9X7F0mDwLvAvfEfP3+fp3vn0IvilPDyS+zaV3jrgHbEC2dKMTXiDV3fUs1Y92LXBbSqJYvkKj2qNEu5mge+z35LMULE6712BndOuitSN9I1HoziqkukwgQsYmuDWCIzJanZ32iP6Z181aozLpA4=
Received: by 10.86.62.3 with SMTP id k3mr4245303fga.71.1201952218328;
        Sat, 02 Feb 2008 03:36:58 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.56
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:57 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-8-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72269>

Conversion for both files is very similar
and in both cases I have added a FIXME where
I would have added an additional decompress_free()

The corresponding deflateEnd() call is not present in
the original code, so I left the line commented out.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 http-push.c   |   21 +++++++++------------
 http-walker.c |   22 +++++++++-------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/http-push.c b/http-push.c
index a7997ec..0920640 100644
--- a/http-push.c
+++ b/http-push.c
@@ -203,12 +203,11 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		posn += retval;
 	} while (posn < size);
 
-	request->stream.avail_in = size;
-	request->stream.next_in = ptr;
+	decompress_from(&request->stream, ptr, size);
+
 	do {
-		request->stream.next_out = expn;
-		request->stream.avail_out = sizeof(expn);
-		request->zret = inflate(&request->stream, Z_SYNC_FLUSH);
+		request->zret = decompress_next_into(&request->stream, expn,
+		                                     sizeof(expn), Z_SYNC_FLUSH);
 		SHA1_Update(&request->c, expn,
 			    sizeof(expn) - request->stream.avail_out);
 	} while (request->stream.avail_in && request->zret == Z_OK);
@@ -266,9 +265,7 @@ static void start_fetch_loose(struct transfer_request *request)
 		return;
 	}
 
-	memset(&request->stream, 0, sizeof(request->stream));
-
-	inflateInit(&request->stream);
+	decompress_alloc(&request->stream);
 
 	SHA1_Init(&request->c);
 
@@ -305,11 +302,11 @@ static void start_fetch_loose(struct transfer_request *request)
 	}
 	unlink(prevfile);
 
-	/* Reset inflate/SHA1 if there was an error reading the previous temp
+	/* Reset decompress/SHA1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
-		memset(&request->stream, 0, sizeof(request->stream));
-		inflateInit(&request->stream);
+		// FIXME should we need decompress_free() here?
+		decompress_alloc(&request->stream);
 		SHA1_Init(&request->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
@@ -735,7 +732,7 @@ static void finish_request(struct transfer_request *request)
 			if (request->http_code == 416)
 				fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
 
-			inflateEnd(&request->stream);
+			decompress_free(&request->stream);
 			SHA1_Final(request->real_sha1, &request->c);
 			if (request->zret != Z_STREAM_END) {
 				unlink(request->tmpfile);
diff --git a/http-walker.c b/http-walker.c
index 2c37868..b1d2a28 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "compress.h"
 #include "pack.h"
 #include "walker.h"
 #include "http.h"
@@ -77,12 +78,10 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		posn += retval;
 	} while (posn < size);
 
-	obj_req->stream.avail_in = size;
-	obj_req->stream.next_in = ptr;
+	decompress_from(&obj_req->stream, ptr, size);
 	do {
-		obj_req->stream.next_out = expn;
-		obj_req->stream.avail_out = sizeof(expn);
-		obj_req->zret = inflate(&obj_req->stream, Z_SYNC_FLUSH);
+		obj_req->zret = decompress_next_into(&obj_req->stream, expn,
+                                             sizeof(expn), Z_SYNC_FLUSH);
 		SHA1_Update(&obj_req->c, expn,
 			    sizeof(expn) - obj_req->stream.avail_out);
 	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
@@ -140,10 +139,7 @@ static void start_object_request(struct walker *walker,
 		return;
 	}
 
-	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-
-	inflateInit(&obj_req->stream);
-
+	decompress_alloc(&obj_req->stream);
 	SHA1_Init(&obj_req->c);
 
 	url = xmalloc(strlen(obj_req->repo->base) + 51);
@@ -179,11 +175,11 @@ static void start_object_request(struct walker *walker,
 	}
 	unlink(prevfile);
 
-	/* Reset inflate/SHA1 if there was an error reading the previous temp
+	/* Reset decompress/SHA1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
-		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-		inflateInit(&obj_req->stream);
+		// FIXME should we need decompress_free() here?
+		decompress_alloc(&obj_req->stream);
 		SHA1_Init(&obj_req->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
@@ -243,7 +239,7 @@ static void finish_object_request(struct object_request *obj_req)
 		return;
 	}
 
-	inflateEnd(&obj_req->stream);
+	decompress_free(&obj_req->stream);
 	SHA1_Final(obj_req->real_sha1, &obj_req->c);
 	if (obj_req->zret != Z_STREAM_END) {
 		unlink(obj_req->tmpfile);
-- 
1.5.4.rc4.39.g524a

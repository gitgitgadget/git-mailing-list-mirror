From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 4/6] Convert http-push.c and http-walker.c
Date: Fri, 11 Jan 2008 19:57:32 +0100
Message-ID: <e5bfff550801111057m449a19eaxec2d2f1ee748e687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP4s-0002pS-GD
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761291AbYAKS5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761201AbYAKS5e
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:57:34 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:36038 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761244AbYAKS5d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:57:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1021460rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 10:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=szJu5E53hUhus8tmV/bM2MwHmltaNf2b5XWAlXctcqU=;
        b=EpGKfzI3y5urC+eZ4Cv23hf5zC9EjVb4T3xBdR8/MbGXMQuEB2fsNbxtXG2s3vHRznRIqf2Z2ZWMohYexcvG4jYiWcrBbjAkN6BkD60IE/WBCd0WMwIhld42NeIasPvQqPPdx4BoGI1vGnY1fJgsPlcudSYKkgFzj8ude2VCcXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k6u2aHCBN0Sw7HqDOtY34avE0KWxMoR6HWxVQxsykbJk3USFnh2Pf9gdLBV7bcxTtbv5sx1cmCZAxYyErMBteXAfmfW6Era8ZSif2/pm3Yu6KiW6lJ2NqROVU9qedGao/N+H2mYMyyOPNLVKDTQ0RAQ0wg8ZzmSGnMKDvEu1pGs=
Received: by 10.141.136.19 with SMTP id o19mr2204721rvn.250.1200077852898;
        Fri, 11 Jan 2008 10:57:32 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 10:57:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70188>

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
index b7fe57f..ec0568c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -203,12 +203,11 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize,
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
@@ -266,9 +265,7 @@ static void start_fetch_loose(struct transfer_request
 		return;
 	}

-	memset(&request->stream, 0, sizeof(request->stream));
-
-	inflateInit(&request->stream);
+	decompress_alloc(&request->stream);

 	SHA1_Init(&request->c);

@@ -305,11 +302,11 @@ static void start_fetch_loose(struct transfer_request
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
 				fprintf(stderr, "Warning: requested range invalid; we may already
have all the data.\n");

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
@@ -77,12 +78,10 @@ static size_t fwrite_sha1_file(void *ptr, size_t
eltsize, size_t
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
@@ -243,7 +239,7 @@ static void finish_object_request(struct object_request
 		return;
 	}

-	inflateEnd(&obj_req->stream);
+	decompress_free(&obj_req->stream);
 	SHA1_Final(obj_req->real_sha1, &obj_req->c);
 	if (obj_req->zret != Z_STREAM_END) {
 		unlink(obj_req->tmpfile);
-- 
1.5.4.rc2.90.gf158-dirty

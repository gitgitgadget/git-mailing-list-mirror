Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4D61F45F
	for <e@80x24.org>; Tue,  7 May 2019 23:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGXD7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 19:03:59 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45348 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGXD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 19:03:58 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1hO97q-0007Sd-B4; Wed, 08 May 2019 08:03:54 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2] Make fread/fwrite-like functions in http.c more like fread/fwrite.
Date:   Wed,  8 May 2019 08:03:54 +0900
Message-Id: <20190507230354.28638-1-mh@glandium.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507214658.GC19955@sigill.intra.peff.net>
References: <20190507214658.GC19955@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fread/fwrite-like functions in http.c, namely fread_buffer,
fwrite_buffer, fwrite_null, fwrite_sha1_file all return the
multiplication of the size and number of items they are being given.

Practically speaking, it doesn't matter, because in all contexts where
those functions are used, size is 1.

But those functions being similar to fread and fwrite (the curl API is
designed around being able to use fread and fwrite directly), it might
be preferable to make them behave like fread and fwrite, which, from
the fread/fwrite manual page, is:
   On  success, fread() and fwrite() return the number of items read
   or written.  This number equals the number of bytes transferred
   only when size is 1.  If an error occurs, or the end of the file
   is reached, the return value is a short item count (or zero).

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 98fb06df0b..27aa0a3192 100644
--- a/http.c
+++ b/http.c
@@ -176,7 +176,7 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	memcpy(ptr, buffer->buf.buf + buffer->posn, size);
 	buffer->posn += size;
 
-	return size;
+	return size / eltsize;
 }
 
 #ifndef NO_CURL_IOCTL
@@ -204,12 +204,12 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	struct strbuf *buffer = buffer_;
 
 	strbuf_add(buffer, ptr, size);
-	return size;
+	return nmemb;
 }
 
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 {
-	return eltsize * nmemb;
+	return nmemb;
 }
 
 static void closedown_active_slot(struct active_request_slot *slot)
@@ -2319,14 +2319,14 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 			BUG("curl_easy_getinfo for HTTP code failed: %s",
 				curl_easy_strerror(c));
 		if (slot->http_code >= 300)
-			return size;
+			return nmemb;
 	}
 
 	do {
 		ssize_t retval = xwrite(freq->localfile,
 					(char *) ptr + posn, size - posn);
 		if (retval < 0)
-			return posn;
+			return posn / eltsize;
 		posn += retval;
 	} while (posn < size);
 
@@ -2339,7 +2339,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		the_hash_algo->update_fn(&freq->c, expn,
 					 sizeof(expn) - freq->stream.avail_out);
 	} while (freq->stream.avail_in && freq->zret == Z_OK);
-	return size;
+	return nmemb;
 }
 
 struct http_object_request *new_http_object_request(const char *base_url,
-- 
2.21.0


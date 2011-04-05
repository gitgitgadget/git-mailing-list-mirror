From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] http: make curl callbacks match contracts from curl header
Date: Mon,  4 Apr 2011 20:06:19 -0500
Message-ID: <1301965579-5299-1-git-send-email-dpmcgee@gmail.com>
References: <7v8vvp7fr0.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 03:06:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6uj4-00063W-BW
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 03:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab1DEBG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 21:06:29 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45523 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab1DEBG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 21:06:27 -0400
Received: by yxs7 with SMTP id 7so2398638yxs.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Gn9LKvZtAEK+58WOIhbsks5T1OOBeliftLDZKc97tXY=;
        b=lCyO0wioQKrvn+fuXZR+aH7wEDTWt8ZHNMOjSO83GLMUXnZz9Diqgs6wSzaIWN0yST
         PWb2XjpefaM6C7sMxC2gcbVG+7mxlY7SMYvcUgELKX4JGtxIcJl/1KMgqemQJ6yBfoRC
         CsTWBGlul0HITwoie1SNW2vVLg/S9l+aC+glE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZnQvcFBOX/dbBjAXdAjI1qYwWnBiZZA0NjbkCmpnIT3JBM+kp5f0RndOwjHCPttuMf
         OACjaRY/f4EV84ZEQdvC8oqHibJRgERRZ4K7Cayqq3WcIKT7C7Qm1aZg6xDjYQBD9qwk
         w1CuL8bn83mLeYMAWi8cQKqN8/Kz3waduu6y0=
Received: by 10.236.154.5 with SMTP id g5mr3304333yhk.86.1301965587216;
        Mon, 04 Apr 2011 18:06:27 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id p59sm2603288yhm.46.2011.04.04.18.06.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 18:06:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <7v8vvp7fr0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170852>

Yes, these don't match perfectly with the void* first parameter of the
fread/fwrite in the standard library, but they do match the curl
expected method signature. This is needed when a refactor passes a
curl_write_callback around, which would otherwise give incorrect
parameter warnings.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Cast the const-ness away in process_alternates_response with the call to
fwrite_buffer() as suggested by Junio, which shows the correct intent rather
than making the variable non-const to begin with. The static modifier was still
dropped.

 http-walker.c |    4 ++--
 http.c        |   12 ++++++------
 http.h        |    6 +++---
 remote-curl.c |    2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 9bc8114..51a906e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -185,7 +185,7 @@ static void process_alternates_response(void *callback_data)
 	struct active_request_slot *slot = alt_req->slot;
 	struct alt_base *tail = cdata->alt;
 	const char *base = alt_req->base;
-	static const char null_byte = '\0';
+	const char null_byte = '\0';
 	char *data;
 	int i = 0;
 
@@ -218,7 +218,7 @@ static void process_alternates_response(void *callback_data)
 		}
 	}
 
-	fwrite_buffer(&null_byte, 1, 1, alt_req->buffer);
+	fwrite_buffer((char *)&null_byte, 1, 1, alt_req->buffer);
 	alt_req->buffer->len--;
 	data = alt_req->buffer->buf;
 
diff --git a/http.c b/http.c
index 9e76772..f44816b 100644
--- a/http.c
+++ b/http.c
@@ -60,7 +60,7 @@ static struct curl_slist *no_pragma_header;
 
 static struct active_request_slot *active_queue_head;
 
-size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
+size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
 	struct buffer *buffer = buffer_;
@@ -92,7 +92,7 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 }
 #endif
 
-size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
+size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
 	struct strbuf *buffer = buffer_;
@@ -102,7 +102,7 @@ size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, void *buffer
 	return size;
 }
 
-size_t fwrite_null(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf)
+size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 {
 	data_received++;
 	return eltsize * nmemb;
@@ -1166,7 +1166,7 @@ abort:
 }
 
 /* Helpers for fetching objects (loose) */
-static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
 {
 	unsigned char expn[4096];
@@ -1183,7 +1183,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	} while (posn < size);
 
 	freq->stream.avail_in = size;
-	freq->stream.next_in = ptr;
+	freq->stream.next_in = (void *)ptr;
 	do {
 		freq->stream.next_out = expn;
 		freq->stream.avail_out = sizeof(expn);
@@ -1202,7 +1202,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	char *filename;
 	char prevfile[PATH_MAX];
 	int prevlocal;
-	unsigned char prev_buf[PREV_BUF_SIZE];
+	char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
diff --git a/http.h b/http.h
index e9ed3c2..19b7134 100644
--- a/http.h
+++ b/http.h
@@ -66,9 +66,9 @@ struct buffer {
 };
 
 /* Curl request read/write callbacks */
-extern size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-extern size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-extern size_t fwrite_null(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+extern size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+extern size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+extern size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 #ifndef NO_CURL_IOCTL
 extern curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
 #endif
diff --git a/remote-curl.c b/remote-curl.c
index 775d614..17d8a9b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -347,7 +347,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 }
 #endif
 
-static size_t rpc_in(const void *ptr, size_t eltsize,
+static size_t rpc_in(char *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
-- 
1.7.4.2

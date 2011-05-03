From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 2/4] http: make curl callbacks match contracts from curl header
Date: Tue,  3 May 2011 23:47:27 +0800
Message-ID: <1304437649-7052-3-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304437649-7052-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 17:48:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHHpR-0003ZP-AN
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 17:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab1ECPry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 11:47:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61216 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab1ECPrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 11:47:52 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so105338pwi.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=mGzJbN1UKxQEu6qulWcAn5UYSTHEXpDKJPlXhoD72dU=;
        b=QIg7YIzAa00DGFXN8/UexFdmb9ugZe78L6vo24uOx3adMsdALvdS6jbI1TQMxMgTLR
         dO9JUJcNoyrma1bYhgmuXTnW2A6q1FoQQ+kb5A5dHHNnniWDDl7ZLqE9erXTOBRxL00F
         b0XdHR7IJ9/6ldUtTVXUlheHXjcXmbQgiZa50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yr8RsJSD2DSgmmc2mznhgoJiE3zKmBVwLODZAIPRpjKnYuKQcC/2I8ASRp+jcQcSf1
         9hj96Tp3Haz+zG9YTVAGOfwsJsrtUdVt+Mhyq3gBGS/GmKA1SEDvfTVXOebfS7mBA+Xa
         afhxVRg4FGxFZ5n+sWD8GTpS6oDXOUbS9LGZk=
Received: by 10.68.40.165 with SMTP id y5mr6534263pbk.338.1304437672318;
        Tue, 03 May 2011 08:47:52 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id p7sm117856pbp.1.2011.05.03.08.47.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 08:47:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304437649-7052-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172666>

From: Dan McGee <dpmcgee@gmail.com>

Yes, these don't match perfectly with the void* first parameter of the
fread/fwrite in the standard library, but they do match the curl
expected method signature. This is needed when a refactor passes a
curl_write_callback around, which would otherwise give incorrect
parameter warnings.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
Unchanged.

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
index b27bb57..b2ae8de 100644
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
@@ -1167,7 +1167,7 @@ abort:
 }
 
 /* Helpers for fetching objects (loose) */
-static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
 {
 	unsigned char expn[4096];
@@ -1184,7 +1184,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	} while (posn < size);
 
 	freq->stream.avail_in = size;
-	freq->stream.next_in = ptr;
+	freq->stream.next_in = (void *)ptr;
 	do {
 		freq->stream.next_out = expn;
 		freq->stream.avail_out = sizeof(expn);
@@ -1203,7 +1203,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
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
1.7.3.3.585.g74f6e

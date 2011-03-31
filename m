From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] http: make curl callbacks match contracts from curl header
Date: Wed, 30 Mar 2011 20:38:50 -0500
Message-ID: <1301535531-1244-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:39:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56ql-0003dg-MG
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933816Ab1CaBiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52625 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822Ab1CaBiy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:54 -0400
Received: by iyb14 with SMTP id 14so1845829iyb.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=vA3lPV41wyg2HEpsmyTVSFQkmWdKZC3qvhhEBtf4IB0=;
        b=NBVUmAN6l/oNNEM0WUQf8PagtPRgukC08j5UV/+Va6qK0c+siMJMmx6vs45YUopSHW
         YuybTo8A/Ll5yDP8uCeN/MvQBD5X/4x19UXYbYNgpiFnPim66WQzwLPe8tFtvK2WmHOO
         7rWnwqeG6zHtHy4TS8pZSRGHJEEgEgzaAuRaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hkcpAC5XvrzUfZwf4AhIkM/gY2sUq5LLxJ7Y+gqIyOn+SgG26amS6sDZgB5aUEa1T3
         dv7jYcxuuPx1EaAgXhomQ/78bAlON5W/BNzLiUnEIGMKOm8Bf8BAAFN48YYYd0w9G97G
         k01CyV91HsslO7Zl1lzcC8oe65TKMnF9nfBPs=
Received: by 10.43.61.79 with SMTP id wv15mr2127235icb.229.1301535534254;
        Wed, 30 Mar 2011 18:38:54 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id i26sm384523iby.7.2011.03.30.18.38.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170447>

Yes, these don't match perfectly with the void* first parameter of the
fread/fwrite in the standard library, but they do match the curl
expected method signature. This is needed when a refactor passes a
curl_write_callback around, which would otherwise give incorrect
parameter warnings.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 http-walker.c |    2 +-
 http.c        |   12 ++++++------
 http.h        |    6 +++---
 remote-curl.c |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 9bc8114..c83df1b 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -185,7 +185,7 @@ static void process_alternates_response(void *callback_data)
 	struct active_request_slot *slot = alt_req->slot;
 	struct alt_base *tail = cdata->alt;
 	const char *base = alt_req->base;
-	static const char null_byte = '\0';
+	char null_byte = '\0';
 	char *data;
 	int i = 0;
 
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

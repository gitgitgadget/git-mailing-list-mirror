From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 2/4] http: make curl callbacks match contracts from curl header
Date: Wed,  4 May 2011 18:11:34 +0800
Message-ID: <1304503896-5988-3-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 12:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHZ3m-0002px-K6
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 12:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab1EDKLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 06:11:49 -0400
Received: from mail-px0-f170.google.com ([209.85.212.170]:56238 "EHLO
	mail-px0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1EDKLr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 06:11:47 -0400
Received: by mail-px0-f170.google.com with SMTP id 19so734544pxi.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=amlLYGQIyZm1zHsp/lWtwwVseOndC+0HqvGnS4Tt09A=;
        b=EQ7woopdp4WD9W8ctoE3L4SQhVjfvpnrrXgONp26o8WXQx+ECRYNcxn5/+y/VXSEp7
         0Fl7w2QM8s8Wt8Lel08OVt2uRsgdCwhQMGH8r68dR1K9ucYmuqdJNstzPIM+uq8H5BXp
         bBBZRbi6ZPeNj6z3plHpf3OPSoBHpdqQTDcwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JhaahQ9r2Bvpn1LipboeZ4oCk2o3JVTGVXN48TxOqnKs2SzfI4w2OmgprjS5ivNZL5
         RHXzyjBLebMWD2xLZaC84s0P1QxoKM7ak3ieHX+TZ37phDzxZucA5aI9GnaP6Yv+qONa
         vUC1EeU1Cs+vDl2g+WKOKIuWn29+Gt0aIiY7Y=
Received: by 10.68.47.5 with SMTP id z5mr1256876pbm.450.1304503907529;
        Wed, 04 May 2011 03:11:47 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id y5sm643190pbq.57.2011.05.04.03.11.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 03:11:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304503896-5988-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172734>

From: Dan McGee <dpmcgee@gmail.com>

Yes, these don't match perfectly with the void* first parameter of the
fread/fwrite in the standard library, but they do match the curl
expected method signature. This is needed when a refactor passes a
curl_write_callback around, which would otherwise give incorrect
parameter warnings.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
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

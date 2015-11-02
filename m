From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4] http.c: use CURLOPT_RANGE for range requests
Date: Mon,  2 Nov 2015 16:39:58 -0500
Message-ID: <1446500398-12257-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Mon Nov 02 22:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtMpq-0005qx-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 22:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbbKBVkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 16:40:10 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34740 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbKBVkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 16:40:08 -0500
Received: by qkcn129 with SMTP id n129so64181377qkc.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 13:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=l3EJme6le/UIc5Z9tEzIuMNyK3M0UP7J1MY0Na4DJQo=;
        b=EU5hnE/d8xv+IaF1ssjrPN9MZ+DQoU4JrWePd9RtvQ5olIGjbwJWIM5bxzZTD53xB5
         5WwkdDelfANRBQS77hF0LGGZ6nRJxRa0QqTALCp8bYcoMRvVIdObU0M5As2IvBvigb+P
         CY2N/QvwEuo+uiDRatlLRN9iBABSvSOPtpXiY1y8RLHhcwstxmnVbyiBf8XQeRurWras
         z7GytW8NQyuBaVntxH8N9hJtLO7uE3EC3xaygcqDs+jGGuAndaen7y8omS08b+nW/on7
         wpygSVGcxUrmTFIUeEZRVXIIqfc26UC0Ssuik36hdqh1qukqVMVSEeWNDhrB0PdMNU+c
         divw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l3EJme6le/UIc5Z9tEzIuMNyK3M0UP7J1MY0Na4DJQo=;
        b=YC+lvJHYje3viz+FM43SxUlsgqM2t9XvEvto23eHklx0l+FDAS7nqHXq+mpqjoH8BA
         lD0vQWHzZSq93t0sPSiSon7X5STdE7ICGU6JBbFSXeKKThmIdD05kX1U1HzG50z9p/BH
         Ld8vhMu8POmWtvQCmiWkHhrHWxBZrhImbZ/8gzyH4t+3+D6eTO6cZekk+4gRNgI5YYxe
         zS2Fsx1rxEXq1BKzD/t2WJ5mAm1E8idDbcqmLL5AywIsGTO2aJLU1NG7ziL55GqHCIMp
         8tW+p35PLui9rFDL5Q2HA8V08mtIjzx+jxf85lvxmrqU8ewolgFpLLnGEIE9oQVTL7Qh
         Dkew==
X-Gm-Message-State: ALoCoQmZtBUv0xjFuupan5xgH4yf+HsXcIFSTsUy9o2TwBBP5ZVz4lAqfTEl1SX9hUvf5TxlDoxJ
X-Received: by 10.55.221.9 with SMTP id n9mr31844205qki.102.1446500407990;
        Mon, 02 Nov 2015 13:40:07 -0800 (PST)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id j94sm8621072qge.27.2015.11.02.13.40.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Nov 2015 13:40:06 -0800 (PST)
X-Mailer: git-send-email 2.4.2.691.g714732c-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280724>

A HTTP server is permitted to return a non-range response to a HTTP
range request (and Apache httpd in fact does this in some cases).
While libcurl knows how to correctly handle this (by skipping bytes
before and after the requested range), it only turns on this handling
if it is aware that a range request is being made.  By manually
setting the range header instead of using CURLOPT_RANGE, we were
hiding the fact that this was a range request from libcurl.  This
could cause corruption.

Signed-off-by: David Turner <dturner@twopensource.com>
---

This one incorporates Jeff's suggestions about off_t.  It also
simplifies by removing the possiblity of a missing low-end of a range;
the entire point of this function is to add a range HEADER and a
range of - is nugatory.

---
 http.c | 33 ++++++++++++---------------------
 http.h |  1 -
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/http.c b/http.c
index 6b89dea..f9a0dc5 100644
--- a/http.c
+++ b/http.c
@@ -30,7 +30,6 @@ static CURL *curl_default;
 #endif
 
 #define PREV_BUF_SIZE 4096
-#define RANGE_HEADER_SIZE 30
 
 char curl_errorstr[CURL_ERROR_SIZE];
 
@@ -692,6 +691,7 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
 #endif
@@ -1184,6 +1184,13 @@ static const char *get_accept_language(void)
 	return cached_accept_language;
 }
 
+static void http_opt_request_remainder(CURL *curl, off_t pos)
+{
+	char buf[128];
+	xsnprintf(buf, sizeof(buf), "%"PRIuMAX"-", (uintmax_t)pos);
+	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -1212,11 +1219,8 @@ static int http_request(const char *url,
 			long posn = ftell(result);
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite);
-			if (posn > 0) {
-				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
-				headers = curl_slist_append(headers, buf.buf);
-				strbuf_reset(&buf);
-			}
+			if (posn > 0)
+				http_opt_request_remainder(slot->curl, posn);
 		} else
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite_buffer);
@@ -1526,10 +1530,6 @@ void release_http_pack_request(struct http_pack_request *preq)
 		fclose(preq->packfile);
 		preq->packfile = NULL;
 	}
-	if (preq->range_header != NULL) {
-		curl_slist_free_all(preq->range_header);
-		preq->range_header = NULL;
-	}
 	preq->slot = NULL;
 	free(preq->url);
 	free(preq);
@@ -1593,7 +1593,6 @@ struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url)
 {
 	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
 	struct strbuf buf = STRBUF_INIT;
 	struct http_pack_request *preq;
 
@@ -1631,10 +1630,7 @@ struct http_pack_request *new_http_pack_request(
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %ld\n",
 				sha1_to_hex(target->sha1), prev_posn);
-		xsnprintf(range, sizeof(range), "Range: bytes=%ld-", prev_posn);
-		preq->range_header = curl_slist_append(NULL, range);
-		curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
-			preq->range_header);
+		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
 
 	return preq;
@@ -1684,8 +1680,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
 	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
 	struct http_object_request *freq;
 
 	freq = xcalloc(1, sizeof(*freq));
@@ -1791,10 +1785,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 			fprintf(stderr,
 				"Resuming fetch of object %s at byte %ld\n",
 				hex, prev_posn);
-		xsnprintf(range, sizeof(range), "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(freq->slot->curl,
-				 CURLOPT_HTTPHEADER, range_header);
+		http_opt_request_remainder(freq->slot->curl, prev_posn);
 	}
 
 	return freq;
diff --git a/http.h b/http.h
index 49afe39..4f97b60 100644
--- a/http.h
+++ b/http.h
@@ -190,7 +190,6 @@ struct http_pack_request {
 	struct packed_git **lst;
 	FILE *packfile;
 	char tmpfile[PATH_MAX];
-	struct curl_slist *range_header;
 	struct active_request_slot *slot;
 };
 
-- 
2.4.2.691.g714732c-twtrsrc

From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3] http.c: use CURLOPT_RANGE for range requests
Date: Mon,  2 Nov 2015 14:36:26 -0500
Message-ID: <1446492986-32350-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Mon Nov 02 20:36:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtKuN-00028N-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 20:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbbKBTgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 14:36:43 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36523 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbKBTgm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 14:36:42 -0500
Received: by qgad10 with SMTP id d10so124772784qga.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=eQmoJDdYSzcwbUziGfgmT3BMvQCJZXmTMT9vcpx2z8Y=;
        b=1kIp2hhL+fB23xk95Tv4YQn80vdxp8gwUSs1BQ1O7qxmVuDq9GL93ks3MEvy0sRm21
         vq/tUxfOK2cO+O5NlIoxvbAsf67Kmam4SRDwBc5Z1tU9MMeBUbP0esAcl2neLdm/FyZ3
         dYRBxNIENda7Dh3Rt5GA7Hw2S/ahTLIIPX6SqZ9h/lzYpYVS7sxIJanleOv070Cx3PDy
         1nwEfme+mmFtCm+9Y4KMX6sQIp724iLrX7hfiQosXzDFheaHgVVCrqQq16pu2ofwmVvF
         dNhDwB0QX7/ggc/hOfwwPaGsMfEu4xXcupEcDKhkTGzt8N9R+BAbbCyzk6tk+Soz/OGn
         gUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eQmoJDdYSzcwbUziGfgmT3BMvQCJZXmTMT9vcpx2z8Y=;
        b=ZCchAQXRNbma74CjeApqQggb9/giDW4YiClU+hlgwSZMSNBPvvU2NYzm3lFCbPJY40
         7/sldieRp9uFVsngNenBhJlAQGvk1MISt3AHm65stE+SXRzaWXnWnPfHQ5e+/QUkqMiO
         5DnvyfnM8smuuMLx4QOoUdPdkSL2OJHUeNxC+1MI9MM1suW2XCoyTpESqyDhZ+ezWeS3
         c2Dk+FXf19iV0+gpuQboV4u//phRUdWARbM8LlVjJLmxfm54YRxXSAf6xm7dw2/frL7i
         uqiDZjVI4oRyPcsoCVaTid12oL9bnukrL6UJvdH9icDW5vGKhpnBpYNMwpNUh/GGRaeM
         Hg/A==
X-Gm-Message-State: ALoCoQk0+8ZIqHfcLrpi2Uoj75oKc2RcqagTH1ueqqse06r270T+lJjYqmEYk6S8Ep42y14x061S
X-Received: by 10.140.93.1 with SMTP id c1mr31219646qge.59.1446493001277;
        Mon, 02 Nov 2015 11:36:41 -0800 (PST)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w50sm8431538qge.45.2015.11.02.11.36.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Nov 2015 11:36:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.691.g714732c-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280712>

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

This version breaks the range option formatting/setting out to a
helper function, as suggested by Junio and Jeff.

In addition, it clears the range option when curl slots are cleared
before reuse, also as suggested

---
 http.c | 39 ++++++++++++++++++---------------------
 http.h |  1 -
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/http.c b/http.c
index 6b89dea..eea5836 100644
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
@@ -1184,6 +1184,19 @@ static const char *get_accept_language(void)
 	return cached_accept_language;
 }
 
+static void http_opt_request_remainder(CURL *curl, ssize_t lo)
+{
+	char buf[128];
+	int len = 0;
+
+	if (lo >= 0)
+		len += xsnprintf(buf + len, 128 - len, "%"PRIiMAX,
+				 (intmax_t)lo);
+	len += xsnprintf(buf + len, 128 - len, "-");
+
+	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -1212,11 +1225,8 @@ static int http_request(const char *url,
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
@@ -1526,10 +1536,6 @@ void release_http_pack_request(struct http_pack_request *preq)
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
@@ -1593,7 +1599,6 @@ struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url)
 {
 	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
 	struct strbuf buf = STRBUF_INIT;
 	struct http_pack_request *preq;
 
@@ -1631,10 +1636,7 @@ struct http_pack_request *new_http_pack_request(
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
@@ -1684,8 +1686,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
 	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
 	struct http_object_request *freq;
 
 	freq = xcalloc(1, sizeof(*freq));
@@ -1791,10 +1791,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
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

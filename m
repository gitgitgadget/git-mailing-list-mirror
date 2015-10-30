From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Fri, 30 Oct 2015 18:54:42 -0400
Message-ID: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 23:55:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsIZp-0005L9-SO
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759974AbbJ3WzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:55:12 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34962 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbbJ3WzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:55:10 -0400
Received: by qgbb65 with SMTP id b65so73716295qgb.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Ti2fapL+3+56uwasvvX8He9dbxRfLCXy1EszX3yv7YY=;
        b=mb+o/Oh0NntJS39FrMYpmGPnXr+2mwb8J+K1V7ufF+S546ZCwc60Yc1hHp2UoRmZWJ
         yuyYULhfi3LtRUwrUUuhoHhczNUe8VYutEBtal2gvbuC0DYeBNLD9TIQZEyryPyVhMs+
         AezzLMEVwP7mAURaVorL34Y2K2KZA06tNm/Q0ZZA1yj9jdMzL/EGZZQ7rZWCuq9V+BLP
         fqZI6X9gK4Co8M/gYGosSi4HcrocZbmrBqzGmL4jVz1ujgqwU3Fiywmnk/SKjUInagTK
         dHAcP7TcviCyHsERjAz5Fh4ID0KL6IWJbFEPDkHaAt7ZQWGjM/bo7piNWty5dHFjFLu8
         BALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ti2fapL+3+56uwasvvX8He9dbxRfLCXy1EszX3yv7YY=;
        b=kjR83rqZO/0TNXHovETSpAmoRxx+nbZQW57kJjJQkXwTMA9ZK9FGKtTlS1yUiWimVf
         grjhG+juAxBselsKkPGsl134NuIqVVbUxEAM3DK8VIQWTXwYtoDbSbnolvVLk7Pxlbgv
         ToR32co0X5WOVe7IuogjMU2fI3zARAcGzVa0vfdLF/LmnZD7ypsgeVLzpWGDM8/cqHm1
         cV0YaU4A9tO+AljE2AvwyLKBYPMPx3I8CpSBGM7auNVaXuSgYQwuNqRL4ZOnpW7IediM
         O1KakOiWP2UAS/D2pe6kNnyenGe7IRrT7lj0S3idl+gvrMtJ6BdGEDqNhZzHcXHtbkYZ
         gjIA==
X-Gm-Message-State: ALoCoQnhFJMwAmvt4ztvEWO2P8aL43KubSZPj5gZJGtYaA2WP9K7+Toc7nA/RSLIIysy16LCxNoH
X-Received: by 10.140.152.68 with SMTP id 65mr13912078qhy.16.1446245709942;
        Fri, 30 Oct 2015 15:55:09 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e80sm3391200qka.38.2015.10.30.15.55.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 15:55:09 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.691.g714732c-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280559>

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

This version applies on top of pu.  It also catches all of the range
requests instead of just the one that I happened to notice.

---
 http.c | 24 ++++++++----------------
 http.h |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/http.c b/http.c
index 6b89dea..16610b9 100644
--- a/http.c
+++ b/http.c
@@ -30,7 +30,7 @@ static CURL *curl_default;
 #endif
 
 #define PREV_BUF_SIZE 4096
-#define RANGE_HEADER_SIZE 30
+#define RANGE_HEADER_SIZE 17
 
 char curl_errorstr[CURL_ERROR_SIZE];
 
@@ -1213,8 +1213,9 @@ static int http_request(const char *url,
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite);
 			if (posn > 0) {
-				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
-				headers = curl_slist_append(headers, buf.buf);
+				strbuf_addf(&buf, "%ld-", posn);
+				curl_easy_setopt(slot->curl, CURLOPT_RANGE,
+						 &buf.buf);
 				strbuf_reset(&buf);
 			}
 		} else
@@ -1526,10 +1527,6 @@ void release_http_pack_request(struct http_pack_request *preq)
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
@@ -1631,10 +1628,8 @@ struct http_pack_request *new_http_pack_request(
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %ld\n",
 				sha1_to_hex(target->sha1), prev_posn);
-		xsnprintf(range, sizeof(range), "Range: bytes=%ld-", prev_posn);
-		preq->range_header = curl_slist_append(NULL, range);
-		curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
-			preq->range_header);
+		xsnprintf(range, sizeof(range), "%ld-", prev_posn);
+		curl_easy_setopt(preq->slot->curl, CURLOPT_RANGE, range);
 	}
 
 	return preq;
@@ -1685,7 +1680,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	ssize_t prev_read = 0;
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
 	struct http_object_request *freq;
 
 	freq = xcalloc(1, sizeof(*freq));
@@ -1791,10 +1785,8 @@ struct http_object_request *new_http_object_request(const char *base_url,
 			fprintf(stderr,
 				"Resuming fetch of object %s at byte %ld\n",
 				hex, prev_posn);
-		xsnprintf(range, sizeof(range), "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(freq->slot->curl,
-				 CURLOPT_HTTPHEADER, range_header);
+		xsnprintf(range, sizeof(range), "%ld-", prev_posn);
+		curl_easy_setopt(freq->slot->curl, CURLOPT_RANGE, range);
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

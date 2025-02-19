Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951381F3BBC
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975441; cv=none; b=P6MzowLnmzrhpS4mdwMaPRu3ertHPI1FmijOdn1C1weIDzzlJbdiS2eP0kFa95Xo5f5fKYv8Vt6kxIECxCM6oDd5Uh8zvYZ3STg+mXVl7QqHOAVq+8HJV0jaoSEfqMU7nRzTmitfOfzNbXnE0qUFsDenk32kmkj8bxFe/IYsxTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975441; c=relaxed/simple;
	bh=5ukjsvcucFdC0q9d9SUNvqg7U1G51qKwM1DUZ2RpfzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kS2SJNdTtv/k2qOUqorF/9tpRSaCTbk/jmp6US8VkztuhlUTrXPlwBsS2dCNUxQhqP8frZe8gZhA7OXUMLue0XkMWrvqUddkrmqfu8Beh7WDzDmgynYyvzIu+5okNdZAd/B33adr9MQ4CHc5WL24OvXijCdO2MEkwjzIm9KjiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=le1fDC9E; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="le1fDC9E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vesGT84jNYl9mSAJzGDDCOzw9+qfAUK8+az7ekNtVYo=;
	b=le1fDC9E4H91a0/vIU6vm3Lc3HJ//ZQEfXIAPt/zbQLTE0cAi3dvTj4wfDPW/saoeBp3fN
	W/RW0Iyiu7XzHewViUafrSKx13MFvk8DjAeINuOEdmB4rXRDKRBItBYTXg1GOKJEaP+70a
	DZKCRaY1OpyYmlRrJMMCifhD2xPxFxc=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 19 Feb 2025 15:30:22 +0100
Subject: [PATCH v2 4/7] http: add the ability to log progress
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-toon-bundleuri-progress-v2-4-a84e7ffa921a@iotcl.com>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
In-Reply-To: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Add an option `progress` to `struct http_get_options` to allow the
caller to enable download progress using the progress.c API.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 http.c | 34 ++++++++++++++++++++++++++++++++++
 http.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/http.c b/http.c
index 38c7c0cd54..5517863808 100644
--- a/http.c
+++ b/http.c
@@ -13,6 +13,7 @@
 #include "credential.h"
 #include "version.h"
 #include "pkt-line.h"
+#include "progress.h"
 #include "gettext.h"
 #include "trace.h"
 #include "transport.h"
@@ -1504,6 +1505,9 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 1L);
+	curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, NULL);
 
 	/*
 	 * Default following to off unless "ALWAYS" is configured; this gives
@@ -2068,6 +2072,21 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
+static int http_progress_callback(void *clientp, curl_off_t dltotal,
+				  curl_off_t dlnow, curl_off_t ultotal UNUSED,
+				  curl_off_t ulnow UNUSED)
+{
+	struct progress *progress = clientp;
+
+	if (progress) {
+		progress_set_total(progress, dltotal);
+		display_progress(progress, dlnow);
+		display_throughput(progress, dlnow);
+	}
+
+	return 0;
+}
+
 static int http_request(const char *url,
 			void *result, int target,
 			const struct http_get_options *options)
@@ -2076,6 +2095,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = http_copy_default_headers();
 	struct strbuf buf = STRBUF_INIT;
+	struct progress *progress = NULL;
 	const char *accept_language;
 	int ret;
 
@@ -2112,6 +2132,13 @@ static int http_request(const char *url,
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+	if (options && options->progress) {
+		progress = start_progress(the_repository, _("Downloading via HTTP"), 0);
+
+		curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 0L);
+		curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, progress);
+		curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, &http_progress_callback);
+	}
 
 	headers = curl_slist_append(headers, buf.buf);
 
@@ -2134,6 +2161,13 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
+	if (progress) {
+		curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 1L);
+		curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
+		curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, NULL);
+		stop_progress(&progress);
+	}
+
 	if (options && options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
diff --git a/http.h b/http.h
index 36202139f4..09ebbdfefe 100644
--- a/http.h
+++ b/http.h
@@ -146,6 +146,11 @@ struct http_get_options {
 	 * request has completed.
 	 */
 	struct string_list *extra_headers;
+
+	/*
+	 * If not zero, display the progress.
+	 */
+	int progress;
 };
 
 /* Return values for http_get_*() */

-- 
2.48.1.658.g4767266eb4


Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4866996F
	for <git@vger.kernel.org>; Wed,  8 May 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172314; cv=none; b=afKnQlfxbneoTH/xQ7ui+SP17Iq5qhUQ9L2rlypqsH+1bMYsCliRGZSVD0B1p8bf8N4/AE3IwcD5m0C0fRZuGXREVN/45GwsZqQYBOrxVp3T7IRnfQLwr2T+Sg67MowZ1YEZ6JyM1FVUNNNEjXZbh9pU4MlRE37ORqi/l3zos8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172314; c=relaxed/simple;
	bh=6rckbd8w7oe3qWSzPy1spgEU/AGb0TpnNHkmcWmUmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5ibq/9WBpfocKrwaxh/0uIYOACnvNBS7YiWJaixhklxH+VMHa84GCQoezweNHQ8kJ2d1zuXte+UMld3I1jfiBLt+t48ecIj9QW2mI/t7fMCOf9FRVqGJWwLu//8l0Z/VW0tYsGR8MhWzHnFA/G+XLmLxnPfex6o+MSIGk5776w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=aZPrqnOE; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="aZPrqnOE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1715172310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRGVpwzTzrk9MbblF+MpKQqTCybqgPP2fi48nQ3hhVk=;
	b=aZPrqnOEusiB07bHAcncBmEV8v/vxBBxo2fwBOTifytGRWtWx/bOidOYkp0u50matK0hF+
	P8vqWvcjfPoVsr8RsKKp/EV96aIgPcSEtBbAYitDC9Bdu/AaSFrtfLz4R5pBT23PKOHmaj
	picRCk+Ml8yrJieMK2YFJAOdg9PG6fc=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 2/4] http: add the ability to log progress
Date: Wed,  8 May 2024 14:44:51 +0200
Message-ID: <20240508124453.600871-3-toon@iotcl.com>
In-Reply-To: <20240508124453.600871-1-toon@iotcl.com>
References: <20240508124453.600871-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add an option `progress` to `struct http_get_options` to allow the
caller to enable download progress using the progress.c API.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 http.c | 32 ++++++++++++++++++++++++++++++++
 http.h |  5 +++++
 2 files changed, 37 insertions(+)

diff --git a/http.c b/http.c
index 3d80bd6116..15c5d53712 100644
--- a/http.c
+++ b/http.c
@@ -10,6 +10,7 @@
 #include "credential.h"
 #include "version.h"
 #include "pkt-line.h"
+#include "progress.h"
 #include "gettext.h"
 #include "trace.h"
 #include "transport.h"
@@ -1457,6 +1458,9 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 1L);
+	curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, NULL);
 
 	/*
 	 * Default following to off unless "ALWAYS" is configured; this gives
@@ -2017,6 +2021,21 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
+static int http_progress_callback(void *clientp, curl_off_t dltotal,
+				  curl_off_t dlnow, curl_off_t ultotal,
+				  curl_off_t ulnow)
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
@@ -2025,6 +2044,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = http_copy_default_headers();
 	struct strbuf buf = STRBUF_INIT;
+	struct progress *progress = NULL;
 	const char *accept_language;
 	int ret;
 
@@ -2061,6 +2081,13 @@ static int http_request(const char *url,
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+	if (options && options->progress) {
+		progress = start_progress(_("Downloading via HTTP"), 0);
+
+		curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 0L);
+		curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, progress);
+		curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, &http_progress_callback);
+	}
 
 	headers = curl_slist_append(headers, buf.buf);
 
@@ -2079,6 +2106,11 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
+	if (progress) {
+		curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
+		stop_progress(&progress);
+	}
+
 	if (options && options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
diff --git a/http.h b/http.h
index 3af19a8bf5..37ecddec17 100644
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
2.44.0.651.g21306a098c


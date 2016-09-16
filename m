Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2062070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757392AbcIPAMr (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:47 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34831 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757058AbcIPAMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:31 -0400
Received: by mail-qk0-f194.google.com with SMTP id w204so4450443qka.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=p2feG4VWbKDi6st1npJbLMkZfpMhXTWoRvuki5YIsTY=;
        b=ATxlOGhZdZOSyU5bZOwPRvSF83Iblae3f5Zfyb6XrwhoKyhdXo9z3hhA+rUCzy+cRc
         juukkEci3R6uKa29rIJvo6RcRXOZYEEkvBJvnMZe4dtPujo1C4vdI8D8dbQrDDY8Mnrc
         mlxR1ytSidbhkll0Krup/PqYOWKtPmxLYkW/dFZ12595qShH1rTzpSLtfZu7xEC9RHJc
         STdHUCUHaKp2he6MYApS5c2L1QwT3ToGHMl5zzbQdDkXC6HeCrbIFpZhkSjklJ4IBtRQ
         B8NGHoyIY7nBI4faHaKuPEmoDIb/LJTqBpzZlKoqOokgpXUxQHnt7ERYZ4RErBmf7R9A
         47cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=p2feG4VWbKDi6st1npJbLMkZfpMhXTWoRvuki5YIsTY=;
        b=QwHDcYiwzmabTnhoZ26CTkbMrubBzLCdvd6zsw0gFanUyeX2MMktovQTvd3B0hWnwF
         Zc/ZLeLbCVdV8JCXT27CN7AjTUW6jgmkDzAzGRyuSVl7X2ossCWVHDgV+B+oGGjsDLvL
         /qwN+ciISfWa9dJGuqyqUJREPxFq979JkBHtV6vS0HsG701YWyfcQ1fX4RnIu7xa1COQ
         rrfkz5FCIq6pb1uxq/eW/gXZTx3XRSTu8Ghd9B0MGHPRAJqPS3gWnvGd0v8pAUM3bltp
         +ugyGLEuzhPXCG9MOeFk9byE3Fc9NJAwVYw3yGrcJIc3fo0dT+v8Yrof3uMC2gtdIuLY
         jMNg==
X-Gm-Message-State: AE9vXwPKhKMF7rTHQmhszejNoO3+MLGmg8YKO/W9rXlLVKpam1P3hdG2pfrAaKixXH0fag==
X-Received: by 10.55.97.130 with SMTP id v124mr13038292qkb.51.1473984749773;
        Thu, 15 Sep 2016 17:12:29 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:29 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 07/11] Resumable clone: add resumable download to http/curl
Date:   Thu, 15 Sep 2016 20:12:18 -0400
Message-Id: <1473984742-12516-8-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create resumable download procedure and progress display function.
The conversion from B to KB occurs because otherwise the byte counts
for large repos (i.e. Linux) overflow calculating percentage.

The download protocol includes the resource's URL, and the directory
the resource will be downloaded to. The url passed to remote-curl on
invocation does not matter (git clone will use the resource url
again here).

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 http.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h        |  7 ++++-
 remote-curl.c | 27 +++++++++++++++++++
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 1d5e3bb..93d6324 100644
--- a/http.c
+++ b/http.c
@@ -10,6 +10,8 @@
 #include "pkt-line.h"
 #include "gettext.h"
 #include "transport.h"
+#include "progress.h"
+#include "dir.h"
 
 #if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
@@ -1136,7 +1138,10 @@ static int handle_curl_result(struct slot_results *results)
 				curl_easy_strerror(results->curl_result),
 				sizeof(curl_errorstr));
 #endif
-		return HTTP_ERROR;
+		if (results->http_code >= 400)
+			return HTTP_ERROR;
+		else
+			return HTTP_ERROR_RESUMABLE;
 	}
 }
 
@@ -1365,6 +1370,40 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
+static int bytes_to_rounded_kb(double bytes)
+{
+	return (int) (bytes + 512)/1024;
+}
+
+int progress_func(void *data, double total_to_download, double now_downloaded,
+		  double total_to_upload, double now_uploadeded)
+{
+	struct progress **progress = data;
+	int kilobytes = total_to_download >= 1024;
+
+	if (total_to_download <= 0.0) {
+		return 0;
+	}
+	if (kilobytes) {
+		now_downloaded = bytes_to_rounded_kb(now_downloaded);
+		total_to_download = bytes_to_rounded_kb(total_to_download);
+	}
+	if (!*progress && now_downloaded < total_to_download) {
+		if (total_to_download > 1024)
+			*progress = start_progress("Downloading (KB)",
+						   total_to_download);
+		else
+			*progress = start_progress("Downloading (B)",
+						   total_to_download);
+	}
+	display_progress(*progress, now_downloaded);
+	if (now_downloaded == total_to_download) {
+		stop_progress(progress);
+	}
+	return 0;
+}
+
+
 static int http_request(const char *url,
 			void *result, int target,
 			const struct http_get_options *options)
@@ -1373,6 +1412,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	struct progress *progress = NULL;
 	const char *accept_language;
 	int ret;
 
@@ -1389,6 +1429,16 @@ static int http_request(const char *url,
 			off_t posn = ftello(result);
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite);
+			if (options && options->progress) {
+				curl_easy_setopt(slot->curl,
+						 CURLOPT_NOPROGRESS, 0);
+				curl_easy_setopt(slot->curl,
+						 CURLOPT_PROGRESSFUNCTION,
+						 progress_func);
+				curl_easy_setopt(slot->curl,
+						 CURLOPT_PROGRESSDATA,
+						 &progress);
+			}
 			if (posn > 0)
 				http_opt_request_remainder(slot->curl, posn);
 		} else
@@ -1559,6 +1609,40 @@ cleanup:
 	return ret;
 }
 
+int http_download_primer(const char *url, const char *out_file)
+{
+	int ret = 0, try_count = HTTP_TRY_COUNT;
+	struct http_get_options options = {0};
+	options.progress = 1;
+
+	if (file_exists(out_file)) {
+		fprintf(stderr,
+			"File already downloaded: '%s', skipping...\n",
+			out_file);
+		return ret;
+	}
+
+	do {
+		if (try_count != HTTP_TRY_COUNT) {
+			fprintf(stderr, "Connection interrupted for some "
+				"reason, retrying (%d attempts left)\n",
+				try_count);
+			struct timeval time = {10, 0}; // 1s
+			select(0, NULL, NULL, NULL, &time);
+		}
+		ret = http_get_file(url, out_file, &options);
+		try_count--;
+	} while (try_count > 0 && ret == HTTP_ERROR_RESUMABLE);
+
+	if (ret != HTTP_OK) {
+		error("Unable to get resource: %s", url);
+		ret = -1;
+	}
+
+	return ret;
+}
+
+
 int http_fetch_ref(const char *base, struct ref *ref)
 {
 	struct http_get_options options = {0};
diff --git a/http.h b/http.h
index 4ef4bbd..6a7ce7b 100644
--- a/http.h
+++ b/http.h
@@ -138,7 +138,8 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 /* Options for http_get_*() */
 struct http_get_options {
 	unsigned no_cache:1,
-		 keep_error:1;
+		 keep_error:1,
+		 progress:1;
 
 	/* If non-NULL, returns the content-type of the response. */
 	struct strbuf *content_type;
@@ -172,6 +173,7 @@ struct http_get_options {
 #define HTTP_START_FAILED	3
 #define HTTP_REAUTH	4
 #define HTTP_NOAUTH	5
+#define HTTP_ERROR_RESUMABLE	6
 
 /*
  * Requests a URL and stores the result in a strbuf.
@@ -180,6 +182,9 @@ struct http_get_options {
  */
 int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_options *options);
 
+#define HTTP_TRY_COUNT 5
+int http_download_primer(const char *url, const char *out_file);
+
 extern int http_fetch_ref(const char *base, struct ref *ref);
 
 /* Helpers for fetching packs */
diff --git a/remote-curl.c b/remote-curl.c
index 8ebb587..051ba52 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -394,6 +394,30 @@ static void prime_clone(void)
 	free(result_full);
 }
 
+static void download_primer(const char *url, const char *base_dir)
+{
+	char *slash_ptr = strchr(url, '/'), *out_file;
+	struct strbuf out_path = STRBUF_INIT;
+	do {
+		out_file = slash_ptr + 1;
+	} while (slash_ptr = strchr(out_file, '/'));
+	strbuf_addf(&out_path, "%s/%s", base_dir, out_file);
+	if (!http_download_primer(url, out_path.buf))
+		printf("%s\n", out_path.buf);
+	printf("\n");
+	fflush(stdout);
+}
+
+static void parse_download_primer(struct strbuf *buf)
+{
+	const char *remote_url;
+	if (skip_prefix(buf->buf, "download-primer ", &remote_url)) {
+		char *base_path;
+		base_path = strchr(remote_url, ' ');
+		*base_path++ = '\0';
+		download_primer(remote_url, base_path);
+	}
+}
 
 static struct discovery *discover_refs(const char *service, int for_push)
 {
@@ -1105,6 +1129,8 @@ int main(int argc, const char **argv)
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
 			int for_push = !!strstr(buf.buf + 4, "for-push");
 			output_refs(get_refs(for_push));
+		} else if (starts_with(buf.buf, "download-primer")) {
+			parse_download_primer(&buf);
 		} else if (!strcmp(buf.buf, "prime-clone")) {
 			prime_clone();
 		} else if (starts_with(buf.buf, "push ")) {
@@ -1132,6 +1158,7 @@ int main(int argc, const char **argv)
 			printf("fetch\n");
 			printf("option\n");
 			printf("push\n");
+			printf("download-primer\n");
 			printf("prime-clone\n");
 			printf("check-connectivity\n");
 			printf("\n");
-- 
2.7.4


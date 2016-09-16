Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B75F207E6
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757350AbcIPAMh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:37 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34381 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756272AbcIPAM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:28 -0400
Received: by mail-qk0-f196.google.com with SMTP id b204so4477841qkc.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=cTolSlk82YDtkVno9jx6dzcFOphZrUIPQpZDSOOJfyw=;
        b=V1JrUVW2mSaqU6Mme1P0IAfvozdrYKbKtIN2wokR/tP3aiYiK5ajz9G4PQ3wkEtEXC
         bxK4cpe8xzL8S3oq+u3/tqDEMpMKxjsNPKTBzKy1o3D7LRmk2NERL8O1IFvuIRQSQouj
         HWIE6F2dNKbcl0L5MsIqQNb/O9S9rZu5Xt8HOXqW7GTYvxHP0iDFK4K6U0LlATNThU/D
         BNPGV3h555rb4bIkhWmwdmZPw3jxVbH2CoYFdXkh8hyGFo67OYVMHJk07Gi6P0MZVxti
         ko+4LgBwbEFUwZvg8cJ99OgYm18VUJFSy3L/Boy83KP4RTF4l75umZ4twvTpMoedNfik
         3rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=cTolSlk82YDtkVno9jx6dzcFOphZrUIPQpZDSOOJfyw=;
        b=PTioXdCwGSVCxUzguKAzpN/NrSK8IL/65wRaugRyDETo4I+4sn7sdOTTg1YTFkidVM
         5gMkTi1ovGD1TJX+udQtGoxDpz1SacOABDwTT6Cj16B9O/K6TxbzXILGvIgViDXY6YAa
         xPKcMxzIg3ZojXExXxmXT5VCutdsHnOnWP+ZISFnyADpkEevANGxTTSs+ZuLbWARAwsh
         j4xMPtQw3318bHWea3nAk7zripd3Z9GAOrOVgtEwV1MQxkdshgkqv4rymJzITuz33MFh
         CzkRm6FvbgEKTkw9xK+u56SwXHXOr/R9jaQWtInowsjuGTYvyyvC2TBOJLom45aUYeKr
         UOBA==
X-Gm-Message-State: AE9vXwPcyx3Gw8rSj1kble4lQ4DYUThipDUgXwbk0IukVIzgyEErNzcCclRZOZoi2wsheg==
X-Received: by 10.233.220.7 with SMTP id q7mr13245170qkf.160.1473984747446;
        Thu, 15 Sep 2016 17:12:27 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:27 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 04/11] Resumable clone: add prime-clone to remote-curl
Date:   Thu, 15 Sep 2016 20:12:15 -0400
Message-Id: <1473984742-12516-5-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add function and interface to handle prime-clone input, extracting
and using duplicate functionality from discover_refs as function
request_service.

Because part of our goal is for prime_clone to recover from errors,
HTTP errors are only optionally printed to screen and never cause
death in this case.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 remote-curl.c | 165 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 121 insertions(+), 44 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 15e48e2..8ebb587 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -13,6 +13,8 @@
 #include "sha1-array.h"
 #include "send-pack.h"
 
+#define HTTP_ERROR_GENTLE (1u << 0)
+
 static struct remote *remote;
 /* always ends with a trailing slash */
 static struct strbuf url = STRBUF_INIT;
@@ -244,7 +246,31 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 	return 0;
 }
 
-static struct discovery *discover_refs(const char *service, int for_push)
+static char *http_handle_result(int http_return)
+{
+	struct strbuf error = STRBUF_INIT;
+
+	switch (http_return) {
+	case HTTP_OK:
+		return NULL;
+	case HTTP_MISSING_TARGET:
+		strbuf_addf(&error, "repository '%s' not found", url.buf);
+		break;
+	case HTTP_NOAUTH:
+		strbuf_addf(&error, "Authentication failed for '%s'",
+			    url.buf);
+		break;
+	default:
+		strbuf_addf(&error, "unable to access '%s': %s", url.buf,
+			    curl_errorstr);
+		break;
+	}
+
+	return strbuf_detach(&error, NULL);
+}
+
+static int request_service(char const *const service, char **buffer_full,
+			    char **buffer_msg, size_t *buffer_len, int flags)
 {
 	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
@@ -252,13 +278,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf refs_url = STRBUF_INIT;
 	struct strbuf effective_url = STRBUF_INIT;
-	struct discovery *last = last_discovery;
-	int http_ret, maybe_smart = 0;
-	struct http_get_options options;
-
-	if (last && !strcmp(service, last->service))
-		return last;
-	free_discovery(last);
+	int http_ret, maybe_smart = 0, ran_smart = 0;
+	struct http_get_options get_options;
+	const char *error_string;
 
 	strbuf_addf(&refs_url, "%sinfo/refs", url.buf);
 	if ((starts_with(url.buf, "http://") || starts_with(url.buf, "https://")) &&
@@ -271,45 +293,41 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
-	memset(&options, 0, sizeof(options));
-	options.content_type = &type;
-	options.charset = &charset;
-	options.effective_url = &effective_url;
-	options.base_url = &url;
-	options.no_cache = 1;
-	options.keep_error = 1;
-
-	http_ret = http_get_strbuf(refs_url.buf, &buffer, &options);
-	switch (http_ret) {
-	case HTTP_OK:
-		break;
-	case HTTP_MISSING_TARGET:
-		show_http_message(&type, &charset, &buffer);
-		die("repository '%s' not found", url.buf);
-	case HTTP_NOAUTH:
-		show_http_message(&type, &charset, &buffer);
-		die("Authentication failed for '%s'", url.buf);
-	default:
-		show_http_message(&type, &charset, &buffer);
-		die("unable to access '%s': %s", url.buf, curl_errorstr);
+	memset(&get_options, 0, sizeof(get_options));
+	get_options.content_type = &type;
+	get_options.charset = &charset;
+	get_options.effective_url = &effective_url;
+	get_options.base_url = &url;
+	get_options.no_cache = 1;
+	get_options.keep_error = 1;
+
+	http_ret = http_get_strbuf(refs_url.buf, &buffer, &get_options);
+	error_string = http_handle_result(http_ret);
+	if (error_string) {
+		if (!(flags & HTTP_ERROR_GENTLE)) {
+			show_http_message(&type, &charset, &buffer);
+			die("%s", error_string);
+		}
+		else if (options.verbosity > 1) {
+			show_http_message(&type, &charset, &buffer);
+			fprintf(stderr, "%s\n", error_string);
+		}
 	}
 
-	last= xcalloc(1, sizeof(*last_discovery));
-	last->service = service;
-	last->buf_alloc = strbuf_detach(&buffer, &last->len);
-	last->buf = last->buf_alloc;
+	*buffer_full = strbuf_detach(&buffer, buffer_len);
+	*buffer_msg = *buffer_full;
 
 	strbuf_addf(&exp, "application/x-%s-advertisement", service);
 	if (maybe_smart &&
-	    (5 <= last->len && last->buf[4] == '#') &&
-	    !strbuf_cmp(&exp, &type)) {
+	    (5 <= *buffer_len && (*buffer_msg)[4] == '#') &&
+	    !strbuf_cmp(&exp, &type) && http_ret == HTTP_OK) {
 		char *line;
 
 		/*
 		 * smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-		line = packet_read_line_buf(&last->buf, &last->len, NULL);
+		line = packet_read_line_buf(buffer_msg, buffer_len, NULL);
 
 		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=%s", service);
@@ -321,23 +339,80 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		 * until a packet flush marker.  Ignore these now, but
 		 * in the future we might start to scan them.
 		 */
-		while (packet_read_line_buf(&last->buf, &last->len, NULL))
+		while (packet_read_line_buf(buffer_msg, buffer_len, NULL))
 			;
 
-		last->proto_git = 1;
+		ran_smart = 1;
 	}
 
-	if (last->proto_git)
-		last->refs = parse_git_refs(last, for_push);
-	else
-		last->refs = parse_info_refs(last);
-
 	strbuf_release(&refs_url);
 	strbuf_release(&exp);
 	strbuf_release(&type);
 	strbuf_release(&charset);
 	strbuf_release(&effective_url);
 	strbuf_release(&buffer);
+
+	return ran_smart;
+}
+
+static void prime_clone(void)
+{
+	char *result, *result_full, *line;
+	size_t result_len;
+	int err = 0, one_successful = 0;
+
+	if (request_service("git-prime-clone", &result_full, &result,
+			&result_len, HTTP_ERROR_GENTLE)) {
+		while (line = packet_read_line_buf_gentle(&result, &result_len,
+							  NULL)) {
+			char *space = strchr(line ,' ');
+
+			// We will eventually support multiple resources, so
+			// always parse the whole message
+			if (err)
+				continue;
+			if (!space || strchr(space + 1, ' ')) {
+				if (options.verbosity > 1)
+					fprintf(stderr, "prime clone "
+						"protocol error: got '%s'\n",
+						line);
+				printf("error\n");
+				err = 1;
+				continue;
+			}
+
+			one_successful = 1;
+			printf("%s\n", line);
+		}
+		if (!one_successful && options.verbosity > 1)
+			fprintf(stderr, "did not get required components for "
+				"alternate resource\n");
+	}
+
+	printf("\n");
+	fflush(stdout);
+	free(result_full);
+}
+
+
+static struct discovery *discover_refs(const char *service, int for_push)
+{
+	struct discovery *last = last_discovery;
+
+	if (last && !strcmp(service, last->service))
+		return last;
+	free_discovery(last);
+
+	last= xcalloc(1, sizeof(*last_discovery));
+	last->service = service;
+	last->proto_git = request_service(service, &last->buf_alloc,
+					  &last->buf, &last->len, 0);
+
+	if (last->proto_git)
+		last->refs = parse_git_refs(last, for_push);
+	else
+		last->refs = parse_info_refs(last);
+
 	last_discovery = last;
 	return last;
 }
@@ -1030,7 +1105,8 @@ int main(int argc, const char **argv)
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
 			int for_push = !!strstr(buf.buf + 4, "for-push");
 			output_refs(get_refs(for_push));
-
+		} else if (!strcmp(buf.buf, "prime-clone")) {
+			prime_clone();
 		} else if (starts_with(buf.buf, "push ")) {
 			parse_push(&buf);
 
@@ -1056,6 +1132,7 @@ int main(int argc, const char **argv)
 			printf("fetch\n");
 			printf("option\n");
 			printf("push\n");
+			printf("prime-clone\n");
 			printf("check-connectivity\n");
 			printf("\n");
 			fflush(stdout);
-- 
2.7.4


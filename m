From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] remote-curl: fall back to Basic auth if Negotiate fails.
Date: Sat, 27 Dec 2014 04:01:33 +0000
Message-ID: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
References: <FBFEB910-4CB8-4049-901C-AADBFAB3AE9E@cisco.com>
Cc: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 05:02:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4iaS-0001Y6-A1
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 05:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbaL0EBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2014 23:01:42 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56036 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbaL0EBl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2014 23:01:41 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 04A9F2808F;
	Sat, 27 Dec 2014 04:01:40 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <FBFEB910-4CB8-4049-901C-AADBFAB3AE9E@cisco.com>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261834>

Apache servers using mod_auth_kerb can be configured to allow the user
to authenticate either using Negotiate (using the Kerberos ticket) or
Basic authentication (using the Kerberos password).  Often, one will
want to use Negotiate authentication if it is available, but fall back
to Basic authentication if the ticket is missing or expired.

Teach the HTTP client code to stop trying authentication mechanisms that
don't use a password (currently Negotiate) after the first failure,
since if they failed the first time, they will never succeed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I was able to reproduce the problem on my server.  This fixes the
problem for me both when info/refs requires authentication and when it
does not.  Dan, please try and see if this fixes the problem for you.

I'm not clear on whether NTLM is a passwordless authentication method.
Since I don't use Windows or NTLM, I can't test it, but if it is, just
adding it to HTTP_AUTH_PASSWORDLESS should be sufficient.

 http.c        | 14 ++++++++++++++
 http.h        |  5 ++++-
 remote-curl.c | 13 ++++++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 040f362..e3e4c65 100644
--- a/http.c
+++ b/http.c
@@ -986,6 +986,16 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		strbuf_addstr(charset, "ISO-8859-1");
 }
 
+void disable_passwordless_auth(struct active_request_slot *slot)
+{
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+#define HTTP_AUTH_PASSWORDLESS (CURLAUTH_GSSNEGOTIATE)
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH,
+			 CURLAUTH_ANY & ~HTTP_AUTH_PASSWORDLESS);
+#endif
+}
+
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -1035,6 +1045,9 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
+	if (options->no_passwordless_auth)
+		disable_passwordless_auth(slot);
+
 	ret = run_one_slot(slot, &results);
 
 	if (options && options->content_type) {
@@ -1139,6 +1152,7 @@ static int http_request_reauth(const char *url,
 	}
 
 	credential_fill(&http_auth);
+	options->no_passwordless_auth = 1;
 
 	return http_request(url, result, target, options);
 }
diff --git a/http.h b/http.h
index 473179b..fc42bf5 100644
--- a/http.h
+++ b/http.h
@@ -98,6 +98,8 @@ extern int handle_curl_result(struct slot_results *results);
 int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results);
 
+void disable_passwordless_auth(struct active_request_slot *slot);
+
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
 extern void add_fill_function(void *data, int (*fill)(void *));
@@ -138,7 +140,8 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 /* Options for http_get_*() */
 struct http_get_options {
 	unsigned no_cache:1,
-		 keep_error:1;
+		 keep_error:1,
+		 no_passwordless_auth:1;
 
 	/* If non-NULL, returns the content-type of the response. */
 	struct strbuf *content_type;
diff --git a/remote-curl.c b/remote-curl.c
index dd63bc2..89bf4ea 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -369,6 +369,8 @@ struct rpc_state {
 	struct strbuf result;
 	unsigned gzip_request : 1;
 	unsigned initial_buffer : 1;
+	/* Automatic authentication didn't work, so don't try it again. */
+	unsigned no_passwordless_auth : 1;
 };
 
 static size_t rpc_out(void *ptr, size_t eltsize,
@@ -467,6 +469,9 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
 
+	if (rpc->no_passwordless_auth)
+		disable_passwordless_auth(slot);
+
 	err = run_slot(slot, results);
 
 	curl_slist_free_all(headers);
@@ -510,8 +515,10 @@ static int post_rpc(struct rpc_state *rpc)
 
 		do {
 			err = probe_rpc(rpc, &results);
-			if (err == HTTP_REAUTH)
+			if (err == HTTP_REAUTH) {
 				credential_fill(&http_auth);
+				rpc->no_passwordless_auth = 1;
+			}
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
@@ -533,6 +540,9 @@ retry:
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
+	if (rpc->no_passwordless_auth)
+		disable_passwordless_auth(slot);
+
 	if (large_request) {
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
@@ -617,6 +627,7 @@ retry:
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
 		credential_fill(&http_auth);
+		rpc->no_passwordless_auth = 1;
 		goto retry;
 	}
 	if (err != HTTP_OK)
-- 
2.2.1.209.g41e5f3a

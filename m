From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate fails
Date: Thu,  1 Jan 2015 19:56:27 +0000
Message-ID: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
Cc: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 20:57:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y6lrw-00014K-KB
	for gcvg-git-2@plane.gmane.org; Thu, 01 Jan 2015 20:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbAAT47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2015 14:56:59 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56500 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751180AbbAAT46 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2015 14:56:58 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2D7BE2808F;
	Thu,  1 Jan 2015 19:56:55 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261971>

Apache servers using mod_auth_kerb can be configured to allow the user
to authenticate either using Negotiate (using the Kerberos ticket) or
Basic authentication (using the Kerberos password).  Often, one will
want to use Negotiate authentication if it is available, but fall back
to Basic authentication if the ticket is missing or expired.

However, libcurl will try very hard to use something other than Basic
auth, even over HTTPS.  If Basic and something else are offered, libcurl
will never attempt to use Basic, even if the other option fails.
Teach the HTTP client code to stop trying authentication mechanisms that
don't use a password (currently Negotiate) after the first failure,
since if they failed the first time, they will never succeed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c        | 16 ++++++++++++++++
 http.h        |  3 +++
 remote-curl.c | 11 ++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 040f362..815194d 100644
--- a/http.c
+++ b/http.c
@@ -62,6 +62,8 @@ static const char *user_agent;
 
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
+/* Should we allow non-password-based authentication (e.g. GSSAPI)? */
+int http_passwordless_auth = 1;
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
@@ -986,6 +988,16 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
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
@@ -1035,6 +1047,9 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
+	if (!http_passwordless_auth)
+		disable_passwordless_auth(slot);
+
 	ret = run_one_slot(slot, &results);
 
 	if (options && options->content_type) {
@@ -1139,6 +1154,7 @@ static int http_request_reauth(const char *url,
 	}
 
 	credential_fill(&http_auth);
+	http_passwordless_auth = 0;
 
 	return http_request(url, result, target, options);
 }
diff --git a/http.h b/http.h
index 473179b..71943d3 100644
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
@@ -112,6 +114,7 @@ extern int active_requests;
 extern int http_is_verbose;
 extern size_t http_post_buffer;
 extern struct credential http_auth;
+extern int http_passwordless_auth;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
diff --git a/remote-curl.c b/remote-curl.c
index dd63bc2..4ca5447 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -467,6 +467,9 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
 
+	if (!http_passwordless_auth)
+		disable_passwordless_auth(slot);
+
 	err = run_slot(slot, results);
 
 	curl_slist_free_all(headers);
@@ -510,8 +513,10 @@ static int post_rpc(struct rpc_state *rpc)
 
 		do {
 			err = probe_rpc(rpc, &results);
-			if (err == HTTP_REAUTH)
+			if (err == HTTP_REAUTH) {
 				credential_fill(&http_auth);
+				http_passwordless_auth = 0;
+			}
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
@@ -533,6 +538,9 @@ retry:
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
+	if (!http_passwordless_auth)
+		disable_passwordless_auth(slot);
+
 	if (large_request) {
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
@@ -617,6 +625,7 @@ retry:
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
 		credential_fill(&http_auth);
+		http_passwordless_auth = 0;
 		goto retry;
 	}
 	if (err != HTTP_OK)
-- 
2.2.1.209.g41e5f3a

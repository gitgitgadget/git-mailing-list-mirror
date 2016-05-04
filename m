From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 1/2] http: support sending custom HTTP headers
Date: Wed, 4 May 2016 08:14:13 +0200 (CEST)
Message-ID: <ff7edf51fe8baf57f6f4cab170602154e5b1e73e.1462342213.git.johannes.schindelin@gmx.de>
References: <cover.1461837783.git.johannes.schindelin@gmx.de> <cover.1462342213.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:14:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axq4u-0001rL-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079AbcEDGO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:14:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:62169 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbcEDGOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:14:25 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LcBPV-1bOxkJ3KpJ-00jZIT; Wed, 04 May 2016 08:14:14
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462342213.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:w1emz4y7gQFWMnzsdQ9RlHXeDyI+J2V1/eHNvN7Q3nSnjw5zCxS
 IAVMekSp3VXU4rY03Tx+vZm+/zIcXtd5xUA/2b4DUFXA8NY0pAz6nxUHrwxJPrT8/RE/Dhe
 s2d32UYTZpxVhMapiEIOom7BtHe12kOTOGZYv4vgtyBQDodcHjbjlC6+lXLQGMddbWe3VPc
 +0vCe2NTM2BOimf8qIvsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1okqesgra98=:zouIM4mICOAdQXtB+HHLjB
 4b2gXO/cGgG0Ee3o7bdTEXj2qCoKViYJN80M1xVeAj3wAfTqFoXZojdAR9VKoClbzJMnk3lwA
 c4X6D2Jd8ywNzjKFNkFTYd0+OyN+BPxU7WrchOFt9iegiW3nmR08UlhNi9YBgQiUdP2cUSJcH
 JUsW09lGZXc2tvWW/lrTi/YnX0wi42XvokQxuV2xFa5y79SwQWP12XxUPxVHBavOm+SP6Dtbz
 fTnvgUcp7bfFpZBA1LLHS7hAvg3bHsAvgrs8G3PjnaVXRtS2xSCO3GeGicBXuXE/Lhu3dXqq1
 rUUYjW4FCS9Ee5IxQsYF67e4ZkfQ9S4W9CnQhi3ooFEHVt3v+HgtIJ9X2l4/0fB4SkHPR/vOw
 XK8VwBu+jHPq8zd674CkzMDLpGRjadNOKXnlyhrhOEPs2OQAOfBkHRqR5G7DWowgxUDBCceWb
 NbP9qbnSZYkRRW0AbFZIkTwL2ABwakDodfWWu+tWUujvnoLoGzm8ZT4/+GGptu21PGuoq35Gw
 pwnaVsKGfaHfkUb16aZAn33a6Vm7O8/1PSmBREo5FRdU4y6kCwEXufuHEMgARySQ8Zyy5Ih05
 YJzmfuUiKQkkBSYAGWS3KprbDlHIvAY5ecukMwaP0A6vRoY+8aoc1a8beiEysczqnoJ0uQOYD
 8bminOOU1cq8cnU+AzT7Zn7fnWHTyaNQvJF6WY1QmIcHHqApsDGBpLMkNHr91GnM8L/6gk6gt
 ICCwmRsh8rSOkryBqdQVPPdpC8iezvpozi0IAiqjzmj1lUvSRdsqSd1z5RR9/FciQ/mswO1i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293497>

We introduce a way to send custom HTTP headers with all requests.

This allows us, for example, to send an extra token from build agents
for temporary access to private repositories. (This is the use case that
triggered this patch.)

This feature can be used like this:

	git -c http.extraheader='Secret: sssh!' fetch $URL $REF

Note that `curl_easy_setopt(..., CURLOPT_HTTPHEADER, ...)` takes only
a single list, overriding any previous call. This means we have to
collect _all_ of the headers we want to use into a single list, and
feed it to cURL in one shot. Since we already unconditionally set a
"pragma" header when initializing the curl handles, we can add our new
headers to that list.

For callers which override the default header list (like probe_rpc),
we provide `http_copy_default_headers()` so they can do the same
trick.

Big thanks to Jeff King and Junio Hamano for their outstanding help and
patient reviews.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt    |  6 ++++++
 http-push.c                 | 10 +++++-----
 http.c                      | 35 ++++++++++++++++++++++++++++++++---
 http.h                      |  1 +
 remote-curl.c               |  4 ++--
 t/lib-httpd/apache.conf     |  8 ++++++++
 t/t5551-http-fetch-smart.sh |  7 +++++++
 7 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..c7bbe98 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1655,6 +1655,12 @@ http.emptyAuth::
 	a username in the URL, as libcurl normally requires a username for
 	authentication.
 
+http.extraHeader::
+	Pass an additional HTTP header when communicating with a server.  If
+	more than one such entry exists, all of them are added as extra
+	headers.  To allow overriding the settings inherited from the system
+	config, an empty value will reset the extra headers to the empty list.
+
 http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
diff --git a/http-push.c b/http-push.c
index bd60668..ae2b7f1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -211,7 +211,7 @@ static void curl_setup_http(CURL *curl, const char *url,
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_copy_default_headers();
 
 	if (options & DAV_HEADER_IF) {
 		strbuf_addf(&buf, "If: (<%s>)", lock->token);
@@ -417,7 +417,7 @@ static void start_put(struct transfer_request *request)
 static void start_move(struct transfer_request *request)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_copy_default_headers();
 
 	slot = get_active_slot();
 	slot->callback_func = process_response;
@@ -845,7 +845,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	char *ep;
 	char timeout_header[25];
 	struct remote_lock *lock = NULL;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_copy_default_headers();
 	struct xml_ctx ctx;
 	char *escaped;
 
@@ -1126,7 +1126,7 @@ static void remote_ls(const char *path, int flags,
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_copy_default_headers();
 	struct xml_ctx ctx;
 	struct remote_ls_ctx ls;
 
@@ -1204,7 +1204,7 @@ static int locking_available(void)
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_copy_default_headers();
 	struct xml_ctx ctx;
 	int lock_flags = 0;
 	char *escaped;
diff --git a/http.c b/http.c
index 4304b80..985b995 100644
--- a/http.c
+++ b/http.c
@@ -114,6 +114,7 @@ static unsigned long http_auth_methods = CURLAUTH_ANY;
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
+static struct curl_slist *extra_http_headers;
 
 static struct active_request_slot *active_queue_head;
 
@@ -323,6 +324,19 @@ static int http_options(const char *var, const char *value, void *cb)
 #endif
 	}
 
+	if (!strcmp("http.extraheader", var)) {
+		if (!value) {
+			return config_error_nonbool(var);
+		} else if (!*value) {
+			curl_slist_free_all(extra_http_headers);
+			extra_http_headers = NULL;
+		} else {
+			extra_http_headers =
+				curl_slist_append(extra_http_headers, value);
+		}
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -678,8 +692,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote)
 		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
 
-	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
-	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
+	pragma_header = curl_slist_append(http_copy_default_headers(),
+		"Pragma: no-cache");
+	no_pragma_header = curl_slist_append(http_copy_default_headers(),
+		"Pragma:");
 
 #ifdef USE_CURL_MULTI
 	{
@@ -765,6 +781,9 @@ void http_cleanup(void)
 #endif
 	curl_global_cleanup();
 
+	curl_slist_free_all(extra_http_headers);
+	extra_http_headers = NULL;
+
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
 
@@ -1163,6 +1182,16 @@ int run_one_slot(struct active_request_slot *slot,
 	return handle_curl_result(results);
 }
 
+struct curl_slist *http_copy_default_headers(void)
+{
+	struct curl_slist *headers = NULL, *h;
+
+	for (h = extra_http_headers; h; h = h->next)
+		headers = curl_slist_append(headers, h->data);
+
+	return headers;
+}
+
 static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
 {
 	char *ptr;
@@ -1380,7 +1409,7 @@ static int http_request(const char *url,
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct curl_slist *headers = NULL;
+	struct curl_slist *headers = http_copy_default_headers();
 	struct strbuf buf = STRBUF_INIT;
 	const char *accept_language;
 	int ret;
diff --git a/http.h b/http.h
index 4ef4bbd..36f558b 100644
--- a/http.h
+++ b/http.h
@@ -106,6 +106,7 @@ extern void step_active_slots(void);
 extern void http_init(struct remote *remote, const char *url,
 		      int proactive_auth);
 extern void http_cleanup(void);
+extern struct curl_slist *http_copy_default_headers(void);
 
 extern long int git_curl_ipresolve;
 extern int active_requests;
diff --git a/remote-curl.c b/remote-curl.c
index 15e48e2..672b382 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -474,7 +474,7 @@ static int run_slot(struct active_request_slot *slot,
 static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = NULL;
+	struct curl_slist *headers = http_copy_default_headers();
 	struct strbuf buf = STRBUF_INIT;
 	int err;
 
@@ -503,7 +503,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 static int post_rpc(struct rpc_state *rpc)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = NULL;
+	struct curl_slist *headers = http_copy_default_headers();
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 9317ba0..b8ed96f 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -102,6 +102,14 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_HTTP_EXPORT_ALL
 	Header set Set-Cookie name=value
 </LocationMatch>
+<LocationMatch /smart_headers/>
+	<RequireAll>
+		Require expr %{HTTP:x-magic-one} == 'abra'
+		Require expr %{HTTP:x-magic-two} == 'cadabra'
+	</RequireAll>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error/ error.sh/
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 58207d8..e44fe72 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -282,5 +282,12 @@ test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 	test_line_count = 100000 tags
 '
 
+test_expect_success 'custom http headers' '
+	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
+	git -c http.extraheader="x-magic-one: abra" \
+	    -c http.extraheader="x-magic-two: cadabra" \
+	    fetch "$HTTPD_URL/smart_headers/repo.git"
+'
+
 stop_httpd
 test_done
-- 
2.8.1.306.gff998f2

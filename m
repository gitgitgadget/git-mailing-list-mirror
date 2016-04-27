From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4] http: support sending custom HTTP headers
Date: Wed, 27 Apr 2016 14:20:37 +0200 (CEST)
Message-ID: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
References: <d087647975742a803735c838d0b970d962d75048.1461738362.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:21:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avOSu-0000O5-1I
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 14:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbcD0MVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 08:21:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:61155 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbcD0MVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 08:21:04 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LrNE4-1bgZfW3iUG-013AQ8; Wed, 27 Apr 2016 14:20:39
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <d087647975742a803735c838d0b970d962d75048.1461738362.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:d9vL2IzSqneCf48CtaCpSVd4nJSWg+aycMSs1vO3ZhL2ZUloNe+
 hrgoY7VeGuo/ZkDZF0luZdiGaJO7PQTnnL2lpch9XaRy26B/g/0YSpyO/Ejq8cRjErcc1x8
 4ly2wEOXh/4Ix8uIakDJfwJ2ukX8eWqfmuvHk61VRBqqn3rqgYej3RKoLsSADSQBnUBEjEW
 zEAGOdm6ualT4v1U+R9RQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o36CO0HPGaw=:LDMCKpMpN3t92thz/w648f
 +EdYq0adNA1mLWX/Nh4X4apANn/+lkct+ucbstACtqIUw+yun5X/TWpovjVAso2eoTt88Rsm6
 +X8hLS1iEWKr6njhVNUJeJ5GBoWAdBFiiejgVMlvas7/7Qjkkw40rymRJkeOQIagLAgMzP5jA
 yHPZR9EsF5pWS+p335qLGnKC91YNHsmykfbFFeA6QKnEi4qEjEaRwpxryotLPqh5NHQch+bBL
 iUVY1HhPI9VPwdWbhE+cyNtUjHXXzTBTteChvCDQZUcA2hdTG+HGCWHe++VIsnhszuBeB/RcQ
 IZGPneVO/71vaqPQc7Y3pI+CwtP+KRikwC9OaVPvOYipjH0dFqjnVodxn113Ah5ZIM70xhcke
 NmcXP+umiC/cgzjSFqnP7NrI+0QU3HyQETMdTjASN5dM44dH4jw2++YqagpKw834q/wBrPkRs
 aNMh4hEwA5Od1AHe7ENFTSoqKZs7ioTAQow620+qWEjdze50Tu89xnbCm3QmYchR1ZW747X1i
 vB+4cQEMUG4JyvfMdaD6bLLWpO89ROoPiNbUraYPsvmR4Mvq8dxwFXNHUtvlntjgWIW/CpeOq
 d+WhBzjK02fX2kqEjjrF6BvkyMSW3qcU/DT+cwEDMEThnpp2EhI1YWED2GQurtDW+IQjm+KXs
 j5/+nXXdPDIaQzeJzaqhMVqdVWUslsjU3ZB/i8N9Y4A9liaKGa2sdRdVXAMgJAuQOduYxHwlr
 0SFuWjljDD4U8Su39mRoNOAWHOEjinvP9gxJADc9hsqNJx3hc0UWPVtJeKiR1pNAKMhP+tAh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292721>

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
Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v4

The only change vs v3 is that I replaced my flimsical test by Peff's (with
*one* change: I realized that we need to group the Require statements in a
<RequireAll> block when I tried to verify that the test fails when I
modify the first header).

 Documentation/config.txt    |  6 ++++++
 http-push.c                 | 10 +++++-----
 http.c                      | 35 ++++++++++++++++++++++++++++++++---
 http.h                      |  1 +
 remote-curl.c               |  4 ++--
 t/lib-httpd/apache.conf     |  8 ++++++++
 t/t5551-http-fetch-smart.sh |  7 +++++++
 7 files changed, 61 insertions(+), 10 deletions(-)
Interdiff vs v3:

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
 diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
 index 96425b1..48e2ab6 100755
 --- a/t/t5550-http-fetch-dumb.sh
 +++ b/t/t5550-http-fetch-dumb.sh
 @@ -267,13 +267,5 @@ test_expect_success 'git client does not send an empty Accept-Language' '
  	! grep "^Accept-Language:" stderr
  '
  
 -test_expect_success 'extra HTTP headers are sent' '
 -	GIT_CURL_VERBOSE=1 \
 -	git -c http.extraheader="Hello: World" \
 -		ls-remote "$HTTPD_URL/dumb/repo.git" >out 2>err &&
 -	test_i18ngrep "Hello: World" err >hello.txt &&
 -	test_line_count = 2 hello.txt
 -'
 -
  stop_httpd
  test_done
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

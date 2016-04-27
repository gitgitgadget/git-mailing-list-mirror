From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3] http: support sending custom HTTP headers
Date: Wed, 27 Apr 2016 08:29:10 +0200 (CEST)
Message-ID: <d087647975742a803735c838d0b970d962d75048.1461738362.git.johannes.schindelin@gmx.de>
References: <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:29:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avIyg-0004aF-1u
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 08:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbcD0G3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 02:29:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:49169 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbcD0G3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 02:29:32 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MKZLb-1axEFE0Lyh-001vuP; Wed, 27 Apr 2016 08:29:11
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:NzQFizefl8fywSysCDB9yYNTK7GzUi1dICwG7qNf9QB4CyWW3gY
 ONqEWCQem/ijwF1ZVabBgHFTxQyuVHSMwYoMC89HISf5FAVuS/D6WGQ2ybzagmDijTIIzEY
 PC6Db9FQwrv4OPKVbk2KskrrMQFEbzL2r0UfTcHGYduUPGpu4fxlbxPeSSERh0h66WJPW7n
 oioVYLI1yYqJ4WCef24vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c5Fy6AYqfoo=:rA9ZXFTOgdYyA1eN0znwYw
 VlsRJs+LsGfUWtiPz+TsaSrDmn5pCpM7fr+VajlC3bwnzdy9ohvuvhIiyd4imqFNAh/ycdG0P
 hPhQ5wVg/LTPTbL8Vy1jNiwhO0LR/rzB6Qs2XG8LKKKETC5zf1WC7rRVKqkr6wCpLazvHlgZ7
 yACLUkUTMUT7KDOUibOzdNTQhJZcguCzrTXPqRNb0+kZIiMGIEqIYgoC/JFaunHs+mNFnhA2y
 rYbV9cGNCop+bMVEy8rZBZhdBQRVkEKBshjUmYkuf85mgkMrBjPQvhujBVWvUyV2zbcW2Nh89
 X/wxakAP7K96zlpwmWhgqzUpcCubvjxQTCoWfn3vdE2wGKjLO7afbsHjY2bM9/PfR2iKKJXE+
 /UgOBS85DIRlMzysb5ejwe2cnosAq1FsDTOqVEFlIBqH2qfnjdqrYWFgR0JHYFNu7ezLK44AC
 kKTXvGCp1YuCHC/9dXJp/gcb7G7I8Rlv2QFltlKlojs9eEBx3Qh2gh6EI/1m3mTBz3Kz6JgWp
 2ZCKUdaigPwFvVi6xJp+b7rn9B2Rm5o4/mS2w/YEX4cWmFBgUmca8fyUnCOB1yISjVDYbyIdR
 E7LC7WHLyjF6A3/xp7El3QkXCG73CmTqBCvomQ7I9cuSJd4A8z5K2pf+/2kuGw4WrIV2GoNK3
 DofxNSgy7cloCDfIhfzGsk+m2FfYEtfcUh3dKFBUGkbh1m0m0y4rkD2zXg+pNyDI9bPReLQsX
 wniHHAMtV2IkramCCGgfb7CYe0TAwwtydGJQ+4vaW66tQA4RDpaT7cfIJjsJAXLeNNqo8YSH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292706>

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

Changes since v2:
	- now using Peff's much improved wording in the commit message
	- skipped the last two lines from the documentation of the feature
	- fixed function declaration/definition by using `(void)`
	- we now allow resetting extra headers with an empty value
	- added a test

Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v3
 Documentation/config.txt   |  6 ++++++
 http-push.c                | 10 +++++-----
 http.c                     | 35 ++++++++++++++++++++++++++++++++---
 http.h                     |  1 +
 remote-curl.c              |  4 ++--
 t/t5550-http-fetch-dumb.sh |  8 ++++++++
 6 files changed, 54 insertions(+), 10 deletions(-)
Interdiff vs v2:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 37b9af7..c7bbe98 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1657,9 +1657,9 @@ http.emptyAuth::
  
  http.extraHeader::
  	Pass an additional HTTP header when communicating with a server.  If
 -	more than one such entry exists, all of them are added as extra headers.
 -	This feature is useful e.g. to increase security, or to allow
 -	time-limited access based on expiring tokens.
 +	more than one such entry exists, all of them are added as extra
 +	headers.  To allow overriding the settings inherited from the system
 +	config, an empty value will reset the extra headers to the empty list.
  
  http.cookieFile::
  	File containing previously stored cookie lines which should be used
 diff --git a/http.c b/http.c
 index 3d662bb..985b995 100644
 --- a/http.c
 +++ b/http.c
 @@ -325,8 +325,15 @@ static int http_options(const char *var, const char *value, void *cb)
  	}
  
  	if (!strcmp("http.extraheader", var)) {
 -		extra_http_headers =
 -			curl_slist_append(extra_http_headers, value);
 +		if (!value) {
 +			return config_error_nonbool(var);
 +		} else if (!*value) {
 +			curl_slist_free_all(extra_http_headers);
 +			extra_http_headers = NULL;
 +		} else {
 +			extra_http_headers =
 +				curl_slist_append(extra_http_headers, value);
 +		}
  		return 0;
  	}
  
 @@ -1175,7 +1182,7 @@ int run_one_slot(struct active_request_slot *slot,
  	return handle_curl_result(results);
  }
  
 -struct curl_slist *http_copy_default_headers()
 +struct curl_slist *http_copy_default_headers(void)
  {
  	struct curl_slist *headers = NULL, *h;
  
 diff --git a/http.h b/http.h
 index 5f13695..36f558b 100644
 --- a/http.h
 +++ b/http.h
 @@ -106,7 +106,7 @@ extern void step_active_slots(void);
  extern void http_init(struct remote *remote, const char *url,
  		      int proactive_auth);
  extern void http_cleanup(void);
 -extern struct curl_slist *http_copy_default_headers();
 +extern struct curl_slist *http_copy_default_headers(void);
  
  extern long int git_curl_ipresolve;
  extern int active_requests;
 diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
 index 48e2ab6..96425b1 100755
 --- a/t/t5550-http-fetch-dumb.sh
 +++ b/t/t5550-http-fetch-dumb.sh
 @@ -267,5 +267,13 @@ test_expect_success 'git client does not send an empty Accept-Language' '
  	! grep "^Accept-Language:" stderr
  '
  
 +test_expect_success 'extra HTTP headers are sent' '
 +	GIT_CURL_VERBOSE=1 \
 +	git -c http.extraheader="Hello: World" \
 +		ls-remote "$HTTPD_URL/dumb/repo.git" >out 2>err &&
 +	test_i18ngrep "Hello: World" err >hello.txt &&
 +	test_line_count = 2 hello.txt
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
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 48e2ab6..96425b1 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -267,5 +267,13 @@ test_expect_success 'git client does not send an empty Accept-Language' '
 	! grep "^Accept-Language:" stderr
 '
 
+test_expect_success 'extra HTTP headers are sent' '
+	GIT_CURL_VERBOSE=1 \
+	git -c http.extraheader="Hello: World" \
+		ls-remote "$HTTPD_URL/dumb/repo.git" >out 2>err &&
+	test_i18ngrep "Hello: World" err >hello.txt &&
+	test_line_count = 2 hello.txt
+'
+
 stop_httpd
 test_done
-- 
2.8.1.306.gff998f2

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] http: support sending custom HTTP headers
Date: Tue, 26 Apr 2016 17:40:30 +0200 (CEST)
Message-ID: <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:40:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av56V-0000Vc-0p
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 17:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbcDZPkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 11:40:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:55055 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbcDZPkm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 11:40:42 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M9NIY-1b03hR3EP0-00CiR8; Tue, 26 Apr 2016 17:40:31
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EUHySaylj/hUWbM1ZNj/wqGJgLeIvZMAJ0v2A9iAtOOcy29OUhH
 0T3fX4nqmeILZXA+9ag5Ft3tRiPWnL93qQhnq83v+3O1dgCSBrSSqzclLzOxHrzHdMBQuKL
 ZgP0VnQFYTXZANbyk8X6F7QYlONMDssuDYwDWEJXXC+n/4tOsT5U7nJuH3nj00jG7/jup3N
 zJxUCHhbPkMrCmekz9lKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xrR00TN75+o=:c+XWpksBmjkDPJRdxRTlkN
 9oPX+o+3I7gjJ7cDLunFHntXbppTsGpL6UppVUwvOje+0QdTsXVm2OZGHOIFiL/eTjVfUT33g
 m/wGE99Du2xouHazYM9r+RapX7QAZsN2a2cjOGlaPxU50WV9KUYL5ti+gatejVtmAS2GVEsu1
 KaP+PY9s2OqP1VlVgSVQSAW5xkEo1SZ4wQp/z0u/TZNsaFb48c6YO7EKph9mWO4FwG/LOQ1rf
 GzehY2BWL/6jYzFEJqiP8AoHTHSiB9dH4zW6i53fPfCuvCmBiLSLkTq61kOlYQAR7SK01cyUT
 wAsomLuL2Gvo1ZBwzror39UX3QpXb+HdFp3AjwnELi/vN6xZvNklTeQeHo0ZqWDXjJ98T5N5B
 GNW0/svQryLW3TghXEHEwXO7Wu8SDlQR268MmjM70+n2hfo+HgaKKwmdgBZRJAHm/QGvDN3lW
 x+f6NhFLZp7zNahJbvKZniTDFWaRVtVkq61u6JcWw2axJrACFrzFjCpiuSKuD1RiZ10LRGZFz
 J8YyrKvnWGq2rpg0W5W5+7sVprZOPIqNRoXLw2vNAR87qibbgl66IH3WbBg2tuYuKZPGTictA
 8K5ivaXdiD3N3IdCRtpO1v3ujLjUp8ctd/dNiK9NgcLAiqtImC6q1jRUIGNXAQfnRFvKe7zn0
 cbPcdjKgoG5ZssKcDD8V2D+HcIhWqLkWJEGtFvzYmpiffKYkMJgtg1pXQiwFKKoO45DZsL3h1
 IjoU8LDVacD0diB6h3DYL6v9VCNu7q4xrCE55WMxBVQbFCRh2UPDlsqFmTJ6QTqq28weyV7Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292605>

We introduce a way to send custom HTTP headers with all requests.

This allows us, for example, to send an extra token from build agents
for temporary access to private repositories. (This is the use case that
triggered this patch.)

This feature can be used like this:

	git -c http.extraheader='Secret: sssh!' fetch $URL $REF

As `curl_easy_setopt(..., CURLOPT_HTTPHEADER, ...)` overrides previous
calls' headers (instead of appending the headers, as this unsuspecting
developer thought initially), we piggyback onto the `Pragma:` setting by
default, and introduce the global helper `http_copy_default_headers()`
to help functions that want to specify HTTP headers themselves.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v2

 Documentation/config.txt |  6 ++++++
 http-push.c              | 10 +++++-----
 http.c                   | 28 +++++++++++++++++++++++++---
 http.h                   |  1 +
 remote-curl.c            |  4 ++--
 5 files changed, 39 insertions(+), 10 deletions(-)

Interdiff vs v1:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 42d2b50..37b9af7 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1655,6 +1655,12 @@ http.emptyAuth::
  	a username in the URL, as libcurl normally requires a username for
  	authentication.
  
 +http.extraHeader::
 +	Pass an additional HTTP header when communicating with a server.  If
 +	more than one such entry exists, all of them are added as extra headers.
 +	This feature is useful e.g. to increase security, or to allow
 +	time-limited access based on expiring tokens.
 +
  http.cookieFile::
  	File containing previously stored cookie lines which should be used
  	in the Git http session, if they match the server. The file format
 diff --git a/http-push.c b/http-push.c
 index 04eef17..ae2b7f1 100644
 --- a/http-push.c
 +++ b/http-push.c
 @@ -211,7 +211,7 @@ static void curl_setup_http(CURL *curl, const char *url,
  static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
  {
  	struct strbuf buf = STRBUF_INIT;
 -	struct curl_slist *dav_headers = http_get_default_headers();
 +	struct curl_slist *dav_headers = http_copy_default_headers();
  
  	if (options & DAV_HEADER_IF) {
  		strbuf_addf(&buf, "If: (<%s>)", lock->token);
 @@ -417,7 +417,7 @@ static void start_put(struct transfer_request *request)
  static void start_move(struct transfer_request *request)
  {
  	struct active_request_slot *slot;
 -	struct curl_slist *dav_headers = http_get_default_headers();
 +	struct curl_slist *dav_headers = http_copy_default_headers();
  
  	slot = get_active_slot();
  	slot->callback_func = process_response;
 @@ -845,7 +845,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
  	char *ep;
  	char timeout_header[25];
  	struct remote_lock *lock = NULL;
 -	struct curl_slist *dav_headers = http_get_default_headers();
 +	struct curl_slist *dav_headers = http_copy_default_headers();
  	struct xml_ctx ctx;
  	char *escaped;
  
 @@ -1126,7 +1126,7 @@ static void remote_ls(const char *path, int flags,
  	struct slot_results results;
  	struct strbuf in_buffer = STRBUF_INIT;
  	struct buffer out_buffer = { STRBUF_INIT, 0 };
 -	struct curl_slist *dav_headers = http_get_default_headers();
 +	struct curl_slist *dav_headers = http_copy_default_headers();
  	struct xml_ctx ctx;
  	struct remote_ls_ctx ls;
  
 @@ -1204,7 +1204,7 @@ static int locking_available(void)
  	struct slot_results results;
  	struct strbuf in_buffer = STRBUF_INIT;
  	struct buffer out_buffer = { STRBUF_INIT, 0 };
 -	struct curl_slist *dav_headers = http_get_default_headers();
 +	struct curl_slist *dav_headers = http_copy_default_headers();
  	struct xml_ctx ctx;
  	int lock_flags = 0;
  	char *escaped;
 diff --git a/http.c b/http.c
 index 02d7147..3d662bb 100644
 --- a/http.c
 +++ b/http.c
 @@ -685,9 +685,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
  	if (remote)
  		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
  
 -	pragma_header = curl_slist_append(http_get_default_headers(),
 +	pragma_header = curl_slist_append(http_copy_default_headers(),
  		"Pragma: no-cache");
 -	no_pragma_header = curl_slist_append(http_get_default_headers(),
 +	no_pragma_header = curl_slist_append(http_copy_default_headers(),
  		"Pragma:");
  
  #ifdef USE_CURL_MULTI
 @@ -1175,7 +1175,7 @@ int run_one_slot(struct active_request_slot *slot,
  	return handle_curl_result(results);
  }
  
 -struct curl_slist *http_get_default_headers()
 +struct curl_slist *http_copy_default_headers()
  {
  	struct curl_slist *headers = NULL, *h;
  
 @@ -1402,7 +1402,7 @@ static int http_request(const char *url,
  {
  	struct active_request_slot *slot;
  	struct slot_results results;
 -	struct curl_slist *headers = http_get_default_headers();
 +	struct curl_slist *headers = http_copy_default_headers();
  	struct strbuf buf = STRBUF_INIT;
  	const char *accept_language;
  	int ret;
 diff --git a/http.h b/http.h
 index b0927de..5f13695 100644
 --- a/http.h
 +++ b/http.h
 @@ -106,7 +106,7 @@ extern void step_active_slots(void);
  extern void http_init(struct remote *remote, const char *url,
  		      int proactive_auth);
  extern void http_cleanup(void);
 -extern struct curl_slist *http_get_default_headers();
 +extern struct curl_slist *http_copy_default_headers();
  
  extern long int git_curl_ipresolve;
  extern int active_requests;
 diff --git a/remote-curl.c b/remote-curl.c
 index 86ba787..672b382 100644
 --- a/remote-curl.c
 +++ b/remote-curl.c
 @@ -474,7 +474,7 @@ static int run_slot(struct active_request_slot *slot,
  static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
  {
  	struct active_request_slot *slot;
 -	struct curl_slist *headers = http_get_default_headers();
 +	struct curl_slist *headers = http_copy_default_headers();
  	struct strbuf buf = STRBUF_INIT;
  	int err;
  
 @@ -503,7 +503,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
  static int post_rpc(struct rpc_state *rpc)
  {
  	struct active_request_slot *slot;
 -	struct curl_slist *headers = http_get_default_headers();
 +	struct curl_slist *headers = http_copy_default_headers();
  	int use_gzip = rpc->gzip_request;
  	char *gzip_body = NULL;
  	size_t gzip_size = 0;


diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..37b9af7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1655,6 +1655,12 @@ http.emptyAuth::
 	a username in the URL, as libcurl normally requires a username for
 	authentication.
 
+http.extraHeader::
+	Pass an additional HTTP header when communicating with a server.  If
+	more than one such entry exists, all of them are added as extra headers.
+	This feature is useful e.g. to increase security, or to allow
+	time-limited access based on expiring tokens.
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
index 4304b80..3d662bb 100644
--- a/http.c
+++ b/http.c
@@ -114,6 +114,7 @@ static unsigned long http_auth_methods = CURLAUTH_ANY;
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
+static struct curl_slist *extra_http_headers;
 
 static struct active_request_slot *active_queue_head;
 
@@ -323,6 +324,12 @@ static int http_options(const char *var, const char *value, void *cb)
 #endif
 	}
 
+	if (!strcmp("http.extraheader", var)) {
+		extra_http_headers =
+			curl_slist_append(extra_http_headers, value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -678,8 +685,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
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
@@ -765,6 +774,9 @@ void http_cleanup(void)
 #endif
 	curl_global_cleanup();
 
+	curl_slist_free_all(extra_http_headers);
+	extra_http_headers = NULL;
+
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
 
@@ -1163,6 +1175,16 @@ int run_one_slot(struct active_request_slot *slot,
 	return handle_curl_result(results);
 }
 
+struct curl_slist *http_copy_default_headers()
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
@@ -1380,7 +1402,7 @@ static int http_request(const char *url,
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct curl_slist *headers = NULL;
+	struct curl_slist *headers = http_copy_default_headers();
 	struct strbuf buf = STRBUF_INIT;
 	const char *accept_language;
 	int ret;
diff --git a/http.h b/http.h
index 4ef4bbd..5f13695 100644
--- a/http.h
+++ b/http.h
@@ -106,6 +106,7 @@ extern void step_active_slots(void);
 extern void http_init(struct remote *remote, const char *url,
 		      int proactive_auth);
 extern void http_cleanup(void);
+extern struct curl_slist *http_copy_default_headers();
 
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
-- 
2.8.1.306.gff998f2

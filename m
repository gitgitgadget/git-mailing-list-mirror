From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 1/6] http: try http_proxy env var when http.proxy config option
 is not set
Date: Thu, 03 May 2012 18:39:47 +0200
Message-ID: <4FA2B4D3.90809@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 17:42:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPyBC-0004vu-VE
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 17:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757543Ab2ECPmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 11:42:47 -0400
Received: from luthien1.map.es ([82.150.0.102]:4488 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab2ECPmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 11:42:46 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 4F080B7913;
	Thu,  3 May 2012 17:42:36 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 1D6BC2C4C8;
	Thu,  3 May 2012 17:42:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 4F080B7913.C0C42
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336664556.9821@KmNnbFxZieo8lv2E8N/gfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196911>

cURL already reads it, but if $http_proxy has username but no password
cURL will not ask you for the password and so failed to authenticate
returning a 407 error code. So we read it ourselves to detect that and
ask for the password. Also we read it prior to connection to be able to
make a proactive authentication in case the flag http_proactive_auth is
set.

We also take care to read env proxy var according to protocol being
used in the destination url, e.g.  when the url to retrieve is a https
one, then the proxy env var we look at is https_proxy. We also look at
the uppercase version of these if the lowercase is not found, with the
exception of HTTP_PROXY because cURL ignores it. To make this possible
we now passed destination url parameter to get_active_slot() and
get_curl_handle() functions.

We also read no_proxy env var so to ignore aforementioned proxy env var
if no_proxy contains an asterisk ('*') or contains the host used in url
destination.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-push.c   |   24 +++++++++++-----------
 http-walker.c |    2 +-
 http.c        |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 http.h        |    2 +-
 remote-curl.c |    4 +-
 5 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/http-push.c b/http-push.c
index 1df7ab5..4e23d00 100644
--- a/http-push.c
+++ b/http-push.c
@@ -297,7 +297,7 @@ static void start_mkcol(struct transfer_request *request)
 
 	request->url = get_remote_object_url(repo->url, hex, 1);
 
-	slot = get_active_slot();
+	slot = get_active_slot(request->url);
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	curl_setup_http_get(slot->curl, request->url, DAV_MKCOL);
@@ -417,7 +417,7 @@ static void start_put(struct transfer_request *request)
 	strbuf_add(&buf, request->lock->tmpfile_suffix, 41);
 	request->url = strbuf_detach(&buf, NULL);
 
-	slot = get_active_slot();
+	slot = get_active_slot(request->url);
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	curl_setup_http(slot->curl, request->url, DAV_PUT,
@@ -438,7 +438,7 @@ static void start_move(struct transfer_request *request)
 	struct active_request_slot *slot;
 	struct curl_slist *dav_headers = NULL;
 
-	slot = get_active_slot();
+	slot = get_active_slot(request->url);
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	curl_setup_http_get(slot->curl, request->url, DAV_MOVE);
@@ -467,7 +467,7 @@ static int refresh_lock(struct remote_lock *lock)
 
 	dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF | DAV_HEADER_TIMEOUT);
 
-	slot = get_active_slot();
+	slot = get_active_slot(lock->url);
 	slot->results = &results;
 	curl_setup_http_get(slot->curl, lock->url, DAV_LOCK);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
@@ -882,7 +882,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	while (ep) {
 		char saved_character = ep[1];
 		ep[1] = '\0';
-		slot = get_active_slot();
+		slot = get_active_slot(url);
 		slot->results = &results;
 		curl_setup_http_get(slot->curl, url, DAV_MKCOL);
 		if (start_active_slot(slot)) {
@@ -912,7 +912,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
-	slot = get_active_slot();
+	slot = get_active_slot(url);
 	slot->results = &results;
 	curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
@@ -980,7 +980,7 @@ static int unlock_remote(struct remote_lock *lock)
 
 	dav_headers = get_dav_token_headers(lock, DAV_HEADER_LOCK);
 
-	slot = get_active_slot();
+	slot = get_active_slot(lock->url);
 	slot->results = &results;
 	curl_setup_http_get(slot->curl, lock->url, DAV_UNLOCK);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
@@ -1158,7 +1158,7 @@ static void remote_ls(const char *path, int flags,
 	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
-	slot = get_active_slot();
+	slot = get_active_slot(url);
 	slot->results = &results;
 	curl_setup_http(slot->curl, url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
@@ -1232,7 +1232,7 @@ static int locking_available(void)
 	dav_headers = curl_slist_append(dav_headers, "Depth: 0");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
-	slot = get_active_slot();
+	slot = get_active_slot(repo->url);
 	slot->results = &results;
 	curl_setup_http(slot->curl, repo->url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
@@ -1409,7 +1409,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 	strbuf_addf(&out_buffer.buf, "%s\n", sha1_to_hex(sha1));
 
-	slot = get_active_slot();
+	slot = get_active_slot(lock->url);
 	slot->results = &results;
 	curl_setup_http(slot->curl, lock->url, DAV_PUT,
 			&out_buffer, fwrite_null);
@@ -1535,7 +1535,7 @@ static void update_remote_info_refs(struct remote_lock *lock)
 	if (!aborted) {
 		dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF);
 
-		slot = get_active_slot();
+		slot = get_active_slot(lock->url);
 		slot->results = &results;
 		curl_setup_http(slot->curl, lock->url, DAV_PUT,
 				&buffer, fwrite_null);
@@ -1695,7 +1695,7 @@ static int delete_remote_branch(const char *pattern, int force)
 		return 0;
 	url = xmalloc(strlen(repo->url) + strlen(remote_ref->name) + 1);
 	sprintf(url, "%s%s", repo->url, remote_ref->name);
-	slot = get_active_slot();
+	slot = get_active_slot(url);
 	slot->results = &results;
 	curl_setup_http_get(slot->curl, url, DAV_DELETE);
 	if (start_active_slot(slot)) {
diff --git a/http-walker.c b/http-walker.c
index 51a906e..5d5ae34 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -348,7 +348,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	 * Use a callback to process the result, since another request
 	 * may fail and need to have alternates loaded before continuing
 	 */
-	slot = get_active_slot();
+	slot = get_active_slot(url);
 	slot->callback_func = process_alternates_response;
 	alt_req.walker = walker;
 	slot->callback_data = &alt_req;
diff --git a/http.c b/http.c
index 5cb87f1..64df7b1 100644
--- a/http.c
+++ b/http.c
@@ -229,6 +229,37 @@ static void init_curl_http_auth(CURL *result)
 #endif
 }
 
+static const char *read_prot_proxy_env(const char *protocol)
+{
+	const char *env_proxy;
+	struct strbuf var = STRBUF_INIT;
+
+	strbuf_addf(&var, "%s_proxy", protocol);
+	env_proxy = getenv(var.buf);
+	if (!env_proxy && strcmp("http_proxy", var.buf)) {
+		char *p;
+		for (p = var.buf; *p; p++)
+			*p = toupper(*p);
+		env_proxy = getenv(var.buf);
+	}
+	strbuf_release(&var);
+	
+	return env_proxy;
+}
+
+static int host_allowed_by_noproxy_env (const char *host)
+{
+	const char *no_proxy = getenv("no_proxy");
+	if (!no_proxy)
+		no_proxy = getenv("NO_PROXY");
+	if (!no_proxy ||
+	    (strcmp("*", no_proxy) &&
+	     !strstr(no_proxy, host)))
+		return 1;
+	
+	return 0;
+}
+
 static int has_cert_password(void)
 {
 	if (ssl_cert == NULL || ssl_cert_password_required != 1)
@@ -241,7 +272,7 @@ static int has_cert_password(void)
 	return 1;
 }
 
-static CURL *get_curl_handle(void)
+static CURL *get_curl_handle(const char *url)
 {
 	CURL *result = curl_easy_init();
 
@@ -304,6 +335,21 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
+	if (!curl_http_proxy) {
+		static struct credential parsed_url = CREDENTIAL_INIT;
+		credential_from_url(&parsed_url, url);
+
+		if (parsed_url.protocol) {
+			const char *env_proxy;
+			env_proxy = read_prot_proxy_env(parsed_url.protocol);
+
+			if (env_proxy && host_allowed_by_noproxy_env(parsed_url.host))
+				curl_http_proxy = xstrdup(env_proxy);
+		}
+
+		credential_clear(&parsed_url);
+	}
+	
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
@@ -394,7 +440,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	}
 
 #ifndef NO_CURL_EASY_DUPHANDLE
-	curl_default = get_curl_handle();
+	curl_default = get_curl_handle(url);
 #endif
 }
 
@@ -443,7 +489,7 @@ void http_cleanup(void)
 	ssl_cert_password_required = 0;
 }
 
-struct active_request_slot *get_active_slot(void)
+struct active_request_slot *get_active_slot(const char *url)
 {
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
@@ -481,7 +527,7 @@ struct active_request_slot *get_active_slot(void)
 
 	if (slot->curl == NULL) {
 #ifdef NO_CURL_EASY_DUPHANDLE
-		slot->curl = get_curl_handle();
+		slot->curl = get_curl_handle(url);
 #else
 		slot->curl = curl_easy_duphandle(curl_default);
 #endif
@@ -756,7 +802,7 @@ static int http_request(const char *url, void *result, int target, int options)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 
-	slot = get_active_slot();
+	slot = get_active_slot(url);
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
@@ -1101,7 +1147,7 @@ struct http_pack_request *new_http_pack_request(
 		goto abort;
 	}
 
-	preq->slot = get_active_slot();
+	preq->slot = get_active_slot(preq->url);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
@@ -1261,7 +1307,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		}
 	}
 
-	freq->slot = get_active_slot();
+	freq->slot = get_active_slot(freq->url);
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
diff --git a/http.h b/http.h
index 915c286..483e3ed 100644
--- a/http.h
+++ b/http.h
@@ -73,7 +73,7 @@ extern curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
 #endif
 
 /* Slot lifecycle functions */
-extern struct active_request_slot *get_active_slot(void);
+extern struct active_request_slot *get_active_slot(const char *url);
 extern int start_active_slot(struct active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_active_slot(struct active_request_slot *slot);
diff --git a/remote-curl.c b/remote-curl.c
index 0896221..6ceba7a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -384,7 +384,7 @@ static int probe_rpc(struct rpc_state *rpc)
 	struct strbuf buf = STRBUF_INIT;
 	int err;
 
-	slot = get_active_slot();
+	slot = get_active_slot(rpc->service_url);
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
@@ -441,7 +441,7 @@ static int post_rpc(struct rpc_state *rpc)
 			return err;
 	}
 
-	slot = get_active_slot();
+	slot = get_active_slot(rpc->service_url);
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
-- 
1.7.7.6

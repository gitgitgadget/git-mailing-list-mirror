From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] http: Support sending custom HTTP headers
Date: Mon, 25 Apr 2016 15:13:08 +0200 (CEST)
Message-ID: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:13:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1augKJ-0003L9-1K
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 15:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbcDYNNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 09:13:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:52389 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299AbcDYNNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 09:13:16 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lh7M3-1bX3Cr0X0p-00oUri; Mon, 25 Apr 2016 15:13:10
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EFwRGY81h9tVzHUg55SW8FH7Cp8re9ojnR8lyQjp26OUMGth/ox
 9eQflvfFF6fGRD9r06w04HyUWn+KO59brzfI1RnJN45EQrzvno+ui6JEAan6xWh9VzAatyd
 ujQQxfvVeK72V/FK7CWh53aAQDNQanBVlsAl3x+bO9hdyGv6xZjEjwYbSxLBxTIK8LAMARP
 xeCoiCzlIkgZr+OmE6FqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D06l+Nfi0JI=:U2/dUGjdVIL7Zt01GGWb0G
 cg/4Jb00189LaaL6l2X7RSxA61zbBNcbElqehpkh2sVgL/jyyqIGnR0o34uQDmFrfUhtg3ED+
 MMBV7DUTZQYcBkG3UIuB59BHMe/HA/mHHGC8kzj4U2xwysxFRfDUqidbCsu1vpxeVgH/UgeoR
 D8faJrrjzb9krNdJjbJBLOaavglHGK9D0ICLDJslE17fVN+qWxqqUbp9LoRGcFSNQXtrNrxHg
 LcAJMyxaNYv1QYMdEahp3t7wSgu9OiffSDbUgprZsqgOBcun22PB4VkwLtFDddSZ8Dz4J3dRy
 ibDI5vXkNS+Z7E+d+JPHTyWpmeJaGEmrEgphxd8nKJy/0TYWwHP+Tv4GXSDGEy/kPEdUIWf+/
 YUuCp5bXDzIS6JbyEPtodDTDyZZ72pYLaXScz/5q+R4LnFEw2lpRDwU5m4OkHT5fi0RBIEbNa
 4bjMtfZquUAboeZtarpv/OSYESR/svP73bglX5VetQh3uyJuZpPe0hcmlpJBe/ivCNIvk6Rid
 GQWQi5ZVPcwy7zoFK9dKiSdcHUWkz8m6HvWQOxYBMyjpzRrLIJ++IXSBQPprdRbs1cH+473oU
 D39SIMffX/VCCCp5JE7Ohsl90+4nPLUGFc6/Twnowp0z2eNNLo8tJ9Nr5I+dijWAmntfJvTFo
 qOo4LNWiSqR87nwSkx/sY/6i3hiC+h3rjpf8BEvuuzSHoxpTM5NPBW/4VirBsL5mpfcXEQQ9C
 QhosdCePVMbRDUGH/UTR6PpkrExe6GEz1xhu7/2NIaLxMwlAYRSnUMls2w55mBdTe4tbcIOG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292473>

To make communication for `git fetch`, `git ls-remote` and friends extra
secure, we introduce a way to send custom HTTP headers with all
requests.

This allows us, for example, to send an extra token that the server
tests for. The server could use this token e.g. to ensure that only
certain operations or refs are allowed, or allow the token to be used
only once.

This feature can be used like this:

	git -c http.extraheader='Secret: sssh!' fetch $URL $REF

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v1
---
 http-push.c   | 10 +++++-----
 http.c        | 28 +++++++++++++++++++++++++---
 http.h        |  1 +
 remote-curl.c |  4 ++--
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/http-push.c b/http-push.c
index bd60668..04eef17 100644
--- a/http-push.c
+++ b/http-push.c
@@ -211,7 +211,7 @@ static void curl_setup_http(CURL *curl, const char *url,
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_get_default_headers();
 
 	if (options & DAV_HEADER_IF) {
 		strbuf_addf(&buf, "If: (<%s>)", lock->token);
@@ -417,7 +417,7 @@ static void start_put(struct transfer_request *request)
 static void start_move(struct transfer_request *request)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_get_default_headers();
 
 	slot = get_active_slot();
 	slot->callback_func = process_response;
@@ -845,7 +845,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	char *ep;
 	char timeout_header[25];
 	struct remote_lock *lock = NULL;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_get_default_headers();
 	struct xml_ctx ctx;
 	char *escaped;
 
@@ -1126,7 +1126,7 @@ static void remote_ls(const char *path, int flags,
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_get_default_headers();
 	struct xml_ctx ctx;
 	struct remote_ls_ctx ls;
 
@@ -1204,7 +1204,7 @@ static int locking_available(void)
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers = http_get_default_headers();
 	struct xml_ctx ctx;
 	int lock_flags = 0;
 	char *escaped;
diff --git a/http.c b/http.c
index 4304b80..02d7147 100644
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
+	pragma_header = curl_slist_append(http_get_default_headers(),
+		"Pragma: no-cache");
+	no_pragma_header = curl_slist_append(http_get_default_headers(),
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
 
+struct curl_slist *http_get_default_headers()
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
+	struct curl_slist *headers = http_get_default_headers();
 	struct strbuf buf = STRBUF_INIT;
 	const char *accept_language;
 	int ret;
diff --git a/http.h b/http.h
index 4ef4bbd..b0927de 100644
--- a/http.h
+++ b/http.h
@@ -106,6 +106,7 @@ extern void step_active_slots(void);
 extern void http_init(struct remote *remote, const char *url,
 		      int proactive_auth);
 extern void http_cleanup(void);
+extern struct curl_slist *http_get_default_headers();
 
 extern long int git_curl_ipresolve;
 extern int active_requests;
diff --git a/remote-curl.c b/remote-curl.c
index 15e48e2..86ba787 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -474,7 +474,7 @@ static int run_slot(struct active_request_slot *slot,
 static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = NULL;
+	struct curl_slist *headers = http_get_default_headers();
 	struct strbuf buf = STRBUF_INIT;
 	int err;
 
@@ -503,7 +503,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 static int post_rpc(struct rpc_state *rpc)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = NULL;
+	struct curl_slist *headers = http_get_default_headers();
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
-- 
2.8.1.306.gff998f2

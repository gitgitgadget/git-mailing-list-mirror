From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Wed,  4 Nov 2015 10:13:25 +0100
Message-ID: <1446628405-8070-3-git-send-email-k.franke@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446628405-8070-1-git-send-email-k.franke@science-computing.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Knut Franke <k.franke@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 10:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtuIG-0003UN-8z
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 10:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbbKDJXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 04:23:40 -0500
Received: from mx3.science-computing.de ([193.197.16.20]:6344 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450AbbKDJXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 04:23:34 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2015 04:23:33 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 4F4313FE7;
	Wed,  4 Nov 2015 10:13:45 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obi.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jlcT730hftOS; Wed,  4 Nov 2015 10:13:44 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 3A9793BFA;
	Wed,  4 Nov 2015 10:13:44 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 2D14CA757D; Wed,  4 Nov 2015 10:13:44 +0100 (CET)
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1446628405-8070-1-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280857>

Currently, the only way to pass proxy credentials to curl is by including them
in the proxy URL. Usually, this means they will end up on disk unencrypted, one
way or another (by inclusion in ~/.gitconfig, shell profile or history). Since
proxy authentication often uses a domain user, credentials can be security
sensitive; therefore, a safer way of passing credentials is desirable.

If the configured proxy contains a username but not a password, query the
credential API for one. Also, make sure we approve/reject proxy credentials
properly.

For consistency reasons, add parsing of http_proxy/https_proxy/all_proxy
environment variables, which would otherwise be evaluated as a fallback by curl.
Without this, we would have different semantics for git configuration and
environment variables.

Signed-off-by: Knut Franke <k.franke@science-computing.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt | 10 +++++--
 http.c                   | 72 +++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                   |  1 +
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4ad7f74..320ce9a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1593,9 +1593,13 @@ help.htmlPath::
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy',
-	'https_proxy', and 'all_proxy' environment variables (see
-	`curl(1)`).  This can be overridden on a per-remote basis; see
-	remote.<name>.proxy
+	'https_proxy', and 'all_proxy' environment variables (see `curl(1)`). In
+	addition to the syntax understood by curl, it is possible to specify a
+	proxy string with a user name but no password, in which case git will
+	attempt to acquire one in the same way it does for other credentials. See
+	linkgit:gitcredentials[7] for more information. The syntax thus is
+	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
+	on a per-remote basis; see remote.<name>.proxy
 
 http.proxyAuthMethod::
 	Set the method with which to authenticate against the HTTP proxy. This
diff --git a/http.c b/http.c
index a786802..714a59a 100644
--- a/http.c
+++ b/http.c
@@ -81,6 +81,8 @@ static struct {
 	 * here, too
 	 */
 };
+static struct credential proxy_auth = CREDENTIAL_INIT;
+static const char *curl_proxyuserpwd;
 static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
@@ -178,6 +180,9 @@ static void finish_active_slot(struct active_request_slot *slot)
 #else
 		slot->results->auth_avail = 0;
 #endif
+
+		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
+			&slot->results->http_connectcode);
 	}
 
 	/* Run callback if appropriate */
@@ -337,6 +342,24 @@ static void var_override(const char **var, char *value)
 
 static void init_curl_proxy_auth(CURL *result)
 {
+	if (proxy_auth.username) {
+		struct strbuf s = STRBUF_INIT;
+		if (!proxy_auth.password)
+			credential_fill(&proxy_auth);
+#if LIBCURL_VERSION_NUM >= 0x071301
+		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
+			proxy_auth.username);
+		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
+			proxy_auth.password);
+#else
+		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
+		strbuf_addch(&s, ':');
+		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
+		curl_proxyuserpwd = strbuf_detach(&s, NULL);
+		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
+#endif
+	}
+
 	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
 
 #if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
@@ -518,8 +541,42 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
 #endif
 
+	/*
+	 * CURL also examines these variables as a fallback; but we need to query
+	 * them here in order to decide whether to prompt for missing password (cf.
+	 * init_curl_proxy_auth()).
+	 *
+	 * Unlike many other common environment variables, these are historically
+	 * lowercase only. It appears that CURL did not know this and implemented
+	 * only uppercase variants, which was later corrected to take both - with
+	 * the exception of http_proxy, which is lowercase only also in CURL. As
+	 * the lowercase versions are the historical quasi-standard, they take
+	 * precedence here, as in CURL.
+	 */
+	if (!curl_http_proxy) {
+		if (!strcmp(http_auth.protocol, "https")) {
+			var_override(&curl_http_proxy, getenv("HTTPS_PROXY"));
+			var_override(&curl_http_proxy, getenv("https_proxy"));
+		} else {
+			var_override(&curl_http_proxy, getenv("http_proxy"));
+		}
+		if (!curl_http_proxy) {
+			var_override(&curl_http_proxy, getenv("ALL_PROXY"));
+			var_override(&curl_http_proxy, getenv("all_proxy"));
+		}
+	}
+
 	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		if (strstr(curl_http_proxy, "://"))
+			credential_from_url(&proxy_auth, curl_http_proxy);
+		else {
+			struct strbuf url = STRBUF_INIT;
+			strbuf_addf(&url, "http://%s", curl_http_proxy);
+			credential_from_url(&proxy_auth, url.buf);
+			strbuf_release(&url);
+		}
+
+		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
 	}
 	init_curl_proxy_auth(result);
 
@@ -663,6 +720,15 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
+	if (proxy_auth.password) {
+		memset(proxy_auth.password, 0, strlen(proxy_auth.password));
+		free(proxy_auth.password);
+		proxy_auth.password = NULL;
+	}
+
+	free((void *)curl_proxyuserpwd);
+	curl_proxyuserpwd = NULL;
+
 	free((void *) http_proxy_authmethod);
 	http_proxy_authmethod = NULL;
 
@@ -994,6 +1060,8 @@ static int handle_curl_result(struct slot_results *results)
 
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
+		if (proxy_auth.password)
+			credential_approve(&proxy_auth);
 		return HTTP_OK;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
@@ -1008,6 +1076,8 @@ static int handle_curl_result(struct slot_results *results)
 			return HTTP_REAUTH;
 		}
 	} else {
+		if (results->http_connectcode == 407)
+			credential_reject(&proxy_auth);
 #if LIBCURL_VERSION_NUM >= 0x070c00
 		if (!curl_errorstr[0])
 			strlcpy(curl_errorstr,
diff --git a/http.h b/http.h
index 49afe39..7352a9e 100644
--- a/http.h
+++ b/http.h
@@ -54,6 +54,7 @@ struct slot_results {
 	CURLcode curl_result;
 	long http_code;
 	long auth_avail;
+	long http_connectcode;
 };
 
 struct active_request_slot {
-- 
2.3.7

-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196

From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Mon,  2 Nov 2015 17:54:24 +0100
Message-ID: <1446483264-15123-3-git-send-email-k.franke@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446483264-15123-1-git-send-email-k.franke@science-computing.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Knut Franke <k.franke@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 18:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtIXU-0001TX-UL
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 18:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbbKBREv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 12:04:51 -0500
Received: from mx1.science-computing.de ([217.243.222.155]:65315 "EHLO
	mx1.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbbKBREf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 12:04:35 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2015 12:04:34 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 67C304915;
	Mon,  2 Nov 2015 17:54:45 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guiness.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id STEqQHchQHnY; Mon,  2 Nov 2015 17:54:44 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 959484140;
	Mon,  2 Nov 2015 17:54:44 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 8955BA0978; Mon,  2 Nov 2015 17:54:44 +0100 (CET)
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1446483264-15123-1-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280702>

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
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
---
 http.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 http.h |  1 +
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 1172819..5708c7a 100644
--- a/http.c
+++ b/http.c
@@ -62,7 +62,7 @@ static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
-static const char *curl_http_proxy;
+static const char *curl_http_proxy = NULL;
 static const char *http_proxy_authmethod = NULL;
 static struct {
 	const char *name;
@@ -81,6 +81,8 @@ static struct {
 	 * here, too
 	 */
 };
+static struct credential proxy_auth = CREDENTIAL_INIT;
+static const char *curl_proxyuserpwd = NULL;
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
@@ -339,6 +344,24 @@ static void env_override(const char **var, const char *envname)
 
 static void init_curl_proxy_auth(CURL *result)
 {
+	if (proxy_auth.username) {
+		if (!proxy_auth.password)
+			credential_fill(&proxy_auth);
+#if LIBCURL_VERSION_NUM >= 0x071301
+		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
+			proxy_auth.username);
+		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
+			proxy_auth.password);
+#else
+		struct strbuf s = STRBUF_INIT;
+		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
+		strbuf_addch(&s, ':');
+		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
+		curl_proxyuserpwd = strbuf_detach(&s, NULL);
+		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
+#endif
+	}
+
 	env_override(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
 
 #if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
@@ -520,8 +543,42 @@ static CURL *get_curl_handle(void)
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
+			env_override(&curl_http_proxy, "HTTPS_PROXY");
+			env_override(&curl_http_proxy, "https_proxy");
+		} else {
+			env_override(&curl_http_proxy, "http_proxy");
+		}
+		if (!curl_http_proxy) {
+			env_override(&curl_http_proxy, "ALL_PROXY");
+			env_override(&curl_http_proxy, "all_proxy");
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
 
@@ -668,6 +725,17 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
+	if (proxy_auth.password) {
+		memset(proxy_auth.password, 0, strlen(proxy_auth.password));
+		free(proxy_auth.password);
+		proxy_auth.password = NULL;
+	}
+
+	if (curl_proxyuserpwd) {
+		free((void *)curl_proxyuserpwd);
+		curl_proxyuserpwd = NULL;
+	}
+
 	if (http_proxy_authmethod) {
 		free((void *)http_proxy_authmethod);
 		http_proxy_authmethod = NULL;
@@ -1001,6 +1069,8 @@ static int handle_curl_result(struct slot_results *results)
 
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
+		if (proxy_auth.password)
+			credential_approve(&proxy_auth);
 		return HTTP_OK;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
@@ -1015,6 +1085,8 @@ static int handle_curl_result(struct slot_results *results)
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

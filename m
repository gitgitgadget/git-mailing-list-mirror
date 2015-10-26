From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Mon, 26 Oct 2015 18:55:09 +0100
Message-ID: <1445882109-18184-2-git-send-email-k.franke@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Cc: Knut Franke <k.franke@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 19:05:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqm9X-0000ku-J6
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 19:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbbJZSFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 14:05:46 -0400
Received: from mx3.science-computing.de ([193.197.16.20]:33434 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbJZSFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 14:05:45 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2015 14:05:44 EDT
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 007EC4821;
	Mon, 26 Oct 2015 18:55:33 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guiness.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SgPCLffbBmO3; Mon, 26 Oct 2015 18:55:33 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 82F2D653;
	Mon, 26 Oct 2015 18:55:33 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 62C9DA757D; Mon, 26 Oct 2015 18:55:46 +0100 (CET)
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280203>

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
---
 http.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h |  1 +
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index f7366d0..6e20017 100644
--- a/http.c
+++ b/http.c
@@ -64,6 +64,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *http_proxy_authmethod = NULL;
+struct credential http_proxy_auth = CREDENTIAL_INIT;
 static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
@@ -161,6 +162,9 @@ static void finish_active_slot(struct active_request_slot *slot)
 #else
 		slot->results->auth_avail = 0;
 #endif
+
+		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
+			&slot->results->http_connectcode);
 	}
 
 	/* Run callback if appropriate */
@@ -318,6 +322,25 @@ static void set_from_env(const char **var, const char *envname)
 
 static void init_curl_proxy_auth(CURL *result)
 {
+	if (http_proxy_auth.username) {
+		if (!http_proxy_auth.password) {
+			credential_fill(&http_proxy_auth);
+		}
+#if LIBCURL_VERSION_NUM >= 0x071301
+		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
+			http_proxy_auth.username);
+		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
+			http_proxy_auth.password);
+#else
+		struct strbuf up = STRBUF_INIT;
+		strbuf_reset(&up);
+		strbuf_addstr_urlencode(&up, http_proxy_auth.username, 1);
+		strbuf_addch(&up, ':');
+		strbuf_addstr_urlencode(&up, http_proxy_auth.password, 1);
+		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, up.buf);
+#endif
+	}
+
     set_from_env(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
 
 	if (http_proxy_authmethod) {
@@ -505,8 +528,36 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
 #endif
 
+	/*
+	 * curl also examines these variables as a fallback; but we need to query
+	 * them here in order to decide whether to prompt for missing password (cf.
+	 * init_curl_proxy_auth()).
+	 */
+	if (!curl_http_proxy) {
+		if (!strcmp(http_auth.protocol, "https")) {
+			set_from_env(&curl_http_proxy, "HTTPS_PROXY");
+			set_from_env(&curl_http_proxy, "https_proxy");
+		} else {
+			set_from_env(&curl_http_proxy, "http_proxy");
+		}
+		if (!curl_http_proxy) {
+			set_from_env(&curl_http_proxy, "ALL_PROXY");
+			set_from_env(&curl_http_proxy, "all_proxy");
+		}
+	}
+
 	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		if (strstr(curl_http_proxy, "://"))
+			credential_from_url(&http_proxy_auth, curl_http_proxy);
+		else {
+			struct strbuf url = STRBUF_INIT;
+			strbuf_reset(&url);
+			strbuf_addstr(&url, "http://");
+			strbuf_addstr(&url, curl_http_proxy);
+			credential_from_url(&http_proxy_auth, url.buf);
+		}
+
+		curl_easy_setopt(result, CURLOPT_PROXY, http_proxy_auth.host);
 	}
 	init_curl_proxy_auth(result);
 
@@ -643,6 +694,12 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
+	if (http_proxy_auth.password) {
+		memset(http_proxy_auth.password, 0, strlen(http_proxy_auth.password));
+		free(http_proxy_auth.password);
+		http_proxy_auth.password = NULL;
+	}
+
 	if (http_proxy_authmethod) {
 		free((void *)http_proxy_authmethod);
 		http_proxy_authmethod = NULL;
@@ -976,6 +1033,8 @@ static int handle_curl_result(struct slot_results *results)
 
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
+		if (http_proxy_auth.password)
+			credential_approve(&http_proxy_auth);
 		return HTTP_OK;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
@@ -990,6 +1049,8 @@ static int handle_curl_result(struct slot_results *results)
 			return HTTP_REAUTH;
 		}
 	} else {
+		if (results->http_connectcode == 407)
+			credential_reject(&http_proxy_auth);
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

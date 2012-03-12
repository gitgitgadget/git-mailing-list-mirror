From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v4 2/5] http: handle proxy proactive authentication
Date: Mon, 12 Mar 2012 18:26:51 +0100
Message-ID: <4F5E31DB.5050900@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 17:28:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S786d-0006jp-PB
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab2CLQ2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:28:15 -0400
Received: from luthien1.map.es ([82.150.0.102]:36779 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab2CLQ2O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:28:14 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 74AA3F8927;
	Mon, 12 Mar 2012 17:28:05 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 267C32C2EB;
	Mon, 12 Mar 2012 17:28:00 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 74AA3F8927.CC9B1
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332174486.15289@z7/y7dkhH3rvCCIwu0RPRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192895>

If http_proactive_auth flag is set and there is a username
but no password in the proxy url, then interactively ask for
the password.

This makes possible to not have the password written down in
http_proxy env var or in http.proxy config option.

Also take care that CURLOPT_PROXY don't include username or
password, as we now set them in the new set_proxy_auth() function
where we use their specific cURL options.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 8932da5..dbdbc3f 100644
--- a/http.c
+++ b/http.c
@@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static struct credential http_auth = CREDENTIAL_INIT;
+static struct credential proxy_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
@@ -232,6 +233,20 @@ static int has_cert_password(void)
 	return 1;
 }
 
+static void set_proxy_auth(CURL *result)
+{
+	if (proxy_auth.username && proxy_auth.password) {
+#if LIBCURL_VERSION_NUM >= 0x071901
+		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME, proxy_auth.username);
+		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD, proxy_auth.password);
+#else
+		char userpwd[100];
+		snprintf(userpwd, 100, "%s:%s", proxy_auth.username, proxy_auth.password);
+		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, userpwd);
+#endif
+	}
+}
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -303,8 +318,18 @@ static CURL *get_curl_handle(void)
 		}
 	}
 	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		if (!proxy_auth.host) { // check to parse only once
+			credential_from_url(&proxy_auth, curl_http_proxy);
+		}
+		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password) {
+			/* proxy string has username but no password, ask for password */
+			credential_fill(&proxy_auth);
+		}
+		char proxyhost[100];
+		snprintf(proxyhost, 100, "%s://%s", proxy_auth.protocol, proxy_auth.host);
+		curl_easy_setopt(result, CURLOPT_PROXY, proxyhost);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+		set_proxy_auth(result);
 	}
 
 	return result;
-- 
1.7.7.6

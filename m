From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Tue, 13 Mar 2012 15:03:54 +0100
Message-ID: <4F5F53CA.7090003@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 14:09:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7RTs-0005ii-1X
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab2CMNJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:09:31 -0400
Received: from luthien2.mpt.es ([213.9.211.102]:42632 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2CMNJb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:09:31 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id AA2DFB71F3;
	Tue, 13 Mar 2012 14:05:07 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id CE1E5D427D;
	Tue, 13 Mar 2012 14:05:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: AA2DFB71F3.BFEA7
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332248709.59792@BxB/XliJ2gzZX4Xk5EPM2w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193021>

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
index be88acb..e7410f8 100644
--- a/http.c
+++ b/http.c
@@ -44,6 +44,7 @@ static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static struct credential cre_url = CREDENTIAL_INIT;
 static struct credential http_auth = CREDENTIAL_INIT;
+static struct credential proxy_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
@@ -233,6 +234,20 @@ static int has_cert_password(void)
 	return 1;
 }
 
+static void set_proxy_auth(CURL *result)
+{
+	if (proxy_auth.username && proxy_auth.password) {
+#if LIBCURL_VERSION_NUM >= 0x071901
+		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME, proxy_auth.username);
+		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD, proxy_auth.password);
+#else
+		struct strbuf userpwd = STRBUF_INIT;
+		strbuf_addf(&userpwd, "%s:%s", proxy_auth.username, proxy_auth.password);
+		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, strbuf_detach(&userpwd, NULL));
+#endif
+	}
+}
+
 static CURL *get_curl_handle(const char *url)
 {
 	CURL *result = curl_easy_init();
@@ -317,8 +332,18 @@ static CURL *get_curl_handle(const char *url)
 		free(env_proxy_var);
 	}
 	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		if (!proxy_auth.host) /* check to parse only once */
+			credential_from_url(&proxy_auth, curl_http_proxy);
+
+		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
+			/* proxy string has username but no password, ask for password */
+			credential_fill(&proxy_auth);
+
+		struct strbuf proxyhost = STRBUF_INIT;
+		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
+		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+		set_proxy_auth(result);
 	}
 
 	return result;
-- 
1.7.7.6

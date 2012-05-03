From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 2/6] http: handle proxy proactive authentication
Date: Thu, 03 May 2012 18:39:54 +0200
Message-ID: <4FA2B4DA.60908@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 17:42:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPyBD-0004vu-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 17:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550Ab2ECPmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 11:42:51 -0400
Received: from luthien1.mpt.es ([82.150.0.102]:10923 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab2ECPmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 11:42:50 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 220E225C84C;
	Thu,  3 May 2012 17:42:40 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id F38B4D4DF4;
	Thu,  3 May 2012 17:42:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 220E225C84C.60304
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336664561.60269@O8s2snSCfDTRPEz9GbLvFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196912>

If http_proactive_auth flag is set and there is a username
but no password in the proxy url, then interactively ask for
the password.

This makes possible to not have the password written down in
http_proxy env var or in http.proxy config option.

Also take care that CURLOPT_PROXY don't include username or
password, as we now set them in the new set_proxy_auth() function
where we use their specific cURL options.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 64df7b1..02f9fcd 100644
--- a/http.c
+++ b/http.c
@@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static struct credential http_auth = CREDENTIAL_INIT;
+static struct credential proxy_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
@@ -272,6 +273,20 @@ static int has_cert_password(void)
 	return 1;
 }
 
+static void set_proxy_auth(CURL *result)
+{
+	if (proxy_auth.username && proxy_auth.password) {
+#if LIBCURL_VERSION_NUM >= 0x071301
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
@@ -351,8 +366,19 @@ static CURL *get_curl_handle(const char *url)
 	}
 	
 	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		struct strbuf proxyhost = STRBUF_INIT;
+
+		if (!proxy_auth.host) /* check to parse only once */
+			credential_from_url(&proxy_auth, curl_http_proxy);
+
+		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
+			/* proxy string has username but no password, ask for password */
+			credential_fill(&proxy_auth);
+
+		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
+		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+		set_proxy_auth(result);
 	}
 
 	return result;
-- 
1.7.7.6

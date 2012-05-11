From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 1/3] http: handle proxy authentication failure (error 407)
Date: Fri, 11 May 2012 15:13:40 +0200
Message-ID: <4FAD1084.4000605@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:16:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSom5-0001no-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab2EKMQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:16:40 -0400
Received: from luthien1.map.es ([213.9.211.102]:55979 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756211Ab2EKMQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:16:38 -0400
Received: from correo.map.es (unknown [10.1.31.68])
	by luthien2.map.es (Postfix) with ESMTP id 2FA3925C933;
	Fri, 11 May 2012 14:16:30 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 1286518000B;
	Fri, 11 May 2012 14:16:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 2FA3925C933.CC769
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1337343390.30001@2kPig/doqcxrMFwRFrdVOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197666>

Handle http 407 error code by asking for credentials and
retrying request in case credentials were not present, or
marking credentials as rejected if they were already provided.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 5cb87f1..624d1a0 100644
--- a/http.c
+++ b/http.c
@@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static struct credential http_auth = CREDENTIAL_INIT;
+static struct credential proxy_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
@@ -241,6 +242,20 @@ static int has_cert_password(void)
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
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -804,6 +819,15 @@ static int http_request(const char *url, void *result, int target, int options)
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
+		} else if (results.http_code == 407) { /* Proxy authentication failure */
+			if (proxy_auth.username && proxy_auth.password) {
+				credential_reject(&proxy_auth);
+				ret = HTTP_NOAUTH;
+			} else {
+				credential_fill(&proxy_auth);
+				set_proxy_auth(slot->curl);
+				ret = HTTP_REAUTH;
+			}
 		} else {
 			if (!curl_errorstr[0])
 				strlcpy(curl_errorstr,
-- 
1.7.7.6

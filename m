From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v2 3/3] http: when proxy url has username but no password,
 ask for password
Date: Thu, 01 Mar 2012 19:22:36 +0100
Message-ID: <4F4FBE6C.5050507@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 18:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39jg-0000BU-79
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab2CARYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 12:24:08 -0500
Received: from luthien2.mpt.es ([213.9.211.102]:53553 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab2CARYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 12:24:07 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 542BF24D16;
	Thu,  1 Mar 2012 18:24:00 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id C132A2C64F;
	Thu,  1 Mar 2012 18:23:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 542BF24D16.3A85D
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331227440.37052@LWI2XAyXJ8/HR4U19fuFrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191951>

Support proxy urls with username but without a password, in which
case we interactively ask for the password (using credential api).
This makes possible to not have the password written down in
http_proxy env var or in http.proxy config option.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 8932da5..5916194 100644
--- a/http.c
+++ b/http.c
@@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static struct credential http_auth = CREDENTIAL_INIT;
+static struct credential proxy_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
@@ -303,7 +304,20 @@ static CURL *get_curl_handle(void)
 		}
 	}
 	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		credential_from_url(&proxy_auth, curl_http_proxy);
+		if (proxy_auth.username != NULL && proxy_auth.password == NULL) {
+			/* proxy string has username but no password, ask for password */
+			struct strbuf pbuf = STRBUF_INIT;
+			credential_fill(&proxy_auth);
+			strbuf_addf(&pbuf, "%s://%s:%s@%s",proxy_auth.protocol,
+				    proxy_auth.username, proxy_auth.password,
+				    proxy_auth.host);
+			free ((void *)curl_http_proxy);
+			curl_http_proxy =  strbuf_detach(&pbuf, NULL);
+			curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		} else {
+			curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		}
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 	}
 
-- 
1.7.7.6

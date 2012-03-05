From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v3 3/4] http: handle proxy proactive authentication
Date: Mon, 05 Mar 2012 16:19:40 +0100
Message-ID: <4F54D98C.2070909@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 15:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Ymw-00065b-Ox
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab2CEOVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 09:21:17 -0500
Received: from luthien1.map.es ([82.150.0.102]:52104 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403Ab2CEOVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 09:21:17 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 84C9FB6CE3;
	Mon,  5 Mar 2012 15:21:04 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id A3D0F2C2CD;
	Mon,  5 Mar 2012 15:20:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 84C9FB6CE3.D7166
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331562064.73585@xxKMpdzZRmQTYw91bLEe7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192244>

If http_proactive_auth flag is set and there is a username
but no password in the proxy url, then interactively ask for
the password.

This makes possible to not have the password written down in
http_proxy env var or in http.proxy config option.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 8932da5..b0b4362 100644
--- a/http.c
+++ b/http.c
@@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static struct credential http_auth = CREDENTIAL_INIT;
+static struct credential proxy_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
@@ -303,6 +304,17 @@ static CURL *get_curl_handle(void)
 		}
 	}
 	if (curl_http_proxy) {
+		credential_from_url(&proxy_auth, curl_http_proxy);
+		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password) {
+			/* proxy string has username but no password, ask for password */
+			struct strbuf pbuf = STRBUF_INIT;
+			credential_fill(&proxy_auth);
+			strbuf_addf(&pbuf, "%s://%s:%s@%s",proxy_auth.protocol,
+			    	proxy_auth.username, proxy_auth.password,
+			    	proxy_auth.host);
+			free ((void *)curl_http_proxy);
+			curl_http_proxy =  strbuf_detach(&pbuf, NULL);
+		}
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 	}
-- 
1.7.7.6

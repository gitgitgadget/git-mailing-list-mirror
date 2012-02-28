From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 3/3] http: when proxy url has username but no password, ask
 for password
Date: Tue, 28 Feb 2012 13:56:29 +0100
Message-ID: <4F4CCEFD.90402@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net, sam.vilain@catalyst.net.nz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 12:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Lh3-0004eI-AI
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab2B1L6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 06:58:04 -0500
Received: from luthien1.map.es ([213.9.211.102]:16299 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314Ab2B1L6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:58:03 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 45F87F8732;
	Tue, 28 Feb 2012 12:57:55 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 83B752C364;
	Tue, 28 Feb 2012 12:57:47 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 45F87F8732.027C2
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331035076.1531@rLnsQEjvq9NGQ1UYXc+f1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191713>

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 79cbe50..68e3f7d 100644
--- a/http.c
+++ b/http.c
@@ -306,7 +306,41 @@ static CURL *get_curl_handle(void)
 		}
 	}
 	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		char *at, *colon, *proxyuser;
+		const char *cp;
+		cp = strstr(curl_http_proxy, "://");
+		if (cp == NULL) {
+			cp = curl_http_proxy;
+		} else {
+			cp += 3;
+		}
+		at = strchr(cp, '@');
+		colon = strchr(cp, ':');
+		if (at && (!colon || at < colon)) {
+			/* proxy string has username but no password, ask for password */
+			char *ask_str, *proxyuser, *proxypass;
+			int len;
+			struct strbuf pbuf = STRBUF_INIT;
+			len = at - cp;
+			proxyuser = xmalloc(len + 1);
+			memcpy(proxyuser, cp, len);
+			proxyuser[len] = '\0';
+			
+			strbuf_addf(&pbuf, "Enter password for proxy %s...", at+1);
+			ask_str = strbuf_detach(&pbuf, NULL);
+			proxypass = xstrdup(git_getpass(ask_str));
+			
+			strbuf_insert(&pbuf, 0, curl_http_proxy, cp - curl_http_proxy);
+			strbuf_addf(&pbuf, "%s:%s", proxyuser, proxypass);
+			strbuf_add(&pbuf, at, strlen(at));
+			curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&pbuf, NULL));
+			
+			free(ask_str);
+			free(proxyuser);
+			free(proxypass);
+		} else {
+			curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		}
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 	}
 
-- 
1.7.7.6

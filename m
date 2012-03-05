From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v3 4/4] http: handle proxy authentication failure (error 407)
Date: Mon, 05 Mar 2012 16:21:28 +0100
Message-ID: <4F54D9F8.2010401@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 15:23:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Yol-0007tV-67
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421Ab2CEOXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 09:23:10 -0500
Received: from luthien1.mpt.es ([213.9.211.102]:21896 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932327Ab2CEOXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 09:23:09 -0500
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id F0AD4B6FE8;
	Mon,  5 Mar 2012 15:22:51 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 618E8203815;
	Mon,  5 Mar 2012 15:22:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: F0AD4B6FE8.9A29A
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331562172.1628@KsC1NzCgi55GN89gSsnk0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192246>

Handle http 407 error code by asking for credentials and
retrying request in case credentials were not present, or
marking credentials as rejected if they were already provided.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index b0b4362..5fffa47 100644
--- a/http.c
+++ b/http.c
@@ -812,6 +812,22 @@ static int http_request(const char *url, void *result, int target, int options)
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
+		} else if (results.http_code == 407) { /* Proxy authentication failure */
+			if (proxy_auth.username && proxy_auth.password) {
+				credential_reject(&proxy_auth);
+				ret = HTTP_NOAUTH;
+			} else {
+				struct strbuf pbuf = STRBUF_INIT;
+				credential_from_url(&proxy_auth, curl_http_proxy);
+				credential_fill(&proxy_auth);
+				strbuf_addf(&pbuf, "%s://%s:%s@%s",proxy_auth.protocol,
+			    			proxy_auth.username, proxy_auth.password,
+			    			proxy_auth.host);
+				free ((void *)curl_http_proxy);
+				curl_http_proxy =  strbuf_detach(&pbuf, NULL);
+				curl_easy_setopt(slot->curl, CURLOPT_PROXY, curl_http_proxy);
+				ret = HTTP_REAUTH;
+			}
 		} else {
 			if (!curl_errorstr[0])
 				strlcpy(curl_errorstr,
-- 
1.7.7.6

From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 3/6] http: fix http_proxy specified without protocol part
Date: Thu, 03 May 2012 18:40:06 +0200
Message-ID: <4FA2B4E6.3080009@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 17:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPyBI-0004yB-TI
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 17:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562Ab2ECPm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 11:42:58 -0400
Received: from luthien2.map.es ([82.150.0.102]:64305 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab2ECPm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 11:42:57 -0400
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id 951A72578E;
	Thu,  3 May 2012 17:42:49 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 037CF203C22;
	Thu,  3 May 2012 17:42:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 951A72578E.1E40A
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336664569.73598@Zs4oqLw1Kv2wCXsBGhcb1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196913>

An earlier patch broke http_proxy specified as <host>:<port> by abusing
credential_from_url().  Teach the function to parse that format, but the
caller needs to be updated to handle the case where there is no protocol
in the parse result.

Also allow keyring implementations to differentiate authentication
material meant for http proxies and http destinations by using a
different token "http-proxy" to consult them for the former.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 credential.c |   12 ++++++++----
 http.c       |   13 ++++++++-----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/credential.c b/credential.c
index 62d1c56..813e3cf 100644
--- a/credential.c
+++ b/credential.c
@@ -324,11 +324,15 @@ void credential_from_url(struct credential *c, const char *url)
 	 *   (1) proto://<host>/...
 	 *   (2) proto://<user>@<host>/...
 	 *   (3) proto://<user>:<pass>@<host>/...
+	 * or "proto://"-less variants of the above. They are not technically
+	 * URLs, but the caller may have some context-specific knowledge about
+	 * what protocol is in use.
 	 */
 	proto_end = strstr(url, "://");
-	if (!proto_end)
-		return;
-	cp = proto_end + 3;
+	if (proto_end)
+		cp = proto_end + 3;
+	else
+		cp = url;
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
 	slash = strchrnul(cp, '/');
@@ -348,7 +352,7 @@ void credential_from_url(struct credential *c, const char *url)
 		host = at + 1;
 	}
 
-	if (proto_end - url > 0)
+	if (proto_end && proto_end != url)
 		c->protocol = xmemdupz(url, proto_end - url);
 	if (slash - host > 0)
 		c->host = url_decode_mem(host, slash - host);
diff --git a/http.c b/http.c
index 02f9fcd..22ffe0c 100644
--- a/http.c
+++ b/http.c
@@ -366,17 +366,20 @@ static CURL *get_curl_handle(const char *url)
 	}
 	
 	if (curl_http_proxy) {
-		struct strbuf proxyhost = STRBUF_INIT;
-
-		if (!proxy_auth.host) /* check to parse only once */
+		if (!proxy_auth.host) {
 			credential_from_url(&proxy_auth, curl_http_proxy);
+			if (!proxy_auth.protocol ||
+			    !strcmp(proxy_auth.protocol, "http")) {
+				free(proxy_auth.protocol);
+				proxy_auth.protocol = xstrdup("http-proxy");
+			}
+		}
 
 		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
 			/* proxy string has username but no password, ask for password */
 			credential_fill(&proxy_auth);
 
-		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
-		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));
+		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 		set_proxy_auth(result);
 	}
-- 
1.7.7.6

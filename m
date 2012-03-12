From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v4 3/5] http: handle proxy authentication failure (error 407)
Date: Mon, 12 Mar 2012 18:27:47 +0100
Message-ID: <4F5E3213.2040008@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 17:29:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S787o-0007Za-9h
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab2CLQ3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:29:21 -0400
Received: from luthien1.map.es ([213.9.211.102]:34609 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635Ab2CLQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:29:19 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 2B04725146;
	Mon, 12 Mar 2012 17:29:01 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 64843D4C57;
	Mon, 12 Mar 2012 17:28:56 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 2B04725146.1D3F2
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332174541.23571@Td3ZYgZ4sgJCSg2hmfiZ+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192896>

Handle http 407 error code by asking for credentials and
retrying request in case credentials were not present, or
marking credentials as rejected if they were already provided.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index dbdbc3f..14edf5a 100644
--- a/http.c
+++ b/http.c
@@ -825,6 +825,15 @@ static int http_request(const char *url, void *result, int target, int options)
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

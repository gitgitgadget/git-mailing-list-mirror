From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 4/6] http: handle proxy authentication failure (error 407)
Date: Thu, 03 May 2012 18:40:14 +0200
Message-ID: <4FA2B4EE.6010008@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 17:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPyBX-0005Bi-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 17:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab2ECPnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 11:43:10 -0400
Received: from luthien2.mpt.es ([82.150.0.102]:44849 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab2ECPnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 11:43:09 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 247F325741;
	Thu,  3 May 2012 17:43:00 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 46D952C3A9;
	Thu,  3 May 2012 17:42:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 247F325741.B414E
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336664581.56265@OvIuj0xqFOZf5q1DKnaOpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196914>

Handle http 407 error code by asking for credentials and
retrying request in case credentials were not present, or
marking credentials as rejected if they were already provided.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 22ffe0c..c87c66c 100644
--- a/http.c
+++ b/http.c
@@ -879,6 +879,15 @@ static int http_request(const char *url, void *result, int target, int options)
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

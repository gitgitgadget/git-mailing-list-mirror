From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v4 4/5] http: Avoid limit of retrying request only twice
Date: Mon, 12 Mar 2012 18:29:09 +0100
Message-ID: <4F5E3265.2030006@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 17:31:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S789a-000064-7r
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab2CLQbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:31:19 -0400
Received: from luthien1.map.es ([213.9.211.102]:65160 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab2CLQbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:31:17 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id F06C2B72E3;
	Mon, 12 Mar 2012 17:30:26 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 237D72C685;
	Mon, 12 Mar 2012 17:30:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: F06C2B72E3.4325B
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332174627.81497@tutk1Lvg1E/nLmNAKyinMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192899>

Current code, after receiving HTTP_REAUTH, only retried
once, so couldn't do step 3 of the following sequence:

  1. We make a request; proxy returns 407, because we didn't give it a
     password. We ask for the password and return HTTP_REAUTH.

  2. We make another request; the proxy passes it to the actual server,
     who returns 401, because we didn't give an http password. We ask
     for the password and return HTTP_REAUTH.

  3. We make a third request, but this time everybody is happy.

Now we retry as long as we keep receiving HTTP_REAUTH, so the previous
sequence correctly completes.

Patch by Jeff King <peff@peff.net>

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 14edf5a..9b98179 100644
--- a/http.c
+++ b/http.c
@@ -858,10 +858,13 @@ static int http_request(const char *url, void *result, int target, int options)
 static int http_request_reauth(const char *url, void *result, int target,
 			       int options)
 {
-	int ret = http_request(url, result, target, options);
-	if (ret != HTTP_REAUTH)
-		return ret;
-	return http_request(url, result, target, options);
+	int ret;
+
+	do {
+		ret = http_request(url, result, target, options);
+	} while (ret == HTTP_REAUTH);
+
+	return ret;
 }
 
 int http_get_strbuf(const char *url, struct strbuf *result, int options)
-- 
1.7.7.6

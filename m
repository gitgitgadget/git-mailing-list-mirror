From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v5 4/5] http: Avoid limit of retrying request only twice
Date: Tue, 13 Mar 2012 15:05:40 +0100
Message-ID: <4F5F5434.1070601@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 14:07:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7RRb-0004FG-LN
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab2CMNHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:07:11 -0400
Received: from luthien2.map.es ([213.9.211.102]:17835 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863Ab2CMNHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:07:09 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id C0ABDF875A;
	Tue, 13 Mar 2012 14:06:53 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 24A652C516;
	Tue, 13 Mar 2012 14:06:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: C0ABDF875A.945E5
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332248814.0222@wT3fOXuO2nSaVG3Y/xlxdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193019>


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
index d3d9d24..12dcaa1 100644
--- a/http.c
+++ b/http.c
@@ -872,10 +872,13 @@ static int http_request(const char *url, void *result, int target, int options)
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

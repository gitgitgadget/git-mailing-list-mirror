From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 2/3] http: Avoid limit of retrying request only twice
Date: Fri, 11 May 2012 15:13:54 +0200
Message-ID: <4FAD1092.2040805@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSonM-0002e6-Lz
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758138Ab2EKMR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:17:59 -0400
Received: from luthien1.map.es ([213.9.211.102]:40241 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758115Ab2EKMR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:17:58 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 4AE5825F1E;
	Fri, 11 May 2012 14:16:49 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 953932C6E6;
	Fri, 11 May 2012 14:16:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 4AE5825F1E.C7573
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1337343413.84764@4imIfSqDOaqccPpN1TLGdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197667>

From: Jeff King <peff@peff.net>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 624d1a0..d34d741 100644
--- a/http.c
+++ b/http.c
@@ -852,10 +852,13 @@ static int http_request(const char *url, void *result, int target, int options)
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

From: Jeff King <peff@peff.net>
Subject: [PATCH 2/9] http_request: factor out curlinfo_strbuf
Date: Sat, 28 Sep 2013 04:31:11 -0400
Message-ID: <20130928083111.GB2131@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpvr-0001zy-2a
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab3I1IbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:31:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:35133 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab3I1IbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:31:13 -0400
Received: (qmail 8597 invoked by uid 102); 28 Sep 2013 08:31:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:31:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:31:11 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235491>

When we retrieve the content-type of an http response, curl
gives us a pointer to internal storage, which we then copy
into a strbuf. Let's factor out the get-and-copy routine,
which can be used for getting other curl info.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index a985c40..d325669 100644
--- a/http.c
+++ b/http.c
@@ -837,6 +837,18 @@ int handle_curl_result(struct slot_results *results)
 	}
 }
 
+static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
+{
+	char *ptr;
+	CURLcode ret;
+
+	strbuf_reset(buf);
+	ret = curl_easy_getinfo(curl, info, &ptr);
+	if (!ret && ptr)
+		strbuf_addstr(buf, ptr);
+	return ret;
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -895,13 +907,8 @@ static int http_request(const char *url, struct strbuf *type,
 		ret = HTTP_START_FAILED;
 	}
 
-	if (type) {
-		char *t;
-		strbuf_reset(type);
-		curl_easy_getinfo(slot->curl, CURLINFO_CONTENT_TYPE, &t);
-		if (t)
-			strbuf_addstr(type, t);
-	}
+	if (type)
+		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, type);
 
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
-- 
1.8.4.rc3.19.g9da5bf6

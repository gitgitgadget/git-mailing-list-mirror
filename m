From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] http: use newer curl options for setting credentials
Date: Fri, 13 Apr 2012 02:19:25 -0400
Message-ID: <20120413061925.GB13690@sigill.intra.peff.net>
References: <20120413061622.GA27591@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 08:19:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIZr2-00032k-Ok
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 08:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab2DMGT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 02:19:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375Ab2DMGT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 02:19:28 -0400
Received: (qmail 4683 invoked by uid 107); 13 Apr 2012 06:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 02:19:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 02:19:25 -0400
Content-Disposition: inline
In-Reply-To: <20120413061622.GA27591@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195402>

We give the username and password to curl by sticking them
in a buffer of the form "user:pass" and handing the result
to CURLOPT_USERPWD. Since curl 7.19.1, there is a split
mechanism, where you can specify each element individually.

This has the advantage that a username can contain a ":"
character. It also is less code for us, since we can hand
our strings over to curl directly. And since curl 7.17.0 and
higher promise to copy the strings for us, we we don't even
have to worry about memory ownership issues.

Unfortunately, we have to keep the ugly code for old curl
around, but as it is now nicely #if'd out, we can easily get
rid of it when we decide that 7.19.1 is "old enough".

Signed-off-by: Jeff King <peff@peff.net>
---
For reference, 7.19.1 is from late 2008.

 http.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index eaf7f40..2ec3789 100644
--- a/http.c
+++ b/http.c
@@ -210,14 +210,23 @@ static int http_options(const char *var, const char *value, void *cb)
 
 static void init_curl_http_auth(CURL *result)
 {
-	if (http_auth.username) {
+	if (!http_auth.username)
+		return;
+
+	credential_fill(&http_auth);
+
+#if LIBCURL_VERSION_NUM >= 0x071301
+	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
+	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
+#else
+	{
 		static struct strbuf up = STRBUF_INIT;
-		credential_fill(&http_auth);
 		strbuf_reset(&up);
 		strbuf_addf(&up, "%s:%s",
 			    http_auth.username, http_auth.password);
 		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
 	}
+#endif
 }
 
 static int has_cert_password(void)
-- 
1.7.9.6.6.g6b3b56

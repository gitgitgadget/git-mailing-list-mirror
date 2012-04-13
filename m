From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] http: clean up leak in init_curl_http_auth
Date: Fri, 13 Apr 2012 02:18:35 -0400
Message-ID: <20120413061835.GA13690@sigill.intra.peff.net>
References: <20120413061622.GA27591@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 08:18:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIZqF-0002ZV-6l
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 08:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab2DMGSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 02:18:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32977
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab2DMGSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 02:18:38 -0400
Received: (qmail 4652 invoked by uid 107); 13 Apr 2012 06:18:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 02:18:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 02:18:35 -0400
Content-Disposition: inline
In-Reply-To: <20120413061622.GA27591@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195401>

When we have a credential to give to curl, we must copy it
into a "user:pass" buffer and then hand the buffer to curl.
Old versions of curl did not copy the buffer, and we were
expected to keep it valid. Newer versions of curl will copy
the buffer.

Our solution was to use a strbuf and detach it, giving
ownership of the resulting buffer to curl. However, this
meant that we were leaking the buffer on newer versions of
curl, since curl was just copying it and throwing away the
string we passed. Furthermore, when we replaced a
credential (e.g., because our original one was rejected), we
were also leaking on both old and new versions of curl.

This got even worse in the last patch, which started
replacing the credential (and thus leaking) on every http
request.

Instead, let's use a static buffer to make the ownership
more clear and less leaky.  We already keep a static "struct
credential", so we are only handling a single credential at
a time, anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
The "old" version was prior to 7.17.0, from 2007. That is probably still
new enough to care about. But at some point we should probably make a
sweep through http.c and get rid of conditional blocks for really old
cruft.

 http.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index c6dc9b7..eaf7f40 100644
--- a/http.c
+++ b/http.c
@@ -211,12 +211,12 @@ static int http_options(const char *var, const char *value, void *cb)
 static void init_curl_http_auth(CURL *result)
 {
 	if (http_auth.username) {
-		struct strbuf up = STRBUF_INIT;
+		static struct strbuf up = STRBUF_INIT;
 		credential_fill(&http_auth);
+		strbuf_reset(&up);
 		strbuf_addf(&up, "%s:%s",
 			    http_auth.username, http_auth.password);
-		curl_easy_setopt(result, CURLOPT_USERPWD,
-				 strbuf_detach(&up, NULL));
+		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
 	}
 }
 
-- 
1.7.9.6.6.g6b3b56

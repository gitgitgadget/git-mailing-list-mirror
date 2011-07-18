From: Jeff King <peff@peff.net>
Subject: [PATCH 04/14] remote-curl: don't retry auth failures with dumb
 protocol
Date: Mon, 18 Jul 2011 03:49:56 -0400
Message-ID: <20110718074956.GD12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiiaa-00048M-FY
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab1GRHt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:49:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50619
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1GRHt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:49:58 -0400
Received: (qmail 19773 invoked by uid 107); 18 Jul 2011 07:50:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:50:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:49:56 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177347>

When fetching an http URL, we first try fetching info/refs
with an extra "service" parameter. This will work for a
smart-http server, or a dumb server which ignores extra
parameters when fetching files. If that fails, we retry
without the extra parameter to remain compatible with dumb
servers which didn't like our first request.

If the server returned a "401 Unauthorized", indicating that
the credentials we provided were not good, there is not much
point in retrying. With the current code, we just waste an
extra round trip to the HTTP server before failing.

But as the http code becomes smarter about throwing away
rejected credentials and re-prompting the user for new ones
(which it will later in this series), this will become more
confusing. At some point we will stop asking for credentials
to retry smart http, and will be asking for credentials to
retry dumb http. So now we're not only wasting an extra HTTP
round trip for something that is unlikely to work, but we're
making the user re-type their password for it.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index b5be25c..42b02af 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -115,7 +115,7 @@ static struct discovery* discover_refs(const char *service)
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
 
 	/* try again with "plain" url (no ? or & appended) */
-	if (http_ret != HTTP_OK) {
+	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
 		free(refs_url);
 		strbuf_reset(&buffer);
 
-- 
1.7.6.rc1.12.g65e2

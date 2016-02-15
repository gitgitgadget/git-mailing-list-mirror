From: Jeff King <peff@peff.net>
Subject: [PATCH 15/18] transport_anonymize_url: use xstrfmt
Date: Mon, 15 Feb 2016 16:56:48 -0500
Message-ID: <20160215215648.GO10287@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:56:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR8Y-0004PB-Ii
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbcBOV4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:56:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:42515 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbcBOV4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:56:50 -0500
Received: (qmail 2763 invoked by uid 102); 15 Feb 2016 21:56:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:56:50 -0500
Received: (qmail 12616 invoked by uid 107); 15 Feb 2016 21:56:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:56:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:56:48 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286271>

This function uses xcalloc and two memcpy calls to
concatenate two strings. We can do this as an xstrfmt
one-liner, and then it is more clear that we are allocating
the correct amount of memory.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/transport.c b/transport.c
index 5c63295..d53e4aa 100644
--- a/transport.c
+++ b/transport.c
@@ -1351,7 +1351,7 @@ int transport_disconnect(struct transport *transport)
  */
 char *transport_anonymize_url(const char *url)
 {
-	char *anon_url, *scheme_prefix, *anon_part;
+	char *scheme_prefix, *anon_part;
 	size_t anon_len, prefix_len = 0;
 
 	anon_part = strchr(url, '@');
@@ -1385,10 +1385,8 @@ char *transport_anonymize_url(const char *url)
 			goto literal_copy;
 		prefix_len = scheme_prefix - url + 3;
 	}
-	anon_url = xcalloc(1, 1 + prefix_len + anon_len);
-	memcpy(anon_url, url, prefix_len);
-	memcpy(anon_url + prefix_len, anon_part, anon_len);
-	return anon_url;
+	return xstrfmt("%.*s%.*s", (int)prefix_len, url,
+		       (int)anon_len, anon_part);
 literal_copy:
 	return xstrdup(url);
 }
-- 
2.7.1.572.gf718037

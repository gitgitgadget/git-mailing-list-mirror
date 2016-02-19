From: Jeff King <peff@peff.net>
Subject: [PATCH 18/21] transport_anonymize_url: use xstrfmt
Date: Fri, 19 Feb 2016 06:25:18 -0500
Message-ID: <20160219112518.GR9319@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 12:25:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjBh-000638-VV
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427693AbcBSLZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:25:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:45305 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1427682AbcBSLZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:25:21 -0500
Received: (qmail 20657 invoked by uid 102); 19 Feb 2016 11:25:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:25:21 -0500
Received: (qmail 26804 invoked by uid 107); 19 Feb 2016 11:25:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:25:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 06:25:18 -0500
Content-Disposition: inline
In-Reply-To: <20160219111941.GA31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286703>

This function uses xcalloc and two memcpy calls to
concatenate two strings. We can do this as an xstrfmt
one-liner, and then it is more clear that we are allocating
the correct amount of memory.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/transport.c b/transport.c
index 3b4e644..ac857a9 100644
--- a/transport.c
+++ b/transport.c
@@ -1021,7 +1021,7 @@ int transport_disconnect(struct transport *transport)
  */
 char *transport_anonymize_url(const char *url)
 {
-	char *anon_url, *scheme_prefix, *anon_part;
+	char *scheme_prefix, *anon_part;
 	size_t anon_len, prefix_len = 0;
 
 	anon_part = strchr(url, '@');
@@ -1055,10 +1055,8 @@ char *transport_anonymize_url(const char *url)
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
2.7.1.577.gfed91b8

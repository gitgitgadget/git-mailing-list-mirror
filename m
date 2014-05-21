From: Jeff King <peff@peff.net>
Subject: [PATCH 4/9] http: normalize case of returned content-type
Date: Wed, 21 May 2014 06:29:17 -0400
Message-ID: <20140521102917.GD30464@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:29:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3lz-0008Ji-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbaEUK3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:29:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:56410 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751411AbaEUK3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:29:19 -0400
Received: (qmail 32491 invoked by uid 102); 21 May 2014 10:29:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:29:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:29:17 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249784>

The content-type string curl hands us comes straight from
the server, and may have odd capitalization. RFC 2616 states
that content-types are case-insensitive. We already handle
this when checking for text/plain (by using strcasecmp), but
do not when checking for a smart-http content-type.

We could simply convert the latter to use strcasecmp, but as
we add more parsing of the header, having it normalized will
simplify our parsing code.

Note that there is one caveat. RFC 2616 notes that the type
itself is case insensitive, as are parameter names. However,
parameter valuse may be case-sensitive, depending on the
individual parameter. In practice, we are OK, though. We
currently only look at the type itself. In the future we
will start looking at charset parameters, but those are also
case-insensitive. And it doesn't seem likely that we would
look at any other parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is fine. If not, we can either:

  1. Use strcasecmp and friends more consistently when
     parsing/comparing (later bits of the series will need to be
     adjusted).

  2. Downcase here in a more context-aware way.

 http.c        | 4 +++-
 remote-curl.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 94e1afd..cd6c328 100644
--- a/http.c
+++ b/http.c
@@ -957,9 +957,11 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
-	if (options && options->content_type)
+	if (options && options->content_type) {
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE,
 				options->content_type);
+		strbuf_tolower(options->content_type);
+	}
 
 	if (options && options->effective_url)
 		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
diff --git a/remote-curl.c b/remote-curl.c
index 52c2d96..a5ab977 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -205,7 +205,7 @@ static int show_http_message(struct strbuf *type, struct strbuf *msg)
 	 * TODO should handle "; charset=XXX", and re-encode into
 	 * logoutputencoding
 	 */
-	if (strcasecmp(type->buf, "text/plain"))
+	if (strcmp(type->buf, "text/plain"))
 		return -1;
 
 	strbuf_trim(msg);
-- 
2.0.0.rc1.436.g03cb729

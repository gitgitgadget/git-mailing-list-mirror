From: Jeff King <peff@peff.net>
Subject: [PATCH v2 8/8] http: default text charset to iso-8859-1
Date: Thu, 22 May 2014 05:36:12 -0400
Message-ID: <20140522093612.GH15032@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:36:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPQA-0004Km-JS
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbaEVJgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:36:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:57262 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751796AbaEVJgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:36:14 -0400
Received: (qmail 12056 invoked by uid 102); 22 May 2014 09:36:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:36:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:36:12 -0400
Content-Disposition: inline
In-Reply-To: <20140522092824.GA14530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249893>

This is specified by RFC 2616 as the default if no "charset"
parameter is given.

Signed-off-by: Jeff King <peff@peff.net>
---
I'd prefer to do this simple, standard thing, and see how it works in
the real world. We'll hand whatever we get off to iconv, and if it
chokes, we'll pass through the data as-is. That should be enough for
most ascii messages to make it through readable, even if we get the
encoding wrong.

If we do want to do magic like "latin1 is really iso-8859-1", that seems
like the domain of iconv to me. If iconv doesn't handle it itself, I'd
rather have a wrapper there. Putting it at that layer keeps the code
cleaner, and it means the wrapper would benefit the regular commit-log
reencoding code.

If anybody wants to go further in that direction, be my guest, but please
make your suggestions in the form of patches which apply on top. :)

 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http.c b/http.c
index e26ee8b..a37e84e 100644
--- a/http.c
+++ b/http.c
@@ -972,6 +972,9 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		while (*p && !isspace(*p))
 			p++;
 	}
+
+	if (!charset->len && starts_with(type->buf, "text/"))
+		strbuf_addstr(charset, "ISO-8859-1");
 }
 
 /* http_request() targets */
-- 
2.0.0.rc1.436.g03cb729

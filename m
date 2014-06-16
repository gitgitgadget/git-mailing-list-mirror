From: Jeff King <peff@peff.net>
Subject: [PATCH] pretty: avoid reading past end-of-string with "%G"
Date: Mon, 16 Jun 2014 16:13:11 -0400
Message-ID: <20140616201311.GA26829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdHK-0002X2-FC
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbaFPUNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:13:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:45478 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755298AbaFPUNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:13:13 -0400
Received: (qmail 14041 invoked by uid 102); 16 Jun 2014 20:13:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 15:13:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 16:13:11 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251815>

If the user asks for --format=%G with nothing else, we
correctly realize that "%G" is not a valid placeholder (it
should be "%G?", "%GK", etc). But we still tell the
strbuf_expand code that we consumed 2 characters, causing it
to jump over the trailing NUL and output garbage.

This also fixes the case where "%GX" would be consumed (and
produce no output). In other cases, we pass unrecognized
placeholders through to the final string.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed while experimenting with "%G" placeholders in the nearby thread.

It doesn't look like we have any tests of "%G*" and friends at all. :(

 pretty.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pretty.c b/pretty.c
index e1e2cad..70d8776 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1267,6 +1267,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (c->signature_check.key)
 				strbuf_addstr(sb, c->signature_check.key);
 			break;
+		default:
+			return 0;
 		}
 		return 2;
 	}
-- 
2.0.0.566.gfe3e6b2

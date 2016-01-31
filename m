From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] checkout-index: disallow "--no-stage" option
Date: Sun, 31 Jan 2016 06:30:30 -0500
Message-ID: <20160131113029.GE5116@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:30:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqDF-0001cm-Ao
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343AbcAaLad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:30:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:35061 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757328AbcAaLac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:30:32 -0500
Received: (qmail 7479 invoked by uid 102); 31 Jan 2016 11:30:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:30:33 -0500
Received: (qmail 15735 invoked by uid 107); 31 Jan 2016 11:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:30:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:30:30 -0500
Content-Disposition: inline
In-Reply-To: <20160131112215.GA4589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285139>

We do not really expect people to use "--no-stage", but if
they do, git currently segfaults. We could instead have it
undo the effects of a previous "--stage", but this gets
tricky around the "to_tempfile" flag. We cannot simply reset
it to 0, because we don't know if it was set by a previous
"--stage=all" or an explicit "--temp" option.

We could solve this by setting a flag and resolving
to_tempfile later, but it's not worth the effort. Nobody
actually wants to use "--no-stage"; we are just trying to
fix a potential segfault here.

While we're in the area adding a translated string, let's
mark the other possible error message in this function as
translatable.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index f8179a7..7a9b561 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -133,6 +133,8 @@ static struct lock_file lock_file;
 static int option_parse_stage(const struct option *opt,
 			      const char *arg, int unset)
 {
+	if (unset)
+		return error(_("--stage cannot be negated"));
 	if (!strcmp(arg, "all")) {
 		to_tempfile = 1;
 		checkout_stage = CHECKOUT_ALL;
@@ -141,7 +143,7 @@ static int option_parse_stage(const struct option *opt,
 		if ('1' <= ch && ch <= '3')
 			checkout_stage = arg[0] - '0';
 		else
-			die("stage should be between 1 and 3 or all");
+			die(_("stage should be between 1 and 3 or all"));
 	}
 	return 0;
 }
-- 
2.7.0.489.g6faad84

From: Jeff King <peff@peff.net>
Subject: [PATCH 28/68] fetch: replace static buffer with xstrfmt
Date: Thu, 24 Sep 2015 17:07:07 -0400
Message-ID: <20150924210707.GY30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:10:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDmC-0004AY-P6
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbbIXVHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:35966 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752930AbbIXVHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:09 -0400
Received: (qmail 11958 invoked by uid 102); 24 Sep 2015 21:07:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:09 -0500
Received: (qmail 29218 invoked by uid 107); 24 Sep 2015 21:07:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:07 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278624>

We parse the INFINITE_DEPTH constant into a static,
fixed-size buffer using sprintf. This buffer is sufficiently
large for the current constant, but it's a suspicious
pattern, as the constant is defined far away, and it's not
immediately obvious that 12 bytes are large enough to hold
it.

We can just use xstrfmt here, which gets rid of any question
of the buffer size. It also removes any concerns with object
lifetime, which means we do not have to wonder why this
buffer deep within a conditional is marked "static" (we
never free our newly allocated result, of course, but that's
OK; it's global that lasts the lifetime of the whole program
anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9a3869f..4703725 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1156,11 +1156,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			die(_("--depth and --unshallow cannot be used together"));
 		else if (!is_repository_shallow())
 			die(_("--unshallow on a complete repository does not make sense"));
-		else {
-			static char inf_depth[12];
-			sprintf(inf_depth, "%d", INFINITE_DEPTH);
-			depth = inf_depth;
-		}
+		else
+			depth = xstrfmt("%d", INFINITE_DEPTH);
 	}
 
 	/* no need to be strict, transport_set_option() will validate it again */
-- 
2.6.0.rc3.454.g204ad51

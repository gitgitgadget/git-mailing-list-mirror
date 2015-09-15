From: Jeff King <peff@peff.net>
Subject: [PATCH 28/67] fetch: replace static buffer with xstrfmt
Date: Tue, 15 Sep 2015 11:46:31 -0400
Message-ID: <20150915154631.GB29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:46:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsRM-0000Al-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbbIOPqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:46:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:59352 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754428AbbIOPqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:46:33 -0400
Received: (qmail 12253 invoked by uid 102); 15 Sep 2015 15:46:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:46:33 -0500
Received: (qmail 7276 invoked by uid 107); 15 Sep 2015 15:46:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:46:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:46:31 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277930>

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
2.6.0.rc2.408.ga2926b9

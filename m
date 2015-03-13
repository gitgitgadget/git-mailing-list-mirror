From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] upload-pack: do not check NULL return of
 lookup_unknown_object
Date: Fri, 13 Mar 2015 00:42:25 -0400
Message-ID: <20150313044224.GB18532@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHQd-0000z5-SM
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbbCMEm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:42:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:60812 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751039AbbCMEm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:42:27 -0400
Received: (qmail 30456 invoked by uid 102); 13 Mar 2015 04:42:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:42:27 -0500
Received: (qmail 9493 invoked by uid 107); 13 Mar 2015 04:42:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:42:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:42:25 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265393>

We check whether the return value of lookup_unknown_object
is NULL, but some code paths dereference it before our
check. This turns out not to be capable of causing a
segfault, though. The lookup_unknown_object function will
never return NULL, since the whole point is to allocate an
object struct if it does not find an existing one. So the
code here is not wrong, it is just confusing. Let's just
drop the NULL check.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index c8e8713..aa84576 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -689,8 +689,6 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1)
 		o->flags |= HIDDEN_REF;
 		return 1;
 	}
-	if (!o)
-		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 	o->flags |= OUR_REF;
 	return 0;
 }
-- 
2.3.2.472.geadab3c

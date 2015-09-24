From: Jeff King <peff@peff.net>
Subject: [PATCH 13/68] test-dump-cache-tree: avoid overflow of cache-tree name
Date: Thu, 24 Sep 2015 17:06:03 -0400
Message-ID: <20150924210603.GJ30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDiX-0000bI-4I
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbbIXVGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:06:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:35927 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754263AbbIXVGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:06:05 -0400
Received: (qmail 11845 invoked by uid 102); 24 Sep 2015 21:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:06:05 -0500
Received: (qmail 28999 invoked by uid 107); 24 Sep 2015 21:06:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:06:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:06:03 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278569>

When dumping a cache-tree, we sprintf sub-tree names directly
into a fixed-size buffer, which can overflow. We can
trivially fix this by converting to xsnprintf to at least
notice and die.

This probably should handle arbitrary-sized names, but
there's not much point. It's used only by the test scripts,
so the trivial fix is enough.

Signed-off-by: Jeff King <peff@peff.net>
---
 test-dump-cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 54c0872..bb53c0a 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -47,7 +47,7 @@ static int dump_cache_tree(struct cache_tree *it,
 		struct cache_tree_sub *rdwn;
 
 		rdwn = cache_tree_sub(ref, down->name);
-		sprintf(path, "%s%.*s/", pfx, down->namelen, down->name);
+		xsnprintf(path, sizeof(path), "%s%.*s/", pfx, down->namelen, down->name);
 		if (dump_cache_tree(down->cache_tree, rdwn->cache_tree, path))
 			errs = 1;
 	}
-- 
2.6.0.rc3.454.g204ad51

From: Jeff King <peff@peff.net>
Subject: [PATCH 13/67] test-dump-cache-tree: avoid overflow of cache-tree name
Date: Tue, 15 Sep 2015 11:30:24 -0400
Message-ID: <20150915153023.GM29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsBk-0006Hf-Ab
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbbIOPa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:30:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:59303 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752545AbbIOPa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:30:26 -0400
Received: (qmail 11418 invoked by uid 102); 15 Sep 2015 15:30:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:30:26 -0500
Received: (qmail 6972 invoked by uid 107); 15 Sep 2015 15:30:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:30:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:30:24 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277914>

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
2.6.0.rc2.408.ga2926b9

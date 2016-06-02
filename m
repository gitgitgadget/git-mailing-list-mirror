From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] rev-list: disable bitmaps when "-n" is used with listing
 objects
Date: Thu, 2 Jun 2016 19:10:49 -0400
Message-ID: <20160602231049.GB11247@sigill.intra.peff.net>
References: <20160602230925.GA11196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 01:10:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8blQ-0005d4-G8
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017AbcFBXKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:10:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:48114 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932090AbcFBXKw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:10:52 -0400
Received: (qmail 9386 invoked by uid 102); 2 Jun 2016 23:10:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:10:52 -0400
Received: (qmail 15358 invoked by uid 107); 2 Jun 2016 23:10:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:10:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 19:10:49 -0400
Content-Disposition: inline
In-Reply-To: <20160602230925.GA11196@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296257>

You can ask rev-list to use bitmaps to speed up an --objects
traversal, which should generally give you your answers much
faster.

Likewise, you can ask rev-list to limit such a traversal
with `-n`, in which case we'll show only a limited set of
commits (and only the tree and commit objects directly
reachable from those commits).

But if you do both together, the results are nonsensical. We
end up limiting any fallback traversal we do to _find_ the
bitmaps, but the actual set of objects we output will be
picked arbitrarily from the union of any bitmaps we do find,
and will involve the objects of many more commits.

It's possible that somebody might want this as a "show me
what you can, but limit the amount of work you do" flag.
But as with the prior commit clamping "--count", the results
are basically non-deterministic; you'll get the values from
some commits between `n` and the total number, and you can't
tell which.

And unlike the `--count` case, we can't easily generate the
"real" value from the bitmap values (you can't just walk
back `-n` commits and subtract out the reachable objects
from the boundary commits; the bitmaps for `X` record its
total reachability, so you don't know which objects are
directly from `X` itself, which from `X^`, and so on).

So let's just fallback to the non-bitmap code path in this
case, so we always give a sane answer.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index aaa79a3..9fb6608 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -365,7 +365,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 				printf("%d\n", commit_count);
 				return 0;
 			}
-		} else if (revs.tag_objects && revs.tree_objects && revs.blob_objects) {
+		} else if (!revs.max_count &&
+			   revs.tag_objects && revs.tree_objects && revs.blob_objects) {
 			if (!prepare_bitmap_walk(&revs)) {
 				traverse_bitmap_commit_list(&show_object_fast);
 				return 0;
-- 
2.9.0.rc1.132.g33c7f30

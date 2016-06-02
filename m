From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] rev-list: "adjust" results of "--count
 --use-bitmap-index -n"
Date: Thu, 2 Jun 2016 19:10:31 -0400
Message-ID: <20160602231031.GA11247@sigill.intra.peff.net>
References: <20160602230925.GA11196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 01:10:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bl9-0005Ky-4c
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbcFBXKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:10:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:48110 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932090AbcFBXKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:10:34 -0400
Received: (qmail 9377 invoked by uid 102); 2 Jun 2016 23:10:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:10:34 -0400
Received: (qmail 15334 invoked by uid 107); 2 Jun 2016 23:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:10:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 19:10:31 -0400
Content-Disposition: inline
In-Reply-To: <20160602230925.GA11196@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296256>

If you ask rev-list for:

    git rev-list --count --use-bitmap-index HEAD

we optimize out the actual traversal and just give you the
number of bits set in the commit bitmap. This is faster,
which is good.

But if you ask to limit the size of the traversal, like:

    git rev-list --count --use-bitmap-index -n 100 HEAD

we'll still output the full bitmapped number we found. On
the surface, that might even seem OK. You explicitly asked
to use the bitmap index, and it was cheap to compute the
real answer, so we gave it to you.

But there's something much more complicated going on under
the hood. If we don't have a bitmap directly for HEAD, then
we have to actually traverse backwards, looking for a
bitmapped commit. And _that_ traversal is bounded by our
`-n` count.

This is a good thing, because it bounds the work we have to
do, which is probably what the user wanted by asking for
`-n`. But now it makes the output quite confusing. You might
get many values:

  - your `-n` value, if we walked back and never found a
    bitmap (or fewer if there weren't that many commits)

  - the actual full count, if we found a bitmap root for
    every path of our traversal with in the `-n` limit

  - any number in between! We might have walked back and
    found _some_ bitmaps, but then cut off the traversal
    early with some commits not accounted for in the result.

So you cannot even see a value higher than your `-n` and say
"OK, bitmaps kicked in, this must be the real full count".
The only sane thing is for git to just clamp the value to a
maximum of the `-n` value, which means we should output the
exact same results whether bitmaps are in use or not.

The test in t5310 demonstrates this by using `-n 1`.
Without this patch we fail in the full-bitmap case (where we
do not have to traverse at all) but _not_ in the
partial-bitmap case (where we have to walk down to find an
actual bitmap). With this patch, both cases just work.

I didn't implement the crazy in-between case, just because
it's complicated to set up, and is really a subset of the
full-count case, which we do cover.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c      | 2 ++
 t/t5310-pack-bitmaps.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 275da0d..aaa79a3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -360,6 +360,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			uint32_t commit_count;
 			if (!prepare_bitmap_walk(&revs)) {
 				count_bitmap_commit_list(&commit_count, NULL, NULL, NULL);
+				if (revs.max_count && revs.max_count < commit_count)
+					commit_count = revs.max_count;
 				printf("%d\n", commit_count);
 				return 0;
 			}
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index d446706..3893afd 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -47,6 +47,12 @@ rev_list_tests() {
 		test_cmp expect actual
 	'
 
+	test_expect_success "counting commits with limit ($state)" '
+		git rev-list --count -n 1 HEAD >expect &&
+		git rev-list --use-bitmap-index --count -n 1 HEAD >actual &&
+		test_cmp expect actual
+	'
+
 	test_expect_success "counting non-linear history ($state)" '
 		git rev-list --count other...master >expect &&
 		git rev-list --use-bitmap-index --count other...master >actual &&
-- 
2.9.0.rc1.132.g33c7f30

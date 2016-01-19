From: Jeff King <peff@peff.net>
Subject: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 16:51:00 -0500
Message-ID: <20160119215100.GB28656@sigill.intra.peff.net>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:51:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLeBA-0001D0-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbcASVvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:51:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:56487 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932252AbcASVvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:51:03 -0500
Received: (qmail 10568 invoked by uid 102); 19 Jan 2016 21:51:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 16:51:03 -0500
Received: (qmail 27047 invoked by uid 107); 19 Jan 2016 21:51:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 16:51:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 16:51:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284384>

On Tue, Jan 19, 2016 at 01:46:35PM -0800, Junio C Hamano wrote:

> > It _is_ slower, though, because it introduces an extra rev-parse. When
> > we could in fact be getting rid of one. Give me a moment to complete a
> > few timing tests and post the results.
> 
> Good point.
> 
> We should do that rev-parse in the helper function.  That rev-parse
> is there only because the skip-empty code wants to know the exact
> object name when comparing.  There is no reason for this code to do
> it for the helper--the helper, if (and only if) it is called, can
> do the rev-parse itself, and we can still omit the overhead when
> we are not skipping empty ones.

Here's the patch I came up with. It takes the conservative choice (see
the argument below), and shows the performance impact. I'll work up the
non-conservative one on top, which I think can do even better than the
original.

-- >8 --
Subject: filter-branch: resolve $commit^{tree} in no-index case

Commit 348d4f2 (filter-branch: skip index read/write when
possible, 2015-11-06) taught filter-branch to optimize out
the final "git write-tree" when we know we haven't touched
the tree with any of our filters. It does by simply putting
the literal text "$commit^{tree}" into the "$tree" variable,
avoiding a useless rev-parse call.

However, when we pass this to git_commit_non_empty_tree(),
it gets confused; it resolves "$commit^{tree}" itself, and
compares our string to the 40-hex sha1, which obviously
doesn't match. As a result, "--prune-empty" (or any custom
filter using git_commit_non_empty_tree) will fail to drop
an empty commit (when filter-branch is used without a tree
or index filter).

Let's resolve $tree to the 40-hex ourselves, so that
git_commit_non_empty_tree can work. Unfortunately, this is a
bit slower due to the extra process overhead:

  $ cd t/perf && ./run 348d4f2 HEAD p7000-filter-branch.sh
  [...]
  Test                  348d4f2           HEAD
  --------------------------------------------------------------
  7000.2: noop filter   3.76(0.24+0.26)   4.54(0.28+0.24) +20.7%

However, the value of $tree here is technically
user-visible. The user can provide arbitrary shell code at
this stage, which could itself have a similar assumption to
what is in git_commit_non_empty_tree. So the conservative
choice to fix this regression is to take the 20% hit and
give the pre-348d4f2 behavior. We still end up much faster
than before the optimization:

  $ cd t/perf && ./run 348d4f2^ HEAD p7000-filter-branch.sh
  [...]
  Test                  348d4f2^          HEAD
  --------------------------------------------------------------
  7000.2: noop filter   9.51(4.32+0.40)   4.51(0.28+0.23) -52.6%

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh     | 2 +-
 t/t7003-filter-branch.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index d61f9ba..5e094ce 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -404,7 +404,7 @@ while read commit parents; do
 	then
 		tree=$(git write-tree)
 	else
-		tree="$commit^{tree}"
+		tree=$(git rev-parse "$commit^{tree}")
 	fi
 	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		"$tree" $parentstr < ../message > ../map/$commit ||
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 377c648..97c23c2 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -333,6 +333,14 @@ test_expect_success 'prune empty collapsed merges' '
 	test_cmp expect actual
 '
 
+test_expect_success 'prune empty works even without index/tree filters' '
+	git rev-list HEAD >expect &&
+	git commit --allow-empty -m empty &&
+	git filter-branch -f --prune-empty HEAD &&
+	git rev-list HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--remap-to-ancestor with filename filters' '
 	git checkout master &&
 	git reset --hard A &&
-- 
2.7.0.248.g5eafd77

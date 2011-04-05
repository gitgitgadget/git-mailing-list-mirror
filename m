From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 2/2] stash: drop dirty worktree check on apply
Date: Tue, 5 Apr 2011 17:23:15 -0400
Message-ID: <20110405212314.GA3613@sigill.intra.peff.net>
References: <20110405212025.GA3579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Brian Lopez <brian@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 23:26:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Dlq-0001TV-HX
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975Ab1DEVXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:23:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44450
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754430Ab1DEVXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:23:18 -0400
Received: (qmail 28683 invoked by uid 107); 5 Apr 2011 21:24:03 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 17:24:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 17:23:15 -0400
Content-Disposition: inline
In-Reply-To: <20110405212025.GA3579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170919>

Before we apply a stash, we make sure there are no changes
in the worktree that are not in the index. This check dates
back to the original git-stash.sh, and is presumably
intended to prevent changes in the working tree from being
accidentally lost during the merge.

However, this check has two problems:

  1. It is overly restrictive. If my stash changes only file
     "foo", but "bar" is dirty in the working tree, it will
     prevent us from applying the stash.

  2. It is redundant. We don't touch the working tree at all
     until we actually call merge-recursive. But it has its
     own (much more accurate) checks to avoid losing working
     tree data, and will abort the merge with a nicer
     message telling us which paths were problems.

So we can simply drop the check entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
As with any time we loosen a safety valve, I am worried that I'm missing
a case where it is still doing something useful. Thus the RFC tag on
this patch.

I'm not sure if the check was perhaps even required when git-stash was
written, and has simply since become useless as merge-recursive became
more careful.

 git-stash.sh     |    4 +---
 t/t3903-stash.sh |   16 ++++++++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index a5b1dc3..07ac323 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -334,9 +334,7 @@ apply_stash () {
 
 	assert_stash_like "$@"
 
-	git update-index -q --refresh &&
-	git diff-files --quiet --ignore-submodules ||
-		die 'Cannot apply to a dirty working tree, please stage your changes'
+	git update-index -q --refresh || die 'unable to refresh index'
 
 	# current index state
 	c_tree=$(git write-tree) ||
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 11077f0..966bc46 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -43,14 +43,26 @@ test_expect_success 'applying bogus stash does nothing' '
 	test_cmp expect file
 '
 
-test_expect_success 'apply needs clean working directory' '
+test_expect_success 'apply does not need clean working directory' '
 	echo 4 > other-file &&
 	git add other-file &&
 	echo 5 > other-file &&
-	test_must_fail git stash apply
+	git stash apply &&
+	echo 3 >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'apply does not clobber working directory changes' '
+	git reset --hard &&
+	echo 4 >file &&
+	test_must_fail git stash apply &&
+	echo 4 >expect &&
+	test_cmp expect file
 '
 
 test_expect_success 'apply stashed changes' '
+	git reset --hard &&
+	echo 5 >other-file &&
 	git add other-file &&
 	test_tick &&
 	git commit -m other-file &&
-- 
1.7.4.3.13.g0b769.dirty

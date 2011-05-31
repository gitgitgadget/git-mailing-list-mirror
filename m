From: Jeff King <peff@peff.net>
Subject: Re: diff: --quiet does not imply --exit-code if --diff-filter is
 present
Date: Tue, 31 May 2011 11:33:56 -0400
Message-ID: <20110531153356.GB2594@sigill.intra.peff.net>
References: <87wrh7jgzk.wl@dns1.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Tue May 31 17:34:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRQxK-0004CF-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 17:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060Ab1EaPd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 11:33:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56613
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab1EaPd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 11:33:59 -0400
Received: (qmail 25571 invoked by uid 107); 31 May 2011 15:34:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 May 2011 11:34:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2011 11:33:56 -0400
Content-Disposition: inline
In-Reply-To: <87wrh7jgzk.wl@dns1.atmark-techno.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174805>

On Tue, May 31, 2011 at 07:34:39PM +0900, Yasushi SHOJI wrote:

> just noticed that quiet does not return exit code when I set
> diff-filter.  at the current tip (v1.7.5.3-401-gfb674d7):
> 
>   git diff --quiet     --diff-filter=A v1.7.5 v1.7.5.1 -- t  #=> 0
>   git diff --exit-code --diff-filter=A v1.7.5 v1.7.5.1 -- t  #=> 1
> 
> these two line returns different exit code.
> 
> is this a bug or a feature?

It's a bug.

-- >8 --
Subject: [PATCH] diff_tree: disable QUICK optimization with diff filter

We stop looking for changes early with QUICK, so our diff
queue contains only a subset of the changes. However, we
don't apply diff filters until later; it will appear at that
point as though there are no changes matching our filter,
when in reality we simply didn't keep looking for changes
long enough.

Commit 2cfe8a6 (diff --quiet: disable optimization when
--diff-filter=X is used, 2011-03-16) fixes this in some
cases by disabling the optimization when a filter is
present. However, it only tweaked run_diff_files, missing
the similar case in diff_tree. Thus the fix worked only for
diffing the working tree and index, but not between trees.

Noticed by Yasushi SHOJI.

Signed-off-by: Jeff King <peff@peff.net>
---
Grepping around, I think this was the only other missed case.

 t/t4040-whitespace-status.sh |    5 +++++
 tree-diff.c                  |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t4040-whitespace-status.sh b/t/t4040-whitespace-status.sh
index abc4934..3c728a3 100755
--- a/t/t4040-whitespace-status.sh
+++ b/t/t4040-whitespace-status.sh
@@ -67,4 +67,9 @@ test_expect_success 'diff-files --diff-filter --quiet' '
 	test_must_fail git diff-files --diff-filter=M --quiet
 '
 
+test_expect_success 'diff-tree --diff-filter --quiet' '
+	git commit -a -m "worktree state" &&
+	test_must_fail git diff-tree --diff-filter=M --quiet HEAD^ HEAD
+'
+
 test_done
diff --git a/tree-diff.c b/tree-diff.c
index 7a79660..3d08f78 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -143,6 +143,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 
 	for (;;) {
 		if (DIFF_OPT_TST(opt, QUICK) &&
+		    !opt->filter &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->pathspec.nr) {
-- 
1.7.5.3.7.g7dde6.dirty

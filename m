From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 17:28:02 -0500
Message-ID: <20160119222802.GC6556@sigill.intra.peff.net>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
 <20160119215928.GA6556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:28:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLel1-0006SW-9X
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 23:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326AbcASW2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 17:28:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:56519 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933070AbcASW2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 17:28:05 -0500
Received: (qmail 13162 invoked by uid 102); 19 Jan 2016 22:28:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 17:28:05 -0500
Received: (qmail 27367 invoked by uid 107); 19 Jan 2016 22:28:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 17:28:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 17:28:02 -0500
Content-Disposition: inline
In-Reply-To: <20160119215928.GA6556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284389>

On Tue, Jan 19, 2016 at 04:59:28PM -0500, Jeff King wrote:

> We could get away "git diff --exit-code $1 $2" to do a single process
> invocation (rather than two rev-parses), but I don't know if it is worth
> the complexity.

And here's that patch.

I'm actually a little iffy on it because it switches to "diff-tree" from
a raw-sha1 comparison. For a well-formed repo, that shouldn't matter.
But what if you had a commit that was replacing a malformed tree object,
but not otherwise changing the diff?  We might drop it as "empty", even
though you'd prefer to keep it.

I guess some alternative ways of doing the same thing are:

  1. Use "git rev-parse $1 $3^{tree}", parse the output and compare.
     Surprisingly tedious to do in a shell without invoking any extra
     sub-processes.

  2. When we do the initial rev-list, output the tree, too. Then we get
     the old tree sha1 for "free" (no extra process, but at the cost of
     slightly more I/O by the shell).

I suspect we could also cache the tree of the parent and avoid the
rev-parse in git_commit_non_empty_tree(), too.

I dunno. I'm inclined to say that none of this is worth it to try to
drop one or two processes. Writing filter-branch in a better language
(or just using BFG) would probably be a more productive use of time.
20% looks like a lot, but that's because it's pretty fast in the first
place.  The timings I showed earlier (and below) are for git.git, which
is not that huge. But the savings from 348d4f2 are really about avoiding
looking at the trees entirely; the bigger your tree, the more you save.
Running it on linux.git should show that we're still reclaiming most of
the original optimization.

So I'm inclined to go with the "conservative" fix I sent initially, and
drop this micro-optimization.

-- >8 --
Subject: [PATCH] filter-branch: optimize out rev-parse for unchanged tree

The prior commit noticed that we started feeding
"$commit^{tree}" to git_commit_non_empty_tree instead of its
resolved 40-hex sha1. It made the conservative fix of
resolving and passing the 40-hex sha1, even though it does
add some overhead.

This patch takes the less conservative choice, under the
assumption that we are unlikely to break anybody's
commit-filter by showing them the unresolved name
"$commit^{tree}" (which is probably the case, because most
people would end their filter with "git commit-tree" or
"git_commit_non_empty_tree").

We can make the comparison in the latter function more
clever by using "diff-tree --quiet", which will compare the
two trees with only a single process invocation.

Here are the resulting numbers from p7000:

  Test                  348d4f2^          348d4f2                  HEAD^                    HEAD
  ----------------------------------------------------------------------------------------------------------------
  7000.2: noop filter   9.48(4.29+0.41)   3.73(0.22+0.26) -60.7%   4.56(0.27+0.26) -51.9%   3.74(0.25+0.25) -60.5%

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5e094ce..d1879e3 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -44,7 +44,7 @@ skip_commit()
 # it will skip commits that leave the tree untouched, commit the other.
 git_commit_non_empty_tree()
 {
-	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
+	if test $# = 3 && git diff-tree --quiet "$1" "$3"; then
 		map "$3"
 	else
 		git commit-tree "$@"
@@ -404,7 +404,7 @@ while read commit parents; do
 	then
 		tree=$(git write-tree)
 	else
-		tree=$(git rev-parse "$commit^{tree}")
+		tree="$commit^{tree}"
 	fi
 	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		"$tree" $parentstr < ../message > ../map/$commit ||
-- 
2.7.0.248.g5eafd77

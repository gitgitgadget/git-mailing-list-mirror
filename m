From: Jeff King <peff@peff.net>
Subject: [PATCH] filter-branch: skip index read/write when possible
Date: Fri, 6 Nov 2015 01:24:29 -0500
Message-ID: <20151106062429.GA24442@sigill.intra.peff.net>
References: <1bf03e2146ceb5bb36b81f1ce64354b0.squirrel@clueserver.org>
 <20151106001832.GB9963@sigill.intra.peff.net>
 <20151106002048.GC9963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: alan@clueserver.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 07:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuaRy-0000eK-Gq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 07:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbbKFGYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 01:24:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:53856 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751539AbbKFGYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 01:24:32 -0500
Received: (qmail 1968 invoked by uid 102); 6 Nov 2015 06:24:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Nov 2015 00:24:32 -0600
Received: (qmail 22626 invoked by uid 107); 6 Nov 2015 06:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Nov 2015 01:24:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Nov 2015 01:24:29 -0500
Content-Disposition: inline
In-Reply-To: <20151106002048.GC9963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280961>

On Thu, Nov 05, 2015 at 07:20:48PM -0500, Jeff King wrote:

> Here's a totally untested patch that seems to make a filter-branch like
> this on the kernel orders of magnitude faster:

Testing shows that it is indeed broken. :)

If $filter_subdir is set, it handles the index read itself, but my
earlier patch did not correctly do the write.

This one should work for all cases (unless the user does something
really strange, like expect to manipulate the index inside the
--env-filter or something, but IMHO it is insane for anyone to rely on
that working).

-- >8 --
Subject: filter-branch: skip index read/write when possible

If the user specifies an index filter but not a tree filter,
filter-branch cleverly avoids checking out the tree
entirely. But we don't do the next level of optimization: if
you have no index or tree filter, we do not need to read the
index at all.

This can greatly speed up cases where we are only changing
the commit objects (e.g., cementing a graft into place).
Here are numbers from the newly-added perf test:

  Test                  HEAD^              HEAD
  ---------------------------------------------------------------
  7000.2: noop filter   13.81(4.95+0.83)   5.43(0.42+0.43) -60.7%

Signed-off-by: Jeff King <peff@peff.net>
---
Those numbers are from git.git. The bigger your tree, the better the
speedup (I didn't run the perf test, because even the span of
HEAD~100..HEAD takes tens of minutes for each trial with the old code.
With the new it's less than 30 seconds).

 git-filter-branch.sh          | 23 +++++++++++++++++++++--
 t/perf/p7000-filter-branch.sh | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100755 t/perf/p7000-filter-branch.sh

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 27c9c54..d61f9ba 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -306,6 +306,15 @@ then
 	start_timestamp=$(date '+%s')
 fi
 
+if test -n "$filter_index" ||
+   test -n "$filter_tree" ||
+   test -n "$filter_subdir"
+then
+	need_index=t
+else
+	need_index=
+fi
+
 while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
 
@@ -313,7 +322,10 @@ while read commit parents; do
 
 	case "$filter_subdir" in
 	"")
-		GIT_ALLOW_NULL_SHA1=1 git read-tree -i -m $commit
+		if test -n "$need_index"
+		then
+			GIT_ALLOW_NULL_SHA1=1 git read-tree -i -m $commit
+		fi
 		;;
 	*)
 		# The commit may not have the subdirectory at all
@@ -387,8 +399,15 @@ while read commit parents; do
 	} <../commit |
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
+
+	if test -n "$need_index"
+	then
+		tree=$(git write-tree)
+	else
+		tree="$commit^{tree}"
+	fi
 	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
-		$(git write-tree) $parentstr < ../message > ../map/$commit ||
+		"$tree" $parentstr < ../message > ../map/$commit ||
 			die "could not write rewritten commit"
 done <../revs
 
diff --git a/t/perf/p7000-filter-branch.sh b/t/perf/p7000-filter-branch.sh
new file mode 100755
index 0000000..15ee5d1
--- /dev/null
+++ b/t/perf/p7000-filter-branch.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='performance of filter-branch'
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+test_expect_success 'mark bases for tests' '
+	git tag -f tip &&
+	git tag -f base HEAD~100
+'
+
+test_perf 'noop filter' '
+	git checkout --detach tip &&
+	git filter-branch -f base..HEAD
+'
+
+test_done
-- 
2.6.2.711.g30c79de

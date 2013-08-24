From: Jeff King <peff@peff.net>
Subject: [PATCH] write_index: optionally allow broken null sha1s
Date: Fri, 23 Aug 2013 21:33:11 -0400
Message-ID: <20130824013310.GA9343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 03:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD2jH-0000P6-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 03:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab3HXBdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 21:33:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:42098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617Ab3HXBdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 21:33:13 -0400
Received: (qmail 2308 invoked by uid 102); 24 Aug 2013 01:33:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 20:33:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 21:33:11 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232856>

Commit 4337b58 (do not write null sha1s to on-disk index,
2012-07-28) unconditionally prevents git from writing null
sha1s into the index. The intent was to catch errors in
other parts of the code that might let such an entry slip
into the index (or worse, a tree).

However, some repositories have history in which the trees
contain entries with null sha1s. Because the restriction is
unconditional, it can be difficult to work with these older
histories (for example, you cannot even check out the
history, because you are forbidden to write the broken
index). Worst of all, you cannot use git-filter-branch's
index-filter to repair such a broken history, because
filter-branch will try to write an index for each tree.

We could potentially work around this by using a
commit-filter, and munging the tree manually. However,
filter-branch unconditionally writes the index, even if we
only asked for a commit-filter, so this doesn't work. That
would be possible to fix, but figuring out that a
commit-filter is needed (and what it should contain) is
somewhat non-intuitive.

Instead, let's introduce an environment variable for
relaxing this check, and use it when checking out the index
in filter-branch. We turn it on by default, so users do not
have to learn any special tricks to perform such a
filter-branch. But we only do so for the index check-out, so
any further manipulations the user does will fail unless
they remove the broken entry.

We cannot catch every case, though, since some filter-branch
invocations might not rewrite the index at all. But we still
print a loud warning, so it is unlikely to go unnoticed by
the user.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to not involve filter-branch in this commit at all, and
instead require the user to manually invoke

  GIT_ALLOW_NULL_SHA1=1 git filter-branch ...

to perform such a filter.  That would be slightly safer, but requires
some specialized knowledge from the user (and advice on using
filter-branch to remove such entries already exists on places like
stackoverflow, and this patch makes it Just Work on recent versions of
git).

 git-filter-branch.sh               |  5 ++--
 read-cache.c                       | 13 +++++++--
 t/t7009-filter-branch-null-sha1.sh | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100755 t/t7009-filter-branch-null-sha1.sh

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ac2a005..98e8fe4 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -283,11 +283,12 @@ while read commit parents; do
 
 	case "$filter_subdir" in
 	"")
-		git read-tree -i -m $commit
+		GIT_ALLOW_NULL_SHA1=1 git read-tree -i -m $commit
 		;;
 	*)
 		# The commit may not have the subdirectory at all
-		err=$(git read-tree -i -m $commit:"$filter_subdir" 2>&1) || {
+		err=$(GIT_ALLOW_NULL_SHA1=1 \
+		      git read-tree -i -m $commit:"$filter_subdir" 2>&1) || {
 			if ! git rev-parse -q --verify $commit:"$filter_subdir"
 			then
 				rm -f "$GIT_INDEX_FILE"
diff --git a/read-cache.c b/read-cache.c
index c3d5e35..83a7414 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1817,8 +1817,17 @@ int write_index(struct index_state *istate, int newfd)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
-		if (is_null_sha1(ce->sha1))
-			return error("cache entry has null sha1: %s", ce->name);
+		if (is_null_sha1(ce->sha1)) {
+			static const char msg[] = "cache entry has null sha1: %s";
+			static int allow = -1;
+
+			if (allow < 0)
+				allow = git_env_bool("GIT_ALLOW_NULL_SHA1", 0);
+			if (allow)
+				warning(msg, ce->name);
+			else
+				return error(msg, ce->name);
+		}
 		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
 			return -1;
 	}
diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7009-filter-branch-null-sha1.sh
new file mode 100755
index 0000000..2944ac9
--- /dev/null
+++ b/t/t7009-filter-branch-null-sha1.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='filter-branch removal of trees with null sha1'
+. ./test-lib.sh
+
+test_expect_success 'create base commits' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three
+'
+
+test_expect_success 'create a commit with a bogus null sha1 in the tree' '
+	test_tick &&
+	tree=$(
+		{
+			git ls-tree HEAD &&
+			printf "160000 commit $_z40\\tbroken"
+		} | git mktree
+	) &&
+	commit=$(
+		echo "add broken entry" |
+		git commit-tree $tree -p HEAD
+	) &&
+	git update-ref HEAD $commit
+'
+
+# we have to make one more commit on top removing the broken
+# entry, since otherwise our index does not match HEAD (and filter-branch will
+# complain). We could make the index match HEAD, but doing so would involve
+# writing a null sha1 into the index.
+test_expect_success 'create a commit dropping the broken entry' '
+	test_tick &&
+	git commit -a -m "back to normal"
+'
+
+test_expect_success 'filter commands are still checked' '
+	test_must_fail git filter-branch \
+		--force --prune-empty \
+		--index-filter "git rm --cached --ignore-unmatch three.t"
+'
+
+test_expect_success 'removing the broken entry works' '
+	git filter-branch \
+		--force --prune-empty \
+		--index-filter "git rm --cached --ignore-unmatch broken"
+'
+
+test_expect_success 'resulting history is clean' '
+	echo three >expect &&
+	git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.4.rc2.28.g6bb5f3f

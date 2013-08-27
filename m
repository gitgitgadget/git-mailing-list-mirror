From: Jeff King <peff@peff.net>
Subject: [PATCHv3] write_index: optionally allow broken null sha1s
Date: Tue, 27 Aug 2013 16:41:12 -0400
Message-ID: <20130827204112.GA19451@sigill.intra.peff.net>
References: <20130824013310.GA9343@sigill.intra.peff.net>
 <20130825061500.GR2882@elie.Belkin>
 <20130825095818.GA12556@sigill.intra.peff.net>
 <20130825195412.GA2752@elie.Belkin>
 <20130826142704.GA14858@sigill.intra.peff.net>
 <20130826173501.GS4110@google.com>
 <20130826212053.GA25452@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 22:41:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEQ4o-0002gg-Df
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 22:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab3H0UlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 16:41:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:49312 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab3H0UlP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 16:41:15 -0400
Received: (qmail 3913 invoked by uid 102); 27 Aug 2013 20:41:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Aug 2013 15:41:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Aug 2013 16:41:12 -0400
Content-Disposition: inline
In-Reply-To: <20130826212053.GA25452@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233158>

On Mon, Aug 26, 2013 at 05:20:53PM -0400, Jeff King wrote:

> And by your rule above, the advice would be "each of these tests
> should say "setup" in the description". That makes sense to me, and I
> don't mind doing it here.
>
> [...]
>
> I totally missed your original point, then. I don't mind combining the
> last two into a single test. That makes sense to me (I only split them
> at all because I added the second one much later during the
> development).

So here is a re-roll with:

  1. The commit message tweaks you suggested

  2. Annotating the setup tests by using the word "setup"

  3. Combining the final two tests to filter and check the result.

I also added your Reviewed-by, since you gave it for the previous
version, and all of the changes are taking your suggestions. :)

-- >8 --
Subject: write_index: optionally allow broken null sha1s

Commit 4337b58 (do not write null sha1s to on-disk index,
2012-07-28) added a safety check preventing git from writing
null sha1s into the index. The intent was to catch errors in
other parts of the code that might let such an entry slip
into the index (or worse, a tree).

Some existing repositories may have invalid trees that
contain null sha1s already, though.  Until 4337b58, a common
way to clean this up would be to use git-filter-branch's
index-filter to repair such broken entries.  That now fails
when filter-branch tries to write out the index.

Introduce a GIT_ALLOW_NULL_SHA1 environment variable to
relax this check and make it easier to recover from such a
history.

It is tempting to not involve filter-branch in this commit
at all, and instead require the user to manually invoke

	GIT_ALLOW_NULL_SHA1=1 git filter-branch ...

to perform an index-filter on a history with trees with null
sha1s.  That would be slightly safer, but requires some
specialized knowledge from the user.  So let's set the
GIT_ALLOW_NULL_SHA1 variable automatically when checking out
the to-be-filtered trees.  Advice on using filter-branch to
remove such entries already exists on places like
stackoverflow, and this patch makes it Just Work again on
recent versions of git.

Further commands that touch the index will still notice and
fail, unless they actually remove the broken entries.  A
filter-branch whose filters do not touch the index at all
will not error out (since we complain of the null sha1 only
on writing, not when making a tree out of the index), but
this is acceptable, as we still print a loud warning, so the
problem is unlikely to go unnoticed.

Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-filter-branch.sh               |  5 ++--
 read-cache.c                       | 13 ++++++++--
 t/t7009-filter-branch-null-sha1.sh | 49 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)
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
index 0000000..a997f7a
--- /dev/null
+++ b/t/t7009-filter-branch-null-sha1.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='filter-branch removal of trees with null sha1'
+. ./test-lib.sh
+
+test_expect_success 'setup: base commits' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three
+'
+
+test_expect_success 'setup: a commit with a bogus null sha1 in the tree' '
+	{
+		git ls-tree HEAD &&
+		printf "160000 commit $_z40\\tbroken\\n"
+	} >broken-tree
+	echo "add broken entry" >msg &&
+
+	tree=$(git mktree <broken-tree) &&
+	test_tick &&
+	commit=$(git commit-tree $tree -p HEAD <msg) &&
+	git update-ref HEAD "$commit"
+'
+
+# we have to make one more commit on top removing the broken
+# entry, since otherwise our index does not match HEAD (and filter-branch will
+# complain). We could make the index match HEAD, but doing so would involve
+# writing a null sha1 into the index.
+test_expect_success 'setup: bring HEAD and index in sync' '
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
+	echo three >expect &&
+	git filter-branch \
+		--force --prune-empty \
+		--index-filter "git rm --cached --ignore-unmatch broken" &&
+	git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.4.2.g87d4a77

From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git bug: moved file with local unstaged changes are lost during
 merge
Date: Sun, 29 Apr 2012 16:17:58 +0200
Message-ID: <20120429141758.GA6500@ecki.lan>
References: <CAAZnV3Einocd4TJ0iqcxPJNsr44j3RwhczS9OhyURX0faGWgBQ@mail.gmail.com>
 <CAAZnV3EwZ6kminW7D3ssn_Rtj2SsMHd++VCx7w14K5rQKba4_g@mail.gmail.com>
 <20120413064941.GC27214@sigill.intra.peff.net>
 <20120414231515.GB18137@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Angell <joe.d.angell@gmail.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 16:18:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOUx1-0003TP-3J
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 16:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab2D2OSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 10:18:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:34752 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab2D2OSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 10:18:04 -0400
Received: from [127.0.0.1] (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id AB2F0CDF82;
	Sun, 29 Apr 2012 16:18:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120414231515.GB18137@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196510>

On Sun, Apr 15, 2012 at 01:15:17AM +0200, Clemens Buchacher wrote:
> --- a/t/t7607-merge-overwrite.sh
> +++ b/t/t7607-merge-overwrite.sh
> @@ -92,6 +92,15 @@ test_expect_success 'will not overwrite removed file with staged changes' '
>  	test_cmp important c1.c
>  '
>  
> +test_expect_failure 'will not overwrite unstaged changes in renamed file' '
> +	git reset --hard c1 &&
> +	git mv c1.c other.c &&
> +	git commit -m rename &&
> +	cp important other.c &&
> +	git merge c1a &&
> +	test_cmp important other.c
> +'

I have looked into this today, and we have a situation that is very
similar to c5ab03f2 (merge-recursive: do not clobber untracked working
tree garbage). The only difference being that the rename was made in our
branch, instead of the other. However, this does make it very difficult.

As you know, we have a fundamental issue in the way we protect untracked
or modified files from changes. Roughly, the procedure is as follows:

1. merge_trees -> threeway_merge

Go through each index entry and try to merge it.  Depending on the
outcome, do one of the following:

 a) If the entry has conflicts, or if it merges cleanly but the result
    is different from HEAD, check that index and work tree are not
    dirty, so that we can checkout the result of the merge without
    overwriting anything. Otherwise abort.

 b) If the entry has no changes, or if it merges cleanly and the result
    is the same as HEAD (or if it does not exist in HEAD), remove the
    CE_UPDATE flag from the entry so that we do not overwrite changes in
    the index or work tree, if any.

2. merge_trees -> process_entry

Find possible rename pairs and try to merge renames. Due to the renames,
entries that were classified as b) above can now become of type a).

If the rename was in the other branch, the entry is new and was
categorized as b). Now we realize it's a modified rename, and it should
have been categorized as a) above.  Untracked files used to be
overridden here. But c5ab03f2 added a last minute safety valve, which
checks that a renamed entry either exists in HEAD, or does not exist in
the work tree. This catches at least the typical case.

If the rename was in our branch, the situation is slightly different.
The entry exists in HEAD, but it is still categorized as b). Due to the
modified rename, we later decide to update the work tree after all.  In
this case, the safety valve above does not help, because the entry was
tracked, but at this point it is too late to tell if the entry was
up-to-date. And so it is overwritten.

One possible fix is to abort in case of trivial merges that would have
been classified as b) above. The reationale is that we have to assume
that the entry could get modified due to a rename later. But that breaks
many test cases where we currently assume that it is ok to have a dirty
work tree during trivial merges. (I did not run all tests.)

Maybe we should disable merging with a dirty work tree altogether, until
we have a solution that is safe to use?

Clemens

-->8--
Subject: [PATCH] trivial merge: always verify that working tree is clean

Even if the index and the merge result match at this stage, if the entry
turns out to be a renamed file, it may still be modified. Make sure that
the work tree is up-to-date, in order to avoid overwriting data.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t1000-read-tree-m-3way.sh |   14 +++++++-------
 t/t1004-read-tree-m-u-wf.sh |    2 +-
 t/t3903-stash.sh            |    2 +-
 t/t7607-merge-overwrite.sh  |    4 ++--
 unpack-trees.c              |    5 +++--
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index babcdd2..eb03339 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -222,7 +222,7 @@ test_expect_success \
      git update-index --add NA &&
      read_tree_must_succeed -m $tree_O $tree_A $tree_B"
 
-test_expect_success \
+test_expect_failure \
     '2 - matching B alone is OK in !O && !A && B case.' \
     "rm -f .git/index NA &&
      cp .orig-B/NA NA &&
@@ -238,7 +238,7 @@ test_expect_success \
      read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_success \
+test_expect_failure \
     '3 - matching A alone is OK in !O && A && !B case.' \
     "rm -f .git/index AN &&
      cp .orig-A/AN AN &&
@@ -289,7 +289,7 @@ test_expect_success \
      read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_success \
+test_expect_failure \
     '5 - must match in !O && A && B && A==B case.' \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
@@ -417,7 +417,7 @@ test_expect_success \
      read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_success \
+test_expect_failure \
     '12 - must match A in O && A && B && O!=A && A==B case' \
     "rm -f .git/index SS &&
      cp .orig-A/SS SS &&
@@ -443,7 +443,7 @@ test_expect_success \
      read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_success \
+test_expect_failure \
     '13 - must match A in O && A && B && O!=A && O==B case' \
     "rm -f .git/index MN &&
      cp .orig-A/MN MN &&
@@ -460,7 +460,7 @@ test_expect_success \
      read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_success \
+test_expect_failure \
     '14 - may match B in O && A && B && O==A && O!=B case' \
     "rm -f .git/index NM &&
      cp .orig-B/NM NM &&
@@ -495,7 +495,7 @@ test_expect_success \
      read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_success \
+test_expect_failure \
     '15 - must match A in O && A && B && O==A && O==B case' \
     "rm -f .git/index NN &&
      cp .orig-A/NN NN &&
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index b3ae7d5..5002af2 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -130,7 +130,7 @@ test_expect_success '3-way not overwriting local changes (setup)' '
 
 '
 
-test_expect_success '3-way not overwriting local changes (our side)' '
+test_expect_failure '3-way not overwriting local changes (our side)' '
 
 	# At this point, file1 from side-a should be kept as side-b
 	# did not touch it.
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3addb80..5f54c30 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -43,7 +43,7 @@ test_expect_success 'applying bogus stash does nothing' '
 	test_cmp expect file
 '
 
-test_expect_success 'apply does not need clean working directory' '
+test_expect_failure 'apply does not need clean working directory' '
 	echo 4 >other-file &&
 	git add other-file &&
 	echo 5 >other-file &&
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 6547eb8..72f84b8 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -92,12 +92,12 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	test_cmp important c1.c
 '
 
-test_expect_failure 'will not overwrite unstaged changes in renamed file' '
+test_expect_success 'will not overwrite unstaged changes in renamed file' '
 	git reset --hard c1 &&
 	git mv c1.c other.c &&
 	git commit -m rename &&
 	cp important other.c &&
-	git merge c1a &&
+	test_must_fail git merge c1a &&
 	test_cmp important other.c
 '
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 36523da..dcaef43 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1480,6 +1480,9 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 			return -1;
 		invalidate_ce_path(merge, o);
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
+		if (verify_uptodate(old, o))
+			return -1;
+
 		/*
 		 * See if we can re-use the old CE directly?
 		 * That way we get the uptodate stat info.
@@ -1491,8 +1494,6 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 			copy_cache_entry(merge, old);
 			update = 0;
 		} else {
-			if (verify_uptodate(old, o))
-				return -1;
 			/* Migrate old flags over */
 			update |= old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
 			invalidate_ce_path(old, o);
-- 
1.7.10

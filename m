From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH/RFC] Revert "filter-branch: subdirectory filter needs --full-history"
Date: Mon, 26 May 2008 21:09:18 +0200
Message-ID: <200805262109.19015.johannes.sixt@telecom.at>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com> <200805251426.54755.johannes.sixt@telecom.at> <alpine.LFD.1.10.0805251359290.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Tweed <david.tweed@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 26 21:10:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0i5G-0006Th-Qr
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 21:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbYEZTJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 15:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbYEZTJW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 15:09:22 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:36796 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbYEZTJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 15:09:21 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 7A64DBEED3;
	Mon, 26 May 2008 21:09:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4448064465;
	Mon, 26 May 2008 21:09:19 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0805251359290.3081@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82946>

This reverts commit cfabd6eee1745cfec58cfcb794ce8847e43b888a. I had
implemented it without understanding what --full-history does. Consider
this history:

    C--M--N
   /  /  /
  A--B  /
   \   /
    D-/

where B and C modify a path, X, in the same way so that the result is
identical, and D does not modify it at all. With the path limiter X and
without --full-history this is simplified to

   A--B

i.e. only one of the paths via B or C is chosen. I had assumed that
--full-history would keep both paths like this

    C--M
   /  /
  A--B

removing the path via D; but in fact it keeps the entire history.

Currently, git does not have the capability to simplify to this
intermediary case. However, the other extreme to keep the entire history
is not wanted either in usual cases. I think we can expect that histories
like the above are rare, and in the usual cases we want a simplified
history. So let's remove --full-history again.

(Concerning t7003, subsequent tests depend on what the test case sets up,
so we can't just back out the entire test case.)

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

On Sunday 25 May 2008 23:23, Linus Torvalds wrote:
> On Sun, 25 May 2008, Johannes Sixt wrote:
> > The history was this:
> >
> >    C--M
> >   /  /
> >  A--B
> >
> > Now assume that both B and C change a, but so that it is identical in
> > both B and C. I thought that --full-history makes a difference *only* for
> > this case, because without --full-history the revision walk would choose
> > either B or C (not quite at random, but in an unspecified manner), but
> > not both; but with --full-history the revision walk would go both paths.
>
> You mis-understood what --full history does.

Yes, indeed. Thank you for your explanations. I'm not prepared to dive into
the revision walk manchinery, so I instead propose to just remove
--full-history from git-filter-branch.

-- Hannes

 git-filter-branch.sh     |    2 +-
 t/t7003-filter-branch.sh |   13 ++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 80e99e5..d04c346 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -234,7 +234,7 @@ case "$filter_subdir" in
 	;;
 *)
 	git rev-list --reverse --topo-order --default HEAD \
-		--parents --full-history "$@" -- "$filter_subdir"
+		--parents "$@" -- "$filter_subdir"
 esac > ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 1639c7a..3577aa6 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -97,7 +97,7 @@ test_expect_success 'subdirectory filter result looks okay' '
 	test_must_fail git show sub:subdir
 '
 
-test_expect_success 'setup and filter history that requires --full-history' '
+test_expect_success 'more setup' '
 	git checkout master &&
 	mkdir subdir &&
 	echo A > subdir/new &&
@@ -107,16 +107,7 @@ test_expect_success 'setup and filter history that requires --full-history' '
 	git rm a &&
 	test_tick &&
 	git commit -m "again subdir on master" &&
-	git merge branch &&
-	git branch sub-master &&
-	git-filter-branch -f --subdirectory-filter subdir sub-master
-'
-
-test_expect_success 'subdirectory filter result looks okay' '
-	test 3 = $(git rev-list -1 --parents sub-master | wc -w) &&
-	git show sub-master^:new &&
-	git show sub-master^2:new &&
-	test_must_fail git show sub:subdir
+	git merge branch
 '
 
 test_expect_success 'use index-filter to move into a subdirectory' '
-- 
1.5.6.rc0.17.gbc20

From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Wed, 06 Jun 2007 09:43:41 +0200
Organization: eudaptics software gmbh
Message-ID: <466665AD.CF5B85DF@eudaptics.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
	  <Pine.LNX.4.64.0706041711500.4046@racer.site> <46643F2D.7C896CBC@eudaptics.com>
	 <Pine.LNX.4.64.0706041850350.4046@racer.site> <46650A58.4934C07C@eudaptics.com> <Pine.LNX.4.64.0706051537360.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvqAs-00014h-BC
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXFFHmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbXFFHmf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:42:35 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:23421 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbXFFHme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:42:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HvqA2-00007T-PE; Wed, 06 Jun 2007 09:42:31 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7942D54D; Wed,  6 Jun 2007 09:42:30 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.040
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49256>

Johannes Schindelin wrote:
> Okay, then. Are you okay with keeping the same options? (See proposed
> patch below.)

I can live with it. But what do you think of this in addtion? It
replaces -k, -r, -s in favor of rev-list arguments.

> Just out of curiousity, do you have any timing data?

I did one test run through 8118 commits which took 18 minutes. But it
turns out that I have a buglet here in git-commit-tree, which would
not accept committer dates before 2000-1-1 00:00:01 UTC, but since the
first commit is from 1999, this test rewrote the entire history, which
was not intended.

--- 8< ---
From: Johannes Sixt <johannes.sixt@telecom.at>

filter-branch: Use rev-list arguments to specify revision ranges.

A subset of commits in a branch used to be specified by options (-k, -r)
as well as the branch tip itself (-s). It is more natural (for git users)
to specify revision ranges like 'master..next' instead. This makes it so.
If no range is specified it defaults to 'HEAD'.

As a consequence, the new name of the filtered branch must be the first
non-option argument. All remaining arguments are passed to 'git rev-list'
unmodified.

The tip of the branch that gets filtered is implied: It is the first
commit that git rev-list would print for the specified range.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-filter-branch.sh     |   39 ++++++++++++---------------------------
 t/t7003-filter-branch.sh |    2 +-
 2 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 9e12a6c..190a492 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -42,15 +42,6 @@
 #	does this in the '.git-rewrite/' directory but you can override
 #	that choice by this parameter.
 #
-# -r STARTREV:: The commit id to start the rewrite at
-#	Normally, the command will rewrite the entire history. If you
-#	pass this argument, though, this will be the first commit it
-#	will rewrite and keep the previous commits intact.
-#
-# -k KEEPREV:: A commit id until which _not_ to rewrite history
-#	If you pass this argument, this commit and all of its
-#	predecessors are kept intact.
-#
 # Filters
 # ~~~~~~~
 # The filters are applied in the order as listed below. The COMMAND
@@ -164,27 +155,31 @@
 # and all children of the merge will become merge commits with P1,P2
 # as their parents instead of the merge commit.
 #
-# To restrict rewriting to only part of the history, use -r or -k or both.
+# To restrict rewriting to only part of the history, specify a revision
+# range in addition to the new branch name. The new branch name will
+# point to the top-most revision that a 'git rev-list' of this range
+# will print.
+#
 # Consider this history:
 #
 #	     D--E--F--G--H
 #	    /     /
 #	A--B-----C
 #
-# To rewrite only commits F,G,H, use:
+# To rewrite commits D,E,F,G,H, use:
 #
-#	git-filter-branch -r F ...
+#	git-filter-branch ... new-H C..H
 #
 # To rewrite commits E,F,G,H, use one of these:
 #
-#	git-filter-branch -r E -k C ...
-#	git-filter-branch -k D -k C ...
+#	git-filter-branch ... new-H C..H --not D
+#	git-filter-branch ... new-H D..H --not C
 
 # Testsuite: TODO
 
 set -e
 
-USAGE="git-filter-branch [-d TEMPDIR] [-r STARTREV]... [-k KEEPREV]... [-s SRCBRANCH] [FILTERS] DESTBRANCH"
+USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
 . git-sh-setup
 
 map()
@@ -233,7 +228,6 @@ get_parents () {
 }
 
 tempdir=.git-rewrite
-unchanged=" "
 filter_env=
 filter_tree=
 filter_index=
@@ -241,7 +235,6 @@ filter_parent=
 filter_msg=cat
 filter_commit='git-commit-tree "$@"'
 filter_tag_name=
-srcbranch=HEAD
 while case "$#" in 0) usage;; esac
 do
 	case "$1" in
@@ -266,12 +259,6 @@ do
 	-d)
 		tempdir="$OPTARG"
 		;;
-	-r)
-		unchanged="$(get_parents "$OPTARG") $unchanged"
-		;;
-	-k)
-		unchanged="$(git-rev-parse "$OPTARG"^{commit}) $unchanged"
-		;;
 	--env-filter)
 		filter_env="$OPTARG"
 		;;
@@ -293,9 +280,6 @@ do
 	--tag-name-filter)
 		filter_tag_name="$OPTARG"
 		;;
-	-s)
-		srcbranch="$OPTARG"
-		;;
 	*)
 		usage
 		;;
@@ -303,6 +287,7 @@ do
 done
 
 dstbranch="$1"
+shift
 test -n "$dstbranch" || die "missing branch name"
 git-show-ref "refs/heads/$dstbranch" 2> /dev/null &&
 	die "branch $dstbranch already exists"
@@ -328,7 +313,7 @@ ret=0
 
 mkdir ../map # map old->new commit ids for rewriting parents
 
-git-rev-list --reverse --topo-order $srcbranch --not $unchanged >../revs
+git-rev-list --reverse --topo-order --default HEAD "$@" >../revs
 commits=$(cat ../revs | wc -l | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 520963a..89b405b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -46,7 +46,7 @@ test_expect_success 'test that the file was renamed' '
 
 git tag oldD H3~4
 test_expect_success 'rewrite one branch, keeping a side branch' '
-	git-filter-branch --tree-filter "mv b boh || :" -k D -s oldD modD
+	git-filter-branch --tree-filter "mv b boh || :" modD D..oldD
 '
 
 test_expect_success 'common ancestor is still common (unchanged)' '
-- 
1.5.2.1.114.gc6c36

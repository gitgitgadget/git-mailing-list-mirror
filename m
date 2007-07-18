From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: get rid of "set -e"
Date: Wed, 18 Jul 2007 14:17:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181416050.14781@racer.site>
References: <20070710205202.GA3212@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 15:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB9Pw-0007ds-D7
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 15:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758730AbXGRNSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 09:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758514AbXGRNSI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 09:18:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:55356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757440AbXGRNSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 09:18:07 -0400
Received: (qmail invoked by alias); 18 Jul 2007 13:18:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 18 Jul 2007 15:18:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ehKlCECweeHhDymQ5NCnwXiMtUBL90IneYUpduo
	9a5+GG6Vmz1IJc
X-X-Sender: gene099@racer.site
In-Reply-To: <20070710205202.GA3212@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52861>


It was reported by Alex Riesen that "set -e" can break something as 
trivial as "unset CDPATH" in bash.

So get rid of "set -e".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 10 Jul 2007, Alex Riesen wrote:

	> I have a Debian system where git-filter-branch exits immediately 
	> after "unset CDPATH" in git-sh-setup (the command exits with 1, 
	> as CDPATH is not defined). The system still has bash-2.05a.
	> 
	> git-filter-branch has "set -e", which is why the script finishes
	> prematurely. If this is not really needed, maybe it can be 
	> removed?

	I hope I got all of the interesting places equipped by the 
	appropriate conditional die() calls.

 git-filter-branch.sh |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5401970..0d000ed 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,8 +8,6 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-set -e
-
 USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
 . git-sh-setup
 
@@ -141,9 +139,10 @@ git show-ref "refs/heads/$dstbranch" 2> /dev/null &&
 	die "branch $dstbranch already exists"
 
 test ! -e "$tempdir" || die "$tempdir already exists, please remove it"
-mkdir -p "$tempdir/t"
-cd "$tempdir/t"
-workdir="$(pwd)"
+mkdir -p "$tempdir/t" &&
+cd "$tempdir/t" &&
+workdir="$(pwd)" ||
+die ""
 
 case "$GIT_DIR" in
 /*)
@@ -155,12 +154,12 @@ esac
 export GIT_DIR GIT_WORK_TREE=.
 
 export GIT_INDEX_FILE="$(pwd)/../index"
-git read-tree # seed the index file
+git read-tree || die "Could not seed the index"
 
 ret=0
 
-
-mkdir ../map # map old->new commit ids for rewriting parents
+# map old->new commit ids for rewriting parents
+mkdir ../map || die "Could not create map/ directory"
 
 case "$filter_subdir" in
 "")
@@ -170,7 +169,7 @@ case "$filter_subdir" in
 *)
 	git rev-list --reverse --topo-order --default HEAD \
 		--parents --full-history "$@" -- "$filter_subdir"
-esac > ../revs
+esac > ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
@@ -186,10 +185,11 @@ while read commit parents; do
 		;;
 	*)
 		git read-tree -i -m $commit:"$filter_subdir"
-	esac
+	esac || die "Could not initialize the index"
 
 	export GIT_COMMIT=$commit
-	git cat-file commit "$commit" >../commit
+	git cat-file commit "$commit" >../commit ||
+		die "Cannot read commit $commit"
 
 	eval "$(set_ident AUTHOR <../commit)" ||
 		die "setting author failed for commit $commit"
@@ -199,7 +199,8 @@ while read commit parents; do
 		die "env filter failed: $filter_env"
 
 	if [ "$filter_tree" ]; then
-		git checkout-index -f -u -a
+		git checkout-index -f -u -a ||
+			die "Could not checkout the index"
 		# files that $commit removed are now still in the working tree;
 		# remove them, else they would be added again
 		git ls-files -z --others | xargs -0 rm -f
@@ -240,7 +241,8 @@ case "$target_head" in
 	echo Nothing rewritten
 	;;
 *)
-	git update-ref refs/heads/"$dstbranch" $target_head
+	git update-ref refs/heads/"$dstbranch" $target_head ||
+		die "Could not update $dstbranch with $target_head"
 	if [ $(wc -l <../map/$src_head) -gt 1 ]; then
 		echo "WARNING: Your commit filter caused the head commit to expand to several rewritten commits. Only the first such commit was recorded as the current $dstbranch head but you will need to resolve the situation now (probably by manually merging the other commits). These are all the commits:" >&2
 		sed 's/^/	/' ../map/$src_head >&2
@@ -277,7 +279,8 @@ if [ "$filter_tag_name" ]; then
 			warn "unreferencing tag object $sha1t"
 		fi
 
-		git update-ref "refs/tags/$new_ref" "$new_sha1"
+		git update-ref "refs/tags/$new_ref" "$new_sha1" ||
+			die "Could not write tag $new_ref"
 	done
 fi
 
-- 
1.5.3.rc1.16.g9d6f-dirty

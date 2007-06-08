From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/2] filter-branch: Simplify parent computation.
Date: Fri, 8 Jun 2007 23:28:39 +0200
Message-ID: <200706082328.39758.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 23:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwm0h-0002h9-Pq
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbXFHV2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXFHV2m
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:28:42 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:34234 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbXFHV2m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:28:42 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 5945B13A34A;
	Fri,  8 Jun 2007 23:28:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1723F56E1C;
	Fri,  8 Jun 2007 23:28:40 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49502>

We can use git rev-list --parents when we list the commits to rewrite.
It is not necessary to run git rev-list --parents for each commit in the
loop.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-filter-branch.sh |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 4990729..4ef4570 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -229,17 +229,6 @@ set_ident () {
 	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export 
GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
 }
 
-# list all parent's object names for a given commit
-get_parents () {
-	case "$filter_subdir" in
-	"")
-		git-rev-list -1 --parents "$1"
-		;;
-	*)
-		git-rev-list -1 --parents "$1" -- "$filter_subdir"
-	esac | sed "s/^[0-9a-f]*//"
-}
-
 tempdir=.git-rewrite
 filter_env=
 filter_tree=
@@ -332,18 +321,19 @@ mkdir ../map # map old->new commit ids for rewriting 
parents
 
 case "$filter_subdir" in
 "")
-	git-rev-list --reverse --topo-order --default HEAD "$@"
+	git-rev-list --reverse --topo-order --default HEAD \
+		--parents "$@"
 	;;
 *)
-	git-rev-list --reverse --topo-order --default HEAD "$@" \
-		-- "$filter_subdir"
+	git-rev-list --reverse --topo-order --default HEAD \
+		--parents "$@" -- "$filter_subdir"
 esac > ../revs
 commits=$(cat ../revs | wc -l | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
 
 i=0
-while read commit; do
+while read commit parents; do
 	i=$(($i+1))
 	printf "\rRewriting commits... ($i/$commits)"
 
@@ -377,7 +367,7 @@ while read commit; do
 	eval "$filter_index" < /dev/null
 
 	parentstr=
-	for parent in $(get_parents $commit); do
+	for parent in $parents; do
 		for reparent in $(map "$parent"); do
 			parentstr="$parentstr -p $reparent"
 		done
@@ -398,7 +388,7 @@ while read commit; do
 		done > ../map/$commit
 done <../revs
 
-src_head=$(tail -n 1 ../revs)
+src_head=$(tail -n 1 ../revs | sed -e 's/ .*//')
 target_head=$(head -n 1 ../map/$src_head)
 case "$target_head" in
 '')
-- 
1.5.2

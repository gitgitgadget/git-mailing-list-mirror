From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach filter-branch about subdirectory filtering
Date: Fri, 8 Jun 2007 01:30:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080130000.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 08 02:33:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwSPZ-0000eq-OE
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 02:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbXFHAcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 20:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933871AbXFHAcr
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 20:32:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:40287 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933283AbXFHAcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 20:32:46 -0400
Received: (qmail invoked by alias); 08 Jun 2007 00:32:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 08 Jun 2007 02:32:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+r3qITMO2rsoMIiF5DW1FJDqZX/jGYgU7gAMwI4H
	NbkTJrKUFEJmb7
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49420>


With git-filter-branch --subdirectory-filter <subdirectory> you can
get at the history, as seen by a certain subdirectory. The history
of the rewritten branch will only contain commits that touched that
subdirectory, and the subdirectory will be rewritten to be the new
project root.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh     |   33 ++++++++++++++++++++++++++++++---
 t/t7003-filter-branch.sh |   24 ++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index e6ed7b9..4990729 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -122,6 +122,10 @@
 #	attached, the rewritten tag won't have it. Sorry. (It is by
 #	definition impossible to preserve signatures at any rate, though.)
 #
+# --subdirectory-filter DIRECTORY:: Only regard the history, as seen by
+#	the given subdirectory. The result will contain that directory as
+#	its project root.
+#
 # EXAMPLE USAGE
 # -------------
 # Suppose you want to remove a file (containing confidential information
@@ -227,7 +231,13 @@ set_ident () {
 
 # list all parent's object names for a given commit
 get_parents () {
-	git-rev-list -1 --parents "$1" | sed "s/^[0-9a-f]*//"
+	case "$filter_subdir" in
+	"")
+		git-rev-list -1 --parents "$1"
+		;;
+	*)
+		git-rev-list -1 --parents "$1" -- "$filter_subdir"
+	esac | sed "s/^[0-9a-f]*//"
 }
 
 tempdir=.git-rewrite
@@ -238,6 +248,7 @@ filter_parent=
 filter_msg=cat
 filter_commit='git-commit-tree "$@"'
 filter_tag_name=
+filter_subdir=
 while case "$#" in 0) usage;; esac
 do
 	case "$1" in
@@ -283,6 +294,9 @@ do
 	--tag-name-filter)
 		filter_tag_name="$OPTARG"
 		;;
+	--subdirectory-filter)
+		filter_subdir="$OPTARG"
+		;;
 	*)
 		usage
 		;;
@@ -316,7 +330,14 @@ ret=0
 
 mkdir ../map # map old->new commit ids for rewriting parents
 
-git-rev-list --reverse --topo-order --default HEAD "$@" >../revs
+case "$filter_subdir" in
+"")
+	git-rev-list --reverse --topo-order --default HEAD "$@"
+	;;
+*)
+	git-rev-list --reverse --topo-order --default HEAD "$@" \
+		-- "$filter_subdir"
+esac > ../revs
 commits=$(cat ../revs | wc -l | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
@@ -326,7 +347,13 @@ while read commit; do
 	i=$(($i+1))
 	printf "\rRewriting commits... ($i/$commits)"
 
-	git-read-tree -i -m $commit
+	case "$filter_subdir" in
+	"")
+		git-read-tree -i -m $commit
+		;;
+	*)
+		git-read-tree -i -m $commit:"$filter_subdir"
+	esac
 
 	export GIT_COMMIT=$commit
 	git-cat-file commit "$commit" >../commit
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 3739cb1..292b837 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -54,4 +54,28 @@ test_expect_success 'common ancestor is still common (unchanged)' '
 	test "$(git-merge-base modD D)" = "$(git-rev-parse B)"
 '
 
+test_expect_success 'filter subdirectory only' '
+	mkdir subdir &&
+	touch subdir/new &&
+	git add subdir/new &&
+	test_tick &&
+	git commit -m "subdir" &&
+	echo H > a &&
+	test_tick &&
+	git commit -m "not subdir" a &&
+	echo A > subdir/new &&
+	test_tick &&
+	git commit -m "again subdir" subdir/new &&
+	git rm a &&
+	test_tick &&
+	git commit -m "again not subdir" &&
+	git-filter-branch --subdirectory-filter subdir sub
+'
+
+test_expect_success 'subdirectory filter result looks okay' '
+	test 2 = $(git-rev-list sub | wc -l) &&
+	git show sub:new &&
+	! git show sub:subdir
+'
+
 test_done
-- 
1.5.2.1.2689.gaf768-dirty

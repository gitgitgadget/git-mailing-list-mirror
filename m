From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] rebase: support -X to pass through strategy options
Date: Thu, 29 Jul 2010 00:04:29 +0200
Message-ID: <80763c667fa4685d2b6451838c0f1809e86fe07e.1280354419.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Lundy <mike@fluffypenguin.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 00:04:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeEkE-0006rt-8W
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 00:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab0G1WEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 18:04:53 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30921 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab0G1WEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 18:04:52 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 29 Jul
 2010 00:04:50 +0200
Received: from localhost.localdomain (84.74.100.241) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 29 Jul
 2010 00:04:30 +0200
X-Mailer: git-send-email 1.7.2.350.ga619b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152122>

From: Mike Lundy <mike@fluffypenguin.org>

git-rebase calls out to merge strategies, but did not support merge
strategy options so far.  Add this, in the same style used in
git-merge.

Sadly we have to do the full quoting/eval dance here, since
merge-recursive supports the --subtree=<path> option which potentially
contains whitespace.

This patch does not cover git rebase -i, which does not call any merge
strategy directly except in --preserve-merges, and even then only for
merges.

Signed-off-by: Mike Lundy <mike@fluffypenguin.org>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Mike posted this back in February but never picked up again after
Junio pointed out that the options can contain spaces.  This is an
attempt to at least finish the job for normal rebase.  Apart from the
whitespace issues, I changed the test to verify that the option
actually takes effect and added docs.


 Documentation/git-rebase.txt |    7 +++++++
 git-rebase.sh                |   23 ++++++++++++++++++++++-
 t/t3402-rebase-merge.sh      |    9 +++++++++
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 41e0604..dc8979e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -249,6 +249,13 @@ on top of the <upstream> branch using the given strategy, using
 the 'ours' strategy simply discards all patches from the <branch>,
 which makes little sense.
 
+-X <strategy-option>::
+--strategy-option=<strategy-option>::
+	Pass the <strategy-option> through to the merge strategy.
+	This implies `\--merge` and, if no strategy has been
+	specified, `-s recursive`.  Note the reversal of 'ours' and
+	'theirs' as noted in above for the `-m` option.
+
 -q::
 --quiet::
 	Be quiet. Implies --no-stat.
diff --git a/git-rebase.sh b/git-rebase.sh
index 694546f..70efbba 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -51,6 +51,7 @@ To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset newbase
 strategy=recursive
+strategy_opts=
 do_merge=
 dotest="$GIT_DIR"/rebase-merge
 prec=4
@@ -119,7 +120,7 @@ call_merge () {
 	then
 		export GIT_MERGE_VERBOSITY=1
 	fi
-	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
+	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
 	rv=$?
 	case "$rv" in
 	0)
@@ -300,6 +301,26 @@ do
 	-M|-m|--m|--me|--mer|--merg|--merge)
 		do_merge=t
 		;;
+	-X*|--strategy-option*)
+		case "$#,$1" in
+		1,-X|1,--strategy-option)
+			usage ;;
+		*,-X|*,--strategy-option)
+			newopt="$2"
+			shift ;;
+		*,--strategy-option=*)
+			newopt="$(expr "$1" : '--strategy-option=\(.*\)')" ;;
+		*,-X*)
+			newopt="$(expr "$1" : '-X\(.*\)')" ;;
+		1,*)
+			usage ;;
+		esac
+		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$newopt")"
+		do_merge=t
+		if test -n "$strategy"; then
+			strategy=recursive
+		fi
+		;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7b7d072..2bea656 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -74,6 +74,15 @@ test_expect_success 'rebase the other way' '
 	git rebase --merge side
 '
 
+test_expect_success 'rebase -Xtheirs' '
+	git checkout -b conflicting master~2 &&
+	echo "AB $T" >> original &&
+	git commit -mconflicting original &&
+	git rebase -Xtheirs master &&
+	grep AB original &&
+	! grep 11 original
+'
+
 test_expect_success 'merge and rebase should match' '
 	git diff-tree -r test-rebase test-merge >difference &&
 	if test -s difference
-- 
1.7.2.350.ga619b6.dirty

From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH 3/5] Replace $((...)) with expr invocations.
Date: Tue, 6 Nov 2007 21:18:09 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106201809.GD6361@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUsV-00027H-OC
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbXKFUSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755263AbXKFUSM
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:18:12 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:57124 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbXKFUSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:18:11 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 7F81A40002DD2
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:18:10 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106201518.GA6361@ins.uni-bonn.de>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63717>

---
 git-filter-branch.sh       |    4 ++--
 git-rebase--interactive.sh |    8 ++++----
 git-rebase.sh              |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ffcc408..2d5c247 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -253,7 +253,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 
 i=0
 while read commit parents; do
-	i=$(($i+1))
+	i=$(expr $i + 1)
 	printf "\rRewrite $commit ($i/$commits)"
 
 	case "$filter_subdir" in
@@ -374,7 +374,7 @@ do
 	;;
 	esac
 	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1
-	count=$(($count+1))
+	count=$(expr $count + 1)
 done < "$tempdir"/heads
 
 # TODO: This should possibly go, with the semantics that all positive given
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ecc6778..da48aaf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -71,8 +71,8 @@ mark_action_done () {
 	sed -e 1q < "$TODO" >> "$DONE"
 	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
-	count=$(($(grep -ve '^$' -e '^#' < "$DONE" | wc -l)))
-	total=$(($count+$(grep -ve '^$' -e '^#' < "$TODO" | wc -l)))
+	count=$(grep -ve '^$' -e '^#' < "$DONE" | wc -l)
+	total=$(expr $count + $(grep -ve '^$' -e '^#' < "$TODO" | wc -l))
 	printf "Rebasing (%d/%d)\r" $count $total
 	test -z "$VERBOSE" || echo
 }
@@ -205,8 +205,8 @@ nth_string () {
 
 make_squash_message () {
 	if test -f "$SQUASH_MSG"; then
-		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
-			< "$SQUASH_MSG" | tail -n 1)+1))
+		COUNT=$(expr $(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
+			< "$SQUASH_MSG" | tail -n 1) + 1)
 		echo "# This is a combination of $COUNT commits."
 		sed -n "2,\$p" < "$SQUASH_MSG"
 	else
diff --git a/git-rebase.sh b/git-rebase.sh
index 224cca9..daa347a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -79,7 +79,7 @@ continue_merge () {
 	echo "$prev_head" > "$dotest/prev_head"
 
 	# onto the next patch:
-	msgnum=$(($msgnum + 1))
+	msgnum=$(expr $msgnum + 1)
 	echo "$msgnum" >"$dotest/msgnum"
 }
 
@@ -90,7 +90,7 @@ call_merge () {
 	cmt_name=$(git symbolic-ref HEAD)
 	msgnum=$(cat "$dotest/msgnum")
 	end=$(cat "$dotest/end")
-	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
+	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(expr $end - $msgnum)"'
 	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'
 	export GITHEAD_$cmt GITHEAD_$hd
 	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
@@ -163,7 +163,7 @@ do
 			prev_head=$(cat "$dotest/prev_head")
 			end=$(cat "$dotest/end")
 			msgnum=$(cat "$dotest/msgnum")
-			msgnum=$(($msgnum + 1))
+			msgnum=$(expr $msgnum + 1)
 			onto=$(cat "$dotest/onto")
 			while test "$msgnum" -le "$end"
 			do
@@ -349,7 +349,7 @@ echo "$prev_head" > "$dotest/prev_head"
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
 do
-	msgnum=$(($msgnum + 1))
+	msgnum=$(expr $msgnum + 1)
 	echo "$cmt" > "$dotest/cmt.$msgnum"
 done
 
-- 
1.5.3.5.561.g140d

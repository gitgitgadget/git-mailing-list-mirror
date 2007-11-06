From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 5/5] Avoid "test -o" and "test -a" which are not POSIX,
	only XSI.
Date: Tue, 6 Nov 2007 21:20:35 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106202035.GF6361@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUuq-00031K-Ul
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbXKFUUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXKFUUi
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:20:38 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:36821 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbXKFUUh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:20:37 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 7617040002DE5
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:20:36 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106201518.GA6361@ins.uni-bonn.de>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63719>

---
 git-clone.sh        |    2 +-
 git-commit.sh       |    4 ++--
 git-merge-stupid.sh |    2 +-
 git-merge.sh        |    4 ++--
 git-mergetool.sh    |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 3f00693..1ae137a 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -462,7 +462,7 @@ then
 
 	case "$no_checkout" in
 	'')
-		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
+		test "z$quiet" = z && test "z$no_progress" = z && v=-v || v=
 		git read-tree -m -u $v HEAD HEAD
 	esac
 fi
diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..78fe518 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -50,7 +50,7 @@ run_status () {
 		export GIT_INDEX_FILE
 	fi
 
-	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
+	if test "$status_only" = "t" || test "$use_status_color" = "t"; then
 		color=
 	else
 		color=--nocolor
@@ -290,7 +290,7 @@ t,,[1-9]*)
 	die "No paths with -i does not make sense." ;;
 esac
 
-if test ! -z "$templatefile" -a -z "$log_given"
+if test ! -z "$templatefile" && test -z "$log_given"
 then
 	if test ! -f "$templatefile"
 	then
diff --git a/git-merge-stupid.sh b/git-merge-stupid.sh
index f612d47..95adbb3 100755
--- a/git-merge-stupid.sh
+++ b/git-merge-stupid.sh
@@ -44,7 +44,7 @@ case "$bases" in
 			 2>/dev/null ||	continue
 		# Count the paths that are unmerged.
 		cnt=`GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l`
-		if test $best_cnt -le 0 -o $cnt -le $best_cnt
+		if test $best_cnt -le 0 || test $cnt -le $best_cnt
 		then
 			best=$c
 			best_cnt=$cnt
diff --git a/git-merge.sh b/git-merge.sh
index c2092a2..b6a35d4 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -124,7 +124,7 @@ merge_name () {
 		git show-ref -q --verify "refs/heads/$truname" 2>/dev/null
 	then
 		echo "$rh		branch '$truname' (early part) of ."
-	elif test "$remote" = "FETCH_HEAD" -a -r "$GIT_DIR/FETCH_HEAD"
+	elif test "$remote" = "FETCH_HEAD" && test -r "$GIT_DIR/FETCH_HEAD"
 	then
 		sed -e 's/	not-for-merge	/		/' -e 1q \
 			"$GIT_DIR/FETCH_HEAD"
@@ -478,7 +478,7 @@ do
 		git diff-files --name-only
 		git ls-files --unmerged
 	    } | wc -l`
-	    if test $best_cnt -le 0 -o $cnt -le $best_cnt
+	    if test $best_cnt -le 0 || test $cnt -le $best_cnt
 	    then
 		best_strategy=$strategy
 		best_cnt=$cnt
diff --git a/git-mergetool.sh b/git-mergetool.sh
index a68b403..9f7386b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -167,7 +167,7 @@ merge_file () {
     local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
     remote_present && git cat-file blob ":3:$prefix$path" >"$REMOTE" 2>/dev/null
 
-    if test -z "$local_mode" -o -z "$remote_mode"; then
+    if test -z "$local_mode" || test -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$path':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
-- 
1.5.3.5.561.g140d

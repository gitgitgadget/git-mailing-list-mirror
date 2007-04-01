From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] Bisect: teach "bisect start" to optionally use one bad
 and many good revs.
Date: Sun, 1 Apr 2007 14:57:23 +0200
Message-ID: <20070401145723.27e17177.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 14:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXzUp-0003Jv-Oq
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 14:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbXDAMtU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 08:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933012AbXDAMtU
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 08:49:20 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52263 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932969AbXDAMtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 08:49:19 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 3DE3BB62A5;
	Sun,  1 Apr 2007 14:49:17 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43589>

As Junio said:

"One bad commit is fundamentally needed for bisect to run,
and if we beforehand know more good commits, we can narrow
the bisect space down without doing the whole tree checkout
every time we give good commits.  I think it may be a good
idea to have:

    git bisect start [$bad [$good1 $good2...]] [-- <paths>...]

as a short-hand for this command sequence:

    git bisect start
    git bisect bad $bad
    git bisect good $good1 $good2...

That would be a good script-shorterner, without limiting it to
any specific use scenario."

In fact this patch implements:

    git bisect start [<bad> [<good>...]] [--] [<pathspec>...]

I think this is more backward compatible because older script
probably didn't used -- before <pathspec>...

On the other hand, there may be some confusion between revs
(<bad> and <good>...) and <pathspec>... if -- is not used
and if an invalid rev or a pathspec that looks like a rev is
given.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh         |  105 ++++++++++++++++++++++++++++++++++++++-----------
 t/t6030-bisect-run.sh |   20 ++++++++-
 2 files changed, 99 insertions(+), 26 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 11313a7..d5a13ee 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,15 +1,24 @@
 #!/bin/sh
 
 USAGE='[start|bad|good|next|reset|visualize|replay|log|run]'
-LONG_USAGE='git bisect start [<pathspec>]	reset bisect state and start bisection.
-git bisect bad [<rev>]		mark <rev> a known-bad revision.
-git bisect good [<rev>...]	mark <rev>... known-good revisions.
-git bisect next			find next bisection to test and check it out.
-git bisect reset [<branch>]	finish bisection search and go back to branch.
-git bisect visualize            show bisect status in gitk.
-git bisect replay <logfile>	replay bisection log.
-git bisect log			show bisect log.
-git bisect run <cmd>... 	use <cmd>... to automatically bisect.'
+LONG_USAGE='git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
+        reset bisect state and start bisection.
+git bisect bad [<rev>]
+        mark <rev> a known-bad revision.
+git bisect good [<rev>...]
+        mark <rev>... known-good revisions.
+git bisect next
+        find next bisection to test and check it out.
+git bisect reset [<branch>]
+        finish bisection search and go back to branch.
+git bisect visualize
+        show bisect status in gitk.
+git bisect replay <logfile>
+        replay bisection log.
+git bisect log
+        show bisect log.
+git bisect run <cmd>...
+        use <cmd>... to automatically bisect.'
 
 . git-sh-setup
 require_work_tree
@@ -70,14 +79,48 @@ bisect_start() {
 	#
 	# Get rid of any old bisect state
 	#
-	rm -f "$GIT_DIR/refs/heads/bisect"
-	rm -rf "$GIT_DIR/refs/bisect/"
+	bisect_clean_state
 	mkdir "$GIT_DIR/refs/bisect"
+
+	#
+	# Check for one bad and then some good revisions.
+	#
+	has_double_dash=0
+	for arg in "$@"; do
+	    case "$arg" in --) has_double_dash=1; break ;; esac
+	done
+	orig_args="$@"
+	bad_seen=0
+	while [ $# -gt 0 ]; do
+	    arg="$1"
+	    case "$arg" in
+	    --)
+	        shift
+		break
+		;;
+	    *)
+	        rev=$(git-rev-parse --verify "$arg^{commit}" 2>/dev/null) || {
+		    test $has_double_dash -eq 1 &&
+		        die "'$arg' does not appear to be a valid revision"
+		    break
+		}
+		if [ $bad_seen -eq 0 ]; then
+		    bad_seen=1
+		    bisect_write_bad "$rev"
+		else
+		    bisect_write_good "$rev"
+		fi
+	        shift
+		;;
+	    esac
+        done
+
+	sq "$@" >"$GIT_DIR/BISECT_NAMES"
 	{
 	    printf "git-bisect start"
-	    sq "$@"
-	} >"$GIT_DIR/BISECT_LOG"
-	sq "$@" >"$GIT_DIR/BISECT_NAMES"
+	    sq "$orig_args"
+	} >>"$GIT_DIR/BISECT_LOG"
+	bisect_auto_next
 }
 
 bisect_bad() {
@@ -90,12 +133,17 @@ bisect_bad() {
 	*)
 		usage ;;
 	esac || exit
-	echo "$rev" >"$GIT_DIR/refs/bisect/bad"
-	echo "# bad: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+	bisect_write_bad "$rev"
 	echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
 }
 
+bisect_write_bad() {
+	rev="$1"
+	echo "$rev" >"$GIT_DIR/refs/bisect/bad"
+	echo "# bad: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+}
+
 bisect_good() {
 	bisect_autostart
         case "$#" in
@@ -106,13 +154,19 @@ bisect_good() {
 	for rev in $revs
 	do
 		rev=$(git-rev-parse --verify "$rev^{commit}") || exit
-		echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
-		echo "# good: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+		bisect_write_good "$rev"
 		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
+
 	done
 	bisect_auto_next
 }
 
+bisect_write_good() {
+	rev="$1"
+	echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
+	echo "# good: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+}
+
 bisect_next_check() {
 	next_ok=no
         test -f "$GIT_DIR/refs/bisect/bad" &&
@@ -190,14 +244,19 @@ bisect_reset() {
 	    usage ;;
 	esac
 	if git checkout "$branch"; then
-		rm -fr "$GIT_DIR/refs/bisect"
-		rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
-		rm -f "$GIT_DIR/BISECT_LOG"
-		rm -f "$GIT_DIR/BISECT_NAMES"
-		rm -f "$GIT_DIR/BISECT_RUN"
+		rm -f "$GIT_DIR/head-name"
+		bisect_clean_state
 	fi
 }
 
+bisect_clean_state() {
+	rm -fr "$GIT_DIR/refs/bisect"
+	rm -f "$GIT_DIR/refs/heads/bisect"
+	rm -f "$GIT_DIR/BISECT_LOG"
+	rm -f "$GIT_DIR/BISECT_NAMES"
+	rm -f "$GIT_DIR/BISECT_RUN"
+}
+
 bisect_replay () {
 	test -r "$1" || {
 		echo >&2 "cannot read $1 for replaying"
diff --git a/t/t6030-bisect-run.sh b/t/t6030-bisect-run.sh
index 39c7228..455dc60 100755
--- a/t/t6030-bisect-run.sh
+++ b/t/t6030-bisect-run.sh
@@ -40,8 +40,8 @@ test_expect_success \
 # We want to automatically find the commit that
 # introduced "Another" into hello.
 test_expect_success \
-    'git bisect run simple case' \
-    'echo "#!/bin/sh" > test_script.sh &&
+    '"git bisect run" simple case' \
+    'echo "#"\!"/bin/sh" > test_script.sh &&
      echo "grep Another hello > /dev/null" >> test_script.sh &&
      echo "test \$? -ne 0" >> test_script.sh &&
      chmod +x test_script.sh &&
@@ -49,7 +49,21 @@ test_expect_success \
      git bisect good $HASH1 &&
      git bisect bad $HASH4 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is first bad commit" my_bisect_log.txt'
+     grep "$HASH3 is first bad commit" my_bisect_log.txt &&
+     git bisect reset'
+
+# We want to automatically find the commit that
+# introduced "Ciao" into hello.
+test_expect_success \
+    '"git bisect run" with more complex "git bisect start"' \
+    'echo "#"\!"/bin/sh" > test_script.sh &&
+     echo "grep Ciao hello > /dev/null" >> test_script.sh &&
+     echo "test \$? -ne 0" >> test_script.sh &&
+     chmod +x test_script.sh &&
+     git bisect start $HASH4 $HASH1 &&
+     git bisect run ./test_script.sh > my_bisect_log.txt &&
+     grep "$HASH4 is first bad commit" my_bisect_log.txt &&
+     git bisect reset'
 
 #
 #
-- 
1.5.1.rc3.21.g177f7-dirty

From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --no-commit to git-merge/git-pull.
Date: Tue, 01 Nov 2005 19:43:30 -0800
Message-ID: <7vd5lj3eal.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 02 04:44:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX9XD-0001Ho-9e
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 04:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVKBDnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 22:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVKBDnc
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 22:43:32 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45207 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932258AbVKBDnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 22:43:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102034240.JFXE2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 22:42:40 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10998>

With --no-commit flag, git-pull will perform the merge but pretends as
if the merge needed a hand resolve even if automerge cleanly resolves,
to give the user a chance to add further changes and edit the commit
message.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 This turns out to be useful while maintaining the maint branch
 for 0.99.9[a-z] lettered maintenance releases.  The plan is for
 the contents of that branch to match always the tip of the
 master branch during 0.99.9 timeframe, and every time a merge
 is done from master into maint, only GIT_VERSION in the
 Makefile is bumped up.  0.99.8 maintenance branch was done by
 pulling from a private branch "fixes", immediately followed by
 a separate commit to bump that definition up, but with this, I
 could instead do this:

        $ git checkout master
        $ git am -3 -s ./++patches-from-the-list.mbox
	... work work work in master ...
        $ git checkout maint
        $ git pull --no-commit . master
        ... update the version in Makefile and debian/changelog ...
        $ git commit -a -m 'GIT 0.99.9b'

 git-merge.sh |   28 ++++++++++++++++++----------
 git-pull.sh  |    6 ++++--
 2 files changed, 22 insertions(+), 12 deletions(-)

applies-to: 60d390a285756ba840953418954ac05dca40f75b
c575e6d759f2305e5710dae7ac58274db5930de7
diff --git a/git-merge.sh b/git-merge.sh
index 6ad96eb..dd104db 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,7 +9,7 @@ LF='
 '
 
 usage () {
-    die "git-merge [-n] [-s <strategy>]... <merge-message> <head> <remote>+"
+    die "git-merge [-n] [--no-commit] [-s <strategy>]... <merge-message> <head> <remote>+"
 }
 
 # all_strategies='resolve recursive stupid octopus'
@@ -63,6 +63,8 @@ do
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
 		--no-summa|--no-summar|--no-summary)
 		no_summary=t ;;
+	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
+		no_commit=t ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -111,18 +113,18 @@ done
 common=$(git-show-branch --merge-base $head "$@")
 echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
-case "$#,$common" in
-*,'')
+case "$#,$common,$no_commit" in
+*,'',*)
 	# No common ancestors found. We need a real merge.
 	;;
-1,"$1")
+1,"$1",*)
 	# If head can reach all the merge then we are up to date.
 	# but first the most common case of merging one remote
 	echo "Already up-to-date."
 	dropsave
 	exit 0
 	;;
-1,"$head")
+1,"$head",*)
 	# Again the most common case of merging one remote.
 	echo "Updating from $head to $1."
 	git-update-index --refresh 2>/dev/null
@@ -132,11 +134,11 @@ case "$#,$common" in
 	dropsave
 	exit 0
 	;;
-1,?*"$LF"?*)
+1,?*"$LF"?*,*)
 	# We are not doing octopus and not fast forward.  Need a
 	# real merge.
 	;;
-1,*)
+1,*,)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.  See if it is really trivial.
 	echo "Trying really trivial in-index merge..."
@@ -210,12 +212,18 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy
 
-    git-merge-$strategy $common -- "$head_arg" "$@" || {
+    git-merge-$strategy $common -- "$head_arg" "$@"
+    exit=$?
+    if test "$no_commit" = t && test "$exit" = 0
+    then
+	exit=1 ;# pretend it left conflicts.
+    fi
+
+    test "$exit" = 0 || {
 
 	# The backend exits with 1 when conflicts are left to be resolved,
 	# with 2 when it does not handle the given merge at all.
 
-	exit=$?
 	if test "$exit" -eq 1
 	then
 	    cnt=`{
@@ -272,4 +280,4 @@ do
 done >"$GIT_DIR/MERGE_HEAD"
 echo $merge_msg >"$GIT_DIR/MERGE_MSG"
 
-die "Automatic merge failed; fix up by hand"
+die "Automatic merge failed/prevented; fix up by hand"
diff --git a/git-pull.sh b/git-pull.sh
index d476518..9601627 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -10,13 +10,15 @@ usage () {
     die "git pull [-n] [-s strategy]... <repo> <head>..."
 }
 
-strategy_args= no_summary=
+strategy_args= no_summary= no_commit=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
 		--no-summa|--no-summar|--no-summary)
 		no_summary=-n ;;
+	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
+		no_commit=--no-commit ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -81,4 +83,4 @@ case "$strategy_args" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
-git-merge $no_summary $strategy_args "$merge_name" HEAD $merge_head
+git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head
---
0.99.9.GIT

From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] 'git bisect visualize'
Date: Tue, 30 Aug 2005 11:22:40 -0700
Message-ID: <7v64tnjndb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:45:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAAkv-0007JQ-An
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 20:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVH3SWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 14:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVH3SWm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 14:22:42 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:26504 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932235AbVH3SWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 14:22:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050830182241.MATW15405.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 Aug 2005 14:22:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 30 Aug 2005 10:29:39 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7961>

Linus says:

    I'm testing bisection to find a bug that causes my G5 to no longer boot,
    and during the process have found this command line very nice:

	    gitk bisect/bad --not $(cd .git/refs ; ls bisect/good-*)

    it basically shows the state of bisection with the known bad commit as the
    top, and cutting off all the good commits - so what you see are the
    potential buggy commits.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I think turning the flow inside out and driving bisect from
   gitk might make more sense, though.  You start 'Bisect...'
   from the 'File' menu, click on one node and say 'good' or
   'bad' from its pop-up menu,...

 git-bisect-script |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

0e0713a470e7bea760aa0bd7510ddc668fb8b744
diff --git a/git-bisect-script b/git-bisect-script
--- a/git-bisect-script
+++ b/git-bisect-script
@@ -2,12 +2,13 @@
 . git-sh-setup-script || dir "Not a git archive"
 
 usage() {
-    echo >&2 'usage: git bisect [start | bad | good | next | reset]
+    echo >&2 'usage: git bisect [start|bad|good|next|reset|visualize]
 git bisect start		reset bisect state and start bisection.
 git bisect bad [<rev>]		mark <rev> a known-bad revision.
 git bisect good [<rev>...]	mark <rev>... known-good revisions.
 git bisect next			find next bisection to test and check it out.
-git bisect reset [<branch>]	finish bisection search and go back to branch.'
+git bisect reset [<branch>]	finish bisection search and go back to branch.
+git bisect visualize		show the current state in gitk.'
     exit 1
 }
 
@@ -57,9 +58,15 @@ bisect_start() {
 
 bisect_bad() {
 	bisect_autostart
-        case "$#" in 0 | 1) ;; *) usage ;; esac
-	rev=$(git-rev-parse --verify --default HEAD "$@") || exit
-	echo "$rev" > "$GIT_DIR/refs/bisect/bad"
+        case "$#" in
+	0)
+		rev=$(git-rev-parse --verify HEAD) ;;
+	1)
+		rev=$(git-rev-parse --verify "$1") ;;
+	*)
+		usage ;;
+	esac || exit
+	echo "$rev" >"$GIT_DIR/refs/bisect/bad"
 	bisect_auto_next
 }
 
@@ -67,10 +74,12 @@ bisect_good() {
 	bisect_autostart
         case "$#" in
 	0)    revs=$(git-rev-parse --verify HEAD) || exit ;;
-	*)    revs=$(git-rev-parse --revs-only --no-flags "$@") || exit ;;
+	*)    revs=$(git-rev-parse --revs-only --no-flags "$@") &&
+	      test '' != "$revs" || die "Bad rev: $@" ;;
 	esac
 	for rev in $revs
 	do
+	    rev=$(git-rev-parse --verify $rev) || exit
 	    echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
 	done
 	bisect_auto_next
@@ -107,8 +116,11 @@ bisect_next() {
 	rev=$(eval "git-rev-list --bisect $good $bad") || exit
 	nr=$(eval "git-rev-list $rev $good" | wc -l) || exit
 	if [ "$nr" -le "1" ]; then
+	    if [ "$rev" = "" ]; then
+		die "Your input does not make sense."
+	    fi
 	    echo "$rev is first bad commit"
-	    git-diff-tree --pretty $rev
+	    git-diff-tree --pretty "$rev"
 	    exit 0
 	fi
 	echo "Bisecting: $nr revisions left to test after this"
@@ -118,6 +130,11 @@ bisect_next() {
 	ln -sf refs/heads/bisect "$GIT_DIR/HEAD"
 }
 
+bisect_visualize() {
+	bisect_next_check fail
+	gitk bisect/bad --not `cd "$GIT_DIR/refs" && echo bisect/good-*`
+}
+
 bisect_reset() {
 	case "$#" in
 	0) branch=master ;;
@@ -150,6 +167,8 @@ case "$#" in
     next)
         # Not sure we want "next" at the UI level anymore.
         bisect_next "$@" ;;
+    visualize)
+        bisect_visualize "$@" ;;
     reset)
         bisect_reset "$@" ;;
     *)

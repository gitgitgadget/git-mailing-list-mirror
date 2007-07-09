From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] rebase: allow starting from a dirty tree.
Date: Mon, 09 Jul 2007 00:59:18 -0700
Message-ID: <7vwsxauhwp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 09:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7o9S-0004Ah-RZ
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 09:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXGIH7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 03:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbXGIH7U
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 03:59:20 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63234 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbXGIH7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 03:59:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709075918.GDQV1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 03:59:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MKzJ1X0071kojtg0000000; Mon, 09 Jul 2007 03:59:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51970>

This uses the new "git stash create" interface to stash away the dirty state
you have in your working tree before starting a rebase, and then replaying
it when you are done with stashing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Not 'master' material yet without heavy field testing, and it is
   not a good time to do so before 1.5.3-rc1, so this will stay
   in 'pu' and perhaps in 'next' for now.

 git-rebase.sh |   66 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index cbafa14..602723a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -116,10 +116,25 @@ call_merge () {
 }
 
 finish_rb_merge () {
+	if test -f "$dotest/stash"
+	then
+		stash=$(cat "$dotest/stash")
+		git stash apply --index "$stash"
+	fi
 	rm -r "$dotest"
 	echo "All done."
 }
 
+unstash_and_exit () {
+	err=$?
+	if test -f "$1" && test $err = 0
+	then
+		stash=$(cat "$1")
+		git stash apply --index "$stash"
+	fi
+	exit $err
+}
+
 is_interactive () {
 	test -f "$dotest"/interactive ||
 	while case $#,"$1" in 0,|*,-i|*,--interactive) break ;; esac
@@ -155,7 +170,7 @@ do
 			exit
 		fi
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
-		exit
+		unstash_and_exit .dotest/stash
 		;;
 	--skip)
 		if test -d "$dotest"
@@ -175,20 +190,29 @@ do
 			exit
 		fi
 		git am -3 --skip --resolvemsg="$RESOLVEMSG"
-		exit
+		unstash_and_exit .dotest/stash
 		;;
 	--abort)
 		git rerere clear
 		if test -d "$dotest"
 		then
+			if test -f "$dotest/stash"
+			then
+				stash=$(cat "$dotest/stash")
+			fi
 			rm -r "$dotest"
 		elif test -d .dotest
 		then
+			if test -f ".dotest/stash"
+			then
+				stash=$(cat ".dotest/stash")
+			fi
 			rm -r .dotest
 		else
 			die "No rebase in progress?"
 		fi
 		git reset --hard ORIG_HEAD
+		test -z "$stash" || git stash apply --index "$stash"
 		exit
 		;;
 	--onto)
@@ -252,16 +276,6 @@ else
 	fi
 fi
 
-# The tree must be really really clean.
-git update-index --refresh || exit
-diff=$(git diff-index --cached --name-status -r HEAD)
-case "$diff" in
-?*)	echo "cannot rebase: your index is not up-to-date"
-	echo "$diff"
-	exit 1
-	;;
-esac
-
 # The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
 upstream=`git rev-parse --verify "${upstream_name}^0"` ||
@@ -271,11 +285,20 @@ upstream=`git rev-parse --verify "${upstream_name}^0"` ||
 onto_name=${newbase-"$upstream_name"}
 onto=$(git rev-parse --verify "${onto_name}^0") || exit
 
+# The tree must be clean enough for us to create a stash
+stash=$(git stash create) || exit
+if test -n "$stash"
+then
+	echo >&2 "Stashed away your working tree changes"
+	git reset --hard
+fi
+
 # If a hook exists, give it a chance to interrupt
 if test -x "$GIT_DIR/hooks/pre-rebase"
 then
 	"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
 		echo >&2 "The pre-rebase hook refused to rebase."
+		test -z "$stash" || git stash apply --index "$stash"
 		exit 1
 	}
 fi
@@ -284,7 +307,10 @@ fi
 case "$#" in
 2)
 	branch_name="$2"
-	git-checkout "$2" || usage
+	git-checkout "$2" || {
+		test -z "$stash" || git stash apply --index "$stash"
+		usage
+	}
 	;;
 *)
 	if branch_name=`git symbolic-ref -q HEAD`
@@ -307,6 +333,7 @@ if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
 	! git rev-list --parents "$onto".."$branch" | grep " .* " > /dev/null
 then
 	echo >&2 "Current branch $branch_name is up to date."
+	test -z "$stash" || git stash apply --index "$stash"
 	exit 0
 fi
 
@@ -326,6 +353,7 @@ git-reset --hard "$onto"
 if test "$mb" = "$branch"
 then
 	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	test -z "$stash" || git stash apply --index "$stash"
 	exit 0
 fi
 
@@ -333,7 +361,16 @@ if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream "$upstream"..ORIG_HEAD |
 	git am $git_am_opt --binary -3 -k --resolvemsg="$RESOLVEMSG"
-	exit $?
+	err=$?
+
+	if test $err = 0
+	then
+		test -z "$stash" || git stash apply --index "$stash"
+		exit
+	else
+		test -z "$stash" || echo "$stash" >.dotest/stash
+		exit $err
+	fi
 fi
 
 # start doing a rebase with git-merge
@@ -344,6 +381,7 @@ echo "$onto" > "$dotest/onto"
 echo "$onto_name" > "$dotest/onto_name"
 prev_head=`git rev-parse HEAD^0`
 echo "$prev_head" > "$dotest/prev_head"
+test -z "$stash" || echo "$stash" >"$dotest/stash"
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
-- 
1.5.3.rc0.81.g1ed84

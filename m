From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach rebase an interactive mode
Date: Sun, 24 Jun 2007 12:09:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706241204450.4059@racer.site>
References: <Pine.LNX.4.64.0706240001150.4059@racer.site>
 <7v4pkxydim.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 13:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Pxy-0001k5-4d
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 13:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbXFXLJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 07:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbXFXLJJ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 07:09:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:36654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754180AbXFXLJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 07:09:07 -0400
Received: (qmail invoked by alias); 24 Jun 2007 11:09:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 24 Jun 2007 13:09:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183tExNWYQ3uPix1SUrxn6SsjftV8qN444L6Tri+0
	dhOvy5UKs1Z+ig
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pkxydim.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50791>

Hi,

thanks to both of you, for your comments. I am a little pressed on time, 
so I will only be able to fix all this up this evening, but I thought I 
let you know what the state is.

I am not answering point by point, because I agree with all of the nits.

The four missing points are:

- fix up the commit message so that it is clear from where the list of 
  commits comes,
- put a sensible reflog message at the last update,
- move the usage section into the man page, and
- fix the quoting in patch 1/2.

Will resend (after using rebase -i myself, yeah!) tonight.

---
 Documentation/git-rebase.txt |   12 ++---
 git-rebase--interactive.sh   |   90 ++++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2e474e8..e96d72e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -235,7 +235,7 @@ Interactive mode
 ----------------
 
 Rebasing interactively means that you have a chance to edit the commits
-which are rebased.  You can not only reorder the commits, but also
+which are rebased.  You can reorder the commits, and you can
 remove them (weeding out bad or otherwise unwanted patches).
 
 The list will look like this:
@@ -247,18 +247,16 @@ pick fa1afe1 The oneline of the next commit
 -------------------------------------------
 
 The oneline descriptions are purely for your pleasure; `git-rebase` will
-not look at them but at the commit names, so do not delete or edit the
-names.
+not look at them but at the commit names ("deadbee" and "fa1afe1" in this
+example), so do not delete or edit the names.
 
 By replacing the command "pick" with the command "edit", you can tell
 `git-rebase` to stop after applying that commit, so that you can edit
 the files and/or the commit message, amend the commit and continue
 rebasing.
 
-If you want to fold two commits into one, just replace the command "pick"
-with "squash" for the second commit.  After squashing the commits,
-`git-rebase` will start an editor with both commit messages, so you
-can compose the commit message for the squashed commit.
+If you want to fold two or more commits into one, replace the command
+"pick" with "squash" for the second and subsequent commit.
 
 A common use case for the interactive mode is when you want to reorder
 the last 5 commits, such that what was HEAD~4 becomes the new HEAD. To
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6a960b4..1d1e927 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -78,30 +78,31 @@ STRATEGY=
 VERBOSE=
 
 warn () {
-	echo "$@" >&2
+	echo "$*" >&2
 }
 
 require_clean_work_tree () {
 	# test if working tree is dirty
 	git rev-parse --verify HEAD > /dev/null &&
 	git update-index --refresh &&
-	test -z "`git diff-files --name-only`" &&
-	test -z "`git diff-index --cached --name-only HEAD`" ||
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD ||
 	die "Working tree is dirty"
 }
 
 ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
 
 comment_for_reflog () {
-	if test -z "$ORIG_REFLOG_ACTION"; then
-		GIT_REFLOG_ACTION="rebase --interactive ($1)"
+	case "$ORIG_REFLOG_ACTION" in
+	''|rebase*)
+		GIT_REFLOG_ACTION="rebase -i ($1)"
 		export GIT_REFLOG_ACTION
-	fi
+	esac
 }
 
 mark_action_done () {
-	sed -n 1p < "$TODO" >> "$DONE"
-	sed -n '2,$p' < "$TODO" >> "$TODO".new
+	sed -e 1q < "$TODO" >> "$DONE"
+	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
 }
 
@@ -117,6 +118,7 @@ die_with_patch () {
 
 pick_one () {
 	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
+	git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
 	current_sha1=$(git rev-parse --verify HEAD)
 	if [ $current_sha1 = $parent_sha1 ]; then
@@ -131,17 +133,17 @@ pick_one () {
 do_next () {
 	read command sha1 rest < "$TODO"
 	case "$command" in
-	\#)
+	\#|'')
 		mark_action_done
 		continue
-	;;
+		;;
 	pick)
 		comment_for_reflog pick
 
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-	;;
+		;;
 	edit)
 		comment_for_reflog edit
 
@@ -155,11 +157,11 @@ do_next () {
 		warn "	git commit --amend"
 		warn
 		exit 0
-	;;
+		;;
 	squash)
 		comment_for_reflog squash
 
-		test -s "$DONE" ||
+		test -z "$(grep -ve '^$' -e '^#' < $DONE)" &&
 			die "Cannot 'squash' without a previous commit"
 
 		mark_action_done
@@ -168,20 +170,21 @@ do_next () {
 		MSG="$DOTEST"/message
 		echo "# This is a combination of two commits." > "$MSG"
 		echo "# The first commit's message is:" >> "$MSG"
-		git cat-file commit HEAD | sed -n '/^$/,$p' >> "$MSG"
+		echo >> "$MSG"
+		git cat-file commit HEAD | sed -e '1,/^$/d' >> "$MSG"
 		echo >> "$MSG"
 		echo "# And this is the 2nd commit message:" >> "$MSG"
 		echo >> "$MSG"
-		git cat-file commit $sha1 | sed -n '/^$/,$p' >> "$MSG"
+		git cat-file commit $sha1 | sed -e '1,/^$/d' >> "$MSG"
 		git reset --soft HEAD^
 		author_script=$(get_author_ident_from_commit $sha1)
 		case $failed in
 		f)
 			# This is like --amend, but with a different message
-			eval $author_script
+			eval "$author_script"
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
 			git commit -F "$MSG" -e
-		;;
+			;;
 		t)
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG
 			warn
@@ -192,21 +195,22 @@ do_next () {
 			warn "	  git commit -F \"$GIT_DIR\"/MERGE_MSG -e"
 			die_with_patch $sha1 ""
 		esac
-	;;
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
 	esac
-	test -s "$TODO" && continue
+	test -s "$TODO" && return
 
 	HEAD=$(git rev-parse HEAD)
 	HEADNAME=$(cat "$DOTEST"/head-name)
+# TODO: reflog?
 	git update-ref $HEADNAME $HEAD &&
 	git symbolic-ref HEAD $HEADNAME || exit
 	rm -rf "$DOTEST" &&
 	warn "Successfully rebased and updated $HEADNAME."
 
-	exit $?
+	exit
 }
 
 do_rest () {
@@ -214,12 +218,12 @@ do_rest () {
 	do
 		do_next
 	done
-	test $? = 0 -a -f "$DOTEST"/verbose &&
+	test -f "$DOTEST"/verbose &&
 		git diff --stat $(cat "$DOTEST"/head)..HEAD
 	exit
 }
 
-while case "$#" in 0) break ;; esac
+while case $# in 0) break ;; esac
 do
 	case "$1" in
 	--continue)
@@ -229,7 +233,7 @@ do
 
 		require_clean_work_tree
 		do_rest
-	;;
+		;;
 	--abort)
 		comment_for_reflog abort
 
@@ -241,15 +245,16 @@ do
 		git reset --hard $HEAD &&
 		rm -rf "$DOTEST"
 		exit
-	;;
+		;;
 	--skip)
 		comment_for_reflog skip
 
 		test -d "$DOTEST" || die "No interactive rebase running"
 
 		git reset --hard && do_rest
-	;;
+		;;
 	-s|--strategy)
+		shift
 		case "$#,$1" in
 		*,*=*)
 			STRATEGY="-s `expr "z$1" : 'z-[^=]*=\(.*\)'`" ;;
@@ -259,22 +264,22 @@ do
 			STRATEGY="-s $2"
 			shift ;;
 		esac
-	;;
+		;;
 	--merge)
 		# we use merge anyway
-	;;
+		;;
 	-C*)
 		die "Interactive rebase uses merge, so $1 does not make sense"
-	;;
+		;;
 	-v)
 		VERBOSE=t
-	;;
+		;;
 	-i|--interactive)
 		# yeah, we know
-	;;
+		;;
 	''|-h)
 		usage
-	;;
+		;;
 	*)
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
@@ -295,8 +300,13 @@ do
 
 		require_clean_work_tree
 
-		test -z "$2" || git checkout "$2" ||
-			die "Could not checkout $2"
+		if [ ! -z "$2"]
+		then
+			git show-ref --verify --quiet "refs/heads/$2" ||
+				die "Invalid branchname: $2"
+			git checkout "$2" ||
+				die "Could not checkout $2"
+		fi
 
 		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
 		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
@@ -314,23 +324,25 @@ do
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
 
 		cat > "$TODO" << EOF
-# Reorder by exchanging lines.  Skip by removing lines.  If you want to
-# edit a commit, replace the "pick" command with "edit".  If you want to
-# squash the changes of a commit A into a commit B, place A directly
-# after B, and replace the "pick" command with "squash".
+# Rebasing $UPSTREAM..$HEAD onto $ONTO
+#
+# Commands:
+#  pick = use commit
+#  edit = use commit, but stop for amending
+#  squash = use commit, but meld into previous commit
 EOF
 		git rev-list --no-merges --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse $UPSTREAM..$HEAD | \
 			sed "s/^/pick /" >> "$TODO"
 
-		test -s "$TODO" || die "Nothing to do"
+		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
+			die "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
 		${VISUAL:-${EDITOR:-vi}} "$TODO" ||
 			die "Could not execute editor"
 
 		git reset --hard $ONTO && do_rest
-	;;
 	esac
 	shift
 done
-- 
1.5.2.2.279.g9b198-dirty

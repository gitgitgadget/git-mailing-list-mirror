From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/11] Use GIT_REFLOG_ACTION environment variable instead.
Date: Thu, 28 Dec 2006 02:34:48 -0500
Message-ID: <20061228073448.GA17867@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzpn1-0000sg-JO
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWL1Hew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1Hew
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:34:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45792 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964949AbWL1Hev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:34:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzpmQ-0007vd-Sb; Thu, 28 Dec 2006 02:34:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3C59720FB65; Thu, 28 Dec 2006 02:34:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35523>

Junio rightly pointed out that the --reflog-action parameter
was starting to get out of control, as most porcelain code
needed to hand it to other porcelain and plumbing alike to
ensure the reflog contained the top-level user action and
not the lower-level actions it invoked.

At Junio's suggestion we are introducing the new set_reflog_action
function to all shell scripts, allowing them to declare early on
what their default reflog name should be, but this setting only
takes effect if the caller has not already set the GIT_REFLOG_ACTION
environment variable.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-merge.txt |    6 ------
 git-am.sh                   |    7 ++-----
 git-fetch.sh                |   21 ++++++++-------------
 git-merge.sh                |   13 +++++--------
 git-pull.sh                 |    6 +++---
 git-rebase.sh               |   10 ++++------
 git-sh-setup.sh             |    8 ++++++++
 7 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e2954aa..0f79665 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,6 @@ SYNOPSIS
 --------
 [verse]
 'git-merge' [-n] [--no-commit] [--squash] [-s <strategy>]...
-	[--reflog-action=<action>]
 	-m=<msg> <remote> <remote>...
 
 DESCRIPTION
@@ -37,11 +36,6 @@ include::merge-options.txt[]
 	least one <remote>.  Specifying more than one <remote>
 	obviously means you are trying an Octopus.
 
---reflog-action=<action>::
-	This is used internally when `git-pull` calls this command
-	to record that the merge was created by `pull` command
-	in the `ref-log` entry that results from the merge.
-
 include::merge-strategies.txt[]
 
 
diff --git a/git-am.sh b/git-am.sh
index 0126a77..c3bbd78 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -6,6 +6,7 @@ USAGE='[--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way]
   [--interactive] [--whitespace=<option>] <mbox>...
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
+set_reflog_action am
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
@@ -101,7 +102,6 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-rloga=am
 dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= ws= resolvemsg=
 
 while case "$#" in 0) break;; esac
@@ -141,9 +141,6 @@ do
 	--resolvemsg=*)
 	resolvemsg=$(echo "$1" | sed -e "s/^--resolvemsg=//"); shift ;;
 
-	--reflog-action=*)
-	rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`; shift ;;
-
 	--)
 	shift; break ;;
 	-*)
@@ -452,7 +449,7 @@ do
 	parent=$(git-rev-parse --verify HEAD) &&
 	commit=$(git-commit-tree $tree -p $parent <"$dotest/final-commit") &&
 	echo Committed: $commit &&
-	git-update-ref -m "$rloga: $SUBJECT" HEAD $commit $parent ||
+	git-update-ref -m "$GIT_REFLOG_ACTION: $SUBJECT" HEAD $commit $parent ||
 	stop_here $this
 
 	if test -x "$GIT_DIR"/hooks/post-applypatch
diff --git a/git-fetch.sh b/git-fetch.sh
index 5f31605..8bd11f8 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -4,6 +4,8 @@
 USAGE='<fetch-options> <repository> <refspec>...'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
+set_reflog_action "fetch $*"
+
 TOP=$(git-rev-parse --show-cdup)
 if test ! -z "$TOP"
 then
@@ -17,7 +19,6 @@ LF='
 '
 IFS="$LF"
 
-rloga=fetch
 no_tags=
 tags=
 append=
@@ -60,9 +61,6 @@ do
 	-k|--k|--ke|--kee|--keep)
 		keep='-k -k'
 		;;
-	--reflog-action=*)
-		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		;;
 	--depth=*)
 		shallow_depth="--depth=`expr "z$1" : 'z-[^=]*=\(.*\)'`"
 		;;
@@ -94,9 +92,6 @@ refs=
 rref=
 rsync_slurped_objects=
 
-rloga="$rloga $remote_nick"
-test "$remote_nick" = "$remote" || rloga="$rloga $remote"
-
 if test "" = "$append"
 then
 	: >"$GIT_DIR/FETCH_HEAD"
@@ -180,12 +175,12 @@ update_local_ref () {
 		else
 			echo >&2 "* $1: updating with $3"
 			echo >&2 "  $label_: $newshort_"
-			git-update-ref -m "$rloga: updating tag" "$1" "$2"
+			git-update-ref -m "$GIT_REFLOG_ACTION: updating tag" "$1" "$2"
 		fi
 	else
 		echo >&2 "* $1: storing $3"
 		echo >&2 "  $label_: $newshort_"
-		git-update-ref -m "$rloga: storing tag" "$1" "$2"
+		git-update-ref -m "$GIT_REFLOG_ACTION: storing tag" "$1" "$2"
 	fi
 	;;
 
@@ -208,7 +203,7 @@ update_local_ref () {
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
 		echo >&2 "  old..new: $oldshort_..$newshort_"
-		git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
+		git-update-ref -m "$GIT_REFLOG_ACTION: fast-forward" "$1" "$2" "$local"
 		;;
 	    *)
 		false
@@ -218,7 +213,7 @@ update_local_ref () {
 		*,t,*)
 			echo >&2 "* $1: forcing update to non-fast forward $3"
 			echo >&2 "  old...new: $oldshort_...$newshort_"
-			git-update-ref -m "$rloga: forced-update" "$1" "$2" "$local"
+			git-update-ref -m "$GIT_REFLOG_ACTION: forced-update" "$1" "$2" "$local"
 			;;
 		*)
 			echo >&2 "* $1: not updating to non-fast forward $3"
@@ -230,7 +225,7 @@ update_local_ref () {
 	else
 	    echo >&2 "* $1: storing $3"
 	    echo >&2 "  $label_: $newshort_"
-	    git-update-ref -m "$rloga: storing head" "$1" "$2"
+	    git-update-ref -m "$GIT_REFLOG_ACTION: storing head" "$1" "$2"
 	fi
 	;;
     esac
@@ -479,7 +474,7 @@ case "$orig_head" in
 	if test "$curr_head" != "$orig_head"
 	then
 	    git-update-ref \
-			-m "$rloga: Undoing incorrectly fetched HEAD." \
+			-m "$GIT_REFLOG_ACTION: Undoing incorrectly fetched HEAD." \
 			HEAD "$orig_head"
 		die "Cannot fetch into the current branch."
 	fi
diff --git a/git-merge.sh b/git-merge.sh
index 022d01e..c7e033c 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,9 +3,10 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [--reflog-action=<action>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 . git-sh-setup
+set_reflog_action "merge $*"
 
 LF='
 '
@@ -57,10 +58,10 @@ squash_message () {
 finish () {
 	if test '' = "$2"
 	then
-		rlogm="$rloga"
+		rlogm="$GIT_REFLOG_ACTION"
 	else
 		echo "$2"
-		rlogm="$rloga: $2"
+		rlogm="$GIT_REFLOG_ACTION: $2"
 	fi
 	case "$squash" in
 	t)
@@ -154,7 +155,7 @@ merge_name () {
 
 case "$#" in 0) usage ;; esac
 
-rloga= have_message=
+have_message=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -184,9 +185,6 @@ do
 			die "available strategies are: $all_strategies" ;;
 		esac
 		;;
-	--reflog-action=*)
-		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		;;
 	-m=*|--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
 		merge_msg=`expr "z$1" : 'z-[^=]*=\(.*\)'`
 		have_message=t
@@ -258,7 +256,6 @@ head=$(git-rev-parse --verify "$head_arg"^0) || usage
 
 # All the rest are remote heads
 test "$#" = 0 && usage ;# we need at least one remote head.
-test "$rloga" = '' && rloga="merge: $@"
 
 remoteheads=
 for remote
diff --git a/git-pull.sh b/git-pull.sh
index 1703091..fd4ffb8 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -7,6 +7,7 @@
 USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
+set_reflog_action "pull $*"
 
 strategy_args= no_summary= no_commit= squash=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
@@ -45,7 +46,7 @@ do
 done
 
 orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
-git-fetch --update-head-ok --reflog-action=pull "$@" || exit 1
+git-fetch --update-head-ok "$@" || exit 1
 
 curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 if test "$curr_head" != "$orig_head"
@@ -118,6 +119,5 @@ case "$strategy_args" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-git-merge "--reflog-action=pull $*" \
-	$no_summary $no_commit $squash $strategy_args \
+git-merge $no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/git-rebase.sh b/git-rebase.sh
index ece3142..5c7c4a6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -28,6 +28,7 @@ Example:       git-rebase master~1 topic
   D---E---F---G master          D---E---F---G master
 '
 . git-sh-setup
+set_reflog_action rebase
 
 RESOLVEMSG="
 When you have resolved this problem run \"git rebase --continue\".
@@ -132,8 +133,7 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG" \
-			--reflog-action=rebase
+		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
 	--skip)
@@ -156,8 +156,7 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git am -3 --skip --resolvemsg="$RESOLVEMSG" \
-			--reflog-action=rebase
+		git am -3 --skip --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
 	--abort)
@@ -306,8 +305,7 @@ fi
 if test -z "$do_merge"
 then
 	git-format-patch -k --stdout --full-index --ignore-if-in-upstream "$upstream"..ORIG_HEAD |
-	git am --binary -3 -k --resolvemsg="$RESOLVEMSG" \
-		--reflog-action=rebase
+	git am --binary -3 -k --resolvemsg="$RESOLVEMSG"
 	exit $?
 fi
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 42f9b1c..87b939c 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -20,6 +20,14 @@ usage() {
 	die "Usage: $0 $USAGE"
 }
 
+set_reflog_action() {
+	if [ -z "${GIT_REFLOG_ACTION:+set}" ]
+	then
+		GIT_REFLOG_ACTION="$*"
+		export GIT_REFLOG_ACTION
+	fi
+}
+
 if [ -z "$LONG_USAGE" ]
 then
 	LONG_USAGE="Usage: $0 $USAGE"
-- 
1.4.4.3.gd2e4

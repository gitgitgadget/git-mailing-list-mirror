From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 10/20] rebase: factor out command line option processing
Date: Thu, 25 Nov 2010 20:57:53 +0100
Message-ID: <1290715083-16919-11-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnb0-00026e-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab0KZB6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:51 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab0KZB6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:18 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347966vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vy3KXZS/X1hdVNqXy8htvla8UV//zY65Op4obrwdn0Y=;
        b=h/dT3c5jeCnOq29BKez211JyA612PtvK74oAXKgy2RhpgD2VX2WCU0LDUCF7U5jwJI
         eKp6V01pqBhXaZb1ZeRqCDaw069R+ND4pxJqTv1TYu7Z9leB+iicxJwuyPpMCJ7IJvOd
         crbFNtKA5kScqNZ1XHHxF2pGKNjld3KzD5ygo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dy+4kGz4dZNatmHS2cemQXEeHSG9TMt847MA14NIlR9xE65vAsyRSPifV5wXY9PoBE
         WSLZQBdO9QgrLWi5w7sPnjpMtJqhwtw9/zlJo8cWWdcbi2Di70E+FqO8tzgRNKT50xq0
         K9rZXvTYb7kG1JQFyv/jdwKkDcJ1F0Qqej1gY=
Received: by 10.220.195.67 with SMTP id eb3mr393761vcb.14.1290736696740;
        Thu, 25 Nov 2010 17:58:16 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:16 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162174>

Factor out the command line processing in git-rebase--interactive.sh
to git-rebase.sh. Store the options in variables in git-rebase.sh and
export them before calling git-rebase--interactive.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |  223 ++++++++++++-------------------------------
 git-rebase.sh              |   45 +++++----
 2 files changed, 88 insertions(+), 180 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 886f80b..6389a9f 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,29 +10,6 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 
-OPTIONS_KEEPDASHDASH=
-OPTIONS_SPEC="\
-git-rebase [-i] [options] [--] <upstream> [<branch>]
-git-rebase [-i] (--continue | --abort | --skip)
---
- Available options are
-v,verbose          display a diffstat of what changed upstream
-onto=              rebase onto given branch instead of upstream
-p,preserve-merges  try to recreate merges instead of ignoring them
-s,strategy=        use the given merge strategy
-no-ff              cherry-pick all commits, even if unchanged
-m,merge            always used (no-op)
-i,interactive      always used (no-op)
- Actions:
-continue           continue rebasing process
-abort              abort rebasing process and restore original branch
-skip               skip current patch and continue rebasing process
-no-verify          override pre-rebase hook from stopping the operation
-verify             allow pre-rebase hook to run
-root               rebase all reachable commmits up to the root(s)
-autosquash         move commits that begin with squash!/fixup! under -i
-"
-
 . git-sh-setup
 require_work_tree
 
@@ -105,16 +82,6 @@ AMEND="$DOTEST"/amend
 REWRITTEN_LIST="$DOTEST"/rewritten-list
 REWRITTEN_PENDING="$DOTEST"/rewritten-pending
 
-preserve_merges=
-strategy=
-onto=
-verbose=
-OK_TO_SKIP_PRE_REBASE=
-rebase_root=
-autosquash=
-test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
-force_rebase=
-
 GIT_CHERRY_PICK_HELP="\
 hint: after resolving the conflicts, mark the corrected paths
 hint: with 'git add <paths>' and run 'git rebase --continue'"
@@ -647,15 +614,6 @@ skip_unnecessary_picks () {
 	die "Could not skip unnecessary pick commands"
 }
 
-# check if no other options are set
-is_standalone () {
-	test $# -eq 2 -a "$2" = '--' &&
-	test -z "$onto" &&
-	test -z "$preserve_merges" &&
-	test -z "$strategy" &&
-	test -z "$verbose"
-}
-
 get_saved_options () {
 	test -d "$REWRITTEN" && preserve_merges=t
 	test -f "$DOTEST"/strategy && strategy="$(cat "$DOTEST"/strategy)"
@@ -743,134 +701,77 @@ parse_onto () {
 	git rev-parse --verify "$1^0"
 }
 
-while test $# != 0
-do
-	case "$1" in
-	--no-verify)
-		OK_TO_SKIP_PRE_REBASE=yes
-		;;
-	--verify)
-		OK_TO_SKIP_PRE_REBASE=
-		;;
-	--continue)
-		is_standalone "$@" || usage
-		get_saved_options
-		comment_for_reflog continue
-
-		test -d "$DOTEST" || die "No interactive rebase running"
-
-		# Sanity check
-		git rev-parse --verify HEAD >/dev/null ||
-			die "Cannot read HEAD"
-		git update-index --ignore-submodules --refresh &&
-			git diff-files --quiet --ignore-submodules ||
-			die "Working tree is dirty"
-
-		# do we have anything to commit?
-		if git diff-index --cached --quiet --ignore-submodules HEAD --
+case "$action" in
+continue)
+	get_saved_options
+	comment_for_reflog continue
+
+	test -d "$DOTEST" || die "No interactive rebase running"
+
+	# Sanity check
+	git rev-parse --verify HEAD >/dev/null ||
+		die "Cannot read HEAD"
+	git update-index --ignore-submodules --refresh &&
+		git diff-files --quiet --ignore-submodules ||
+		die "Working tree is dirty"
+
+	# do we have anything to commit?
+	if git diff-index --cached --quiet --ignore-submodules HEAD --
+	then
+		: Nothing to commit -- skip this
+	else
+		. "$AUTHOR_SCRIPT" ||
+			die "Cannot find the author identity"
+		amend=
+		if test -f "$AMEND"
 		then
-			: Nothing to commit -- skip this
-		else
-			. "$AUTHOR_SCRIPT" ||
-				die "Cannot find the author identity"
-			amend=
-			if test -f "$AMEND"
-			then
-				amend=$(git rev-parse --verify HEAD)
-				test "$amend" = $(cat "$AMEND") ||
-				die "\
+			amend=$(git rev-parse --verify HEAD)
+			test "$amend" = $(cat "$AMEND") ||
+			die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
-				git reset --soft HEAD^ ||
-				die "Cannot rewind the HEAD"
-			fi
-			do_with_author git commit --no-verify -F "$MSG" -e || {
-				test -n "$amend" && git reset --soft $amend
-				die "Could not commit staged changes."
-			}
+			git reset --soft HEAD^ ||
+			die "Cannot rewind the HEAD"
 		fi
+		do_with_author git commit --no-verify -F "$MSG" -e || {
+			test -n "$amend" && git reset --soft $amend
+			die "Could not commit staged changes."
+		}
+	fi
 
-		record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
+	record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
 
-		require_clean_work_tree "rebase"
-		do_rest
-		;;
-	--abort)
-		is_standalone "$@" || usage
-		get_saved_options
-		comment_for_reflog abort
-
-		git rerere clear
-		test -d "$DOTEST" || die "No interactive rebase running"
-
-		HEADNAME=$(cat "$DOTEST"/head-name)
-		HEAD=$(cat "$DOTEST"/head)
-		case $HEADNAME in
-		refs/*)
-			git symbolic-ref HEAD $HEADNAME
-			;;
-		esac &&
-		output git reset --hard $HEAD &&
-		rm -rf "$DOTEST"
-		exit
-		;;
-	--skip)
-		is_standalone "$@" || usage
-		get_saved_options
-		comment_for_reflog skip
+	require_clean_work_tree "rebase"
+	do_rest
+	;;
+abort)
+	get_saved_options
+	comment_for_reflog abort
 
-		git rerere clear
-		test -d "$DOTEST" || die "No interactive rebase running"
+	git rerere clear
+	test -d "$DOTEST" || die "No interactive rebase running"
 
-		output git reset --hard && do_rest
-		;;
-	-s)
-		case "$#,$1" in
-		*,*=*)
-			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
-		;;
-	-m)
-		# we use merge anyway
-		;;
-	-v)
-		verbose=t
-		;;
-	-p)
-		preserve_merges=t
-		;;
-	-i)
-		# yeah, we know
-		;;
-	--no-ff)
-		force_rebase=t
-		;;
-	--root)
-		rebase_root=t
-		;;
-	--autosquash)
-		autosquash=t
-		;;
-	--no-autosquash)
-		autosquash=
-		;;
-	--onto)
-		test 2 -le "$#" || usage
-		onto="$2"
-		shift
-		;;
-	--)
-		shift
-		break
+	HEADNAME=$(cat "$DOTEST"/head-name)
+	HEAD=$(cat "$DOTEST"/head)
+	case $HEADNAME in
+	refs/*)
+		git symbolic-ref HEAD $HEADNAME
 		;;
-	esac
-	shift
-done
+	esac &&
+	output git reset --hard $HEAD &&
+	rm -rf "$DOTEST"
+	exit
+	;;
+skip)
+	get_saved_options
+	comment_for_reflog skip
+
+	git rerere clear
+	test -d "$DOTEST" || die "No interactive rebase running"
+
+	output git reset --hard && do_rest
+	;;
+esac
 
 if test -n "$onto"
 then
diff --git a/git-rebase.sh b/git-rebase.sh
index ed1d4f5..df4e184 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -56,6 +56,9 @@ rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
 action=
+preserve_merges=
+autosquash=
+test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
 read_state () {
 	if test -d "$merge_dir"
@@ -171,27 +174,14 @@ finish_rb_merge () {
 	say All done.
 }
 
-is_interactive () {
-	while test $# != 0
-	do
-		case "$1" in
-			-i|--interactive)
-				interactive_rebase=explicit
-				break
-			;;
-			-p|--preserve-merges)
-				interactive_rebase=implied
-			;;
-		esac
-		shift
-	done
-
+run_interactive_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
 	fi
-
-	test -n "$interactive_rebase" || test -f "$merge_dir"/interactive
+	export onto autosquash strategy strategy_opts verbose rebase_root \
+	force_rebase action preserve_merges OK_TO_SKIP_PRE_REBASE
+	exec git-rebase--interactive "$@"
 }
 
 run_pre_rebase_hook () {
@@ -206,8 +196,6 @@ run_pre_rebase_hook () {
 test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
-is_interactive "$@" && exec git-rebase--interactive "$@"
-
 while test $# != 0
 do
 	case "$1" in
@@ -227,6 +215,19 @@ do
 		onto="$2"
 		shift
 		;;
+	-i|--interactive)
+		interactive_rebase=explicit
+		;;
+	-p|--preserve-merges)
+		preserve_merges=t
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
+	--autosquash)
+		autosquash=t
+		;;
+	--no-autosquash)
+		autosquash=
+		;;
 	-M|-m|--m|--me|--mer|--merg|--merge)
 		do_merge=t
 		;;
@@ -351,6 +352,10 @@ valuable there.'
 	test $# -eq 0 && test -z "$rebase_root" && usage
 fi
 
+test -f "$merge_dir"/interactive && interactive_rebase=explicit
+
+test -n "$action" && test -n "$interactive_rebase" && run_interactive_rebase
+
 case "$action" in
 continue)
 	git update-index --ignore-submodules --refresh &&
@@ -409,6 +414,8 @@ abort)
 	;;
 esac
 
+test -n "$interactive_rebase" && run_interactive_rebase "$@"
+
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 if test -z "$rebase_root"
-- 
1.7.3.2.864.gbbb96

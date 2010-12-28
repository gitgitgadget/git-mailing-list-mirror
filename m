From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 10/31] rebase: factor out command line option processing
Date: Tue, 28 Dec 2010 10:30:27 +0100
Message-ID: <1293528648-21873-11-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYj-0005Wr-CT
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab0L1Pct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:49 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43383 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab0L1Pcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:41 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11285887qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xciP1dL/BBDOObZ272zCzL5lqXY7ORiw0qL3bjEMUKc=;
        b=nD87nS6feftx/zWUJVKoN795NCUdDqCvZlB3q7Ox06990Gz7brerpLlOfULb8xOXo/
         v8esGIZpN24Fg1uygTDgLYf9QolfzwwJKqfWevoxDfNjrWKfMIdC0IwsE9iXLKHwLfFr
         5oJiI/abkv1+xwBr1ndfgGXZnZ37/eNeyNwLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dpkKJHVh37X+FEFUZWiTJuZm87LnOYP9qy5+k+pfIEY6gN4uWQ5dtL9tNG/69JUDSM
         ZpX0dtQHbm7OOUdHdbOsJkCZn+Vug1E1duaJEJkbLrxMdLDXxqWTUYjsVRSS+dqcHLIG
         r/lUyn7Cjmeu/Hue9QlUEBDmr2ozPm/TJ4LuQ=
Received: by 10.229.181.9 with SMTP id bw9mr11962959qcb.143.1293550360821;
        Tue, 28 Dec 2010 07:32:40 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:40 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164248>

Factor out the command line processing in git-rebase--interactive.sh
to git-rebase.sh. Store the options in variables in git-rebase.sh and
export them before calling git-rebase--interactive.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Since this removes the command line processing from
git-rebase--interactive.sh, it completely changes its command line
interface. Since it is not listed as even a plumbing command, I hope
this is fine.

 git-rebase--interactive.sh |  224 ++++++++++++--------------------------------
 git-rebase.sh              |   60 ++++++++----
 2 files changed, 102 insertions(+), 182 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1af739a..4d3dc63 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,31 +10,7 @@
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
-require_work_tree
 
 DOTEST="$GIT_DIR/rebase-merge"
 
@@ -105,16 +81,6 @@ AMEND="$DOTEST"/amend
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
@@ -648,15 +614,6 @@ skip_unnecessary_picks () {
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
@@ -744,134 +701,77 @@ parse_onto () {
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
index 21366ba..e646b8f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -64,6 +64,9 @@ type=
 state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
+preserve_merges=
+autosquash=
+test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
 read_state () {
 	if test "$type" = merge
@@ -176,27 +179,14 @@ finish_rb_merge () {
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
@@ -211,8 +201,6 @@ run_pre_rebase_hook () {
 test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
-is_interactive "$@" && exec git-rebase--interactive "$@"
-
 if test -d "$apply_dir"
 then
 	type=am
@@ -249,6 +237,19 @@ do
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
@@ -339,7 +340,11 @@ do
 done
 test $# -gt 2 && usage
 
-test -n "$action" && test -z "$in_progress" && die "No rebase in progress?"
+if test -n "$action"
+then
+	test -z "$in_progress" && die "No rebase in progress?"
+	test "$type" = interactive && run_interactive_rebase
+fi
 
 case "$action" in
 continue)
@@ -415,6 +420,21 @@ fi
 
 test $# -eq 0 && test -z "$rebase_root" && usage
 
+if test -n "$interactive_rebase"
+then
+	type=interactive
+	state_dir="$merge_dir"
+elif test -n "$do_merge"
+then
+	type=merge
+	state_dir="$merge_dir"
+else
+	type=am
+	state_dir="$apply_dir"
+fi
+
+test "$type" = interactive && run_interactive_rebase "$@"
+
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 if test -z "$rebase_root"
-- 
1.7.3.2.864.gbbb96

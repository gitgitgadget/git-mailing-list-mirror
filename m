From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 06/31] rebase: act on command line outside parsing loop
Date: Sun,  6 Feb 2011 13:43:35 -0500
Message-ID: <1297017841-20678-7-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:46:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9cg-0004j0-8k
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab1BFSqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:00 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1BFSpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:45:55 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=j/ER1/fWs6XubRG6OxprPCrmvTRbQ4Coeg+yDH9L+Ug=;
        b=XXt/ddDyEi1qLP9y9fOzto8wf2o4bEGupV1pEB9kVYrFrqEC9ok01j2Co4f9Y23AeN
         TWUOzXVw3x2qvxhWWaCdCGiIBSEOpEZq8dT/KsNVA/FySxfhnDhKHnnt3eCc6qokiQuR
         XjtDmw/OpUo4J8nGCWAnOp3QiC7e5CWHzw9Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZAdGcYnClBHz/mO+r9wIgJh6Inuz9jA0ThsyPw/+GD0FvGzse6ZjBuUKptEyrBseEg
         ew6jXRZB/kW8wiInQcVY6Cq9FErKZt7PGQSA9ofkZXwzPA7ecjPgKautp+B0fEYFgzJi
         lLUcJHmar8CU2uucDMr6rh5QwH5DcLpHtAglg=
Received: by 10.229.235.2 with SMTP id ke2mr12069427qcb.285.1297017954996;
        Sun, 06 Feb 2011 10:45:54 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:54 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166166>

To later be able to use the command line processing in git-rebase.sh
for both interactive and non-interactive rebases, move anything that
is specific to non-interactive rebase outside of the parsing
loop. Keep only parsing and validation of command line options in the
loop.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
May want to view this patch with --ignore-all-space.

 git-rebase--interactive.sh |  300 ++++++++++++++++++++++----------------------
 git-rebase.sh              |  126 ++++++++++---------
 2 files changed, 217 insertions(+), 209 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5873ba4..824f4f3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -866,152 +866,158 @@ first and then run 'git rebase --continue' again."
 		;;
 	--)
 		shift
-		test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
-		test ! -z "$REBASE_ROOT" -a $# -le 1 || usage
-		test -d "$DOTEST" &&
-			die "Interactive rebase already started"
-
-		git var GIT_COMMITTER_IDENT >/dev/null ||
-			die "You need to set your committer info first"
-
-		if test -z "$REBASE_ROOT"
-		then
-			UPSTREAM_ARG="$1"
-			UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-			test -z "$ONTO" && ONTO=$UPSTREAM
-			shift
-		else
-			UPSTREAM=
-			UPSTREAM_ARG=--root
-			test -z "$ONTO" &&
-				die "You must specify --onto when using --root"
-		fi
-		run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
-
-		comment_for_reflog start
-
-		require_clean_work_tree "rebase" "Please commit or stash them."
-
-		if test ! -z "$1"
-		then
-			output git checkout "$1" -- ||
-				die "Could not checkout $1"
-		fi
+		break
+		;;
+	esac
+	shift
+done
 
-		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
-		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
+test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
+test ! -z "$REBASE_ROOT" -a $# -le 1 || usage
+test -d "$DOTEST" &&
+	die "Interactive rebase already started"
 
-		: > "$DOTEST"/interactive || die "Could not mark as interactive"
-		git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
-			echo "detached HEAD" > "$DOTEST"/head-name
+git var GIT_COMMITTER_IDENT >/dev/null ||
+	die "You need to set your committer info first"
 
-		echo $HEAD > "$DOTEST"/head
-		case "$REBASE_ROOT" in
-		'')
-			rm -f "$DOTEST"/rebase-root ;;
-		*)
-			: >"$DOTEST"/rebase-root ;;
-		esac
-		echo $ONTO > "$DOTEST"/onto
-		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
-		test t = "$VERBOSE" && : > "$DOTEST"/verbose
-		if test t = "$PRESERVE_MERGES"
-		then
-			if test -z "$REBASE_ROOT"
-			then
-				mkdir "$REWRITTEN" &&
-				for c in $(git merge-base --all $HEAD $UPSTREAM)
-				do
-					echo $ONTO > "$REWRITTEN"/$c ||
-						die "Could not init rewritten commits"
-				done
-			else
-				mkdir "$REWRITTEN" &&
-				echo $ONTO > "$REWRITTEN"/root ||
-					die "Could not init rewritten commits"
-			fi
-			# No cherry-pick because our first pass is to determine
-			# parents to rewrite and skipping dropped commits would
-			# prematurely end our probe
-			MERGES_OPTION=
-			first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
-		else
-			MERGES_OPTION="--no-merges --cherry-pick"
-		fi
-
-		SHORTHEAD=$(git rev-parse --short $HEAD)
-		SHORTONTO=$(git rev-parse --short $ONTO)
-		if test -z "$REBASE_ROOT"
-			# this is now equivalent to ! -z "$UPSTREAM"
-		then
-			SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
-			REVISIONS=$UPSTREAM...$HEAD
-			SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
-		else
-			REVISIONS=$ONTO...$HEAD
-			SHORTREVISIONS=$SHORTHEAD
-		fi
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --topo-order \
-			$REVISIONS | \
-			sed -n "s/^>//p" |
-		while read -r shortsha1 rest
+if test -z "$REBASE_ROOT"
+then
+	UPSTREAM_ARG="$1"
+	UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
+	test -z "$ONTO" && ONTO=$UPSTREAM
+	shift
+else
+	UPSTREAM=
+	UPSTREAM_ARG=--root
+	test -z "$ONTO" &&
+	die "You must specify --onto when using --root"
+fi
+run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
+
+comment_for_reflog start
+
+require_clean_work_tree "rebase" "Please commit or stash them."
+
+if test ! -z "$1"
+then
+	output git checkout "$1" -- ||
+		die "Could not checkout $1"
+fi
+
+HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
+mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
+
+: > "$DOTEST"/interactive || die "Could not mark as interactive"
+git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
+	echo "detached HEAD" > "$DOTEST"/head-name
+
+echo $HEAD > "$DOTEST"/head
+case "$REBASE_ROOT" in
+'')
+	rm -f "$DOTEST"/rebase-root ;;
+*)
+	: >"$DOTEST"/rebase-root ;;
+esac
+echo $ONTO > "$DOTEST"/onto
+test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
+test t = "$VERBOSE" && : > "$DOTEST"/verbose
+if test t = "$PRESERVE_MERGES"
+then
+	if test -z "$REBASE_ROOT"
+	then
+		mkdir "$REWRITTEN" &&
+		for c in $(git merge-base --all $HEAD $UPSTREAM)
 		do
-			if test t != "$PRESERVE_MERGES"
-			then
-				printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
-			else
-				sha1=$(git rev-parse $shortsha1)
-				if test -z "$REBASE_ROOT"
-				then
-					preserve=t
-					for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
-					do
-						if test -f "$REWRITTEN"/$p -a \( $p != $ONTO -o $sha1 = $first_after_upstream \)
-						then
-							preserve=f
-						fi
-					done
-				else
-					preserve=f
-				fi
-				if test f = "$preserve"
-				then
-					touch "$REWRITTEN"/$sha1
-					printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
-				fi
-			fi
+			echo $ONTO > "$REWRITTEN"/$c ||
+				die "Could not init rewritten commits"
 		done
-
-		# Watch for commits that been dropped by --cherry-pick
-		if test t = "$PRESERVE_MERGES"
+	else
+		mkdir "$REWRITTEN" &&
+		echo $ONTO > "$REWRITTEN"/root ||
+			die "Could not init rewritten commits"
+	fi
+	# No cherry-pick because our first pass is to determine
+	# parents to rewrite and skipping dropped commits would
+	# prematurely end our probe
+	MERGES_OPTION=
+	first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
+else
+	MERGES_OPTION="--no-merges --cherry-pick"
+fi
+
+SHORTHEAD=$(git rev-parse --short $HEAD)
+SHORTONTO=$(git rev-parse --short $ONTO)
+if test -z "$REBASE_ROOT"
+	# this is now equivalent to ! -z "$UPSTREAM"
+then
+	SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
+	REVISIONS=$UPSTREAM...$HEAD
+	SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
+else
+	REVISIONS=$ONTO...$HEAD
+	SHORTREVISIONS=$SHORTHEAD
+fi
+git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
+	--abbrev=7 --reverse --left-right --topo-order \
+	$REVISIONS | \
+	sed -n "s/^>//p" |
+while read -r shortsha1 rest
+do
+	if test t != "$PRESERVE_MERGES"
+	then
+		printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
+	else
+		sha1=$(git rev-parse $shortsha1)
+		if test -z "$REBASE_ROOT"
 		then
-			mkdir "$DROPPED"
-			# Save all non-cherry-picked changes
-			git rev-list $REVISIONS --left-right --cherry-pick | \
-				sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
-			# Now all commits and note which ones are missing in
-			# not-cherry-picks and hence being dropped
-			git rev-list $REVISIONS |
-			while read rev
+			preserve=t
+			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
 			do
-				if test -f "$REWRITTEN"/$rev -a "$(sane_grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
+				if test -f "$REWRITTEN"/$p -a \( $p != $ONTO -o $sha1 = $first_after_upstream \)
 				then
-					# Use -f2 because if rev-list is telling us this commit is
-					# not worthwhile, we don't want to track its multiple heads,
-					# just the history of its first-parent for others that will
-					# be rebasing on top of it
-					git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$DROPPED"/$rev
-					short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
-					sane_grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${TODO}2" "$TODO"
-					rm "$REWRITTEN"/$rev
+					preserve=f
 				fi
 			done
+		else
+			preserve=f
+		fi
+		if test f = "$preserve"
+		then
+			touch "$REWRITTEN"/$sha1
+			printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
 		fi
+	fi
+done
 
-		test -s "$TODO" || echo noop >> "$TODO"
-		test -n "$AUTOSQUASH" && rearrange_squash "$TODO"
-		cat >> "$TODO" << EOF
+# Watch for commits that been dropped by --cherry-pick
+if test t = "$PRESERVE_MERGES"
+then
+	mkdir "$DROPPED"
+	# Save all non-cherry-picked changes
+	git rev-list $REVISIONS --left-right --cherry-pick | \
+		sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
+	# Now all commits and note which ones are missing in
+	# not-cherry-picks and hence being dropped
+	git rev-list $REVISIONS |
+	while read rev
+	do
+		if test -f "$REWRITTEN"/$rev -a "$(sane_grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
+		then
+			# Use -f2 because if rev-list is telling us this commit is
+			# not worthwhile, we don't want to track its multiple heads,
+			# just the history of its first-parent for others that will
+			# be rebasing on top of it
+			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$DROPPED"/$rev
+			short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
+			sane_grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${TODO}2" "$TODO"
+			rm "$REWRITTEN"/$rev
+		fi
+	done
+fi
+
+test -s "$TODO" || echo noop >> "$TODO"
+test -n "$AUTOSQUASH" && rearrange_squash "$TODO"
+cat >> "$TODO" << EOF
 
 # Rebase $SHORTREVISIONS onto $SHORTONTO
 #
@@ -1028,22 +1034,18 @@ first and then run 'git rebase --continue' again."
 #
 EOF
 
-		has_action "$TODO" ||
-			die_abort "Nothing to do"
+has_action "$TODO" ||
+	die_abort "Nothing to do"
 
-		cp "$TODO" "$TODO".backup
-		git_editor "$TODO" ||
-			die_abort "Could not execute editor"
+cp "$TODO" "$TODO".backup
+git_editor "$TODO" ||
+	die_abort "Could not execute editor"
 
-		has_action "$TODO" ||
-			die_abort "Nothing to do"
+has_action "$TODO" ||
+	die_abort "Nothing to do"
 
-		test -d "$REWRITTEN" || test -n "$NEVER_FF" || skip_unnecessary_picks
+test -d "$REWRITTEN" || test -n "$NEVER_FF" || skip_unnecessary_picks
 
-		output git checkout $ONTO || die_abort "could not detach HEAD"
-		git update-ref ORIG_HEAD $HEAD
-		do_rest
-		;;
-	esac
-	shift
-done
+output git checkout $ONTO || die_abort "could not detach HEAD"
+git update-ref ORIG_HEAD $HEAD
+do_rest
diff --git a/git-rebase.sh b/git-rebase.sh
index 1d34d43..e3fd001 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -62,6 +62,8 @@ in_progress=
 type=
 # One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
 state_dir=
+# One of {'', continue, skip, abort}, as parsed from command line
+action=
 
 read_state () {
 	if test "$type" = merge
@@ -236,66 +238,10 @@ do
 	--verify)
 		OK_TO_SKIP_PRE_REBASE=
 		;;
-	--continue)
-		test -z "$in_progress" && die "No rebase in progress?"
-
-		git update-index --ignore-submodules --refresh &&
-		git diff-files --quiet --ignore-submodules || {
-			echo "You must edit all merge conflicts and then"
-			echo "mark them as resolved using git add"
-			exit 1
-		}
-		read_state
-		if test -d "$merge_dir"
-		then
-			continue_merge
-			while test "$msgnum" -le "$end"
-			do
-				call_merge "$msgnum"
-				continue_merge
-			done
-			finish_rb_merge
-			exit
-		fi
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
-		move_to_original_branch
-		exit
-		;;
-	--skip)
-		test -z "$in_progress" && die "No rebase in progress?"
-
-		git reset --hard HEAD || exit $?
-		read_state
-		if test -d "$merge_dir"
-		then
-			git rerere clear
-			msgnum=$(($msgnum + 1))
-			while test "$msgnum" -le "$end"
-			do
-				call_merge "$msgnum"
-				continue_merge
-			done
-			finish_rb_merge
-			exit
-		fi
-		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
-		move_to_original_branch
-		exit
-		;;
-	--abort)
-		test -z "$in_progress" && die "No rebase in progress?"
-
-		git rerere clear
-		read_state
-		case "$head_name" in
-		refs/*)
-			git symbolic-ref HEAD $head_name ||
-			die "Could not move back to $head_name"
-			;;
-		esac
-		git reset --hard $orig_head
-		rm -r "$state_dir"
-		exit
+	--continue|--skip|--abort)
+		action=${1##--}
+		shift
+		break
 		;;
 	--onto)
 		test 2 -le "$#" || usage
@@ -391,6 +337,66 @@ do
 done
 test $# -gt 2 && usage
 
+test -n "$action" && test -z "$in_progress" && die "No rebase in progress?"
+
+case "$action" in
+continue)
+	git update-index --ignore-submodules --refresh &&
+	git diff-files --quiet --ignore-submodules || {
+		echo "You must edit all merge conflicts and then"
+		echo "mark them as resolved using git add"
+		exit 1
+	}
+	read_state
+	if test -d "$merge_dir"
+	then
+		continue_merge
+		while test "$msgnum" -le "$end"
+		do
+			call_merge "$msgnum"
+			continue_merge
+		done
+		finish_rb_merge
+		exit
+	fi
+	git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+	move_to_original_branch
+	exit
+	;;
+skip)
+	git reset --hard HEAD || exit $?
+	read_state
+	if test -d "$merge_dir"
+	then
+		git rerere clear
+		msgnum=$(($msgnum + 1))
+		while test "$msgnum" -le "$end"
+		do
+			call_merge "$msgnum"
+			continue_merge
+		done
+		finish_rb_merge
+		exit
+	fi
+	git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
+	move_to_original_branch
+	exit
+	;;
+abort)
+	git rerere clear
+	read_state
+	case "$head_name" in
+	refs/*)
+		git symbolic-ref HEAD $head_name ||
+		die "Could not move back to $head_name"
+		;;
+	esac
+	git reset --hard $orig_head
+	rm -r "$state_dir"
+	exit
+	;;
+esac
+
 # Make sure no rebase is in progress
 if test -n "$in_progress"
 then
-- 
1.7.4.rc2.33.g8a14f

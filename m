From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 18/31] rebase: extract merge code to new source file
Date: Tue, 28 Dec 2010 10:30:35 +0100
Message-ID: <1293528648-21873-19-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYm-0005Wr-GE
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab0L1PdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab0L1Pcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:55 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=L9PFJUZ2utzsTR/0b4bThViBzgdzBHZ6Uzu9hfY9TzQ=;
        b=g4KeoHz6YPRG4TMjcr49MVmtalDVSLCFKP+oHfACjeGlG+fMMzhel0QcpLQNyfHUe1
         LG8Z4PmmGv9P2dztKc2Fwtm2aH+MZaxsqn0PHDLLcUWxikslIKsw1oLAVnZet2XM9Fcn
         sFsmfxxvr98CzYl+xp+3ARw+aNQMXTK14unEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FgVkcf6VkB7rP6LcCE7TX1/uioOzzQvoXq46U5x5el6Noy7KwRlR9/tfW/bWYi9hXo
         ns9lX9CxzRiIfN0wgr1OaV7cHp7vDa+3ql1cpzi0XPDhQ5epmg+DTF+pSQM6EhxMDEJS
         OWd8KalrrbhnoM+0LiE1s9wb83aKMZ5i8GaTM=
Received: by 10.229.38.140 with SMTP id b12mr12157228qce.161.1293550374620;
        Tue, 28 Dec 2010 07:32:54 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:54 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164254>

Extract the code for merge-based rebase to git-rebase--merge.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

What copyright year? Most of the code is just extracted from
git-rebase.sh, which has copyright year 2005. Does that matter?

Would read_initial_state be a better name than read_basic_state?

 .gitignore           |    1 +
 Makefile             |    1 +
 git-rebase--merge.sh |  154 ++++++++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh        |  167 +++++---------------------------------------------
 4 files changed, 171 insertions(+), 152 deletions(-)
 create mode 100644 git-rebase--merge.sh

diff --git a/.gitignore b/.gitignore
index 87b833c..40506ff 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,6 +103,7 @@
 /git-read-tree
 /git-rebase
 /git-rebase--interactive
+/git-rebase--merge
 /git-receive-pack
 /git-reflog
 /git-relink
diff --git a/Makefile b/Makefile
index ff35154..ffc3a5d 100644
--- a/Makefile
+++ b/Makefile
@@ -370,6 +370,7 @@ SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase--interactive.sh
+SCRIPT_SH += git-rebase--merge.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
new file mode 100644
index 0000000..8cfdcf1
--- /dev/null
+++ b/git-rebase--merge.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Junio C Hamano.
+#
+
+. git-sh-setup
+
+prec=4
+
+read_state () {
+	onto_name=$(cat "$state_dir"/onto_name) &&
+	end=$(cat "$state_dir"/end) &&
+	msgnum=$(cat "$state_dir"/msgnum)
+}
+
+continue_merge () {
+	test -d "$state_dir" || die "$state_dir directory does not exist"
+
+	unmerged=$(git ls-files -u)
+	if test -n "$unmerged"
+	then
+		echo "You still have unmerged paths in your index"
+		echo "did you forget to use git add?"
+		die "$RESOLVEMSG"
+	fi
+
+	cmt=`cat "$state_dir/current"`
+	if ! git diff-index --quiet --ignore-submodules HEAD --
+	then
+		if ! git commit --no-verify -C "$cmt"
+		then
+			echo "Commit failed, please do not call \"git commit\""
+			echo "directly, but instead do one of the following: "
+			die "$RESOLVEMSG"
+		fi
+		if test -z "$GIT_QUIET"
+		then
+			printf "Committed: %0${prec}d " $msgnum
+		fi
+		echo "$cmt $(git rev-parse HEAD^0)" >> "$state_dir/rewritten"
+	else
+		if test -z "$GIT_QUIET"
+		then
+			printf "Already applied: %0${prec}d " $msgnum
+		fi
+	fi
+	test -z "$GIT_QUIET" &&
+	GIT_PAGER='' git log --format=%s -1 "$cmt"
+
+	# onto the next patch:
+	msgnum=$(($msgnum + 1))
+	echo "$msgnum" >"$state_dir/msgnum"
+}
+
+call_merge () {
+	cmt="$(cat "$state_dir/cmt.$1")"
+	echo "$cmt" > "$state_dir/current"
+	hd=$(git rev-parse --verify HEAD)
+	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
+	msgnum=$(cat "$state_dir/msgnum")
+	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
+	eval GITHEAD_$hd='$onto_name'
+	export GITHEAD_$cmt GITHEAD_$hd
+	if test -n "$GIT_QUIET"
+	then
+		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
+	fi
+	test -z "$strategy" && strategy=recursive
+	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
+	rv=$?
+	case "$rv" in
+	0)
+		unset GITHEAD_$cmt GITHEAD_$hd
+		return
+		;;
+	1)
+		git rerere $allow_rerere_autoupdate
+		die "$RESOLVEMSG"
+		;;
+	2)
+		echo "Strategy: $rv $strategy failed, try another" 1>&2
+		die "$RESOLVEMSG"
+		;;
+	*)
+		die "Unknown exit code ($rv) from command:" \
+			"git-merge-$strategy $cmt^ -- HEAD $cmt"
+		;;
+	esac
+}
+
+finish_rb_merge () {
+	move_to_original_branch
+	git notes copy --for-rewrite=rebase < "$state_dir"/rewritten
+	if test -x "$GIT_DIR"/hooks/post-rewrite &&
+		test -s "$state_dir"/rewritten; then
+		"$GIT_DIR"/hooks/post-rewrite rebase < "$state_dir"/rewritten
+	fi
+	rm -r "$state_dir"
+	say All done.
+}
+
+case "$action" in
+continue)
+	read_state
+	continue_merge
+	while test "$msgnum" -le "$end"
+	do
+		call_merge "$msgnum"
+		continue_merge
+	done
+	finish_rb_merge
+	exit
+	;;
+skip)
+	read_state
+	git rerere clear
+	msgnum=$(($msgnum + 1))
+	while test "$msgnum" -le "$end"
+	do
+		call_merge "$msgnum"
+		continue_merge
+	done
+	finish_rb_merge
+	exit
+	;;
+esac
+
+mkdir -p "$state_dir"
+echo "$onto_name" > "$state_dir/onto_name"
+echo "$head_name" > "$state_dir/head-name"
+echo "$onto" > "$state_dir/onto"
+echo "$orig_head" > "$state_dir/orig-head"
+echo "$GIT_QUIET" > "$state_dir/quiet"
+
+msgnum=0
+for cmt in `git rev-list --reverse --no-merges "$revisions"`
+do
+	msgnum=$(($msgnum + 1))
+	echo "$cmt" > "$state_dir/cmt.$msgnum"
+done
+
+echo 1 >"$state_dir/msgnum"
+echo $msgnum >"$state_dir/end"
+
+end=$msgnum
+msgnum=1
+
+while test "$msgnum" -le "$end"
+do
+	call_merge "$msgnum"
+	continue_merge
+done
+
+finish_rb_merge
diff --git a/git-rebase.sh b/git-rebase.sh
index eae2f7a..ee586e8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -48,7 +48,6 @@ strategy_opts=
 do_merge=
 merge_dir="$GIT_DIR"/rebase-merge
 apply_dir="$GIT_DIR"/rebase-apply
-prec=4
 verbose=
 diffstat=
 test "$(git config --bool rebase.stat)" = true && diffstat=t
@@ -68,94 +67,13 @@ preserve_merges=
 autosquash=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
-read_state () {
-	if test "$type" = merge
-	then
-		onto_name=$(cat "$state_dir"/onto_name) &&
-		end=$(cat "$state_dir"/end) &&
-		msgnum=$(cat "$state_dir"/msgnum)
-	fi &&
+read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
 	onto=$(cat "$state_dir"/onto) &&
 	orig_head=$(cat "$state_dir"/orig-head) &&
 	GIT_QUIET=$(cat "$state_dir"/quiet)
 }
 
-continue_merge () {
-	test -d "$merge_dir" || die "$merge_dir directory does not exist"
-
-	unmerged=$(git ls-files -u)
-	if test -n "$unmerged"
-	then
-		echo "You still have unmerged paths in your index"
-		echo "did you forget to use git add?"
-		die "$RESOLVEMSG"
-	fi
-
-	cmt=`cat "$merge_dir/current"`
-	if ! git diff-index --quiet --ignore-submodules HEAD --
-	then
-		if ! git commit --no-verify -C "$cmt"
-		then
-			echo "Commit failed, please do not call \"git commit\""
-			echo "directly, but instead do one of the following: "
-			die "$RESOLVEMSG"
-		fi
-		if test -z "$GIT_QUIET"
-		then
-			printf "Committed: %0${prec}d " $msgnum
-		fi
-		echo "$cmt $(git rev-parse HEAD^0)" >> "$merge_dir/rewritten"
-	else
-		if test -z "$GIT_QUIET"
-		then
-			printf "Already applied: %0${prec}d " $msgnum
-		fi
-	fi
-	test -z "$GIT_QUIET" &&
-	GIT_PAGER='' git log --format=%s -1 "$cmt"
-
-	# onto the next patch:
-	msgnum=$(($msgnum + 1))
-	echo "$msgnum" >"$merge_dir/msgnum"
-}
-
-call_merge () {
-	cmt="$(cat "$merge_dir/cmt.$1")"
-	echo "$cmt" > "$merge_dir/current"
-	hd=$(git rev-parse --verify HEAD)
-	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	msgnum=$(cat "$merge_dir/msgnum")
-	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd='$onto_name'
-	export GITHEAD_$cmt GITHEAD_$hd
-	if test -n "$GIT_QUIET"
-	then
-		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
-	fi
-	test -z "$strategy" && strategy=recursive
-	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
-	rv=$?
-	case "$rv" in
-	0)
-		unset GITHEAD_$cmt GITHEAD_$hd
-		return
-		;;
-	1)
-		git rerere $allow_rerere_autoupdate
-		die "$RESOLVEMSG"
-		;;
-	2)
-		echo "Strategy: $rv $strategy failed, try another" 1>&2
-		die "$RESOLVEMSG"
-		;;
-	*)
-		die "Unknown exit code ($rv) from command:" \
-			"git-merge-$strategy $cmt^ -- HEAD $cmt"
-		;;
-	esac
-}
-
 move_to_original_branch () {
 	case "$head_name" in
 	refs/*)
@@ -168,25 +86,17 @@ move_to_original_branch () {
 	esac
 }
 
-finish_rb_merge () {
-	move_to_original_branch
-	git notes copy --for-rewrite=rebase < "$merge_dir"/rewritten
-	if test -x "$GIT_DIR"/hooks/post-rewrite &&
-		test -s "$merge_dir"/rewritten; then
-		"$GIT_DIR"/hooks/post-rewrite rebase < "$merge_dir"/rewritten
-	fi
-	rm -r "$merge_dir"
-	say All done.
-}
-
-run_interactive_rebase () {
+run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
 	fi
 	export onto autosquash strategy strategy_opts verbose rebase_root \
-	force_rebase action preserve_merges upstream switch_to head_name
-	exec git-rebase--interactive
+	force_rebase action preserve_merges upstream switch_to head_name \
+	state_dir orig_head onto_name GIT_QUIET revisions RESOLVEMSG \
+	allow_rerere_autoupdate
+	export -f move_to_original_branch
+	test "$type" != am && exec git-rebase--$type
 }
 
 run_pre_rebase_hook () {
@@ -343,7 +253,7 @@ test $# -gt 2 && usage
 if test -n "$action"
 then
 	test -z "$in_progress" && die "No rebase in progress?"
-	test "$type" = interactive && run_interactive_rebase
+	test "$type" = interactive && run_specific_rebase
 fi
 
 case "$action" in
@@ -354,44 +264,23 @@ continue)
 		echo "mark them as resolved using git add"
 		exit 1
 	}
-	read_state
-	if test -d "$merge_dir"
-	then
-		continue_merge
-		while test "$msgnum" -le "$end"
-		do
-			call_merge "$msgnum"
-			continue_merge
-		done
-		finish_rb_merge
-		exit
-	fi
+	read_basic_state
+	run_specific_rebase
 	git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	exit
 	;;
 skip)
 	git reset --hard HEAD || exit $?
-	read_state
-	if test -d "$merge_dir"
-	then
-		git rerere clear
-		msgnum=$(($msgnum + 1))
-		while test "$msgnum" -le "$end"
-		do
-			call_merge "$msgnum"
-			continue_merge
-		done
-		finish_rb_merge
-		exit
-	fi
+	read_basic_state
+	run_specific_rebase
 	git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	exit
 	;;
 abort)
 	git rerere clear
-	read_state
+	read_basic_state
 	case "$head_name" in
 	refs/*)
 		git symbolic-ref HEAD $head_name ||
@@ -549,7 +438,7 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
-test "$type" = interactive && run_interactive_rebase
+test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
@@ -591,30 +480,4 @@ fi
 # start doing a rebase with git-merge
 # this is rename-aware if the recursive (default) strategy is used
 
-mkdir -p "$merge_dir"
-echo "$onto_name" > "$merge_dir/onto_name"
-echo "$head_name" > "$merge_dir/head-name"
-echo "$onto" > "$merge_dir/onto"
-echo "$orig_head" > "$merge_dir/orig-head"
-echo "$GIT_QUIET" > "$merge_dir/quiet"
-
-msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
-do
-	msgnum=$(($msgnum + 1))
-	echo "$cmt" > "$merge_dir/cmt.$msgnum"
-done
-
-echo 1 >"$merge_dir/msgnum"
-echo $msgnum >"$merge_dir/end"
-
-end=$msgnum
-msgnum=1
-
-while test "$msgnum" -le "$end"
-do
-	call_merge "$msgnum"
-	continue_merge
-done
-
-finish_rb_merge
+run_specific_rebase
-- 
1.7.3.2.864.gbbb96

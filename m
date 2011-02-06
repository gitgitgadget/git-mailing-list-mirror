From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Sun,  6 Feb 2011 13:43:47 -0500
Message-ID: <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eB-0005ZO-85
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab1BFSqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:21 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab1BFSqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:19 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=poG8ZUfVU0/KthVVuLLz+vpTkIJ3aorquZ9EBQrrL4k=;
        b=wCgSPi0ywlH+RAMIQbRFLA6zqWYo0ciKWualWDL/RAfAn9atlM4FVWOw3DuS1UeqVe
         p74Nci9wj9yL666RH7TdV48PM/Tbrh88GDMruzoDsndMzbceiGp9d/6apLa8d2UqRs9Q
         2ZlT1URcwX8qHydOSGp5cwSBwABvpfGPiVNvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DRTFQQ4ZH7DMVMfMXVcIV8EZRstVlEQ9QbI/etmu6RmQFjpc+CM7sS7jlrVeNBfQFm
         Y+TCJpkpCAhc5Zd/XYiPCbLJij9sFGSp7w1/F6kSP+qWFFSQvTattKnijA08eIWWQPBh
         8xa0IAxNdSI8q9/y3EoKvdMHjBh0FP9DH6bsc=
Received: by 10.224.73.132 with SMTP id q4mr13646488qaj.62.1297017978475;
        Sun, 06 Feb 2011 10:46:18 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:17 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166176>

Extract the code for merge-based rebase to git-rebase--merge.sh.

Suggested-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Changes since v1:

 * As suggested by Johannes Sixt, git-rebase--$type is now sourced
   instead of executed.

What copyright year? Most of the code is just extracted from
git-rebase.sh, which has copyright year 2005. Does that matter?

Would read_initial_state be a better name than read_basic_state?


 .gitignore           |    1 +
 Makefile             |    1 +
 git-rebase--merge.sh |  154 +++++++++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh        |  162 ++++----------------------------------------------
 4 files changed, 167 insertions(+), 151 deletions(-)
 create mode 100644 git-rebase--merge.sh

diff --git a/.gitignore b/.gitignore
index 3dd6ef7..a8b98b4 100644
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
index 775ee83..f47550f 100644
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
index 0000000..c04ce8a
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
+		die "$resolvemsg"
+	fi
+
+	cmt=`cat "$state_dir/current"`
+	if ! git diff-index --quiet --ignore-submodules HEAD --
+	then
+		if ! git commit --no-verify -C "$cmt"
+		then
+			echo "Commit failed, please do not call \"git commit\""
+			echo "directly, but instead do one of the following: "
+			die "$resolvemsg"
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
+		die "$resolvemsg"
+		;;
+	2)
+		echo "Strategy: $rv $strategy failed, try another" 1>&2
+		die "$resolvemsg"
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
index ed34906..44e169f 100755
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
-		die "$resolvemsg"
-	fi
-
-	cmt=`cat "$merge_dir/current"`
-	if ! git diff-index --quiet --ignore-submodules HEAD --
-	then
-		if ! git commit --no-verify -C "$cmt"
-		then
-			echo "Commit failed, please do not call \"git commit\""
-			echo "directly, but instead do one of the following: "
-			die "$resolvemsg"
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
-		die "$resolvemsg"
-		;;
-	2)
-		echo "Strategy: $rv $strategy failed, try another" 1>&2
-		die "$resolvemsg"
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
@@ -168,23 +86,12 @@ move_to_original_branch () {
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
-	. git-rebase--interactive
+	test "$type" != am && . git-rebase--$type
 }
 
 run_pre_rebase_hook () {
@@ -341,7 +248,7 @@ test $# -gt 2 && usage
 if test -n "$action"
 then
 	test -z "$in_progress" && die "No rebase in progress?"
-	test "$type" = interactive && run_interactive_rebase
+	test "$type" = interactive && run_specific_rebase
 fi
 
 case "$action" in
@@ -352,44 +259,23 @@ continue)
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
 	git am --resolved --3way --resolvemsg="$resolvemsg" &&
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
 	git am -3 --skip --resolvemsg="$resolvemsg" &&
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
@@ -548,7 +434,7 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
-test "$type" = interactive && run_interactive_rebase
+test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
@@ -590,30 +476,4 @@ fi
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
1.7.4.rc2.33.g8a14f

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 18/20] rebase -m: extract code to new source file
Date: Thu, 25 Nov 2010 20:58:01 +0100
Message-ID: <1290715083-16919-19-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna8-0001kp-8g
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab0KZB6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:30 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38028 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0KZB62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:28 -0500
Received: by qwb7 with SMTP id 7so1535375qwb.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FzDIFzAy5IYfxcBMB+OzFRD72Je99QkGBSqfmQJMg1g=;
        b=egeGp+n2jK6QoZgIAscsVNxOoofIOaKU+5qI3bEvwyf/IWWKukwCt+6lTECSPKpxyf
         hhvMBChm/Zv/vh+Md/dgz1RQZZkKJCLqakdmln6lablpgduE81J8VFAtLhohkhidJUdx
         pSzc2IJbUEo+UWJlQ6AwypUOuhJPlXqlBXIf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L7291OxZR+OGDQ5ufUD/nEJWI+Fa9dMIb77rQ1IylON7u7GUQTQJ67FIDSkynB1pCQ
         zjVw+am2txjRITKMcQPe2pz+FgRsqwqz1I6AG1iC8FtYtCHqtOXPx9Dwkx84liOwKnL2
         utvt6V1PLvcUgLAUyD4snVt866cBx1f5PoVfM=
Received: by 10.220.200.140 with SMTP id ew12mr2798193vcb.3.1290736707233;
        Thu, 25 Nov 2010 17:58:27 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162171>

Extract the code for merge-based rebase to git-rebase--merge.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 .gitignore           |    1 +
 Makefile             |    1 +
 git-rebase--merge.sh |  154 +++++++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh        |  168 +++++---------------------------------------------
 4 files changed, 172 insertions(+), 152 deletions(-)
 create mode 100644 git-rebase--merge.sh

diff --git a/.gitignore b/.gitignore
index b279de3..8f68f8a 100644
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
index 8357106..213ceaf 100644
--- a/Makefile
+++ b/Makefile
@@ -397,6 +397,7 @@ SCRIPT_SH += git-mergetool.sh
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
index d233da6..0773968 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -48,7 +48,6 @@ strategy_opts=
 do_merge=
 merge_dir="$GIT_DIR"/rebase-merge
 apply_dir="$GIT_DIR"/rebase-apply
-prec=4
 verbose=
 diffstat=$(git config --bool rebase.stat)
 git_am_opt=
@@ -66,94 +65,13 @@ type=
 # One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
 state_dir=
 
-read_state () {
-	if test "$type" = merge
-	then
-		onto_name=$(cat "$merge_dir"/onto_name) &&
-		end=$(cat "$merge_dir"/end) &&
-		msgnum=$(cat "$merge_dir"/msgnum)
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
@@ -166,25 +84,17 @@ move_to_original_branch () {
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
+	in_progress state_dir head_name orig_head GIT_QUIET revisions \
+	RESOLVEMSG
+	export -f move_to_original_branch
+	test "$type" != am && exec git-rebase--$type
 }
 
 run_pre_rebase_hook () {
@@ -362,7 +272,7 @@ valuable there.'
 	test $# -eq 0 && test -z "$rebase_root" && usage
 fi
 
-test -n "$action" && test -n "$interactive_rebase" && run_interactive_rebase
+test -n "$action" && test -n "$interactive_rebase" && run_specific_rebase
 
 case "$action" in
 continue)
@@ -372,44 +282,23 @@ continue)
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
@@ -552,7 +441,7 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
-test -n "$interactive_rebase" && run_interactive_rebase
+test -n "$interactive_rebase" && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
@@ -591,33 +480,8 @@ then
 	exit $ret
 fi
 
+
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

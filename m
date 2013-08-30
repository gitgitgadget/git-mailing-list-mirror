From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 27/28] rebase: remove merge mode
Date: Fri, 30 Aug 2013 00:56:21 -0500
Message-ID: <1377842182-18724-28-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmt-0007tj-2A
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab3H3GCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:02:15 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:46758 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:02:10 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so1452642obp.8
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufnz8AxfvXnjoB76T6Ie5rGiBAARRW1RB1zuSC10mLg=;
        b=AOOi3PhCP/r4OZfV4HFp1nu0DbSLD2kPIa2ZxoXtu33hi6YVbTEYVRXR7F3SWkRHOT
         GUT1pjK2KyEXZVdCiSYtfGtN0mk9/jOjzo5ikhetpy779GvABgZbtGUFEUQE1f3lErbK
         PgFE2GyFNmEi9rspFfyvH49Jw1B9aK4KJYFy63uJV1vX0yLOhhxtqzogMI3+6dzh89eJ
         Z9V7HHb8xDoGBBsrtC0Haxq2Zy36E+KSXyWpm7nXZEbAPEW+C2U3ALSHyaWIMPGTv0bs
         0RuE/lKQo1wdtVyy4pnL7LFvAOP3Syn0YTODYyQKjnzu4cF+alwOpIh5H9/UdwfhmvDa
         GZfA==
X-Received: by 10.60.80.8 with SMTP id n8mr5510876oex.33.1377842529621;
        Thu, 29 Aug 2013 23:02:09 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id a18sm35718153obf.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:02:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233421>

The cherrypick mode does the job.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                        |   1 -
 Makefile                          |   1 -
 git-rebase--interactive.sh        |   2 +-
 git-rebase--merge.sh              | 151 --------------------------------------
 git-rebase.sh                     |  13 +---
 t/t3406-rebase-message.sh         |  14 +---
 t/t3425-rebase-topology-merges.sh |   9 +--
 t/t9903-bash-prompt.sh            |   2 +-
 8 files changed, 7 insertions(+), 186 deletions(-)
 delete mode 100644 git-rebase--merge.sh

diff --git a/.gitignore b/.gitignore
index 3514737..7b64376 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,7 +116,6 @@
 /git-rebase--am
 /git-rebase--cherrypick
 /git-rebase--interactive
-/git-rebase--merge
 /git-receive-pack
 /git-reflog
 /git-relink
diff --git a/Makefile b/Makefile
index 2d6521e..f73e060 100644
--- a/Makefile
+++ b/Makefile
@@ -475,7 +475,6 @@ SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--cherrypick
 SCRIPT_LIB += git-rebase--interactive
-SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e8143ae..58aad45 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -81,7 +81,7 @@ rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
 strategy_args=
-if test -n "$do_merge"
+if test -n "$strategy"
 then
 	strategy_args=${strategy:+--strategy=$strategy}
 	eval '
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
deleted file mode 100644
index 16d1817..0000000
--- a/git-rebase--merge.sh
+++ /dev/null
@@ -1,151 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2010 Junio C Hamano.
-#
-
-prec=4
-
-read_state () {
-	onto_name=$(cat "$state_dir"/onto_name) &&
-	end=$(cat "$state_dir"/end) &&
-	msgnum=$(cat "$state_dir"/msgnum)
-}
-
-continue_merge () {
-	test -d "$state_dir" || die "$state_dir directory does not exist"
-
-	unmerged=$(git ls-files -u)
-	if test -n "$unmerged"
-	then
-		echo "You still have unmerged paths in your index"
-		echo "did you forget to use git add?"
-		die "$resolvemsg"
-	fi
-
-	cmt=`cat "$state_dir/current"`
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
-		echo "$cmt $(git rev-parse HEAD^0)" >> "$state_dir/rewritten"
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
-	echo "$msgnum" >"$state_dir/msgnum"
-}
-
-call_merge () {
-	cmt="$(cat "$state_dir/cmt.$1")"
-	echo "$cmt" > "$state_dir/current"
-	hd=$(git rev-parse --verify HEAD)
-	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	msgnum=$(cat "$state_dir/msgnum")
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
-		echo "Strategy: $strategy failed, try another" 1>&2
-		die "$resolvemsg"
-		;;
-	*)
-		die "Unknown exit code ($rv) from command:" \
-			"git-merge-$strategy $cmt^ -- HEAD $cmt"
-		;;
-	esac
-}
-
-finish_rb_merge () {
-	move_to_original_branch
-	if test -s "$state_dir"/rewritten
-	then
-		git notes copy --for-rewrite=rebase <"$state_dir"/rewritten
-		if test -x "$GIT_DIR"/hooks/post-rewrite
-		then
-			"$GIT_DIR"/hooks/post-rewrite rebase <"$state_dir"/rewritten
-		fi
-	fi
-	say All done.
-}
-
-case "$action" in
-continue)
-	read_state
-	continue_merge
-	while test "$msgnum" -le "$end"
-	do
-		call_merge "$msgnum"
-		continue_merge
-	done
-	finish_rb_merge
-	return
-	;;
-skip)
-	read_state
-	git rerere clear
-	msgnum=$(($msgnum + 1))
-	while test "$msgnum" -le "$end"
-	do
-		call_merge "$msgnum"
-		continue_merge
-	done
-	finish_rb_merge
-	return
-	;;
-esac
-
-mkdir -p "$state_dir"
-echo "$onto_name" > "$state_dir/onto_name"
-write_basic_state
-
-msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
-do
-	msgnum=$(($msgnum + 1))
-	echo "$cmt" > "$state_dir/cmt.$msgnum"
-done
-
-echo 1 >"$state_dir/msgnum"
-echo $msgnum >"$state_dir/end"
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
diff --git a/git-rebase.sh b/git-rebase.sh
index f0291df..7390c59 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,7 +59,6 @@ unset onto
 cmd=
 strategy=
 strategy_opts=
-do_merge=
 merge_dir="$GIT_DIR"/rebase-merge
 apply_dir="$GIT_DIR"/rebase-apply
 verbose=
@@ -204,11 +203,8 @@ then
 	then
 		type=interactive
 		interactive_rebase=explicit
-	elif test -f "$merge_dir"/cherrypick
-	then
-		type=cherrypick
 	else
-		type=merge
+		type=cherrypick
 	fi
 	state_dir="$merge_dir"
 fi
@@ -255,18 +251,15 @@ do
 		autosquash=
 		;;
 	-M|-m)
-		do_merge=t
 		;;
 	-X)
 		shift
 		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$1")"
-		do_merge=t
 		test -z "$strategy" && strategy=recursive
 		;;
 	-s)
 		shift
 		strategy="$1"
-		do_merge=t
 		;;
 	-n)
 		diffstat=
@@ -411,10 +404,6 @@ if test -n "$interactive_rebase"
 then
 	type=interactive
 	state_dir="$merge_dir"
-elif test -n "$do_merge"
-then
-	type=merge
-	state_dir="$merge_dir"
 elif test -n "$git_am_opt"
 then
 	type=am
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0392e36..730e503 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -17,20 +17,8 @@ test_expect_success 'setup' '
 	git tag start
 '
 
-cat >expect <<\EOF
-Already applied: 0001 A
-Already applied: 0002 B
-Committed: 0003 Z
-EOF
-
-test_expect_success 'rebase -m' '
-	git rebase -m master >report &&
-	sed -n -e "/^Already applied: /p" \
-		-e "/^Committed: /p" report >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'rebase against master twice' '
+	git rebase master &&
 	git rebase master >out &&
 	test_i18ngrep "Current branch topic is up to date" out
 '
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 99b4535..9cd3480 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -70,9 +70,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" d..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
 test_run_rebase success 'n o e' ''
-test_run_rebase success 'e n o' -m
+test_run_rebase success 'n o e' -m
 test_run_rebase success 'n o e' -i
 
 test_run_rebase () {
@@ -87,9 +86,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
 test_run_rebase success 'd n o e' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 test_run_rebase () {
@@ -104,9 +102,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
 test_run_rebase success 'd n o e' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 test_expect_success "rebase -p is no-op in non-linear history" "
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 3c3e4e8..32170bb 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -158,7 +158,7 @@ test_expect_success 'prompt - interactive rebase' '
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-m 1/3)" >expected &&
+	printf " (b2|REBASE 1/3)" > expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
-- 
1.8.4-fc

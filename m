From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 35/36] rebase: remove merge mode
Date: Sun,  9 Jun 2013 14:24:49 -0500
Message-ID: <1370805890-3453-36-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllI4-00048m-Tm
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab3FIT2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:34 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:63885 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab3FIT2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:25 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so9054807obc.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YO9/SZRla8w1SZvvwYWIgApw3YGXZRZq9ZXkhxL+dRg=;
        b=vw8ZJZeIiM6iGXJpm6aIyccsLHu+Xjq9rabkr2sbNm0iA7wAjuwcKG+JQBMWXAhvIc
         zVw9tC8/TuGwYVZxub1s+D9sPg6yPCxj2NDFZqpI420iYQPzxi71jF37GXxA9jqEvdNp
         rYoh+g6FsLixRMbAiGpELS9arC35A8fYrxysrpr/iUzXu/u+16cUzsK1E4bmmnE2LdZX
         rytLszRDi/UsE3uXyqCkRFkGQn/50SGYL047o80pV/+ZGfXMxwHtfXi42CO29Z59uxdf
         6qJLOJyg7CYfXce9jdCqKEsO/BF6B0cyrJGDkTo3Zdp2j04CT3Q3/pYVcIpp2cnqPXTU
         KsaA==
X-Received: by 10.60.125.5 with SMTP id mm5mr5509808oeb.81.1370806104610;
        Sun, 09 Jun 2013 12:28:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm16060516obc.0.2013.06.09.12.28.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227143>

The cherrypick mode does the job.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile                         |   1 -
 contrib/completion/git-prompt.sh |   4 +-
 git-rebase--merge.sh             | 151 ---------------------------------------
 git-rebase.sh                    |  13 +---
 t/t3406-rebase-message.sh        |  15 ----
 t/t9903-bash-prompt.sh           |   2 +-
 6 files changed, 3 insertions(+), 183 deletions(-)
 delete mode 100644 git-rebase--merge.sh

diff --git a/Makefile b/Makefile
index 4719979..609fa9e 100644
--- a/Makefile
+++ b/Makefile
@@ -475,7 +475,6 @@ SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--cherrypick
 SCRIPT_LIB += git-rebase--interactive
-SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 3d10f21..5036795 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -352,12 +352,10 @@ __git_ps1 ()
 			total=$(cat "$g/rebase-merge/end")
 			if [ -f "$g/rebase-merge/interactive" ]; then
 				r="|REBASE-i"
-			elif [ -f "$g/rebase-merge/cherrypick" ]; then
+			else
 				r="|REBASE"
 				step=$(cat "$g/sequencer/rewritten" | wc -l)
 				let step+=1
-			else
-				r="|REBASE-m"
 			fi
 		else
 			if [ -d "$g/rebase-apply" ]; then
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
index f2efff9..8ddf270 100755
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
@@ -205,11 +204,8 @@ then
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
@@ -256,18 +252,15 @@ do
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
@@ -412,10 +405,6 @@ if test -n "$interactive_rebase"
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
index e6a9a0d..37d19c5 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -27,21 +27,6 @@ test_expect_success setup '
 
 '
 
-cat >expect <<\EOF
-Already applied: 0001 A
-Already applied: 0002 B
-Committed: 0003 Z
-EOF
-
-test_expect_success 'rebase -m' '
-
-	git rebase -m master >report &&
-	sed -n -e "/^Already applied: /p" \
-		-e "/^Committed: /p" report >actual &&
-	test_cmp expect actual
-
-'
-
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
         git rebase --stat master >diffstat.txt &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 15521cc..2e46f93 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -266,7 +266,7 @@ EOF
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-m 1/3)" > expected &&
+	printf " (b2|REBASE 1/3)" > expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
-- 
1.8.3.698.g079b096

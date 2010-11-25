From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 01/20] rebase: clearer names for directory variables
Date: Thu, 25 Nov 2010 20:57:44 +0100
Message-ID: <1290715083-16919-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna5-0001kp-IF
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab0KZB6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:15 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62199 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab0KZB6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:07 -0500
Received: by vws3 with SMTP id 3so347969vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AE3/UekSpOGXL903f8zRQpNhWOmQnpr4XZpHSLMzid8=;
        b=xRmXNHFhGGlVXl+e1kw0ldRUIJ57Kgj7djDh8LxIntqsQT+lqekTEDspqjyJrYGsSN
         9ZHoFUIy9KPZ6/XYYSk0f/n21s5zT3UDc6IFF+60+3cElSRe74yuoJJNiE4pCayplfjj
         jgJ81ozfL+Q/3lymhbzRWRnDCo6LDT/IMiiYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CASMh3GQb4Kq2aGOjQrdba1J4tG6VEOLG1ZZsTTtgRP1hH+h5+4vRkmhMbkLRkLnf4
         0pExGLdD/9eLNpvzNs9i0lxOwLHgjmE7v94wa3mawYi5cJPM/37k7SDVZ1hqgAHDMDM4
         b4hH80ks2NIOGRhuMVTqVvHcb0jfjQTsVM3Mw=
Received: by 10.220.90.203 with SMTP id j11mr390281vcm.197.1290736686218;
        Thu, 25 Nov 2010 17:58:06 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:05 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162168>

Instead of using the old variable name 'dotest' for
"$GIT_DIR"/rebase-merge and no variable for "$GIT_DIR"/rebase-apply,
introduce two variables 'merge_dir' and 'apply_dir' for these paths.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |  141 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 933ca49..a529bab 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -46,7 +46,8 @@ unset newbase
 strategy=recursive
 strategy_opts=
 do_merge=
-dotest="$GIT_DIR"/rebase-merge
+merge_dir="$GIT_DIR"/rebase-merge
+apply_dir="$GIT_DIR"/rebase-apply
 prec=4
 verbose=
 diffstat=$(git config --bool rebase.stat)
@@ -57,7 +58,7 @@ allow_rerere_autoupdate=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
-	test -d "$dotest" || die "$dotest directory does not exist"
+	test -d "$merge_dir" || die "$merge_dir directory does not exist"
 
 	unmerged=$(git ls-files -u)
 	if test -n "$unmerged"
@@ -67,7 +68,7 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
-	cmt=`cat "$dotest/current"`
+	cmt=`cat "$merge_dir/current"`
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
 		if ! git commit --no-verify -C "$cmt"
@@ -80,7 +81,7 @@ continue_merge () {
 		then
 			printf "Committed: %0${prec}d " $msgnum
 		fi
-		echo "$cmt $(git rev-parse HEAD^0)" >> "$dotest/rewritten"
+		echo "$cmt $(git rev-parse HEAD^0)" >> "$merge_dir/rewritten"
 	else
 		if test -z "$GIT_QUIET"
 		then
@@ -92,22 +93,22 @@ continue_merge () {
 
 	prev_head=`git rev-parse HEAD^0`
 	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$dotest/prev_head"
+	echo "$prev_head" > "$merge_dir/prev_head"
 
 	# onto the next patch:
 	msgnum=$(($msgnum + 1))
-	echo "$msgnum" >"$dotest/msgnum"
+	echo "$msgnum" >"$merge_dir/msgnum"
 }
 
 call_merge () {
-	cmt="$(cat "$dotest/cmt.$1")"
-	echo "$cmt" > "$dotest/current"
+	cmt="$(cat "$merge_dir/cmt.$1")"
+	echo "$cmt" > "$merge_dir/current"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	msgnum=$(cat "$dotest/msgnum")
-	end=$(cat "$dotest/end")
+	msgnum=$(cat "$merge_dir/msgnum")
+	end=$(cat "$merge_dir/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'
+	eval GITHEAD_$hd='$(cat "$merge_dir/onto_name")'
 	export GITHEAD_$cmt GITHEAD_$hd
 	if test -n "$GIT_QUIET"
 	then
@@ -137,9 +138,9 @@ call_merge () {
 
 move_to_original_branch () {
 	test -z "$head_name" &&
-		head_name="$(cat "$dotest"/head-name)" &&
-		onto="$(cat "$dotest"/onto)" &&
-		orig_head="$(cat "$dotest"/orig-head)"
+		head_name="$(cat "$merge_dir"/head-name)" &&
+		onto="$(cat "$merge_dir"/onto)" &&
+		orig_head="$(cat "$merge_dir"/orig-head)"
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
@@ -153,12 +154,12 @@ move_to_original_branch () {
 
 finish_rb_merge () {
 	move_to_original_branch
-	git notes copy --for-rewrite=rebase < "$dotest"/rewritten
+	git notes copy --for-rewrite=rebase < "$merge_dir"/rewritten
 	if test -x "$GIT_DIR"/hooks/post-rewrite &&
-		test -s "$dotest"/rewritten; then
-		"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+		test -s "$merge_dir"/rewritten; then
+		"$GIT_DIR"/hooks/post-rewrite rebase < "$merge_dir"/rewritten
 	fi
-	rm -r "$dotest"
+	rm -r "$merge_dir"
 	say All done.
 }
 
@@ -182,7 +183,7 @@ is_interactive () {
 		export GIT_EDITOR
 	fi
 
-	test -n "$interactive_rebase" || test -f "$dotest"/interactive
+	test -n "$interactive_rebase" || test -f "$merge_dir"/interactive
 }
 
 run_pre_rebase_hook () {
@@ -194,7 +195,7 @@ run_pre_rebase_hook () {
 	fi
 }
 
-test -f "$GIT_DIR"/rebase-apply/applying &&
+test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
 is_interactive "$@" && exec git-rebase--interactive "$@"
@@ -209,7 +210,7 @@ do
 		OK_TO_SKIP_PRE_REBASE=
 		;;
 	--continue)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+		test -d "$merge_dir" -o -d "$apply_dir" ||
 			die "No rebase in progress?"
 
 		git update-index --ignore-submodules --refresh &&
@@ -218,13 +219,13 @@ do
 			echo "mark them as resolved using git add"
 			exit 1
 		}
-		if test -d "$dotest"
+		if test -d "$merge_dir"
 		then
-			prev_head=$(cat "$dotest/prev_head")
-			end=$(cat "$dotest/end")
-			msgnum=$(cat "$dotest/msgnum")
-			onto=$(cat "$dotest/onto")
-			GIT_QUIET=$(cat "$dotest/quiet")
+			prev_head=$(cat "$merge_dir/prev_head")
+			end=$(cat "$merge_dir/end")
+			msgnum=$(cat "$merge_dir/msgnum")
+			onto=$(cat "$merge_dir/onto")
+			GIT_QUIET=$(cat "$merge_dir/quiet")
 			continue_merge
 			while test "$msgnum" -le "$end"
 			do
@@ -234,28 +235,28 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
-		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
-		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
+		head_name=$(cat "$apply_dir"/head-name) &&
+		onto=$(cat "$apply_dir"/onto) &&
+		orig_head=$(cat "$apply_dir"/orig-head) &&
+		GIT_QUIET=$(cat "$apply_dir"/quiet)
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--skip)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+		test -d "$merge_dir" -o -d "$apply_dir" ||
 			die "No rebase in progress?"
 
 		git reset --hard HEAD || exit $?
-		if test -d "$dotest"
+		if test -d "$merge_dir"
 		then
 			git rerere clear
-			prev_head=$(cat "$dotest/prev_head")
-			end=$(cat "$dotest/end")
-			msgnum=$(cat "$dotest/msgnum")
+			prev_head=$(cat "$merge_dir/prev_head")
+			end=$(cat "$merge_dir/end")
+			msgnum=$(cat "$merge_dir/msgnum")
 			msgnum=$(($msgnum + 1))
-			onto=$(cat "$dotest/onto")
-			GIT_QUIET=$(cat "$dotest/quiet")
+			onto=$(cat "$merge_dir/onto")
+			GIT_QUIET=$(cat "$merge_dir/quiet")
 			while test "$msgnum" -le "$end"
 			do
 				call_merge "$msgnum"
@@ -264,31 +265,31 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
-		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
-		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
+		head_name=$(cat "$apply_dir"/head-name) &&
+		onto=$(cat "$apply_dir"/onto) &&
+		orig_head=$(cat "$apply_dir"/orig-head) &&
+		GIT_QUIET=$(cat "$apply_dir"/quiet)
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--abort)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+		test -d "$merge_dir" -o -d "$apply_dir" ||
 			die "No rebase in progress?"
 
 		git rerere clear
 
-		test -d "$dotest" || dotest="$GIT_DIR"/rebase-apply
+		test -d "$merge_dir" || merge_dir="$apply_dir"
 
-		head_name="$(cat "$dotest"/head-name)" &&
+		head_name="$(cat "$merge_dir"/head-name)" &&
 		case "$head_name" in
 		refs/*)
 			git symbolic-ref HEAD $head_name ||
 			die "Could not move back to $head_name"
 			;;
 		esac
-		git reset --hard $(cat "$dotest/orig-head")
-		rm -r "$dotest"
+		git reset --hard $(cat "$merge_dir/orig-head")
+		rm -r "$merge_dir"
 		exit
 		;;
 	--onto)
@@ -387,31 +388,31 @@ test $# -gt 2 && usage
 
 if test $# -eq 0 && test -z "$rebase_root"
 then
-	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
-	test -d "$dotest" -o -f "$GIT_DIR"/rebase-apply/rebasing &&
+	test -d "$merge_dir" -o -d "$apply_dir" || usage
+	test -d "$merge_dir" -o -f "$apply_dir"/rebasing &&
 		die 'A rebase is in progress, try --continue, --skip or --abort.'
 fi
 
-# Make sure we do not have $GIT_DIR/rebase-apply
+# Make sure we do not have $apply_dir or $merge_dir
 if test -z "$do_merge"
 then
-	if mkdir "$GIT_DIR"/rebase-apply 2>/dev/null
+	if mkdir "$apply_dir" 2>/dev/null
 	then
-		rmdir "$GIT_DIR"/rebase-apply
+		rmdir "$apply_dir"
 	else
 		echo >&2 '
 It seems that I cannot create a rebase-apply directory, and
 I wonder if you are in the middle of patch application or another
 rebase.  If that is not the case, please
-	rm -fr '"$GIT_DIR"'/rebase-apply
+	rm -fr '"$apply_dir"'
 and run me again.  I am stopping in case you still have something
 valuable there.'
 		exit 1
 	fi
 else
-	if test -d "$dotest"
+	if test -d "$merge_dir"
 	then
-		die "previous rebase directory $dotest still exists." \
+		die "previous rebase directory $merge_dir still exists." \
 			'Try git rebase (--continue | --abort | --skip)'
 	fi
 fi
@@ -559,35 +560,35 @@ then
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
-	test 0 != $ret -a -d "$GIT_DIR"/rebase-apply &&
-		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
-		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
-		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head &&
-		echo "$GIT_QUIET" > "$GIT_DIR"/rebase-apply/quiet
+	test 0 != $ret -a -d "$apply_dir" &&
+		echo $head_name > "$apply_dir/head-name" &&
+		echo $onto > "$apply_dir/onto" &&
+		echo $orig_head > "$apply_dir/orig-head" &&
+		echo "$GIT_QUIET" > "$apply_dir/quiet"
 	exit $ret
 fi
 
 # start doing a rebase with git-merge
 # this is rename-aware if the recursive (default) strategy is used
 
-mkdir -p "$dotest"
-echo "$onto" > "$dotest/onto"
-echo "$onto_name" > "$dotest/onto_name"
+mkdir -p "$merge_dir"
+echo "$onto" > "$merge_dir/onto"
+echo "$onto_name" > "$merge_dir/onto_name"
 prev_head=$orig_head
-echo "$prev_head" > "$dotest/prev_head"
-echo "$orig_head" > "$dotest/orig-head"
-echo "$head_name" > "$dotest/head-name"
-echo "$GIT_QUIET" > "$dotest/quiet"
+echo "$prev_head" > "$merge_dir/prev_head"
+echo "$orig_head" > "$merge_dir/orig-head"
+echo "$head_name" > "$merge_dir/head-name"
+echo "$GIT_QUIET" > "$merge_dir/quiet"
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$revisions"`
 do
 	msgnum=$(($msgnum + 1))
-	echo "$cmt" > "$dotest/cmt.$msgnum"
+	echo "$cmt" > "$merge_dir/cmt.$msgnum"
 done
 
-echo 1 >"$dotest/msgnum"
-echo $msgnum >"$dotest/end"
+echo 1 >"$merge_dir/msgnum"
+echo $msgnum >"$merge_dir/end"
 
 end=$msgnum
 msgnum=1
-- 
1.7.3.2.864.gbbb96

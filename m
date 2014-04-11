From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Fri, 11 Apr 2014 01:28:17 -0700
Message-ID: <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 10:28:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYWpD-0003Dh-2T
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 10:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbaDKI2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 04:28:31 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43618 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbaDKI22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 04:28:28 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so5120965pbc.20
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YXimwF7wPKaNZzpsVSmoU8jygfcPMAWS8O1dvmneOwU=;
        b=Jh4GSaKJHjo01ShLsGb/5s2yzjKDL2XFLojJiWzqe+DwhrADYprH0HTQ128/+RVMTH
         8IEnrv434vuYBYrdXplHnOEVymhOBJQHbLgHSyTv1GHWoQjA6VMMANN748fAuDwTGKG7
         Gt7BHkLPVffPWu5UluijuAstoK3moL7Cuhr1ccXGS5Xl6CO/PcE8lINxpzkv/uWJ9Z1a
         BAnYuO7NufyRRPpYV9HTN05NmgygIgX4FC1oTnhgRXEarRZdH/1DuL02XDgp2SfPE30a
         qtoH6dJpjjNOw583o+OwJQ6CMvSgp6VhRHoCZNUOp41E26plfO4hE1gy8r6jJHU/QSEj
         pTYw==
X-Received: by 10.68.254.5 with SMTP id ae5mr25410607pbd.83.1397204907423;
        Fri, 11 Apr 2014 01:28:27 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ky8sm14002027pbc.64.2014.04.11.01.28.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 01:28:26 -0700 (PDT)
In-Reply-To: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246070>

Since a1549e10, 15d4bf2e and 01a1e646 (first appearing in v1.8.4) the
git-rebase--*.sh scripts have used a "return" to return from the "dot"
command that runs them.  While this is allowed by POSIX, the FreeBSD
/bin/sh utility behaves poorly under some circumstances when such a
"return" is executed.

In particular, if the "dot" command is contained within a function,
then when a "return" is executed by the script it runs (that is not
itself inside a function), control will return from the function
that contains the "dot" command skipping any statements that might
follow the dot command inside that function.  Commit 99855ddf (first
appearing in v1.8.4.1) addresses this by making the "dot" command
the last line in the function.  Unfortunately the FreeBSD /bin/sh
may also execute some statements in the script run by the "dot"
command that appear after the troublesome "return".  The fix in
99855ddf does not address this problem.

For example, if you have script1.sh with these contents:

#!/bin/sh
# script1.sh
run_script2() {
        . "$(dirname -- "$0")/script2.sh"
        _e=$?
        echo only this line should show
        [ $_e -eq 5 ] || echo expected status 5 got $_e
        return 3
}
run_script2
e=$?
[ $e -eq 3 ] || { echo expected status 3 got $e; exit 1; }

And script2.sh with these contents:

# script2.sh
if [ 5 -gt 3 ]; then
        return 5
fi
case bad in *)
        echo always shows
esac
echo should not get here
! :

When running script1.sh (e.g. '/bin/sh script1.sh' or './script1.sh'
after making it executable), the expected output from a POSIX shell
is simply the single line:

only this line should show

However, when run using FreeBSD's /bin/sh, the following output
appears instead:

should not get here
expected status 3 got 1

Not only did the lines following the "dot" command in the run_script2
function in script1.sh get skipped, but additional lines in script2.sh
following the "return" got executed -- but not all of them (e.g. the
"echo always shows" line did not run).

These issues can be avoided by not using a top-level "return" in
script2.sh.  If script2.sh is changed to this:

# script2.sh fixed
main() {
        if [ 5 -gt 3 ]; then
                return 5
        fi
        case bad in *)
                echo always shows
        esac
        echo should not get here
        ! :
}
main

Then it behaves the same when using FreeBSD's /bin/sh as when using
other more POSIX compliant /bin/sh implementations.

We fix the git-rebase--*.sh scripts in a similar fashion by moving
the top-level code that contains "return" statements into its own
function and then calling that as the last line in the script.

The changes introduced by this commit are best viewed with the
--ignore-all-space (-w) diff option.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

---
 git-rebase--am.sh          | 117 ++++++++--------
 git-rebase--interactive.sh | 335 +++++++++++++++++++++++----------------------
 git-rebase--merge.sh       |  87 ++++++------
 3 files changed, 274 insertions(+), 265 deletions(-)


For convenience, here are the diffs using -w:

|--- a/git-rebase--am.sh
|+++ b/git-rebase--am.sh
|@@ -4,6 +4,7 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+git_rebase__am() {
 	case "$action" in
 	continue)
 		git am --resolved --resolvemsg="$resolvemsg" &&
|@@ -73,3 +74,5 @@ then
 	fi
 
 	move_to_original_branch
+}
+git_rebase__am

|--- a/git-rebase--interactive.sh
|+++ b/git-rebase--interactive.sh
|@@ -810,6 +810,7 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
 
+git_rebase__interactive() {
 	case "$action" in
 	continue)
 		# do we have anything to commit?
|@@ -1042,3 +1043,5 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 	output git checkout $onto || die_abort "could not detach HEAD"
 	git update-ref ORIG_HEAD $orig_head
 	do_rest
+}
+git_rebase__interactive

|--- a/git-rebase--merge.sh
|+++ b/git-rebase--merge.sh
|@@ -101,6 +101,7 @@ finish_rb_merge () {
 	say All done.
 }
 
+git_rebase__merge() {
 	case "$action" in
 	continue)
 		read_state
|@@ -151,3 +152,5 @@ do
 	done
 
 	finish_rb_merge
+}
+git_rebase__merge


diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index a4f683a5..2d3f6d55 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,72 +4,75 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
-case "$action" in
-continue)
-	git am --resolved --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
-	return
-	;;
-skip)
-	git am --skip --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
-	return
-	;;
-esac
-
-test -n "$rebase_root" && root_flag=--root
-
-ret=0
-if test -n "$keep_empty"
-then
-	# we have to do this the hard way.  git format-patch completely squashes
-	# empty commits and even if it didn't the format doesn't really lend
-	# itself well to recording empty patches.  fortunately, cherry-pick
-	# makes this easy
-	git cherry-pick --allow-empty "$revisions"
-	ret=$?
-else
-	rm -f "$GIT_DIR/rebased-patches"
+git_rebase__am() {
+	case "$action" in
+	continue)
+		git am --resolved --resolvemsg="$resolvemsg" &&
+		move_to_original_branch
+		return
+		;;
+	skip)
+		git am --skip --resolvemsg="$resolvemsg" &&
+		move_to_original_branch
+		return
+		;;
+	esac
 
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-		$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
-	ret=$?
+	test -n "$rebase_root" && root_flag=--root
 
-	if test 0 != $ret
+	ret=0
+	if test -n "$keep_empty"
 	then
+		# we have to do this the hard way.  git format-patch completely squashes
+		# empty commits and even if it didn't the format doesn't really lend
+		# itself well to recording empty patches.  fortunately, cherry-pick
+		# makes this easy
+		git cherry-pick --allow-empty "$revisions"
+		ret=$?
+	else
 		rm -f "$GIT_DIR/rebased-patches"
-		case "$head_name" in
-		refs/heads/*)
-			git checkout -q "$head_name"
-			;;
-		*)
-			git checkout -q "$orig_head"
-			;;
-		esac
 
-		cat >&2 <<-EOF
+		git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+			--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+			$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
+		ret=$?
 
-		git encountered an error while preparing the patches to replay
-		these revisions:
+		if test 0 != $ret
+		then
+			rm -f "$GIT_DIR/rebased-patches"
+			case "$head_name" in
+			refs/heads/*)
+				git checkout -q "$head_name"
+				;;
+			*)
+				git checkout -q "$orig_head"
+				;;
+			esac
 
-		    $revisions
+			cat >&2 <<-EOF
 
-		As a result, git cannot rebase them.
-		EOF
-		return $?
-	fi
+			git encountered an error while preparing the patches to replay
+			these revisions:
+
+			    $revisions
 
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
-	ret=$?
+			As a result, git cannot rebase them.
+			EOF
+			return $?
+		fi
 
-	rm -f "$GIT_DIR/rebased-patches"
-fi
+		git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
+		ret=$?
 
-if test 0 != $ret
-then
-	test -d "$state_dir" && write_basic_state
-	return $ret
-fi
+		rm -f "$GIT_DIR/rebased-patches"
+	fi
 
-move_to_original_branch
+	if test 0 != $ret
+	then
+		test -d "$state_dir" && write_basic_state
+		return $ret
+	fi
+
+	move_to_original_branch
+}
+git_rebase__am
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 43631b47..42164f11 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -810,16 +810,17 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
 
-case "$action" in
-continue)
-	# do we have anything to commit?
-	if git diff-index --cached --quiet HEAD --
-	then
-		: Nothing to commit -- skip this
-	else
-		if ! test -f "$author_script"
+git_rebase__interactive() {
+	case "$action" in
+	continue)
+		# do we have anything to commit?
+		if git diff-index --cached --quiet HEAD --
 		then
-			die "You have staged changes in your working tree. If these changes are meant to be
+			: Nothing to commit -- skip this
+		else
+			if ! test -f "$author_script"
+			then
+				die "You have staged changes in your working tree. If these changes are meant to be
 squashed into the previous commit, run:
 
   git commit --amend
@@ -832,42 +833,42 @@ In both case, once you're done, continue with:
 
   git rebase --continue
 "
-		fi
-		. "$author_script" ||
-			die "Error trying to find the author identity to amend commit"
-		if test -f "$amend"
-		then
-			current_head=$(git rev-parse --verify HEAD)
-			test "$current_head" = $(cat "$amend") ||
-			die "\
+			fi
+			. "$author_script" ||
+				die "Error trying to find the author identity to amend commit"
+			if test -f "$amend"
+			then
+				current_head=$(git rev-parse --verify HEAD)
+				test "$current_head" = $(cat "$amend") ||
+				die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
-			do_with_author git commit --amend --no-verify -F "$msg" -e ||
-				die "Could not commit staged changes."
-		else
-			do_with_author git commit --no-verify -F "$msg" -e ||
-				die "Could not commit staged changes."
+				do_with_author git commit --amend --no-verify -F "$msg" -e ||
+					die "Could not commit staged changes."
+			else
+				do_with_author git commit --no-verify -F "$msg" -e ||
+					die "Could not commit staged changes."
+			fi
 		fi
-	fi
 
-	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
+		record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
 
-	require_clean_work_tree "rebase"
-	do_rest
-	return 0
-	;;
-skip)
-	git rerere clear
+		require_clean_work_tree "rebase"
+		do_rest
+		return 0
+		;;
+	skip)
+		git rerere clear
 
-	do_rest
-	return 0
-	;;
-edit-todo)
-	git stripspace --strip-comments <"$todo" >"$todo".new
-	mv -f "$todo".new "$todo"
-	collapse_todo_ids
-	append_todo_help
-	git stripspace --comment-lines >>"$todo" <<\EOF
+		do_rest
+		return 0
+		;;
+	edit-todo)
+		git stripspace --strip-comments <"$todo" >"$todo".new
+		mv -f "$todo".new "$todo"
+		collapse_todo_ids
+		append_todo_help
+		git stripspace --comment-lines >>"$todo" <<\EOF
 
 You are editing the todo file of an ongoing interactive rebase.
 To continue rebase after editing, run:
@@ -875,170 +876,172 @@ To continue rebase after editing, run:
 
 EOF
 
-	git_sequence_editor "$todo" ||
-		die "Could not execute editor"
-	expand_todo_ids
+		git_sequence_editor "$todo" ||
+			die "Could not execute editor"
+		expand_todo_ids
 
-	exit
-	;;
-esac
+		exit
+		;;
+	esac
 
-git var GIT_COMMITTER_IDENT >/dev/null ||
-	die "You need to set your committer info first"
+	git var GIT_COMMITTER_IDENT >/dev/null ||
+		die "You need to set your committer info first"
 
-comment_for_reflog start
+	comment_for_reflog start
 
-if test ! -z "$switch_to"
-then
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-	output git checkout "$switch_to" -- ||
-	die "Could not checkout $switch_to"
+	if test ! -z "$switch_to"
+	then
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
+		output git checkout "$switch_to" -- ||
+		die "Could not checkout $switch_to"
 
-	comment_for_reflog start
-fi
+		comment_for_reflog start
+	fi
 
-orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
+	orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
+	mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
 
-: > "$state_dir"/interactive || die "Could not mark as interactive"
-write_basic_state
-if test t = "$preserve_merges"
-then
-	if test -z "$rebase_root"
+	: > "$state_dir"/interactive || die "Could not mark as interactive"
+	write_basic_state
+	if test t = "$preserve_merges"
 	then
-		mkdir "$rewritten" &&
-		for c in $(git merge-base --all $orig_head $upstream)
-		do
-			echo $onto > "$rewritten"/$c ||
+		if test -z "$rebase_root"
+		then
+			mkdir "$rewritten" &&
+			for c in $(git merge-base --all $orig_head $upstream)
+			do
+				echo $onto > "$rewritten"/$c ||
+					die "Could not init rewritten commits"
+			done
+		else
+			mkdir "$rewritten" &&
+			echo $onto > "$rewritten"/root ||
 				die "Could not init rewritten commits"
-		done
+		fi
+		# No cherry-pick because our first pass is to determine
+		# parents to rewrite and skipping dropped commits would
+		# prematurely end our probe
+		merges_option=
 	else
-		mkdir "$rewritten" &&
-		echo $onto > "$rewritten"/root ||
-			die "Could not init rewritten commits"
+		merges_option="--no-merges --cherry-pick"
 	fi
-	# No cherry-pick because our first pass is to determine
-	# parents to rewrite and skipping dropped commits would
-	# prematurely end our probe
-	merges_option=
-else
-	merges_option="--no-merges --cherry-pick"
-fi
 
-shorthead=$(git rev-parse --short $orig_head)
-shortonto=$(git rev-parse --short $onto)
-if test -z "$rebase_root"
-	# this is now equivalent to ! -z "$upstream"
-then
-	shortupstream=$(git rev-parse --short $upstream)
-	revisions=$upstream...$orig_head
-	shortrevisions=$shortupstream..$shorthead
-else
-	revisions=$onto...$orig_head
-	shortrevisions=$shorthead
-fi
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
-	--abbrev=7 --reverse --left-right --topo-order \
-	$revisions | \
-	sed -n "s/^>//p" |
-while read -r shortsha1 rest
-do
-
-	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
+	shorthead=$(git rev-parse --short $orig_head)
+	shortonto=$(git rev-parse --short $onto)
+	if test -z "$rebase_root"
+		# this is now equivalent to ! -z "$upstream"
 	then
-		comment_out="$comment_char "
+		shortupstream=$(git rev-parse --short $upstream)
+		revisions=$upstream...$orig_head
+		shortrevisions=$shortupstream..$shorthead
 	else
-		comment_out=
+		revisions=$onto...$orig_head
+		shortrevisions=$shorthead
 	fi
+	git rev-list $merges_option --pretty=oneline --abbrev-commit \
+		--abbrev=7 --reverse --left-right --topo-order \
+		$revisions | \
+		sed -n "s/^>//p" |
+	while read -r shortsha1 rest
+	do
 
-	if test t != "$preserve_merges"
-	then
-		printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
-	else
-		sha1=$(git rev-parse $shortsha1)
-		if test -z "$rebase_root"
+		if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
 		then
-			preserve=t
-			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
-			do
-				if test -f "$rewritten"/$p
-				then
-					preserve=f
-				fi
-			done
+			comment_out="$comment_char "
 		else
-			preserve=f
-		fi
-		if test f = "$preserve"
-		then
-			touch "$rewritten"/$sha1
-			printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+			comment_out=
 		fi
-	fi
-done
 
-# Watch for commits that been dropped by --cherry-pick
-if test t = "$preserve_merges"
-then
-	mkdir "$dropped"
-	# Save all non-cherry-picked changes
-	git rev-list $revisions --left-right --cherry-pick | \
-		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
-	# Now all commits and note which ones are missing in
-	# not-cherry-picks and hence being dropped
-	git rev-list $revisions |
-	while read rev
-	do
-		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+		if test t != "$preserve_merges"
 		then
-			# Use -f2 because if rev-list is telling us this commit is
-			# not worthwhile, we don't want to track its multiple heads,
-			# just the history of its first-parent for others that will
-			# be rebasing on top of it
-			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
-			short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
-			sane_grep -v "^[a-z][a-z]* $short" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
-			rm "$rewritten"/$rev
+			printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+		else
+			sha1=$(git rev-parse $shortsha1)
+			if test -z "$rebase_root"
+			then
+				preserve=t
+				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+				do
+					if test -f "$rewritten"/$p
+					then
+						preserve=f
+					fi
+				done
+			else
+				preserve=f
+			fi
+			if test f = "$preserve"
+			then
+				touch "$rewritten"/$sha1
+				printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+			fi
 		fi
 	done
-fi
 
-test -s "$todo" || echo noop >> "$todo"
-test -n "$autosquash" && rearrange_squash "$todo"
-test -n "$cmd" && add_exec_commands "$todo"
+	# Watch for commits that been dropped by --cherry-pick
+	if test t = "$preserve_merges"
+	then
+		mkdir "$dropped"
+		# Save all non-cherry-picked changes
+		git rev-list $revisions --left-right --cherry-pick | \
+			sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
+		# Now all commits and note which ones are missing in
+		# not-cherry-picks and hence being dropped
+		git rev-list $revisions |
+		while read rev
+		do
+			if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+			then
+				# Use -f2 because if rev-list is telling us this commit is
+				# not worthwhile, we don't want to track its multiple heads,
+				# just the history of its first-parent for others that will
+				# be rebasing on top of it
+				git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
+				short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
+				sane_grep -v "^[a-z][a-z]* $short" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+				rm "$rewritten"/$rev
+			fi
+		done
+	fi
+
+	test -s "$todo" || echo noop >> "$todo"
+	test -n "$autosquash" && rearrange_squash "$todo"
+	test -n "$cmd" && add_exec_commands "$todo"
 
-cat >>"$todo" <<EOF
+	cat >>"$todo" <<EOF
 
 $comment_char Rebase $shortrevisions onto $shortonto
 EOF
-append_todo_help
-git stripspace --comment-lines >>"$todo" <<\EOF
+	append_todo_help
+	git stripspace --comment-lines >>"$todo" <<\EOF
 
 However, if you remove everything, the rebase will be aborted.
 
 EOF
 
-if test -z "$keep_empty"
-then
-	printf '%s\n' "$comment_char Note that empty commits are commented out" >>"$todo"
-fi
+	if test -z "$keep_empty"
+	then
+		printf '%s\n' "$comment_char Note that empty commits are commented out" >>"$todo"
+	fi
 
 
-has_action "$todo" ||
-	die_abort "Nothing to do"
+	has_action "$todo" ||
+		die_abort "Nothing to do"
 
-cp "$todo" "$todo".backup
-git_sequence_editor "$todo" ||
-	die_abort "Could not execute editor"
+	cp "$todo" "$todo".backup
+	git_sequence_editor "$todo" ||
+		die_abort "Could not execute editor"
 
-has_action "$todo" ||
-	die_abort "Nothing to do"
+	has_action "$todo" ||
+		die_abort "Nothing to do"
 
-expand_todo_ids
+	expand_todo_ids
 
-test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
+	test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
-GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-output git checkout $onto || die_abort "could not detach HEAD"
-git update-ref ORIG_HEAD $orig_head
-do_rest
+	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
+	output git checkout $onto || die_abort "could not detach HEAD"
+	git update-ref ORIG_HEAD $orig_head
+	do_rest
+}
+git_rebase__interactive
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index e7d96de9..b5f05bf5 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -101,53 +101,56 @@ finish_rb_merge () {
 	say All done.
 }
 
-case "$action" in
-continue)
-	read_state
-	continue_merge
-	while test "$msgnum" -le "$end"
-	do
-		call_merge "$msgnum"
+git_rebase__merge() {
+	case "$action" in
+	continue)
+		read_state
 		continue_merge
+		while test "$msgnum" -le "$end"
+		do
+			call_merge "$msgnum"
+			continue_merge
+		done
+		finish_rb_merge
+		return
+		;;
+	skip)
+		read_state
+		git rerere clear
+		msgnum=$(($msgnum + 1))
+		while test "$msgnum" -le "$end"
+		do
+			call_merge "$msgnum"
+			continue_merge
+		done
+		finish_rb_merge
+		return
+		;;
+	esac
+
+	mkdir -p "$state_dir"
+	echo "$onto_name" > "$state_dir/onto_name"
+	write_basic_state
+
+	msgnum=0
+	for cmt in `git rev-list --reverse --no-merges "$revisions"`
+	do
+		msgnum=$(($msgnum + 1))
+		echo "$cmt" > "$state_dir/cmt.$msgnum"
 	done
-	finish_rb_merge
-	return
-	;;
-skip)
-	read_state
-	git rerere clear
-	msgnum=$(($msgnum + 1))
+
+	echo 1 >"$state_dir/msgnum"
+	echo $msgnum >"$state_dir/end"
+
+	end=$msgnum
+	msgnum=1
+
 	while test "$msgnum" -le "$end"
 	do
 		call_merge "$msgnum"
 		continue_merge
 	done
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
 
-while test "$msgnum" -le "$end"
-do
-	call_merge "$msgnum"
-	continue_merge
-done
-
-finish_rb_merge
+	finish_rb_merge
+}
+git_rebase__merge
-- 
tg: (0bc85abb..) t/freebsd-sh-return (depends on: maint)

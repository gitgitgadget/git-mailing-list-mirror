From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 14/21] i18n: rebase-interactive: mark strings for translation
Date: Wed, 18 May 2016 15:27:47 +0000
Message-ID: <1463585274-9027-15-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:30:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33Qz-0001Xv-K5
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbcERPac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:30:32 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58796 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932381AbcERPaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:30:30 -0400
Received: (qmail 21193 invoked from network); 18 May 2016 15:30:28 -0000
Received: (qmail 27623 invoked from network); 18 May 2016 15:30:27 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:30:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294959>

Mark strings in git-rebase--interactive.sh for translation. There is no
need to source git-sh-i18n since git-rebase.sh already does so.

Add git-rebase--interactive.sh to LOCALIZED_SH in Makefile in order to
enabled extracting strings marked for translation by xgettext.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile                   |   1 +
 git-rebase--interactive.sh | 171 ++++++++++++++++++++++++---------------------
 2 files changed, 92 insertions(+), 80 deletions(-)

diff --git a/Makefile b/Makefile
index d31fcf2..c22c6f2 100644
--- a/Makefile
+++ b/Makefile
@@ -2064,6 +2064,7 @@ XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
+LOCALIZED_SH += git-rebase--interactive.sh
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1c6dfb6..5ce5b1f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -128,7 +128,7 @@ mark_action_done () {
 	if test "$last_count" != "$new_count"
 	then
 		last_count=$new_count
-		printf "Rebasing (%d/%d)\r" $new_count $total
+		printf "$(gettext Rebasing) (%d/%d)\r" $new_count $total
 		test -z "$verbose" || echo
 	fi
 }
@@ -201,11 +201,13 @@ exit_with_patch () {
 	make_patch $1
 	git rev-parse --verify HEAD > "$amend"
 	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-	warn "You can amend the commit now, with"
+	# TRANSLATORS: after this line is a command to be issued by the user
+	warn "$(gettext "You can amend the commit now, with")"
 	warn
 	warn "	git commit --amend $gpg_sign_opt_quoted"
 	warn
-	warn "Once you are satisfied with your changes, run"
+	# TRANSLATORS: after this line is a command to be issued by the user
+	warn "$(gettext "Once you are satisfied with your changes, run")"
 	warn
 	warn "	git rebase --continue"
 	warn
@@ -222,9 +224,10 @@ has_action () {
 }
 
 is_empty_commit() {
-	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
-		die "$1: not a commit that can be picked")
-	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
+	sha1=$1
+	tree=$(git rev-parse -q --verify "$sha1"^{tree} 2>/dev/null ||
+		die "$(eval_gettext "\$sha1: not a commit that can be picked")")
+	ptree=$(git rev-parse -q --verify "$sha1"^^{tree} 2>/dev/null ||
 		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
 	test "$tree" = "$ptree"
 }
@@ -261,7 +264,7 @@ pick_one () {
 
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	case "$force_rebase" in '') ;; ?*) ff= ;; esac
-	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
+	output git rev-parse --verify $sha1 || die "$(eval_gettext "Invalid commit name: \$sha1")"
 
 	if is_empty_commit "$sha1"
 	then
@@ -303,7 +306,7 @@ pick_one_preserving_merges () {
 				git rev-parse HEAD > "$rewritten"/$current_commit
 			done <"$state_dir"/current-commit
 			rm "$state_dir"/current-commit ||
-			die "Cannot write current commit's replacement sha1"
+				die "$(gettext "Cannot write current commit's replacement sha1")"
 		fi
 	fi
 
@@ -355,9 +358,9 @@ pick_one_preserving_merges () {
 	done
 	case $fast_forward in
 	t)
-		output warn "Fast-forward to $sha1"
+		output warn "$(eval_gettext "Fast-forward to \$sha1")"
 		output git reset --hard $sha1 ||
-			die "Cannot fast-forward to $sha1"
+			die "$(eval_gettext "Cannot fast-forward to \$sha1")"
 		;;
 	f)
 		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
@@ -366,12 +369,12 @@ pick_one_preserving_merges () {
 		then
 			# detach HEAD to current parent
 			output git checkout $first_parent 2> /dev/null ||
-				die "Cannot move HEAD to $first_parent"
+				die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
 		fi
 
 		case "$new_parents" in
 		' '*' '*)
-			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
+			test "a$1" = a-n && die "$(eval_gettext "Refusing to squash a merge: \$sha1")"
 
 			# redo merge
 			author_script_content=$(get_author_ident_from_commit $sha1)
@@ -385,7 +388,7 @@ pick_one_preserving_merges () {
 				$merge_args $strategy_args -m "$msg_content" $new_parents'
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
-				die_with_patch $sha1 "Error redoing merge $sha1"
+				die_with_patch $sha1 "$(eval_gettext "Error redoing merge \$sha1")"
 			fi
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
@@ -393,7 +396,7 @@ pick_one_preserving_merges () {
 			output eval git cherry-pick \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 				"$strategy_args" "$@" ||
-				die_with_patch $sha1 "Could not pick $sha1"
+				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
 			;;
 		esac
 		;;
@@ -460,12 +463,14 @@ peek_next_command () {
 # messages, effectively causing the combined commit to be used as the
 # new basis for any further squash/fixups.  Args: sha1 rest
 die_failed_squash() {
+	sha1=$1
+	rest=$2
 	mv "$squash_msg" "$msg" || exit
 	rm -f "$fixup_msg"
 	cp "$msg" "$GIT_DIR"/MERGE_MSG || exit
 	warn
-	warn "Could not apply $1... $2"
-	die_with_patch $1 ""
+	warn "$(eval_gettext "Could not apply \$sha1... \$rest")"
+	die_with_patch $sha1 ""
 }
 
 flush_rewritten_pending() {
@@ -489,6 +494,8 @@ record_in_rewritten() {
 }
 
 do_pick () {
+	sha1=$1
+	rest=$2
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
 		# Set the correct commit message and author info on the
@@ -500,15 +507,15 @@ do_pick () {
 		# resolve before manually running git commit --amend then git
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
-			   --no-post-rewrite -n -q -C $1 &&
-			pick_one -n $1 &&
+			   --no-post-rewrite -n -q -C $sha1 &&
+			pick_one -n $sha1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $1 \
+				   --amend --no-post-rewrite -n -q -C $sha1 \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
-			die_with_patch $1 "Could not apply $1... $2"
+				   die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
 	else
-		pick_one $1 ||
-			die_with_patch $1 "Could not apply $1... $2"
+		pick_one $sha1 ||
+			die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
 	fi
 }
 
@@ -536,10 +543,11 @@ do_next () {
 		mark_action_done
 		do_pick $sha1 "$rest"
 		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
-			warn "Could not amend commit after successfully picking $sha1... $rest"
-			warn "This is most likely due to an empty commit message, or the pre-commit hook"
-			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
-			warn "you are able to reword the commit."
+			warn "$(eval_gettext "\
+Could not amend commit after successfully picking \$sha1... \$rest
+This is most likely due to an empty commit message, or the pre-commit hook
+failed. If the pre-commit hook failed, you may need to resolve the issue before
+you are able to reword the commit.")"
 			exit_with_patch $sha1 1
 		}
 		record_in_rewritten $sha1
@@ -550,7 +558,7 @@ do_next () {
 		mark_action_done
 		do_pick $sha1 "$rest"
 		sha1_abbrev=$(git rev-parse --short $sha1)
-		warn "Stopped at $sha1_abbrev... $rest"
+		warn "$(eval_gettext "Stopped at \$sha1_abbrev... \$rest")"
 		exit_with_patch $sha1 0
 		;;
 	squash|s|fixup|f)
@@ -565,7 +573,7 @@ do_next () {
 		comment_for_reflog $squash_style
 
 		test -f "$done" && has_action "$done" ||
-			die "Cannot '$squash_style' without a previous commit"
+			die "$(eval_gettext "Cannot '\$squash_style' without a previous commit")"
 
 		mark_action_done
 		update_squash_messages $squash_style $sha1
@@ -607,7 +615,7 @@ do_next () {
 	x|"exec")
 		read -r command rest < "$todo"
 		mark_action_done
-		printf 'Executing: %s\n' "$rest"
+		printf "$(gettext Executing:) %s\n" "$rest"
 		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
 		status=$?
 		# Run in subshell because require_clean_work_tree can die.
@@ -615,11 +623,12 @@ do_next () {
 		(require_clean_work_tree "rebase" 2>/dev/null) || dirty=t
 		if test "$status" -ne 0
 		then
-			warn "Execution failed: $rest"
+			warn "$(gettext "Execution failed:") $rest"
 			test "$dirty" = f ||
-			warn "and made changes to the index and/or the working tree"
+				warn "$(gettext "and made changes to the index and/or the working tree")"
 
-			warn "You can fix the problem, and then run"
+			# TRANSLATORS: after this line is a command to be issued by the user
+			warn "$(gettext "You can fix the problem, and then run")"
 			warn
 			warn "	git rebase --continue"
 			warn
@@ -630,9 +639,11 @@ do_next () {
 			exit "$status"
 		elif test "$dirty" = t
 		then
-			warn "Execution succeeded: $rest"
-			warn "but left changes to the index and/or the working tree"
-			warn "Commit or stash your changes, and then run"
+			# TRANSLATORS: after these lines is a command to be issued by the user
+			warn "$(eval_gettext "\
+Execution succeeded: \$rest
+but left changes to the index and/or the working tree
+Commit or stash your changes, and then run")"
 			warn
 			warn "	git rebase --continue"
 			warn
@@ -640,8 +651,8 @@ do_next () {
 		fi
 		;;
 	*)
-		warn "Unknown command: $command $sha1 $rest"
-		fixtodo="Please fix this using 'git rebase --edit-todo'."
+		warn "$(gettext "Unknown command:") $command $sha1 $rest"
+		fixtodo="$(gettext "Please fix this using 'git rebase --edit-todo'.")"
 		if git rev-parse --verify -q "$sha1" >/dev/null
 		then
 			die_with_patch $sha1 "$fixtodo"
@@ -676,7 +687,7 @@ do_next () {
 		"$hook" rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
-	warn "Successfully rebased and updated $head_name."
+		warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"
 
 	return 1 # not failure; just to break the do_rest loop
 }
@@ -723,7 +734,7 @@ skip_unnecessary_picks () {
 		record_in_rewritten "$onto"
 		;;
 	esac ||
-	die "Could not skip unnecessary pick commands"
+		die "$(gettext "Could not skip unnecessary pick commands")"
 }
 
 transform_todo_ids () {
@@ -881,9 +892,9 @@ check_commit_sha () {
 	if test $badsha -ne 0
 	then
 		line="$(sed -n -e "${2}p" "$3")"
-		warn "Warning: the SHA-1 is missing or isn't" \
-			"a commit in the following line:"
-		warn " - $line"
+		warn "$(eval_gettext "\
+Warning: the SHA-1 is missing or isn't a commit in the following line:
+ - \$line")"
 		warn
 	fi
 
@@ -914,9 +925,9 @@ check_bad_cmd_and_sha () {
 			;;
 		*)
 			line="$(sed -n -e "${lineno}p" "$1")"
-			warn "Warning: the command isn't recognized" \
-				"in the following line:"
-			warn " - $line"
+			warn "$(eval_gettext "\
+Warning: the command isn't recognized in the following line:
+ - \$line")"
 			warn
 			retval=1
 			;;
@@ -953,7 +964,7 @@ warn_lines () {
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-	output git checkout $onto || die_abort "could not detach HEAD"
+	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
 	git update-ref ORIG_HEAD $orig_head
 }
 
@@ -991,28 +1002,26 @@ check_todo_list () {
 		then
 			test "$check_level" = error && raise_error=t
 
-			warn "Warning: some commits may have been dropped" \
-				"accidentally."
-			warn "Dropped commits (newer to older):"
+			warn "$(gettext "\
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):")"
 
 			# Make the list user-friendly and display
 			opt="--no-walk=sorted --format=oneline --abbrev-commit --stdin"
 			git rev-list $opt <"$todo".miss | warn_lines
 
-			warn "To avoid this message, use \"drop\" to" \
-				"explicitly remove a commit."
-			warn
-			warn "Use 'git config rebase.missingCommitsCheck' to change" \
-				"the level of warnings."
-			warn "The possible behaviours are: ignore, warn, error."
+			warn "$(gettext "\
+To avoid this message, use \"drop\" to explicitly remove a commit.
+
+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
+The possible behaviours are: ignore, warn, error.")"
 			warn
 		fi
 		;;
 	ignore)
 		;;
 	*)
-		warn "Unrecognized setting $check_level for option" \
-			"rebase.missingCommitsCheck. Ignoring."
+		warn "$(eval_gettext "Unrecognized setting \$check_level for option rebase.missingCommitsCheck. Ignoring.")"
 		;;
 	esac
 
@@ -1029,8 +1038,8 @@ check_todo_list () {
 		# placed before the commit of the next action
 		checkout_onto
 
-		warn "You can fix this with 'git rebase --edit-todo'."
-		die "Or you can abort the rebase with 'git rebase --abort'."
+		warn "$(gettext "You can fix this with 'git rebase --edit-todo'.")"
+		die "$(gettext "Or you can abort the rebase with 'git rebase --abort'.")"
 	fi
 }
 
@@ -1054,41 +1063,43 @@ continue)
 
 		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
 		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
-		die "Could not remove CHERRY_PICK_HEAD"
+		die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
 	else
 		if ! test -f "$author_script"
 		then
 			gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-			die "You have staged changes in your working tree. If these changes are meant to be
+			die "$(eval_gettext "\
+You have staged changes in your working tree.
+If these changes are meant to be
 squashed into the previous commit, run:
 
-  git commit --amend $gpg_sign_opt_quoted
+  git commit --amend \$gpg_sign_opt_quoted
 
 If they are meant to go into a new commit, run:
 
-  git commit $gpg_sign_opt_quoted
+  git commit \$gpg_sign_opt_quoted
 
 In both case, once you're done, continue with:
 
   git rebase --continue
-"
+")"
 		fi
 		. "$author_script" ||
-			die "Error trying to find the author identity to amend commit"
+			die "$(gettext "Error trying to find the author identity to amend commit")"
 		if test -f "$amend"
 		then
 			current_head=$(git rev-parse --verify HEAD)
 			test "$current_head" = $(cat "$amend") ||
-			die "\
-You have uncommitted changes in your working tree. Please, commit them
-first and then run 'git rebase --continue' again."
+			die "$(gettext "\
+You have uncommitted changes in your working tree. Please commit them
+first and then run 'git rebase --continue' again.")"
 			do_with_author git commit --amend --no-verify -F "$msg" -e \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				die "Could not commit staged changes."
+				die "$(gettext "Could not commit staged changes.")"
 		else
 			do_with_author git commit --no-verify -F "$msg" -e \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				die "Could not commit staged changes."
+				die "$(gettext "Could not commit staged changes.")"
 		fi
 	fi
 
@@ -1121,7 +1132,7 @@ To continue rebase after editing, run:
 EOF
 
 	git_sequence_editor "$todo" ||
-		die "Could not execute editor"
+		die "$(gettext "Could not execute editor")"
 	expand_todo_ids
 
 	exit
@@ -1129,7 +1140,7 @@ EOF
 esac
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
-	die "You need to set your committer info first"
+	die "$(gettext "You need to set your committer info first")"
 
 comment_for_reflog start
 
@@ -1137,15 +1148,15 @@ if test ! -z "$switch_to"
 then
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
 	output git checkout "$switch_to" -- ||
-	die "Could not checkout $switch_to"
+		die "$(eval_gettext "Could not checkout \$switch_to")"
 
 	comment_for_reflog start
 fi
 
-orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
+orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
+mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
 
-: > "$state_dir"/interactive || die "Could not mark as interactive"
+: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
 write_basic_state
 if test t = "$preserve_merges"
 then
@@ -1155,12 +1166,12 @@ then
 		for c in $(git merge-base --all $orig_head $upstream)
 		do
 			echo $onto > "$rewritten"/$c ||
-				die "Could not init rewritten commits"
+				die "$(gettext "Could not init rewritten commits")"
 		done
 	else
 		mkdir "$rewritten" &&
 		echo $onto > "$rewritten"/root ||
-			die "Could not init rewritten commits"
+			die "$(gettext "Could not init rewritten commits")"
 	fi
 	# No cherry-pick because our first pass is to determine
 	# parents to rewrite and skipping dropped commits would
@@ -1270,7 +1281,7 @@ EOF
 
 if test -z "$keep_empty"
 then
-	printf '%s\n' "$comment_char Note that empty commits are commented out" >>"$todo"
+	printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
 fi
 
 
@@ -1280,7 +1291,7 @@ has_action "$todo" ||
 cp "$todo" "$todo".backup
 collapse_todo_ids
 git_sequence_editor "$todo" ||
-	die_abort "Could not execute editor"
+	die_abort "$(gettext "Could not execute editor")"
 
 has_action "$todo" ||
 	return 2
-- 
2.7.3

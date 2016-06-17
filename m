Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E9820179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbcFQUY1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:27 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52115 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964855AbcFQUYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:24 -0400
Received: (qmail 23686 invoked from network); 17 Jun 2016 20:24:22 -0000
Received: (qmail 5724 invoked from network); 17 Jun 2016 20:24:22 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:20 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 14/38] i18n: rebase-interactive: mark strings for translation
Date:	Fri, 17 Jun 2016 20:21:03 +0000
Message-Id: <1466194887-18236-15-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark strings in git-rebase--interactive.sh for translation. There is no
need to source git-sh-i18n since git-rebase.sh already does so.

Add git-rebase--interactive.sh to LOCALIZED_SH in Makefile in order to
enable extracting strings marked for translation by xgettext.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile                   |   1 +
 git-rebase--interactive.sh | 191 ++++++++++++++++++++++++---------------------
 2 files changed, 102 insertions(+), 90 deletions(-)

diff --git a/Makefile b/Makefile
index 6169389..3cb1d60 100644
--- a/Makefile
+++ b/Makefile
@@ -2065,6 +2065,7 @@ XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
+LOCALIZED_SH += git-rebase--interactive.sh
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6e96abc..2b8a845 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -128,7 +128,7 @@ mark_action_done () {
 	if test "$last_count" != "$new_count"
 	then
 		last_count=$new_count
-		printf "Rebasing (%d/%d)\r" $new_count $total
+		eval_gettext "Rebasing (\$new_count/\$total)"; printf "\r"
 		test -z "$verbose" || echo
 	fi
 }
@@ -200,13 +200,14 @@ exit_with_patch () {
 	make_patch $1
 	git rev-parse --verify HEAD > "$amend"
 	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-	warn "You can amend the commit now, with"
-	warn
-	warn "	git commit --amend $gpg_sign_opt_quoted"
-	warn
-	warn "Once you are satisfied with your changes, run"
-	warn
-	warn "	git rebase --continue"
+	warn "$(eval_gettext "\
+You can amend the commit now, with
+
+	git commit --amend \$gpg_sign_opt_quoted
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue")"
 	warn
 	exit $2
 }
@@ -221,10 +222,12 @@ has_action () {
 }
 
 is_empty_commit() {
-	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
-		die "$1: not a commit that can be picked")
-	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
-		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
+	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null) || {
+		sha1=$1
+		die "$(eval_gettext "\$sha1: not a commit that can be picked")"
+	}
+	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null) ||
+		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 	test "$tree" = "$ptree"
 }
 
@@ -260,7 +263,7 @@ pick_one () {
 
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	case "$force_rebase" in '') ;; ?*) ff= ;; esac
-	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
+	output git rev-parse --verify $sha1 || die "$(eval_gettext "Invalid commit name: \$sha1")"
 
 	if is_empty_commit "$sha1"
 	then
@@ -302,7 +305,7 @@ pick_one_preserving_merges () {
 				git rev-parse HEAD > "$rewritten"/$current_commit
 			done <"$state_dir"/current-commit
 			rm "$state_dir"/current-commit ||
-			die "Cannot write current commit's replacement sha1"
+				die "$(gettext "Cannot write current commit's replacement sha1")"
 		fi
 	fi
 
@@ -354,9 +357,9 @@ pick_one_preserving_merges () {
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
@@ -365,12 +368,12 @@ pick_one_preserving_merges () {
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
@@ -384,7 +387,7 @@ pick_one_preserving_merges () {
 				$merge_args $strategy_args -m "$msg_content" $new_parents'
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
-				die_with_patch $sha1 "Error redoing merge $sha1"
+				die_with_patch $sha1 "$(eval_gettext "Error redoing merge \$sha1")"
 			fi
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
@@ -392,7 +395,7 @@ pick_one_preserving_merges () {
 			output eval git cherry-pick \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 				"$strategy_args" "$@" ||
-				die_with_patch $sha1 "Could not pick $sha1"
+				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
 			;;
 		esac
 		;;
@@ -459,12 +462,14 @@ peek_next_command () {
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
@@ -488,6 +493,8 @@ record_in_rewritten() {
 }
 
 do_pick () {
+	sha1=$1
+	rest=$2
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
 		# Set the correct commit message and author info on the
@@ -499,15 +506,15 @@ do_pick () {
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
 
@@ -535,10 +542,11 @@ do_next () {
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
@@ -549,7 +557,7 @@ do_next () {
 		mark_action_done
 		do_pick $sha1 "$rest"
 		sha1_abbrev=$(git rev-parse --short $sha1)
-		warn "Stopped at $sha1_abbrev... $rest"
+		warn "$(eval_gettext "Stopped at \$sha1_abbrev... \$rest")"
 		exit_with_patch $sha1 0
 		;;
 	squash|s|fixup|f)
@@ -564,7 +572,7 @@ do_next () {
 		comment_for_reflog $squash_style
 
 		test -f "$done" && has_action "$done" ||
-			die "Cannot '$squash_style' without a previous commit"
+			die "$(eval_gettext "Cannot '\$squash_style' without a previous commit")"
 
 		mark_action_done
 		update_squash_messages $squash_style $sha1
@@ -606,7 +614,7 @@ do_next () {
 	x|"exec")
 		read -r command rest < "$todo"
 		mark_action_done
-		printf 'Executing: %s\n' "$rest"
+		eval_gettextln "Executing: \$rest"
 		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
 		status=$?
 		# Run in subshell because require_clean_work_tree can die.
@@ -614,13 +622,14 @@ do_next () {
 		(require_clean_work_tree "rebase" 2>/dev/null) || dirty=t
 		if test "$status" -ne 0
 		then
-			warn "Execution failed: $rest"
+			warn "$(eval_gettext "Execution failed: \$rest")"
 			test "$dirty" = f ||
-			warn "and made changes to the index and/or the working tree"
+				warn "$(gettext "and made changes to the index and/or the working tree")"
 
-			warn "You can fix the problem, and then run"
-			warn
-			warn "	git rebase --continue"
+			warn "$(gettext "\
+You can fix the problem, and then run
+
+	git rebase --continue")"
 			warn
 			if test $status -eq 127		# command not found
 			then
@@ -629,18 +638,20 @@ do_next () {
 			exit "$status"
 		elif test "$dirty" = t
 		then
-			warn "Execution succeeded: $rest"
-			warn "but left changes to the index and/or the working tree"
-			warn "Commit or stash your changes, and then run"
-			warn
-			warn "	git rebase --continue"
+			# TRANSLATORS: after these lines is a command to be issued by the user
+			warn "$(eval_gettext "\
+Execution succeeded: \$rest
+but left changes to the index and/or the working tree
+Commit or stash your changes, and then run
+
+	git rebase --continue")"
 			warn
 			exit 1
 		fi
 		;;
 	*)
-		warn "Unknown command: $command $sha1 $rest"
-		fixtodo="Please fix this using 'git rebase --edit-todo'."
+		warn "$(eval_gettext "Unknown command: \$command \$sha1 \$rest")"
+		fixtodo="$(gettext "Please fix this using 'git rebase --edit-todo'.")"
 		if git rev-parse --verify -q "$sha1" >/dev/null
 		then
 			die_with_patch $sha1 "$fixtodo"
@@ -675,7 +686,7 @@ do_next () {
 		"$hook" rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
-	warn "Successfully rebased and updated $head_name."
+		warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"
 
 	return 1 # not failure; just to break the do_rest loop
 }
@@ -722,7 +733,7 @@ skip_unnecessary_picks () {
 		record_in_rewritten "$onto"
 		;;
 	esac ||
-	die "Could not skip unnecessary pick commands"
+		die "$(gettext "Could not skip unnecessary pick commands")"
 }
 
 transform_todo_ids () {
@@ -880,9 +891,9 @@ check_commit_sha () {
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
 
@@ -913,9 +924,9 @@ check_bad_cmd_and_sha () {
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
@@ -952,7 +963,7 @@ warn_lines () {
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-	output git checkout $onto || die_abort "could not detach HEAD"
+	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
 	git update-ref ORIG_HEAD $orig_head
 }
 
@@ -990,28 +1001,26 @@ check_todo_list () {
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
 
@@ -1028,8 +1037,8 @@ check_todo_list () {
 		# placed before the commit of the next action
 		checkout_onto
 
-		warn "You can fix this with 'git rebase --edit-todo'."
-		die "Or you can abort the rebase with 'git rebase --abort'."
+		warn "$(gettext "You can fix this with 'git rebase --edit-todo'.")"
+		die "$(gettext "Or you can abort the rebase with 'git rebase --abort'.")"
 	fi
 }
 
@@ -1053,41 +1062,43 @@ continue)
 
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
 
@@ -1120,7 +1131,7 @@ To continue rebase after editing, run:
 EOF
 
 	git_sequence_editor "$todo" ||
-		die "Could not execute editor"
+		die "$(gettext "Could not execute editor")"
 	expand_todo_ids
 
 	exit
@@ -1128,7 +1139,7 @@ EOF
 esac
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
-	die "You need to set your committer info first"
+	die "$(gettext "You need to set your committer info first")"
 
 comment_for_reflog start
 
@@ -1136,15 +1147,15 @@ if test ! -z "$switch_to"
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
@@ -1154,12 +1165,12 @@ then
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
@@ -1269,7 +1280,7 @@ EOF
 
 if test -z "$keep_empty"
 then
-	printf '%s\n' "$comment_char Note that empty commits are commented out" >>"$todo"
+	printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
 fi
 
 
@@ -1279,7 +1290,7 @@ has_action "$todo" ||
 cp "$todo" "$todo".backup
 collapse_todo_ids
 git_sequence_editor "$todo" ||
-	die_abort "Could not execute editor"
+	die_abort "$(gettext "Could not execute editor")"
 
 has_action "$todo" ||
 	return 2
-- 
2.6.6


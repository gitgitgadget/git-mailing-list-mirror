From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/3] Add git-sequencer shell prototype
Date: Wed, 16 Jul 2008 22:45:16 +0200
Message-ID: <cfa3b96d13488d57caf8b758367cdf0679126462.1216233914.git.s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDtx-0004gx-Lc
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969AbYGPUpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756842AbYGPUpm
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:45:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:58482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756604AbYGPUpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:45:33 -0400
Received: (qmail invoked by alias); 16 Jul 2008 20:45:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp063) with SMTP; 16 Jul 2008 22:45:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WDHk2UWaWkOTGtPsdKHADoIvf0opaqx0EAHC5yq
	BnPmTe/B6PUJHc
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJDsI-0005no-Ax; Wed, 16 Jul 2008 22:45:22 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88754>

git-sequencer is planned as a backend for user scripts
that execute a sequence of git instructions and perhaps
need manual intervention, for example git-rebase or git-am.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 .gitignore       |    1 +
 Makefile         |    1 +
 command-list.txt |    1 +
 git-sequencer.sh | 2064 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 2067 insertions(+), 0 deletions(-)
 create mode 100755 git-sequencer.sh

diff --git a/.gitignore b/.gitignore
index a213e8e..a617039 100644
--- a/.gitignore
+++ b/.gitignore
@@ -110,6 +110,7 @@ git-revert
 git-rm
 git-send-email
 git-send-pack
+git-sequencer
 git-sh-setup
 git-shell
 git-shortlog
diff --git a/Makefile b/Makefile
index 9b52071..391a4ac 100644
--- a/Makefile
+++ b/Makefile
@@ -248,6 +248,7 @@ SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
+SCRIPT_SH += git-sequencer.sh
 SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
diff --git a/command-list.txt b/command-list.txt
index 3583a33..44bb5b0 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -101,6 +101,7 @@ git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain common
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
+git-sequencer                           plumbingmanipulators
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain common
diff --git a/git-sequencer.sh b/git-sequencer.sh
new file mode 100755
index 0000000..6c406dc
--- /dev/null
+++ b/git-sequencer.sh
@@ -0,0 +1,2064 @@
+#!/bin/sh
+# A git sequencer prototype.
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git sequencer [options] [--] [<file>]
+git sequencer (--continue | --abort | --skip | --edit | --status)
+--
+ Options to start a sequencing process
+B,batch        run in batch-mode
+onto=          checkout the given commit or branch first
+no-advice      suppress advice when pausing (conflicts, etc)
+q,quiet        suppress output
+v,verbose      be more verbose
+ Options to restart/change a sequencing process or show information
+continue       continue paused sequencer process
+abort          restore original branch and abort
+skip           skip current patch and continue
+status         show the status of the sequencing process
+edit           invoke editor to let user edit the remaining insns
+ Options to be used by user scripts
+caller=        provide information string: name|abort|cont|skip
+"
+
+. git-sh-setup
+require_work_tree
+
+git var GIT_COMMITTER_IDENT >/dev/null ||
+	die 'You need to set your committer info first'
+
+SEQ_DIR="$GIT_DIR/sequencer"
+TODO="$SEQ_DIR/todo"
+DONE="$SEQ_DIR/done"
+MSG="$SEQ_DIR/message"
+PATCH="$SEQ_DIR/patch"
+AUTHOR_SCRIPT="$SEQ_DIR/author-script"
+ORIG_AUTHOR_SCRIPT="$SEQ_DIR/author-script.orig"
+CALLER_SCRIPT="$SEQ_DIR/caller-script"
+WHY_FILE="$SEQ_DIR/why"
+MARK_PREFIX='refs/sequencer-marks'
+
+warn () {
+	echo "$*" >&2
+}
+
+cleanup () {
+	for ref in $(git for-each-ref --format='%(refname)' "$MARK_PREFIX")
+	do
+		git update-ref -d "$ref" "$ref" || return
+	done
+	rm -rf "$SEQ_DIR"
+}
+
+print_advice () {
+	case "$ADVICE,$WHY" in
+	t,conflict)
+		echo "
+After resolving the conflicts, mark the corrected paths with
+
+	git add <paths>
+
+and run
+
+	$(print_caller --continue)
+
+Note, that your working tree must match the index."
+		;;
+	t,pause)
+		echo "
+You can now edit files and add them to the index.
+Once you are satisfied with your changes, run
+
+	$(print_caller --continue)
+
+If you only want to change the commit message, run
+git commit --amend before."
+		;;
+	t,run)
+		echo "
+Running failed:
+	$@
+
+You can now fix the problem.  When manual runs pass,
+add the changes to the index and invoke
+
+	$(print_caller --continue)"
+		;;
+	t,todo)
+		echo "
+Fix with git sequencer --edit or abort with $(print_caller --abort)."
+		;;
+	esac
+}
+
+# Die if there has been a conflict
+die_to_continue () {
+	warn "$*"
+	test -z "$BATCHMODE" ||
+		die_abort 'Aborting, because of batch mode.'
+	test -n "$WHY" || WHY=conflict
+	echo "$WHY" >"$WHY_FILE"
+	print_advice
+	exit 3
+}
+
+die_abort () {
+	restore
+	cleanup
+	die "$1"
+}
+
+quit () {
+	cleanup
+	test -z "$*" ||
+		echo "$*"
+	exit 0
+}
+
+perform () {
+	case "$VERBOSE" in
+	0)
+		"$@" >/dev/null
+		;;
+	1)
+		output=$("$@" 2>&1 )
+		status=$?
+		test $status -ne 0 && printf '%s\n' "$output"
+		return $status
+		;;
+	2)
+		"$@"
+		;;
+	esac
+}
+
+require_clean_work_tree () {
+	# test if working tree is dirty
+	git rev-parse --verify HEAD >/dev/null &&
+	git update-index --ignore-submodules --refresh &&
+	git diff-files --quiet --ignore-submodules &&
+	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
+	die 'Working tree is dirty'
+}
+
+ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
+
+comment_for_reflog () {
+	if test -z "$ORIG_REFLOG_ACTION"
+	then
+		GIT_REFLOG_ACTION='sequencer'
+		test -z "$CALLER" ||
+			GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION ($CALLER)"
+		export GIT_REFLOG_ACTION
+	fi
+}
+
+# Get commit message from commit $1
+commit_message () {
+	git cat-file commit "$1" | sed -e '1,/^$/d'
+}
+
+LAST_COUNT=
+mark_action_done () {
+	sed -e 1q <"$TODO" >>"$DONE"
+	sed -e 1d <"$TODO" >"$TODO.new"
+	mv -f "$TODO.new" "$TODO"
+	todo_ack "$TODO"
+	if test "$VERBOSE" -gt 0
+	then
+		count=$(grep -c '^[^#]' <"$DONE")
+		total=$(expr "$count" + "$(grep -c '^[^#]' <"$TODO")")
+		if test "$LAST_COUNT" != "$count"
+		then
+			LAST_COUNT="$count"
+			test "$VERBOSE" -lt 1 ||
+				printf 'Sequencing (%d/%d)\r' "$count" "$total"
+			test "$VERBOSE" -lt 2 || echo
+		fi
+	fi
+}
+
+# Generate message, patch and author script files
+make_patch () {
+	parent_sha1=$(git rev-parse --verify "$1^" 2>/dev/null ||
+		echo '--root')
+	git diff-tree -p "$parent_sha1" "$1" >"$PATCH"
+	test -f "$MSG" ||
+		commit_message "$1" >"$MSG"
+	test -f "$AUTHOR_SCRIPT" ||
+		get_author_ident_from_commit "$1" >"$AUTHOR_SCRIPT"
+}
+
+# Generate a patch and die with "conflict" status code
+die_with_patch () {
+	make_patch "$1"
+	git rerere
+	die_to_continue "$2"
+}
+
+restore () {
+	git rerere clear
+
+	read HEADNAME <"$SEQ_DIR/head-name"
+	read HEAD <"$SEQ_DIR/head"
+	case $HEADNAME in
+	refs/*)
+		git symbolic-ref HEAD "$HEADNAME"
+		;;
+	esac &&
+	perform git reset --hard "$HEAD"
+}
+
+has_action () {
+	grep '^[^#]' "$1" >/dev/null
+}
+
+# Check if text file $1 contains a commit message
+has_message () {
+	test -n "$(sed -n -e '/^Signed-off-by:/d;/^[^#]/p' <"$1")"
+}
+
+# Count parents of commit $1
+count_parents() {
+	git cat-file commit "$1" | sed -n -e '1,/^$/p' | grep -c '^parent'
+}
+
+# Evaluate the author script to get author information to
+# apply it with "with_author git foo" then.
+get_current_author () {
+	if test -f "$AUTHOR_SCRIPT"
+	then
+		. "$AUTHOR_SCRIPT"
+	else
+		. "$ORIG_AUTHOR_SCRIPT"
+	fi || die_abort 'Author script is damaged. This must not happen!'
+}
+
+# Run command with author information
+with_author () {
+	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
+	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
+	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
+		"$@"
+}
+
+# clean WHY_FILE and reset WHY
+clean_why () {
+	rm -f "$WHY_FILE"
+	WHY=
+}
+
+# Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
+pick_one () {
+	what="$1"
+	shift
+
+	case "$what,$1" in
+	revert,*)
+		test "$1" != '--edit' &&
+			what='revert --no-edit'
+		;;
+	cherry-pick,-*)
+		;;
+	cherry-pick,*)
+		# fast forward
+		if test "$(git rev-parse --verify "$1^" 2>/dev/null)" = \
+			"$(git rev-parse --verify HEAD)"
+		then
+			perform git reset --hard "$1"
+			return
+		fi
+		;;
+	esac
+	$use_perform git $what "$@"
+}
+
+nth_string () {
+	case "$1" in
+	*1[0-9]|*[04-9])
+		echo "$1th"
+		;;
+	*1)
+		echo "$1st"
+		;;
+	*2)
+		echo "$1nd"
+		;;
+	*3)
+		echo "$1rd"
+		;;
+	esac
+}
+
+make_squash_message () {
+	if test -f "$squash_msg"
+	then
+		count=$(($(sed -n -e 's/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p' \
+			<"$squash_msg" | sed -n -e '$p')+1))
+		echo "# This is a combination of $count commits."
+		sed -e '1d' -e '2,/^./{
+			/^$/d
+		}' <"$squash_msg"
+	else
+		count=2
+		echo '# This is a combination of 2 commits.'
+		echo '# The first commit message is:'
+		echo
+		commit_message HEAD
+	fi
+	echo
+	echo "# This is the $(nth_string "$count") commit message:"
+	echo
+	commit_message "$1"
+}
+
+make_squash_message_multiple () {
+	revlist=$(git rev-list --reverse "$sha1..HEAD")
+	count=$(echo "$revlist" | wc -l)
+	squash_i=0
+	echo "# This is a combination of $count commits."
+	for cur_sha1 in $revlist
+	do
+		squash_i=$(($squash_i+1))
+		if test -f "$squash_msg"
+		then
+			count=$(($count + $(sed -n -e \
+				's/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p' \
+				<"$squash_msg" | sed -n -e '$p')+1))
+			sed -e '1d' -e '2,/^./{
+				/^$/d
+			}' <"$squash_msg"
+		fi
+		echo
+		echo "# This is the $(nth_string "$squash_i") commit message:"
+		echo
+		commit_message "$cur_sha1"
+	done
+}
+
+peek_next_command () {
+	sed -n -e '/^#/d' -e '1s/ .*$//p' <"$TODO"
+}
+
+# If $1 is a mark, make a ref from it; otherwise keep it.
+# Note on marks:
+#  * :0 is allowed
+#  * :01 is the same as :1
+mark_to_ref () {
+	arg="$1"
+	ref=$(expr "x$arg" : 'x:0*\([0-9][0-9]*\)$')
+	test -n "$ref" &&
+		arg="$MARK_PREFIX/$ref"
+	printf '%s\n' "$arg"
+}
+
+mark_to_commit () {
+	git rev-parse --verify "$(mark_to_ref "$1")"
+}
+
+
+cannot_fallback () {
+	echo "$1"
+	die_to_continue 'Cannot fall back to three-way merge. Please hand-edit.'
+}
+
+
+fallback_3way () {
+	O_OBJECT=$(cd "$GIT_OBJECT_DIRECTORY" && pwd)
+
+	rm -fr "$PATCH-merge-"*
+	mkdir "$PATCH-merge-tmp-dir"
+
+	# First see if the patch records the index info that we can use.
+	git apply --build-fake-ancestor "$PATCH-merge-tmp-index" "$PATCH" &&
+	GIT_INDEX_FILE="$PATCH-merge-tmp-index" \
+		git write-tree >"$PATCH-merge-base+" ||
+	cannot_fallback 'Repository lacks necessary blobs to fall back on 3-way merge.'
+
+	echo 'Using index info to reconstruct a base tree...'
+	if GIT_INDEX_FILE="$PATCH-merge-tmp-index" \
+		git apply --cached "$PATCH"
+	then
+		mv "$PATCH-merge-base+" "$PATCH-merge-base"
+		mv "$PATCH-merge-tmp-index" "$PATCH-merge-index"
+	else
+		cannot_fallback "Did you hand edit your patch?
+It does not apply to blobs recorded in its index."
+	fi
+
+	test -f "$PATCH-merge-index" &&
+	his_tree=$(GIT_INDEX_FILE="$PATCH-merge-index" git write-tree) &&
+	orig_tree=$(cat "$PATCH-merge-base") &&
+	rm -fr "$PATCH-merge-"* || exit 1
+
+	echo 'Falling back to patching base and 3-way merge...'
+
+	# This is not so wrong.  Depending on which base we picked,
+	# orig_tree may be wildly different from ours, but his_tree
+	# has the same set of wildly different changes in parts the
+	# patch did not touch, so recursive ends up canceling them,
+	# saying that we reverted all those changes.
+
+	eval GITHEAD_$his_tree='"$firstline"'
+	export GITHEAD_$his_tree
+	git merge-recursive "$orig_tree" -- HEAD "$his_tree" || {
+		git rerere
+		die 'Failed to merge in the changes.'
+	}
+}
+
+# Run hook "$@" (with arguments) if executable
+run_hook () {
+	test -z "$1" || return
+	hookname="$1"
+	hook="$GIT_DIR/hooks/$hookname"
+	shift
+	if test -x "$hook"
+	then
+		"$hook" "$@" ||
+			die_to_continue "Hook $hookname failed."
+	fi
+}
+
+# Add Signed-off-by: line if general option --signoff is given
+dashdash_signoff () {
+	add_signoff=
+	if test -n "$SIGNOFF"
+	then
+		last_signed_off_by=$(
+			sed -n -e '/^Signed-off-by: /p' <"$MSG" | sed -n -e '$p'
+		)
+		test "$last_signed_off_by" = "$SIGNOFF" ||
+			add_signoff=$(
+				test '' = "$last_signed_off_by" && echo
+				echo "$SIGNOFF"
+			)
+	fi
+	{
+		test -s "$MSG" && cat "$MSG"
+		test -n "$add_signoff" && echo "$add_signoff"
+	} >"$MSG.new"
+	mv "$MSG.new" "$MSG"
+}
+
+
+### --caller-related functions
+
+# Show string for caller invocation for --abort/--continue/--skip
+print_caller_info () {
+	case "$1" in
+	--abort)
+		echo "$CALLER_ABRT"
+		;;
+	--continue)
+		echo "$CALLER_CONT"
+		;;
+	--skip)
+		echo "$CALLER_SKIP"
+		;;
+	*)
+		warn 'Internal error: Unknown print_caller argument!'
+		;;
+	esac
+}
+
+# Print the program to invoke to (--)abort/continue/skip
+print_caller() {
+	caller_info=$(print_caller_info "$1")
+	if test -n "$CALLERCOMPARE" -a -n "$caller_info"
+	then
+		test -n "$CALLER" && printf "$CALLER "
+		echo "$caller_info"
+	else
+		echo "git sequencer $1"
+	fi
+}
+
+# Test if --caller was set correctly
+# $1 must be abort/continue/skip
+test_caller () {
+	caller_info=$(print_caller_info "--$1")
+	test -n "$CALLERCOMPARE" -a \
+		"$CALLERCOMPARE" != "$CALLERSTRING" -a \
+		-n "$caller_info" &&
+		die "You must use '$CALLER $caller_info' to $1!"
+}
+
+# Generate $CALLER_SCRIPT file from "git foo|--abort|--continue|--skip"
+# string $1
+generate_caller_script () {
+	echo "$1" | sed -e 's/^\(.*\)|\(.*\)|\(.*\)|\(.*\)$/\
+CALLERCOMPARE="\0"\
+CALLER="\1"\
+CALLER_ABRT="\2"\
+CALLER_CONT="\3"\
+CALLER_SKIP="\4"/' >"$CALLER_SCRIPT"
+}
+
+# Run caller script and set GIT_CHERRY_PICK_HELP
+assure_caller () {
+	test -r "$CALLER_SCRIPT" &&
+		. "$CALLER_SCRIPT"
+
+	# we do not want cherry-pick to print *any* help
+	GIT_CHERRY_PICK_HELP=""
+	export GIT_CHERRY_PICK_HELP
+}
+
+
+### Helpers for check_* functions:
+
+# Print a warning on todo checking
+todo_warn () {
+	printf 'Warning at line %d, %s: %s\n' "$line" "$command" "$*"
+}
+
+# Raise an error on todo checking
+todo_error () {
+	printf 'Error at line %d, %s: %s\n' "$line" "$command" "$*"
+	retval=1
+}
+
+# Test if $1 is a commit on todo checking
+commit_check () {
+	test "$(git cat-file -t "$1" 2>/dev/null)" = commit ||
+		todo_error "'$1' is not a commit."
+}
+
+# A helper function to check if $1 is a an available mark during check_*
+arg_is_mark_check () {
+	for cur_mark in $available_marks
+	do
+		test "$cur_mark" -eq "${1#:}" && return
+	done
+	todo_error "Mark $1 is not yet defined."
+}
+
+# A helper function for check_* and mark usage:
+# check if "$1" is a commit or a defined mark
+arg_is_mark_or_commit_check () {
+	if expr "x$1" : 'x:[0-9][0-9]*$' >/dev/null
+	then
+		arg_is_mark_check "$1"
+	else
+		commit_check "$1"
+	fi
+}
+
+
+### Author script functions
+
+# Take "Name <e-mail>" in stdin and outputs author script
+make_author_script_from_string () {
+	sed -e "s/'/'"'\\'"''/g" \
+	    -e 's/^\(.*\) <\(.*\)>.*$/GIT_AUTHOR_NAME='\''\1'\''\
+GIT_AUTHOR_EMAIL='\''\2'\''\
+GIT_AUTHOR_DATE=/'
+}
+
+
+### General option functions (and options spec)
+
+OPTIONS_GENERAL=' General options:
+author= Override author
+C,reuse-commit= Reuse message and authorship data from commit
+F,file= Take commit message from given file
+m,message= Specify commit message
+M,reuse-message= Reuse message from commit
+signoff Add signoff
+e,edit Invoke editor to edit commit message'
+
+# Check if option is a general option
+check_general_option () {
+	general_shift=1
+	case "$1" in
+	--signoff)
+		return 0
+		;;
+	--author)
+		general_shift=2
+		author_opt="t$author_opt"
+		expr "x$2" : 'x.* <.*>' >/dev/null ||
+			todo_error "Author \"$2\" not in the correct format \"Name <e-mail>\"."
+		;;
+	-m)
+		general_shift=2
+		msg_opt="t$msg_opt"
+		;;
+	-C)
+		general_shift=2
+		msg_opt="t$msg_opt"
+		author_opt="t$author_opt"
+		commit_check "$2"
+		;;
+	-M)
+		general_shift=2
+		msg_opt="t$msg_opt"
+		commit_check "$2"
+		;;
+	-F)
+		general_shift=2
+		msg_opt="t$msg_opt"
+		test -r "$2" ||
+			todo_error "Cannot read file '$2'."
+		;;
+	-e)
+		test -z "$BATCHMODE" ||
+			todo_error '--batch and --edit options do not make sense together.'
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
+# Set a general option variable or return 1
+handle_general_option () {
+	general_shift=1
+	case "$1" in
+	--signoff)
+		SIGNOFF=$(git var GIT_COMMITTER_IDENT | sed -e '
+				s/>.*/>/
+				s/^/Signed-off-by: /')
+		;;
+	--author)
+		general_shift=2
+		AUTHOR=t
+		echo "$2" |
+			make_author_script_from_string >"$AUTHOR_SCRIPT"
+		;;
+	-m)
+		general_shift=2
+		MESSAGE="$2"
+		;;
+	-C)
+		general_shift=2
+		AUTHOR=t
+		get_author_ident_from_commit "$2" >"$AUTHOR_SCRIPT"
+		MESSAGE=$(commit_message "$2")
+		;;
+	-M)
+		general_shift=2
+		MESSAGE=$(commit_message "$2")
+		;;
+	-F)
+		general_shift=2
+		MESSAGE=$(cat "$2")
+		;;
+	-e)
+		EDIT=--edit
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
+
+### Functions for checking and realizing TODO instructions
+# Note that options_*, check_* and insn_* function names are reserved.
+
+options_pause="\
+pause
+--
+"
+
+# Check the "pause" instruction
+check_pause () {
+	shift
+	test -z "$BATCHMODE" ||
+		todo_error '"pause" instruction and --batch do not make sense together.'
+	test $# -eq 0 ||
+		todo_error 'The pause instruction takes no arguments.'
+	return 0
+}
+
+# Realize the "pause" instruction
+insn_pause () {
+	mark_action_done
+	make_patch HEAD
+	echo 'pause' >"$WHY_FILE"
+	WHY=pause print_advice
+	exit 2
+}
+
+
+options_run="\
+run [--dir=<path>] [--] <cmd> <args>...::
+--
+dir= Change directory before running command
+"
+
+# Check the "run" instruction
+check_run () {
+	while test $# -gt 0
+	do
+		case "$1" in
+		--dir)
+			test -e "$2" ||
+				todo_error "Path $2 does not exist."
+			test -d "$2" ||
+				todo_error "Path $2 is not a directory."
+			shift 2
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			todo_error "Unknown option $1"
+			;;
+		esac
+	done
+	# we don't check if cmd exists
+	return 0
+}
+
+# Realize the "run" instruction
+insn_run () {
+	runpath=./
+	while test $# -gt 0
+	do
+		case "$1" in
+		--dir)
+			runpath="$2"
+			shift 2
+			;;
+		--)
+			shift
+			break
+			;;
+		esac
+	done
+
+	mark_action_done
+
+	savepath="$PWD"
+	cd "$runpath"
+	"$@"
+	success="$?"
+	cd "$savepath"
+
+	if test "$success" -ne 0
+	then
+		test -z "$BATCHMODE" ||
+			die_abort "Running $1 failed. Aborting because of batch mode."
+		make_patch HEAD
+		echo 'run' >"$WHY_FILE"
+		WHY=run print_advice "$@"
+		exit 3
+	fi
+}
+
+
+options_patch="\
+patch [options] <file>
+--
+3,3way Fall back to 3-way merge
+k Pass to git-mailinfo (keep subject)
+n Pass to git-mailinfo (no utf8)
+$OPTIONS_GENERAL
+ Options passed to git-apply:
+R,reverse Reverse changes
+context= Ensure context of ... lines
+p= Remove ... leading slashes
+unidiff-zero Bypass unidiff checks
+exclude= Do not apply changes to given files
+no-add Ignore additions of patch
+whitespace= Set whitespace error behavior
+inaccurate-eof Support inaccurate EOFs
+u no-op (backward compatibility)
+binary no-op (backward compatibility)
+"
+
+# Check the "file" instruction
+check_patch () {
+	while test $# -gt 1
+	do
+		case "$1" in
+		-3|-k|-n|-u|--binary|-R|--reverse|--unidiff-zero|--no-add|--inaccurate-eof)
+			:
+			;;
+		-p|--whitespace|--exclude|--context)
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			check_general_option "$@" ||
+				todo_warn "Unknown option $1"
+			;;
+		*)
+			todo_error "Wrong number of arguments. ($# given, 1 wanted)"
+			break
+			;;
+		esac
+		shift $general_shift
+	done
+
+	if test -f "$1" -a -r "$1"
+	then
+		grep -e '^diff' "$1" >/dev/null ||
+			todo_error "File '$1' contains no patch."
+	else
+		todo_error "Cannot open file '$1'."
+	fi
+	return 0
+}
+
+# Realize the "patch" instruction
+insn_patch () {
+	comment_for_reflog patch
+
+	apply_opts=
+	mailinfo_opts=
+	threeway=
+
+	# temporary files
+	infofile="$SEQ_DIR/patch-info"
+	msgfile="$SEQ_DIR/patch-msg"
+
+	while test "$#" -gt 1
+	do
+		case "$1" in
+		-3)
+			threeway=t
+			;;
+		-k|-n)
+			mailinfo_opts="$mailinfo_opts $1"
+			;;
+		-u|--binary)
+			: Do nothing. It is there due to b/c only.
+			;;
+		-R|--reverse|--unidiff-zero|--no-add|--inaccurate-eof)
+			apply_opts="$apply_opts $1"
+			;;
+		-p)
+			shift
+			apply_opts="$apply_opts -p$1"
+			;;
+		--whitespace|--exclude)
+			apply_opts="$apply_opts $1=$2"
+			shift
+			;;
+		--context)
+			shift
+			apply_opts="$apply_opts -C$1"
+			;;
+		--)
+			shift
+			break
+			;;
+		*)
+			handle_general_option "$@"
+			;;
+		esac
+		shift $general_shift
+	done
+
+	filename="$1"
+
+	mark_action_done
+
+	git mailinfo $mailinfo_opts "$msgfile" "$PATCH" \
+		<"$filename" >"$infofile" ||
+		die_abort 'Could not read or parse mail'
+
+	# if author not set by option, read author information of patch
+	if test -z "$AUTHOR"
+	then
+		cp "$ORIG_AUTHOR_SCRIPT" "$AUTHOR_SCRIPT"
+		sed -e "s/'/'"'\\'"''/g" -n -e '
+			s/^Author: \(.*\)$/GIT_AUTHOR_NAME='\''\1'\''/p;
+			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL='\''\1'\''/p;
+			s/^Date: \(.*\)$/GIT_AUTHOR_DATE='\''\1'\''/p
+		' <"$infofile" >>"$AUTHOR_SCRIPT"
+		# If sed's result is empty, we keep the original
+		# author script by appending.
+	fi
+
+	# Ignore every mail that's not containing a patch
+	test -s "$PATCH" || {
+		warn 'Does not contain patch!'
+		return 0
+	}
+
+	edit_msg=
+	if grep -e '^Subject:' "$infofile" >/dev/null
+	then
+		# add subject to commit message
+		sed -n -e '/^Subject:/ s/Subject: //p' <"$infofile"
+		echo
+		echo
+		cat "$msgfile"
+	else
+		cat "$msgfile"
+		edit_msg=t
+	fi | git stripspace >"$MSG"
+	rm -f "$infofile" "$msgfile"
+
+	firstline=$(sed -e '1q' <"$MSG")
+
+	get_current_author
+
+	test -n "$MESSAGE" && printf '%s\n' "$MESSAGE" >"$MSG"
+	test -z "$firstline" && firstline=$(sed -e '1q' <"$MSG")
+
+	dashdash_signoff
+
+	with_author run_hook applypatch-msg "$MSG"
+	failed=
+	git apply $apply_opts --index "$PATCH" || failed=t
+
+	if test -n "$failed" -a -n "$threeway" && (with_author fallback_3way)
+	then
+		# Applying the patch to an earlier tree and merging the
+		# result may have produced the same tree as ours.
+		git diff-index --quiet --cached HEAD -- && {
+			echo 'No changes -- Patch already applied.'
+			return 0
+			# XXX: do we want that?
+		}
+		# clear apply_status -- we have successfully merged.
+		failed=
+	fi
+
+	if test -n "$failed"
+	then
+		die_to_continue 'Patch failed.'
+		# XXX: We actually needed a git-apply flag that creates
+		# conflict markers and sets the DIFF_STATUS_UNMERGED flag.
+	fi
+
+	with_author run_hook pre-applypatch
+
+	test -n "$EDIT" && edit_msg=t
+	if ! has_message "$MSG" || test -n "$edit_msg"
+	then
+		echo "
+# Please enter the commit message for the applied patch.
+# (Comment lines starting with '#' will not be included)" >>"$MSG"
+
+		git_editor "$MSG" ||
+			die_with_patch 'Editor returned error.'
+		has_message "$MSG" ||
+			die_with_patch 'No commit message given.'
+	fi
+
+	tree=$(git write-tree) &&
+	parent=$(git rev-parse --verify HEAD) &&
+	commit=$(with_author git commit-tree "$tree" -p "$parent" <"$MSG") &&
+	git update-ref -m "$GIT_REFLOG_ACTION: $firstline" HEAD "$commit" "$parent" ||
+		die_to_continue 'Could not commit tree.'
+
+	test -x "$GIT_DIR/hooks/post-applypatch" &&
+		with_author "$GIT_DIR/hooks/post-applypatch"
+
+	return 0
+}
+
+
+options_pick="\
+pick [options] <commit>
+--
+R,reverse Revert introduced changes
+mainline= Specify parent number to use for merge commits
+$OPTIONS_GENERAL
+"
+
+# Check the "pick" instruction
+check_pick () {
+	mainline=
+	while test $# -gt 1
+	do
+		case "$1" in
+		-R)
+			;;
+		--mainline)
+			shift
+			mainline="$1"
+			test "$mainline" -gt 0 || {
+				todo_error '--mainline needs an integer beginning from 1.'
+				mainline=
+			}
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			check_general_option "$@" ||
+				todo_warn "Unknown option $1"
+			;;
+		*)
+			todo_error "Wrong number of arguments. ($# given, 1 wanted)"
+			break
+			;;
+		esac
+		shift $general_shift
+	done
+
+	if test -n "$mainline"
+	then
+		parents=$(count_parents "$1")
+		test "$parents" -lt "$mainline" &&
+			todo_error "Commit has only $parents (less than $mainline) parents."
+		test "$parents" -eq 1 &&
+			todo_warn 'Commit is not a merge at all.'
+	fi
+
+	commit_check "$1"
+
+	return 0
+}
+
+# Realize the "pick" instruction
+insn_pick () {
+	op=cherry-pick
+	mainline=
+	while test $# -gt 1
+	do
+		case "$1" in
+		-R)
+			op=revert
+			;;
+		--mainline)
+			mainline="$1 $2"
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			handle_general_option "$@"
+			;;
+		esac
+		shift $general_shift
+	done
+
+	sha1=$(git rev-parse --verify "$1")
+
+	comment_for_reflog pick
+
+	mark_action_done
+
+	edit_msg="$EDIT"
+
+	# Don't edit on pick, but later, if author or message given.
+	test -n "$AUTHOR" -o -n "$MESSAGE" && edit_msg=
+
+	# Be kind to users and ignore --mainline=1 on non-merge commits
+	test -n "$mainline" -a 2 -gt $(count_parents "$sha1") && mainline=
+
+	use_perform=
+	test -n "$edit_msg" ||
+		use_perform=perform
+
+	pick_one "$op" $edit_msg $mainline $sha1 ||
+		die_with_patch $sha1 "Could not apply $sha1"
+
+	test -n "$EDIT" ||
+		use_perform=perform
+
+	get_current_author
+	signoff=
+	test -n "$SIGNOFF" && signoff=-s
+	if test -n "$AUTHOR" -a -n "$MESSAGE"
+	then
+		# this is just because we only want to do ONE amending commit
+		$use_perform git commit --amend $EDIT $signoff --no-verify \
+			--author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
+			--message="$MESSAGE"
+	elif test -n "$AUTHOR"
+	then
+		# correct author if AUTHOR is set
+		$use_perform git commit --amend $EDIT --no-verify -C HEAD \
+			--author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+	elif test -n "$MESSAGE"
+	then
+		# correct commit message if MESSAGE is set
+		$use_perform git commit --amend $EDIT $signoff --no-verify \
+			-C HEAD --message="$MESSAGE"
+	elif test -n "$SIGNOFF"
+	then
+		# only add signoff
+		$use_perform git commit --amend $EDIT $signoff --no-verify \
+			-C HEAD
+	fi
+
+	return 0
+}
+
+options_edit="\
+edit <commit>
+--
+"
+
+# Check the "edit" instruction
+check_edit () {
+	shift
+	test -z "$BATCHMODE" ||
+		todo_error '"edit" instruction and --batch do not make sense together.'
+	test $# -eq 1 ||
+		todo_error "Wrong number of arguments. ($# given, 1 wanted)"
+	return 0
+}
+
+# Realize the "edit" instruction
+insn_edit () {
+	shift
+	insn_pick "$1"
+
+	# work around mark_action_done in insn_pause
+	echo '# pausing' >"$TODO.new"
+	cat "$TODO" >>"$TODO.new"
+	mv -f "$TODO.new" "$TODO"
+	insn_pause
+}
+
+
+options_squash="\
+squash <commit>
+squash [options] --from <mark>
+--
+from Squash all commits from <mark>
+collect-signoffs Collect Signed-off-by: lines
+include-merges Do not fail on merge commits
+$OPTIONS_GENERAL
+"
+
+# Check the "squash" instruction
+check_squash () {
+	from=
+	collect=
+	merges=
+	while test $# -gt 1
+	do
+		case "$1" in
+		--from)
+			from=t
+			;;
+		--collect-signoffs)
+			collect=t
+			todo_warn 'Not yet implemented.'
+			;;
+		--include-merges)
+			merges=t
+			;;
+		--)
+			shift
+			break
+			;;
+		*)
+			check_general_option "$@" ||
+				todo_error "Unknown option $1"
+			;;
+		esac
+		shift $general_shift
+	done
+
+	# in --from mode?
+	if test -n "$from"
+	then
+		test -z "$merges" &&
+			cat "$DONE" "$TODO" |
+			sed -n -e '/^[ \t]*mark[ \t]*:\{0,1\}'"${1#:}"'\($\|[^0-9]\)/,'"$line"'p' |
+			grep '^[ \t]*merge' >/dev/null &&
+			todo_error "$1..HEAD contains a merge commit. You may try --include-merges."
+
+		arg_is_mark_check "$1"
+	else
+		test -n "$merges" &&
+			todo_error '--include-merges only makes sense with --from <mark>.'
+		test -n "$collect" &&
+			todo_error '--collect-signoffs only makes sense with --from <mark>.'
+
+		commit_check "$1"
+	fi
+
+	return 0
+}
+
+# Realize the "squash" instruction
+insn_squash () {
+	squash_msg="$MSG-squash"
+	from=
+	while test $# -gt 1
+	do
+		case "$1" in
+		--from)
+			from=t
+			;;
+		--collect-signoffs)
+			warn '--collect-signoffs is not implemented.'
+			# XXX
+			;;
+		--include-merges)
+			: # This has to be done during check_squash
+			;;
+		--)
+			shift
+			break
+			;;
+		*)
+			handle_general_option "$@"
+			;;
+		esac
+		shift $general_shift
+	done
+
+	if test -n "$from"
+	then
+		sha1=$(mark_to_commit ":${1#:}")
+	else
+		sha1=$(git rev-parse --verify "$1")
+	fi
+
+	comment_for_reflog squash
+
+	# Hm, somehow I don't think --skip on a conflicting squash
+	# may be useful, but if someone wants to do it, it should
+	# do the obvious: skip what squash would do.
+	echo "$(git rev-parse HEAD)" >"$SEQ_DIR/skiphead"
+
+	mark_action_done
+
+	if test -n "$MESSAGE"
+	then
+		printf '%s\n' "$MESSAGE" >"$MSG"
+	else
+		if test -n "$from"
+		then
+			make_squash_message_multiple "$sha1" >"$MSG"
+		else
+			make_squash_message "$sha1" >"$MSG"
+		fi
+	fi
+
+	case "$(peek_next_command)" in
+	squash)
+		edit_commit=
+		use_perform=perform
+		cp "$MSG" "$squash_msg"
+		;;
+	*)
+		edit_commit=-e
+		use_perform=
+		rm -f "$squash_msg" || exit
+		;;
+	esac
+
+	test -n "$MESSAGE" && edit_commit=
+	test -n "$EDIT" && edit_commit=-e
+
+	# is --author (or equivalent) set?
+	if test -n "$AUTHOR"
+	then
+		# evaluate author script
+		get_current_author
+	else
+		# if --author is not given, we get the authorship
+		# information from the commit before.
+		eval "$(get_author_ident_from_commit HEAD)"
+		# but we do not write an author script
+	fi
+
+	# --from or not
+	failed=
+	if test -n "$from"
+	then
+		perform git reset --soft "$sha1"
+	else
+		perform git reset --soft HEAD^
+
+		pick_one cherry-pick -n "$sha1" || failed=t
+	fi
+
+	dashdash_signoff
+
+	if test -z "$failed"
+	then
+		# This is like --amend, but with a different message
+		with_author $use_perform git commit --no-verify \
+			-F "$MSG" $edit_commit || failed=t
+	else
+		cp "$MSG" "$GIT_DIR/MERGE_MSG"
+		warn
+		warn "Could not apply $sha1..."
+		die_with_patch $sha1 ""
+	fi
+
+	return 0
+}
+
+
+options_mark="\
+mark <mark>
+--
+"
+
+# Check the "mark" instruction
+check_mark () {
+	shift
+	test $# -eq 1 ||
+		todo_error "Wrong number of arguments. ($# given, 1 wanted)"
+	my_mark=$(expr "x${1#:}" : 'x0*\([0-9][0-9]*\)$')
+	test -n "$my_mark" ||
+		todo_error "Mark $1 not an integer."
+	expr "x$available_marks " : " $my_mark " >/dev/null &&
+		todo_error "Mark :$my_mark already defined. Choose another integer."
+	available_marks="$available_marks $my_mark"
+
+	return 0
+}
+
+# Realize the "mark" instruction
+insn_mark () {
+	shift
+	given="$1"
+
+	mark_action_done
+
+	mark=$(mark_to_ref ":${given#:}")
+	git update-ref "$mark" HEAD
+	return 0
+}
+
+
+options_merge="\
+merge [options] <commit-ish> ...
+--
+standard Generate default commit message
+s,strategy= Use merge strategy ...
+$OPTIONS_GENERAL
+"
+
+# Check the "merge" instruction
+check_merge () {
+	while test $# -gt 1
+	do
+		case "$1" in
+		--standard)
+			msg_opt="t$msg_opt"
+			;;
+		-s)
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			check_general_option "$@" ||
+				todo_error "Unknown option $1"
+			;;
+		esac
+		shift $general_shift
+	done
+
+	test $# -gt 0 ||
+		todo_error 'What are my parents? Need new parents!'
+
+	while test $# -gt 0
+	do
+		arg_is_mark_or_commit_check "$1"
+		shift
+	done
+	return 0
+}
+
+# Realize the "merge" instruction
+insn_merge () {
+	comment_for_reflog merge
+
+	standard=
+
+	while test $# -gt 1
+	do
+		case "$1" in
+		--standard)
+			standard=t
+			;;
+		-s)
+			shift
+			strategy="-s $1"
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			handle_general_option "$@"
+			;;
+		esac
+		shift $general_shift
+	done
+
+	new_parents=
+	for p in "$@"
+	do
+		new_parents="$new_parents $(mark_to_ref $p)"
+	done
+	new_parents="${new_parents# }"
+
+	get_current_author
+
+	if test -n "$standard"
+	then
+		for cur_parent in $new_parents
+		do
+			printf '%s\t\t%s' \
+				"$(git rev-parse "$cur_parent")" "$cur_parent"
+		done | git fmt-merge-msg >"$MSG"
+	fi
+
+	test -n "$MESSAGE" &&
+		printf '%s\n' "$MESSAGE" >"$MSG"
+
+	dashdash_signoff
+	if ! has_message "$MSG" || test -n "$EDIT"
+	then
+		echo "
+# Please enter the merge commit message.
+# (Comment lines starting with '#' will not be included)" >>"$MSG"
+
+		git_editor "$MSG" ||
+			die_with_patch 'Editor returned error.'
+		has_message "$MSG" ||
+			die_with_patch 'No commit message given.'
+	fi
+
+	mark_action_done
+	if ! with_author perform git merge $strategy -m junk $new_parents
+	then
+		git rerere
+		cp "$MSG" "$GIT_DIR/MERGE_MSG"
+		die_to_continue 'Error merging'
+	fi
+	with_author perform git commit --amend -F "$MSG" --no-verify
+	return 0
+}
+
+
+options_reset="\
+reset <commit-ish>
+--
+"
+
+# Check the "reset" instruction
+check_reset () {
+	shift
+	test $# -eq 1 ||
+		todo_error "Wrong number of arguments. ($# given, 1 wanted)"
+	arg_is_mark_or_commit_check "$1"
+
+	return 0
+}
+
+# Realize the "reset" instruction
+insn_reset () {
+	shift
+	comment_for_reflog reset
+
+	mark_action_done
+	perform git reset --hard "$(mark_to_commit "$1")"
+}
+
+
+options_ref="\
+ref <ref>
+--
+"
+
+# Check the "ref" instruction
+check_ref () {
+	shift
+	test $# -eq 1 ||
+		todo_error "Wrong number of arguments. ($# given, 1 wanted)"
+	return 0
+}
+
+# Realize the "ref" instruction
+insn_ref () {
+	shift
+	comment_for_reflog ref
+
+	mark_action_done
+	perform git update-ref "$1" HEAD
+}
+
+
+### Instruction main loop
+
+# Run check_* or insn_* with massaged options
+# Usage: run_insn (check|do) <insn> <insn options>
+run_insn () {
+	c_or_i="$1"
+	insn="$2"
+	shift
+	shift
+	eval "option_spec=\"\$options_$insn\""
+	eval "$(printf "%s" "$option_spec" |
+		git rev-parse --parseopt -- "$@" ||
+		echo return 1)"
+	case "$c_or_i" in
+	check)
+		check_$insn "$@"
+		;;
+	do)
+		insn_$insn "$@"
+		;;
+	esac
+}
+
+# Execute the first line of the current TODO file
+execute_next () {
+	read -r command rol <"$TODO"
+	test "$VERBOSE" -gt 1 &&
+		printf 'Next line: %s\n' "$command $rol"
+
+	case "$command" in
+	'#'*|'')
+		mark_action_done
+		;;
+	*)
+		# reset general options
+		rm -f "$AUTHOR_SCRIPT" "$MSG"
+		echo 'HEAD' >"$SEQ_DIR/skiphead"
+		general_shift=1
+		AUTHOR=
+		EDIT=
+		MESSAGE=
+		SIGNOFF=
+		# XXX: eval is evil!
+		eval "run_insn do $command $rol" ||
+			die_to_continue 'An unexpected error occured.'
+		;;
+	esac
+}
+
+# Execute the rest of the TODO file and finish
+execute_rest () {
+	while has_action "$TODO"
+	do
+		execute_next
+	done
+
+	comment_for_reflog finish
+	if test -n "$ONTO"
+	then
+		git update-ref -m "$GIT_REFLOG_ACTION: $ONTO" "$ONTO" HEAD &&
+		git symbolic-ref HEAD "$ONTO"
+	fi &&
+	quit
+}
+
+# We don't need to check a todo file if it has not changed
+# since it has last been acknowledged to be sane.
+todo_has_changed () {
+	test -f "$1.sum" || return 0
+	test "$(git hash-object "$1")" != "$(cat "$1.sum")"
+}
+
+# acknowledge todo file to be sane
+todo_ack () {
+	git hash-object "$1" >"$1.sum"
+}
+
+# Main loop to check instructions
+todo_check () {
+	todo="$TODO"
+	test -n "$1" && todo="$1"
+	todo_has_changed "$todo" || return 0
+
+	test "$VERBOSE" -lt 1 || printf 'Checking...\r'
+	available_marks=' '
+	for cur_mark in $(git for-each-ref --format='%(refname)' "$MARK_PREFIX")
+	do
+		available_marks="$available_marks ${cur_mark##*/}"
+	done
+
+	retval=0
+	line=1
+	while read -r command rol
+	do
+		case "$command" in
+		'#'*|'')
+			;;
+		*)
+			eval 'test -n "$options_'"$command"'"' || {
+				retval=1
+				todo_error "Unknown $command instruction"
+				continue
+			}
+
+			general_shift=1
+			msg_opt=
+			author_opt=
+			eval "run_insn check $command $rol" ||
+				todo_error "Unknown option used"
+			expr "$msg_opt" : 'ttt*' >/dev/null &&
+				todo_error 'You can only provide one commit message option.'
+			expr "$author_opt" : 'ttt*' >/dev/null &&
+				todo_error 'You can only provide one author option.'
+			;;
+		esac
+		line=$(expr "$line" + 1)
+	done <"$todo"
+	test $retval -ne 0 || todo_ack "$todo"
+	return $retval
+}
+
+prepare_editable_todo () {
+	echo '# ALREADY DONE:'
+	sed -e 's/^/#  /' <"$DONE"
+	echo '# '
+	echo "$markline"
+	cat "$TODO"
+}
+
+# expand shortcuts in TODO file $1
+expand_shortcuts () {
+	sed -e '
+		s/^[ \t]*p\>/pick/;
+		s/^[ \t]*e\>/edit/;
+		s/^[ \t]*s\>/squash/;
+	' <"$1" >"$TODO.cut"
+	mv "$TODO.cut" "$1"
+}
+
+get_saved_options () {
+	read VERBOSE <"$SEQ_DIR/verbose"
+	read ADVICE <"$SEQ_DIR/advice"
+	read ONTO <"$SEQ_DIR/onto"
+	test -f "$WHY_FILE" &&
+		read WHY <"$WHY_FILE"
+	return 0
+}
+
+# Realize sequencer invocation
+do_startup () {
+	test -d "$SEQ_DIR" &&
+		die 'sequencer already started'
+
+	require_clean_work_tree
+
+	HEAD=$(git rev-parse --verify HEAD) ||
+		die 'No HEAD?'
+
+	mkdir "$SEQ_DIR" ||
+		die "Could not create temporary $SEQ_DIR"
+
+	# save options
+	echo "$VERBOSE" >"$SEQ_DIR/verbose"
+	echo "$ADVICE" >"$SEQ_DIR/advice"
+	test -n "$CALLERSTRING" &&
+		generate_caller_script "$CALLERSTRING"
+	# generate empty DONE and "onto" file
+	: >"$DONE"
+	: >"$SEQ_DIR/onto"
+
+	if test -n "$BATCHMODE"
+	then
+		GIT_CHERRY_PICK_HELP='  Aborting (batch mode)'
+		export GIT_CHERRY_PICK_HELP
+	else
+		assure_caller
+	fi
+
+	comment_for_reflog start
+
+	# save old head before checking out the given <branch>
+	git symbolic-ref HEAD >"$SEQ_DIR/head-name" 2>/dev/null ||
+		echo 'detached HEAD' >"$SEQ_DIR/head-name"
+	echo $HEAD >"$SEQ_DIR/head"
+	# do it here so that die_abort can work ;)
+
+	if test -n "$ONTO"
+	then
+		# if ONTO is a branch name, then keep it, otherwise
+		# we don't care anymore and erase ONTO.
+		if git-show-ref --quiet --verify -- "refs/heads/${ONTO##*/}"
+		then
+			ONTO="refs/heads/${ONTO##*/}"
+			echo "$ONTO" >"$SEQ_DIR/onto"
+			perform git checkout "$(git rev-parse "$ONTO")" ||
+				die_abort "Could not checkout branch $ONTO"
+		else
+			perform git checkout "$ONTO" ||
+				die_abort "Could not checkout commit $ONTO"
+			ONTO=
+		fi
+	fi
+
+	(git var GIT_AUTHOR_IDENT || git var COMMITTER_IDENT) |
+		make_author_script_from_string >"$ORIG_AUTHOR_SCRIPT"
+
+	# read from file or from stdin?
+	if test -z "$1"
+	then
+		: >"$TODO" ||
+			die_abort "Could not generate TODO file $TODO"
+		while read -r line
+		do
+			printf '%s\n' "$line" >>"$TODO" ||
+				die_abort "Could not append to TODO file $TODO"
+		done
+	else
+		cp "$1" "$TODO" ||
+			die_abort "Could not find TODO file $1."
+	fi
+	expand_shortcuts "$TODO"
+
+	has_action "$TODO" || die_abort 'Nothing to do'
+	todo_check || WHY=todo die_to_continue "TODO file contains errors."
+
+	execute_rest
+	exit
+}
+
+# Realize --continue.
+do_continue () {
+	test -d "$SEQ_DIR" || die 'No sequencer running'
+	test_caller 'continue'
+
+	expand_shortcuts "$TODO"
+	todo_check || WHY=todo die_to_continue "TODO file contains errors."
+
+	comment_for_reflog continue
+
+	# Sanity check
+	git rev-parse --verify HEAD >/dev/null ||
+		die_to_continue 'Cannot read HEAD'
+	git update-index --ignore-submodules --refresh &&
+		git diff-files --quiet --ignore-submodules ||
+		die_to_continue 'Working tree is dirty. (Use git add or git stash first?)'
+
+	get_saved_options
+
+	# do we have anything to commit? (staged changes)
+	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
+	then
+		get_current_author
+
+		# After "pause", we should amend (merge-safe!).
+		# On conflict, we do not have a commit to amend, so we
+		# should just commit.
+		case "$WHY" in
+		pause|run)
+			with_author git commit --amend --no-verify -F "$MSG" -e ||
+				die_to_continue 'Could not commit staged changes.'
+			;;
+		conflict)
+			with_author git commit --no-verify -F "$MSG" -e ||
+				die_to_continue 'Could not commit staged changes.'
+			echo '# resolved CONFLICTS of the last instruction' >>"$DONE"
+			;;
+		*)
+			die_to_continue 'There are staged changes. Do not know what to do with them.'
+		esac
+	fi
+
+	require_clean_work_tree
+	clean_why
+	execute_rest
+	exit
+}
+
+# Realize --abort.
+do_abort () {
+	test -d "$SEQ_DIR" || die 'No sequencer running'
+	test_caller 'abort'
+
+	comment_for_reflog abort
+	git rerere clear
+	restore
+	quit
+}
+
+# Realize --skip.
+do_skip () {
+	test -d "$SEQ_DIR" || die 'No sequencer running'
+	test_caller 'skip'
+
+	expand_shortcuts "$TODO"
+	todo_check || WHY=todo die_to_continue "TODO file contains errors."
+	get_saved_options
+
+	comment_for_reflog skip
+	git rerere clear
+	clean_why
+
+	perform git reset --hard "$(cat "$SEQ_DIR/skiphead")" &&
+	echo '# SKIPPED the last instruction' >>"$DONE" &&
+		execute_rest
+	exit
+}
+
+# Realize --edit.
+do_edit () {
+	test -d "$SEQ_DIR" || die 'No sequencer running'
+
+	markline='### BEGIN EDITING BELOW THIS LINE ###'
+	prepare_editable_todo >"$TODO.new"
+	if todo_has_changed "$TODO"
+	then
+		sane=
+	else
+		sane=t
+		todo_ack "$TODO.new"
+	fi
+
+	# XXX: does not make sense
+	#      when input does not come from a terminal
+	git_editor "$TODO.new" ||
+		die 'Editor returned an error.'
+
+	if test -t 0 -a -t 1
+	then
+		sane=t
+		echo
+		# interactive:
+		until has_action "$TODO.new" && todo_check "$TODO.new"
+		do
+			has_action "$TODO.new" || echo 'TODO file empty.'
+			printf 'What to do with the file? [c]orrect/[e]dit again/[r]ewind/[s]ave/[?] '
+			read reply
+			case "$reply" in
+			[cC]*)
+				git_editor "$TODO.new"
+				expand_shortcuts "$TODO.new"
+				;;
+			[eE]*)
+				prepare_editable_todo >"$TODO.new"
+				git_editor "$TODO.new"
+				expand_shortcuts "$TODO.new"
+				;;
+			[rRxXqQ]*)
+				rm -f "$TODO.new" "$TODO.new.sum"
+				exit 0
+				;;
+			[sS]*)
+				test "$WHY" != 'pause' ||
+					echo 'todo' >"$WHY_FILE"
+				sane=
+				break
+				;;
+			[?hH]*)
+				cat <<EOF
+
+Help:
+s - save TODO file and exit
+c - respawn editor to correct TODO file
+e - drop changes and respawn editor on original TODO file
+r - drop changes and exit as if nothing happened
+? - print this help
+EOF
+				;;
+			esac
+			echo
+		done
+	else
+		# defaults:
+		has_action "$TODO.new" || quit "Nothing to do"
+		todo_check "$TODO.new" ||
+			die 'TODO file contains errors. Aborting.'
+	fi
+	cp "$TODO" "$TODO.old"
+	if grep "^$markline" "$TODO.new" >/dev/null
+	then
+		sed -e "1,/^$markline/d" <"$TODO.new" >"$TODO"
+	else
+		cp "$TODO.new" "$TODO"
+	fi
+	rm -f "$TODO.new" "$TODO.new.sum"
+	test -z "$sane" || todo_ack "$TODO"
+	echo
+	echo 'TODO file contains:'
+	echo
+	cat "$TODO"
+	exit 0
+}
+
+# Realize --status.
+do_status () {
+	test -d "$SEQ_DIR" || die 'No sequencer running.'
+	get_saved_options
+
+	if has_action "$DONE"
+	then
+		echo 'Already done (or tried):'
+		sed -e 's/^/  /' <"$DONE"
+		echo
+	fi
+	case "$WHY" in
+	pause)
+		echo 'Intentionally paused.'
+		;;
+	run)
+		echo 'Interrupted because running failed.'
+		;;
+	conflict)
+		echo 'Interrupted by conflict at'
+		sed -n -e 's/^/  /;$p' <"$DONE"
+		;;
+	todo)
+		echo 'Interrupted because of errors in the TODO file.'
+		;;
+	*)
+		echo 'Current state is broken.'
+	esac
+	test "$VERBOSE" -gt 1 && echo 'Running verbosely.'
+	test "$VERBOSE" -lt 1 && echo 'Running quietly.'
+	test -n "$ONTO" &&
+		echo "Sequencing on branch ${ONTO##*/}."
+	if has_action "$TODO"
+	then
+		echo
+
+		echo 'Still to do:'
+		sed -e 's/^/  /' <"$TODO"
+	fi
+	if test "$WHY" = todo
+	then
+		echo
+		echo 'But there are errors. To edit, run:'
+		echo '    git sequencer --edit'
+	else
+		echo
+		echo 'To abort & restore, invoke:'
+		echo "    $(print_caller --abort)"
+		echo 'To continue, invoke:'
+		echo "    $(print_caller --continue)"
+		test "$WHY" = 'pause' -o "$WHY" = 'run' || {
+			echo 'To skip the current instruction, invoke:'
+			echo "    $(print_caller --skip)"
+		}
+	fi
+	exit 0
+}
+
+is_standalone () {
+	test $# -eq 2 &&
+	test "$2" = '--' &&
+	test -z "$BATCHMODE" &&
+	test "$ADVICE" = t &&
+	test -z "$onto" &&
+	test "$VERBOSE" -eq 1
+}
+
+
+### Option handling and startup
+
+onto=
+BATCHMODE=
+CALLERSTRING=
+VERBOSE=1
+ADVICE=t
+CALLER=
+CALLER_ABRT=
+CALLER_CONT=
+CALLER_SKIP=
+while test $# -gt 0
+do
+	case "$1" in
+	--continue)
+		is_standalone "$@" || usage
+		assure_caller
+		do_continue
+		;;
+	--abort)
+		is_standalone "$@" || usage
+		assure_caller
+		do_abort
+		;;
+	--skip)
+		is_standalone "$@" || usage
+		assure_caller
+		do_skip
+		;;
+	--status)
+		is_standalone "$@" || usage
+		assure_caller
+		do_status
+		;;
+	--edit)
+		is_standalone "$@" || usage
+		do_edit
+		;;
+	--caller)
+		###############################################################
+		# This feature is for user scripts only. (Hence undocumented.)
+		# User scripts should pass an argument like:
+		# --caller="git foo|abrt|go|next"
+		# on every git sequencer call. (It is only ignored on
+		# --edit and --status.)
+		# So git sequencer knows that
+		# "git foo abrt" will abort,
+		# "git foo go" will continue and
+		# "git foo next" will skip the sequencing process.
+		# This is useful if your user script does some extra
+		# preparations or cleanup before/after calling
+		#   git sequencer --caller="..." --abort|--continue|--skip
+		#
+		# Running git-sequencer without the same --caller string
+		# fails then, until the sequencing process has finished or
+		# aborted.
+		#
+		# Btw, --caller="my_tiny_script.sh|-a||" will be
+		# interpreted, that users must invoke "my_tiny_script.sh -a"
+		# to abort, but can invoke "git sequencer --continue" and
+		# "git sequencer --skip" to continue or skip.
+		# And it is also possible to provide three different scripts
+		# by --caller="|script 1|tool 2|util 3".
+		#
+		# If your user script does not need any special
+		# abort/continue/skip behavior, then just do NOT pass
+		# the --caller option.
+		###############################################################
+		shift
+		expr "x$1" : 'x.*|.*|.*|.*$' >/dev/null ||
+			die 'Wrong --caller format.'
+		CALLERSTRING="$1"
+		;;
+	-B)
+		BATCHMODE=t
+		# XXX: we still have abort on editor invokations
+		;;
+	--no-advice)
+		ADVICE=f
+		;;
+	--onto)
+		shift
+		ONTO="$1"
+		test $(git cat-file -t "$ONTO") = 'commit' ||
+			die "$ONTO is no commit or branch."
+		;;
+	-q)
+		VERBOSE=0
+		ADVICE=f
+		# XXX: If there were no editors,
+		# we could just do exec >/dev/null
+		;;
+	-v)
+		VERBOSE=2
+		# or increment it if we have several verbosity steps
+		;;
+	--)
+		shift
+		break
+		;;
+	*)
+		die "$1 currently not implemented."
+		;;
+	esac
+	shift
+done
+test $# -gt 1 && usage
+
+do_startup "$1"
-- 
1.5.6.3.391.ge45b

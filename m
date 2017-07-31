Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845AD1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdGaV0g (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:26:36 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:35471 "EHLO
        coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdGaV0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:26:33 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jul 2017 17:26:32 EDT
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
        by coral.adamspiers.org (Postfix) with ESMTPSA id 38ECC2E299
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 22:18:51 +0100 (BST)
From:   Adam Spiers <git@adamspiers.org>
To:     git list <git@vger.kernel.org>
Subject: [PATCH 1/1] add git-splice command for non-interactive branch splicing
Date:   Mon, 31 Jul 2017 22:18:49 +0100
Message-Id: <c3213758552a02e233d9c173f0c52d05d2460a0f.1501535033.git-series.git@adamspiers.org>
X-Mailer: git-send-email 2.14.0.rc1.2.g921b285a1.dirty
In-Reply-To: <cover.55495badd28b73b39c60ca4107b50aae7ee95028.1501535033.git-series.git@adamspiers.org>
References: <cover.55495badd28b73b39c60ca4107b50aae7ee95028.1501535033.git-series.git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new subcommand git-splice(1) which non-interactively splices the
current branch by removing a range of commits from within it and/or
cherry-picking a range of commits into it.

It's essentially a convenience wrapper around cherry-pick and
interactive rebase, but the workflow state is persisted to disk, and
thereby supports standard --abort and --continue semantics just like
git's other extended workflow commands.  It also handles more complex
cases, as described in the manual page.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 .gitignore                   |   1 +-
 Documentation/git-splice.txt | 125 ++++++-
 Makefile                     |   1 +-
 git-splice.sh                | 737 ++++++++++++++++++++++++++++++++++++-
 t/t7900-splice.sh            | 630 +++++++++++++++++++++++++++++++-
 5 files changed, 1494 insertions(+)
 create mode 100644 Documentation/git-splice.txt
 create mode 100755 git-splice.sh
 create mode 100755 t/t7900-splice.sh

diff --git a/.gitignore b/.gitignore
index 833ef3b..4062009 100644
--- a/.gitignore
+++ b/.gitignore
@@ -150,6 +150,7 @@
 /git-show-branch
 /git-show-index
 /git-show-ref
+/git-splice
 /git-stage
 /git-stash
 /git-status
diff --git a/Documentation/git-splice.txt b/Documentation/git-splice.txt
new file mode 100644
index 0000000..29f3ac8
--- /dev/null
+++ b/Documentation/git-splice.txt
@@ -0,0 +1,125 @@
+git-splice(1)
+=============
+
+NAME
+----
+git-splice - Splice commits into/out of current branch
+
+SYNOPSIS
+--------
+[verse]
+'git splice' <insertion point> <cherry pick range>
+'git splice' <insertion point> \-- <cherry pick range args ...>
+'git splice' [-r|--root] <remove range> [<cherry pick range>]
+'git splice' [-r|--root] <remove range args ...> \-- [<cherry pick range args ...>]
+'git splice' (--abort | --continue | --in-progress)
+
+DESCRIPTION
+-----------
+Non-interactively splice branch by removing a range of commits from
+within the current branch, and/or cherry-picking a range of commits
+into the current branch.
+
+<remove range> specifies the range of commits to remove from the
+current branch, and <cherry-pick-range> specifies the range to insert
+at the point where <remove-range> previously existed, or just after
+<insertion-point>.
+
+<insertion point> is a commit-ish in the standard format accepted
+by linkgit:git-rev-parse[1].
+
+<remove range> and <cherry pick range> are single shell words
+specifying commit ranges in the standard format accepted by
+linkgit:git-rev-list[1], e.g.
+
+    A..B
+    A...B
+    A^!   (just commit A)
+
+It is possible to pass multi-word specifications for both the removal
+and insertion ranges, in which case they are passed to
+linkgit:git-rev-list[1] to calculate the commits to remove or
+cherry-pick.  For this you need to terminate <remove range args> with
+`--` to indicate that the multi-word form of parameters is being used.
+
+When the `--root` option is present, a removal range can be specified
+as a commit-ish in the standard format accepted by
+linkgit:git-rev-parse[1], in which case the commit-ish is treated as a
+range.  This makes it possible to remove or replace root
+(i.e. parentless) commits.
+
+Currently git-splice assumes that all commits being operated on have a
+single parent; removal and insertion of merge commits is not supported.
+
+N.B. Obviously this command rewrites history!  As with
+linkgit:git-rebase[1], you should be aware of all the implications of
+history rewriting before using it.  (And actually this command is just
+a glorified wrapper around linkgit:git-cherry-pick[1] and
+linkgit:git-rebase[1] in interactive mode.)
+
+OPTIONS
+-------
+
+-r::
+--root::
+	Treat (each) removal range argument as a commit-ish, and
+	remove all its ancestors.
+
+--abort::
+	Abort an in-progress splice.
+
+--continue::
+	Resume an in-progress splice.
+
+--in-progress::
+	Exit 0 if and only if a splice is in progress.
+
+EXAMPLES
+--------
+
+`git splice A..B`::
+
+	Remove commits A..B (i.e. excluding A) from the current branch.
+
+`git splice A^!`::
+
+	Remove commit A from the current branch.
+
+`git splice --root A`::
+
+	Remove commit A and all its ancestors (including the root commit)
+	from the current branch.
+
+`git splice A..B C..D`::
+
+	Remove commits A..B from the current branch, and cherry-pick
+	commits C..D at the same point.
+
+`git splice A C..D`::
+
+	Cherry-pick commits C..D, splicing them in just after commit A.
+
+`git splice --since=11am --grep="foo" --`::
+
+	Remove all commits since 11am this morning mentioning "foo".
+
+`git splice --abort`::
+
+	Abort a splice which failed during cherry-pick or rebase.
+
+`git splice --continue`::
+
+	Resume a splice after manually fixing conflicts caused by
+	cherry-pick or rebase.
+
+`git splice --in-progress && git splice --abort`::
+
+	Abort if there is a splice in progress.
+
+SEE ALSO
+--------
+linkgit:git-rebase[1], linkgit:git-cherry-pick[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 461c845..eeaabc2 100644
--- a/Makefile
+++ b/Makefile
@@ -547,6 +547,7 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
+SCRIPT_SH += git-splice.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/git-splice.sh b/git-splice.sh
new file mode 100755
index 0000000..e4f3e53
--- /dev/null
+++ b/git-splice.sh
@@ -0,0 +1,737 @@
+#!/bin/bash
+#
+# git-splice - splice commits into/out of current branch
+# Copyright (c) 2016 Adam Spiers
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# ---------------------------------------------------------------------
+#
+
+dashless=$(basename "$0" | sed -e 's/-/ /')
+USAGE="<insertion point> <cherry pick range>
+   or: $dashless <insertion point> -- <cherry pick range args ...>
+   or: $dashless [-r|--root] <remove range> [<cherry pick range>]
+   or: $dashless [-r|--root] <remove range args> ... -- <cherry pick range args ...>
+   or: $dashless (--abort | --continue | --in-progress)"
+LONG_USAGE=\
+'    -h, --help     Show this help and exit
+     -r, root      Treat (each) removal range argument as a commit-ish, and
+                   remove all its ancestors.
+    --abort        Abort an in-progress splice
+    --continue     Continue an in-progress splice
+    --in-progress  Exit 0 if and only if a splice is in progress'
+
+OPTIONS_SPEC=
+. git-sh-setup
+
+export PS4="+\${BASH_SOURCE/\$HOME/\~}@\${LINENO}(\${FUNCNAME[0]}): "
+
+me=$(basename $0)
+git_dir=$(git rev-parse --git-dir) || exit 1
+splice_dir="$git_dir/splice"
+base_file="$splice_dir/base"
+branch_file="$splice_dir/branch"
+insert_todo="$splice_dir/insert-todo"
+remove_todo="$splice_dir/remove-todo"
+rebase_exit="$splice_dir/rebase-exit"
+rebase_cancelled="$splice_dir/rebase-cancelled"
+TMP_BRANCH="tmp/splice"
+
+main () {
+	parse_opts "$@"
+
+	if test -n "$in_progress"
+	then
+		if in_progress
+		then
+			echo "Splice in progress: $reason"
+			exit 0
+		else
+			echo "Splice not in progress"
+			exit 1
+		fi
+	fi
+
+	if test -n "$abort" || test -n "$continue" || test -n "$rebase_edit"
+	then
+		ensure_splice_in_progress
+	else
+		# Needs to happen before parse_args(), otherwise the in-flight
+		# files will already exist.
+		ensure_splice_not_in_progress
+	fi
+
+	parse_args "${ARGV[@]}"
+
+	if test -n "$rebase_edit"
+	then
+		# We're being invoked by git rebase as the rebase todo list editor,
+		# rather than by the user.  This mode is for internal use only.
+		rebase_edit
+		return
+	fi
+
+	if test -n "$abort"
+	then
+		splice_abort
+		return
+	fi
+
+	# Handle both normal execution and --continue
+	splice
+}
+
+prepare_tmp_branch () {
+	if valid_ref "$TMP_BRANCH"
+	then
+		if test -z "$continue"
+		then
+			die "BUG: $TMP_BRANCH exists but no --continue"
+		fi
+
+		if ! on_tmp_branch
+		then
+			: "Presumably on a detached head in the middle of a rebase"
+		fi
+	else
+		if removing_root
+		then
+			echo git checkout -q --orphan "$TMP_BRANCH"
+			git checkout -q --orphan "$TMP_BRANCH"
+			git reset --hard
+		else
+			echo git checkout -q -B "$TMP_BRANCH" "$base"
+			git checkout -q -B "$TMP_BRANCH" "$base"
+		fi
+	fi
+}
+
+do_cherry_picks () {
+	if cherry_pick_active
+	then
+		if ! git cherry-pick --continue
+		then
+			error_and_pause "git cherry-pick --continue failed!"
+		fi
+	else
+		reason="cat $insert_todo | xargs git cherry-pick"
+		if ! cat $insert_todo | xargs -t git cherry-pick
+		then
+			error_and_pause "git cherry-pick failed!"
+		fi
+		rm "$insert_todo"
+	fi
+}
+
+do_rebase () {
+	if rebase_active
+	then
+		args=( --continue )
+	elif removing_root
+	then
+		args=( -i --root "$branch" )
+	else
+		args=( -i --onto "$TMP_BRANCH" "$base" "$branch" )
+	fi
+
+	# We make git rebase -i use a special internal-only invocation of
+	# git-splice which non-interactively edits the temporary
+	# $rebase_todo file.
+	export GIT_SEQUENCE_EDITOR="$0 $debug --rebase-edit"
+
+	echo git rebase "${args[@]}"
+	# git rebase can output messages on STDOUT or STDERR depending
+	# on whether verbose is enabled.  Either way we want to catch
+	# references to "git rebase --continue" / "git rebase --abort"
+	# and tweak them to refer to git splice instead.
+	#
+	# To achieve that, we filter both STDOUT and STDERR through pipes,
+	# using a clever technique explained here:
+	# http://wiki.bash-hackers.org/howto/redirection_tutorial
+	rm -f "$rebase_exit"
+	{
+		{
+			{
+				git rebase "${args[@]}" 3>&-;
+				echo $? >"$rebase_exit"
+			} |
+				tweak_rebase_error 2>&3 3>&-
+		} 2>&1 >&4 4>&- |
+			tweak_rebase_error 3>&- 4>&-
+	} 3>&2 4>&1
+	rebase_exitcode="$(cat $rebase_exit)"
+	rm -f "$rebase_exit"
+	if test "$rebase_exitcode" != 0
+	then
+		if test -e "$rebase_cancelled"
+		then
+			: "happens if there were no commits (left) to rebase"
+			git reset --hard "$TMP_BRANCH"
+			rm "$rebase_cancelled"
+		else
+			error_and_pause "git rebase ${args[*]} failed!"
+		fi
+	fi
+}
+
+splice () {
+	base="$(cat $base_file)"
+	branch="$(cat $branch_file)"
+
+	validate_base
+
+	if removing_root
+	then
+		if test -s "$insert_todo"
+		then
+			# If we're creating a new root commit, it will either come
+			# by cherry-picking onto a new orphaned $TMP_BRANCH, if we
+			# have any cherry-picking to do:
+			prepare_tmp_branch
+		else
+			# or it will come via rebase --root, in which case we don't
+			# need a temporary branch.
+			no_tmp_branch=y
+		fi
+	else
+		prepare_tmp_branch
+	fi
+
+	if test -s "$insert_todo"
+	then
+		do_cherry_picks
+	fi
+
+	if ! removing_root && test "$base" = "$branch"
+	then
+		echo git checkout -B "$branch" "$TMP_BRANCH"
+		git checkout -B "$branch" "$TMP_BRANCH"
+	else
+		do_rebase
+	fi
+
+	if test -z "$no_tmp_branch"
+	then
+		git branch -d "$TMP_BRANCH"
+	fi
+	rm -rf "$splice_dir"
+}
+
+tweak_rebase_error () {
+	grep -v 'When you have resolved this problem, run "git rebase --continue"\.' |
+		sed -e 's/git rebase \(--continue\|--abort\)/git splice \1/g'
+}
+
+valid_ref () {
+	git rev-parse --quiet --verify "$@" >/dev/null
+}
+
+# Returns true (0) iff the arguments passed explicitly describe a
+# range of commits (e.g. A..B).  Note that this deliberately returns
+# false when fed a single commit-ish A, even though a commit-ish
+# technically describes a range covering A and all its ancestors.
+# This is used to infer whether the user intended this commit to be
+# interpreted as an insertion point or a removal range, when it is not
+# made clear by the use of --root or a particular combination of
+# arguments on ARGV.
+valid_commit_range () {
+	if ! parsed=( $(git rev-parse "$@" 2>/dev/null) )
+	then
+		cleanup
+		fatal "Failed to parse commit range $1"
+	fi
+	test "${#parsed[@]}" -gt 1
+}
+
+cherry_pick_active () {
+	# Ideally git rebase would have some plumbing for this, so
+	# we wouldn't have to assume knowledge of internals.
+	valid_ref CHERRY_PICK_HEAD
+}
+
+rebase_active () {
+	# Ideally git rebase would have some plumbing for this, so
+	# we wouldn't have to assume knowledge of internals.  See:
+	# http://stackoverflow.com/questions/3921409/how-to-know-if-there-is-a-git-rebase-in-progress
+	test -e "$git_dir/rebase-merge" ||
+		test -e "$git_dir/rebase-apply"
+}
+
+removing_root () {
+	test "$base" = 'ROOT'
+}
+
+validate_base () {
+	if test -z "$base"
+	then
+		die "BUG: base should not be empty"
+	fi
+
+	if removing_root
+	then
+		: "We're removing the root commit"
+		return
+	fi
+
+	if ! valid_ref "$base"
+	then
+		cleanup
+		die "BUG: base commit $base was not valid"
+	fi
+}
+
+error_and_pause () {
+	warn "$*"
+	warn "When you have resolved this problem, run \"git splice --continue\","
+	warn "or run \"git splice --abort\" to abandon the splice."
+	exit 1
+}
+
+in_progress () {
+	if test -e "$insert_todo"
+	then
+		reason="$insert_todo exists"
+		return 0
+	fi
+
+	if test -e "$remove_todo"
+	then
+		reason="$remove_todo exists"
+		return 0
+	fi
+
+	if test -d "$splice_dir"
+	then
+		reason="$splice_dir exists"
+		return 0
+	fi
+
+	if on_tmp_branch
+	then
+		reason="on $TMP_BRANCH branch"
+		return 0
+	fi
+
+	reason=
+	return 1
+}
+
+cleanup () {
+	aborted=
+
+	if test -e "$insert_todo"
+	then
+		# Can we be sure that the in-flight cherry-pick was started by
+		# git splice?  Probably, because otherwise
+		# ensure_cherry_pick_not_in_progress should have prevented us
+		# from reaching this point in the code.
+		if cherry_pick_active
+		then
+			git cherry-pick --abort
+		fi
+
+		rm "$insert_todo"
+		aborted=y
+	fi
+
+	if test -e "$remove_todo"
+	then
+		if rebase_active
+		then
+			git rebase --abort
+		fi
+
+		rm "$remove_todo"
+		aborted=y
+	fi
+
+	if valid_ref "$TMP_BRANCH"
+	then
+		if on_tmp_branch
+		then
+			git checkout "$(cat $branch_file)"
+		fi
+
+		git branch -d "$TMP_BRANCH"
+		aborted=y
+	fi
+
+	if test -d "$splice_dir"
+	then
+		rm -rf "$splice_dir"
+		aborted=y
+	fi
+}
+
+splice_abort () {
+	cleanup
+
+	if test -z "$aborted"
+	then
+		fatal "No splice in progress"
+	fi
+}
+
+head_ref () {
+	git symbolic-ref --short -q HEAD
+}
+
+on_branch () {
+	[ "$(head_ref)" = "$1" ]
+}
+
+on_tmp_branch () {
+	on_branch "$TMP_BRANCH"
+}
+
+ensure_splice_in_progress () {
+	if ! in_progress
+	then
+		fatal "Splice not in progress"
+	fi
+}
+
+ensure_splice_not_in_progress () {
+	for file in "$insert_todo" "$remove_todo"
+	do
+		if test -e "$file"
+		then
+			in_progress_error "$file already exists."
+		fi
+	done
+
+	ensure_cherry_pick_not_in_progress
+	ensure_rebase_not_in_progress
+
+	if on_tmp_branch
+	then
+		fatal "On $TMP_BRANCH branch, but no splice in progress."\
+		    "Try switching to another branch first."
+	fi
+
+	if valid_ref "$TMP_BRANCH"
+	then
+		fatal "$TMP_BRANCH branch exists, but no splice in"\
+		    "progress. Try deleting $TMP_BRANCH first."
+	fi
+}
+
+in_progress_error () {
+	cat <<EOF >&2
+$*
+
+git splice already in progress; please complete it, or run
+
+  git splice --abort
+EOF
+	exit 1
+}
+
+ensure_cherry_pick_not_in_progress () {
+	if cherry_pick_active
+	then
+		fatal "Can't start git splice when there is a"\
+		      "cherry-pick in progress"
+	fi
+}
+
+ensure_rebase_not_in_progress () {
+	if rebase_active
+	then
+		warn "Can't start git splice when there is a rebase in progress."
+
+		# We know this will fail; we run it because we want to output
+		# the same error message which git-rebase uses to tell the user
+		# to finish or abort their in-flight rebase.
+		git rebase
+		exit 1
+	fi
+}
+
+rebase_edit () {
+	if ! test -e "$rebase_todo"
+	then
+		die "BUG: $me invoked in rebase edit mode,"\
+		    "but $rebase_todo was missing"
+	fi
+
+	if test -e "$remove_todo"
+	then
+		sed -i 's/^\([0-9a-f]\+\)$/^pick \1/' "$remove_todo"
+		grep -v -f "$remove_todo" "$rebase_todo" >"$rebase_todo".new
+		if test -n "$debug"
+		then
+			set +x
+			echo -e "-----------------------------------"
+			echo "$rebase_todo"
+			cat "$rebase_todo"
+			echo -e "-----------------------------------"
+			echo "$remove_todo"
+			cat "$remove_todo"
+			echo -e "-----------------------------------"
+			echo "$rebase_todo.new"
+			cat "$rebase_todo.new"
+			set -x
+		fi
+		mv "$rebase_todo".new "$rebase_todo"
+	fi
+
+	if ! grep '^ *[a-z]' "$rebase_todo"
+	then
+		echo "Nothing left to rebase; cancelling."
+		>"$rebase_todo"
+		touch "$rebase_cancelled"
+	fi
+}
+
+warn () {
+	echo >&2 "$*"
+}
+
+fatal () {
+	die "fatal: $*"
+}
+
+parse_opts () {
+	ORIG_ARGV=( "$@" )
+	while test $# != 0
+	do
+		case "$1" in
+		-h|--help)
+			usage
+			;;
+		-v|--version)
+			echo "$me $VERSION"
+			;;
+		-d|--debug)
+			debug=--debug
+			echo >&2 "#-------------------------------------------------"
+			echo >&2 "# Invocation: $0 ${ORIG_ARGV[@]}"
+			set -x
+
+			shift
+			;;
+		--continue)
+			continue=yes
+			shift
+			;;
+		--abort)
+			abort=yes
+			shift
+			;;
+		--in-progress)
+			in_progress=yes
+			shift
+			;;
+		-r|--root)
+			root=yes
+			shift
+			;;
+		# for internal use only
+		--rebase-edit)
+			rebase_edit=yes
+			rebase_todo="$2"
+			shift 2
+			;;
+		*)
+			break
+			;;
+		esac
+	done
+
+	if echo "$continue$abort$in_progress" | grep -q yesyes
+	then
+		fatal "You must only select one of --abort, --continue,"\
+		    "and --in-progress."
+	fi
+
+	ARGV=( "$@" )
+}
+
+detect_remove_range_or_insertion_point () {
+	# Figure out whether the first parameter is a remove range
+	# or insertion point.
+	if test -z "$root"
+	then
+		if valid_commit_range "$@"
+		then
+			: "$1 must be a removal range"
+			remove_range=( "$@" )
+		else
+			: "$* must be an insertion point"
+			insertion_point="$@"
+		fi
+	else
+		# The user has explicitly requested a removal of the
+		# commit-ish and all its ancestors.
+		remove_range=( "$@" )
+	fi
+}
+
+parse_args () {
+	if test -n "$abort" || test -n "$continue" ||
+			test -n "$in_progress" || test -n "$rebase_edit"
+	then
+		return
+	fi
+
+	count=$#
+	for word in "$@"
+	do
+		if test "$word" = '--'
+		then
+			multi_word=yes
+			count=$(( $count - 1 ))
+			break
+		fi
+	done
+
+	if test $count -eq 0
+	then
+		fatal "You must specify at least one range to splice."
+	fi
+
+	if test -z "$multi_word"
+	then
+		# No "--" argument present, so the number of arguments is significant.
+		if test $# -eq 1
+		then
+			if test -z "$root"
+			then
+				# In this invocation form, $1 must be a removal range,
+				# because nothing has been given to cherry-pick.
+				if ! valid_commit_range "$1"
+				then
+					fatal "$1 is not a valid removal range"
+				fi
+			else
+				# The user has explicitly requested a removal of the
+				# commit-ish and all its ancestors.
+				if ! valid_ref "$1"
+				then
+					fatal "$1 is not a valid removal commit-ish"
+				fi
+			fi
+			remove_range=( "$1" )
+		elif test $# -eq 2
+		then
+			insert_range=( "$2" )
+			detect_remove_range_or_insertion_point "$1"
+		elif test $# -ge 2
+		then
+			fatal "Use of multiple words in the removal or insertion"\
+			    "ranges requires the -- separator"
+		fi
+	else
+		# "--" argument is present, so split
+		remove_range_or_insertion_base=()
+		for word in "$@"
+		do
+			if test "$word" = '--'
+			then
+				shift
+				insert_range=( "$@" )
+				break
+			fi
+			remove_range_or_insertion_base+=( "$word" )
+			shift
+		done
+
+		detect_remove_range_or_insertion_point \
+			"${remove_range_or_insertion_base[@]}"
+	fi
+
+	mkdir -p "$splice_dir"
+
+	if ! head_ref >"$branch_file"
+	then
+		rm "$branch_file"
+		fatal "Cannot run $me on detached head"
+	fi
+
+	if [ "${#remove_range[@]}" -gt 0 ]
+	then
+		# In this case we already know it's a range
+		: "removing range ${remove_range[@]}"
+		check_no_merge_commits "Removing" "${remove_range[@]}"
+		populate_remove_todo "${remove_range[@]}"
+		populate_base_file "${remove_range[@]}"
+	elif test -n "$insertion_point"
+	then
+		echo "$insertion_point" >"$base_file"
+	else
+		die "BUG: didn't get removal range or insertion point"
+	fi
+
+	if [ "${#insert_range[@]}" -gt 0 ]
+	then
+		if ! valid_commit_range "${insert_range[@]}"
+		then
+			cleanup
+			fatal "Failed to parse ${insert_range[*]} as insertion range"
+		fi
+
+		check_no_merge_commits "Inserting" "${insert_range[@]}"
+
+		if [ "${#insert_range[@]}" -eq 1 ]
+		then
+			echo "${insert_range[@]}" >"$insert_todo"
+		else
+			git rev-list --reverse "${insert_range[@]}" >"$insert_todo"
+		fi
+	fi
+}
+
+check_no_merge_commits () {
+	action="$1"
+	shift
+	if git rev-list --min-parents=2 -n1 "$@" | grep -q .
+	then
+		cleanup
+		fatal "$action merge commits is not supported"
+	fi
+}
+
+populate_remove_todo () {
+	git rev-list --abbrev-commit "$@" >"$remove_todo"
+	if ! test -s "$remove_todo"
+	then
+		cleanup
+		fatal "No commits found in removal range $*"
+	fi
+	newest=$(head -n1 "$remove_todo")
+	newest=$(git rev-parse "$newest") # unabbreviate for comparison below
+	head=$(head_ref)
+	mb=$(git merge-base "$newest" "$head")
+	if test "$mb" != "$newest"
+	then
+		cleanup
+		fatal "$newest is in removal range but not in $head branch"
+	fi
+}
+
+populate_base_file () {
+	earliest=$(tail -n1 "$remove_todo")
+	echo "Earliest commit in $@ is $earliest"
+	if git rev-list --min-parents=1 -n1 "${earliest}" | grep -q .
+	then
+		# Earliest in removal range has a parent
+		echo "${earliest}^" >"$base_file"
+	else
+		echo "ROOT" >"$base_file"
+	fi
+}
+
+main "$@"
diff --git a/t/t7900-splice.sh b/t/t7900-splice.sh
new file mode 100755
index 0000000..5654309
--- /dev/null
+++ b/t/t7900-splice.sh
@@ -0,0 +1,630 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Adam Spiers
+#
+
+test_description='git splice
+
+This tests all features of git-splice.
+'
+
+. ./test-lib.sh
+
+TMP_BRANCH=tmp/splice
+
+#############################################################################
+# Setup
+
+for i in one two three
+do
+	for j in a b
+	do
+		tag=$i-$j
+		test_expect_success "setup $i" "
+			echo $i $j >> $i &&
+			git add $i &&
+			git commit -m \"$i $j\" &&
+			git tag $tag"
+	done
+done
+git_dir=`git rev-parse --git-dir`
+latest_tag=$tag
+
+setup_other_branch () {
+	branch="$1" base="$2"
+	shift 2
+	git checkout -b $branch $base &&
+	for i in "$@"
+	do
+		echo $branch $i >> $branch &&
+		git add $branch &&
+		git commit -m "$branch $i" &&
+		git tag "$branch-$i"
+	done
+}
+
+test_expect_success "setup four branch" '
+	setup_other_branch four one-b a b c &&
+	git checkout master
+'
+
+test_debug 'git show-ref'
+
+del_tmp_branch () {
+	git update-ref -d refs/heads/$TMP_BRANCH
+}
+
+reset () {
+	# First check that tests don't leave a splice in progress,
+	# as they should always do --abort or --continue if necessary
+	test_splice_not_in_progress &&
+	on_branch master &&
+	git reset --hard $latest_tag &&
+	del_tmp_branch &&
+	rm -f stdout stderr
+}
+
+git_splice () {
+	git splice ${debug:+-d} "$@" >stdout 2>stderr
+	ret=$?
+	set +x
+	if [ -s stdout ]
+	then
+		echo "====== STDOUT from git splice $* ======"
+	fi
+	cat stdout
+	if [ -s stderr ]
+	then
+		echo "------ STDERR from git splice $* ------"
+		cat stderr
+	fi
+	echo "====== exit $ret from git splice $* ======"
+	if test -n "$trace"
+	then
+		set -x
+	fi
+	return $ret
+}
+
+test_splice_in_progress () {
+	git splice --in-progress
+}
+
+head_ref () {
+	git symbolic-ref --short -q HEAD
+}
+
+on_branch () {
+	if test "`head_ref`" = "$1"
+	then
+		return 0
+	else
+		echo "not on $1 branch" >&2
+		return 1
+	fi
+}
+
+test_splice_not_in_progress () {
+	test_must_fail test_splice_in_progress &&
+	test_must_fail git_splice --continue &&
+		grep -q "Splice not in progress" stderr &&
+		test_debug 'echo "--continue failed as expected - good"' &&
+	test_must_fail git_splice --abort    &&
+		grep -q "Splice not in progress" stderr &&
+		test_debug 'echo "--abort failed as expected - good"'
+}
+
+#############################################################################
+# Invalid arguments
+
+test_expect_success 'empty command line' '
+	test_must_fail git_splice &&
+	grep "You must specify at least one range to splice" stderr
+'
+
+test_expect_success 'too many arguments' '
+	test_must_fail git_splice a b c &&
+	grep "Use of multiple words in the removal or insertion ranges requires the -- separator" stderr
+'
+
+test_only_one_option () {
+	test_splice_not_in_progress &&
+	test_must_fail git_splice "$@" &&
+	grep "You must only select one of --abort, --continue, and --in-progress" stderr &&
+	test_splice_not_in_progress
+}
+
+for combo in \
+	'--abort --continue' \
+	'--continue --abort' \
+	'--abort --in-progress' \
+	'--in-progress --abort' \
+	'--continue --in-progress' \
+	'--in-progress --continue'
+do
+	test_expect_success "$combo" "
+		test_only_one_option $combo
+	"
+done
+
+test_expect_success 'insertion point without insertion range' '
+	test_must_fail git_splice one &&
+	grep "fatal: one is not a valid removal range" stderr &&
+	test_splice_not_in_progress
+'
+
+test_failed_to_parse_removal_spec () {
+	test_must_fail git_splice "$@" &&
+	grep "fatal: Failed to parse commit range $*" stderr &&
+	test_splice_not_in_progress
+}
+
+test_expect_success 'remove invalid single commit' '
+	test_failed_to_parse_removal_spec five
+'
+
+test_expect_success 'remove range with invalid start' '
+	test_failed_to_parse_removal_spec five..two-b
+'
+
+test_expect_success 'remove range with invalid end' '
+	test_failed_to_parse_removal_spec two-b..five
+'
+
+test_expect_success 'empty removal range' '
+	test_must_fail git_splice two-a..two-a &&
+	grep "^fatal: No commits found in removal range two-a..two-a" stderr &&
+	test_splice_not_in_progress
+'
+
+#############################################################################
+# Invalid initial state
+
+test_expect_success "checkout $TMP_BRANCH; ensure splice won't start" "
+	test_when_finished 'git checkout master; del_tmp_branch' &&
+	reset &&
+	git checkout -b $TMP_BRANCH &&
+	test_must_fail git_splice two-b^! &&
+	grep 'fatal: On $TMP_BRANCH branch, but no splice in progress' stderr &&
+	git checkout master &&
+	del_tmp_branch &&
+	test_splice_not_in_progress
+"
+
+test_expect_success "create $TMP_BRANCH; ensure splice won't start" "
+	test_when_finished 'del_tmp_branch' &&
+	reset &&
+	git branch $TMP_BRANCH master &&
+	test_must_fail git_splice two-b^! &&
+	grep '$TMP_BRANCH branch exists, but no splice in progress' stderr &&
+	del_tmp_branch &&
+	test_splice_not_in_progress
+"
+
+test_expect_success "start cherry-pick with conflicts; ensure splice won't start" '
+	test_when_finished "git cherry-pick --abort" &&
+	reset &&
+	test_must_fail git cherry-pick four-b >stdout 2>stderr &&
+	grep "error: could not apply .* four b" stderr &&
+	test_must_fail git_splice two-b^! &&
+	grep "Can'\''t start git splice when there is a cherry-pick in progress" stderr &&
+	test_splice_not_in_progress
+'
+
+test_expect_success "start rebase with conflicts; ensure splice won't start" '
+	test_when_finished "git rebase --abort" &&
+	reset &&
+	test_must_fail git rebase --onto one-b two-a >stdout 2>stderr &&
+	grep "CONFLICT" stdout &&
+	grep "Failed to merge in the changes" stderr &&
+	test_must_fail git_splice two-b^! &&
+	grep "Can'\''t start git splice when there is a rebase in progress" stderr &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'cause conflict; ensure not re-entrant' '
+	test_when_finished "
+		git_splice --abort &&
+		test_splice_not_in_progress
+	" &&
+	reset &&
+	test_must_fail git_splice two-a^! &&
+	test_splice_in_progress &&
+	test_must_fail git_splice two-a^! &&
+	grep "git splice already in progress; please complete it, or run" stderr &&
+	grep "git splice --abort" stderr &&
+	test_splice_in_progress
+'
+
+#############################################################################
+# Removing a single commit
+
+test_remove_two_b () {
+	reset &&
+	git_splice two-b^! "$@" &&
+	grep "one b"   one   &&
+	grep "three b" three &&
+	grep "two a"   two   &&
+	! grep "two b" two   &&
+	test_splice_not_in_progress
+}
+
+test_expect_success 'remove single commit' '
+	test_remove_two_b
+'
+
+test_expect_success 'remove single commit with --' '
+	test_remove_two_b --
+'
+
+test_expect_success 'remove single commit causing conflict; abort' '
+	reset &&
+	test_must_fail git_splice two-a^! &&
+	grep "Could not apply .* two b" stdout stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stdout stderr &&
+	grep "or run \"git splice --abort\"" stdout stderr &&
+	test_splice_in_progress &&
+	git_splice --abort &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove single commit causing conflict; fix; continue' '
+	reset &&
+	test_must_fail git_splice two-a^! &&
+	grep "Could not apply .* two b" stdout stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stdout stderr &&
+	grep "or run \"git splice --abort\"" stdout stderr &&
+	test_splice_in_progress &&
+	echo two merged >two &&
+	git add two &&
+	git_splice --continue &&
+	grep "two merged" two &&
+	grep "three b" three &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove root commit' '
+	# We have to remove one-b first, in order to avoid conflicts when
+	# we remove one-a.
+	reset &&
+	git_splice one-b^! &&
+	! grep "one b" one &&
+	git_splice --root one-a &&
+	! test -e one &&
+	grep "three b" three &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove root commit causing conflict; abort' '
+	reset &&
+	test_must_fail git_splice --root one-a &&
+	grep "Could not apply .* one b" stdout stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stdout stderr &&
+	grep "or run \"git splice --abort\"" stdout stderr &&
+	test_splice_in_progress &&
+	git_splice --abort &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove root commit causing conflict; fix; continue' '
+	reset &&
+	test_must_fail git_splice --root one-a &&
+	grep "Could not apply .* one b" stdout stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stdout stderr &&
+	grep "or run \"git splice --abort\"" stdout stderr &&
+	test_splice_in_progress &&
+	echo one merged >one &&
+	git add one &&
+	git_splice --continue &&
+	grep "one merged" one &&
+	grep "three b" three &&
+	test_splice_not_in_progress
+'
+
+#############################################################################
+# Removing a range of commits
+
+test_remove_range_of_commits () {
+	reset &&
+	git_splice one-b..two-b "$@" &&
+	grep "one b"   one   &&
+	grep "three b" three &&
+	! test -e two        &&
+	test_splice_not_in_progress
+}
+
+test_expect_success 'remove range of commits' '
+	test_remove_range_of_commits
+'
+
+test_expect_success 'remove range of commits with --' '
+	test_remove_range_of_commits --
+'
+
+test_expect_success 'remove commit from branch tip' '
+	reset &&
+	git_splice HEAD^! &&
+	test `git rev-parse HEAD` = `git rev-parse three-a` &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove commits from branch tip' '
+	reset &&
+	git_splice HEAD~3..HEAD &&
+	test `git rev-parse HEAD` = `git rev-parse two-a` &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove range of commits starting at root' '
+	reset &&
+	git_splice --root one-b &&
+	! test -e one &&
+	grep "three b" three &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove range of commits starting at root' '
+	reset &&
+	git_splice --root one-b -- &&
+	! test -e one &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove range of commits outside branch' '
+	reset &&
+	test_must_fail git_splice four-a..four-c &&
+	grep "^fatal: .* is in removal range but not in master" stderr &&
+	! test -e four &&
+	grep "three b" three &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'dirty working tree prevents removing commit on same file' '
+	reset &&
+	echo dirty >>two &&
+	test_when_finished "
+		git_splice --abort &&
+		test_splice_not_in_progress
+	" &&
+	test_must_fail git_splice two-b^! &&
+	grep "^error: Your local changes to the following files would be overwritten by checkout:" stderr &&
+	grep "^[[:space:]]*two" stderr &&
+	grep "^Please commit your changes or stash them before you switch branches" stderr &&
+	grep dirty two &&
+	test_splice_in_progress
+'
+
+test_expect_success 'dirty working tree prevents removing commit on other file' '
+	reset &&
+	echo dirty >>three &&
+	test_when_finished "
+		git_splice --abort &&
+		test_splice_not_in_progress
+	" &&
+	test_must_fail git_splice two-b^! &&
+	grep "^error: Your local changes to the following files would be overwritten by checkout:" stderr &&
+	grep "^[[:space:]]*three" stderr &&
+	grep "^Please commit your changes or stash them before you switch branches" stderr &&
+	test_splice_in_progress
+'
+
+create_merge_commit () {
+	test_when_finished "git tag -d four-merge" &&
+	reset &&
+	git merge four &&
+	git tag four-merge &&
+	echo "four d" >>four &&
+	git commit -am"four d"
+}
+
+test_expect_success 'abort when trying to remove a merge commit' '
+	create_merge_commit &&
+	test_must_fail git_splice four-merge^! &&
+	grep "^fatal: Removing merge commits is not supported" stderr &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'abort when removal range contains merge commits' '
+	create_merge_commit &&
+	test_must_fail git_splice four-merge^^..HEAD &&
+	grep "^fatal: Removing merge commits is not supported" stderr &&
+	test_splice_not_in_progress
+'
+
+# The foo.. notation doesn't naturally play nice with our implementation,
+# since HEAD gets moved around during the splice.
+test_expect_success 'abort when removal range contains merge commits (2)' '
+	create_merge_commit &&
+	test_must_fail git_splice four-merge^^.. &&
+	grep "^fatal: Removing merge commits is not supported" stderr &&
+	test_splice_not_in_progress
+'
+
+#############################################################################
+# Inserting a single commit
+
+test_expect_success 'insert single commit at HEAD' '
+	reset &&
+	git_splice HEAD four-a^! &&
+	grep "two b" two &&
+	grep "three a" three &&
+	grep "four a" four &&
+	! grep "four b" four &&
+	git log --format=format:%s, | xargs |
+		grep "four a, three b, three a, two b," &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'insert single commit within branch' '
+	reset &&
+	git_splice two-b four-a^! &&
+	grep "two b" two &&
+	grep "three a" three &&
+	grep "four a" four &&
+	! grep "four b" four &&
+	git log --format=format:%s, | xargs |
+		grep "three b, three a, four a, two b," &&
+	test_splice_not_in_progress
+'
+
+create_five_branch () {
+	test_when_finished "
+		git branch -D five &&
+		git tag -d five-{a,b,c,merge}
+	" &&
+	setup_other_branch five one-b a b &&
+	git checkout five &&
+	git merge four-a &&
+	git tag five-merge &&
+	echo "five c" >>five &&
+	git commit -am"five c" &&
+	git tag five-c &&
+	git checkout master
+}
+
+test_expect_success 'abort when appending a single merge commit on HEAD' '
+	reset &&
+	create_five_branch &&
+	test_must_fail git_splice HEAD five-merge^! &&
+	grep "^fatal: Inserting merge commits is not supported" stderr &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'abort when inserting a single merge commit within branch' '
+	reset &&
+	create_five_branch &&
+	test_must_fail git_splice HEAD~2 five-merge^! &&
+	grep "^fatal: Inserting merge commits is not supported" stderr &&
+	test_splice_not_in_progress
+'
+
+#############################################################################
+# Inserting a range of commits
+
+test_expect_success 'insert commit range' '
+	reset &&
+	git_splice two-b one-b..four-b &&
+	grep "two b" two &&
+	grep "three a" three &&
+	grep "four b" four &&
+	git log --format=format:%s, | xargs |
+		grep "three b, three a, four b, four a, two b," &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'insert commit causing conflict; abort' '
+	reset &&
+	test_must_fail git_splice two-b four-b^! &&
+	grep "could not apply .* four b" stderr &&
+	grep "git cherry-pick failed" stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stdout stderr &&
+	grep "or run \"git splice --abort\"" stdout stderr &&
+	test_splice_in_progress &&
+	git_splice --abort &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'insert commit causing conflict; fix; continue' '
+	reset &&
+	test_must_fail git_splice two-b four-b^! &&
+	grep "could not apply .* four b" stderr &&
+	grep "git cherry-pick failed" stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stdout stderr &&
+	grep "or run \"git splice --abort\"" stdout stderr &&
+	test_splice_in_progress &&
+	echo four merged >four &&
+	git add four &&
+	git_splice --continue &&
+	grep "four merged" four &&
+	grep "three b" three &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'abort when appending range includes a merge commit' '
+	reset &&
+	create_five_branch &&
+	test_must_fail git_splice HEAD five-a^..five &&
+	grep "^fatal: Inserting merge commits is not supported" stderr &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'abort when inserting range includes a merge commit' '
+	reset &&
+	create_five_branch &&
+	test_must_fail git_splice HEAD~2 five-a^..five &&
+	grep "^fatal: Inserting merge commits is not supported" stderr &&
+	test_splice_not_in_progress
+'
+
+#############################################################################
+# Removing a range and inserting one or more commits
+
+test_expect_success 'remove range; insert commit' '
+	reset &&
+	git_splice two-a^..two-b four-a^! &&
+	grep "four a" four &&
+	! grep "four b" four &&
+	grep "three b" three &&
+	! test -e two &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove range; insert commit range' '
+	reset &&
+	git_splice two-a^..two-b four-a^..four-b &&
+	grep "four b" four &&
+	! grep "four c" four &&
+	grep "three b" three &&
+	! test -e two &&
+	test_splice_not_in_progress
+'
+
+test_expect_success 'remove range; insert commit causing conflict; abort' '
+	reset &&
+	test_must_fail git_splice two-a^..two-b four-b^! &&
+	grep "could not apply .* four b" stderr &&
+	grep "git cherry-pick failed" stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stderr &&
+	grep "or run \"git splice --abort\" to abandon the splice" stderr &&
+	test_splice_in_progress &&
+	git_splice --abort &&
+	test_splice_not_in_progress
+'
+
+test_remove_range_insert_commit_fix_conflict_continue () {
+	reset &&
+	test_must_fail git_splice two-a^..two-b "$@" four-b^! &&
+	grep "could not apply .* four b" stderr &&
+	grep "git cherry-pick failed" stderr &&
+	grep "When you have resolved this problem, run \"git splice --continue\"" stdout stderr &&
+	grep "or run \"git splice --abort\"" stdout stderr &&
+	test_splice_in_progress &&
+	echo four merged >four &&
+	git add four &&
+	git_splice --continue &&
+	grep "four merged" four &&
+	grep "three b" three &&
+	! test -e two &&
+	test_splice_not_in_progress
+}
+
+test_expect_success 'remove range; insert commit causing conflict; fix; continue' '
+	test_remove_range_insert_commit_fix_conflict_continue
+'
+
+test_expect_success 'remove range -- insert commit causing conflict; fix; continue' '
+	test_remove_range_insert_commit_fix_conflict_continue --
+'
+
+test_expect_success 'remove grepped commits; insert grepped commits' '
+	reset &&
+	git_splice --grep=two -n1 three-b -- --grep=four --skip=1 four &&
+	grep "two a" two &&
+	! grep "two b" two &&
+	grep "four b" four &&
+	! grep "four c" four &&
+	grep "three b" three &&
+	test_splice_not_in_progress
+'
+
+test_done
-- 
git-series 0.9.1

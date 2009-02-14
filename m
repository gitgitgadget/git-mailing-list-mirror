From: Eric Kidd <git@randomhacks.net>
Subject: [RFC/PATCHv2] git submodule split
Date: Fri, 13 Feb 2009 21:24:18 -0500
Message-ID: <1234578258-48870-1-git-send-email-git@randomhacks.net>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
Cc: Eric Kidd <git@randomhacks.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 03:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYAEH-0007GI-CP
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZBNCYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbZBNCY3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:24:29 -0500
Received: from randomhacks.net ([69.93.127.95]:34323 "EHLO randomhacks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbZBNCY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:24:28 -0500
Received: from pool-64-222-85-242.burl.east.myfairpoint.net ([64.222.85.242] helo=localhost.localdomain)
	by randomhacks.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <git@randomhacks.net>)
	id 1LYACf-0000UG-Cr; Fri, 13 Feb 2009 21:24:26 -0500
X-Mailer: git-send-email 1.6.2.rc0.59.g5c88.dirty
In-Reply-To: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109805>

Proposed usage:
    git submodule split [--url submodule_repo_url] submodule_dir \
        [alternate_dir...]

Replace submodule_dir with a newly-created submodule, keeping all the
history of submodule_dir.  This command also rewrites each commit in the
current repository's history to include the correct revision of
sumodule_dir and the appropriate .gitmodules entries.

If the submodule has moved around the source tree, specify one or more
values for alternate_dir.  To specify the URL of the newly created
repository (for use in .gitmodules), use the --url parameter.

Johannes Schindelin provided extensive help with the UI and
implementation of this command (but has not yet reviewed the code).

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

---
Open questions:

  1) Right now, this command is actually git-submodule-split.sh.  Should
     I include this code directly into git-submodule.sh, or move it
     to git-submodule--split.sh and hook it into git-submodule.sh?

  2) Should I implement a --force flag based on filter-branch?  Johannes
     Schindelin has suggested that it might be better to remove the
     --force flag from filter-branch and just rely on the reflog to keep
     backups.

  3) It would be useful to have a version of this command which didn't
     rewrite the super-project's history.  In fact, the non-rewriting
     version should probably be the default, and the current behavior
     should probably be selected using --rewrite.  Thoughts?

  4) We're obviously going to need to support revision arguments other
     than --all (which is what we currently pass to filter-branch).  Should
     we default to the current branch only, or to --all?

Design Q&A (this appeared in an earlier e-mail)

  Q. Why not merge 'submodule split' into the existing 'filter-branch'
  loop?

  A. Internally, 'submodule split' needs to make two separate passes
  with 'filter-branch': One to create the new submodule, and one to
  update the parent. If I were to merge 'submodule split' into the
  existing filter-branch loop, filter-branch would need to keep track of
  two repositories. Writing 'submodule split' as a wrapper around
  filter-branch helps keep filter-branch simple.

  Q. Why only process one submodule at time?

  A. If there were multiple submodules, each with several different
  historical locations, the data structures in sh would get too tricky
  for me to implement well. But I'm happy to take patches and UI
  suggestions.

  Q. Why operate on the current directory, and why output the new
  submodule in place?

  A. An earlier version of 'submodule split' took the arguments
  'src-repo dst-repo sub-repo sub-repo-dir...'. This required the user
  to do more typing, and it didn't feel very "git like". Johannes
  Schindelin suggested the current interface. The new interface feels
  more natural to me, and it's certainly easier to use in the common
  cases.

 .gitignore                 |    1 +
 Makefile                   |    1 +
 git-submodule-split.sh     |  190 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7404-submodule-split.sh |  135 +++++++++++++++++++++++++++++++
 4 files changed, 327 insertions(+), 0 deletions(-)
 create mode 100644 git-submodule-split.sh
 create mode 100755 t/t7404-submodule-split.sh

diff --git a/.gitignore b/.gitignore
index 1c57d4c..603ad7a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
+git-submodule-split
 git-stage
 git-stash
 git-status
diff --git a/Makefile b/Makefile
index b040a96..96274f1 100644
--- a/Makefile
+++ b/Makefile
@@ -276,6 +276,7 @@ SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
+SCRIPT_SH += git-submodule-split.sh
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
diff --git a/git-submodule-split.sh b/git-submodule-split.sh
new file mode 100644
index 0000000..4582d2a
--- /dev/null
+++ b/git-submodule-split.sh
@@ -0,0 +1,190 @@
+#!/bin/sh
+# 
+# Split a repository into a submodule and main module, with history
+#
+# Copyright 2009 Trustees of Dartmouth College
+# License: GNU General Public License, version 2 or later
+
+USAGE="[--url submodule_repo_url] submodule_dir [alternate_dir...]"
+
+OPTIONS_SPEC=
+. git-sh-setup
+require_work_tree
+
+# Set up our temporary directory.  We export these variables because we
+# want to use them from scripts passed to 'git filter-branch'.  We can't
+# simply substitute these variable values into the text of the scripts we
+# pass to 'git filter-branch', because the filenames may contain spaces,
+# which would get mangled.  Thanks to Johannes Schindelin for this idea.
+export GIT_SPLIT_TEMP_DIR="$GIT_DIR/.git_split"
+export GIT_SPLIT_MAP_DIR="$GIT_SPLIT_TEMP_DIR/map"
+rm -rf "$GIT_SPLIT_TEMP_DIR" &&
+mkdir -p "$GIT_SPLIT_MAP_DIR" || exit
+
+# Parse our command-line arguments.
+mkdir "$GIT_SPLIT_TEMP_DIR/dirs" || exit
+dir_count=0
+while test $# -ne 0; do
+	case "$1" in
+	--)
+		shift
+		break
+		;;
+	--url)
+                shift
+                test $# -ne 0 || die "Must supply argument to --url"
+		sub_url="$1"
+		shift
+		;;
+        -*)
+		die "Unknown option: $1"
+		;;
+	*)
+		# Use the first specified directory as the subrepository
+		# name.
+		if test "$dir_count" -eq 0; then
+			sub_path="$1"
+		fi
+
+		# There's no good way to pass an array of filenames
+		# containing spaces to our subprocesses, so let's cheat
+		# shamelessly and create an "array" of files on disk.
+		printf '%s' "$1" > "$GIT_SPLIT_TEMP_DIR/dirs/$dir_count"
+		dir_count=$(($dir_count + 1))
+                shift
+		;;
+	esac
+done
+
+# We should have at least one directory listed on the command line.
+test "$dir_count" -ge 1 || usage
+
+# Default the repository URL to something based on the repository path.
+if test -z "$sub_url"; then
+	sub_url="../$sub_path"
+fi
+
+# TODO: Pass remaining arguments to rev-parse, defaulting to --all.
+revs="--all"
+
+# More variables for our subprocesses.
+export GIT_SPLIT_DIR_COUNT="$dir_count"
+export GIT_SPLIT_SUB_PATH="$sub_path"
+export GIT_SPLIT_SUB_URL="$sub_url"
+
+# Make sure our environment is sane.
+test "$(is_bare_repository)" = false ||
+	die "Cannot run submodule split in a bare repository"
+git diff-files --ignore-submodules --quiet &&
+	git diff-index --cached --quiet HEAD -- ||
+	die "Cannot split out a submodule with a dirty working directory."
+(cd "$sub_path" &&
+	test "$GIT_DIR" = "$(git rev-parse --git-dir)" ||
+	die "$sub_path is already in a submodule")
+
+
+
+#--------------------------------------------------------------------------
+# Create the new submodule
+
+# Create a new repository at the last known address of our submodule.  We
+# initially share our objects with our parent repository.
+src_repo="$(pwd)"
+sub_repo_temp="$GIT_SPLIT_TEMP_DIR/s" && mkdir "$sub_repo_temp" &&
+(cd "$sub_repo_temp" &&
+	git init &&
+	git remote add origin --mirror "$src_repo" &&
+	echo "$src_repo/.git/objects" > .git/objects/info/alternates &&
+	git fetch --update-head-ok &&
+	git remote rm origin &&
+	git read-tree -u -m HEAD) || exit
+
+index_filter=$(cat << \EOF
+map_info="$GIT_SPLIT_MAP_DIR/$GIT_COMMIT"
+
+# Check for the submodule in all possible locations.
+i=0
+while test "$i" -lt "$GIT_SPLIT_DIR_COUNT"; do
+	candidate="$(cat "$GIT_SPLIT_TEMP_DIR/dirs/$i")" || exit
+	if git rev-parse -q --verify "$GIT_COMMIT:$candidate"; then
+		# Borrowed from git filter-branch.
+		err="$(git read-tree -i -m "$GIT_COMMIT:$candidate" 2>&1)" ||
+			die "$err"
+	        printf '%s' "$candidate" > "$map_info-dir"
+		break
+	fi
+	i=$(($i + 1))
+done
+EOF
+)
+
+commit_filter=$(cat << \EOF
+map_info="$GIT_SPLIT_MAP_DIR/$GIT_COMMIT"
+if test -f "$map_info-dir"; then
+	new_commit="$(git_commit_non_empty_tree "$@")" || exit
+	echo "$new_commit"
+	echo "$new_commit" > "$map_info-submodule-commit" ||
+		die "Can't record the commit ID of the new commit"
+else
+	skip_commit "$@"
+fi
+EOF
+)
+
+# Run our filters, repack the results as a standalone repository with no
+# extra history, and check out HEAD.
+(cd "$sub_repo_temp" &&
+	git filter-branch --index-filter "$index_filter" \
+		--commit-filter "$commit_filter" -- "$revs" &&
+	rm -rf .git/refs/original &&
+	git reflog expire --expire="now" --all &&
+	git repack -a -d &&
+	rm .git/objects/info/alternates) || exit
+
+#--------------------------------------------------------------------------
+# Create the new superproject
+
+index_filter=$(cat << \EOF
+map_info="$GIT_SPLIT_MAP_DIR/$GIT_COMMIT"
+
+# Only update the index if the submodule is present in this revision.
+if test -f "$map_info-dir"; then
+	dir="$(cat "$map_info-dir")" || exit
+
+	# Splice the repo into the tree.
+	test -f "$map_info-submodule-commit" ||
+		die "Can't find map for $GIT_COMMIT"
+	git rm -q --cached -r "$dir" || exit
+	subcommit="$(cat "$map_info-submodule-commit")" || exit
+	echo "160000 $subcommit	$dir" |
+		git update-index --index-info || exit
+
+	# Either update the old .gitmodules file, or make a new one.
+	gitmodules="$GIT_SPLIT_TEMP_DIR/gitmodules"
+	if git rev-parse -q --verify "$GIT_COMMIT:.gitmodules"; then
+		git cat-file blob "$GIT_COMMIT:.gitmodules" > "$gitmodules" ||
+			exit
+	fi
+	subsection=submodule."$GIT_SPLIT_SUB_PATH"
+	git config -f "$gitmodules" "$subsection".path "$dir"
+	git config -f "$gitmodules" "$subsection".url "$GIT_SPLIT_SUB_URL"
+
+	# Write the new .gitmodules file into the tree.
+	new_obj="$(git hash-object -t blob -w "$gitmodules")" ||
+		die "Error adding new .gitmodules file to tree"
+	git update-index --add --cacheinfo 100644 "$new_obj" .gitmodules || exit
+fi
+EOF
+)
+
+# Run our filter.
+git filter-branch --index-filter "$index_filter" -- "$revs" || exit
+
+# Move our submodule into place.  This has to wait until last, because
+# we want to keep the tree clean until after the final git filter, and we
+# need to have a place to put the new submodule.
+rmdir "$sub_path"
+test -d "$sub_path" && die "submodule $sub_path was not actually deleted"
+mv "$sub_repo_temp" "$sub_path" || exit
+
+exit 0
diff --git a/t/t7404-submodule-split.sh b/t/t7404-submodule-split.sh
new file mode 100755
index 0000000..ecc167e
--- /dev/null
+++ b/t/t7404-submodule-split.sh
@@ -0,0 +1,135 @@
+#!/bin/sh
+#
+# Copyright 2009 Trustees of Dartmouth College
+
+test_description='git submodule split tests'
+. ./test-lib.sh
+
+# We use two main repositories: An "original" repository, which remains
+# unmodified, and a "working" repository, which we transform repeatedly.
+rm -rf .git
+test_create_repo original
+
+test_expect_success 'create original repository' '
+	(cd original &&
+		echo "In main project" > main-file &&
+		mkdir sub1 &&
+		echo "In sub1" > sub1/sub1-file &&
+		git add . &&
+		git commit -m "Original project and sub1" &&
+		git tag c1 &&
+        	mkdir -p nested/sub2 &&
+	  	echo "In sub2" > nested/sub2/sub2-file &&
+		git add . &&
+		git commit -m "Add sub2" &&
+		git tag c2 &&
+		git rm -r nested &&
+		git commit -m "Removing nested temporarily" &&
+		git tag c3 &&
+		git checkout c2 -- nested &&
+		git add . &&
+		git commit -m "Putting nested back" &&
+		git tag c4 &&
+		git mv nested/sub2 other-sub2 &&
+		echo "Changed file" >> other-sub2/sub2-file &&
+		git add . &&
+		git commit -m "Moving sub2 and changing a file" &&
+		git tag c5 &&
+		git mv other-sub2 nested/sub2 &&
+		git commit -m "Moving sub2 back" &&
+		git tag c6
+	)
+'
+
+test_expect_success 'make a working repository' '
+	abs_src_path="$(pwd)/original" && mkdir working &&
+	(cd working &&
+		git init &&
+		git remote add origin --mirror "$abs_src_path" &&
+		git fetch --update-head-ok &&
+		git remote rm origin &&
+		git read-tree -u -m HEAD)
+'
+
+test_expect_success 'split out sub1' '
+	(cd working &&
+		git submodule-split --url ../sub1-repo sub1 &&
+		test -f main-file &&
+		test -d sub1/.git &&
+		test_must_fail git rev-parse -q --verify HEAD:sub1/sub1-file &&
+		(cd sub1 && git rev-parse -q --verify HEAD:sub1-file)
+	)
+'
+
+test_expect_success 'split out sub2' '
+	(cd working &&
+		rm -rf .git/refs/original &&
+		git submodule-split nested/sub2 other-sub2 &&
+		test -d nested/sub2/.git &&
+		test_must_fail git rev-parse -q --verify \
+			HEAD:nested/sub2/sub2-file &&
+		test_must_fail git rev-parse -q --verify \
+			c5:other-sub2/sub2-file &&
+		(cd nested/sub2 &&
+			git rev-parse -q --verify HEAD:sub2-file &&
+			git rev-parse -q --verify c5:sub2-file)
+	)
+'
+
+submodule_path() {
+	git config -f .gitmodules submodule."$1".path
+}
+
+submodule_url() {
+	git config -f .gitmodules submodule."$1".url
+}
+
+test_expect_success 'make sure .gitmodules knows about both submodules' '
+	(cd working &&
+		test "$(submodule_path sub1)" = sub1 &&
+		test "$(submodule_url  sub1)" = ../sub1-repo &&
+		test "$(submodule_path nested/sub2)" = nested/sub2 &&
+		test "$(submodule_url  nested/sub2)" = ../nested/sub2
+	)
+'
+
+test_expect_success 'compare each commit in split repository with original' '
+	rm -rf working/.git/refs/original &&
+	module_base="$(pwd)/original" &&
+	(cd working && git config remote.origin.url "$module_base") &&
+	mv working/sub1 sub1-repo &&
+	mkdir nested && mv working/nested/sub2 nested &&
+	original_revs="$(cd original && git rev-parse --all)" &&
+	working_revs="$(cd working && git rev-parse --all)" &&
+	while test -n "$original_revs"; do
+		original_commit="$(echo "$original_revs" | head -n 1)" &&
+		working_commit="$(echo "$working_revs" | head -n 1)" &&
+		original_revs="$(echo "$original_revs" | tail -n +2)" &&
+		working_revs="$(echo "$working_revs" | tail -n +2)" &&
+		(cd original && git checkout -f "$original_commit") &&
+		(cd working && git checkout -f "$working_commit" &&
+			git clean -fd &&
+			git submodule update --init) &&
+		diff -Nr -x .git -x .gitmodules original working ||
+			exit
+	done
+'
+
+test_expect_success 'verify that empty commits are skipped' '
+	(cd working/sub1 &&
+		test "$(git rev-parse c1)" = "$(git rev-parse c2)"
+	)
+'
+
+# Note that we should probably also drop the c3 tag here, because sub2
+# temporarily disappeared from the tree during that commit, but doing so
+# will require more work.  For now, we map c3 back to the last known state
+# of the directory when it was actually in-tree.
+test_expect_success 'verify that directories missing from rev are skipped' '
+	(cd working/nested/sub2 &&
+		test_must_fail git rev-parse -q --verify c1 &&
+		test "$(git rev-parse c2)" = "$(git rev-parse c4)"
+	)
+'
+
+test_done
-- 
1.6.2.rc0.59.g5c88.dirty

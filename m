From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] contrib: add a 'git difftool' command for driving common merge tools
Date: Tue, 16 Sep 2008 00:57:33 -0700
Message-ID: <6385cbdec792ad2cd932dba38d68e2542efa5827.1221551358.git.davvid@gmail.com>
Cc: git@vger.kernel.org, tytso@mit.edu
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 16 10:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVYu-0002EM-1j
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 10:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbYIPIER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 04:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbYIPIER
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 04:04:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:14825 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbYIPIEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 04:04:12 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2569105rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GI04hyWu2dAEQBG6OIRzjo2twKm600CphtuBTXGyJf4=;
        b=od8aUCTkf+6QnlpI8MoRhr7iUwCPpVPkrxVxBipHyAk9+KkoEw8INeMGiPhjqHSE4N
         IAa6m9YrMPTcjZGMeMedxmNPjtaMsxNV8RcoooEGzX4chuIF2Lhn99KtYs2RgmskQ9Af
         wIZEjg7pd4pDPl3CRXUpIkJ85L4CgK3TJ/8W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VPcyParEr4YmwQO6MLYq+ZTq/SLCk+ZvIR5fIIkKZEVRxQ6g8PYbHL8JayOVWo89fJ
         CC6z7cRk1pe1F+Rwim4RIuL6o/QN8EoyPJdQ640QXcjoOMrLABvhS+mfXDMtHPknaa5S
         jOF2w7zR6R4lxcPzkCEaPqFuotoPIUMQ+D/Yw=
Received: by 10.141.86.14 with SMTP id o14mr5434547rvl.227.1221552251624;
        Tue, 16 Sep 2008 01:04:11 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id g31sm24710623rvb.7.2008.09.16.01.04.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 01:04:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95988>

'git-difftool' is a git command that allows you to compare and edit files
between revisions using standard git merge tools.  At its most basic level,
'git-difftool' does what 'git-mergetool' does but its use is for non-merge
situations, such as when preparing commits or comparing changes against
the index.  It uses the same configuration variables as git-mergetool,
so it automagically supports existing custom merge tool configurations.

'git-difftool' shows differences between the work tree and the index by
default but can also show differences between arbitrary commits by using
the --start and --end options.  When operating on the index, saving the
merged file from within the merge tool (and a successful exit code) will
instruct 'git-difftool' to stage the new content for commit.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

git-difftool was adapted from git-mergetool, so there's some common code.
If people like this enough to move it out of contrib then I'll happily help
factor out the similarities.

Every CVS user I've met has asked for the functionality provided by this
command in one form or another.  For some reason they just can't let go of
their side-by-side diff viewer.

 contrib/difftool/git-difftool.sh  |  538 +++++++++++++++++++++++++++++++++++++
 contrib/difftool/git-difftool.txt |  130 +++++++++
 2 files changed, 668 insertions(+), 0 deletions(-)

diff --git a/contrib/difftool/git-difftool.sh b/contrib/difftool/git-difftool.sh
new file mode 100755
index 0000000..bafd650
--- /dev/null
+++ b/contrib/difftool/git-difftool.sh
@@ -0,0 +1,538 @@
+#!/bin/sh
+#
+# This program uses merge tools to stage and compare commits
+#
+# Copyright (c) 2008 David Aguilar
+#
+# Adapted from git-mergetool.sh
+# Copyright (c) 2006 Theodore Y. Ts'o
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Junio C Hamano.
+#
+USAGE='[--tool=tool] [--commit=ref] [--start=ref --end=ref] [--no-prompt] [file to merge] ...'
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+. git-sh-setup
+require_work_tree
+cd_to_toplevel
+dirname=
+keep_backup_mode="$(git config --bool mergetool.keepBackup || echo true)"
+
+keep_backup () {
+	test "$keep_backup_mode" = "true"
+}
+
+parse_arg () {
+	expr "z$1" : 'z-[^=]*=\(.*\)'
+}
+
+index_present () {
+    test -n "$index_mode"
+}
+
+modified_present () {
+    test -n "$modified_mode"
+}
+
+commitish_present () {
+	test -n "$commitish"
+}
+
+should_prompt () {
+	! test -n "$no_prompt"
+}
+
+use_rev_range () {
+	test -n "$start" && test -n "$end"
+}
+
+handle_dir () {
+	test -n "$non_existant_dir"
+}
+
+merge_three () {
+	index_present && modified_present && ! use_rev_range
+}
+
+modified_files () {
+	if use_rev_range; then
+		git diff --name-only "$start".."$end" -- "$@" 2>/dev/null
+	elif commitish_present; then
+		git diff --name-only "$commitish" -- "$@" 2>/dev/null
+	else
+		git diff --name-only -- "$@" 2>/dev/null
+	fi
+}
+
+staged_files() {
+	git diff --name-only --cached "$@" 2>/dev/null
+}
+
+cleanup_temp_files () {
+	if keep_backup && test "$MERGED" -nt "$BACKUP"; then
+		test -f "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE"
+	else
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
+	fi
+	handle_dir && rmdir -p "$dirname"
+}
+
+check_unchanged () {
+	if test "$MERGED" -nt "$BACKUP"; then
+		status=0
+	else
+		status=1
+		use_rev_range && status=0 # we don't 'git add' in rev-range mode
+		if ! use_rev_range && should_prompt; then
+			while true
+			do
+				printf "\n$MERGED seems unchanged.\n"
+				printf "Was the merge successful? [y/n] "
+				read answer < /dev/tty
+				case "$answer" in
+				y*|Y*) status=0; break ;;
+				n*|N*) status=1; break ;;
+				esac
+			done
+		fi
+	fi
+}
+
+merge_file ()
+{
+	MERGED="$1"
+
+	modified_mode=$(modified_files "$MERGED")
+	index_mode=$(staged_files "$MERGED")
+
+	if ! modified_present && use_rev_range; then
+		echo "$MERGED: no changes between '$start' and '$end'."
+		exit 1
+	elif ! modified_present && ! index_present; then
+		if ! test -f "$MERGED"; then
+			echo $(pwd)
+			echo "$MERGED: file not found"
+		else
+			echo "$MERGED: file is unchanged."
+		fi
+		exit 1
+	fi
+
+	dirname=$(dirname "$MERGED")
+	test -d "$dirname" || non_existant_dir=true
+	handle_dir && mkdir -p "$dirname"
+
+	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
+	BACKUP="./$MERGED.BACKUP.$ext"
+
+	test -f "$MERGED" &&
+	mv -- "$MERGED" "$BACKUP" &&
+	cp -- "$BACKUP" "$MERGED"
+
+	if use_rev_range; then
+		BASE="./$MERGED.LOCAL.$ext"
+		LOCAL="./$MERGED.START.$ext"
+		REMOTE="./$MERGED.END.$ext"
+		base=local
+		local=start
+		remote=end
+
+		if ! git show "$start":"$MERGED" > "$LOCAL" 2>/dev/null; then
+			cleanup_temp_files;
+			if ! should_prompt; then
+				echo "$MERGED does not exist at $start"
+				exit 1
+			fi
+			return
+		fi
+		if ! git show "$end":"$MERGED" > "$REMOTE" 2>/dev/null; then
+			cleanup_temp_files;
+			if ! should_prompt; then
+				echo "$MERGED does not exist at $end"
+				exit 1
+			fi
+			return
+		fi
+
+		# $BASE could be used by custom mergetool commands, so provide it.
+		# $MERGED might not exist in the worktree, start or end so commit
+		# so check in that order.
+		if test -f "$MERGED"; then
+			cp -- "$MERGED" "$BASE"
+		elif test -f "$REMOTE"; then
+			cp -- "$REMOTE" "$BASE"
+		elif test -f "$LOCAL"; then
+			cp -- "$LOCAL" "$BASE"
+		else
+			touch "$BASE"
+		fi
+	else
+		base=index
+		local=local
+		remote=${commitish-HEAD}
+		LOCAL="./$MERGED.LOCAL.$ext"
+		REMOTE="./$MERGED.HEAD.$ext"
+		BASE="./$MERGED.INDEX.$ext"
+		cp -- "$MERGED" "$LOCAL"
+		git show "$remote":"$MERGED" > "$REMOTE" 2>&1
+		# If changes are present in the index use them as $BASE
+		git checkout-index --prefix=.index- "$MERGED"
+		mv -- .index-"$MERGED" "$BASE"
+	fi
+
+	if should_prompt; then
+		printf "\nEditing '$MERGED':\n"
+		printf "Hit return to start merge tool (%s): " "$merge_tool"
+		read ans
+	fi
+
+	case "$merge_tool" in
+	kdiff3)
+		basename=$(basename "$MERGED")
+		if merge_three; then
+		(
+			"$merge_tool_path" --auto \
+				--L1 "[$base] $basename" \
+				--L2 "[$local] $basename" \
+				--L3 "[$remote] $basename" \
+				-o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1
+		)
+		else
+		(
+			"$merge_tool_path" --auto \
+				--L1 "[$local] $basename" \
+				--L2 "[$remote] $basename" \
+				-o "$MERGED" "$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1
+		)
+		fi
+		status=$?
+		;;
+
+	tkdiff)
+		if merge_three; then
+			"$merge_tool_path" \
+				-a "$BASE" \
+				-o "$MERGED" "$LOCAL" "$REMOTE"
+		else
+			"$merge_tool_path" \
+				-o "$MERGED" "$LOCAL" "$REMOTE"
+		fi
+		status=$?
+		;;
+
+	meld|vimdiff)
+		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		check_unchanged
+		;;
+
+	gvimdiff)
+		"$merge_tool_path" -f "$LOCAL" "$MERGED" "$REMOTE"
+		check_unchanged
+		;;
+
+	xxdiff)
+		if merge_three; then
+			"$merge_tool_path" -X --show-merged-pane \
+				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				--merged-file "$MERGED" \
+				"$LOCAL" "$BASE" "$REMOTE"
+		else
+			"$merge_tool_path" -X --show-merged-pane \
+				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				--merged-file "$MERGED" \
+				"$LOCAL" "$REMOTE"
+		fi
+		check_unchanged
+		;;
+
+	opendiff)
+		if merge_three; then
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				-ancestor "$BASE" \
+				-merge "$MERGED" | cat
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				-merge "$MERGED" | cat
+		fi
+		check_unchanged
+		;;
+
+	ecmerge)
+		if merge_three; then
+			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+				--default --mode=merge3 --to="$MERGED"
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				--default --mode=merge2 --to="$MERGED"
+		fi
+		check_unchanged
+		;;
+
+	emerge)
+		if merge_three; then
+			"$merge_tool_path" \
+				-f emerge-files-with-ancestor-command \
+				"$LOCAL" "$REMOTE" "$BASE" \
+				"$(basename "$MERGED")"
+		else
+			"$merge_tool_path" -f emerge-files-command \
+				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
+		fi
+		status=$?
+		;;
+	*)
+		if test -n "$merge_tool_cmd"; then
+			if test "$merge_tool_trust_exit_code" = "false"; then
+				( eval $merge_tool_cmd )
+				check_unchanged
+			else
+				( eval $merge_tool_cmd )
+				status=$?
+			fi
+		fi
+		;;
+	esac
+
+	if ! use_rev_range; then
+		if test "$status" -ne 0; then
+			if should_prompt; then
+				echo "merge of $MERGED failed" 1>&2
+			fi
+			cleanup_temp_files
+			exit 1
+		fi
+		git add -- "$MERGED"
+	fi
+	cleanup_temp_files
+}
+
+while test $# != 0
+do
+	case "$1" in
+	-t|--tool*)
+		case "$#,$1" in
+		*,*=*)
+			merge_tool=$(parse_arg "$1")
+			shift
+			;;
+		1,*)
+			usage
+			;;
+		*)
+			shift
+			merge_tool="$1"
+			shift
+			;;
+		esac
+		;;
+	-c|--commit*)
+		case "$#,$1" in
+		*,*=*)
+			commitish=$(parse_arg "$1")
+			shift
+			;;
+		1,*)
+			usage
+			;;
+		*)
+			shift
+			commitish="$1"
+			shift
+			;;
+		esac
+		;;
+	-s|--start*)
+		case "$#,$1" in
+		*,*=*)
+			start=$(parse_arg "$1")
+			shift
+			;;
+		1,*)
+			usage
+			;;
+		*)
+			shift
+			start="$1"
+			shift
+			;;
+		esac
+		;;
+	-e|--end*)
+		case "$#,$1" in
+		*,*=*)
+			end=$(parse_arg "$1")
+			shift
+			;;
+		1,*)
+			usage
+			;;
+		*)
+			shift
+			end="$1"
+			shift
+			;;
+		esac
+		;;
+	--no-prompt)
+		no_prompt=true
+		shift
+		;;
+	--)
+		shift
+		break
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+done
+
+valid_custom_tool()
+{
+    merge_tool_cmd="$(git config mergetool.$1.cmd)"
+    test -n "$merge_tool_cmd"
+}
+
+valid_tool()
+{
+	case "$1" in
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+		;; # happy
+	*)
+		if ! valid_custom_tool "$1"
+		then
+			return 1
+		fi
+		;;
+	esac
+}
+
+init_merge_tool_path()
+{
+	merge_tool_path=$(git config mergetool."$1".path)
+	if test -z "$merge_tool_path"; then
+		case "$1" in
+		emerge)
+			merge_tool_path=emacs
+			;;
+		*)
+			merge_tool_path="$1"
+			;;
+		esac
+	fi
+}
+
+
+if test -z "$merge_tool"; then
+	merge_tool=$(git config merge.tool)
+	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
+		echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
+		echo >&2 "Resetting to default..."
+		unset merge_tool
+	fi
+fi
+
+if test -z "$merge_tool"; then
+	if test -n "$DISPLAY"; then
+		merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
+		if test -n "$GNOME_DESKTOP_SESSION_ID"; then
+			merge_tool_candidates="meld $merge_tool_candidates"
+		fi
+		if test "$KDE_FULL_SESSION" = "true"; then
+			merge_tool_candidates="kdiff3 $merge_tool_candidates"
+		fi
+	fi
+
+	if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
+		merge_tool_candidates="$merge_tool_candidates emerge"
+	fi
+
+	if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
+		merge_tool_candidates="$merge_tool_candidates vimdiff"
+	fi
+
+	merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
+	echo "merge tool candidates: $merge_tool_candidates"
+
+	for i in $merge_tool_candidates
+	do
+		init_merge_tool_path $i
+		if type "$merge_tool_path" > /dev/null 2>&1; then
+			merge_tool=$i
+			break
+		fi
+	done
+
+	if test -z "$merge_tool" ; then
+		echo "No known merge resolution program available."
+		exit 1
+	fi
+
+else
+	if ! valid_tool "$merge_tool"; then
+		echo >&2 "Unknown merge tool $merge_tool"
+		exit 1
+	fi
+
+	init_merge_tool_path "$merge_tool"
+
+	if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
+		echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
+		exit 1
+	fi
+
+	if ! test -z "$merge_tool_cmd"; then
+		merge_tool_trust_exit_code="$(git config --bool mergetool.$merge_tool.trustExitCode || echo false)"
+	fi
+fi
+
+
+if test $# -eq 0; then
+	use_index=0
+	files=$(modified_files)
+
+	if test -z "$files"; then
+		use_index=1
+		files=$(staged_files)
+	fi
+
+	if test -z "$files"; then
+		echo "No modified files exist."
+		exit 0
+	fi
+
+	if test $use_index -eq 0; then
+		modified_files |
+		while IFS= read i
+		do
+			merge_file "$i" < /dev/tty > /dev/tty
+		done
+	elif ! use_rev_range; then
+		staged_files |
+		while IFS= read i
+		do
+			merge_file "$i" < /dev/tty > /dev/tty
+		done
+	else
+		echo "Nothing to compare."
+		exit 0
+	fi
+else
+	while test $# -gt 0
+	do
+		merge_file "$1"
+		shift
+	done
+fi
+exit $status
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
new file mode 100644
index 0000000..ddc090d
--- /dev/null
+++ b/contrib/difftool/git-difftool.txt
@@ -0,0 +1,130 @@
+git-difftool(1)
+===============
+
+NAME
+----
+git-difftool - stage and compare changes using git merge tools
+
+SYNOPSIS
+--------
+'git difftool' [--tool=<tool>]
+               [--commit=<ref> | --start=<ref> --end=<ref>]
+               [--no-prompt]
+               [--] [<file>]...
+
+DESCRIPTION
+-----------
+'git-difftool' is a git command that allows you to compare and edit files
+between revisions using standard git merge tools.  At its most basic level,
+'git-difftool' does what 'git-mergetool' does but its use is for non-merge
+situations, such as when preparing commits or comparing changes against
+the index.
+
+'git-difftool' shows differences between the work tree and the index by
+default but can also show differences between arbitrary commits by using
+the --start and --end options.  When operating on the index, saving the
+merged file from within the merge tool (and a successful exit code) will
+instruct 'git-difftool' to stage the new content for commit.
+
+OPTIONS
+-------
+
+-t or --tool=<tool>::
+	Use the merge resolution program specified by <tool>.
+	Valid merge tools are:
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
++
+If a merge resolution program is not specified, 'git-difftool'
+will use the configuration variable `merge.tool`.  If the
+configuration variable `merge.tool` is not set, 'git-difftool'
+will pick a suitable default.
++
+You can explicitly provide a full path to the tool by setting the
+configuration variable `mergetool.<tool>.path`. For example, you
+can configure the absolute path to kdiff3 by setting
+`mergetool.kdiff3.path`. Otherwise, 'git-difftool' assumes the
+tool is available in PATH.
++
+Instead of running one of the known merge tool programs,
+'git-difftool' can be customized to run an alternative program
+by specifying the command line to invoke in a configuration
+variable `mergetool.<tool>.cmd`.
++
+When 'git-difftool' is invoked with this tool (either through the
+`-t` or `--tool` option or the `merge.tool` configuration variable)
+the configured command line will be invoked with the following
+variables available: `$BASE` is set to the name of a temporary file
+containing the contents of the index; `$LOCAL` set to the name of a
+temporary file containing the contents of the file as it appears in
+the work tree; `$REMOTE` set to the name of a temporary file
+containing the contents of the file to be merged, and `$MERGED` set
+to the name of the file to which the merge tool should write the
+result of the merge resolution.
++
+When `--start=<ref>` and `--end=<ref>` are specified
+`$LOCAL` contains the contents of the file from the
+starting revision and `$REMOTE` contains the contents
+of the file in the ending revision.  `$BASE` contains
+the contents of the file in the work tree if it exists,
+and the starting revision otherwise.
++
+If the custom merge tool correctly indicates the success of a
+merge resolution with its exit code then the configuration
+variable `mergetool.<tool>.trustExitCode` can be set to `true`.
+Otherwise, 'git-difftool' will prompt the user to indicate the
+success of the resolution after the custom tool has exited.
+
+-c or --commit=<ref>::
+	Specifies a commit reference for comparing against.
+	'git-difftool' compares against the index by default.
+
+--no-prompt::
+	Do not prompt before and after launching a merge tool.
+
+-s or --start=<ref> and -e or --end=<ref>::
+	See changes between commits start and end.
+	This example shows the latest commit: `--start=HEAD^ --end=HEAD`.
+
+CONFIG VARIABLES
+----------------
+
+merge.tool::
+	The default merge tool to use.
++
+See the `--tool=<tool>` option above for more details.
+
+mergetool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+mergetool.<tool>.cmd::
+	Specify the command to invoke the specified merge tool.
++
+See the `--tool=<tool>` option above for more details.
+
+mergetool.<tool>.trustExitCode::
+	For a custom merge command, specify whether the exit code of
+	the merge command can be used to determine whether the merge was
+	successful.  If this is not set to true then the merge target file
+	timestamp is checked and the merge assumed to have been successful
+	if the file has been updated, otherwise the user is prompted to
+	indicate the success of the merge.
+
+mergetool.keepBackup::
+	The original, unedit file content can be saved to a file with
+	a `.orig` extension. Defaults to `true` (i.e. keep the backup files).
+
+
+SEE ALSO
+--------
+linkgit:git-mergetool[1]::
+	'git-difftool' uses many of the same concepts as the core
+	'git-mergetool' command.
+
+linkgit:git-config[7]::
+	 Get and set repository or global options.
+
+AUTHOR
+------
+Written by David Aguilar <davvid@gmail.com>.
+
-- 
1.6.0.2.229.g1293c

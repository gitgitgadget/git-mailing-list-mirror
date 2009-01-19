From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] contrib: add 'git-difftool' for launching common diff tools
Date: Sun, 18 Jan 2009 16:25:53 -0800
Message-ID: <1232324753-16137-1-git-send-email-davvid@gmail.com>
References: <200901182025.24045.markus.heidelberg@web.de>
Cc: gitster@pobox.com, markus.heidelberg@web.de,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 01:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOhyT-0001nv-Q7
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 01:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbZASAZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 19:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbZASAZR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 19:25:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:6628 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbZASAZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 19:25:14 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2379208rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 16:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KKDeU5KPHWEnT6GAhYiNX3nPa+N30ZUKfMYH3kl9bmc=;
        b=oXhrFr5n5QGSXPGDPccDH9wxDlt6lfNuUm89SLXNnb0PhFDMDufnKZOPBNavGhN3EH
         aetLm0ese+8SPbGsevoH0wWbn/FDHgUhsLqD8ho249KJ3G8gwm7Qc6iecYTGmn5v+Z1H
         yD36ijWlix2y1XZgqEe0TNQk721bd4SQycJFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TTeC6CarXgPb4p/A7Q94WvDjisvCR1m179nHTgiIZEY+kxqe/o/GSKVcAGObRY6EMu
         Klm20oDedvnL2K6a+cQOOWF6dJzLb8Jk5TIbm8NZryyVGo2D+kXTZpaoHXHYT8iey8zn
         cL1QTFCSI3r6JkwJxeoJdm/9J6mowlqDwB3qk=
Received: by 10.141.115.20 with SMTP id s20mr2508296rvm.255.1232324711886;
        Sun, 18 Jan 2009 16:25:11 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l31sm8630168rvb.2.2009.01.18.16.25.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jan 2009 16:25:10 -0800 (PST)
X-Mailer: git-send-email 1.6.1.149.g7bbd8
In-Reply-To: <200901182025.24045.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106294>

'git-difftool' is a git command that allows you to compare and edit files
between revisions using common merge tools.  'git-difftool' does what
'git-mergetool' does but its use is for non-merge situations such as
when preparing commits or comparing changes against the index.
It uses the same configuration variables as 'git-mergetool' and
provides the same command-line interface as 'git-diff'.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This newer version addresses the feedback from Markus Heidelberg.
difftool is now more consistent with mergetool and it includes
Markus's vimdiff enhancements for positioning the cursor at startup.

 contrib/difftool/git-difftool        |   73 ++++++++++
 contrib/difftool/git-difftool-helper |  244 ++++++++++++++++++++++++++++++++++
 contrib/difftool/git-difftool.txt    |  104 ++++++++++++++
 3 files changed, 421 insertions(+), 0 deletions(-)
 create mode 100755 contrib/difftool/git-difftool
 create mode 100755 contrib/difftool/git-difftool-helper
 create mode 100644 contrib/difftool/git-difftool.txt

diff --git a/contrib/difftool/git-difftool b/contrib/difftool/git-difftool
new file mode 100755
index 0000000..0cda3d2
--- /dev/null
+++ b/contrib/difftool/git-difftool
@@ -0,0 +1,73 @@
+#!/usr/bin/env perl
+# Copyright (c) 2009 David Aguilar
+#
+# This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
+# git-difftool-helper script.  This script exports
+# GIT_EXTERNAL_DIFF and GIT_PAGER for use by git, and
+# GIT_DIFFTOOL_NO_PROMPT and GIT_MERGE_TOOL for use by git-difftool-helper.
+# Any arguments that are unknown to this script are forwarded to 'git diff'.
+
+use strict;
+use warnings;
+use Cwd qw(abs_path);
+use File::Basename qw(dirname);
+
+my $DIR = abs_path(dirname($0));
+
+
+sub usage
+{
+	print << 'USAGE';
+usage: git difftool [--tool=<tool>] [--no-prompt] ["git diff" options]
+USAGE
+	exit 1;
+}
+
+sub setup_environment
+{
+	$ENV{PATH} = "$DIR:$ENV{PATH}";
+	$ENV{GIT_PAGER} = '';
+	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool-helper';
+}
+
+sub exe
+{
+	my $exe = shift;
+	return defined $ENV{COMSPEC} ? "$exe.exe" : $exe;
+}
+
+sub generate_command
+{
+	my @command = (exe('git'), 'diff');
+	my $skip_next = 0;
+	my $idx = -1;
+	for my $arg (@ARGV) {
+		$idx++;
+		if ($skip_next) {
+			$skip_next = 0;
+			next;
+		}
+		if ($arg eq '-t' or $arg eq '--tool') {
+			usage() if $#ARGV <= $idx;
+			$ENV{GIT_MERGE_TOOL} = $ARGV[$idx + 1];
+			$skip_next = 1;
+			next;
+		}
+		if ($arg =~ /^--tool=/) {
+			$ENV{GIT_MERGE_TOOL} = substr($arg, 7);
+			next;
+		}
+		if ($arg eq '--no-prompt') {
+			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+			next;
+		}
+		if ($arg eq '-h' or $arg eq '--help') {
+			usage();
+		}
+		push @command, $arg;
+	}
+	return @command
+}
+
+setup_environment();
+exec(generate_command());
diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
new file mode 100755
index 0000000..a6f862f
--- /dev/null
+++ b/contrib/difftool/git-difftool-helper
@@ -0,0 +1,244 @@
+#!/bin/sh
+# git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
+# It supports kdiff3, tkdiff, xxdiff, meld, opendiff, emerge, ecmerge,
+# vimdiff, gvimdiff, and custom user-configurable tools.
+# This script is typically launched by using the 'git difftool'
+# convenience command.
+#
+# Copyright (c) 2009 David Aguilar
+
+# Set GIT_DIFFTOOL_NO_PROMPT to bypass the per-file prompt.
+should_prompt () {
+	! test -n "$GIT_DIFFTOOL_NO_PROMPT"
+}
+
+# Should we keep the backup .orig file?
+keep_backup_mode="$(git config --bool merge.keepBackup || echo true)"
+keep_backup () {
+	test "$keep_backup_mode" = "true"
+}
+
+# This function manages the backup .orig file.
+# A backup $MERGED.orig file is created if changes are detected.
+cleanup_temp_files () {
+	if test -n "$MERGED"; then
+		if keep_backup && test "$MERGED" -nt "$BACKUP"; then
+			test -f "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"
+		else
+			rm -f -- "$BACKUP"
+		fi
+	fi
+}
+
+# This is called when users Ctrl-C out of git-difftool-helper
+sigint_handler () {
+	echo
+	cleanup_temp_files
+	exit 1
+}
+
+# This function prepares temporary files and launches the appropriate
+# merge tool.
+launch_merge_tool () {
+	# Merged is the filename as it appears in the work tree
+	# Local is the contents of a/filename
+	# Remote is the contents of b/filename
+	# Custom merge tool commands might use $BASE so we provide it
+	MERGED="$1"
+	LOCAL="$2"
+	REMOTE="$3"
+	BASE="$1"
+	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
+	BACKUP="$MERGED.BACKUP.$ext"
+
+	# Create and ensure that we clean up $BACKUP
+	test -f "$MERGED" && cp -- "$MERGED" "$BACKUP"
+	trap sigint_handler SIGINT
+
+	# $LOCAL and $REMOTE are temporary files so prompt
+	# the user with the real $MERGED name before launching $merge_tool.
+	if should_prompt; then
+		printf "\nViewing: '$MERGED'\n"
+		printf "Hit return to launch '%s': " "$merge_tool"
+		read ans
+	fi
+
+	# Run the appropriate merge tool command
+	case "$merge_tool" in
+	kdiff3)
+		basename=$(basename "$MERGED")
+		"$merge_tool_path" --auto \
+			--L1 "$basename (A)" \
+			--L2 "$basename (B)" \
+			-o "$MERGED" "$LOCAL" "$REMOTE" \
+			> /dev/null 2>&1
+		;;
+
+	tkdiff)
+		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
+		;;
+
+	meld)
+		"$merge_tool_path" "$LOCAL" "$REMOTE"
+		;;
+
+	vimdiff)
+		"$merge_tool_path" -c "wincmd r" "$LOCAL" "$REMOTE"
+		;;
+
+	gvimdiff)
+		"$merge_tool_path" -c "wincmd r" -f "$LOCAL" "$REMOTE"
+		;;
+
+	xxdiff)
+		"$merge_tool_path" \
+			-X \
+			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+			-R 'Accel.Search: "Ctrl+F"' \
+			-R 'Accel.SearchForward: "Ctrl-G"' \
+			--merged-file "$MERGED" \
+			"$LOCAL" "$REMOTE"
+		;;
+
+	opendiff)
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			-merge "$MERGED" | cat
+		;;
+
+	ecmerge)
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			--default --mode=merge2 --to="$MERGED"
+		;;
+
+	emerge)
+		"$merge_tool_path" -f emerge-files-command \
+			"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
+		;;
+
+	*)
+		if test -n "$merge_tool_cmd"; then
+			( eval $merge_tool_cmd )
+		fi
+		;;
+	esac
+
+	cleanup_temp_files
+}
+
+# Verifies that mergetool.<tool>.cmd exists
+valid_custom_tool() {
+	merge_tool_cmd="$(git config mergetool.$1.cmd)"
+	test -n "$merge_tool_cmd"
+}
+
+# Verifies that the chosen merge tool is properly setup.
+# Built-in merge tools are always valid.
+valid_tool() {
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
+# Sets up the merge_tool_path variable.
+# This handles the mergetool.<tool>.path configuration.
+init_merge_tool_path() {
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
+# Allow the GIT_MERGE_TOOL variable to provide a default value
+test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
+
+# If not merge tool was specified then use the merge.tool
+# configuration variable.  If that's invalid then reset merge_tool.
+if test -z "$merge_tool"; then
+	merge_tool=$(git config merge.tool)
+	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
+		echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
+		echo >&2 "Resetting to default..."
+		unset merge_tool
+	fi
+fi
+
+# Try to guess an appropriate merge tool if no tool has been set.
+if test -z "$merge_tool"; then
+
+	# We have a $DISPLAY so try some common UNIX merge tools
+	if test -n "$DISPLAY"; then
+		merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
+		# If gnome then prefer meld
+		if test -n "$GNOME_DESKTOP_SESSION_ID"; then
+			merge_tool_candidates="meld $merge_tool_candidates"
+		fi
+		# If KDE then prefer kdiff3
+		if test "$KDE_FULL_SESSION" = "true"; then
+			merge_tool_candidates="kdiff3 $merge_tool_candidates"
+		fi
+	fi
+
+	# $EDITOR is emacs so add emerge as a candidate
+	if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
+		merge_tool_candidates="$merge_tool_candidates emerge"
+	fi
+
+	# $EDITOR is vim so add vimdiff as a candidate
+	if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
+		merge_tool_candidates="$merge_tool_candidates vimdiff"
+	fi
+
+	merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
+	echo "merge tool candidates: $merge_tool_candidates"
+
+	# Loop over each candidate and stop when a valid merge tool is found.
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
+	# A merge tool has been set, so verify that it's valid.
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
+fi
+
+
+# Launch the merge tool on each path provided by 'git diff'
+while test $# -gt 6
+do
+	launch_merge_tool "$1" "$2" "$5"
+	shift 7
+done
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
new file mode 100644
index 0000000..ca3dbd2
--- /dev/null
+++ b/contrib/difftool/git-difftool.txt
@@ -0,0 +1,104 @@
+git-difftool(1)
+===============
+
+NAME
+----
+git-difftool - compare changes using common merge tools
+
+SYNOPSIS
+--------
+'git difftool' [--tool=<tool>] [--no-prompt] ['git diff' options]
+
+DESCRIPTION
+-----------
+'git-difftool' is a git command that allows you to compare and edit files
+between revisions using common merge tools.  At its most basic level,
+'git-difftool' does what 'git-mergetool' does but its use is for non-merge
+situations such as when preparing commits or comparing changes against
+the index.
+
+'git difftool' is a frontend to 'git diff' and accepts the same
+arguments and options.
+
+See linkgit:git-diff[1] for the full list of supported options.
+
+OPTIONS
+-------
+-t <tool>::
+--tool=<tool>::
+	Use the merge resolution program specified by <tool>.
+	Valid merge tools are:
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
++
+If a merge resolution program is not specified, 'git-difftool'
+will use the configuration variable `merge.tool`.  If the
+configuration variable `merge.tool` is not set, 'git difftool'
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
+variables available: `$LOCAL` is set to the name of the temporary
+file containing the contents of the diff pre-image and `$REMOTE`
+is set to the name of the temporary file containing the contents
+of the diff post-image.  `$BASE` is provided for compatibility
+with custom merge tool commands and has the same value as `$LOCAL`.
+
+--no-prompt::
+	Do not prompt before launching a diff tool.
+
+CONFIG VARIABLES
+----------------
+merge.tool::
+	The default merge tool to use.
++
+See the `--tool=<tool>` option above for more details.
+
+merge.keepBackup::
+	The original, unedited file content can be saved to a file with
+	a `.orig` extension.  Defaults to `true` (i.e. keep the backup files).
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
+
+SEE ALSO
+--------
+linkgit:git-diff[1]::
+	 Show changes between commits, commit and working tree, etc
+
+linkgit:git-mergetool[1]::
+	Run merge conflict resolution tools to resolve merge conflicts
+
+linkgit:git-config[1]::
+	 Get and set repository or global options
+
+
+AUTHOR
+------
+Written by David Aguilar <davvid@gmail.com>.
+
+Documentation
+--------------
+Documentation by David Aguilar and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.6.1.149.g7bbd8

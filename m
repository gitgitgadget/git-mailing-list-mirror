From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v14 8/9] difftool: teach difftool to handle directory diffs
Date: Fri, 20 Apr 2012 12:56:28 -0400
Message-ID: <1334940988-8940-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com,
	ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Apr 20 18:58:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLHAS-00022I-Dh
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 18:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab2DTQ6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 12:58:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64989 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab2DTQ6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 12:58:38 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so13625748iag.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mC2ocz+Z4uuRAS553dqPo7BEEWp/zoYjXodtmpY5+2Y=;
        b=G8B91cLcO/3mQg6gE2+mOvjOHyVSzXFC3auK7TfcWx4RjdJgHAeuDIndSv1UqRxe2U
         zZg4XIlbpde3QQZFbohaKfMNxswIpBjvvTSd03yZkLoN4FME91TWGHy45timMM52jWAC
         nk6yLl1h4cn8zuMNCtKpx/tjOVEKdcX782nhTUcvcEtLh08kK4Ba3qGFzm0/2n/vWd2k
         i01caBZAFIoMQEe6UTrjrGf3aLLN/ZP4UKFye2785TK/mlVf0VWszGJFQL2CQisgOG+2
         tll0T4bPFKY0YpYBQYlsIXi8pEKAF0fJK+zlY8Oi8iu3GYa8dDQ/aAA5lWehboQ8Dxyz
         Tayg==
Received: by 10.50.45.200 with SMTP id p8mr7124291igm.23.1334941118294;
        Fri, 20 Apr 2012 09:58:38 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id i6sm8119594igq.3.2012.04.20.09.58.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Apr 2012 09:58:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.26.g5eb68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196009>

When 'difftool' is called to compare a range of commits that modify
more than one file, it opens a separate instance of the diff tool for
each file that changed.

The new '--dir-diff' option copies all the modified files to a temporary
location and runs a directory diff on them in a single instance of the
diff tool.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces 7fbdc6c on the th/difftool-diffall branch [1].

Changes in v14:

  - Fixed use of unitialized vars in the find_worktree function. A warning
    was seen when run on msysgit, but not other platforms.

  - Added a helper function (write_to_file) to replace repeated logic.

  - Fixed handling of symbolic links. The diff shown in the external tool
    now matches what is seen in the output of 'git diff'.

  - Added support for the diff format used for renames and copies. In the
    external tool, these will still appear as delete/add pairs.

  - Added logic to detect and abort if a combined diff ('--cc' or '-c')
    is commanded at the same time as directory diff ('--dir-diff').

[1]: https://github.com/gitster/git/tree/th/difftool-diffall


 Documentation/git-difftool.txt |    6 +
 git-difftool--helper.sh        |   19 ++-
 git-difftool.perl              |  261 +++++++++++++++++++++++++++++++++++++---
 t/t7800-difftool.sh            |   39 ++++++
 4 files changed, 299 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index fe38f66..aba5e76 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -19,6 +19,12 @@ linkgit:git-diff[1].
 
 OPTIONS
 -------
+-d::
+--dir-diff::
+	Copy the modified files to a temporary location and perform
+	a directory diff on them. This mode never prompts before
+	launching the diff tool.
+
 -y::
 --no-prompt::
 	Do not prompt before launching a diff tool.
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index e6558d1..3d0fe0c 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -73,9 +73,16 @@ then
 	fi
 fi
 
-# Launch the merge tool on each path provided by 'git diff'
-while test $# -gt 6
-do
-	launch_merge_tool "$1" "$2" "$5"
-	shift 7
-done
+if test -n "$GIT_DIFFTOOL_DIRDIFF"
+then
+	LOCAL="$1"
+	REMOTE="$2"
+	run_merge_tool "$merge_tool" false
+else
+	# Launch the merge tool on each path provided by 'git diff'
+	while test $# -gt 6
+	do
+		launch_merge_tool "$1" "$2" "$5"
+		shift 7
+	done
+fi
diff --git a/git-difftool.perl b/git-difftool.perl
index aba3d2f..7211f1e 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -1,21 +1,31 @@
-#!/usr/bin/env perl
+#!/usr/bin/perl
 # Copyright (c) 2009, 2010 David Aguilar
+# Copyright (c) 2012 Tim Henigan
 #
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
 # git-difftool--helper script.
 #
 # This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
-# GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, and GIT_DIFF_TOOL
-# are exported for use by git-difftool--helper.
+# The GIT_DIFF* variables are exported for use by git-difftool--helper.
 #
 # Any arguments that are unknown to this script are forwarded to 'git diff'.
 
 use 5.008;
 use strict;
 use warnings;
+use File::Basename qw(dirname);
+use File::Copy;
+use File::stat;
+use File::Path qw(mkpath);
+use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
+my @working_tree;
+my $rc;
+my $repo = Git->repository();
+my $repo_path = $repo->repo_path();
+
 sub usage
 {
 	my $exitcode = shift;
@@ -24,15 +34,202 @@ usage: git difftool [-t|--tool=<tool>]
                     [-x|--extcmd=<cmd>]
                     [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
+                    [-d|--dir-diff]
                     ['git diff' options]
 USAGE
 	exit($exitcode);
 }
 
+sub find_worktree
+{
+	# Git->repository->wc_path() does not honor changes to the working
+	# tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
+	# config variable.
+	my $worktree;
+	my $env_worktree = $ENV{GIT_WORK_TREE};
+	my $core_worktree = Git::config('core.worktree');
+
+	if (defined($env_worktree) and (length($env_worktree) > 0)) {
+		$worktree = $env_worktree;
+	} elsif (defined($core_worktree) and (length($core_worktree) > 0)) {
+		$worktree = $core_worktree;
+	} else {
+		$worktree = $repo->wc_path();
+	}
+
+	return $worktree;
+}
+
+my $workdir = find_worktree();
+
+sub setup_dir_diff
+{
+	# Run the diff; exit immediately if no diff found
+	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
+	# if $GIT_DIR and $GIT_WORK_TREE are set in ENV, they are actually used
+	# by Git->repository->command*.
+	my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
+	my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
+	exit(0) if (length($diffrtn) == 0);
+
+	if ($diffrtn =~ /::/) {
+		print "Combined diff formats ('-c' and '--cc') are not supported in directory diff mode.\n";
+		exit(1);
+	}
+
+	# Setup temp directories
+	my $tmpdir = tempdir('git-diffall.XXXXX', CLEANUP => 1, TMPDIR => 1);
+	my $ldir = "$tmpdir/left";
+	my $rdir = "$tmpdir/right";
+	mkpath($ldir) or die $!;
+	mkpath($rdir) or die $!;
+
+	# Build index info for left and right sides of the diff
+	my $submodule_mode = "160000";
+	my $symlink_mode = "120000";
+	my $null_mode = "0" x 6;
+	my $null_sha1 = "0" x 40;
+	my $lindex = "";
+	my $rindex = "";
+	my %submodule;
+	my %symlink;
+	my @rawdiff = split(':', $diffrtn);
+
+	for (my $i=1; $i<@rawdiff; $i++) {
+		my @fields = split('\0', $rawdiff[$i]);
+		my @stat = split(' ', splice(@fields, 0, 1));
+
+		my ($lmode, $rmode, $lsha1, $rsha1, $status) = @stat;
+		my ($src_path, $dst_path) = @fields;
+
+		if (not defined($dst_path)) {
+			$dst_path = $src_path;
+		}
+
+		if (($lmode eq $submodule_mode) or ($rmode eq $submodule_mode)) {
+			$submodule{$src_path}{left} = $lsha1;
+			if ($lsha1 ne $rsha1) {
+				$submodule{$dst_path}{right} = $rsha1;
+			} else {
+				$submodule{$dst_path}{right} = "$rsha1-dirty";
+			}
+			next;
+		}
+
+		if ($lmode eq $symlink_mode) {
+			$symlink{$src_path}{left} = $diffrepo->command_oneline('show', "$lsha1");
+		}
+
+		if ($rmode eq $symlink_mode) {
+			$symlink{$dst_path}{right} = $diffrepo->command_oneline('show', "$rsha1");
+		}
+
+		if ($lmode ne $null_mode) {
+			$lindex .= "$lmode $lsha1\t$src_path\0";
+		}
+
+		if ($rmode ne $null_mode) {
+			if ($rsha1 ne $null_sha1) {
+				$rindex .= "$rmode $rsha1\t$dst_path\0";
+			} else {
+				push(@working_tree, $dst_path);
+			}
+		}
+	}
+
+	# If $GIT_DIR is not set prior to calling 'git update-index' and
+	# 'git checkout-index', then those commands will fail if difftool
+	# is called from a directory other than the repo root.
+	my $must_unset_git_dir = 0;
+	if (not defined($ENV{GIT_DIR})) {
+		$must_unset_git_dir = 1;
+		$ENV{GIT_DIR} = $repo_path;
+	}
+
+	# Populate the left and right directories based on each index file
+	my ($inpipe, $ctx);
+	$ENV{GIT_INDEX_FILE} = "$tmpdir/lindex";
+	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	print($inpipe $lindex);
+	$repo->command_close_pipe($inpipe, $ctx);
+	$rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
+	exit($rc | ($rc >> 8)) if ($rc != 0);
+
+	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
+	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	print($inpipe $rindex);
+	$repo->command_close_pipe($inpipe, $ctx);
+	$rc = system('git', 'checkout-index', '--all', "--prefix=$rdir/");
+	exit($rc | ($rc >> 8)) if ($rc != 0);
+
+	# If $GIT_DIR was explicitly set just for the update/checkout
+	# commands, then it should be unset before continuing.
+	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
+	delete($ENV{GIT_INDEX_FILE});
+
+	# Changes in the working tree need special treatment since they are
+	# not part of the index
+	for my $file (@working_tree) {
+		my $dir = dirname($file);
+		unless (-d "$rdir/$dir") {
+			mkpath("$rdir/$dir") or die $!;
+		}
+		copy("$workdir/$file", "$rdir/$file") or die $!;
+		chmod(stat("$workdir/$file")->mode, "$rdir/$file") or die $!;
+	}
+
+	# Changes to submodules require special treatment. This loop writes a
+	# temporary file to both the left and right directories to show the
+	# change in the recorded SHA1 for the submodule.
+	for my $path (keys %submodule) {
+		if (defined($submodule{$path}{left})) {
+			write_to_file("$ldir/$path", "Subproject commit $submodule{$path}{left}");
+		}
+		if (defined($submodule{$path}{right})) {
+			write_to_file("$rdir/$path", "Subproject commit $submodule{$path}{right}");
+		}
+	}
+
+	# Symbolic links require special treatment. The standard "git diff"
+	# shows only the link itself, not the contents of the link target.
+	# This loop replicates that behavior.
+	for my $path (keys %symlink) {
+		if (defined($symlink{$path}{left})) {
+			write_to_file("$ldir/$path", $symlink{$path}{left});
+		}
+		if (defined($symlink{$path}{right})) {
+			write_to_file("$rdir/$path", $symlink{$path}{right});
+		}
+	}
+
+	return ($ldir, $rdir);
+}
+
+sub write_to_file
+{
+	my $path = shift;
+	my $value = shift;
+
+	# Make sure the path to the file exists
+	my $dir = dirname($path);
+	unless (-d "$dir") {
+		mkpath("$dir") or die $!;
+	}
+
+	# If the file already exists in that location, delete it.  This
+	# is required in the case of symbolic links.
+	unlink("$path");
+
+	open(my $fh, ">", "$path") or die $!;
+	print($fh $value);
+	close($fh);
+}
+
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
-my ($difftool_cmd, $extcmd, $gui, $help, $prompt);
+my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt);
 GetOptions('g|gui!' => \$gui,
+	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
 	'prompt!' => \$prompt,
 	'y' => sub { $prompt = 0; },
@@ -65,22 +262,46 @@ if ($gui) {
 		$ENV{GIT_DIFF_TOOL} = $guitool;
 	}
 }
-if (defined($prompt)) {
-	if ($prompt) {
-		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+
+# In directory diff mode, 'git-difftool--helper' is called once
+# to compare the a/b directories.  In file diff mode, 'git diff'
+# will invoke a separate instance of 'git-difftool--helper' for
+# each file that changed.
+if (defined($dirdiff)) {
+	my ($a, $b) = setup_dir_diff();
+	if (defined($extcmd)) {
+		$rc = system($extcmd, $a, $b);
 	} else {
-		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
+		$rc = system('git', 'difftool--helper', $a, $b);
 	}
-}
 
-$ENV{GIT_PAGER} = '';
-$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
-my @command = ('git', 'diff', @ARGV);
-
-# ActiveState Perl for Win32 does not implement POSIX semantics of
-# exec* system call. It just spawns the given executable and finishes
-# the starting program, exiting with code 0.
-# system will at least catch the errors returned by git diff,
-# allowing the caller of git difftool better handling of failures.
-my $rc = system(@command);
-exit($rc | ($rc >> 8));
+	exit($rc | ($rc >> 8)) if ($rc != 0);
+
+	# If the diff including working copy files and those
+	# files were modified during the diff, then the changes
+	# should be copied back to the working tree
+	for my $file (@working_tree) {
+		copy("$b/$file", "$workdir/$file") or die $!;
+		chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
+	}
+} else {
+	if (defined($prompt)) {
+		if ($prompt) {
+			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+		} else {
+			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		}
+	}
+
+	$ENV{GIT_PAGER} = '';
+	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
+
+	# ActiveState Perl for Win32 does not implement POSIX semantics of
+	# exec* system call. It just spawns the given executable and finishes
+	# the starting program, exiting with code 0.
+	# system will at least catch the errors returned by git diff,
+	# allowing the caller of git difftool better handling of failures.
+	my $rc = system('git', 'diff', @ARGV);
+	exit($rc | ($rc >> 8));
+}
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e716d06..478c1be 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -319,4 +319,43 @@ test_expect_success PERL 'say no to the second file' '
 	echo "$diff" | stdin_doesnot_contain br2
 '
 
+test_expect_success PERL 'setup change in subdirectory' '
+	git checkout master &&
+	mkdir sub &&
+	echo master >sub/sub &&
+	git add sub/sub &&
+	git commit -m "added sub/sub" &&
+	echo test >>file &&
+	echo test >>sub/sub &&
+	git add . &&
+	git commit -m "modified both"
+'
+
+test_expect_success PERL 'difftool -d' '
+	diff=$(git difftool -d --extcmd ls branch) &&
+	echo "$diff" | stdin_contains sub &&
+	echo "$diff" | stdin_contains file
+'
+
+test_expect_success PERL 'difftool --dir-diff' '
+	diff=$(git difftool --dir-diff --extcmd ls branch) &&
+	echo "$diff" | stdin_contains sub &&
+	echo "$diff" | stdin_contains file
+'
+
+test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
+	diff=$(git difftool --dir-diff --prompt --extcmd ls branch) &&
+	echo "$diff" | stdin_contains sub &&
+	echo "$diff" | stdin_contains file
+'
+
+test_expect_success PERL 'difftool --dir-diff from subdirectory' '
+	(
+		cd sub &&
+		diff=$(git difftool --dir-diff --extcmd ls branch) &&
+		echo "$diff" | stdin_contains sub &&
+		echo "$diff" | stdin_contains file
+	)
+'
+
 test_done
-- 
1.7.10.rc1.26.g5eb68

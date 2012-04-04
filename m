From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Wed,  4 Apr 2012 15:21:05 -0400
Message-ID: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com,
	ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Wed Apr 04 21:21:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFVlz-0004aO-NY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab2DDTVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 15:21:34 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33877 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292Ab2DDTVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:21:33 -0400
Received: by qcro28 with SMTP id o28so387784qcr.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fa0V595IPMYpxwaTHDSm7q6yTvhdRq1vDoUzRrmbB/s=;
        b=cfkQT3tW6Lk3OK/D5QhzeviJWmwk9I8jMFeXoC8sNb1tSRGFFpe3CvUzcJBpqSgeSr
         BNlftvDru5HEiAeTpSzaDOTq2FMbSy6hzT/PMapox0XlfIFkdNNaP3an9ILIytWkMnAH
         8A4QFu6gGyjac4HEbxIJ/N/LcfIRbuCmkO5gSfIt6LO46et0Nzw3b7/sGZ09fFJzbTes
         cRMyaefZkpBGteDoJVwreqVXx//oedgSxwgWHJ4MililAQyolaSbG9MWn8f91HRWqJKQ
         8oKpTakMETGktG9mXH970djeit+9FqGMalRDb2LMFg8rpUEG9UglZ9KU/ABx/KsixaM4
         oxsg==
Received: by 10.229.105.224 with SMTP id u32mr7384610qco.41.1333567292486;
        Wed, 04 Apr 2012 12:21:32 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id dm8sm2511781qab.18.2012.04.04.12.21.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 12:21:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc2.22.ga52d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194721>

When 'difftool' is called to compare a range of commits that modify
more than one file, it opens a separate instance of the diff tool for
each file that changed.

The new '--dir-diff' option copies all the modified files to a temporary
location and runs a directory diff on them in a single instance of the
diff tool.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces commit 4d6efe0 in the 'th/difftool-diffall' branch based
on pu. This version corrects some problems with submodule support in
difftool.

Changes in v11:
  - Fix handling of submodules in subdirectories.
    
    If the diff includes a submodule that lives in a subdirectory of
    the project, the script fails with "No such file or directory".
    For example, if a submodule is located at '<repo root>/lib/sub',
    the script fails when it tries to write the submodule SHA1 to
    '/tmp/.../lib/sub' because the 'lib' directory does not exist.
    This commit teaches difftool to create the subdirectory path in
    the tmp location prior to writing the submodule file.

  - Append "dirty" to submodule SHA1 when needed
    
    If a submodule is dirty (i.e. has uncommitted changes) then
      'git diff' reports "<SHA1 of parent>-dirty"
    while
      'git diff --raw' reports "<SHA1 of parent>"
    difftool uses the '--raw' diff format, so the "dirty" flag is lost.
    To make the output more closely match that of 'git diff', teach
    difftool to append "-dirty" to the submodule SHA1 when needed.


 Documentation/git-difftool.txt |    6 ++
 git-difftool--helper.sh        |   19 +++--
 git-difftool.perl              |  170 +++++++++++++++++++++++++++++++++++-----
 t/t7800-difftool.sh            |   39 +++++++++
 4 files changed, 209 insertions(+), 25 deletions(-)

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
index d4fe998..5bb01e1 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -1,21 +1,29 @@
 #!/usr/bin/env perl
 # Copyright (c) 2009, 2010 David Aguilar
+# Copyright (c) 2012 Tim Henigan
 #
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
 # git-difftool--helper script.
 #
 # This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
-# GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, and GIT_DIFF_TOOL
-# are exported for use by git-difftool--helper.
+# GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, GIT_DIFFTOOL_DIRDIFF,
+# and GIT_DIFF_TOOL are exported for use by git-difftool--helper.
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
+
 sub usage
 {
 	my $exitcode = shift;
@@ -24,15 +32,121 @@ usage: git difftool [-t|--tool=<tool>]
                     [-x|--extcmd=<cmd>]
                     [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
+                    [-d|--dir-diff]
                     ['git diff' options]
 USAGE
 	exit($exitcode);
 }
 
+sub setup_dir_diff
+{
+	# Run the diff; exit immediately if no diff found
+	my $repo = Git->repository();
+	my $diffrtn = $repo->command_oneline(['diff', '--raw', '--no-abbrev', '-z', @ARGV]);
+	exit(0) if (length($diffrtn) == 0);
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
+	my $null_mode = 0 x 6;
+	my $null_sha1 = 0 x 40;
+	my $lindex = "";
+	my $rindex = "";
+	my %submodule;
+	my @rawdiff = split('\0', $diffrtn);
+
+	for (my $i=0; $i<@rawdiff; $i+=2) {
+		my ($lmode, $rmode, $lsha1, $rsha1, $status) = split(' ', substr($rawdiff[$i], 1));
+		my $path = $rawdiff[$i + 1];
+
+		if (($lmode eq $submodule_mode) or ($rmode eq $submodule_mode)) {
+			$submodule{$path}{left} = $lsha1;
+			if ($lsha1 ne $rsha1) {
+				$submodule{$path}{right} = $rsha1;
+			} else {
+				$submodule{$path}{right} = "$rsha1-dirty";
+			}
+			next;
+		}
+
+		if ($lmode ne $null_mode) {
+			$lindex .= "$lmode $lsha1\t$path\0";
+		}
+
+		if ($rmode ne $null_mode) {
+			if ($rsha1 ne $null_sha1) {
+				$rindex .= "$rmode $rsha1\t$path\0";
+			} else {
+				push(@working_tree, $path);
+			}
+		}
+	}
+
+	# Populate the left and right directories based on each index file
+	my ($inpipe, $ctx);
+	$ENV{GIT_DIR} = $repo->repo_path();
+	$ENV{GIT_INDEX_FILE} = "$tmpdir/lindex";
+	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	print($inpipe $lindex);
+	$repo->command_close_pipe($inpipe, $ctx);
+	system(('git', 'checkout-index', '--all', "--prefix=$ldir/"));
+
+	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
+	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	print($inpipe $rindex);
+	$repo->command_close_pipe($inpipe, $ctx);
+	system(('git', 'checkout-index', '--all', "--prefix=$rdir/"));
+
+	# Changes in the working tree need special treatment since they are
+	# not part of the index
+	my $workdir = $repo->repo_path() . "/..";
+	for (@working_tree) {
+		my $dir = dirname($_);
+		unless (-d "$rdir/$dir") {
+			mkpath("$rdir/$dir") or die $!;
+		}
+		copy("$workdir/$_", "$rdir/$_") or die $!;
+		chmod(stat("$workdir/$_")->mode, "$rdir/$_") or die $!;
+	}
+
+	# Changes to submodules require special treatment. This loop writes a
+	# temporary file to both the left and right directories to show the
+	# change in the recorded SHA1 for the submodule.
+	foreach my $path (keys %submodule) {
+		if (defined $submodule{$path}{left}) {
+			my $dir = dirname($path);
+			unless (-d "$ldir/$dir") {
+				mkpath("$ldir/$dir") or die $!;
+			}
+			open(my $fh, ">", "$ldir/$path") or die $!;
+			print($fh "Subproject commit $submodule{$path}{left}");
+			close($fh);
+		}
+		if (defined $submodule{$path}{right}) {
+			my $dir = dirname($path);
+			unless (-d "$rdir/$dir") {
+				mkpath("$rdir/$dir") or die $!;
+			}
+			open(my $fh, ">", "$rdir/$path") or die $!;
+			print($fh "Subproject commit $submodule{$path}{right}");
+			close($fh);
+		}
+	}
+
+	return ($ldir, $rdir);
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
@@ -65,22 +179,40 @@ if ($gui) {
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
+		system(($extcmd, $a, $b));
 	} else {
-		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
+		system(('git', 'difftool--helper', $a, $b));
+	}
+
+	# If the diff including working copy files and those
+	# files were modified during the diff, then the changes
+	# should be copied back to the working tree
+	my $repo = Git->repository();
+	my $workdir = $repo->repo_path() . "/..";
+	for (@working_tree) {
+		copy("$b/$_", "$workdir/$_") or die $!;
+		chmod(stat("$b/$_")->mode, "$workdir/$_") or die $!;
+	}
+} else {
+	if (defined($prompt)) {
+		if ($prompt) {
+			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+		} else {
+			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		}
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
+	$ENV{GIT_PAGER} = '';
+	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
+	my $rc = system(('git', 'diff', @ARGV));
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
1.7.10.rc2.22.ga52d4

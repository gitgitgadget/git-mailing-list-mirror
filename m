From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 8/9 v10] difftool: teach difftool to handle directory diffs
Date: Tue,  3 Apr 2012 09:04:24 -0400
Message-ID: <1333458265-29360-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com,
	ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Tue Apr 03 15:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF3QB-0003hz-GT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 15:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab2DCNFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 09:05:07 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62897 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab2DCNFF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 09:05:05 -0400
Received: by qcro28 with SMTP id o28so834467qcr.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uxT/IRoVNINJ+zXCuibxfJcB6iCTQRhvbRdMYNY2C7M=;
        b=ROM7eItl/MENEzdwMVO4EyuKmrafE0I8+aN00UEnqjz4FeFuhRlaWgS6ZoRWI7VdJ1
         ZGROw6rn/PHSaA0Z5RU27qXGLvrRsDaWjg+Kzoy+Pb5FJIzXAdGcrf/3AyyvFklqeG4E
         6wh+59aG1m+Vf4np3O1GAIHKzbw+A3SCdfnh7S2kMf7GuySLDy9plHCYRFe31QbqBOXO
         YIHW9fFl97JYR+UtuLmCNhHmxI76zJND6W2jx74joBNnImEE8+v9lvhqFDUDG5ucAd0K
         ng7WffxZufmSQVD0R080rfzUnguJieMhyJ+iwZNM0wmQU/0yphfmeiG2lXR+s+gLVPNR
         wfQg==
Received: by 10.229.136.5 with SMTP id p5mr4883050qct.134.1333458304628;
        Tue, 03 Apr 2012 06:05:04 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id f12sm39638394qan.1.2012.04.03.06.04.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 06:05:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc2.20.ge4d56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194619>

When 'difftool' is called to compare a range of commits that modify
more than one file, it opens a separate instance of the diff tool for
each file that changed.

The new '--dir-diff' option copies all the modified files to a temporary
location and runs a directory diff on them in a single instance of the
diff tool.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This update is intended to be applied to the branch currently found at
'th/difftool-diffall' (based on pu).

Changes in v10:

As Ramsay Jones pointed out on the Git list [1], t7800.3 is failing on
some systems because the exit code from difftool is incorrect.

difftool wraps some commands in 'git_cmd_try' blocks. If an exception is
raised, these blocks call Carp::croak to exit. However, there appears to
be a bug in Carp::croak that causes it to always exit with errno 9 "Bad
file descriptor" on some systems.

This happens even with a simple one-liner like:
  perl -e 'use 5.008; use Carp qw(croak); print $!+0, " $!\n";'

The above is expected to print "0" and exit without error. However, on
the problem systems it prints "9 Bad file descriptor".

To fix the problem, we need to:
  - Drop commit 0440ed72 (patch 7/9 "difftool: replace system call with
    Git::command_noisy") from the series.
  - Replace commit 6fbdb7b (patch 8/9 "difftool: teach difftool to handle
    directory diffs") with this patch. This version changes all instances
    of 'git_cmd_try' to simple 'system' calls.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/194284/focus=194540

 Documentation/git-difftool.txt |    6 ++
 git-difftool--helper.sh        |   19 +++--
 git-difftool.perl              |  158 +++++++++++++++++++++++++++++++++++-----
 t/t7800-difftool.sh            |   39 ++++++++++
 4 files changed, 197 insertions(+), 25 deletions(-)

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
index d4fe998..828c11e 100755
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
@@ -24,15 +32,109 @@ usage: git difftool [-t|--tool=<tool>]
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
+			$submodule{$path}{right} = $rsha1;
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
+			open(my $fh, ">", "$ldir/$path") or die $!;
+			print($fh "Subproject commit $submodule{$path}{left}");
+			close($fh);
+		}
+		if (defined $submodule{$path}{right}) {
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
@@ -65,22 +167,40 @@ if ($gui) {
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
1.7.10.rc1.28.geb866

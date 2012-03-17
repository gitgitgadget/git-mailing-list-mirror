From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 7/9] difftool: teach difftool to handle directory diffs
Date: Fri, 16 Mar 2012 21:59:34 -0400
Message-ID: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ivp-0006ki-4W
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 02:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946041Ab2CQB7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:59:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61404 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945895Ab2CQB7i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:59:38 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so6234576iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=O+CKtOkVH5jOwVOBNHTmfUEFtu/6nmD+dtgdipvUBno=;
        b=odZuT0EBFiHgQDldb78ylVlrmUtnyCiVRXB2quCWTrgI+mR79RNKybzwHsSr5arF+d
         THwwDFwXYoEQH2FdGETcEOwjbXQiKVntqGzfq2srsQSfJX1+aCmdgzZe/UrHJ77ZM9A5
         asmYz7m6TZRTZHFhg6YsI5BNyUT9Z4XQ19h/XNrNYH5iKkecd9zC1xl5xf54pimFscPj
         tlEs/GzBP9E5/3JXaq+RF1S2p8vljjza3Q0efWJ0cKKQTtrb2lUT816ftf6GRi8+ICnW
         79TY9TQ6LP6fx3MAu1oofOrB17HBlF0GPsqEAHTJ91Mw38oKMI5GuDPeDSms9RX2Y0p8
         sGPQ==
Received: by 10.50.95.167 with SMTP id dl7mr1236473igb.6.1331949578536;
        Fri, 16 Mar 2012 18:59:38 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id gh8sm904484igb.16.2012.03.16.18.59.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:59:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193296>

Prior to this commit, the difftool utility could only open files one
at a time.  The new '--dir-diff' option copies all the modified files
to a temporary location and runs a directory diff on them.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

I'm not sure what conventions are used to decide when new copyright
authors are added.  Given the amount of change to this script, it
seems appropriate to add me to the list. However, if that is change
is outside norms, I have no problem taking it out.


 Documentation/git-difftool.txt |    6 ++
 git-difftool--helper.sh        |   20 ++++--
 git-difftool.perl              |  142 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 150 insertions(+), 18 deletions(-)

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
index e6558d1..bd0556f 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -6,6 +6,7 @@
 # Copyright (c) 2009, 2010 David Aguilar
 
 TOOL_MODE=diff
+SUBDIRECTORY_OK=1
 . git-mergetool--lib
 
 # difftool.prompt controls the default prompt/no-prompt behavior
@@ -73,9 +74,16 @@ then
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
index 8498089..0262c7a 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -1,18 +1,24 @@
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
 
@@ -22,15 +28,109 @@ sub usage
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>] [-x|--extcmd=<cmd>]
                     [-y|--no-prompt]   [-g|--gui]
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
+	my $tmpdir = tempdir('/tmp/git-diffall.XXXXX', CLEANUP => 1);
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
+	my @working_tree;
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
+	$ENV{GIT_INDEX_FILE} = "$tmpdir/lindex";
+	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	print($inpipe $lindex);
+	$repo->command_close_pipe($inpipe, $ctx);
+	$repo->command_oneline(["checkout-index", "-a", "--prefix=$ldir/"]);
+
+	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
+	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	print($inpipe $rindex);
+	$repo->command_close_pipe($inpipe, $ctx);
+	$repo->command_oneline(["checkout-index", "-a", "--prefix=$rdir/"]);
+
+	# Changes in the working tree need special treatment since they are
+	# not part of the index
+	my $workdir = $repo->wc_path();
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
+			open(SUBMOD, ">$ldir/$path") or die $!;
+			print(SUBMOD "Subproject commit $submodule{$path}{left}");
+			close(SUBMOD);
+		}
+		if (defined $submodule{$path}{right}) {
+			open(SUBMOD, ">$rdir/$path") or die $!;
+			print(SUBMOD "Subproject commit $submodule{$path}{right}");
+			close(SUBMOD);
+		}
+	}
+
+	return ($ldir, $rdir);
+}
+
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
-my ($difftool_cmd, $extcmd, $gui, $help, $no_prompt, $prompt);
+my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $no_prompt, $prompt);
 GetOptions('g|gui' => \$gui,
+	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
 	'prompt' => \$prompt,
 	't|tool:s' => \$difftool_cmd,
@@ -63,13 +163,31 @@ if (defined($gui)) {
 		$ENV{GIT_DIFF_TOOL} = $guitool;
 	}
 }
-if (defined($prompt)) {
-	$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-}
-elsif (defined($no_prompt)) {
-	$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
-}
 
-$ENV{GIT_PAGER} = '';
-$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
-git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
+# In directory diff mode, 'git-difftool--helper' is called once
+# to compare the a/b directories.  In file diff mode, 'git diff'
+# will invoke a separate instance of 'git-difftool--helper' for
+# each file that changed.
+if (defined($dirdiff)) {
+	my ($a, $b) = setup_dir_diff();
+	if (defined($extcmd)) {
+		system("$extcmd $a $b");
+	} else {
+		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
+		system("git difftool--helper $a $b");
+	}
+	# TODO: if the diff including working copy files and those
+	# files were modified during the diff, then the changes
+	# should be copied back to the working tree
+} else {
+	if (defined($prompt)) {
+		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+	}
+	elsif (defined($no_prompt)) {
+		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+	}
+
+	$ENV{GIT_PAGER} = '';
+	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
+	git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
+}
-- 
1.7.9.1.290.gbd444

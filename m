From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 2/5] difftool: Eliminate global variables
Date: Tue, 24 Jul 2012 19:59:30 -0700
Message-ID: <1343185173-48278-3-git-send-email-davvid@gmail.com>
References: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:59:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StrpM-0002AO-L2
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835Ab2GYC7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:59:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37671 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab2GYC7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:59:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so634306pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 19:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=U6D9YiM6LXvO2QEoJoCenaSbagNW/rZF5qC+2PZ5SZI=;
        b=fM1n1PB2XSM+NTIqYZSvkyBUzVkxSEcHWC4ZtbCew05O5lo1RQYA1hqeztERalBHbM
         N3ifDVhv6/ZWegPh/KvLZRiLQ9jmaxMu0k7GQkLJyPRxHLOJGrOYKywkhcWU7MTmPwY4
         NbeggNyOTdFYV5ETWoWFw0NucHUib6fBxaqbGQnuXOsopTLiCbepoN53GCNbEBy4oNd1
         crtgnw4sIXSkBJ1HLkqdrekjVn342q0wcO3wnIY1q7hXmEiN0VODiZjG9M1TECr++KlU
         LkZAkCuB/4vWGEXw5/pBN9O+wiEiEyp2K+YAZCbkTq7iJr+6H+rp3uqoxP1/gl6mYV8v
         I+eg==
Received: by 10.68.192.40 with SMTP id hd8mr33276049pbc.125.1343185175667;
        Tue, 24 Jul 2012 19:59:35 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kh1sm13382996pbc.23.2012.07.24.19.59.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 19:59:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202099>

Organize the script so that it has a single main() function which
calls out to dir_diff() and file_diff() functions. This eliminates
"dir-diff"-specific variables that do not need to be calculated when
performing a regular file-diff.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Same as last time, but rebased against the new 1/5

 git-difftool.perl | 128 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 75 insertions(+), 53 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index d4737e1..fa787d6 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -23,11 +23,6 @@ use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
-my @working_tree;
-my $rc;
-my $repo = Git->repository();
-my $repo_path = $repo->repo_path();
-
 sub usage
 {
 	my $exitcode = shift;
@@ -44,6 +39,8 @@ USAGE
 
 sub find_worktree
 {
+	my ($repo) = @_;
+
 	# Git->repository->wc_path() does not honor changes to the working
 	# tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
 	# config variable.
@@ -62,8 +59,6 @@ sub find_worktree
 	return $worktree;
 }
 
-my $workdir = find_worktree();
-
 sub filter_tool_scripts
 {
 	my ($tools) = @_;
@@ -112,10 +107,13 @@ sub print_tool_help
 
 sub setup_dir_diff
 {
+	my ($repo, $workdir) = @_;
+
 	# Run the diff; exit immediately if no diff found
 	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
 	# if $GIT_DIR and $GIT_WORK_TREE are set in ENV, they are actually used
 	# by Git->repository->command*.
+	my $repo_path = $repo->repo_path();
 	my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
 	my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
 	exit(0) if (length($diffrtn) == 0);
@@ -136,6 +134,7 @@ sub setup_dir_diff
 	my $rindex = '';
 	my %submodule;
 	my %symlink;
+	my @working_tree = ();
 	my @rawdiff = split('\0', $diffrtn);
 
 	my $i = 0;
@@ -203,7 +202,7 @@ sub setup_dir_diff
 	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
 	print($inpipe $lindex);
 	$repo->command_close_pipe($inpipe, $ctx);
-	$rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
+	my $rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
 	exit($rc | ($rc >> 8)) if ($rc != 0);
 
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
@@ -253,7 +252,7 @@ sub setup_dir_diff
 		}
 	}
 
-	return ($ldir, $rdir);
+	return ($ldir, $rdir, @working_tree);
 }
 
 sub write_to_file
@@ -276,54 +275,70 @@ sub write_to_file
 	close($fh);
 }
 
-# parse command-line options. all unrecognized options and arguments
-# are passed through to the 'git diff' command.
-my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
-GetOptions('g|gui!' => \$gui,
-	'd|dir-diff' => \$dirdiff,
-	'h' => \$help,
-	'prompt!' => \$prompt,
-	'y' => sub { $prompt = 0; },
-	't|tool:s' => \$difftool_cmd,
-	'tool-help' => \$tool_help,
-	'x|extcmd:s' => \$extcmd);
-
-if (defined($help)) {
-	usage(0);
-}
-if (defined($tool_help)) {
-	print_tool_help();
-}
-if (defined($difftool_cmd)) {
-	if (length($difftool_cmd) > 0) {
-		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
-	} else {
-		print "No <tool> given for --tool=<tool>\n";
-		usage(1);
+sub main
+{
+	# parse command-line options. all unrecognized options and arguments
+	# are passed through to the 'git diff' command.
+	my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
+	GetOptions('g|gui!' => \$gui,
+		'd|dir-diff' => \$dirdiff,
+		'h' => \$help,
+		'prompt!' => \$prompt,
+		'y' => sub { $prompt = 0; },
+		't|tool:s' => \$difftool_cmd,
+		'tool-help' => \$tool_help,
+		'x|extcmd:s' => \$extcmd);
+
+	if (defined($help)) {
+		usage(0);
 	}
-}
-if (defined($extcmd)) {
-	if (length($extcmd) > 0) {
-		$ENV{GIT_DIFFTOOL_EXTCMD} = $extcmd;
-	} else {
-		print "No <cmd> given for --extcmd=<cmd>\n";
-		usage(1);
+	if (defined($tool_help)) {
+		print_tool_help();
 	}
-}
-if ($gui) {
-	my $guitool = '';
-	$guitool = Git::config('diff.guitool');
-	if (length($guitool) > 0) {
-		$ENV{GIT_DIFF_TOOL} = $guitool;
+	if (defined($difftool_cmd)) {
+		if (length($difftool_cmd) > 0) {
+			$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
+		} else {
+			print "No <tool> given for --tool=<tool>\n";
+			usage(1);
+		}
+	}
+	if (defined($extcmd)) {
+		if (length($extcmd) > 0) {
+			$ENV{GIT_DIFFTOOL_EXTCMD} = $extcmd;
+		} else {
+			print "No <cmd> given for --extcmd=<cmd>\n";
+			usage(1);
+		}
+	}
+	if ($gui) {
+		my $guitool = '';
+		$guitool = Git::config('diff.guitool');
+		if (length($guitool) > 0) {
+			$ENV{GIT_DIFF_TOOL} = $guitool;
+		}
+	}
+
+	# In directory diff mode, 'git-difftool--helper' is called once
+	# to compare the a/b directories.  In file diff mode, 'git diff'
+	# will invoke a separate instance of 'git-difftool--helper' for
+	# each file that changed.
+	if (defined($dirdiff)) {
+		dir_diff($extcmd);
+	} else {
+		file_diff($prompt);
 	}
 }
 
-# In directory diff mode, 'git-difftool--helper' is called once
-# to compare the a/b directories.  In file diff mode, 'git diff'
-# will invoke a separate instance of 'git-difftool--helper' for
-# each file that changed.
-if (defined($dirdiff)) {
-	my ($a, $b) = setup_dir_diff();
+sub dir_diff
+{
+	my ($extcmd) = @_;
+
+	my $rc;
+	my $repo = Git->repository();
+
+	my $workdir = find_worktree($repo);
+	my ($a, $b, @working_tree) = setup_dir_diff($repo, $workdir);
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
 	} else {
@@ -342,7 +357,12 @@ if (defined($dirdiff)) {
 			chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
 		}
 	}
-} else {
+}
+
+sub file_diff
+{
+	my ($prompt) = @_;
+
 	if (defined($prompt)) {
 		if ($prompt) {
 			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
@@ -362,3 +382,5 @@ if (defined($dirdiff)) {
 	my $rc = system('git', 'diff', @ARGV);
 	exit($rc | ($rc >> 8));
 }
+
+main();
-- 
1.7.12.rc0.15.g8157c39

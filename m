From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/5] difftool: Eliminate global variables
Date: Sun, 22 Jul 2012 20:42:17 -0700
Message-ID: <1343014940-16439-2-git-send-email-davvid@gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:43:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9Xz-00065r-PX
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab2GWDm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:42:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54753 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2GWDmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:42:16 -0400
Received: by pbbrp8 with SMTP id rp8so10148794pbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sWEJMlEttba+y76BSb8jE7lxpbMPwyBNKdBnHO6fbe0=;
        b=zEkqBvHd9ms76Y3dVHIEI0+KeqTyX68KlNvqpzGNIrIa856oXfnl0KD2hlwhsyl17t
         XdwjKNpP+u/CIDPKtyujy9nv6m0EbKeRjVss96tMBOU+4Mwroc9J6N2Qao5jyYPFZ40u
         2abVeA3C0KQAIDiZV8GvhkH67aX8bXRRp3afhljveEJ/XgIMWdfGpEwxTkwv1+O5y29a
         TERyjKYDaOT0eDc4ABM3AVZXhhr8cDYutCUDzjgUZzCnlKhMqyji+08lTO6Q1frYIVNC
         A3o0Jl+nI/6SLBj49tDTY8Ebz5HQWGwL59byguQy9sOMGZacJo/Eki+VwtwFbNTCyNC9
         N2mg==
Received: by 10.66.87.66 with SMTP id v2mr27520483paz.71.1343014935818;
        Sun, 22 Jul 2012 20:42:15 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ru10sm9051189pbc.50.2012.07.22.20.42.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:42:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
In-Reply-To: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201882>

Organize the script so that it has a single main() function which
calls out to dir_diff() and file_diff() functions. This eliminates
"dir-diff"-specific variables that do not need to be calculated when
performing a regular file-diff.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 128 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 75 insertions(+), 53 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ac0ed63..41ba932 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -22,11 +22,6 @@ use File::Temp qw(tempdir);
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
@@ -43,6 +38,8 @@ USAGE
 
 sub find_worktree
 {
+	my ($repo) = @_;
+
 	# Git->repository->wc_path() does not honor changes to the working
 	# tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
 	# config variable.
@@ -61,8 +58,6 @@ sub find_worktree
 	return $worktree;
 }
 
-my $workdir = find_worktree();
-
 sub print_tool_help
 {
 	my ($cmd, @found, @notfound);
@@ -97,10 +92,13 @@ sub print_tool_help
 
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
@@ -121,6 +119,7 @@ sub setup_dir_diff
 	my $rindex = '';
 	my %submodule;
 	my %symlink;
+	my @working_tree = ();
 	my @rawdiff = split('\0', $diffrtn);
 
 	my $i = 0;
@@ -188,7 +187,7 @@ sub setup_dir_diff
 	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
 	print($inpipe $lindex);
 	$repo->command_close_pipe($inpipe, $ctx);
-	$rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
+	my $rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
 	exit($rc | ($rc >> 8)) if ($rc != 0);
 
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
@@ -238,7 +237,7 @@ sub setup_dir_diff
 		}
 	}
 
-	return ($ldir, $rdir);
+	return ($ldir, $rdir, @working_tree);
 }
 
 sub write_to_file
@@ -261,54 +260,70 @@ sub write_to_file
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
@@ -327,7 +342,12 @@ if (defined($dirdiff)) {
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
@@ -347,3 +367,5 @@ if (defined($dirdiff)) {
 	my $rc = system('git', 'diff', @ARGV);
 	exit($rc | ($rc >> 8));
 }
+
+main();
-- 
1.7.11.2.255.g5f133da

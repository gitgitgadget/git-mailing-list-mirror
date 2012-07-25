From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 5/5] difftool: Use symlinks when diffing against the worktree
Date: Tue, 24 Jul 2012 19:59:33 -0700
Message-ID: <1343185173-48278-6-git-send-email-davvid@gmail.com>
References: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:59:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StrpD-00024D-On
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab2GYC7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:59:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37671 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab2GYC7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:59:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so634306pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 19:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+dM6aBzsw12/37aYPiMuoMQMNHxmau6cav+voGnRb4k=;
        b=LU9kypnmlXoOHcNwriwCn8b4OZ3qMr3l8bE7/k5upMt19c83NQNQaIKdl0cyEctJc1
         XpW1z3luPebiEJdm/rcBHBbpzrBqIWPxXESeqeWI3iXrcir7awB+mKaSPvt8JgHj6d7W
         LKr1OVe8MUmRkAqmmwEjOuZDSuZtzzHyF1pZA2VzA/DTQt5ZNZQ+Pv05Ljo4GhA7pgic
         VrcbngNBnwgnnD3qNeXPvBrAAFdo5BCDlL9Pqeorl6NzojhvQaRYnlxWjDF+1Eqdaohn
         a0CgGkSO8xeLFfAL1e9qgdJmJeWD6GXgMrg8IlozrU7jjP6yqObdrMlreQC9WdFqScIU
         bflw==
Received: by 10.68.190.102 with SMTP id gp6mr49806015pbc.5.1343185181244;
        Tue, 24 Jul 2012 19:59:41 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kh1sm13382996pbc.23.2012.07.24.19.59.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 19:59:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202098>

Teach difftool's --dir-diff mode to use symlinks to represent
files from the working copy, and make it the default behavior
for the non-Windows platforms.

Using symlinks is safer since we avoid needing to copy temporary
files into the worktree.

The original behavior is available as --no-symlinks.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Differences:

This version checks for compare() returning -1 and emit a warning.

 Documentation/git-difftool.txt |  8 ++++++++
 git-difftool.perl              | 43 ++++++++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 31fc2e3..313d54e 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -66,6 +66,14 @@ of the diff post-image.  `$MERGED` is the name of the file which is
 being compared. `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$MERGED`.
 
+--symlinks::
+--no-symlinks::
+	'git difftool''s default behavior is create symlinks to the
+	working tree when run in `--dir-diff` mode.
++
+	Specifying `--no-symlinks` instructs 'git difftool' to create
+	copies instead.  `--no-symlinks` is the default on Windows.
+
 --tool-help::
 	Print a list of diff tools that may be used with `--tool`.
 
diff --git a/git-difftool.perl b/git-difftool.perl
index b4f2fc6..10d3d97 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -107,7 +107,7 @@ sub print_tool_help
 
 sub setup_dir_diff
 {
-	my ($repo, $workdir) = @_;
+	my ($repo, $workdir, $symlinks) = @_;
 
 	# Run the diff; exit immediately if no diff found
 	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
@@ -224,8 +224,13 @@ sub setup_dir_diff
 		unless (-d "$rdir/$dir") {
 			mkpath("$rdir/$dir") or die $!;
 		}
-		copy("$workdir/$file", "$rdir/$file") or die $!;
-		chmod(stat("$workdir/$file")->mode, "$rdir/$file") or die $!;
+		if ($symlinks) {
+			symlink("$workdir/$file", "$rdir/$file") or die $!;
+		} else {
+			copy("$workdir/$file", "$rdir/$file") or die $!;
+			my $mode = stat("$workdir/$file")->mode;
+			chmod($mode, "$rdir/$file") or die $!;
+		}
 	}
 
 	# Changes to submodules require special treatment. This loop writes a
@@ -286,6 +291,8 @@ sub main
 		gui => undef,
 		help => undef,
 		prompt => undef,
+		symlinks => $^O ne 'cygwin' &&
+				$^O ne 'MSWin32' && $^O ne 'msys',
 		tool_help => undef,
 	);
 	GetOptions('g|gui!' => \$opts{gui},
@@ -293,6 +300,8 @@ sub main
 		'h' => \$opts{help},
 		'prompt!' => \$opts{prompt},
 		'y' => sub { $opts{prompt} = 0; },
+		'symlinks' => \$opts{symlinks},
+		'no-symlinks' => sub { $opts{symlinks} = 0; },
 		't|tool:s' => \$opts{difftool_cmd},
 		'tool-help' => \$opts{tool_help},
 		'x|extcmd:s' => \$opts{extcmd});
@@ -331,7 +340,7 @@ sub main
 	# will invoke a separate instance of 'git-difftool--helper' for
 	# each file that changed.
 	if (defined($opts{dirdiff})) {
-		dir_diff($opts{extcmd});
+		dir_diff($opts{extcmd}, $opts{symlinks});
 	} else {
 		file_diff($opts{prompt});
 	}
@@ -339,13 +348,13 @@ sub main
 
 sub dir_diff
 {
-	my ($extcmd) = @_;
+	my ($extcmd, $symlinks) = @_;
 
 	my $rc;
 	my $repo = Git->repository();
 
 	my $workdir = find_worktree($repo);
-	my ($a, $b, @working_tree) = setup_dir_diff($repo, $workdir);
+	my ($a, $b, @worktree) = setup_dir_diff($repo, $workdir, $symlinks);
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
 	} else {
@@ -357,13 +366,27 @@ sub dir_diff
 
 	# If the diff including working copy files and those
 	# files were modified during the diff, then the changes
-	# should be copied back to the working tree
-	for my $file (@working_tree) {
-		if (-e "$b/$file" && compare("$b/$file", "$workdir/$file")) {
+	# should be copied back to the working tree.
+	# Do not copy back files when symlinks are used and the
+	# external tool did not replace the original link with a file.
+	for my $file (@worktree) {
+		next if $symlinks && -l "$b/$file";
+		next if ! -f "$b/$file";
+
+		my $diff = compare("$b/$file", "$workdir/$file");
+		if ($diff == 0) {
+			next;
+		} elsif ($diff == -1 ) {
+			my $errmsg = "warning: could not compare ";
+			$errmsg += "'$b/$file' with '$workdir/$file'\n";
+			warn $errmsg;
+		} elsif ($diff == 1) {
 			copy("$b/$file", "$workdir/$file") or die $!;
-			chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
+			my $mode = stat("$b/$file")->mode;
+			chmod($mode, "$workdir/$file") or die $!;
 		}
 	}
+	exit(0);
 }
 
 sub file_diff
-- 
1.7.12.rc0.15.g8157c39

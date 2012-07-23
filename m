From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 5/5] difftool: Use symlinks when diffing against the worktree
Date: Sun, 22 Jul 2012 20:57:11 -0700
Message-ID: <1343015831-17498-6-git-send-email-davvid@gmail.com>
References: <1343015831-17498-1-git-send-email-davvid@gmail.com>
 <1343015831-17498-2-git-send-email-davvid@gmail.com>
 <1343015831-17498-3-git-send-email-davvid@gmail.com>
 <1343015831-17498-4-git-send-email-davvid@gmail.com>
 <1343015831-17498-5-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:58:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9mb-0000Tl-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab2GWD5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:57:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56934 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab2GWD5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:57:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so10168206pbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SR54/feCZRST3WugoQkYPi4ImZ+xdd3J1dn7NiK3vtc=;
        b=IZ1iHVuaY70Bx6vi4UKEbC9U9HaT5jFbhssCqsX4lHTk6FxrNRc25oTzUjhrQ6ZVpx
         SL4vJd/8GCMxUHlmdmPCTP34o25+UC0BZocwTUx1mtk6Grh5nF3AaejLCnNXEa5Cziho
         LwW4Et9oFfEBCMOkyyjaRyEpoxPZP9WSxwY53mRWRdkynfrR4ttPogSonDTdkpBBM29P
         +QCcMDaklhjME36OxESJmNx3tbpyWQNMokf17NwiSGiiLd5ZKJt92DPZVoXk3dNCCYle
         eYVnEBpjHqZ/x7/FU6cxqOaJVBM2HREgBWB7SBfiJwo5faeTiB/nzimA2QdXm+56nPnj
         gKhg==
Received: by 10.68.219.162 with SMTP id pp2mr31780466pbc.85.1343015836756;
        Sun, 22 Jul 2012 20:57:16 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id iw10sm8485543pbc.55.2012.07.22.20.57.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:57:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
In-Reply-To: <1343015831-17498-5-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201891>

Teach difftool's --dir-diff mode to use symlinks to represent
files from the working copy, and make it the default behavior
for the non-Windows platforms.

Using symlinks is simpler and safer since we do not need to
worry about copying files back into the worktree.
The old behavior is still available as --no-symlinks.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Same as before, resending because gmail ate patch 4/5

 Documentation/git-difftool.txt |  8 ++++++++
 git-difftool.perl              | 30 +++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

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
index 2ae344c..b8f8057 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -92,7 +92,7 @@ sub print_tool_help
 
 sub setup_dir_diff
 {
-	my ($repo, $workdir) = @_;
+	my ($repo, $workdir, $symlinks) = @_;
 
 	# Run the diff; exit immediately if no diff found
 	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
@@ -209,8 +209,13 @@ sub setup_dir_diff
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
@@ -271,6 +276,7 @@ sub main
 		gui => undef,
 		help => undef,
 		prompt => undef,
+		symlinks => $^O ne 'MSWin32' && $^O ne 'msys',
 		tool_help => undef,
 	);
 	GetOptions('g|gui!' => \$opts{gui},
@@ -278,6 +284,8 @@ sub main
 		'h' => \$opts{help},
 		'prompt!' => \$opts{prompt},
 		'y' => sub { $opts{prompt} = 0; },
+		'symlinks' => \$opts{symlinks},
+		'no-symlinks' => sub { $opts{symlinks} = 0; },
 		't|tool:s' => \$opts{difftool_cmd},
 		'tool-help' => \$opts{tool_help},
 		'x|extcmd:s' => \$opts{extcmd});
@@ -316,7 +324,7 @@ sub main
 	# will invoke a separate instance of 'git-difftool--helper' for
 	# each file that changed.
 	if (defined($opts{dirdiff})) {
-		dir_diff($opts{extcmd});
+		dir_diff($opts{extcmd}, $opts{symlinks});
 	} else {
 		file_diff($opts{prompt});
 	}
@@ -324,13 +332,13 @@ sub main
 
 sub dir_diff
 {
-	my ($extcmd) = @_;
+	my ($extcmd, $symlinks) = @_;
 
 	my $rc;
 	my $repo = Git->repository();
 
 	my $workdir = find_worktree($repo);
-	my ($a, $b, @working_tree) = setup_dir_diff($repo, $workdir);
+	my ($a, $b, @working_tree) = setup_dir_diff($repo, $workdir, $symlinks);
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
 	} else {
@@ -340,15 +348,23 @@ sub dir_diff
 
 	exit($rc | ($rc >> 8)) if ($rc != 0);
 
+	# Do not copy back files when symlinks are used
+	if ($symlinks) {
+		exit(0);
+	}
+
 	# If the diff including working copy files and those
 	# files were modified during the diff, then the changes
 	# should be copied back to the working tree
+
 	for my $file (@working_tree) {
 		if (-e "$b/$file" && compare("$b/$file", "$workdir/$file")) {
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
1.7.11.2.255.g5f133da

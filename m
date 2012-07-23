From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 5/5] difftool: Use symlinks when diffing against the worktree
Date: Sun, 22 Jul 2012 20:42:20 -0700
Message-ID: <1343014940-16439-5-git-send-email-davvid@gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9YN-0006PU-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2GWDnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:43:00 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52535 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab2GWDmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:42:21 -0400
Received: by pbbrp8 with SMTP id rp8so10148903pbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EtLq53LohfOAil4/1aVbltn0422SdA1W3NMBJkBXohc=;
        b=NRug2nyR+E13vvv32TIb34VGQB8pnzKE++AaXeYQhyW+D/y3rmwiKWD7n4841kQQqI
         Vpx3BqB4m4S8IC1/PXl5gTz3eYLQ6u7nqjJOkSdOg9gYfS3ZDNnzG9ORijlp8/azXBVn
         OL+yUJt/d+3yBa6i7iGMI7oS7uv0FX3GZhN0lZkgDt8E2UkmC275luMwoItZCTBXiqPe
         QdtLgtA7F7/dmW+n7q1kDlU1UwSJBCMgY/PGl7dVK2H5suEXHs72IcAsLgNiBhUGB7Xs
         4I9HeTs7U4RsKKBM7nCEiqHv8/ELXsMzMLVdmRN5e+JSGeez0x7+mQJADNOsMojdA+9M
         nFgw==
Received: by 10.68.194.234 with SMTP id hz10mr32148507pbc.126.1343014941478;
        Sun, 22 Jul 2012 20:42:21 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ru10sm9051189pbc.50.2012.07.22.20.42.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:42:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
In-Reply-To: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201884>

Teach difftool's --dir-diff mode to use symlinks to represent
files from the working copy, and make it the default behavior
for the non-Windows platforms.

Using symlinks is simpler and safer since we do not need to
worry about copying files back into the worktree.
The old behavior is still available as --no-symlinks.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
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

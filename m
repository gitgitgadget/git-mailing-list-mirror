From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 4/5] difftool: Use symlinks when diffing against the worktree
Date: Sun, 22 Jul 2012 23:05:30 -0700
Message-ID: <1343023530-31463-1-git-send-email-davvid@gmail.com>
References: <7vzk6rnkgq.fsf@alter.siamese.dyndns.org>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StBm0-00045X-Ca
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab2GWGFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:05:35 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48279 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab2GWGFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:05:35 -0400
Received: by gglu4 with SMTP id u4so5104256ggl.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K5l9qX2bHiarg9fkBQrfMHaub2jKbo23xHr5z2OqLhs=;
        b=msGGQcP5mLAvSsmzJEgmwsxCUhEOWrKb696A4WWcH0iwoXR1M2Qp/DNilvQX3oDkNI
         g+93Txsiu80Pg9aQvj1uQxe1/CLgduuRa/4RmEqW9bTzoWmf+mKPBVaKjn2TagWtW8Gc
         j0Ax0ij71vHZpp1YnaY+koXxZzkBtHCet4L6bBsvpam6QcTKfwy592pDOGBK16cBngOU
         O8UaS3r0GdBmqslzyatq6piSMlr6yx1p341fLvYGmLE2OlD30dsQby9GcBJTwwfajg+u
         rl8nwXlx1tOdcM7Q9I4lJhVCjySt6TlFKRxjhVoXTplZFnHWWHEFCUkhxq3g8HDrz9oH
         tKWw==
Received: by 10.66.85.135 with SMTP id h7mr28097253paz.75.1343023533730;
        Sun, 22 Jul 2012 23:05:33 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id og4sm9290904pbb.48.2012.07.22.23.05.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 23:05:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3.293.gf8e7f10
In-Reply-To: <7vzk6rnkgq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201905>

Teach difftool's --dir-diff mode to use symlinks to represent
files from the working copy, and make it the default behavior
for the non-Windows platforms.

Using symlinks is simpler and safer since we do not need to
worry about copying files back into the worktree.
The old behavior is still available as --no-symlinks.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Handles the case where an editor unlinks the original symlink,
replacing it with a file.

 Documentation/git-difftool.txt |    8 ++++++++
 git-difftool.perl              |   33 +++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

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
index 2ae344c..a5b371f 100755
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
+	my ($a, $b, @worktree) = setup_dir_diff($repo, $workdir, $symlinks);
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
 	} else {
@@ -342,13 +350,18 @@ sub dir_diff
 
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
+		if (-f "$b/$file" && compare("$b/$file", "$workdir/$file")) {
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
1.7.7.2.448.gee6df

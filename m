From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: Do not remove temporary files on error
Date: Tue, 24 Jul 2012 23:14:36 -0700
Message-ID: <1343196876-59195-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:14:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sturt-0007FH-Io
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab2GYGOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:14:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55945 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab2GYGOj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:14:39 -0400
Received: by yenl2 with SMTP id l2so350403yen.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 23:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LNUYdItew/O85KbOmkSEwjLXCM8oZ6tBzlKiqHtdNTI=;
        b=ByYHRzMivbyIhxnTc6XsFblrfYGR0z8nJr/092d5RvyO2Y1gOJd1FuLwKp8jAQefnL
         e3h6ja/RsmPCnbWLm9Uub/7XvQOgpActyOEAC2v0q6TgHDci151gEf18GNkxefxvFHpZ
         YeWrydsmrdAS8/6ViGJ4dWZrJtpnbT5nLrjyXA8hTgCPAGSRj+zs2JYd1kIVYvSq1D63
         b+ZS1nzv48D8RPDiSELhVEvZB5UEvXfagRfLpljyLNpd621LKTO47CcM1Ij7WKcHSRpU
         1fMLT9Cj229j+ELP4ivnoUoaVKaWD9s7zG/rWrcpbrgnAgcegOgDogqLtb9dhA43E96M
         1BjA==
Received: by 10.66.89.166 with SMTP id bp6mr10237089pab.48.1343196878841;
        Tue, 24 Jul 2012 23:14:38 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id rs4sm13719801pbc.0.2012.07.24.23.14.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 23:14:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.9.g2b1cfc7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202128>

Keep the temporary directory around when either compare() or
the difftool returns a non-zero exit status.

Tell the user about the location of the temporary files so that
they can recover from the failure.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 10d3d97..f4f7d4a 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -18,7 +18,7 @@ use File::Copy;
 use File::Compare;
 use File::Find;
 use File::stat;
-use File::Path qw(mkpath);
+use File::Path qw(mkpath rmtree);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
@@ -119,7 +119,7 @@ sub setup_dir_diff
 	exit(0) if (length($diffrtn) == 0);
 
 	# Setup temp directories
-	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 1, TMPDIR => 1);
+	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
 	my $ldir = "$tmpdir/left";
 	my $rdir = "$tmpdir/right";
 	mkpath($ldir) or die $!;
@@ -257,7 +257,7 @@ sub setup_dir_diff
 		}
 	}
 
-	return ($ldir, $rdir, @working_tree);
+	return ($ldir, $rdir, $tmpdir, @working_tree);
 }
 
 sub write_to_file
@@ -349,20 +349,23 @@ sub main
 sub dir_diff
 {
 	my ($extcmd, $symlinks) = @_;
-
 	my $rc;
+	my $error = 0;
 	my $repo = Git->repository();
-
 	my $workdir = find_worktree($repo);
-	my ($a, $b, @worktree) = setup_dir_diff($repo, $workdir, $symlinks);
+	my ($a, $b, $tmpdir, @worktree) =
+		setup_dir_diff($repo, $workdir, $symlinks);
+
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
 	} else {
 		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
 		$rc = system('git', 'difftool--helper', $a, $b);
 	}
-
-	exit($rc | ($rc >> 8)) if ($rc != 0);
+	if ($rc != 0) {
+		dir_diff_tmpdir_warning($tmpdir);
+		exit($rc | ($rc >> 8));
+	}
 
 	# If the diff including working copy files and those
 	# files were modified during the diff, then the changes
@@ -377,16 +380,29 @@ sub dir_diff
 		if ($diff == 0) {
 			next;
 		} elsif ($diff == -1 ) {
-			my $errmsg = "warning: could not compare ";
+			my $errmsg = "warning: Could not compare ";
 			$errmsg += "'$b/$file' with '$workdir/$file'\n";
 			warn $errmsg;
+			$error = 1;
 		} elsif ($diff == 1) {
 			copy("$b/$file", "$workdir/$file") or die $!;
 			my $mode = stat("$b/$file")->mode;
 			chmod($mode, "$workdir/$file") or die $!;
 		}
 	}
-	exit(0);
+	if ($error) {
+		dir_diff_tmpdir_warning($tmpdir);
+	} else {
+		rmtree($tmpdir);
+	}
+	exit($error);
+}
+
+sub dir_diff_tmpdir_warning
+{
+	my ($tmpdir) = @_;
+	warn "warning: Temporary files exist in '$tmpdir'.\n";
+	warn "warning: You may want to cleanup or recover these.\n";
 }
 
 sub file_diff
-- 
1.7.11.9.g2b1cfc7.dirty

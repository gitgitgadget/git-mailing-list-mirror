From: Barry Wardell <barry.wardell@gmail.com>
Subject: [PATCH] git-svn: Simplify calculation of GIT_DIR
Date: Sat,  3 Mar 2012 18:08:27 +0000
Message-ID: <1330798107-33561-1-git-send-email-barry.wardell@gmail.com>
Cc: Barry Wardell <barry.wardell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 19:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tNz-0006lu-MJ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 19:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab2CCSIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 13:08:46 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61640 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab2CCSIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 13:08:45 -0500
Received: by wgbdr13 with SMTP id dr13so2413825wgb.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 10:08:44 -0800 (PST)
Received-SPF: pass (google.com: domain of barry.wardell@gmail.com designates 10.216.134.87 as permitted sender) client-ip=10.216.134.87;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of barry.wardell@gmail.com designates 10.216.134.87 as permitted sender) smtp.mail=barry.wardell@gmail.com; dkim=pass header.i=barry.wardell@gmail.com
Received: from mr.google.com ([10.216.134.87])
        by 10.216.134.87 with SMTP id r65mr3446797wei.46.1330798124352 (num_hops = 1);
        Sat, 03 Mar 2012 10:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=1Mc1nm0V56Ctl462uytDITrkNCwZAM2JSw/+M1OlVj8=;
        b=c7VLJ3+9nPXi7xmJmAjX0g+o/dc45Z3I/AV2/ZUY4sFFnzP4WSds1BwW/4Kwzf2azI
         TRI9TWzK7ILDQcgZC2vKS/vA9OJgLmUowztoabWVA13GQY2eg4koijBYlqK9mfwAOrRj
         M98Xc6+DCYZTJp+MDxLfMaN8A8liY+DVivBV+8huIEmhWl4AGKB9s8HMGZBiYdjQEvv0
         m9wB1PGARnuSX1tJ7ZyqSeTmHEx3A0AJlTUQ3NgQmXLrkgrAr6DRSad7HqPKZsXCt4kZ
         0dz/taTrK+Ha3MEXCYZY8zwuGd0iPzFrze7NC35+tPJCFuX5ot96ijUArALYl1dPZZwu
         eF2w==
Received: by 10.216.134.87 with SMTP id r65mr2758201wei.46.1330798124277;
        Sat, 03 Mar 2012 10:08:44 -0800 (PST)
Received: from localhost.localdomain ([46.7.100.170])
        by mx.google.com with ESMTPS id fl2sm30799781wib.4.2012.03.03.10.08.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 10:08:43 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192127>

Since git-rev-parse already checks for the $GIT_DIR environment
variable and that it returns an actual git repository, there is no
need to repeat the checks again here.

This also fixes a problem where git-svn did not work in cases where
.git was a file with a gitdir: link.
---
 git-svn.perl |   25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4334b95..cf2cef8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -15,8 +15,6 @@ my $cmd_dir_prefix = eval {
 	command_oneline([qw/rev-parse --show-prefix/], STDERR => 0)
 } || '';
 
-my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
-$ENV{GIT_DIR} ||= '.git';
 $Git::SVN::default_repo_id = 'svn';
 $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
@@ -290,28 +288,9 @@ for (my $i = 0; $i < @ARGV; $i++) {
 	}
 };
 
-# make sure we're always running at the top-level working directory
+# Access an existing repository
 unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
-	unless (-d $ENV{GIT_DIR}) {
-		if ($git_dir_user_set) {
-			die "GIT_DIR=$ENV{GIT_DIR} explicitly set, ",
-			    "but it is not a directory\n";
-		}
-		my $git_dir = delete $ENV{GIT_DIR};
-		my $cdup = undef;
-		git_cmd_try {
-			$cdup = command_oneline(qw/rev-parse --show-cdup/);
-			$git_dir = '.' unless ($cdup);
-			chomp $cdup if ($cdup);
-			$cdup = "." unless ($cdup && length $cdup);
-		} "Already at toplevel, but $git_dir not found\n";
-		chdir $cdup or die "Unable to chdir up to '$cdup'\n";
-		unless (-d $git_dir) {
-			die "$git_dir still not found after going to ",
-			    "'$cdup'\n";
-		}
-		$ENV{GIT_DIR} = $git_dir;
-	}
+	$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
 	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
-- 
1.7.9.2

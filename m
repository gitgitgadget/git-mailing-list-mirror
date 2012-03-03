From: Barry Wardell <barry.wardell@gmail.com>
Subject: [PATCH v2] git-svn: Simplify calculation of GIT_DIR
Date: Sat,  3 Mar 2012 19:53:17 +0000
Message-ID: <1330804397-43062-1-git-send-email-barry.wardell@gmail.com>
Cc: Barry Wardell <barry.wardell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 20:55:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3v2j-0006p5-57
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 20:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab2CCTyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 14:54:31 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38312 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab2CCTya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 14:54:30 -0500
Received: by wgbdr13 with SMTP id dr13so2448245wgb.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 11:54:29 -0800 (PST)
Received-SPF: pass (google.com: domain of barry.wardell@gmail.com designates 10.180.80.40 as permitted sender) client-ip=10.180.80.40;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of barry.wardell@gmail.com designates 10.180.80.40 as permitted sender) smtp.mail=barry.wardell@gmail.com; dkim=pass header.i=barry.wardell@gmail.com
Received: from mr.google.com ([10.180.80.40])
        by 10.180.80.40 with SMTP id o8mr5492935wix.10.1330804469054 (num_hops = 1);
        Sat, 03 Mar 2012 11:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=K8gM8cmjYQaMvtrh30si9Tun1GR0ErfTmp7Qnp9SYgY=;
        b=fQeTsGgTm02E9cY7tCBPeMOCTl+jg1gywJIc7u893qBhpT9q58SsTuWn745mvpVt1m
         fkn+cESDi/1RlK0SkkCGYWUg9wTf3g75bFMg6hCapu8aWJbMPCPpx+ZAPGAgVxpSHZHg
         KzdLo1NNABj0hDlt4AXIS0ZMxX1LsTRcvM+MIrVTXxq1gTwHDwKN836e4oncjkNbxQlr
         25pSza9+VwcY+VGDCzrGm7La2ggYSvaqxfmM+RG9T2UyH6BYSSvav06fHjK0tS1sd6j9
         rfnlcf8iWp4U0BpgycNJGBZ8UQ255yCqS5fzLPhXD1XEjuJoBdGaYlV8FNXZrrV54hz+
         U0VQ==
Received: by 10.180.80.40 with SMTP id o8mr4347382wix.10.1330804468984;
        Sat, 03 Mar 2012 11:54:28 -0800 (PST)
Received: from localhost.localdomain ([46.7.100.170])
        by mx.google.com with ESMTPS id r8sm6341744wiw.10.2012.03.03.11.54.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 11:54:28 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192133>

Since git-rev-parse already checks for the $GIT_DIR environment
variable and that it returns an actual git repository, there is no
need to repeat the checks again here.

This also fixes a problem where git-svn did not work in cases where
.git was a file with a gitdir: link.
---
 git-svn.perl |   33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4334b95..bbfd351 100755
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
@@ -292,26 +290,17 @@ for (my $i = 0; $i < @ARGV; $i++) {
 
 # make sure we're always running at the top-level working directory
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
+	my $toplevel = undef;
+
+	git_cmd_try {
+		$toplevel = command_oneline([qw/rev-parse --show-toplevel/]);
+	} "Unable to find toplevel directory\n";
+
+	git_cmd_try {
+		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
+	} "Unable to find .git directory\n";
+
+	chdir $toplevel or die "Unable to chdir to '$toplevel'\n";
 	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
-- 
1.7.9.2

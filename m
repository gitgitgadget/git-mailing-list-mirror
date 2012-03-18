From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 8/9 v2] difftool: teach dir-diff to copy modified files back to working tree
Date: Sat, 17 Mar 2012 21:55:33 -0400
Message-ID: <1332035734-5443-9-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95Mm-0004Sq-FE
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab2CRB4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:56:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883Ab2CRB4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:56:32 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=68NzvPxkH42upzXpU/gR5CyLMJ7m2JnLvZbOLsXL644=;
        b=FSsb3pry7pUdZJrBnkczXeqMt0FRMHUkjKzRV3weDLhYbS74F5Tf3MMOYxicHdGJB0
         nfaBfNjjNiLD+cz8K4Jv3I7PVsrBSe7enj+OrPVu45HsjvvIKlHv0etmD+A9FcYu1+hg
         bTAK8R3Hf3BhzP23nO62cQ2zokvMLqtUli/wOoZduxsorjO6v56i9be31QkW5Zmzqw/1
         fJ0WqQmkzGRu1tL+tYg2+tGZ+dIx3Q5q4+QI+hJzSO1qnfWXZtOYPTkjuR5s82R26LoK
         xAjZsG6o7GWMvAyZYfTuTr5p/Fu3z5tUiTefA3CaZKw2Vb+Pd7Fw2h61prH6meIB9rZu
         vRLw==
Received: by 10.50.216.231 with SMTP id ot7mr2942428igc.8.1332035791790;
        Sat, 17 Mar 2012 18:56:31 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id zv10sm2956629igb.13.2012.03.17.18.56.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:56:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193363>

If the user runs a diff when there are modified files in the working copy,
they expect to be able to be edit the files in the diff viewer and save
the changes. When using difftool in file mode (i.e. diffing one file at
a time), this works as expected.  However, when using difftool in directory
diff mode, the changes are not saved.

This commit teaches the directory diff mode to copy changes from the diff
viewer back to the working copy.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 1f7b8f2..e306977 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -22,6 +22,8 @@ use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
+my @working_tree;
+
 sub usage
 {
 	my $exitcode = shift;
@@ -54,7 +56,6 @@ sub setup_dir_diff
 	my $null_sha1 = 0 x 40;
 	my $lindex = "";
 	my $rindex = "";
-	my @working_tree;
 	my %submodule;
 	my @rawdiff = split('\0', $diffrtn);
 
@@ -178,9 +179,16 @@ if (defined($dirdiff)) {
 			Git::command_noisy(('difftool--helper', $a, $b))
 		} 'exit code %d';
 	}
-	# TODO: if the diff including working copy files and those
+
+	# If the diff including working copy files and those
 	# files were modified during the diff, then the changes
 	# should be copied back to the working tree
+	my $repo = Git->repository();
+	my $workdir = $repo->wc_path();
+	for (@working_tree) {
+		copy("$b/$_", "$workdir/$_") or die $!;
+		chmod(stat("$b/$_")->mode, "$workdir/$_") or die $!;
+	}
 } else {
 	if (defined($prompt)) {
 		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-- 
1.7.9.1.290.gbd444

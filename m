From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 8/9] difftool: teach dir-diff to copy modified files back to working tree
Date: Fri, 16 Mar 2012 21:59:54 -0400
Message-ID: <1331949594-15238-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 03:00:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8iw9-000700-1M
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 03:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946083Ab2CQB77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:59:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61404 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945895Ab2CQB76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:59:58 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so6234576iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IXO87VYfjU1vPGjudc80w67hAmnZsHNBFybeBqk01J4=;
        b=HvhUcmKhM+xW8ysSgVrMX1TFvKvM4xATYANilpyh4gh8tY8p0dHRXaZ+5/RnU0rdxp
         BykhMGjYreowSfiuIUoBmoOQ+fwdCRcn/VdB3xVBs52pVrIbzD+WmyL4iChUifTDmUA2
         uU3aDhbROhBIOpQoh77P1bfiRNNegjyWcb7PpnUaM2XCsbqT5I1OiRmwIjN3uS6I1O1k
         aO3F5/I2RetnmlIBg1M7JGT0ETrPsh3+s0ipkPORzMd7oEvu/IfQFHUITF6P4UgEOv02
         0HeWcPQuymKonvpCkgfzJU0eLa8qX6jsWwIcFruvNRWDFLPBLC/ufo398407Y+5+cVl/
         vEhg==
Received: by 10.50.195.165 with SMTP id if5mr892132igc.70.1331949598394;
        Fri, 16 Mar 2012 18:59:58 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id k3sm935039igq.1.2012.03.16.18.59.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:59:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193297>

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
index 0262c7a..ebffd1e 100755
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
 
@@ -176,9 +177,16 @@ if (defined($dirdiff)) {
 		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
 		system("git difftool--helper $a $b");
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

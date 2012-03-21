From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3 8/9] difftool: teach dir-diff to copy modified files back to working tree
Date: Wed, 21 Mar 2012 15:35:57 -0400
Message-ID: <1332358560-13774-3-git-send-email-tim.henigan@gmail.com>
References: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 21 20:36:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARKy-0000QY-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 20:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab2CUTgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 15:36:42 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44144 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab2CUTgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 15:36:41 -0400
Received: by mail-qa0-f53.google.com with SMTP id c11so800804qad.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pdYGu8sBqN9B4H4NwLTeSfW+krek533fEFhiJdv7lxQ=;
        b=0B4UlsEHrBm/RFgxyBjc/1NeYT3Cn0ej2c6mjk2zPs/JD+MTF8ZKEa4+ekapG3nDHs
         9NU+JHDXtcK35Xei9fogkXnrFFbngGNgn7qcgfq13UoVIMWFa0PajStPHM7T684c6RuY
         TtH/PuM5UuWD7pycUZVELoJ1YxUNstvljeCV3pI/DQBE1UcM+RmuCBUs0K2Y12m0U0r2
         HpDDR34hhOGwK44yULNE45hWf7e1wWbOBTobfqCEpZb3riDrjnrgUarquZ5mvheL0ktl
         4lV5cuP8CFkNypd9W/0ObFWgbBIHeSMSm+K4ACILJKmrLWd2RMIYcShLkjOr1qAHHXbO
         O9ww==
Received: by 10.224.106.193 with SMTP id y1mr7470061qao.55.1332358601523;
        Wed, 21 Mar 2012 12:36:41 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id gv7sm4414662qab.5.2012.03.21.12.36.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 12:36:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.39.g6e141f
In-Reply-To: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193603>

If the user runs a diff when there are modified files in the working copy,
they expect to be able to be edit the files in the diff viewer and save
the changes. When using difftool in file mode (i.e. diffing one file at
a time), this works as expected.  However, when using difftool in directory
diff mode, the changes are not saved.

This commit teaches the directory diff mode to copy changes from the diff
viewer back to the working copy.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces patch 8/9 in v2 of the series.

Changed in v3
  - Replaced calls to '$repo->wc_path()' with '$repo->repo_path() . "/.."'
    so that paths are properly handled when 'difftool --dir-diff' is
    called from a subdirectory of the repo.


 git-difftool.perl |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 082e887..9201b89 100755
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
 
@@ -98,7 +99,7 @@ sub setup_dir_diff
 
 	# Changes in the working tree need special treatment since they are
 	# not part of the index
-	my $workdir = $repo->wc_path();
+	my $workdir = $repo->repo_path() . "/..";
 	for (@working_tree) {
 		my $dir = dirname($_);
 		unless (-d "$rdir/$dir") {
@@ -179,9 +180,16 @@ if (defined($dirdiff)) {
 			Git::command_noisy(('difftool--helper', $a, $b))
 		} 'exit code %d';
 	}
-	# TODO: if the diff including working copy files and those
+
+	# If the diff including working copy files and those
 	# files were modified during the diff, then the changes
 	# should be copied back to the working tree
+	my $repo = Git->repository();
+	my $workdir = $repo->repo_path() . "/..";
+	for (@working_tree) {
+		copy("$b/$_", "$workdir/$_") or die $!;
+		chmod(stat("$b/$_")->mode, "$workdir/$_") or die $!;
+	}
 } else {
 	if (defined($prompt)) {
 		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-- 
1.7.10.rc1.39.g6e141f

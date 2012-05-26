From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCHv2 2/3] git-p4: Verify detection of "empty" branch creation
Date: Sat, 26 May 2012 10:56:05 +0100
Message-ID: <1338026166-5462-3-git-send-email-vitor.hda@gmail.com>
References: <1338026166-5462-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 11:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYDjr-00018H-Ev
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 11:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab2EZJ4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 05:56:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63256 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab2EZJ4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 05:56:20 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1036185wey.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JuTjGnKHROYalinWg1LQRoguWwXk9VoNcaqteAxfzW0=;
        b=WYapL9212tn3xhTtjh2Mu7sCNrJXWqlJqQEmQyQdz2bFVghPf/7ISpvVV5kTuz/UYm
         oCMtlrSo5eNdp/0wEc2gO+58Iw/l/u1raLRIjbuWRXaHfKTBrPAolNCzOgujmqNJhwd8
         01/CyYnIUErvObIX9U7+kqDkXvASmSN+Z5I0djDh8CWiy3OPAFHeWo5Uz/ZyR3NNBIeD
         7ZZDQItKKv6VT8jtvU0SRDQOtPFXp1ccJeZNWA/NdaL3On9eWbfcrO0FjDyCKfuQo6Yr
         oLYbHDgj50mlChDequJLCW3PKMDHr7h4KlSZRFiLsKBj0QOWpAErmS0oqqNoitKjMV61
         bEqQ==
Received: by 10.216.227.101 with SMTP id c79mr997901weq.188.1338026180091;
        Sat, 26 May 2012 02:56:20 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id gv4sm5763390wib.8.2012.05.26.02.56.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 02:56:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1338026166-5462-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198547>

Current implementation of new branch parent detection works on the
principle that the new branch is a complete integration, with no
changes, of the original files.
This test shows this deficiency in the particular case when the new
branch is created from a subset of the original files.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 0ae8607..308b123 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -358,6 +358,60 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
 	)
 '
 
+# Create a branch by integrating a single file
+test_expect_success 'git p4 file subset branch' '
+	(
+		cd "$cli" &&
+		p4 integrate //depot/branch1/file1 //depot/branch6/file1 &&
+		p4 submit -d "Integrate file1 alone from branch1 to branch6"
+	)
+'
+
+# Check if git p4 creates a new branch containing a single file,
+# instead of keeping the old files from the original branch
+test_expect_failure 'git p4 clone file subset branch' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		git config --add git-p4.branchList branch1:branch4 &&
+		git config --add git-p4.branchList branch1:branch5 &&
+		git config --add git-p4.branchList branch1:branch6 &&
+		git p4 clone --dest=. --detect-branches //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch1 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		grep update file2 &&
+		git reset --hard p4/depot/branch2 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_missing file3 &&
+		! grep update file2 &&
+		git reset --hard p4/depot/branch3 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_missing file3 &&
+		grep update file2 &&
+		git reset --hard p4/depot/branch4 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		! grep update file2 &&
+		git reset --hard p4/depot/branch5 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		! grep update file2 &&
+		git reset --hard p4/depot/branch6 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_missing file3
+	)
+'
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.7.rc2.14.g5e044.dirty

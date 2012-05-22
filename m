From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/2] git-p4: Verify detection of "empty" branch creation
Date: Wed, 23 May 2012 00:38:11 +0100
Message-ID: <1337729891-27648-3-git-send-email-vitor.hda@gmail.com>
References: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 01:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWyfA-0006Jp-H0
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 01:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831Ab2EVXio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 19:38:44 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41070 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724Ab2EVXin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 19:38:43 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn6so4034207wib.1
        for <git@vger.kernel.org>; Tue, 22 May 2012 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9y9ZPcdsVgODYsEKZkOV1oMkG2hpbng/xtB/FZwtwvw=;
        b=UbvTHuY0qgymiuQQPa8shio6gNo4yZOY4o6gqBGldID5z26BFE1+rrmjHcIoDadOzz
         HqrgSseGlKl4OM5AA/Uu+zz0xTl0WOyGZkVMDlY17ncbOVD1ByE/MkcZ4BNG9MCR4p4X
         4035MPtDlR2tbc18sWrie0V6NVfVBINksYfIubQRq6qPEmG0A9wiOFsJveFyj+68tuyx
         UeoqHAEhlg8q82DTnN+nXtwvUt+6GzE7rsGLgLP7hLz7+ckNyq44fToeyjkQdSAkZbzX
         BgLYJHGHAXdNVkISZcGS3ChRKviIB+kUvDXmWVsGuaaR5c1hFA8ht9jHHsxIgkxKaMze
         yShQ==
Received: by 10.180.95.137 with SMTP id dk9mr30303154wib.1.1337729922730;
        Tue, 22 May 2012 16:38:42 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id r2sm56922565wif.7.2012.05.22.16.38.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 16:38:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198268>

Current implementation of new branch parent detection works on the
principle that the new branch is a complete integration, with no
changes, of the original files.
This test shows this deficiency in the particular case when the new
branch is created from a subset of the original files.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 89d8c59..c8e4d86 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -360,6 +360,62 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
 	)
 '
 
+# Create a branch by integrating a single file
+test_expect_success 'git p4 file subset branch' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$cli" &&
+		p4 integrate //depot/branch1/file1 //depot/branch6/file1 &&
+		p4 submit -d "Integrate file1 alone from branch1 to branch6"
+	)
+'
+
+# Check if git -p4 creates a new branch containing a single file,
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
+		"$GITP4" clone --dest=. --detect-branches //depot@all &&
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
+		! test_path_is_file file2 &&
+		! test_path_is_file file3
+	)
+'
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.7.rc2.14.g5e044.dirty

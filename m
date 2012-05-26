From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCHv2 1/3] git-p4: Test changelists touching two branches
Date: Sat, 26 May 2012 10:56:04 +0100
Message-ID: <1338026166-5462-2-git-send-email-vitor.hda@gmail.com>
References: <1338026166-5462-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 11:57:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYDk2-0001d6-H3
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 11:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab2EZJ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 05:56:44 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58274 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab2EZJ4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 05:56:20 -0400
Received: by weyu7 with SMTP id u7so1036189wey.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K1kvyXmM2HM4w0+S21zGebbIKx286YKnK5qNAyXu2LQ=;
        b=MXt4m0KvpycyLcdlpf2lSQJlbRQ0iNTL/q95FM3aX2SbzhAVdqAGgeQMibpF6kvC52
         WB7YyZ9ND9ui9AxMn3J7G4cibJnKvk6IEVWK/Zb6cEBznIwro9o3F6lTCMh55SyeWA0W
         Mpmw4pPLld5MWqUL1dt4PBwmOKBgLylzMhDRQo+3z/oNTI6Ncz2E/2vweWon+3CMqr+N
         4G74kxC/zjgT++Uh7Mi+dq0wnhxXutdfgxtLIeLvJEVuBM1BIoLUSf135WO2oNe1DLQy
         +DAGP2ajxN7J8sLDFN/LVrjD+MocN0cYvWKsXZ/nB2gCKza4d3ClCWcBdMe1Il2rz6iH
         uOCg==
Received: by 10.216.135.204 with SMTP id u54mr1035572wei.40.1338026179017;
        Sat, 26 May 2012 02:56:19 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id gv4sm5763390wib.8.2012.05.26.02.56.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 02:56:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1338026166-5462-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198548>

It is possible to modify two different branches in P4 in a single
changelist. git-p4 correctly detects this and commits the relevant
changes to the different branches separately. This test proves that and
avoid future regressions in this behavior.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 2859256..0ae8607 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -306,6 +306,58 @@ test_expect_success 'git p4 clone complex branches' '
 	)
 '
 
+# Move branch3/file3 to branch4/file3 in a single changelist
+test_expect_success 'git p4 submit to two branches in a single changelist' '
+	(
+		cd "$cli" &&
+		p4 integrate //depot/branch3/file3 //depot/branch4/file3 &&
+		p4 delete //depot/branch3/file3 &&
+		p4 submit -d "Move branch3/file3 to branch4/file3"
+	)
+'
+
+# Confirm that changes to two branches done in a single changelist
+# are correctly imported by git p4
+test_expect_success 'git p4 sync changes to two branches in the same changelist' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		git config --add git-p4.branchList branch1:branch4 &&
+		git config --add git-p4.branchList branch1:branch5 &&
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
+		test_path_is_missing .git/git-p4-tmp
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.7.rc2.14.g5e044.dirty

From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/2] git-p4: Test changelists touching two branches
Date: Wed, 23 May 2012 00:38:10 +0100
Message-ID: <1337729891-27648-2-git-send-email-vitor.hda@gmail.com>
References: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 01:38:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWyf3-0006A5-Le
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 01:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823Ab2EVXih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 19:38:37 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:51585 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724Ab2EVXih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 19:38:37 -0400
Received: by weyu7 with SMTP id u7so4225088wey.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mkK8snAOC9Sc0odAkieWKj7LIC5loXFLw4CUmj+FxAo=;
        b=nqRduXB/Jcst2sy27B4eWgMwK9E/BjMCGawAObppsVsMl/X8BeC/B0IYBAkPnXNj67
         j3bTalhOJA6uPmxNpjhPXniCT4xrlMw2h8xRtvgz6kmwUdoJZfk9jw/1WN7524l7LgqM
         efXDoWiYpSWpXCdIFKX70Wezt6tLESO/uQa6g/uWF4BI4ImkoHWMkIwyWBLyaOt2iHMf
         S4G66lu6+nB1WTLhPhiBl2ehIKz0EiNazgD7Chhv7SL8VvlMdgIYLwRQkqv79qbv2L77
         /KfZYa6V1JPfVZBz32UO+8BuusipD83llsR4FwrzIW+QKxIvi0FZ9+s773Yd8nOljm7X
         eJmQ==
Received: by 10.180.75.241 with SMTP id f17mr39459802wiw.11.1337729915748;
        Tue, 22 May 2012 16:38:35 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id r2sm56922565wif.7.2012.05.22.16.38.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 16:38:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198267>

It is possible to modify two different branches in P4 in a single
changelist. git-p4 correctly detects this and commits the relevant
changes to the different branches separately. This test proves that and
avoid future regressions in this behavior.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 2859256..89d8c59 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -306,6 +306,60 @@ test_expect_success 'git p4 clone complex branches' '
 	)
 '
 
+# Move branch3/file3 to branch4/file3 in a single changelist
+test_expect_success 'git p4 submit to two branches in a single changelist' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
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

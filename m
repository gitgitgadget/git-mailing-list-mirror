From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] git p4 test: Check ignore files with client spec
Date: Fri, 19 Jul 2013 00:04:53 +0100
Message-ID: <1374188693-547-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 01:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzxGk-0005s6-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 01:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934562Ab3GRXFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 19:05:50 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:58886 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749Ab3GRXFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 19:05:49 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so7316wgg.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Dp2W43XxyCLxgKDRosuqqT6ZTsP8gnd0mSjx+wYMoBM=;
        b=ZJ9AeDiYKb6WsuT1Sr/ldzE5LGj/TvdI/ZA/09jBYdy3I1Hvy5JavP3RDOiGbIxmGp
         VcK7hYlmnPhdGm9trJiRqwYXXscI6D2A4Ftjw+H7EWkSvJOKIZeQGB7aXCmd80KhSNrK
         9Ck20Q88VXu1apCPWgaXHXnefGY5m4Ux8+xr4kxWHki/w26O3CXN+468xm2uHGaqrCcL
         GuTi4v3UUPTPQbcYySCei4xZfA2V+RVwm7SrSlmlRBNGyLJBGW1xa/YivRg5BvXK/rZ3
         XTuTvPyqinY08Y7EbAsTZSvzGtCLAfM+SeOjdZmc2GBcnzVsxJ2bugcFHELOI/DasNcm
         gRyQ==
X-Received: by 10.180.80.6 with SMTP id n6mr21081503wix.59.1374188747786;
        Thu, 18 Jul 2013 16:05:47 -0700 (PDT)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPSA id fs8sm44966529wib.0.2013.07.18.16.05.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 16:05:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230763>

This test confirms that a file can be ignored during git p4 sync if if is
excluded in P4 client specification.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 9730821..2bf142d 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -469,9 +469,11 @@ test_expect_success 'use-client-spec detect-branches skips branches setup' '
 		View: //depot/usecs/b1/... //depot/usecs/b3/...
 		EOF
 
-		echo b3/b3-file3 >b3/b3-file3 &&
-		p4 add b3/b3-file3 &&
-		p4 submit -d "b3/b3-file3"
+		echo b3/b3-file3_1 >b3/b3-file3_1 &&
+		echo b3/b3-file3_2 >b3/b3-file3_2 &&
+		p4 add b3/b3-file3_1 &&
+		p4 add b3/b3-file3_2 &&
+		p4 submit -d "b3/b3-file3_1 b3/b3-file3_2"
 	)
 '
 
@@ -487,6 +489,21 @@ test_expect_success 'use-client-spec detect-branches skips branches' '
 	)
 '
 
+test_expect_success 'use-client-spec detect-branches skips files in branches' '
+	client_view "//depot/usecs/... //client/..." \
+		    "-//depot/usecs/b3/b3-file3_1 //client/b3/b3-file3_1" &&
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
+		git checkout -b master p4/usecs/b3 &&
+		test_path_is_file b1-file1 &&
+		test_path_is_file b3-file3_2 &&
+		test_path_is_missing b3-file3_1
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.3.2

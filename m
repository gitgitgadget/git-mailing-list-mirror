From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 8/9] bisect: add tests for --ignore-checkout-failure option.
Date: Sun, 24 Jul 2011 15:57:53 +1000
Message-ID: <1311487074-25070-9-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkri0-0007mm-5V
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab1GXF6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:32 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab1GXF60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:26 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4UfKiK+/Ty3pUKtB/UsyG7Kn2B6tR2TEMaremCr3P1I=;
        b=JOijdCFrvJssWfOMY4BKRP1BoufitzavuQvYUeOP3mMh1Sowm69AqyF6amdSf4AFsE
         eaM4FEsYYZblFnnuY22DXElvRwp/0C7YJpQljrRA1yumLn7hXPDZhsOzQlCPjf4+klRk
         iLtJk2tNenslao3JzbSolMwaqgXXnsBxpxYVI=
Received: by 10.68.4.71 with SMTP id i7mr5590529pbi.21.1311487106676;
        Sat, 23 Jul 2011 22:58:26 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177724>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   69 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2c14fb0..32fb434 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -624,4 +624,73 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
         test_cmp expected.missing-tree.default error.txt
 '
 
+test_expect_success 'bisect: --ignore-checkout-failure - start commit bad' '
+        git bisect reset &&
+        git bisect start $BROKEN_HASH7 $HASH4 --ignore-checkout-failure 2>error.txt
+        test_cmp expected.missing-tree.ignored error.txt &&
+        broken6=$(git rev-parse HEAD) &&
+        test "$broken6" = "$BROKEN_HASH6" &&
+        git bisect reset
+'
+
+test_expect_success 'bisect: --ignore-checkout-failure - trial commit bad' '
+        git bisect reset &&
+        git bisect start broken $HASH4 --ignore-checkout-failure 2>error.txt
+        test_cmp expected.missing-tree.ignored error.txt &&
+        broken6=$(git rev-parse HEAD) &&
+        test "$broken6" = "$BROKEN_HASH6" &&
+        git bisect reset
+'
+
+test_expect_success 'bisect: --ignore-checkout-failure - target before breakage' '
+        git bisect reset &&
+        git bisect start broken $HASH4 --ignore-checkout-failure 2>error.txt
+        test_cmp expected.missing-tree.ignored error.txt &&
+        broken6=$(git rev-parse HEAD) &&
+        test "$broken6" = "$BROKEN_HASH6" &&
+        git bisect bad HEAD &&
+        broken5=$(git rev-parse HEAD) &&
+        test "$broken5" = "$BROKEN_HASH5" &&
+        git bisect bad HEAD > my_bisect_log.txt &&
+        broken4=$(git rev-parse HEAD) &&
+        test "$broken4" = "$HASH4" &&
+        echo "$BROKEN_HASH5 is the first bad commit" > expected.txt &&
+        test_cmp expected.txt my_bisect_log.txt
+        git bisect reset
+'
+
+test_expect_success 'bisect: --ignore-checkout-failure - target in breakage' '
+        git bisect reset &&
+        git bisect start broken $HASH4 --ignore-checkout-failure 2>error.txt
+        test_cmp expected.missing-tree.ignored error.txt &&
+        broken6=$(git rev-parse HEAD) &&
+        test "$broken6" = "$BROKEN_HASH6" &&
+        git bisect bad HEAD &&
+        broken5=$(git rev-parse HEAD) &&
+        test "$broken5" = "$BROKEN_HASH5" &&
+        git bisect good HEAD > my_bisect_log.txt &&
+        broken6=$(git rev-parse HEAD) &&
+        test "$broken6" = "$BROKEN_HASH6" &&
+        echo "$BROKEN_HASH6 is the first bad commit" > expected.txt &&
+        test_cmp expected.txt my_bisect_log.txt
+        git bisect reset
+'
+
+test_expect_success 'bisect: --ignore-checkout-failure - target after breakage' '
+        git bisect reset &&
+        git bisect start broken $HASH4 --ignore-checkout-failure 2>error.txt
+        test_cmp expected.missing-tree.ignored error.txt &&
+        broken6=$(git rev-parse HEAD) &&
+        test "$broken6" = "$BROKEN_HASH6" &&
+        git bisect good HEAD &&
+        broken8=$(git rev-parse HEAD) &&
+        test "$broken8" = "$BROKEN_HASH8" &&
+        git bisect good HEAD > my_bisect_log.txt &&
+        broken9=$(git rev-parse HEAD) &&
+        test "$broken9" = "$BROKEN_HASH9" &&
+        echo "$BROKEN_HASH9 is the first bad commit" > expected.txt &&
+        test_cmp expected.txt my_bisect_log.txt
+        git bisect reset
+'
+
 test_done
-- 
1.7.6.347.g96e0b.dirty

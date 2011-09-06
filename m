From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v2 5/5] t5710: add testcase for multi-level relative alternates
Date: Tue, 6 Sep 2011 18:24:05 +0800
Message-ID: <1315304645-12009-6-git-send-email-Hui.Wang@windriver.com>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-4-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-5-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:24:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0sp6-0003wz-Fb
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab1IFKYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:24:06 -0400
Received: from mail.windriver.com ([147.11.1.11]:61496 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab1IFKYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:24:04 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p86ANwGg005041
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Sep 2011 03:23:58 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Tue, 6 Sep 2011 03:23:57 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1315304645-12009-5-git-send-email-Hui.Wang@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180788>

From: Hui Wang <Hui.Wang@windriver.com>

Since we removed "relative alternates only possible for current dir"
limitation, it is needed to change an existing testcase to make it
pass for the relative path at the second level alternates.

Add a new testcase to make it pass when it work at a 5-level relative
alternates repository and make it fail when it work at a 6-level
relative alternates repository.

Signed-off-by: Hui Wang <Hui.Wang@windriver.com>
---
 t/t5710-info-alternate.sh |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index ef7127c..a606a94 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -102,9 +102,26 @@ test_valid_repo'
 cd "$base_dir"
 
 test_expect_success \
-    'that relative alternate is only possible for current dir' '
+    'that relative alternate is possible for none current dir' '
     cd D &&
-    ! (test_valid_repo)
+    test_valid_repo
+'
+
+cd "$base_dir"
+
+test_expect_success 'allow maxium 5 level relative alternate' \
+'echo "" > A/.git/objects/info/alternates &&
+echo "../../../A/.git/objects" > B/.git/objects/info/alternates &&
+echo "../../../B/.git/objects" > C/.git/objects/info/alternates &&
+echo "../../../C/.git/objects" > D/.git/objects/info/alternates &&
+echo "../../../D/.git/objects" > E/.git/objects/info/alternates &&
+echo "../../../E/.git/objects" > F/.git/objects/info/alternates &&
+echo "../../../F/.git/objects" > G/.git/objects/info/alternates &&
+cd F &&
+test_valid_repo &&
+cd ../G &&
+git fsck --full > fsck.err 2>&1 &&
+test `wc -l < fsck.err` != 0
 '
 
 cd "$base_dir"
-- 
1.6.3.1

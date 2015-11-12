From: larsxschneider@gmail.com
Subject: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Thu, 12 Nov 2015 10:37:41 +0100
Message-ID: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
Cc: sbeller@google.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 10:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwoKF-0007fR-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 10:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbbKLJhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 04:37:46 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36410 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbbKLJhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 04:37:43 -0500
Received: by wmww144 with SMTP id w144so192343071wmw.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 01:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pNy4TFfA+/RaY0xw7ybT/pdsVwg3PafWJYv3elj7dug=;
        b=mi6jYDs7jRStHf+M6uBdvZzIAnXAq9jgz5qq67bXdLJLqQ5gMdGM8vStwZfgIYqjud
         ls5P/retOalIM+HaEZ0NAUmic1iM0XrdIScX2kSceS3Q9bRvzzIt6M1PUFPvda0XsESi
         SCIw0uktKSm8k1kArbaTEdCUi/64bxiNBEyw5N/Kv/zU05c5ZZ593dc8OmiYyN6A89M0
         RcOZG+TNN9SZMCGXFbed699SIMNCSRZ01ZrZnOqTGvfF2KHFT0yuAQdHGwCV25V/Z5Xx
         ZaZA7QQAi8rd4SDXfhCFf4WF4fi66/1+15h24mbJaakfhXapOvsD9mz7V09yZS52vukb
         Nt0Q==
X-Received: by 10.194.203.106 with SMTP id kp10mr15364303wjc.86.1447321062533;
        Thu, 12 Nov 2015 01:37:42 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB6E5E.dip0.t-ipconnect.de. [93.219.110.94])
        by smtp.gmail.com with ESMTPSA id om1sm13470872wjc.2.2015.11.12.01.37.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Nov 2015 01:37:41 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281214>

From: Lars Schneider <larsxschneider@gmail.com>

"git clone --recursive --depth 1 --single-branch <url>" clones the
submodules successfully. However, it does not obey "--depth 1" for
submodule cloning.

The following workaround does only work if the used submodule pointer
is on the default branch. Otherwise "git submodule update" fails with
"fatal: reference is not a tree:" and "Unable to checkout".
git clone --depth 1 --single-branch <url>
cd <repo-name>
git submodule update --init --recursive --depth 1

The workaround does not fail using the "--remote" flag. However, in that
case the wrong commit is checked out.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t7412-submodule-recursive.sh | 78 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 t/t7412-submodule-recursive.sh

diff --git a/t/t7412-submodule-recursive.sh b/t/t7412-submodule-recursive.sh
new file mode 100755
index 0000000..aaf252b
--- /dev/null
+++ b/t/t7412-submodule-recursive.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='Test shallow cloning of repos with submodules'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git checkout -b master &&
+	echo file >file &&
+	git add file &&
+	test_tick &&
+	git commit -m "master commit 1" &&
+
+	git checkout -b branch &&
+	echo file >branch-file &&
+	git add branch-file &&
+	test_tick &&
+	git commit -m "branch commit 1" &&
+
+	git checkout master &&
+	git clone . repo &&
+	(
+		cd repo &&
+		git checkout master &&
+		git submodule add ../. submodule &&
+		(
+			cd submodule &&
+			git checkout branch
+		) &&
+		git add submodule &&
+		test_tick &&
+		git commit -m "master commit 2"
+	)
+'
+
+test_expect_failure shallow-clone-recursive '
+	URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
+	echo $URL &&
+	git clone --recursive --depth 1 --single-branch $URL clone-recursive &&
+	(
+		cd "clone-recursive" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	) &&
+	(
+		cd "clone-recursive/submodule" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_expect_failure shallow-clone-recursive-workaround '
+	URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
+	echo $URL &&
+	git clone --depth 1 --single-branch $URL clone-recursive-workaround &&
+	(
+		cd "clone-recursive-workaround" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines &&
+		git submodule update --init --recursive --depth 1
+	)
+'
+
+test_expect_failure shallow-clone-recursive-with-remote-workaround '
+	URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
+	echo $URL &&
+	git clone --depth 1 --single-branch $URL clone-recursive-remote-workaround &&
+	(
+		cd "clone-recursive-remote-workaround" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines &&
+		git submodule update --init --remote --recursive --depth 1 &&
+		git status submodule >status &&
+		test_must_fail grep "modified:" status
+	)
+'
+
+test_done
-- 
2.5.1

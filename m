From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [BUG/TEST 1/2] t3501: Expose bug with cherry-pick into dirty trees w/ renames
Date: Mon, 11 Feb 2013 20:27:41 -0800
Message-ID: <1360643262-1472-2-git-send-email-sboyd@codeaurora.org>
References: <1360643262-1472-1-git-send-email-sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 05:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U57Tf-00032p-52
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 05:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760418Ab3BLE1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 23:27:47 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:14328 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab3BLE1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 23:27:45 -0500
X-IronPort-AV: E=Sophos;i="4.84,647,1355126400"; 
   d="scan'208";a="24933590"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Feb 2013 20:27:45 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 607D610004D7
	for <git@vger.kernel.org>; Mon, 11 Feb 2013 20:27:45 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.566.gaa39828
In-Reply-To: <1360643262-1472-1-git-send-email-sboyd@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216118>

I encountered this bug while doing some cherry-picking into a
dirty tree. In this case, the working tree was dirty with some
changes to a file that had been renamed. The change I wanted to
cherry-pick was made along another branch before the rename and
it matched a subset of my working tree modulo the file rename.
When I cherry-picked the change from the other branch without the
rename to my current branch with the rename, the change applied
cleanly and the dirty bits were committed but the other dirty
bits in the file were lost. Make this into a test to expose this
bug.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 t/t3501-revert-cherry-pick.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 6f489e2..eef4d8c 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -109,4 +109,32 @@ test_expect_success 'chery-pick on unborn branch' '
 	! test_cmp_rev initial HEAD
 '
 
+test_expect_success 'cherry-pick on dirty rename should stay dirty' '
+	git checkout initial &&
+
+	for l in b c d e f g h i j k l m n o
+	do
+		echo $l$l$l$l$l$l$l$l$l
+	done >oops &&
+
+	test_tick &&
+	git add oops &&
+	git commit -m drop &&
+	git tag drop &&
+
+	git checkout initial &&
+	test_tick &&
+	git mv oops spoo &&
+	git commit -m rename3 &&
+	git tag rename3 &&
+
+	for l in b c d e f g h i j k m n o
+	do
+		echo $l$l$l$l$l$l$l$l$l
+	done >spoo &&
+
+	git cherry-pick drop &&
+	! git diff --quiet
+'
+
 test_done
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

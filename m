From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [BUG/TEST 2/2] t3501: Expose addinfo_cache error message in cherry-pick
Date: Mon, 11 Feb 2013 20:27:42 -0800
Message-ID: <1360643262-1472-3-git-send-email-sboyd@codeaurora.org>
References: <1360643262-1472-1-git-send-email-sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 05:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U57TW-0002gW-R5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 05:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760519Ab3BLE1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 23:27:47 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:3441 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760247Ab3BLE1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 23:27:46 -0500
X-IronPort-AV: E=Sophos;i="4.84,647,1355126400"; 
   d="scan'208";a="25120107"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Feb 2013 20:27:45 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 8D52310004B6
	for <git@vger.kernel.org>; Mon, 11 Feb 2013 20:27:45 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.566.gaa39828
In-Reply-To: <1360643262-1472-1-git-send-email-sboyd@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216116>

I encountered a mysterious error message while doing some
cherry-picking into a dirty tree. In this case, the working tree
was dirty with changes to two files that had been renamed, we'll
call them 'file and 'otherfile'. The change I wanted to
cherry-pick was made along a branch before the rename to 'file'.
When I cherry-picked the change from the other branch without the
rename to my current branch with the rename, the change applied
cleanly and the dirty bits were committed but a mysterious error
message was printed indicating something went wrong with the file
that was still dirty after the cherry-pick.

	error: addinfo_cache failed for path 'otherfile'

I suspect this error message shouldn't be printed, so recreate
the problem in t3501 so that it can be fixed.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 t/t3501-revert-cherry-pick.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index eef4d8c..522a9fd 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -137,4 +137,36 @@ test_expect_success 'cherry-pick on dirty rename should stay dirty' '
 	! git diff --quiet
 '
 
+test_expect_success 'cherry-pick on dirty rename should not complain' '
+	git checkout initial &&
+
+	test_commit file1
+
+	for l in b c d e f g h i j k l m n o
+	do
+		echo $l$l$l$l$l$l$l$l$l
+	done >oops &&
+
+	test_tick &&
+	git add oops &&
+	git commit -m drop2 &&
+	git tag drop2 &&
+
+	git checkout file1 &&
+	test_tick &&
+	git mv oops spoo &&
+	git mv file1.t file2.t &&
+	git commit -m rename4 &&
+	git tag rename4 &&
+
+	echo file2 > file2.t &&
+	for l in b c d e f g h i j k m n o
+	do
+		echo $l$l$l$l$l$l$l$l$l
+	done >spoo &&
+
+	git cherry-pick drop2 2> errors &&
+	! test -s errors
+'
+
 test_done
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v3 2/2] Added tests for reset -
Date: Tue, 10 Mar 2015 16:22:08 +0530
Message-ID: <1425984728-27996-2-git-send-email-sudshekhar02@gmail.com>
References: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, davvid@gmail.com,
	sunshine@sunshineco.com, Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 11:53:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVHmb-00035k-K8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 11:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbbCJKxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 06:53:00 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44245 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbCJKw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 06:52:59 -0400
Received: by padet14 with SMTP id et14so810976pad.11
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O/717FrcnCpTrON351qZQsMLC9F4D6oAF23o5n5c0rc=;
        b=KGqYp1S6gu4pkaM8/zzaa24FF00APfR07f4YjFHVXmFA0qfCWMGMXX9UIStrAP5VSu
         Wui47FsKjnAwnFOEpjwstOsu2F+vuH5hHCq5e10mOkBZGmk5Xb5baZk/4N2Ijmz9CjTK
         5ZB+V/OTAZ3Vu1QmQ9zoIWcqgr8p2eBdeD65UudZBYUkv2BQJHD4vfwHIb4gB/9CEOy0
         qgq+tULh5S04oi3HL95rKXdpIoYsQAIPXWh82ogS3nrqj45vlEakpinRdp5Lqtbpb0Ab
         NkTEXPjJZJkAOVihl0P3OJMUqPVqtG9cvVpIjXrbLdYs/6JqXyvyodF0jumxiJrD3Yy4
         3ypw==
X-Received: by 10.66.66.230 with SMTP id i6mr64005783pat.108.1425984778756;
        Tue, 10 Mar 2015 03:52:58 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id um16sm453888pab.7.2015.03.10.03.52.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2015 03:52:57 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.279.gd534259
In-Reply-To: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265227>

Added the following test cases:
    1) Confirm error message when git reset is used with no previous branch
    2) Confirm git reset - works like git reset @{-1}
    3) Confirm "-" is always treated as a commit unless the -- file option
    is specified
    4) Confirm "git reset -" works normally even when a file named @{-1} is
    present

Helped-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
I have tried to keep each test self sufficient. Please let me know if any changes are required.
Thank you!

 t/t7102-reset.sh | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..0faf241 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,143 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset - with no previous branch' '
+	git init no_previous &&
+	(
+		cd no_previous &&
+		test_must_fail git reset - 2>output
+	) &&
+	test_i18ngrep "bad flag" no_previous/output
+'
+
+test_expect_success 'reset - while having file named - and no previous branch' '
+	git init no_previous &&
+	(
+		cd no_previous &&
+		>./- &&
+		test_must_fail git reset - 2>output
+	) &&
+	test_i18ngrep "bad flag" no_previous/output
+'
+
+
+test_expect_success 'reset - in the presence of file named - with previous branch' '
+	echo "Unstaged changes after reset:" >expect &&
+	echo "M	-" >>expect &&
+	echo "M	1" >>expect &&
+	git init no_previous &&
+	(
+		cd no_previous &&
+		>./- &&
+		>1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset - >../output
+	) &&
+	rm -rf no_previous &&
+	test_cmp output expect
+'
+test_expect_success 'reset - in the presence of file named - with -- option' '
+	echo "Unstaged changes after reset:" >expect &&
+	echo "M	-" >>expect &&
+	echo "M	1" >>expect &&
+	git init no_previous &&
+	(
+		cd no_previous &&
+		>./- &&
+		>1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset - -- >../output
+	) &&
+	rm -rf no_previous &&
+	test_cmp output expect
+'
+
+test_expect_success 'reset - in the presence of file named - with -- file option' '
+	echo "Unstaged changes after reset:" >expect &&
+	echo "M	-" >>expect &&
+	git init no_previous &&
+	(
+		cd no_previous &&
+		>./- &&
+		>1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset -- - >../output
+	) &&
+	rm -rf no_previous
+	test_cmp output expect
+'
+test_expect_success 'reset - in the presence of file named - with both pre and post -- option' '
+	echo "Unstaged changes after reset:" >expect &&
+	echo "M	-" >>expect &&
+	git init no_previous &&
+	(
+		cd no_previous &&
+		>./- &&
+		>1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset - -- - >../output
+	) &&
+	rm -rf no_previous
+	test_cmp output expect
+'
+
+test_expect_success 'reset - works same as reset @{-1}' '
+	git init no_previous &&
+	(
+		cd no_previous &&
+		echo "random" >random &&
+		git add random &&
+		git commit -m "base commit" &&
+		git checkout -b temp &&
+		echo new-file >new-file &&
+		git add new-file &&
+		git commit -m "added new-file" &&
+		git reset - &&
+		git status --porcelain >../first &&
+		git add new-file &&
+		git commit -m "added new-file" &&
+		git reset @{-1} &&
+		git status --porcelain >../second
+	) &&
+	test_cmp first second
+'
+
+test_expect_success 'reset - with file named @{-1}' '
+	echo "Unstaged changes after reset:" >expect &&
+	echo "M	@{-1}" >>expect &&
+	git init no_previous &&
+	(
+		cd no_previous &&
+		echo "random" >./@{-1} &&
+		git add ./@{-1} &&
+		git commit -m "base commit" &&
+		git checkout -b new_branch &&
+		echo "additional stuff" >>./@{-1} &&
+		git add ./@{-1} &&
+		git reset - >../output
+	) &&
+	rm -rf no_previous &&
+	test_cmp output expect
+'
+
 test_done
-- 
2.3.1.279.gd534259

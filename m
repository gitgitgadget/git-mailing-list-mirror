From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/6] am --skip: revert changes introduced by failed 3way merge
Date: Sat,  6 Jun 2015 19:46:07 +0800
Message-ID: <1433591172-27077-2-git-send-email-pyokagan@gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 13:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CYb-00053Q-RX
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbbFFLq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:46:29 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35905 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbbFFLq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:46:27 -0400
Received: by pdjm12 with SMTP id m12so69765223pdj.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fUniDFdM/gsGaIGscT7FE59GRGY3UaDvxRINLFrUuZA=;
        b=lOtKdeOG4YZdhW/arsMKjCl6aVxYmE54tu4lyQPY5apr/NnXj0vhYyMw8hoR3P3uA8
         6jSHVEUoyZm+gCcSKS5Pmn85eAhDaYq/FKfjNShszinwphlnP3g+X5DtLB1SRMtWEyL9
         xjvA26hEiu2TDMeJZkjDy9lvEvYN0qG1IIH8Sy26WOV02Yl7gIJyE5j6HfbrTu0AgWvJ
         tBUOqupRXLbwca1bOFl8qzm3XWMZQpQEKXFsXNPR/U5wf1mFVJ0NwqzWwgub8Emp9J2A
         bCho4crqZFy7rL961JWH4RdMQH6VVXI57u1HVXUjfzDT/n4xQFkhx7ObUvpoDes8jdc4
         VEFQ==
X-Received: by 10.66.141.176 with SMTP id rp16mr13438441pab.137.1433591186650;
        Sat, 06 Jun 2015 04:46:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id on3sm9344587pbc.69.2015.06.06.04.46.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 04:46:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270916>

Even when a merge conflict occurs with am --3way, the index will be
modified with the results of any succesfully merged files (such as a new
file). These changes to the index will not be reverted with a
"git read-tree --reset -u HEAD HEAD", as git read-tree will not be aware
of how the current index differs from HEAD.

To fix this, we first reset any conflicting entries from the index. The
resulting index will contain the results of successfully merged files.
We write the index to a tree, then use git read-tree -m to fast-forward
the "index tree" back to HEAD, thus undoing all the changes from the
failed merge.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh           |  7 ++++++-
 t/t4151-am-abort.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 761befb..df3c8f4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -69,6 +69,8 @@ then
 	cmdline="$cmdline -3"
 fi
 
+empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+
 sq () {
 	git rev-parse --sq-quote "$@"
 }
@@ -502,7 +504,10 @@ then
 		;;
 	t,)
 		git rerere clear
-		git read-tree --reset -u HEAD HEAD
+		head_tree=$(git rev-parse --verify -q HEAD || echo $empty_tree) &&
+		git read-tree --reset -u $head_tree $head_tree &&
+		index_tree=$(git write-tree) &&
+		git read-tree -m -u $index_tree $head_tree
 		orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
 		git reset HEAD
 		git update-ref ORIG_HEAD $orig_head
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 8d90634..e15acc8 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -63,6 +63,17 @@ do
 
 done
 
+test_expect_success 'am -3 --skip removes otherfile-4' '
+	git reset --hard initial &&
+	test_must_fail git am -3 0003-*.patch &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 4 = "$(cat otherfile-4)" &&
+	git am --skip &&
+	test_cmp_rev initial HEAD &&
+	test -z $(git ls-files -u) &&
+	test_path_is_missing otherfile-4
+'
+
 test_expect_success 'am --abort will keep the local commits intact' '
 	test_must_fail git am 0004-*.patch &&
 	test_commit unrelated &&
-- 
2.1.4

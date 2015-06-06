From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/6] am -3: support 3way merge on unborn branch
Date: Sat,  6 Jun 2015 19:46:08 +0800
Message-ID: <1433591172-27077-3-git-send-email-pyokagan@gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 13:46:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CYe-00056t-Of
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbbFFLqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:46:33 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33120 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbbFFLqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:46:31 -0400
Received: by padev16 with SMTP id ev16so8266290pad.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/lcMTKNd/wBnkIfPj4KS6r2cAM8L3wctd6YoopJ+tE=;
        b=T9nIt8uxgxRDJHGqyCs5CZuN6ZQaK5gM8VeGUz/IOdl79fUjGDwblPC5XCKAB9mRU3
         dzqGuwKsrTHq2LrbS3D92zHjVRluHiGFmWL+AcpgseQCzyhuMjU2DvnMOnMCUiREXNTR
         O872H/oXB/2t+m7qbLfQVi+AdKjL6HizhOKwyZqtiIRu5qPkcSWu+7UOSVKx18B+7qx3
         +Dc+frCuBc2UxTr57xXGovdPa+h80d6V34pVI9z0wNj/uh+mBBrLpjtTbfRNi3ecOJt+
         5f/O0g07emCjxfETTjsArRhu68o+pgSR+XsrEPOSE2T9HI0sjvTYPB027QeRTepKkRIR
         4Y2g==
X-Received: by 10.66.121.101 with SMTP id lj5mr13399886pab.113.1433591190117;
        Sat, 06 Jun 2015 04:46:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id on3sm9344587pbc.69.2015.06.06.04.46.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 04:46:28 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270917>

While on an unborn branch, git am -3 will fail to do a threeway merge as
it references HEAD as "our tree", but HEAD does not point to a valid
tree.

Fix this by using an empty tree as "our tree" when we are on an unborn
branch.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh           | 3 ++-
 t/t4151-am-abort.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index df3c8f4..c847b58 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -179,7 +179,8 @@ It does not apply to blobs recorded in its index.")"
     then
 	    GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
     fi
-    git-merge-recursive $orig_tree -- HEAD $his_tree || {
+    our_tree=$(git rev-parse --verify -q HEAD || echo $empty_tree)
+    git-merge-recursive $orig_tree -- $our_tree $his_tree || {
 	    git rerere $allow_rerere_autoupdate
 	    die "$(gettext "Failed to merge in the changes.")"
     }
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index e15acc8..b618ee0 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -83,4 +83,13 @@ test_expect_success 'am --abort will keep the local commits intact' '
 	test_cmp expect actual
 '
 
+test_expect_success 'am -3 stops on conflict on unborn branch' '
+	git checkout -f --orphan orphan &&
+	git reset &&
+	rm -f otherfile-4 &&
+	test_must_fail git am -3 0003-*.patch &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 4 = "$(cat otherfile-4)"
+'
+
 test_done
-- 
2.1.4

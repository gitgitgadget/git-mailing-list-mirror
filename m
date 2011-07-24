From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/9] bisect: add tests to document expected behaviour in presence of broken trees.
Date: Sun, 24 Jul 2011 15:57:46 +1000
Message-ID: <1311487074-25070-2-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhv-0007mm-VW
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab1GXF6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:13 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1GXF6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:10 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WDqrye0bB9gipKsxE90CNQ0FSiZJJyWcxMbbwRjIcX0=;
        b=Nh5k/ZI53M0920OYY5lZUWuE6fJo9+5tlwbUtmCau+NCZljkgG9uYWrg7NNhcg4a2Y
         5hndrfHdR1/dRY1o8nTWJxRfxA3omdmfQWCNPVYSWNWrfW0JcC3kH4xzZUvg/bp+9VSR
         fEx+AuVSY7yVSZGMZ2767AKtHX9omRdrS09qU=
Received: by 10.142.209.19 with SMTP id h19mr1947728wfg.79.1311487089892;
        Sat, 23 Jul 2011 22:58:09 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177718>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   50 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b5063b6..2c14fb0 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -573,5 +573,55 @@ test_expect_success 'erroring out when using bad path parameters' '
 '
 
 #
+# This creates a broken branch which cannot be checked out because
+# the tree created has been deleted.
 #
+# H1-H2-H3-H4-H5-H6-H7  <--other
+#            \
+#             S5-S6'-S7'-S8'-S9  <--broken
+#
+# Commits marked with ' have a missing tree.
+#
+test_expect_success 'broken branch creation' '
+        git bisect reset &&
+        git checkout -b broken $HASH4 &&
+        add_line_into_file "5(broken): first line on a broken branch" hello2 &&
+        BROKEN_HASH5=$(git rev-parse --verify HEAD) &&
+        mkdir missing &&
+        :> missing/MISSING &&
+        git add missing/MISSING &&
+        git commit -m "Added file that will be deleted"
+        BROKEN_HASH6=$(git rev-parse --verify HEAD) &&
+        add_line_into_file "6(broken): second line on a broken branch" hello2 &&
+        BROKEN_HASH7=$(git rev-parse --verify HEAD) &&
+        add_line_into_file "7(broken): third line on a broken branch" hello2 &&
+        BROKEN_HASH8=$(git rev-parse --verify HEAD) &&
+        git rm missing/MISSING &&
+        git commit -m "Remove missing file"
+        BROKEN_HASH9=$(git rev-parse --verify HEAD) &&
+        rm .git/objects/39/f7e61a724187ab767d2e08442d9b6b9dab587d
+'
+
+echo "" > expected.ok
+cat > expected.missing-tree.default <<EOF
+fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
+EOF
+cat > expected.missing-tree.ignored <<EOF
+fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
+warn: checkout failed. Updating HEAD directly. The working tree and index may be inconsistent.
+EOF
+
+test_expect_success 'bisect fails if tree is broken on start commit' '
+        git bisect reset &&
+        test_must_fail git bisect start $BROKEN_HASH7 $HASH4 2>error.txt &&
+        test_cmp expected.missing-tree.default error.txt
+'
+
+test_expect_success 'bisect fails if tree is broken on trial commit' '
+        git bisect reset &&
+        test_must_fail git bisect start $BROKEN_HASH9 $HASH4 2>error.txt &&
+        git update-ref --no-deref HEAD broken &&
+        test_cmp expected.missing-tree.default error.txt
+'
+
 test_done
-- 
1.7.6.347.g96e0b.dirty

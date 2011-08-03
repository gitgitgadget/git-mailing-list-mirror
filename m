From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v16 3/7] bisect: add tests to document expected behaviour in presence of broken trees.
Date: Thu,  4 Aug 2011 07:57:02 +1000
Message-ID: <1312408626-8600-4-git-send-email-jon.seymour@gmail.com>
References: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 23:58:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojS8-0007Nf-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab1HCV6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:58:08 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45607 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab1HCV6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:58:05 -0400
Received: by mail-yi0-f46.google.com with SMTP id 27so747475yia.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/iqAqemLyUp1ifOv4rV21ICKb1HOCRM6k4P5yx4fGTc=;
        b=XbwBGr82Oq3MlYrPYZQ1XNAA+Mb4sx6vPE2pyb3Fl8d8T3NqnPk7SGnc+G06o0eVca
         gik9Q8ukDGfIbDY8vViM7TVvLnA4ahuyvc3RqttvA4XXtQ2q1CtShVHUngb4aR69XDQ8
         /aURCIaCMRpM8smHlalorKGe+YoLTI4QkoJ4M=
Received: by 10.151.147.7 with SMTP id z7mr1201156ybn.80.1312408685386;
        Wed, 03 Aug 2011 14:58:05 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id e7sm625568ybg.18.2011.08.03.14.58.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 14:58:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g172e
In-Reply-To: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178632>

If the repo is broken, we expect bisect to fail.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   48 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b3d1b14..9ae2de8 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -581,5 +581,53 @@ test_expect_success 'erroring out when using bad path parameters' '
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
+	git bisect reset &&
+	git checkout -b broken $HASH4 &&
+	git tag BROKEN_HASH4 $HASH4 &&
+	add_line_into_file "5(broken): first line on a broken branch" hello2 &&
+	git tag BROKEN_HASH5 &&
+	mkdir missing &&
+	:> missing/MISSING &&
+	git add missing/MISSING &&
+	git commit -m "6(broken): Added file that will be deleted"
+	git tag BROKEN_HASH6 &&
+	add_line_into_file "7(broken): second line on a broken branch" hello2 &&
+	git tag BROKEN_HASH7 &&
+	add_line_into_file "8(broken): third line on a broken branch" hello2 &&
+	git tag BROKEN_HASH8 &&
+	git rm missing/MISSING &&
+	git commit -m "9(broken): Remove missing file"
+	git tag BROKEN_HASH9 &&
+	rm .git/objects/39/f7e61a724187ab767d2e08442d9b6b9dab587d
+'
+
+echo "" > expected.ok
+cat > expected.missing-tree.default <<EOF
+fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
+EOF
+
+test_expect_success 'bisect fails if tree is broken on start commit' '
+	git bisect reset &&
+	test_must_fail git bisect start BROKEN_HASH7 BROKEN_HASH4 2>error.txt &&
+	test_cmp expected.missing-tree.default error.txt
+'
+
+test_expect_success 'bisect fails if tree is broken on trial commit' '
+	git bisect reset &&
+	test_must_fail git bisect start BROKEN_HASH9 BROKEN_HASH4 2>error.txt &&
+	git reset --hard broken &&
+	git checkout broken &&
+	test_cmp expected.missing-tree.default error.txt
+'
+
 test_done
-- 
1.7.6.352.g172e

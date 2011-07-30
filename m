From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/5] bisect: add tests to document expected behaviour in presence of broken trees.
Date: Sat, 30 Jul 2011 18:28:27 +1000
Message-ID: <1312014511-7157-2-git-send-email-jon.seymour@gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn4uk-0002FL-G8
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 10:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab1G3I2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 04:28:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36729 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab1G3I2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 04:28:46 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so7731148pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0m3X5S/z54DTS8gUggEHCuKJG20VjEHPbFfNJXLzu1A=;
        b=ME1QY/behlwRUA3d7xKdqk8m2xqxBHd3qiF3+9+es4AXwSSWN7YUfDcA0/dM1hzQmQ
         b8n7hKQWCDZPhfPMsSHLk88jyyk/GDC0zMbz2G0TlzRiDDiZ5SfMlkugdtoj/wGLLAqU
         g7BS+WmRhFFiQq201Ok3FfZUcaPX5d6X68fKQ=
Received: by 10.68.31.135 with SMTP id a7mr3391657pbi.262.1312014526512;
        Sat, 30 Jul 2011 01:28:46 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id p7sm3012490pbn.65.2011.07.30.01.28.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 01:28:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.387.g991c2
In-Reply-To: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178181>

If the repo is broken, we expect bisect to fail.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   48 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b5063b6..c28da2d 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -573,5 +573,53 @@ test_expect_success 'erroring out when using bad path parameters' '
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
1.7.6.387.g991c2

From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v17 3/7] bisect: add tests to document expected behaviour in presence of broken trees.
Date: Thu,  4 Aug 2011 22:00:59 +1000
Message-ID: <1312459263-16911-4-git-send-email-jon.seymour@gmail.com>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 14:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowch-0003qe-AI
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab1HDMB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:01:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36181 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab1HDMBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:01:55 -0400
Received: by gxk21 with SMTP id 21so985599gxk.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jstge76OIPKbmewJo2lzcPORPDx4Ms2qnyOr1M09/Ho=;
        b=MKvNd4XgMyVtOqxyNnEvIsiZ1g4bLv84bAC71KGot1HXbyjCduKCY/DCPCuArh99oS
         s37L4BfYXnBtMnVl+MG8UjguqD4YYVqs5OD01eY0lz0cRH95to0FxhuByA+3blnsVuwa
         CSr9K5Oyx2aNvW5BuGsLXDOVMUSDZ5eTRLVe4=
Received: by 10.142.156.4 with SMTP id d4mr663188wfe.60.1312459314143;
        Thu, 04 Aug 2011 05:01:54 -0700 (PDT)
Received: from localhost.localdomain ([120.16.214.215])
        by mx.google.com with ESMTPS id i5sm249965wff.18.2011.08.04.05.01.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 05:01:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g50d6f
In-Reply-To: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178741>

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
1.7.6.353.g50d6f

From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v13 3/8] bisect: add tests to document expected behaviour in presence of broken trees.
Date: Tue,  2 Aug 2011 21:29:00 +1000
Message-ID: <1312284545-2426-4-git-send-email-jon.seymour@gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDB8-0004bt-8k
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab1HBLaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:30:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36827 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1HBLaF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:30:05 -0400
Received: by ywn13 with SMTP id 13so1252172ywn.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E7wZErmLdCQ51j72LDAd5isB60FsZ5Gdk0YycLgs8xM=;
        b=qmo8+GYPWVK/76woUOJH/Nm+jOuSI+oBVIERLV4kFn+Pa6HKoG1cLE767uj/mSJ/Jt
         MRJu7cQJmbnv6kBU9lahzDEefVha9+oE8YPJzoBkJDHGnBvd/URCxk+KV+ZuKL2PNYi1
         HmsrXbaGTn7dLRYUhHUAUOWj87rmLhWwPfsM4=
Received: by 10.142.213.17 with SMTP id l17mr3532523wfg.206.1312284604860;
        Tue, 02 Aug 2011 04:30:04 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id t20sm3715018wfe.12.2011.08.02.04.30.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:30:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g3461
In-Reply-To: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178454>

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
1.7.6.353.g3461

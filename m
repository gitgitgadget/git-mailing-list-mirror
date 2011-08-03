From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v16 6/7] bisect: add tests for the --no-checkout option.
Date: Thu,  4 Aug 2011 07:57:05 +1000
Message-ID: <1312408626-8600-7-git-send-email-jon.seymour@gmail.com>
References: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 23:58:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojSK-0007T3-1f
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab1HCV6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:58:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49435 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab1HCV6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:58:21 -0400
Received: by mail-yx0-f174.google.com with SMTP id 19so495880yxj.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0wG69igduyQoHH+N4Pb+Zhlf4+c+WN8grrIC9T3bZC8=;
        b=XUylVMki9MScRtu5XRdWgielUV3aMxaM3JynlSVJuClF9nN00iaxeX7prPpnUZt2T0
         vbcSKF9DeHlSnJeErlHvGNFK8qR9ujoMMIxDoyxRQzNI4K2wrFzesUC23h8fsqvEoX2g
         Lb3d5j/4sQfwEQV71OyRp4Iccxay8lYoXS8Ys=
Received: by 10.150.73.35 with SMTP id v35mr1167218yba.218.1312408700606;
        Wed, 03 Aug 2011 14:58:20 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id e7sm625568ybg.18.2011.08.03.14.58.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 14:58:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g172e
In-Reply-To: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178635>

These tests verify that git-bisect --no-checkout can successfully
bisect commit histories that reference damaged trees.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   82 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9ae2de8..113e1c5 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -126,6 +126,18 @@ test_expect_success 'bisect reset removes packed refs' '
 	test -z "$(git for-each-ref "refs/heads/bisect")"
 '
 
+test_expect_success 'bisect reset removes bisect state after --no-checkout' '
+	git bisect reset &&
+	git bisect start --no-checkout &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH3 &&
+	git bisect next &&
+	git bisect reset &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test -z "$(git for-each-ref "refs/heads/bisect")" &&
+	test -z "$(git for-each-ref "BISECT_HEAD")"
+'
+
 test_expect_success 'bisect start: back in good branch' '
 	git branch > branch.output &&
 	grep "* other" branch.output > /dev/null &&
@@ -616,6 +628,14 @@ cat > expected.missing-tree.default <<EOF
 fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
 EOF
 
+check_same()
+{
+    echo "Checking $1 is the same as $2" &&
+    git rev-parse "$1" > expected.same &&
+    git rev-parse "$2" > expected.actual &&
+    test_cmp expected.same expected.actual
+}
+
 test_expect_success 'bisect fails if tree is broken on start commit' '
 	git bisect reset &&
 	test_must_fail git bisect start BROKEN_HASH7 BROKEN_HASH4 2>error.txt &&
@@ -630,4 +650,66 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 	test_cmp expected.missing-tree.default error.txt
 '
 
+test_expect_success 'bisect: --no-checkout - start commit bad' '
+	git bisect reset &&
+	git bisect start BROKEN_HASH7 BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - trial commit bad' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target before breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect bad BISECT_HEAD &&
+	check_same BROKEN_HASH5 BISECT_HEAD &&
+	git bisect bad BISECT_HEAD &&
+	check_same BROKEN_HASH5 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target in breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect bad BISECT_HEAD &&
+	check_same BROKEN_HASH5 BISECT_HEAD &&
+	git bisect good BISECT_HEAD &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target after breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect good BISECT_HEAD &&
+	check_same BROKEN_HASH8 BISECT_HEAD &&
+	git bisect good BISECT_HEAD &&
+	check_same BROKEN_HASH9 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: demonstrate identification of damage boundary' "
+	git bisect reset &&
+	git checkout broken &&
+	git bisect start broken master --no-checkout &&
+	git bisect run sh -c '
+		GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*) &&
+		git rev-list --objects BISECT_HEAD --not $GOOD >tmp.$$ &&
+		git pack-objects --stdout >/dev/null < tmp.$$ &&
+		rc=$?
+		rm tmp.$$
+		test \$rc = 0' &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+"
+
 test_done
-- 
1.7.6.352.g172e

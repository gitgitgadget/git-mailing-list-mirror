From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11 6/7] bisect: add tests for the --no-checkout option.
Date: Mon,  1 Aug 2011 21:56:16 +1000
Message-ID: <1312199777-10144-7-git-send-email-jon.seymour@gmail.com>
References: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:57:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr7r-0006Bk-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab1HAL5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:57:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42860 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1HAL5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:57:23 -0400
Received: by mail-yw0-f46.google.com with SMTP id 13so633522ywn.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7WIoMjkYIWf+Ike/uNq+EJhCGrNLQq5Ex2b0FYPI0bw=;
        b=M4vDNHvxittcC8cyGCDFEV0KqE4pzx23dwuY/G8s0ibg7ccnq4LdnDh5fKa5Qk55GU
         ZDXuHJFxiYCrG9Ji0rEC2vZrUKMsR8hlGwIfWdEaz5c7ZcZlyHaFuwqn3FG1I1Wg6jsv
         1yzlyfPBs2QnyVHj8j7+LtImZVdCgXPxtaNS4=
Received: by 10.142.56.15 with SMTP id e15mr2620478wfa.340.1312199842184;
        Mon, 01 Aug 2011 04:57:22 -0700 (PDT)
Received: from localhost.localdomain ([120.16.6.238])
        by mx.google.com with ESMTPS id a4sm3060009wfm.4.2011.08.01.04.57.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:57:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g0c69b
In-Reply-To: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178340>

These tests verify that git-bisect --no-checkout can successfully
bisect commit histories that reference damaged trees.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   70 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9ae2de8..a1e0ddc 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -616,6 +616,14 @@ cat > expected.missing-tree.default <<EOF
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
@@ -630,4 +638,66 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 	test_cmp expected.missing-tree.default error.txt
 '
 
+test_expect_success 'bisect: --no-checkout - start commit bad' '
+	git bisect reset &&
+	git bisect start BROKEN_HASH7 BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - trial commit bad' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target before breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect bad HEAD &&
+	check_same BROKEN_HASH5 HEAD &&
+	git bisect bad HEAD &&
+	check_same BROKEN_HASH5 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target in breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect bad HEAD &&
+	check_same BROKEN_HASH5 HEAD &&
+	git bisect good HEAD &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target after breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect good HEAD &&
+	check_same BROKEN_HASH8 HEAD &&
+	git bisect good HEAD &&
+	check_same BROKEN_HASH9 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: demonstrate identification of damage boundary' "
+	git bisect reset &&
+	git checkout broken &&
+	git bisect start broken master --no-checkout &&
+	git bisect run eval '
+rc=1;
+if git rev-list --objects HEAD >tmp.$$; then
+   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
+fi;
+rm tmp.$$;
+test \$rc -eq 0;' &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+"
+
 test_done
-- 
1.7.6.352.g0c69b

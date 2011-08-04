From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v17 6/7] bisect: add tests for the --no-checkout option.
Date: Thu,  4 Aug 2011 22:01:02 +1000
Message-ID: <1312459263-16911-7-git-send-email-jon.seymour@gmail.com>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 14:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowd1-00043l-8h
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab1HDMCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:02:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36281 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab1HDMCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:02:14 -0400
Received: by gwaa12 with SMTP id a12so988077gwa.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8LgxXLH87IIg3G4/U8vOiPQOYxTmnB1LbVMNAmLPZsE=;
        b=qzyl08kmi9uA7S6T/Dux5Ws0Awua/tKv+H4w8284P25U4JDEqzc2mPr6ysiV5iVImQ
         UYD8KF623ArkIOc5Qz0PrrSLUZmBLxUg8yy2x27wfxNHGjieQcJUBBG0aKx5iLFh3G5+
         Zz+daBpWqQIGOUl3utJ/LOSOJGZ8lKTpzU0u4=
Received: by 10.143.20.5 with SMTP id x5mr750218wfi.41.1312459333567;
        Thu, 04 Aug 2011 05:02:13 -0700 (PDT)
Received: from localhost.localdomain ([120.16.214.215])
        by mx.google.com with ESMTPS id i5sm249965wff.18.2011.08.04.05.02.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 05:02:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g50d6f
In-Reply-To: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178744>

These tests verify that git-bisect --no-checkout can successfully
bisect commit histories that reference damaged trees.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   82 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9ae2de8..4fb7d11 100755
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
@@ -630,4 +642,74 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 	test_cmp expected.missing-tree.default error.txt
 '
 
+check_same()
+{
+	echo "Checking $1 is the same as $2" &&
+	git rev-parse "$1" > expected.same &&
+	git rev-parse "$2" > expected.actual &&
+	test_cmp expected.same expected.actual
+}
+
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
+		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
+		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
+		git pack-objects --stdout >/dev/null < tmp.\$\$
+		rc=\$?
+		rm -f tmp.\$\$
+		test \$rc = 0' &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+"
+
 test_done
-- 
1.7.6.353.g50d6f

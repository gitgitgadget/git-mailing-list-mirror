From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v13 6/8] bisect: add tests for the --no-checkout option.
Date: Tue,  2 Aug 2011 21:29:03 +1000
Message-ID: <1312284545-2426-7-git-send-email-jon.seymour@gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDBA-0004bt-Im
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab1HBLaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:30:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41800 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1HBLaW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:30:22 -0400
Received: by mail-gy0-f174.google.com with SMTP id 3so3985580gyh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=B28D2jIdMM07CFN+BYwipZWT1qP8BlYeLJZDiTtRG8g=;
        b=JReGwCqW5jaaKZSn0g46p6UEXpFOgAwfPQ4A2kxMljVx8EADr+y/kHij4ldbtl23P7
         PEpEKnIkSdZ+xzyzJLIwxvfZ+bzcV7UXbFuTI8Hs0Kq6g2vYvYFdKoHW8+/KbP0WOdum
         Op2ZIzdOluxFYBWTNcs0yEu2Ef8WHrd3/t70Q=
Received: by 10.142.111.8 with SMTP id j8mr2664992wfc.108.1312284621734;
        Tue, 02 Aug 2011 04:30:21 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id t20sm3715018wfe.12.2011.08.02.04.30.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:30:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g3461
In-Reply-To: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178456>

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
1.7.6.353.g3461

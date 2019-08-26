Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB961F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfHZBoL (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58288 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfHZBoH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CBCEF6074A;
        Mon, 26 Aug 2019 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783846;
        bh=p17VuaSheP1+ohXjcp12g/UGe7MYk2eIBZfRmD4076o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XmIEiKA5YDiuOT1vL5HzW1RCNQEeBzd3+7POxwSwRQcdcO2SkqPdWvJ6dafgThCw6
         VzMr3D0k9a/RKktmIDCuXFybRASUPHagIq0+kvA/kVZGW6UlhRvkg0FlES702mte1i
         Nll0121Y+oQrEWwPeQTilTusYwGu3eNS5k1ZKv64BUoUHrVx0I5glG69Yng+28gkOd
         INYalxW6lbLxISGS9dWl4MCMDIGd5gjvrLjZeITnaKDBnWfAU4akXpq5ze1WLu+QhG
         Pqw0XEJIkzA+YCKwzZiW6pa0Ul/rB/QlvMgtjg54IyE3tFnjijcEsQ8mODoT2sqzFv
         o2ec8hHG9oVrC7Z/pc4DpzTOIBdPVlF4adfO73YcrKdf6Uet82CahifjAhfMiZM4S3
         ptJfHbCMdQlKyddl75oSEEBliV5uyHVN57AAmqGUvvFmIIJjxx5U8apPwd0fmCC9sy
         SH/rsBvvOgceGpT1hN3XUTv1Ywkh7DGJIyeDYSuTYrTLPEtPDq8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 05/14] t3306: abstract away SHA-1-specific constants
Date:   Mon, 26 Aug 2019 01:43:35 +0000
Message-Id: <20190826014344.16008-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.  Convert some single-line heredocs into inline
uses of echo now that they can be expressed succinctly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3306-notes-prune.sh | 45 ++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index 61748088eb..8f4102ff9e 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -11,23 +11,26 @@ test_expect_success 'setup: create a few commits with notes' '
 	test_tick &&
 	git commit -m 1st &&
 	git notes add -m "Note #1" &&
+	first=$(git rev-parse HEAD) &&
 	: > file2 &&
 	git add file2 &&
 	test_tick &&
 	git commit -m 2nd &&
 	git notes add -m "Note #2" &&
+	second=$(git rev-parse HEAD) &&
 	: > file3 &&
 	git add file3 &&
 	test_tick &&
 	git commit -m 3rd &&
-	COMMIT_FILE=.git/objects/5e/e1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	third=$(git rev-parse HEAD) &&
+	COMMIT_FILE=$(echo $third | sed "s!^..!.git/objects/&/!") &&
 	test -f $COMMIT_FILE &&
 	test-tool chmtime =+0 $COMMIT_FILE &&
 	git notes add -m "Note #3"
 '
 
 cat > expect <<END_OF_LOG
-commit 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
+commit $third
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:15:13 2005 -0700
 
@@ -36,7 +39,7 @@ Date:   Thu Apr 7 15:15:13 2005 -0700
 Notes:
     Note #3
 
-commit 08341ad9e94faa089d60fd3f523affb25c6da189
+commit $second
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:14:13 2005 -0700
 
@@ -45,7 +48,7 @@ Date:   Thu Apr 7 15:14:13 2005 -0700
 Notes:
     Note #2
 
-commit ab5f302035f2e7aaf04265f08b42034c23256e1f
+commit $first
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:13:13 2005 -0700
 
@@ -70,16 +73,16 @@ test_expect_success 'remove some commits' '
 
 test_expect_success 'verify that commits are gone' '
 
-	test_must_fail git cat-file -p 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
-	git cat-file -p 08341ad9e94faa089d60fd3f523affb25c6da189 &&
-	git cat-file -p ab5f302035f2e7aaf04265f08b42034c23256e1f
+	test_must_fail git cat-file -p $third &&
+	git cat-file -p $second &&
+	git cat-file -p $first
 '
 
 test_expect_success 'verify that notes are still present' '
 
-	git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
-	git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
-	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+	git notes show $third &&
+	git notes show $second &&
+	git notes show $first
 '
 
 test_expect_success 'prune -n does not remove notes' '
@@ -90,13 +93,10 @@ test_expect_success 'prune -n does not remove notes' '
 	test_cmp expect actual
 '
 
-cat > expect <<EOF
-5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
-EOF
 
 test_expect_success 'prune -n lists prunable notes' '
 
-
+	echo $third >expect &&
 	git notes prune -n > actual &&
 	test_cmp expect actual
 '
@@ -109,9 +109,9 @@ test_expect_success 'prune notes' '
 
 test_expect_success 'verify that notes are gone' '
 
-	test_must_fail git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
-	git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
-	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+	test_must_fail git notes show $third &&
+	git notes show $second &&
+	git notes show $first
 '
 
 test_expect_success 'remove some commits' '
@@ -121,21 +121,18 @@ test_expect_success 'remove some commits' '
 	git gc --prune=now
 '
 
-cat > expect <<EOF
-08341ad9e94faa089d60fd3f523affb25c6da189
-EOF
-
 test_expect_success 'prune -v notes' '
 
+	echo $second >expect &&
 	git notes prune -v > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'verify that notes are gone' '
 
-	test_must_fail git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
-	test_must_fail git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
-	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+	test_must_fail git notes show $third &&
+	test_must_fail git notes show $second &&
+	git notes show $first
 '
 
 test_done

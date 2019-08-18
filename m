Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871061F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfHRTUz (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:20:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57788 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbfHRTUy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:20:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6754D6074A;
        Sun, 18 Aug 2019 19:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156051;
        bh=p17VuaSheP1+ohXjcp12g/UGe7MYk2eIBZfRmD4076o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=S8eaBzbqUt3zLSnVm0Szyj6XyldnxsAEb/KxuOCYgW1zB9qSejI6lbMLwzlBL7RnE
         veXNFkuUOJSh4A9/CSNXqR0KjqaYGmzvw4vF4G0An3qOnbtMhhTlAxK0ZB5e9odnfu
         0rJYJMT3Ybc9HEhTmR2NH7yQCRec/Z+628uwltRsrBb6/LrjqszJcL9kPUcCMQYyDf
         PZHf0Wbciz1RyNUjGobtaqexg7dGDTIX/eciEvA14G8sO0kkpCV8NkLJz2LJ+mzH1q
         MwXQAIW0vY5614J8/33tk/Du1YGWGFVqfmTatFKMONFDXW/F5x1c/5YvC5W1X8CIta
         MRhMB1vnSF0Fjdb2EETO4t2z4KLFY+5iTltnl43zauLA3zIf4dbZevGRdklJdZkEoO
         SrYBnB0bE1I03HcqZjae7+3jygYI0Lvu8r5mS/TWdcj/6294ow91tnVR/CuLIq1TxJ
         ILKsqRJOZR9RlmwQ67anhG5wasGzHCIQCR5wYu2YBLWgh2kkKbv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 05/14] t3306: abstract away SHA-1-specific constants
Date:   Sun, 18 Aug 2019 19:16:37 +0000
Message-Id: <20190818191646.868106-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
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

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB35A1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfHRTVG (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:21:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57850 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727127AbfHRTVE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:21:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3167C6075D;
        Sun, 18 Aug 2019 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156062;
        bh=IuPf9FWSu4jKHpIr6ccgKNVinQdoZ4tgt5YbhUe2Xz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gDFie5i9IW0XWfzgZLP3MejImhIlv3KLaQIkzHOhD16l6n+mEp4CmJmu2apN12N8P
         Qfy4r2kAjHMwfm3t1ef9jj68SCgVHCzcyekoYmouhYlvph/EecG4up8UQXKOWofyvI
         v3JDB+q3QOGtr6yVWZMK/2OrTpkj5IEA2zisSyXgldHnRcaGBe5IOYCJHZOGmjXIpq
         5aFhm3InGLiNkeAlHstxbtEkFMeIqJsq/1dlxSWAcguIkCvHMzgufYRB+sxyAEyuAE
         bN/ife32fZTlNttUaxcDXOu3kq1zCJhdQ02vKWBV4CFPbz+23ynM69iUTgweUHBeM4
         jzyAs93r2qnHi/lVkY44d2m0rxP8ir7QA37vIp7kj49AqAIQB5aCHtE6alDoH3LtBf
         gRSmKw/3y8ey8nIrn+8QRtpHrLV4bwcMhG33IH8K2wZM3ouwP5Igsx+xUbzD1+LPKi
         d0S+dyi2TfpcVYDafSGJcvlugjcZMQQWbbcVv0q7vDjtSwiNyZa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 11/14] t3903: abstract away SHA-1-specific constants
Date:   Sun, 18 Aug 2019 19:16:43 +0000
Message-Id: <20190818191646.868106-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abstract away the SHA-1-specific constants by sanitizing diff output to
remove the index lines, since it's clear from the assertions in question
that we are not interested in the specific object IDs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3903-stash.sh | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b8e337893f..8e3e0992df 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -7,6 +7,18 @@ test_description='Test git stash'
 
 . ./test-lib.sh
 
+diff_cmp () {
+	for i in "$1" "$2"
+	do
+		sed -e 's/^index 0000000\.\.[0-9a-f]*/index 0000000..1234567/' \
+		-e 's/^index [0-9a-f]*\.\.[0-9a-f]*/index 1234567..89abcde/' \
+		-e 's/^index [0-9a-f]*,[0-9a-f]*\.\.[0-9a-f]*/index 1234567,7654321..89abcde/' \
+		"$i" > "$i.compare"
+	done &&
+	test_cmp "$1.compare" "$2.compare" &&
+	rm -f "$1.compare" "$2.compare"
+}
+
 test_expect_success 'stash some dirty working directory' '
 	echo 1 >file &&
 	git add file &&
@@ -36,7 +48,7 @@ EOF
 test_expect_success 'parents of stash' '
 	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
 	git diff stash^2..stash >output &&
-	test_cmp expect output
+	diff_cmp expect output
 '
 
 test_expect_success 'applying bogus stash does nothing' '
@@ -210,13 +222,13 @@ test_expect_success 'stash branch' '
 	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
 	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
 	git diff --cached >output &&
-	test_cmp expect output &&
+	diff_cmp expect output &&
 	git diff >output &&
-	test_cmp expect1 output &&
+	diff_cmp expect1 output &&
 	git add file &&
 	git commit -m alternate\ second &&
 	git diff master..stashbranch >output &&
-	test_cmp output expect2 &&
+	diff_cmp output expect2 &&
 	test 0 = $(git stash list | wc -l)
 '
 
@@ -577,7 +589,7 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	+bar
 	EOF
 	git stash show -p ${STASH_ID} >actual &&
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'stash show - no stashes on stack, stash-like argument' '
@@ -609,7 +621,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	+foo
 	EOF
 	git stash show -p ${STASH_ID} >actual &&
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'stash show --patience shows diff' '
@@ -627,7 +639,7 @@ test_expect_success 'stash show --patience shows diff' '
 	+foo
 	EOF
 	git stash show --patience ${STASH_ID} >actual &&
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'drop: fail early if specified stash is not a stash ref' '
@@ -791,7 +803,7 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
 	git diff-index --cached --quiet HEAD &&
 	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
 	git diff stash^..stash >output &&
-	test_cmp expect output
+	diff_cmp expect output
 '
 
 test_expect_success 'store called with invalid commit' '
@@ -847,7 +859,7 @@ test_expect_success 'stash list implies --first-parent -m' '
 	+working
 	EOF
 	git stash list --format=%gd -p >actual &&
-	test_cmp expect actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'stash list --cc shows combined diff' '
@@ -864,7 +876,7 @@ test_expect_success 'stash list --cc shows combined diff' '
 	++working
 	EOF
 	git stash list --format=%gd -p --cc >actual &&
-	test_cmp expect actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'stash is not confused by partial renames' '

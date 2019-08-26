Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484D51F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfHZBoT (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729114AbfHZBoR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69CC761385;
        Mon, 26 Aug 2019 01:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783855;
        bh=4VUU0BUyd5WOxClHnKEEV+04Yt5LJ3i28LFCIWq+rVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=C4QRZQbdw04LVCeJ7tmbGs9WFD4Hl4HIGEmHzmBH/pKtgK75WKUExOFAjSg32gdst
         lT6iVH7wuAVoGdUQvjxWtB8BqK+f3yPPOlSzo34fZxJxnshJrF5l7LJ/ndjf9yUE1w
         Hf+db5xVPP7TUFWhjVvn7VT0WfEt2zucYSqacdf6OgXBRR3s8im5NqWjv4C4Ak+pig
         UiSihj8hVRMSJi5znoFzFx/gp9+yYULzKuy5nDVB9sBsalK9ncnD1MsoEAct7nnC76
         Bv/RPH6KytXQyKaqWAC9SRpxcImltRb+4SdN7YAWk5W0RXOqjcn3fbT8MDxryFr+nK
         9Y7rRxK4F1XAVfVSGaz0vkPYEy8qgVgKaia1rEh5BrJ9uUrcUvZyszV7lH1oyw3E62
         Wh6FzQsoW7WSQw0zIEqP/m/sTnIxpJ/Ct+OB7qoH4ZT+7rP2WTdmmOGuokCGJIoqCT
         5gKc7mA3mNecYjVswWIvnZ9rmxX2PLXf1S06nCtKvxCTF3RKvmD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 11/14] t3903: abstract away SHA-1-specific constants
Date:   Mon, 26 Aug 2019 01:43:41 +0000
Message-Id: <20190826014344.16008-12-sandals@crustytoothpaste.net>
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

Abstract away the SHA-1-specific constants by sanitizing diff output to
remove the index lines, since it's clear from the assertions in question
that we are not interested in the specific object IDs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3903-stash.sh | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b8e337893f..820b350aeb 100755
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
+		"$i" >"$i.compare" || return 1
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

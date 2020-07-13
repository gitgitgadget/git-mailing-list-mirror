Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A4C43465
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F77206B6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="W8CsKqfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgGMCuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40844 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728799AbgGMCuM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 50A9B60A5C;
        Mon, 13 Jul 2020 02:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608580;
        bh=PH9Y9BybEDzEXzhugfvQ0aDzJkU9Be5O4/4VUcENJHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=W8CsKqfXHctJsop6J2cggNQLgefDhc9pRAg9poahgWfOUNrKDP0GnQlti5JrD+Qs4
         yiHOUhwp9dh+sHw5kU1K75YsHMLCx+e54y3Zxf/4B54vLT+73ab7hHfhlkkUOZ+DOn
         Ix+qMIlq6acjZiz45Ai+uGw0s9gTwAG4sItg2yb7AfsoQu/wRi5tjS5/hrmbpWN/jn
         NqCShouCYnwL+RbdBhI2L5lQftsRR/X9xuGgeVl7hoDWMQP35v6M77sp45wyn07SVl
         DZItmLx7hA5Oeq2LW+sWXTYO3vxICZ7nK5XveZ2SCZxAOO+MCu2Oqv4sn90zGnDMP6
         GJrgZOO+wMcqsON71EVcvBcX1Xuy1x27w654uQxknPzXZJTAvi+cW5+58PHlHWkOSd
         EE4N7+4SFBUIr3Q1ef1h4Ul/XmPusSJWcaT69Zg9rs082k+p4O5KNiopRz6mwJfNMb
         Ioe+ww7LJnjr8Ksmu1jlOneVVuVsP3444riRe4Lqwzn4d8XoOGP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 35/39] t: allow testing different hash algorithms via environment
Date:   Mon, 13 Jul 2020 02:49:05 +0000
Message-Id: <20200713024909.3714837-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow developers to run the testsuite with a different algorithm than
the default, provide an environment variable, GIT_TEST_DEFAULT_HASH, to
specify the algorithm to use. Compute the fixed constants using
test_oid. Move the constant initialization down below the point where
test-lib-functions.sh is loaded so the functions are defined.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 4 +---
 t/test-lib.sh           | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d243ff43f3..8848ad568a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1417,9 +1417,7 @@ test_set_hash () {
 
 # Detect the hash algorithm in use.
 test_detect_hash () {
-	# Currently we only support SHA-1, but in the future this function will
-	# actually detect the algorithm in use.
-	test_hash_algo='sha1'
+	test_hash_algo="${GIT_TEST_DEFAULT_HASH:-sha1}"
 }
 
 # Load common hash metadata and common placeholder object IDs for use with
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 618a7c8d5b..307bb2207e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -452,6 +452,9 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
+export GIT_DEFAULT_HASH
+
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE

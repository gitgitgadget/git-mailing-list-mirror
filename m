Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C19C43466
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59F52053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yOjx0wdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgGWBKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40548 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387665AbgGWBKf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AD42061017
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466604;
        bh=PH9Y9BybEDzEXzhugfvQ0aDzJkU9Be5O4/4VUcENJHU=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=yOjx0wdz665Wwby+M4EUiJ7XqQVvpQ9Med/NM48rLrYlYXXifP8CiE7duzY/Imgqj
         CqJxhT0xmH5krKDwb0VYkHdw0sP8CPkVR007stDHzvYa5IO6FYvntbWOPJnNcPINdF
         Rs+HznCBCC7zJkvd9myjWrHfMzC4ncL+Jza1oj3jmucINDcUFeHsrJyFR99DT3d3lG
         9Kbp/sPH+khH927tUideybMrIslckVGqr9dn7pKlgBNJvEh3jeJr01FsKdP/fC9AmZ
         9eGcpIdjDCzXBZrL/pFYCdfpcARM8X8ctOhqdwP4VQv4FeaeB4D6lpU9VLgdHmJk3w
         zfM27nxLGSB+2NCUCHd1niPIZyfGp+MGUv1X7X6rrL2zB5nogL4rbrUwQMgbhiL9iD
         PYokiWGZRwqlUapyqwPn4c7xsuBUhW1moK/so6RHOmKZ1I+qu3barQycX9OoskIODv
         F6wBTTJ78Uhw8a/zkeVi9zVceADeZIQ1e/i0xk9zIj+YeM0JMMZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 35/39] t: allow testing different hash algorithms via environment
Date:   Thu, 23 Jul 2020 01:09:39 +0000
Message-Id: <20200723010943.2329634-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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

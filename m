Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F3EC433FB
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D402075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AeqJ9SvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgG1XfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40926 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730234AbgG1XfN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8E446101D;
        Tue, 28 Jul 2020 23:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979310;
        bh=2wb0pxNxxHB8AyR/+6fbiG1mvbjofu/+IuiJcIxweiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AeqJ9SvRbVEbS4qibHdiQvrpdm0agQY27Ym91GJLcVpEMJiOTzE9Rs/U8qcLRZ3Db
         87aZ2z/RQJMQE5K/JStJmP7krarODHijqc/wsg8DVwaLpvTktj7qMBXOvhCl2TlLH9
         jYM2tTYi0xoJtUq2URA4pEe6zTRTgxcM+zn42Bx/bmy6tBuYhXhAtk5vfScmKua8z0
         OzJ8zu6s7OZ3Dpnj1XRi/V+uEO2gW+hlimxgTm3UzptLkbyDlJUItxbMy0hr0too8i
         q85FcbdQntlm2OygnrH7nt5powh6Q34MQdn8u512KrDODcgMjq6h749g9YA2t5NpPj
         comc2ZRd1br6LJPHsG1YDFsAR4hvM1450FCks+u2JTFeDW0oftogAcd6LUA0XafG4e
         umEw4fqGs7yAEAnW8f35IjrUZ6xmePvDYlIIgcFawwNXhzQATmUKFBXNqt1sV9rjYa
         2eHuGGiJZx2JZCchzs1kKI+0j59ii0HFFLPyoYxQAiqOIvGbWyo
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 35/39] t: allow testing different hash algorithms via environment
Date:   Tue, 28 Jul 2020 23:34:42 +0000
Message-Id: <20200728233446.3066485-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
index 2608e80f11..2e01bb2c2b 100644
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

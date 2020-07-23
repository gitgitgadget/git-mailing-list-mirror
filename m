Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A5C433FB
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D372080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CGGEiEmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgGWBKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387615AbgGWBKG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6513B6101B
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466605;
        bh=RZkf13Z5+0o7/YS0PxOH8OIwQKOadGhIo4GvGuDnDCY=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=CGGEiEmWKUfAgNC6VKqT0+7eae1Ydg7VrcWPx8YSZ4a59JUZjgESADx8M2JF8vVlh
         KlzWrZvlei/fiMhcLuq+kiMHqbKJTY3XBgUUPsKKwWlo0/1otLHudpJkA9wiFhKvWG
         ovpZ5RQxZI7bgaiSoTCK4dI7ID9ymZ5MESPBsCEg+1PsspVbvbrAMcg3Dwy3WjKMtT
         lAtzeH2ztI2s/RrLu4c0jOWLaLcH5R2za6d8pbjYD3IIH2AKzBcuL86Oy9auqAc75p
         gjDV94BHASiVMCmOCgw7T2NXYvsnvGJ/Dt63lIfrHG1qX1kLkCbYAcsrN8WSmNFS1x
         4A8LtSsPn6eXWdE5uM2+ACT71LcWErxZ4vJSKEygg8lojwvuteggzukGyAnQXnWpt+
         kMJuiLyEQVIFOghFQ3AXsuJbpw/8YKNxtaT+I9DdnG2T5RtNeT6WPusnwUxP9Uj9So
         LKQic/lv2DgHkk/nBYFtVU2TtWHdEiEff+lbJR3T1m0+v6kzppu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 37/39] ci: run tests with SHA-256
Date:   Thu, 23 Jul 2020 01:09:41 +0000
Message-Id: <20200723010943.2329634-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have Git supporting SHA-256, we'd like to make sure that we
don't regress that state.  Unfortunately, it's easy to do so, so to
help, let's add code to run one of our CI jobs with SHA-256 as the
default hash.  This will help us detect any problems that may occur.

We pick the linux-clang job because it's relatively fast and the
linux-gcc job already runs the testsuite twice.  We want our tests to
run as fast as possible, so we wouldn't want to add a third run to the
linux-gcc job.  To make sure we properly exercise the code, let's run
the tests in the default mode (SHA-1) first and then run a second time
with SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ci/run-build-and-tests.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 17e25aade9..a1a6a28791 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -24,6 +24,11 @@ linux-gcc)
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	make test
 	;;
+linux-clang)
+	make test
+	export GIT_TEST_DEFAULT_HASH=sha256
+	make test
+	;;
 linux-gcc-4.8)
 	# Don't run the tests; we only care about whether Git can be
 	# built with GCC 4.8, as it errors out on some undesired (C99)

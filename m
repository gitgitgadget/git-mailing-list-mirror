Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C3C433FE
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F003120719
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="om1B3lQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgGZTzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbgGZTy6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C5EAA6101D;
        Sun, 26 Jul 2020 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793298;
        bh=RZkf13Z5+0o7/YS0PxOH8OIwQKOadGhIo4GvGuDnDCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=om1B3lQjFPz6Gh5DMqyz/xo+9RVIReVM0y+Vu8pVDRYa/bnlfFcyZ/PmsgyT7mae9
         aCVM7MK1jjTf4+IeDmuii0BgLBnkjJkEJbKt1cGtQZwxu3213/FAyvyHtacK0elIxc
         /y2EJerN4Fuhslqpc4rla6dbpRemGjFq8P2sYnkBGl2//4JtbFsWChtK/zdSJN1VZZ
         +MVKtDJbP2BBio5g0S+6eE6Kz0LI+dgkCtoIPNG/pJrywCG23/HXHKVwuiezK6OMce
         K9qxh4MtzAalhVZL7VXH61U6VxT3CWzVNl9qF6ZvhfYW6gBH0FH1lkisCfrADm4fRm
         OCnXdtzFxK/lgcq6KerGdlfEQzq/aHHkI7bm1LSVA+A4kVd3pL+yt5qI5xKleQaeN0
         CXFTyWbi8Uy+BZb81SDou++iIpSRoMrRsewCqfdRhaTM2MOqX6dR7/WY44U4i8J0Jf
         M1crWmiIV2XnVIIOtauXETalwiLRUqteYziC1BL5tyhSdjpAeH0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 37/39] ci: run tests with SHA-256
Date:   Sun, 26 Jul 2020 19:54:22 +0000
Message-Id: <20200726195424.626969-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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

Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA1DC4345A
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1AD2075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JR7T5R5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgG1XfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730240AbgG1XfO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 883B16101E;
        Tue, 28 Jul 2020 23:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979311;
        bh=PXksA9t4Mk9dgBX8Q6mV6mHGt+DBKXcHNHfaGS2lp9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JR7T5R5zge/oB1oMavmu1CZS1jFsjZ67y8QtLLojtG3kYY9RgFKz1KKvh6Oo758ON
         qJLArZQbmrGJnYQLtMK8isI2UlAJN7+W8TKhUdeJV3wfoySVOZsdEuXnCeV1YjHhvU
         URTCQVs759SGqMI1dXJF9yNBjbhumOVXNoXy0qXOuYzhxdYlKpgOxEXKSw1EMn2/Li
         Pb251IqIS1KNzqHFmNCC+uPKYidqzhirz5d4I+/C4U7ZE/qZNHVnzxda3lyDogOLBR
         0CxUJ5iPb6hbPpHJyySAABY00yRgwUN/n4A8+8yTnSRwCF242MoI20WnyXih3G7f7J
         vdgQbI5+0iNqqRHRW34N5VqiN9QpVvQeIRxNfgO+9P7kCn10uFbXZBDwRHCuhb9nQO
         VosUuEzAdSqluuikoXE4ue/5EeFLzzWAEzX/Q+Wast4CjQo3l/PYsdzEL1GP7CStfK
         l5VUm0PWo8R+gKDx6oaz+0FE7y/T530s18iiM6ehqL9RQrXAYA1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 37/39] ci: run tests with SHA-256
Date:   Tue, 28 Jul 2020 23:34:44 +0000
Message-Id: <20200728233446.3066485-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
with SHA-256.  We explicitly specify SHA-1 for the first run so that if
we change the default in the future, we make sure to test both cases.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ci/run-build-and-tests.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 17e25aade9..6c27b886b8 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -24,6 +24,12 @@ linux-gcc)
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	make test
 	;;
+linux-clang)
+	export GIT_TEST_DEFAULT_HASH=sha1
+	make test
+	export GIT_TEST_DEFAULT_HASH=sha256
+	make test
+	;;
 linux-gcc-4.8)
 	# Don't run the tests; we only care about whether Git can be
 	# built with GCC 4.8, as it errors out on some undesired (C99)

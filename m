Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6CC4345E
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90801206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="P4KO0fey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgGMCuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40822 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728769AbgGMCuG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3595760A6F;
        Mon, 13 Jul 2020 02:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608575;
        bh=e0GG4MGDDPBIn8sVOpdBt+JTBrciFKCG4qAUcFp9kSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=P4KO0feyOyozXC8NuNIsoJzl75yj8SzDYtUP0mF7kaHlambSWbRKXzQSEtVL+Em74
         N8olCw7e+44NqiIcDqbCTe581sxUdp6db7xFg8NYEC34EDOok3nI6VxtJUzwS+APRj
         ju//2akXz8qGE9eJ0yr+U4oO78DuP9aRp38ncgLMncG8CLmKxPANGkdytATEA9iarU
         oFVaPxD1S3hOOsyS5z9glYhtwuyUvNdyTEQEqNkJILIMuJbknVWxnFTulQfAWfZSDY
         ko9qQDzwTgQB7hN9huuKPI8XVvx9cgzAQfLMQhfGqqabQmEyDjpV+6GRsbnFBKCYua
         WyLIkSuNd0xWl2OeHMZeIOxRBwOg/u2ujTR0ySj2jBo2PD8oYvBPDXqLOMK3PZYMZ3
         +NmqezQH8jMgLIPoKfyeLYofgnYyYchyXR1rRh/8TPNZ+qJHTtL5Zh7dRxk8OMH2eh
         xYHr9RE9N0fFkN13WP03gWO2OPNjWHLH9x4nsdDc4/IiIS/K0+O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 25/39] t9500: ensure that algorithm info is preserved in config
Date:   Mon, 13 Jul 2020 02:48:55 +0000
Message-Id: <20200713024909.3714837-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we use a hash algorithm other than SHA-1, it's important to
preserve the hash-related values in the config file, but this test
overwrites the config file with a new one. Ensure we copy these values
properly from the old config to the new one so that the repository can
be read if it's using SHA-256.

Note that if there is no extensions.objectFormat value set, git config
will return unsuccessfully if we try to read it; since this is not an
error for us, use test_might_fail.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9500-gitweb-standalone-no-errors.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 267ddc997d..b484e3e250 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -621,12 +621,22 @@ test_expect_success \
 	 git config gitweb.snapshot "zip,tgz, tbz2" &&
 	 gitweb_run "p=.git;a=tree"'
 
-cat >.git/config <<\EOF
-# testing noval and alternate separator
-[gitweb]
-	blame
-	snapshot = zip tgz
-EOF
+test_expect_success 'setup' '
+	version=$(git config core.repositoryformatversion) &&
+	algo=$(test_might_fail git config extensions.objectformat) &&
+	cat >.git/config <<-\EOF &&
+	# testing noval and alternate separator
+	[gitweb]
+		blame
+		snapshot = zip tgz
+	EOF
+	git config core.repositoryformatversion "$version" &&
+	if test -n "$algo"
+	then
+		git config extensions.objectformat "$algo"
+	fi
+'
+
 test_expect_success \
 	'config override: tree view, features enabled in repo config (2)' \
 	'gitweb_run "p=.git;a=tree"'

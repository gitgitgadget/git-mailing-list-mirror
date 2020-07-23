Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A69C433ED
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A722A2080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ue3OAt0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbgGWBKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733175AbgGWBKB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A33DA60CF4
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466600;
        bh=e0GG4MGDDPBIn8sVOpdBt+JTBrciFKCG4qAUcFp9kSg=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=ue3OAt0NFMwXllFAzJFUKLQcO9uPBiCZjQeyrRM2zRbjD/Zwwpp5XiK5ALTURCXO3
         3DgEDdX+RK56OmErwR/aguUQmIwZOFKl3GMME4AX0cbjRUtvFMP3sAt69FPH6pxSrF
         Xc2VNynB/I00GqDNOa5dn5G5xz4yJLYWOcstqCXgAHGh+Bp1vMj6GVtbD8DfUrZPji
         EFLJrUKn507prS0WQoEkMppjswje6YoVboAK8HjhhjejwS/XGLd23Q17l20vP6iw3F
         NvBKT590U7xtX7HNUaMrcduobawLRa1kAe/+Q+LlV9dRFo/r5liipBuMQOYe9Og40V
         Zg2CwaP37jao4JLIa2bG7q9WVJsZkHqOkq+S8sKCBxRLI3kHEmJx374oaCQXpwy1x5
         sTtdKurk3XUuyqebhwWHN/8lNTCUidxrMoTS7zstI0bfHofnyHE13AtIG4FnQQzkOb
         hle4fsW4acofB25Ltf7QnKLh95yhSyuZj2+Rsm810XkTmqulI+p
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 25/39] t9500: ensure that algorithm info is preserved in config
Date:   Thu, 23 Jul 2020 01:09:29 +0000
Message-Id: <20200723010943.2329634-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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

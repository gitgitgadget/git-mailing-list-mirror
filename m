Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8117C433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B686A2067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SCe9Fyim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgG2XPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41132 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728102AbgG2XPE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9457C60CF8;
        Wed, 29 Jul 2020 23:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064500;
        bh=wWSDzLux9lZl/hYWf8cUrYsVtjcoSytsY8I6Jyl87T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SCe9FyimLvIdjtyqI1OW26RpzxU46oUk2KgYst4xk8qj/mPod+naqmYiOZTKTbyBh
         2TsERGcY+vtnKOalz5ylXbCKr/1+uEuYcTchnRJUoNJ23ZXvBS7vPJMKGHPIlJSRta
         hZTFB2yRenYzZkLo2eJ7uoaR6DnZaLqH93n/AzZkXHyUAOBqRuDACspjn0MQPYL2ri
         SfD/wiEp11Ub4YhQzcd3+ae87OEso8Hu4coblGIyIzfBqXoqJdAR0dTJBTdp7kN5jj
         jQKSoyxpQLtgsHaQvY32iELOUZo75zZx2oIsfpQkEPffFQP8oNYDZrK7pv7/7aYsRa
         G+Kq3CcjtFMMFbQRBlOHmwjCmKvP0H7J9sWBmI19vuz6lJl82Dz8fNJB0HnheQgrKI
         NfZp/WHlNE3D6hH7doSfHpo027sw52gHhGtZ6KCUyT3Vsg5KI07Mku3VARHcsrnnSN
         H9YbsdvyBKCRz+B7a1TB1kM75/XjFcngNlASGlUQ+VbMPoTWqC3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 33/39] repository: enable SHA-256 support by default
Date:   Wed, 29 Jul 2020 23:14:22 +0000
Message-Id: <20200729231428.3658647-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have a complete SHA-256 implementation in Git, let's enable
it so people can use it.  Remove the ENABLE_SHA256 define constant
everywhere it's used.  Add tests for initializing a repository with
SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/init-db.c |  5 -----
 config.mak.dev    |  2 --
 repository.c      |  4 ----
 t/t0001-init.sh   | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index cee64823cb..f70076d38e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -183,11 +183,6 @@ void initialize_repository_version(int hash_algo)
 	char repo_version_string[10];
 	int repo_version = GIT_REPO_VERSION;
 
-#ifndef ENABLE_SHA256
-	if (hash_algo != GIT_HASH_SHA1)
-		die(_("The hash algorithm %s is not supported in this build."), hash_algos[hash_algo].name);
-#endif
-
 	if (hash_algo != GIT_HASH_SHA1)
 		repo_version = GIT_REPO_VERSION_READ;
 
diff --git a/config.mak.dev b/config.mak.dev
index cd4a82a9eb..89b218d11a 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -16,8 +16,6 @@ DEVELOPER_CFLAGS += -Wstrict-prototypes
 DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
 
-DEVELOPER_CFLAGS += -DENABLE_SHA256
-
 ifndef COMPILER_FEATURES
 COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
 endif
diff --git a/repository.c b/repository.c
index 6f7f6f002b..a4174ddb06 100644
--- a/repository.c
+++ b/repository.c
@@ -89,10 +89,6 @@ void repo_set_gitdir(struct repository *repo,
 void repo_set_hash_algo(struct repository *repo, int hash_algo)
 {
 	repo->hash_algo = &hash_algos[hash_algo];
-#ifndef ENABLE_SHA256
-	if (hash_algo != GIT_HASH_SHA1)
-		die(_("The hash algorithm %s is not supported in this build."), repo->hash_algo->name);
-#endif
 }
 
 /*
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6d2467995e..d71d4c7238 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -441,6 +441,39 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success 'init honors GIT_DEFAULT_HASH' '
+	GIT_DEFAULT_HASH=sha1 git init sha1 &&
+	git -C sha1 rev-parse --show-object-format >actual &&
+	echo sha1 >expected &&
+	test_cmp expected actual &&
+	GIT_DEFAULT_HASH=sha256 git init sha256 &&
+	git -C sha256 rev-parse --show-object-format >actual &&
+	echo sha256 >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'init honors --object-format' '
+	git init --object-format=sha1 explicit-sha1 &&
+	git -C explicit-sha1 rev-parse --show-object-format >actual &&
+	echo sha1 >expected &&
+	test_cmp expected actual &&
+	git init --object-format=sha256 explicit-sha256 &&
+	git -C explicit-sha256 rev-parse --show-object-format >actual &&
+	echo sha256 >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
+	git init --object-format=sha256 explicit-v0 &&
+	git -C explicit-v0 config core.repositoryformatversion 0 &&
+	test_must_fail git -C explicit-v0 rev-parse --show-object-format
+'
+
+test_expect_success 'init rejects attempts to initialize with different hash' '
+	test_must_fail git -C sha1 init --object-format=sha256 &&
+	test_must_fail git -C sha256 init --object-format=sha1
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

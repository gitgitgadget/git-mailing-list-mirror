Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F62C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806A1207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UX5TWT3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgAMMsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37774 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgAMMr7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:47:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AD258607F9
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919678;
        bh=+5bAwq2BIkQD0nv7y2dIjQhI+1TCfEBgfO/PHBzhD9k=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=UX5TWT3xc03F6qaBqOOihhazX3+kD4cL4RvIWVqv9nTRKG/+auKnU29chX1V2aQdF
         MBVf/+mcW6a24teBDjQW020WyV8yJpYRb85OLVXU5Ovbdz2dac+DMy/OIq926moF8e
         5+yJCjpMGBBAFdYbMrn7pyyqrf1/M0kCt9y8O9NhQ1UPxfBDBYF2arcIHv6sQEJgSo
         DaMcMN2ZCaxiucEZyVhYWAiljqinFJCiUY2x64lrh3xlt0KJg3q1hxKEFAJ2RvCmyc
         vo2+N3/OGD1bVfuw0Yvpbv19wuniuDqJAD5JMkBtSEdhRq8VKa70UrjyqZTLhvmxyX
         eXfu4pyqs4N44VAHmvNNm4UfjQ+mHs2hWnJno4FSfNQ6BlnroSNvf8APG+M382hD8G
         09HmeDSxCYb0Eo1xta4UssQ/FmaT7NZfH8ta/nu4AamD5kILuvinGQ0JTdJzJqW56u
         rU4uHKxvgCZfsgfo5kxK9qd+XdZzjik7jiFBqEtVoGtNuDjFjuT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 03/22] repository: require a build flag to use SHA-256
Date:   Mon, 13 Jan 2020 12:47:10 +0000
Message-Id: <20200113124729.3684846-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this point, SHA-256 support is experimental and some behavior may
change. To avoid surprising unsuspecting users, require a build flag,
ENABLE_SHA256, to allow use of a non-SHA-1 algorithm. Enable this flag
by default when the DEVELOPER make flag is set so that contributors can
test this case adequately.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 config.mak.dev | 2 ++
 repository.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index bf1f3fcdee..2e19435915 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -17,6 +17,8 @@ DEVELOPER_CFLAGS += -Wstrict-prototypes
 DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
 
+DEVELOPER_CFLAGS += -DENABLE_SHA256
+
 ifndef COMPILER_FEATURES
 COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
 endif
diff --git a/repository.c b/repository.c
index a4174ddb06..6f7f6f002b 100644
--- a/repository.c
+++ b/repository.c
@@ -89,6 +89,10 @@ void repo_set_gitdir(struct repository *repo,
 void repo_set_hash_algo(struct repository *repo, int hash_algo)
 {
 	repo->hash_algo = &hash_algos[hash_algo];
+#ifndef ENABLE_SHA256
+	if (hash_algo != GIT_HASH_SHA1)
+		die(_("The hash algorithm %s is not supported in this build."), repo->hash_algo->name);
+#endif
 }
 
 /*

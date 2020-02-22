Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD09C35677
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28C208C3
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zzjWAzts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgBVUSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39080 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbgBVUSH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A35566079A
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402685;
        bh=+5bAwq2BIkQD0nv7y2dIjQhI+1TCfEBgfO/PHBzhD9k=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=zzjWAztsd6qmLi2GmsWnDE6Q0R+AhxE3XSIOliiynUq0zVYaeQIlsAro4Y1mteuD+
         0gDv8tJyGNPuCPLufGkj4A3saiQmf2A4GMNQkze9LZlYNf6RlrlEEXcjUs7wZVRbUY
         nqR3EA9Za+GvS9Iywjzo0VganCOwHseMXg8y9nT+xxoJ84q3W4cjAXFLk2rBNmwgTl
         a4VjXozolPWatLqvDJHKECWuwT8BX0RRLrmfSrF5aHYH4pvvXo5e1leHqjIsvxEbFV
         +e/lrTy0dZXy4WiDGl/v30ubrJooHZ97BBLBRlStRB1ItUOC4REhITv5bhtYy4/K8Z
         nEbf+AeGgbXoORorGzimCaJhIHuuCaWTrC5xwcbzEPNMrjP1kAu9r+Os60olF5oyzr
         e8KzodUGedcats3nwpp4fst5mzfUm93qpZ899FFCLcuUf7BrOs20KFCcWs0CtTTL+r
         gTIEBqEyPJUv86FENtshZwdc8tE6XMKm14BmNS3PDiR9Abl+kpN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 05/24] repository: require a build flag to use SHA-256
Date:   Sat, 22 Feb 2020 20:17:30 +0000
Message-Id: <20200222201749.937983-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
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

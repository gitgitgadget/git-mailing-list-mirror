Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224BAC43461
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54776128D
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhDZBET (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhDZBER (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F242361479;
        Mon, 26 Apr 2021 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399016;
        bh=US+ST31w2SiyGL01QHu7Cmjinaf8CseSjXZ0+fzdEaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xsi1V5DV0lDWANcJUovvRMBGZk05x7N4fnthGpnXQBv9LLYjdvEDdHQl0KfHDrp7i
         Gt0pdF3hXcmk3iLSi0K4e9PmQ+c1+3V62sH5JZnyaGnzyJ6Wk+J3rBk2y1BQQkqu1q
         EyyDqinOPB6K3huIDQ1qmwG28Va5Su7hMCKCV6PrVY/01C6x2GDpsUV1IGsNY1u5KB
         FAlYL64u7FXCFsNtl9anS2xo9DdcXq0UpvGgjqwsIzi2Lm3zS+r2HF/yOantnJYle2
         y0SPw/FWIIbMzELSy4GQzmSb+VoUShhLDjjHbey31dULfdprLSxIUVbZnBu5dXRYys
         gEmHvMJf1GFw8W1t+ZP8M1r/jKoDHxEIbgsaroAjDR22yl6MAbcpZDPfDQD/GAU2Lf
         u283XTsZFa2XU6OFrE5Pnjm5TqOO7d8r5vbXyDu2zj9qj21WkryvzaJNh+bGOalHE4
         IK3WWohAIQIMWo0btm4U6tvLkdySyZtKZbweSCoGS19+jP2AgJD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/13] hex: print objects using the hash algorithm member
Date:   Mon, 26 Apr 2021 01:03:01 +0000
Message-Id: <20210426010301.1093562-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all code paths correctly set the hash algorithm member of
struct object_id, write an object's hex representation using the hash
algorithm member embedded in it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hex.c b/hex.c
index 74d256f239..4f64d34696 100644
--- a/hex.c
+++ b/hex.c
@@ -143,7 +143,7 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 
 char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 {
-	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
+	return hash_to_hex_algop_r(buffer, oid->hash, &hash_algos[oid->algo]);
 }
 
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *algop)
@@ -161,5 +161,5 @@ char *hash_to_hex(const unsigned char *hash)
 
 char *oid_to_hex(const struct object_id *oid)
 {
-	return hash_to_hex_algop(oid->hash, the_hash_algo);
+	return hash_to_hex_algop(oid->hash, &hash_algos[oid->algo]);
 }

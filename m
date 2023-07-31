Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0487CC001E0
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 12:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGaMPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjGaMPk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 08:15:40 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2010E2
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 05:15:39 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7B7B11F548
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690805288;
        bh=G4pPpd2+hkKA/g7A6j56XV7zn54kD2jy/m585iVtims=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1kJ6LyTdoZRSJ8uUFNzx7WI6GDdzzCka00wNyCVV11FpbAUKpYNF5eVC8VZdwY7uP
         t7+ruIaiDCxGJXJGYx0zgsDNxeDMS5cqNnzjDE5sjgpoYUM81ITuyegZuaCBpPLG9H
         k11UqNlrO/EMVmT/n12MHw9vabUxAsWqkFR+/P8s=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] sha256/gcrypt: fix memory leak with SHA-256 repos
Date:   Mon, 31 Jul 2023 12:08:07 +0000
Message-Id: <20230731120808.1230210-3-e@80x24.org>
In-Reply-To: <20230731120808.1230210-1-e@80x24.org>
References: <20230731120808.1230210-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`gcry_md_open' needs to be paired with `gcry_md_close' to ensure
resources are released.  Since our internal APIs don't have
separate close/release callbacks, sticking it into the finalization
callback seems appropriate.

Building with SANITIZE=leak and running `git fsck' on a SHA-256
repository no longer reports leaks.

Signed-off-by: Eric Wong <e@80x24.org>
---
 sha256/gcrypt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha256/gcrypt.h b/sha256/gcrypt.h
index 68cf6b6a54..1d06a778af 100644
--- a/sha256/gcrypt.h
+++ b/sha256/gcrypt.h
@@ -20,6 +20,7 @@ static inline void gcrypt_SHA256_Update(gcrypt_SHA256_CTX *ctx, const void *data
 static inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX *ctx)
 {
 	memcpy(digest, gcry_md_read(*ctx, GCRY_MD_SHA256), SHA256_DIGEST_SIZE);
+	gcry_md_close(*ctx);
 }
 
 static inline void gcrypt_SHA256_Clone(gcrypt_SHA256_CTX *dst, const gcrypt_SHA256_CTX *src)

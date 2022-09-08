Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E29C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 23:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIHXCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIHXCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 19:02:33 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFF585FDA
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 16:02:33 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11e9a7135easo48426052fac.6
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rVt1Tunem9R9ATZ5WmVvLSmvqu+rolGDpmm/wZ0YAq4=;
        b=hrjqWLq2b+BqtYzERDDDt10sMakbmeIJ77AED7gDJ1Ez0FDmOnaQ+23HNj6wUOB101
         K7BMHKe+MG0S1KWyMPDB8i1RQGop44e3Kr8iVqwctsb7e1ge0G7SPXs+s3FWhnR2Xh1W
         XIK6AEUFZnQEYS+SpnPdF5TeisN44+O73v/qvBluKyTeiwqwwEZD1+MTOttQixsDuCLS
         0Z5uc6vqSW3rnNlY5Zh8/PDXdMxwo2nhIoQuO31EF9BTcNzbUWqXw/HBRTyKm4EBUx2a
         cIW/f4BEVNezAxXAJHYiPeKoxfITqpe/MhAkscFhbGBclT2iB+IszAr8AVfcKFThxhFu
         aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rVt1Tunem9R9ATZ5WmVvLSmvqu+rolGDpmm/wZ0YAq4=;
        b=qXUKI4YIOUBEpWTyM9Rw2nxI/4mMK1LWtzsUOU69bCh0cEz0stmDCu0iDvCbNYUNPz
         dJnikU/hABfQCEZtKbFHEkWLEWwNSR2VOB0Rh3alwJAfaNYCXwDKduspjRY2TLwpItSc
         mjend4EGBHMl9jsxRJCegtO5LVe2AfAvFfSnz1LN2Awj7AN2PY8GcSEC/4psF8Vr946O
         65k7emhOlvGcnwNcVry02wmW6Ciby/sc3FrM6kgUij9LMkVd7PkyzPoFuhBicTHEn/h+
         wsrCck21GzNuNI2h8fncqYjmMqY4gn0pUbEbH7QVJSfREfteseq5VcQvxOKfH8/U7iNw
         Lvdg==
X-Gm-Message-State: ACgBeo3J6W5GyU5a3x0zHNvb6+kEXUxXsCVZgujSNNhLM+SKSCG/dLKy
        vm5xNkMcsLIY/nLv6BQZjL6BJbnEID0=
X-Google-Smtp-Source: AA6agR6pRpuXdya1jnxCM1cPMmm6bTyWJa0NYloPpiE9o/WQD1HGPGuFjLnhp8K5c8g3U5UE57YlaQ==
X-Received: by 2002:a05:6870:560f:b0:127:7d57:9e2d with SMTP id m15-20020a056870560f00b001277d579e2dmr3282369oao.103.1662678152340;
        Thu, 08 Sep 2022 16:02:32 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id n8-20020a056870e40800b0011d23ed5365sm222528oag.43.2022.09.08.16.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 16:02:31 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     gitster@pobox.com, vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH] builtin/mv.c: fix possible segfault in add_slash()
Date:   Thu,  8 Sep 2022 16:02:23 -0700
Message-Id: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A possible segfault was introduced in c08830de41 (mv: check if
<destination> is a SKIP_WORKTREE_DIR, 2022-08-09).

When running t7001 with SANITIZE=address, problem appears when running:

	git mv path1/path2/ .
or
	git mv directory ../
or
	any <destination> that makes dest_path[0] an empty string.

The add_slash() call segfaults when dest_path[0] is an empty string,
because it was accessing a null value in such case.

Change add_slash() to check the path argument is a non-empty string
before accessing its value.

The purpose of add_slash() is adding a slash to the end of a string to
construct a directory path. And, because adding a slash to an empty
string is of no use here, and checking the string value without checking
it is non-empty leads to segfault, we should make sure the length of the
string is positive to solve both problems.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
Reference: https://lore.kernel.org/git/YwdJRRuST2SP8ZT7@coredump.intra.peff.net/

 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2d64c1e80f..3413ad1c9b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -71,7 +71,7 @@ static const char **internal_prefix_pathspec(const char *prefix,
 static const char *add_slash(const char *path)
 {
 	size_t len = strlen(path);
-	if (path[len - 1] != '/') {
+	if (len && path[len - 1] != '/') {
 		char *with_slash = xmalloc(st_add(len, 2));
 		memcpy(with_slash, path, len);
 		with_slash[len++] = '/';

base-commit: e71f9b1de6941c8b449d0c0e17e457f999664bc9
-- 
2.37.0


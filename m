Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52050C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbiCBRLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiCBRL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF2CD325
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i8so3827445wrr.8
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lUjwAuWNRyPLWSkiDNzq/v6QrtFpmgzWY00NA9mmtdI=;
        b=oC05jhlT+R/qqVgobGfVnRCKprhPedXP0kX3vMh1A8hZdqFoRiWoj8FMTmHgdQeJKF
         xoPG4E/Td1Upz1VV8AUSmmiz9o7b7ok7V9em/Uk/ofCO/mmqugi9rh5aADn14I1FYrJs
         kpRyDhZU7bR9YUZ3auOvdB2K15cRe+BYzYV9D9PH0Vqb38dFq9Cw7OkJtozuGM9CXQ8x
         PTvbT6UtRyk3xkG2cBb5Zj3sHFeZttGkRsyBgLB2HWyWnwQxPJTmi5N4VHUKVx9rBT4d
         pBNjdlEoIzbZpdDJO/30O/c3BFNK382w2JW3tS/fMo6QNC0EyDt+hSv2AFOlD9k5vtSC
         5J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lUjwAuWNRyPLWSkiDNzq/v6QrtFpmgzWY00NA9mmtdI=;
        b=l2B1WEqimP8FPFWOkX22bbH5BEbBG7XEs5IYd3RQQzkR2E8akHcUUQR0I2OM70wQXD
         zkyJj42e6/9VG+tJ0aUemdtqCsATd61vjKb49+8oo5+JaopohOh2/4rO4Q8KuJA3NWHu
         ZP9WWOadgI0qqoe38jGcT2XGy1k5dVmFEom0zMeObhyCetiIzg8dxdzpY8HSiJYOSCGV
         yRFeh6Dh8eYP1ZHyhYTg/g4HwoweV9kZQyvGe0wsUSusaJDDCvMACCD6cWnQmsl8+ODL
         0+RYKuj/m/JkUbU+3f0JCzmtSkjmLI/ll6vhlunt2oUJp9qPd/7Zd73JYOmck2UowXIv
         rtIg==
X-Gm-Message-State: AOAM530TMpcsuej/L7j/d5zJR8QNEgvTqRI3Jt7e4lQcrRastlpWTvAG
        qR6MyGRO+seu9oaFS+dMX8d8VS00XL/M9g==
X-Google-Smtp-Source: ABdhPJy8bCDUnDf5Btf6NzUhmOilZpMXrG3uICrqL6PGIsM/EVNuEbJkED9ap9npZUVkyzVRa4fhiA==
X-Received: by 2002:adf:fbcf:0:b0:1ef:d5f2:23a5 with SMTP id d15-20020adffbcf000000b001efd5f223a5mr11344535wrs.567.1646241035664;
        Wed, 02 Mar 2022 09:10:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/14] range-diff: plug memory leak in common invocation
Date:   Wed,  2 Mar 2022 18:10:18 +0100
Message-Id: <patch-12.14-6d13c2530db-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a public release_patch() version of the private free_patch()
function added in 13b5af22f39 (apply: move libified code from
builtin/apply.c to apply.{c,h}, 2016-04-22). Unlike the existing
function this one doesn't free() the "struct patch" itself, so we can
use it for variables on the stack.

Use it in range-diff.c to fix a memory leak in common range-diff
invocations, e.g.:

    git -P range-diff origin/master origin/next origin/seen

Would emit several errors when compiled with SANITIZE=leak, but now
runs cleanly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c      | 7 ++++++-
 apply.h      | 2 ++
 range-diff.c | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 0912307bd91..01f91816428 100644
--- a/apply.c
+++ b/apply.c
@@ -219,13 +219,18 @@ static void free_fragment_list(struct fragment *list)
 	}
 }
 
-static void free_patch(struct patch *patch)
+void release_patch(struct patch *patch)
 {
 	free_fragment_list(patch->fragments);
 	free(patch->def_name);
 	free(patch->old_name);
 	free(patch->new_name);
 	free(patch->result);
+}
+
+static void free_patch(struct patch *patch)
+{
+	release_patch(patch);
 	free(patch);
 }
 
diff --git a/apply.h b/apply.h
index 4052da50c06..b9f18ce87d1 100644
--- a/apply.h
+++ b/apply.h
@@ -173,6 +173,8 @@ int parse_git_diff_header(struct strbuf *root,
 			  unsigned int size,
 			  struct patch *patch);
 
+void release_patch(struct patch *patch);
+
 /*
  * Some aspects of the apply behavior are controlled by the following
  * bits in the "options" parameter passed to apply_all_patches().
diff --git a/range-diff.c b/range-diff.c
index 30a4de5c2d8..b2a2961f521 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -165,6 +165,7 @@ static int read_patches(const char *range, struct string_list *list,
 					    patch.old_mode, patch.new_mode);
 
 			strbuf_addstr(&buf, " ##");
+			release_patch(&patch);
 		} else if (in_header) {
 			if (starts_with(line, "Author: ")) {
 				strbuf_addstr(&buf, " ## Metadata ##\n");
-- 
2.35.1.1228.g56895c6ee86


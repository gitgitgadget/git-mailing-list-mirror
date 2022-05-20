Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6CCC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354060AbiETXSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354057AbiETXST (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7092F1A491C
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id u35so8855557qtc.13
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zg8D+mVhTqbxYEbGanVURWql8MDAlH6HQ57KJAQ9z7Q=;
        b=PAp2aB7UJ0iAFYC329N3K7/rbexG6tqSfMcg+HzGF9Nh7pZavJ+X/7rix4Jv7MLp3U
         /A8uMr6gaSkhRmZquA2zpc7ctDhLDAk4WkhR4U7FAT1SQ4NBt5tLmTOzJdH6Hz8xznNX
         DQsaxQ+3MyoJ+3FMpeB5tW780QBIHlANzCqb2Jdsjy/zjS9O6nQcpZeMcnAlyEagf6Of
         WqQRdjNbhvhWqM8px08PYxY3s9qxZi6oGyhYD+3TakWzlWpn8wDxvfU8TR8HDqSgYZg5
         U9LZ/nzAInfGu1/JFLW1qa1Z6f5Ixz66/wQ0CQUjoA6lXPHoawK7c5qQQZsE/lb5r2vK
         DD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zg8D+mVhTqbxYEbGanVURWql8MDAlH6HQ57KJAQ9z7Q=;
        b=EhhPxOpPTPqhCo9/Sr7tU7Jv3NqYutWrq80Wbz3AGme0hl0q6JKw8DztX63ClbfLqm
         +jsr3/jhU4BCAoe8jAsKNu665LPf9BMydtNeSlohqfxACLWQKS2qYDxbbY/bc4jXi/K6
         8J001pynUDmv56IRFAwUBniLi58GslIjA90gEI4tKyLjqUGCVSauNHY4gJ4sTBT0liur
         02VLuVd40toRtwAt3ElmwbY0FnKmzPPA3rGNDSrLNzm4w+HYV2y3xYDvaup722fg9aPd
         ftCNIl59qqvNNvoraM+CQFz7haWJ0k7q1PvZp6GMrYDX6/RfFW7UUysU6helMLxQ7dDP
         /mhQ==
X-Gm-Message-State: AOAM530EAb59wtePXHmcEdbpkGMiTn9zyov/C3h9t3Acv7A3k8+nRI1j
        u4S349WoBc1YopCPXcbFEoHddokO/6Kpg+ly
X-Google-Smtp-Source: ABdhPJzgYpDMyx+5Qm6tYFhX7GdzmwBB7x2zh6UuG7QhpuvdfNdGLWltuOoaW7Jn0XY/M9vwCgfq+Q==
X-Received: by 2002:a05:622a:2c2:b0:2f9:db4:2b56 with SMTP id a2-20020a05622a02c200b002f90db42b56mr9451069qtx.540.1653088690024;
        Fri, 20 May 2022 16:18:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v4-20020a05622a188400b002f9094e8a5csm562851qtc.53.2022.05.20.16.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:18:09 -0700 (PDT)
Date:   Fri, 20 May 2022 19:18:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 14/17] builtin/repack.c: use named flags for existing_packs
Message-ID: <f9e3ab56b1a8801f95a46b42084d5c7f923a8fc9.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the `util` pointer for items in the `existing_packs` string list
to indicate which packs are going to be deleted. Since that has so far
been the only use of that `util` pointer, we just set it to 0 or 1.

But we're going to add an additional state to this field in the next
patch, so prepare for that by adding a #define for the first bit so we
can more expressively inspect the flags state.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b85483a148..36d1f03671 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -22,6 +22,8 @@
 #define LOOSEN_UNREACHABLE 2
 #define PACK_CRUFT 4
 
+#define DELETE_PACK 1
+
 static int pack_everything;
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -564,7 +566,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, existing_nonkept_packs) {
-			if (item->util)
+			if ((uintptr_t)item->util & DELETE_PACK)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
@@ -1002,7 +1004,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			 * was given) and that we will actually delete this pack
 			 * (if `-d` was given).
 			 */
-			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
+			if (!string_list_has_string(&names, sha1))
+				item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
 		}
 	}
 
@@ -1026,7 +1029,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (delete_redundant) {
 		int opts = 0;
 		for_each_string_list_item(item, &existing_nonkept_packs) {
-			if (!item->util)
+			if (!((uintptr_t)item->util & DELETE_PACK))
 				continue;
 			remove_redundant_pack(packdir, item->string);
 		}
-- 
2.36.1.94.gb0d54bedca


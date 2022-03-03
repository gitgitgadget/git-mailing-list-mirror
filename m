Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE1C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiCCAWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiCCAWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:22:09 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4513D900
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:19 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i1so2770095ilu.6
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MEmXxd3UfEXLl/sVy5AcsqzJ2DK6P3effos5SpxBajY=;
        b=olyKhuOOapUWBA+fFeV0MHZ2lo230nBS7ZhsTVX9tu7y6pdXuqhEduDCmApQPS/+1D
         zfIxvXvJF81BnZ1XXTCSGMYA12EpyzIEogLCdBKsLKXGolbat05NZ21F9NVkugiNYSeu
         bUIt2KkfBs6EA86zJRXTtJYaJyxr4BxCgwR3jn7LZShUks0+aNo/OxittqnnTWHwxnyo
         C5Jq7U8NxcFioufbzsxKmnfg8fM6WTBmIZQXM5hFwLt2PjYrH3WQj7kbWv/zvTrRN1HV
         YMtILlRq8M/WXrEgC7Jl2QFSlrGsoVTI6W4kXwTH+Z6PBK857ma+O/J2DZpFuOcaGLuV
         5/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MEmXxd3UfEXLl/sVy5AcsqzJ2DK6P3effos5SpxBajY=;
        b=VhBqBqVe/8gQdjkFg2A0xW3kAVA4m2k36s3Q0Dobsw0IDaX9PaON96UUbpNaE8Cl4v
         BrvhSy1Dykubz1ba8gO4F2MzxKfgLwN3XvvElwg2UowIKExoIuluxu37UESaLG8wNJif
         plLvYMyPDvF6Vln6VKAh+U7awBEkPAGebAWCsyeKLfBIunZgN7AiwJOM68vhWoLoOwqH
         f4L/hGbbKvEqcDxjuou1OBlh+8cNJ+Ie0gxQYsnd6KlFQCezHVyhZ24bgnCt9hZ++tdb
         Q0ixMJsYyAGGOTwksSKeIDXvWTr2Exh4LdVkXtyDyG0FHO4zdvfsVH72eVQ5uJEYN1i8
         /nsg==
X-Gm-Message-State: AOAM533LyFBJd2GZIMA0GdKYcWJmF7X2iVq4pDSZlxJJzMuvjPV3X1dd
        3HXMnV600Ak9FEKEwzB9IO4ktZbj88XJ6f87
X-Google-Smtp-Source: ABdhPJyzHKOanqrxkeKlM2EVAHONB0yEStpS5M50SR1qQXlSlCJRlQqVPvvxyMqtL9FKK4FQtIyh3Q==
X-Received: by 2002:a05:6e02:1b05:b0:2c1:7111:d67e with SMTP id i5-20020a056e021b0500b002c17111d67emr29200913ilv.73.1646266878824;
        Wed, 02 Mar 2022 16:21:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k11-20020a926f0b000000b002c2756f7e90sm300620ilc.17.2022.03.02.16.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:18 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 14/17] builtin/repack.c: use named flags for existing_packs
Message-ID: <1a58807df02aa6cf487599b2d875a7a24dd16a32.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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
index d61c78e94e..afa4d51a22 100644
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
@@ -561,7 +563,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, existing_nonkept_packs) {
-			if (item->util)
+			if ((uintptr_t)item->util & DELETE_PACK)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
@@ -1000,7 +1002,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			 * was given) and that we will actually delete this pack
 			 * (if `-d` was given).
 			 */
-			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
+			if (!string_list_has_string(&names, sha1))
+				item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
 		}
 	}
 
@@ -1024,7 +1027,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (delete_redundant) {
 		int opts = 0;
 		for_each_string_list_item(item, &existing_nonkept_packs) {
-			if (!item->util)
+			if (!((uintptr_t)item->util & DELETE_PACK))
 				continue;
 			remove_redundant_pack(packdir, item->string);
 		}
-- 
2.35.1.73.gccc5557600


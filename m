Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667DAC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiEXSyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEXSyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:54:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B55A17C
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:30 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e93bbb54f9so23345563fac.12
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D7LV9vFMN1YJTuI2n9SEbJ5iJsxmMil2bdChPnPBV94=;
        b=plOK/KXSBpXUrUukKzdk5/9fcQMGLyd+MVb9m973UnVpwYhP8Q8Iv/PpbBqIfRwyvW
         LZOXInR6046rpShXZWRCfW/6HXY1W/0o5i9W+o3LIV33n4RwxTAOeyDUoX/oLo0WsFbC
         BRHuM5nzUJ2x03kCd/IMpgNNUz6fzBCrNvYlaaFy/V5DqyGX7m8FsNL3FPEBxVusSCPo
         K0Zl3TTNpjGeo/Pm10ldyBXLqRzASaqVeFsMhAvKb3wuQUwI6pFC2L/A1mXgKZSmb32t
         69HUsFDYxRR+yXttK5izxbViAhu1Uko7E6yG+YVNrX5zN6r03XYpVWB/vklKvoCEv6L2
         Vygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7LV9vFMN1YJTuI2n9SEbJ5iJsxmMil2bdChPnPBV94=;
        b=W1n0V6x5HR5VFGNI3tnpXNMyh4kRgnqAvBtuNDTdee9UwZa+Ji/KIn/qJ2i6H+ompI
         g8P0Iz/bKFCb8hSN0xjRjV/yT8oqJSDt/FQO+Yz2eCW0MW6aD7SMbGogDJou2YYhyqTk
         iXVbNNn2Gz2yFJCBQEEmVcakYiUwKgnPruFfAIBob3E8LyU/aJf0nkA0lhwQeyJbWKY1
         qXSkbDOgGf1/f0Ci9aQ4QigYUbVuuSsLAH9RBmNg1yHsyoB3uq/KQygzkJLU96KLA3oG
         5j1o2XsUseF+XDrSqLSpIQsyAbRTfldROJ0A6JX3HJ/RNTljFqAegqHwG7/Ca4GvtfNS
         uf3Q==
X-Gm-Message-State: AOAM531NbIlsZ22N6pVlMzBhepMCjfswF2XEuvdxLUj7L3Yghc6Y75O2
        BVwodjwyjSC14xIEQmxhbgLoXq7c75U+KQ==
X-Google-Smtp-Source: ABdhPJzoFZnpatUo0uSNBjW5BIz7nIe6JtlhHxjzXYFeK10XekPUc9NQliulNXF4SQLTHqoRN7Ydxg==
X-Received: by 2002:a05:6870:fb94:b0:f1:92e7:5501 with SMTP id kv20-20020a056870fb9400b000f192e75501mr3345624oab.283.1653418470086;
        Tue, 24 May 2022 11:54:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870920200b000f2776dd2acsm2240061oaf.27.2022.05.24.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:54:29 -0700 (PDT)
Date:   Tue, 24 May 2022 14:54:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v2 2/4] builtin/pack-objects.c: avoid redundant NULL check
Message-ID: <2719d33f328e03239cdb2f5cca2fef9a4e9cbb93.1653418457.git.me@ttaylorr.com>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653418457.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before calling `for_each_object_in_pack()`, the caller
`read_packs_list_from_stdin()` loops through each of the `include_packs`
and checks that its `->util` pointer (which is used to store the `struct
packed_git *` itself) is non-NULL.

This check is redundant, because `read_packs_list_from_stdin()` already
checks that the included packs are non-NULL earlier on in the same
function (and it does not add any new entries in between).

Remove this check, since it is not doing anything in the meantime.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 014dcd4bc9..ec3193fd95 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3369,8 +3369,6 @@ static void read_packs_list_from_stdin(void)
 
 	for_each_string_list_item(item, &include_packs) {
 		struct packed_git *p = item->util;
-		if (!p)
-			die(_("could not find pack '%s'"), item->string);
 		for_each_object_in_pack(p,
 					add_object_entry_from_pack,
 					&revs,
-- 
2.36.1.94.gb0d54bedca


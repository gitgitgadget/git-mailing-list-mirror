Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE68C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B201761183
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhJUDma (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJUDm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:26 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D11C061774
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:01 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d125so27271911iof.5
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jH1fzBQ+o6N7ARCnMCP2GRXkwznvAiu34mObQxLor3A=;
        b=8N1MPRB83RaDgKgH2TnDkp4Bs4i43cYiLdTJSq/jgJFkEy3ulS/DITvV7BR/ndAYJA
         2aCL74sCqNjQw7BOXgEMeV2Ur2vJ7ykkuuHCnfpuVFDFSCHA+x1uY8UTtWtTNSGqq7pk
         kwzlfBWQC9oWLX10dHOOb5lvsMIu25O/u9863KQher8mvQu9e9DW15G5oKVL5iQXb40s
         ruG4wtgvRvmFU4hqP/gkiuky7batkTwWtTIcsjhnIOx0K9CSvS2qtIXEoa0PZ/ZCnsCo
         6oNSdNSjRTXdtA6puQ/J8XxSb9uMxJrgzz4W+cBHn2Cq/QQlc8UTJMiyY0R18CTLbj27
         7ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jH1fzBQ+o6N7ARCnMCP2GRXkwznvAiu34mObQxLor3A=;
        b=5K5tqhFfRnABE94yAb9lD8vJ/Hjvb/q2bnD8gm6ZwEtHcpyw2/uquDzgA0AqyZjl20
         H5qMwv3k+QmvUWBmpX7cE6F8uNfQXxyBdpHPzLD+U9jRk3Rum6P2szCRLAaxhlTYvbNA
         Y9VJNu9xN2q3AoqKBth5MQbJTdb3K0LgF6Krn3UQRc8mP9sLNgp09dgiRG/6eT4vds/d
         A4tRUpwYz3nSyDSaVX2a8YCKBUq5JCkyrZh1WEIDKdNo9vhftfssXEudp8VpVfpt+utT
         j1MVZJjSCjuvm2M62/iaSBGhNVnH74HrpSuV7d+WXKOiJZby0SHHS8wq8xcBr8LxFQfR
         4gGA==
X-Gm-Message-State: AOAM533pscbWPpeX64VisYuYnBiJ5ZhCBOLENe/PiNvdlZ3UBa1/64w0
        GIOdZH9NtdsNvHTTHxIELoNz5J21IjTV0Q==
X-Google-Smtp-Source: ABdhPJzlEebETtMtq7JpkPwZHYl0U4uBYbQTatFPBW4Vl33mWWsK+elpOGlaiDuKXmNs56cr92t+6Q==
X-Received: by 2002:a05:6602:2c91:: with SMTP id i17mr2315224iow.20.1634787601109;
        Wed, 20 Oct 2021 20:40:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l5sm2033783iln.50.2021.10.20.20.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:40:00 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:40:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 06/11] builtin/multi-pack-index.c: don't leak concatenated
 options
Message-ID: <ffded80c7d20b6e22683f6269208d0a73dee67c6.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `multi-pack-index` builtin dynamically allocates an array of
command-line option for each of its separate modes by calling
add_common_options() to concatante the common options with sub-command
specific ones.

Because this operation allocates a new array, we have to be careful to
remember to free it. We already do this in the repack and write
sub-commands, but verify and expire don't. Rectify this by calling
FREE_AND_NULL as the other modes do.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 075d15d706..4480ba3982 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -167,6 +167,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 		usage_with_options(builtin_multi_pack_index_verify_usage,
 				   options);
 
+	FREE_AND_NULL(options);
+
 	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
 }
 
@@ -191,6 +193,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 		usage_with_options(builtin_multi_pack_index_expire_usage,
 				   options);
 
+	FREE_AND_NULL(options);
+
 	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
 }
 
-- 
2.33.0.96.g73915697e6


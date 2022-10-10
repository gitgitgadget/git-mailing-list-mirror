Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A72EC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJJRle (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJJRlc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:41:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065661D4C
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:41:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d142so3013529iof.7
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5RflWeMn2+94lg90TehdKgz11e4y+p7hgOENTVL9lc=;
        b=szmgOIBDsurzmSrUrr7fES8BeUxPLl5EVNpWqfbWdQNle3nMfAcyRuuYKBMWoy70wl
         pF0ubkivIYxdY3i+oqGhmQCbAmvgWlyv6G2Q37cixDpX//PVR51KUKjV/+mxcqrPVv3e
         L5Mc4D05wZ2bRGuNi1Nb0krdleFHgzyHYe6vTyToO7oEujhWot3Qouore5RrZ476LXqU
         BqPbejXm+R5yWBB6c6OVT/cfL2mf58CCPpGMd/s/hEXBR0YzCcr+Z665zhI8QsQTLpzF
         9w8of0DXGmq9j+HDgKjTaLX1Z/8lhyv70jdCNBW9/4btQePFB1s8GwFO4ABR1O4xnJRw
         8QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5RflWeMn2+94lg90TehdKgz11e4y+p7hgOENTVL9lc=;
        b=drQOI12jx7ShJy1EZctxsaGyx/0BwJ7oZrSyBG+AkfDmWtEVVYqQ+6L1UupCz9cdeC
         i91JYHrFn6d3ZBYa7+xTxglInI2TePWowVFGWon+sFjzGI+X/LU9jtkVZkdkYoTVwZUs
         Dr0B76ZaOz5ljh37ZHD4Oe0iRSDKrAGSzb5kOFcLIIvbXcfNGtlYwIM5jsUMOBu5N04w
         ZV6lS/XucbrJH8u6sBHBxPacwobrDnEjiVAi62zbk/WJe5xuuMG90D9O620wRjgQhuFk
         g6LzmLHwVDTZSaqQ1GyAXl5pkeowMl7CQZxTXWJ9mWpZxoNmyhSyMdkZQWmhhP3tOgKm
         C2Pw==
X-Gm-Message-State: ACrzQf2M5oC7bLqiWMsSXpiObDsksBCSCTG3sdnqFKsAK5Lphi2ZHdwL
        xRndRGLu3HiUWvldzkm7/YdsNyjHi549+S0v
X-Google-Smtp-Source: AMsMyM5NsX5SgmuH/2bASPbNE+Pn8B2ZwE7vLfSJrUPdJrRnpTTphx1MxvACAErl0dtxyQS/PE6Tww==
X-Received: by 2002:a05:6638:1606:b0:35a:5472:fa1b with SMTP id x6-20020a056638160600b0035a5472fa1bmr10238833jas.241.1665423691166;
        Mon, 10 Oct 2022 10:41:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q14-20020a02c8ce000000b0036378825c31sm4214451jao.70.2022.10.10.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:41:30 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:41:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     orygaw@protonmail.com, rsbecker@nexbridge.com, gitster@pobox.com
Subject: [PATCH 1/2] t4202: demonstrate `git log --invert-grep` segfault
Message-ID: <fa27aca12c46d2934baa594c05b7b3d7672e0be6.1665423686.git.me@ttaylorr.com>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
 <cover.1665423686.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665423686.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `--invert-grep` is given without a pattern, `git log` behaves as
normal. But as of f41fb662f5 (revisions API: have release_revisions()
release "grep_filter", 2022-04-13), this doesn't quite work because we
try to dereference the NULL `grep_expr` pointer in
`free_pattern_expr()`, leading to a sgefault.

The subsequent patch will explain the bug, provide a fix, and update
this test to expect success.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4202-log.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index cc15cb4ff6..e3ec5f5661 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -297,6 +297,12 @@ test_expect_success 'log --invert-grep --grep -i' '
 	fi
 '
 
+test_expect_failure 'log --invert-grep (no --grep)' '
+	git log --pretty="tformat:%s" >expect &&
+	git log --invert-grep --pretty="tformat:%s" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --grep option parsing' '
 	echo second >expect &&
 	git log -1 --pretty="tformat:%s" --grep sec >actual &&
-- 
2.37.0.1.g1379af2e9d


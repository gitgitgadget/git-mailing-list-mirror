Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DDC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCTQUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjCTQTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B4EC7F
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d17so2468387wrb.11
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679328693;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kt14L+siK06aGwaa0y3SCTDFzkBihIf93pRnykwQbcg=;
        b=IXDCLRzzDgQlo6RveZ143WB0tWXO0efXwMjVkDd3bB/oOfcqcQzHKhDRo56qkqX5Ux
         BF0ZpiOlBaWEdmBUtZ2UrqdFYaU5iR2ZYXlfA97nDDh05jYA3b00PlZSsJ4nzjelWxLB
         y6N6SbGVZ5rR3VwwP/2/Lfz5g/FUASTfdmMuJiNCmJY7Wcjc5WrpeZLpGOYV2mAmyuTf
         4FezeyRdErtHfv9RKJXUROpfZ31DJmRtoyfdZAa91lGVwbYJLtzjDMHGMOf2q9lNLRnD
         qRPzVNDLup0jggK/iO6d1JTZdvHd5gjxafCiLNSl6FB2iEcSkZUvZUzhKwbli409DRgr
         ui4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328693;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kt14L+siK06aGwaa0y3SCTDFzkBihIf93pRnykwQbcg=;
        b=DsM3xX3KSheHdBgzz672otFQESwROPpKyG+2GMuvnssrtBgpjmfevQQnPefcOPCV9M
         MKtS1MOlfjiql3NadqBtRHdYZXso3gCYtqFYUqt9JmEo079PbVM3yM9CyuYgU7CLEDKV
         FanfaFNt2lhIgnrGUv83fdszLwp7SVUVMtd8TpNP9bigj1MtiAnXKsOM5QpLJ/T/8qup
         gnGH/XuRSskN/sw8/dYyT1zl5nO/Rg859A5uKrb75tfUNusCVLDWhgkRnpZCidQQ+C7S
         K5a4oAEktdnB/tUPOaL3GVpP0zLcR/HlnW0dc9D+LFBdzCecZ6sAwAPhmtV6rSCo9g8r
         /avQ==
X-Gm-Message-State: AO0yUKVzuipDaeAzAM2L5zmPiyHh0yQl3czDmVLVuVm64B81PZUnhyaj
        g2C1LBcLdySZPd4PqH8ila/FlOzmOcg=
X-Google-Smtp-Source: AK7set+Dlf4vssfGRVsZD1o6ujy87gK4e3ypL5IljfkZwRgRTNEZVZZR0aIAPpWf5Ywt0HvbSZQaRA==
X-Received: by 2002:adf:fc0f:0:b0:2cf:e87b:5c52 with SMTP id i15-20020adffc0f000000b002cfe87b5c52mr13523599wrr.18.1679328693749;
        Mon, 20 Mar 2023 09:11:33 -0700 (PDT)
Received: from localhost.localdomain ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm9279628wrs.22.2023.03.20.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:11:33 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/3] wildmatch: avoid undefined behavior
Date:   Mon, 20 Mar 2023 16:10:01 +0000
Message-Id: <c6f2d44622f10cfee3c48a7d13b3de9607d1061d.1679328580.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
References: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The code changed in this commit is designed to check if the pattern
starts with "**/" or contains "/**/" (see 3a078dec33 (wildmatch: fix
"**" special case, 2013-01-01)). Unfortunately when the pattern begins
with "**/" `prev_p = p - 2` is evaluated when `p` points to the second
"*" and so the subtraction is undefined according to section 6.5.6 of
the C standard because the result does not point within the same object
as `p`. Fix this by avoiding the subtraction unless it is well defined.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 wildmatch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 06861bd8bc..694d2f8e40 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -83,12 +83,12 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 			continue;
 		case '*':
 			if (*++p == '*') {
-				const uchar *prev_p = p - 2;
+				const uchar *prev_p = p;
 				while (*++p == '*') {}
 				if (!(flags & WM_PATHNAME))
 					/* without WM_PATHNAME, '*' == '**' */
 					match_slash = 1;
-				else if ((prev_p < pattern || *prev_p == '/') &&
+				else if ((prev_p - pattern < 2 || *(prev_p - 2) == '/') &&
 				    (*p == '\0' || *p == '/' ||
 				     (p[0] == '\\' && p[1] == '/'))) {
 					/*
-- 
2.39.2


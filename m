Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFB71F42D
	for <e@80x24.org>; Wed, 30 May 2018 17:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeE3RFA (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 13:05:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38963 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeE3RE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 13:04:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id w12-v6so7208170pgc.6
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L4equ/AoTvD4cLgPIvPYhbVrFKXgPNkfrnk7RvkSIA4=;
        b=GTmeNXFr6aZPDO1H9/Fukag06Pk06+Ji1H593E1sz3vBWofYZGZesok5IBoGO8iV3o
         85iOjOLOoRCOqtkTHFE4mDiBhRID83qNFI8cuBt9XG+0h+PXu68M52rbUFW5IjFY7VCk
         KR9JjvmWutUFU3g84Snum2Lln8wKEiK9uQ9HP1e7nXcP4AmcRWgDBq+HQObZ93UMpdmF
         R9xeb2yBRc5uUNcur38lQvsE0ns6UrLd536yChcjDht8EYNNScFIS3o3nLgDPnaJwT09
         A0Yy0zq//IvbSCuNa0w/e7l+Dh4pPjUQTbwGoD9sLrZngMWFg3z77myIJrWFqrgC0+bH
         Qyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L4equ/AoTvD4cLgPIvPYhbVrFKXgPNkfrnk7RvkSIA4=;
        b=i2ZgHIOUv20StahIp7vYXPOvW7dU4AijoQ+MiPWga9w9HKbHKgo0RPRygCi9MeHa4G
         vhBAWujicGhlF0B6XHmw2FGWzJCi1n2HOv0AD8Xd50eUQav1be+BjAEondzCqJyUxjWH
         JN2JNU6mjBiuns/3wAk7L85S0/hTwYnuvyzxxQ9Gv3VeR6pbOmlyQRHnqNEDxkjXiK5V
         fLp/XntK8haEpe8IXej4i70klFnotySMY4IKRb89BJjMcSM3vwLXsH3m9OYzoRmmyWO+
         3Z18TFCxmXG+lOqTptFfeJNdQpimk/KWAYUegvbX2uEWUAaI4MoPIqWGGia5iv88Nx2b
         Rr6Q==
X-Gm-Message-State: ALKqPwePqLPYkGCR8dmG7DpJDXgrSlhfDzcpZHMQm6TBPvmL4Junz57Y
        26t4Pob1BuSdlZuvc1dat9/rLYyiQfA=
X-Google-Smtp-Source: ADUXVKK3gl8L845a2CQ4QMXZidDWFLR9zzlTNRAf5A9viIqmX0KUJMIlHPssdt8PPG+Mqmi/v/vacQ==
X-Received: by 2002:a65:520c:: with SMTP id o12-v6mr2858600pgp.350.1527699898662;
        Wed, 30 May 2018 10:04:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l9-v6sm77352656pfg.146.2018.05.30.10.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 10:04:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] refspec.c: use rhs in parse_refspec instead of potentially uninitialized item->dst
Date:   Wed, 30 May 2018 10:04:33 -0700
Message-Id: <20180530170433.191495-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'item->dst' has not been assigned if '!rhs' is true. As the caller is allowed to pass in uninitialized
memory (we don't assume 'item' was zeroed out before calling), this fixes an access to
uninitialized memory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

applies on bw/refspec-api

 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index c59a4ccf1e5..ea169dec0d3 100644
--- a/refspec.c
+++ b/refspec.c
@@ -108,7 +108,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		 * - empty is not allowed.
 		 * - otherwise it must be a valid looking ref.
 		 */
-		if (!item->dst) {
+		if (!rhs) {
 			if (check_refname_format(item->src, flags))
 				return 0;
 		} else if (!*item->dst) {
-- 
2.17.0.582.gccdcbd54c44.dirty


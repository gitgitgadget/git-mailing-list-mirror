Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B75E2018F
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbcGKRXZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36637 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564AbcGKRXX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so15279928wma.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r7MVx+q0TUSuK1Pm8P0VmfB8hEkBaIZIHgndrhKytkE=;
        b=ulzKWQExtrMFfTFclrT/kv/b5C5cYg0F7YI2cp5pmuBCHfvLMnnNY43MCtCYPpky99
         mrNfZqFYKCes4E7o6BWH+Lx6zjf+XjGkUAzhX4pK38m0wAm3DHioUoo8qgZb5lpuKytx
         gdRvAPXn+uWh1aFUdin+5HH0XQyoIpzcYPhRDJHDZFymUvfZbbFu/SDd2w9QJrU9cWXp
         HhCfa47EkBxWCgxco3M/GCQUtEyw4axvLYz0vc6zqA9S9oqduu6V+NpLsQ/B4k+J0DpI
         DHiDiIhLqgfdaaiKlcNYFZOBufRBkfvkHdk5lY6MdtYRxKIBfeMuuvLwU1g9ladtCRdf
         +7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r7MVx+q0TUSuK1Pm8P0VmfB8hEkBaIZIHgndrhKytkE=;
        b=PKFf6cSTQHAcVgY3ysAlzhufc2gpDPxlu1wK69M6wGDzP67Cgby+NVCVAXg2i/6Ryv
         qKAhSX1fz0SHTf/PftqXPqQhvleWZdjXMVYVl5AcUCraVjbKRGG24kR0BR7k+MPUqnUS
         UuUB0w67BeHUbTapaU76LjACZ3TwP3cPMzw2XcabgtWthG+cPpB+Y3EoywCRDzWxq+Bi
         qLPcB33bwU5q0cems3Bt0U5ZEzonttb7o7F4is8fSqNzP2P1pJj2JZKB2UR11/4exWXL
         ySggdgZFi/vU0+D5ftYdp/hoGQW3nE41gRP5cwRHYh2pO+MvrRyg/bk/HM8bTsefBoGm
         zzlw==
X-Gm-Message-State: ALyK8tLSDm7Hvc6xrMrCwQsqS2qNzzCmf2HF4p7K47+kFmzsowFMgcjA/gRes/ACOYv+AQ==
X-Received: by 10.194.152.166 with SMTP id uz6mr884035wjb.89.1468257802000;
        Mon, 11 Jul 2016 10:23:22 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:21 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 3/8] read-cache: add and then use tweak_split_index()
Date:	Mon, 11 Jul 2016 19:22:49 +0200
Message-Id: <20160711172254.13439-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This will make us use the split-index feature or not depending
on the value of the core.splitIndex config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index db27766..ae292d6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1538,10 +1538,27 @@ static void tweak_untracked_cache(struct index_state *istate)
 	}
 }
 
+static void tweak_split_index(struct index_state *istate)
+{
+	switch (git_config_get_split_index()) {
+	case -1: /* unset: do nothing */
+		break;
+	case 0: /* false */
+		remove_split_index(istate);
+		break;
+	case 1: /* true */
+		add_split_index(istate);
+		break;
+	default: /* unknown value: do nothing */
+		break;
+	}
+}
+
 static void post_read_index_from(struct index_state *istate)
 {
 	check_ce_order(istate);
 	tweak_untracked_cache(istate);
+	tweak_split_index(istate);
 }
 
 /* remember to discard_cache() before reading a different cache! */
-- 
2.9.0.250.g7087ccc.dirty


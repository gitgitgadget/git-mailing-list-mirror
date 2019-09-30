Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3B31F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfI3BvT (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39492 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BvT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so6410954qki.6
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HEIHFvzdwAhSMqiGSbq8PfzCVlfGdZT5BATSO8gHVmU=;
        b=RkUNq/LNdMHm7HRBzzVc0GmdEDNOEMWmJSWIUYu71hW5qOgdac0+6u2AEe4jp/ybo8
         Mm8Xq/wEqcHgANA8/vxGg9QB4kP5P1HtDzp6OB2vF7tTmYQ7Yyp1rRCuI7TF34FvTlps
         fiU67c2RZTSEIG4mLjlf0xVXzy7uDuBvPixtlkXIuBmqBn6UlbLgk//T3nw+7C6Lr8+u
         bUbjmZBXwSLGVdkLokdlEEy32vBUzdql1Be0Tk5Qv4ovQQknTno9NPl/bs4g2EvTatyZ
         TXgJbrSVG96tvM7NNS8LyhOLklE9E2553uqiw8GCQkBciC8jyvkM3scZjet2sMTwQBMv
         g1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEIHFvzdwAhSMqiGSbq8PfzCVlfGdZT5BATSO8gHVmU=;
        b=GJ+PO/7Nw3wcpIFpCWDhBUK/k6d/clVUV+VqaMRSpJjRMiIPxRgPN/8/2YH3v7/41C
         /89brz5GbJ8MHiJFF2oigjjnswTRInwlMlZdNHoSfdyqjyiMUfpzvgAEKVHRJWNzxQ2I
         rZjqng7CeaCKFmZjIe1n2HWOuI+g03vEZ0tH3pPnGjLffTYmFAGfxhInKToY9T2Qbz8t
         dyfPBz5gmdbOBmlo9Jjv10ETwkoMFia82Tl6L5jWgo21ezeZQnyqyJ0t7cmFMP5OGQrq
         LTMcQRCr0twduG/CImrfSbpu0rUE8kiBTty5lpw5cgYE7sjwv7oZmxFuUWxQcQl2MDFU
         QZRA==
X-Gm-Message-State: APjAAAVCgLuMNo+uTPxOZ6hmL9FdTfbvG+JCcg/IHLVZYlYUxBsik2OK
        ZrqY1p71Xvz80IbYI8A1W/VPNMSCvsE=
X-Google-Smtp-Source: APXvYqxCbuflG8utemjZgjgqsKX6isF07KHjzDqNYGWjVnzQx4QQc7IThsVnFyUsnVx8auRJT+gUQA==
X-Received: by 2002:a37:dc06:: with SMTP id v6mr16508690qki.163.1569808277832;
        Sun, 29 Sep 2019 18:51:17 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Antonio Ospite <ao2@ao2.it>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v2 02/11] grep: fix race conditions at grep_submodule()
Date:   Sun, 29 Sep 2019 22:50:48 -0300
Message-Id: <be32683f1d59786550138169200d29bf67a822ca.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There're currently two function calls in builtin/grep.c:grep_submodule()
which might result in race conditions:

- submodule_from_path(): it has config_with_options() in its call stack
  which, in turn, may have read_object_file() in its own. Therefore,
  calling the first function without acquiring grep_read_mutex may end
  up causing a race condition with other object read operations
  performed by worker threads (for example, at the fill_textconv()
  call in grep.c:fill_textconv_grep()).
- parse_object_or_die(): it falls into the same problem, having
  repo_has_object_file(the_repository, ...) in its call stack. Besides
  that, parse_object(), which is also called by parse_object_or_die(),
  is thread-unsafe and also called by object reading functions.

It's unlikely to really fall into a data race with these operations as
the volume of calls to them is usually very low. But we better protect
ourselves against this possibility, anyway. So, to solve these issues,
move both of these function calls into the critical section of
grep_read_mutex.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2699001fbd..626dbe554d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -407,8 +407,7 @@ static int grep_submodule(struct grep_opt *opt,
 {
 	struct repository subrepo;
 	struct repository *superproject = opt->repo;
-	const struct submodule *sub = submodule_from_path(superproject,
-							  &null_oid, path);
+	const struct submodule *sub;
 	struct grep_opt subopt;
 	int hit;
 
@@ -419,6 +418,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * object.
 	 */
 	grep_read_lock();
+	sub = submodule_from_path(superproject, &null_oid, path);
 
 	if (!is_submodule_active(superproject, path)) {
 		grep_read_unlock();
@@ -455,9 +455,8 @@ static int grep_submodule(struct grep_opt *opt,
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
-		object = parse_object_or_die(oid, oid_to_hex(oid));
-
 		grep_read_lock();
+		object = parse_object_or_die(oid, oid_to_hex(oid));
 		data = read_object_with_reference(&subrepo,
 						  &object->oid, tree_type,
 						  &size, NULL);
-- 
2.23.0


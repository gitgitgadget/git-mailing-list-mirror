Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664AC1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbfISVrp (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54725 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbfISVrj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so45195wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Mmb/W0PMqpYxJe+a1U3Yg0AyF3gnkbyucfeef2nJCA=;
        b=bSMcr6DhdCih3C1HFrqEDJ4dkZpjxDFGbr85j1okohp4M8KlX7n740pSjN72Bk/Wxx
         w2CvZFuCTWnBasUYZYvyP2q4gyqn0nwglSEZ8NOK43G/A4IaomxTGCnTQE9hIUtJtrqf
         hev2BqeLE7Mo/098I/jwWD3krUw0WTp8d7utfAFHT3V5oLmzSNv9iym5pXNTP2vjy+MB
         LGtyFGWKMAp2AfqIWhzv99CqNryrR3hRFtVleO/Xz8FJ1yJBLBjPs+WZbfYUhSprL0q2
         S1zK75bULZZcv3nvQZRkyf/xUgTyI5FDQoG4GrvHnaatCor5vNAqsfDIr4IrTj+Z+0pm
         59tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Mmb/W0PMqpYxJe+a1U3Yg0AyF3gnkbyucfeef2nJCA=;
        b=EGjSN6zy3sv4CCHTrjC0yUKiRQt8BsTcGj4NAaQl1i2EfDey7ECJI34CIgYwgdEpl3
         Pz8RBZia0nNEOkXDw8a93Lb9g9ODfMA0NnY4MbcwiILYGZRxtzRI4OqGVvrKD2VBFwXH
         9G1at4YR2yLebk1oiZYclJUAzrUFoOLhynCxpFJzAlBF0rnX/pLLR3ImoXHX7wlEaEUj
         j8DcPaE2EP2tvx50N4YXTx9vwJGR258Ck1hEtPt7a0EI+OmiuVcjbMdGZUVGFKPAhYnd
         JS7B8X5hxyE7aeP5cPUqz+hL+lE62q+ii/n/YtxuTej4lwuUN+Av7b+6vo1ImMCFyZ7k
         I0Xw==
X-Gm-Message-State: APjAAAXSKHTNrDRXomfT9wTKqq3vMo+9/jx8Crlygg37+66Xzk6Ifudd
        QHW9pZPoJbqPfI7kodBLgr8=
X-Google-Smtp-Source: APXvYqy6RL+DV8Tm+7XyJ48sENOdmzu9W37CjmlCCY3+rpIAwp+tKUylloOVpp5jA/KnbJzKaY43xA==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr48127wmf.46.1568929657526;
        Thu, 19 Sep 2019 14:47:37 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 15/15] name-rev: plug memory leak in name_rev()
Date:   Thu, 19 Sep 2019 23:47:12 +0200
Message-Id: <20190919214712.7348-18-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The loop iterating over the parent commits in the name_rev() function
contains two xstrfmt() calls, and their result is leaked if the parent
commit is not processed further (because that parent has already been
visited before, and this further visit doesn't result in a better name
for its ancestors).

Make sure that the result of those xstrfmt() calls is free()d if the
parent commit is not processed further.

This results in slightly but measurably lower memory usage: the
avarage maximum resident size of 5 'git name-rev --all' invocations in
'linux.git' shrinks from 3256124kB to 319990kB, just about 2% less.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f867d45f0b..d65de04918 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -139,6 +139,7 @@ static void name_rev(struct commit *start_commit,
 			struct commit *parent = parents->item;
 			const char *new_name;
 			int generation, distance;
+			const char *new_name_to_free = NULL;
 
 			parse_commit(parent);
 			if (parent->date < cutoff)
@@ -158,6 +159,7 @@ static void name_rev(struct commit *start_commit,
 					new_name = xstrfmt("%.*s^%d", (int)len,
 							   name->tip_name,
 							   parent_number);
+				new_name_to_free = new_name;
 				generation = 0;
 				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
 			} else {
@@ -171,6 +173,8 @@ static void name_rev(struct commit *start_commit,
 						  from_tag))
 				last_new_parent = commit_list_append(parent,
 						  last_new_parent);
+			else
+				free((char*) new_name_to_free);
 		}
 
 		*last_new_parent = list;
-- 
2.23.0.331.g4e51dcdf11


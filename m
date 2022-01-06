Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D4C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbiAFTuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbiAFTuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:50:14 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C90C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 11:50:14 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id kc16so3398809qvb.3
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 11:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5FB9y+ypTjyQ9ZFI+uo24PWFFuDpX/he4vbmdVUajaM=;
        b=toO51zEfLbi8SjWLa1NsYUN40h6u0DignOToJ/XsP9BunS/yWySL1cojeNhycLmiZO
         ewphAnnuMg1TgUiipTe4RiMNrSd5ZrMdsAwwKp6Svj/C1X/n/e88bJNrPZs2ik/soDaO
         /RetYC9UslANcARjBKXRVHuHsvGhxJYEVYwXjnk8SH0xJUPZOQdmSOtm4Z8+YXYEbo2t
         FVeYnY+GZELfeEb9JcCEriOuZW0/nxi3XhieGNAE+IlpBPzhM5+idmUdJtjVqf5KjTiZ
         8XBCkIkf11/H4HPSpzIDfcLWNlDi9MnI70PaWs2OsJ96wAI+l6glQfueWTW4EY0G1HSr
         AtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5FB9y+ypTjyQ9ZFI+uo24PWFFuDpX/he4vbmdVUajaM=;
        b=CfqcwyJ1JQTsL/oB4TBdJc8ozQWP+uxyZ5hxhvUU/X37cX+SKCtR6jQyxeShA/eD6g
         ukXqo3XXIWXo/UUub79pdIqX8c11bDn2IVVF3q/FKu8sgwF/wpqQyXqwHmL/PrtvUISr
         2NTAwN4T2lz8xbHZUtQdxLKcvpKIgxcegl+cbsvoPFlQ/e3QUaEOJyhNnx+jTgPaWwF1
         kFubzmNZDs0VEcb2Gz1TzA/39sFIKtwLL/KoYbtOLpW2gG8d3LBe7XZqllX+K0hutRay
         Y8LMeNgfdAhTD5k8mqp9+e3Xy3vDZaMSgmUQayeGTxK6LUlwYXxs9rTRrAGVlC7j7VDu
         THnA==
X-Gm-Message-State: AOAM533ErR+E6KaA2UpiKyKOPFkCuevuYb9KAbmXGq0HRQdTFksB44u3
        lbmcbpfoZJqiU+Arp12QT96LZw5X+RGp8g==
X-Google-Smtp-Source: ABdhPJzlXJP7N4GBHzIxWn1NixeM47OrwxrRrVcK0ZTnvtDxV3W+Qf9m2BieXNfrhz/gtP1QXqoOTw==
X-Received: by 2002:a05:6214:27c6:: with SMTP id ge6mr55123207qvb.83.1641498613660;
        Thu, 06 Jan 2022 11:50:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f8sm2265962qtk.1.2022.01.06.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 11:50:13 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:50:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, gitster@pobox.com
Subject: [PATCH 1/2] grep: extract grep_binexp() from grep_or_expr()
Message-ID: <dae476d1bd14608358b6c103e2b5dda76d294687.1641498525.git.me@ttaylorr.com>
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
 <cover.1641498525.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641498525.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing an OR node, the grep.c code uses `grep_or_expr()` to
make a node, assign its kind, and set its left and right children. The
same is not done for AND nodes.

Prepare to introduce a new `grep_and_expr()` function which will share
code with the existing implementation of `grep_or_expr()` by introducing
a new function which compiles either kind of binary expression, and
reimplement `grep_or_expr()` in terms of it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index bdbd06d437..d772fe6cc5 100644
--- a/grep.c
+++ b/grep.c
@@ -603,15 +603,22 @@ static struct grep_expr *grep_not_expr(struct grep_expr *expr)
 	return z;
 }
 
-static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep_expr *right)
+static struct grep_expr *grep_binexp(enum grep_expr_node kind,
+				     struct grep_expr *left,
+				     struct grep_expr *right)
 {
 	struct grep_expr *z = xcalloc(1, sizeof(*z));
-	z->node = GREP_NODE_OR;
+	z->node = kind;
 	z->u.binary.left = left;
 	z->u.binary.right = right;
 	return z;
 }
 
+static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep_expr *right)
+{
+	return grep_binexp(GREP_NODE_OR, left, right);
+}
+
 static struct grep_expr *compile_pattern_or(struct grep_pat **);
 static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 {
-- 
2.34.1.455.gd6eb6fd089


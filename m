Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D6C1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 20:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759410AbcLBUbe (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 15:31:34 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36587 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754015AbcLBUba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 15:31:30 -0500
Received: by mail-wm0-f52.google.com with SMTP id g23so27638313wme.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YP3u+qkwwbtNvnIR/BhdP1EIWVpOiWJ1mlV6i/F1d/c=;
        b=hY43805v4mx9kHV8aC87vn/zWCXHt0GDb1whiSEKcXIZbjUS0Gc5qgvyLMvv5/QNpE
         OnJ2fx70J6ZyUFdQJR2N03lPA6UFw6BcO90RduvoJ/wtjSzTr1E8gp2T8n5hmJ46U6Il
         qcaaqQlgh6w6ckH7LMQ8ScuYtc7Xb7D24aiY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YP3u+qkwwbtNvnIR/BhdP1EIWVpOiWJ1mlV6i/F1d/c=;
        b=hO56e+lksZEeLvcP09Hb2MsbkF8vwx/VJpJmWyA66QsCTpp+lQBnpK6WgePLBSbTPL
         xOBAyGYCAi3IqaF2UJDqGhQe934l3fafIYpi5L9j41wBWqIL4BYkvr9zpWt14Zi7kTmf
         n03iSkSGkKMelR054Wq77HSko6Lr9hJbuBJW/BB/jvvsrbKY+E1Lz6vCkThKAwhDrRos
         sqRp3VAeDMTp+lHuF1bdR8eSl3X8AGGrShh/YHzqbnZLCRgi5g/vjE6nHw9BnRtRF0SF
         uo5ziQa8aOJvZ47Cu3wITegBouAZOd0hh9m9OAke00Fr57DAgEZx67u26ih7KMLk+G86
         R01w==
X-Gm-Message-State: AKaTC00d5SKuE5bgC9QsOzRk1WWGHKJmeTpiL1F3wSjm6AjpH43FGFoMhrzfPUZwjkoqlA==
X-Received: by 10.28.161.129 with SMTP id k123mr4866305wme.66.1480710688229;
        Fri, 02 Dec 2016 12:31:28 -0800 (PST)
Received: from lvps87-230-87-209.dedicated.hosteurope.de (wildmoose.dk. [87.230.87.209])
        by smtp.gmail.com with ESMTPSA id w79sm4938178wmw.0.2016.12.02.12.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 12:31:27 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 2/4] shallow.c: avoid theoretical pointer wrap-around
Date:   Fri,  2 Dec 2016 21:31:02 +0100
Message-Id: <1480710664-26290-2-git-send-email-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The expression info->free+size is technically undefined behaviour in
exactly the case we want to test for. Moreover, the compiler is likely
to translate the expression to

  (unsigned long)info->free + size > (unsigned long)info->end

where there's at least a theoretical chance that the LHS could wrap
around 0, giving a false negative.

This might as well be written using pointer subtraction avoiding these
issues.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 shallow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index e21534a..8b1c35d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -444,7 +444,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	unsigned nr = (info->nr_bits + 31) / 32;
 	unsigned size = nr * sizeof(uint32_t);
 	void *p;
-	if (!info->slab_count || info->free + size > info->end) {
+	if (!info->slab_count || size > info->end - info->free) {
 		unsigned alloc_size = size < COMMIT_SLAB_SIZE ?
 			COMMIT_SLAB_SIZE : size;
 		info->slab_count++;
-- 
2.1.4


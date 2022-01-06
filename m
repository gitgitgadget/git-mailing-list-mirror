Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC03C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbiAFWmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245212AbiAFWmb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:42:31 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C93C0611FD
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:42:30 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id y17so3789424qtx.9
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y1WlMvkx/EM/x9afpKqxA3UeXzIL9bkPknxvbNJWZ9k=;
        b=RTO7ILDWcGL95XE6Qe5VFFCkCdKIGpNMndbcLjlmV9M8It9ZPPYbcv2oYICWAncqdF
         xN5Rn1FeVtUgiUJ88CwlMBi9EXdA66/A/fdxRxtNl+AboyuGGA3P9A9bgVMpM3cGg1ZK
         O1rHoqwA6DvhR5/diqzuXj8WcoYw6sU2NrrS85UaazdN+VUexVHW+pe8VGLI+Ie2C+ma
         Ev/O8nf+cOhApE6lst0tkFW8TXMe6aKFCxG0Mb2g5BTYro4Q1K3CHCljZAJ1xjJhvLvy
         nOrmhcdXG+4dYDDT6wIDKaCOuvGvvRQfrL1OhkKKL+mxoCBIelyio9e7N/r8KS7Fdn52
         07CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1WlMvkx/EM/x9afpKqxA3UeXzIL9bkPknxvbNJWZ9k=;
        b=TxpiJjAfJj4PJRh3kn2DBxHN++569/Pslgjes08Y+QrqhkFVy/rYgFSxKsFQRo94wB
         s6lN4WiwBHJP9ITSQxRPC6c7xbIIoqpOj8LN1itC2pZK25iBNJkcqnNTe1D9T8a7fpcQ
         /+R0A9V7I2Zw6bkfJrWltB1KxRYCXRMOU912PDEzAbwi3ZTPmsQQNio7EnOqbPmlecui
         aXIO+Hb+GBuorSl28r4WWmRVeG6fVmq5vljsc1RR2/ROrV0ei/msRhobhbqwpwgAx+ZS
         GywnfOyxqGBVBz58ThFjgP5NK0HLM6LS07mdwqo+IeRNldQqzZiVE89bQYCYsZA+8zx5
         Op5w==
X-Gm-Message-State: AOAM53022tQsaeimN7C8DAkBt43hdY8mKg02wVIOv+G/yFELh1qfoV8O
        eYC6o8RlRuE2ORnyuf6ALzQU/pc3+99Ytg==
X-Google-Smtp-Source: ABdhPJz68i5QE2FI+Cmy22doefnVff0mDoIg1LYCXiLqQkxq8O6hmmgJO1Mo5FgKxeZOyax4jbPaRw==
X-Received: by 2002:ac8:7d08:: with SMTP id g8mr54729286qtb.573.1641508949810;
        Thu, 06 Jan 2022 14:42:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14sm2642434qko.9.2022.01.06.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:42:29 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:42:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, gitster@pobox.com
Subject: [PATCH v2 2/2] grep: use grep_and_expr() in compile_pattern_and()
Message-ID: <f637e024222a98b6a064fd49b6b810c0b09527d8.1641508884.git.me@ttaylorr.com>
References: <cover.1641498525.git.me@ttaylorr.com>
 <cover.1641508884.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641508884.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as a previous commit, use the new `grep_and_expr()`
to construct the AND node in `compile_pattern_and()`.

Unlike the aforementioned previous commit, this is not about code
duplication, since this is the only spot in grep.c where an AND node is
constructed. Rather, this is about visual consistency with the other
`compile_pattern_xyz()` functions.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index d772fe6cc5..7a1c52c60a 100644
--- a/grep.c
+++ b/grep.c
@@ -619,6 +619,11 @@ static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep_expr *
 	return grep_binexp(GREP_NODE_OR, left, right);
 }
 
+static struct grep_expr *grep_and_expr(struct grep_expr *left, struct grep_expr *right)
+{
+	return grep_binexp(GREP_NODE_AND, left, right);
+}
+
 static struct grep_expr *compile_pattern_or(struct grep_pat **);
 static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 {
@@ -674,7 +679,7 @@ static struct grep_expr *compile_pattern_not(struct grep_pat **list)
 static struct grep_expr *compile_pattern_and(struct grep_pat **list)
 {
 	struct grep_pat *p;
-	struct grep_expr *x, *y, *z;
+	struct grep_expr *x, *y;
 
 	x = compile_pattern_not(list);
 	p = *list;
@@ -687,11 +692,7 @@ static struct grep_expr *compile_pattern_and(struct grep_pat **list)
 		y = compile_pattern_and(list);
 		if (!y)
 			die("--and not followed by pattern expression");
-		CALLOC_ARRAY(z, 1);
-		z->node = GREP_NODE_AND;
-		z->u.binary.left = x;
-		z->u.binary.right = y;
-		return z;
+		return grep_and_expr(x, y);
 	}
 	return x;
 }
-- 
2.34.1.455.gd6eb6fd089

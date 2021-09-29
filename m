Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7262C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF29E61352
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbhI2B47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243661AbhI2B45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:56:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4949FC061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p80so1095432iod.10
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iUERTpfrumNzPpL+9R6cg7A8hehvT+o3pXXZN9DmkNc=;
        b=wpweK1OKrrTNG5yO0AWtY7uNrhGx7KevjJeWRyNg7GsN5ZZg6V0I9s9XpldHcyx4hQ
         8cplxtnpm62pp+Z4p1KG6Byx7aFQBUhWcvwgIVgnWdwJrASzeJY2dCElgL40DhQXyE3z
         KQqD1cy3JdKTw+FS2g8X9c9/c6quW/NdTzJ1CLiKROwU120zw9H/aN5Bs/BHAFnuRvsO
         Bv3AI/HJXXeI/ShZP0lwLRkBQ4e7pnC/zed8vubijTx/YJxpeasOeGpBFXU6gtYRvo2o
         ECsBPt58WL70jQMHkhw9HQwduM8HODWY0FFJfMuaDTWFxC/mI2nWSG4+bBXkSmsTp0vp
         phGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iUERTpfrumNzPpL+9R6cg7A8hehvT+o3pXXZN9DmkNc=;
        b=2FPzbFIPanYgpeXqjDKwhdH5A0UGGW8oaHp0ZGGmLf083iFSE/I7nWr3d9FKrGDnBS
         aBkBk83uBTj8DbHoj9IpVelzTJLjFPL9vfPW0dO3RH1ze8jFScmsqEiWz0mmHXZwWDNq
         TNO38X+4Qy5/zE0nePhYjC9CJ475+G1BzCihsTx4QKmZDcsuovR8pdtN0DCxh5mUBF3t
         YgBYevCigYSkvLQuDzHIJe722mpbS+ew5yehmcvkT+OKf3+wNHWEdIOuaUmnuYCqNL9W
         9CMfBWvXjSRQmoajfPt4lyGDwsqK5uoQNhqAeL8rEjFEYfbo58PPbKEPtOfUIKInqUY9
         DUqA==
X-Gm-Message-State: AOAM532DsXJNXe64llSBIfd//SaA9TuO1a9v9Wr6vbYETFUJJUldYD0u
        RY7ACF1LSiTm+vhJp4gpwHix3UTP9xFfxQ==
X-Google-Smtp-Source: ABdhPJyRXIBZhseR2Y6Xt7+7Ke4TMZTyyZ8IOX0bWjHI0yVatEvTsklkPvPlh3UpUKLGzADgfpIoRQ==
X-Received: by 2002:a05:6602:1a:: with SMTP id b26mr6157579ioa.0.1632880516626;
        Tue, 28 Sep 2021 18:55:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x12sm498326ilh.15.2021.09.28.18.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:16 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 6/9] builtin/repack.c: extract showing progress to a
 variable
Message-ID: <1a40161baf13224228d9c755db8ce2bdeb06917a.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only ask whether stderr is a tty before calling
'prune_packed_objects()', but the subsequent patch will add another use.

Extract this check into a variable so that both can use it without
having to call 'isatty()' twice.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5539ec7e89..475677b297 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -446,6 +446,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct strbuf line = STRBUF_INIT;
 	int i, ext, ret;
 	FILE *out;
+	int show_progress = isatty(2);
 
 	/* variables to be filled by option parsing */
 	int pack_everything = 0;
@@ -719,7 +720,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			}
 			strbuf_release(&buf);
 		}
-		if (!po_args.quiet && isatty(2))
+		if (!po_args.quiet && show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
 
-- 
2.33.0.96.g73915697e6


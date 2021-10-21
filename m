Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55660C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F6061186
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJUDmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJUDmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A53C061749
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:54 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l7so11042196iln.8
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LCphwRaPGY8QsBu1ReFAnc9TeEz7ZWhd41/xcUdARxg=;
        b=dmrkINQLDpsDIrD7lLUFUxclCo6PLDuJsuS64sjP1GVAoZMBYLEkQh5N+pdDNIO/ra
         Jlssm/9Z5ABUho+6l/P+WFkzavAVSNBKz7Xe0Ht5Xcg917ByPx9SHtdOPefrahucb7Hf
         qXYeeBLzJZOh8GLpag5KQxg8U0fqi6/iOE0gj9eLScCLfExzPiojH3Pr8Di4o6Am4lQ5
         4qHxXUmxVf0PSKRgEVGQI1MU9iZjvaxHYbIIu5fH+Ou7gJEkRyzSw7B8pNdta46jEo/g
         o0u5jR844n9JM3Dg4N6zQRDf+gWCLfLTlcIlWqi5SKJGaLGF448CSj7vac/5hK0qAmYR
         wQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCphwRaPGY8QsBu1ReFAnc9TeEz7ZWhd41/xcUdARxg=;
        b=iKzFZ2X+ToMrG/YXnWhWfawn+Y8dlrRZtTWfhuN0asc8AIgAa5Zr4QyJ1XbH9YAZU2
         EG4fEhQu1j5HOBMJfl0jBNxrAtpkJnMGUst9ydIs79N8ia4K0pzGK0v+9M/QHQdzy5By
         uhyqRrMqmy5Y4RHz8IgRODomKcbIiUTFV9JgiY2uLeRonZ74qT3RMuUUQEBiBClq1vLz
         jwYp14maYsFP68ZZHDiMOqqsTFbhsPC886Gj/vrE+hUWjPyvgx4FfLphhbhu0STDZje5
         eb+6jDb1s5gDGt3FATRyrPKrk+mh2f2O7V1HRT63EHGgGDKrr4G3IMHSEB2Pz6UWTSiR
         T7lQ==
X-Gm-Message-State: AOAM532KQS6fNmqrKEQ3/kWzl0B6i4Fawt/AwKDbVBImu2zlt3P38f0l
        KLyX9Lsw0dK14ajqTFkfUSdqvyKQ1jSlFA==
X-Google-Smtp-Source: ABdhPJzqBMeV7dh2BwEocsr1KRheXKVoTCLwAZbW7TRwYHn2gjJ+5X/FEx7BKziodxPv1i3hM/+FAA==
X-Received: by 2002:a05:6e02:152b:: with SMTP id i11mr2026494ilu.166.1634787593912;
        Wed, 20 Oct 2021 20:39:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm1981833ilo.35.2021.10.20.20.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:39:53 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:39:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 03/11] t/helper/test-read-midx.c: free MIDX within
 read_midx_file()
Message-ID: <5157edb41e298c2504ac0bd8b4163fc6851bc1f9.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling `read_midx_file()` to show information about a MIDX or list
the objects contained within it we fail to call `close_midx()`, leaking
the memory allocated to store that MIDX.

Fix this by calling `close_midx()` before exiting the function. We can
drop the "early" return when `show_objects` is non-zero, since the next
instruction is also a return.

(We could just as easily put a `cleanup` label here as with previous
patches. But the only other time we terminate the function early is
when we fail to load a MIDX in the first place. `close_midx()` does
handle a NULL argument, but the extra complexity is likely not
warranted).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 9d6fa7a377..27072ba94d 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -55,9 +55,10 @@ static int read_midx_file(const char *object_dir, int show_objects)
 			printf("%s %"PRIu64"\t%s\n",
 			       oid_to_hex(&oid), e.offset, e.p->pack_name);
 		}
-		return 0;
 	}
 
+	close_midx(m);
+
 	return 0;
 }
 
-- 
2.33.0.96.g73915697e6


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C14C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2177561039
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhJZVDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbhJZVDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:41 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A9C061227
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h2so633161ili.11
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LCphwRaPGY8QsBu1ReFAnc9TeEz7ZWhd41/xcUdARxg=;
        b=4cSnf+ZvJOW3TS97Mncw4mmKpIyvBSypwBlAx9YTVurqkM1B5IZT9hU4PTf8fao63Y
         M1uZbpZU3b9/5cK7MmMvuRALh2dj1i9qW5nC6XkLjds/0MUISJcAdgDJmj0lqTBKk8aL
         TOBW9EaJI6N/dH5R0edl249grHLHh6ujIH74UwT+CxlLAn0j1eB5MmPD0gPA+NFW61nA
         +qf8zXF4/HDVO4s89rpUUqz8rAZrEU5/xfNgCHXsd5tGkvH3kZI80qzabem/bBqlpHW4
         lLv70oOFjxZiDmh9HwLnxF9hpnjZbOtpSoqExQ8YbS3qt8Ivc/pOL092yBSLUfFMGeq+
         +qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCphwRaPGY8QsBu1ReFAnc9TeEz7ZWhd41/xcUdARxg=;
        b=eDXu6RLkWxqT0YrySd2H2dvkjrnqOxlbhq/OeqecF9iHWBRfBEMflwnS9ZFRjLIpXY
         QSFZI5t23diLWZJKPJdBd+NUmiJBQsG16StIgpd/gPn1vbCNJvKXlR3GHua0ztwlhJKz
         sPW0Mvpr+qWZVj/95Y7sbv5eBFAbP6FT7uOB9kj+jhLr4J2OWjQvsD5nWQfEfYIO7075
         ElzJ/2PuQsgHpSfbF0sjPRCb9zErirD2870SM8GQKm0LgXrvTCAzt0Ip2zde0/H2TYYj
         7MAhPYbSOiEn743FUWyDTk26MAIGRg7aHMjZhxlUHzPljtGfUkwIATkua7mxzTnwZqtN
         b+jQ==
X-Gm-Message-State: AOAM5320Ta6KJQLrUCsR4rbQAJ+XJSDTTbhbTxTEfKAbjzcN3p2hHVfo
        Irv+IMhiv1C1bENsWYxOVzk1AeygPykB2Q==
X-Google-Smtp-Source: ABdhPJwoQKvQhazRIL3NNR7GL2jBvXkpInWk2ozRaJVOsRPmCL6Z6aBnJn4+M1xqZkgaOCX0myuF0w==
X-Received: by 2002:a05:6e02:1bae:: with SMTP id n14mr10509600ili.269.1635282072143;
        Tue, 26 Oct 2021 14:01:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x13sm4837604ile.9.2021.10.26.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:11 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 3/9] t/helper/test-read-midx.c: free MIDX within
 read_midx_file()
Message-ID: <84859d5b534606ab243b82afa119514f71ca1c03.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
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


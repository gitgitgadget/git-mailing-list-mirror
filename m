Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321B4C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BCA61186
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJUDmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhJUDmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:07 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31285C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:52 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id k3so14004170ilo.7
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oZIj6k0qGH8oMfjn+MsLxCeO7koJJHsNfIcJTYH5d4=;
        b=dK8/IOtrxKQeF89N1ZYb2L0txOT0FBJ+kFVQbnEhQcm2iw6V4gmhbUUCImMMdq5OGn
         o0apj/Tfa9V0jZZ0XqK/2SK4u2B3j8JYpBVYTNvjnYMPxUNBQxYZ8pVoYuEhdlsLMioO
         P2s4IkRWAw5UbO2TIkYNH9LTmG1ggv820SNXBn+h88mTIN5hFsZ6cT93Vk1Q9OjBnq/l
         k3XkDQ94QNkcWy/HKCmJ2KGcLqNACbEym4EzRmZvJ6YsnKaP1RIIAn3Alsv2infIfu7L
         zCCggQGZnXSgwvtm49hSVoiT+14XxTtPqhG+fRxbUNr1acI0b+X864y7MkAYFwo5nGuW
         4rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oZIj6k0qGH8oMfjn+MsLxCeO7koJJHsNfIcJTYH5d4=;
        b=yiiPgPjJJkUS/l9TiNqh/l/wG2jzasS7vE01l9Pxc57UCoyFjYV60+1KamE+DlwW/b
         5gdWLCleN6WqRO9z/nxQtP0ysz+T1VRJPA5owartwFQsJZyycSPak5EEF5ymBSsLCe/g
         7n2HP/t9kmOCBNht521xiHqcRp7gZ3+DQwOZTySq7FhvGp4AmhD9Ys9OhSCXE4PtkQY6
         kG5yp+hXCkUDBC7MAOudgqAqHdF5z6wFYO6ml9RW9s18eZYTK01wSS6S/OOhqUKRyZof
         RAifGvbOIE26su3rYQ58sU5JrUag8wl3jIZfzmDSqdgNPbIMwSMy8jDzYnrhgmzlHBOg
         uU5g==
X-Gm-Message-State: AOAM531qrQZqZy4GO4tUFHWoml9fKX9hRyrRGq1I1I/eAT5pNFoLcIW0
        Raz8kcijuAmJsQ/23Yj4+1r+FK2lX4SZEw==
X-Google-Smtp-Source: ABdhPJy602ce/85lFnobbKs2+t7DYVuJvaVtpKTsAs1Z6cveyIa32hQ2Sjt2ZfA6z8wCcDJ0YoFWMA==
X-Received: by 2002:a05:6e02:1c26:: with SMTP id m6mr2004176ilh.229.1634787591499;
        Wed, 20 Oct 2021 20:39:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a12sm1936681ilb.66.2021.10.20.20.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:39:51 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:39:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 02/11] midx.c: don't leak MIDX from verify_midx_file
Message-ID: <b0c79904ab7bdaee7a1bc7a55b0fb26b1f2cf8d3.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function midx.c:verify_midx_file() allocate a MIDX struct by calling
load_multi_pack_index(). But when cleaning up, it calls free() without
freeing any resources associated with the MIDX.

Call the more appropriate close_midx() which does free those resources,
which causes t5319.3 to pass when Git is compiled with SANITIZE=leak.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 36e4754767..ad60e48468 100644
--- a/midx.c
+++ b/midx.c
@@ -1611,7 +1611,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		 * Remaining tests assume that we have objects, so we can
 		 * return here.
 		 */
-		return verify_midx_error;
+		goto cleanup;
 	}
 
 	if (flags & MIDX_PROGRESS)
@@ -1689,7 +1689,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	}
 	stop_progress(&progress);
 
+cleanup:
 	free(pairs);
+	close_midx(m);
 
 	return verify_midx_error;
 }
-- 
2.33.0.96.g73915697e6


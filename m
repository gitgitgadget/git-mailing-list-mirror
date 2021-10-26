Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D3CC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6554D60FE8
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhJZVDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhJZVDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C5BC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id 3so661263ilq.7
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ywGIn9LL+WdWZrY9v/GGM+XQz0CjxBSr644Hb+5V47Q=;
        b=v59hPcD3FmpTn2oQt8V4iMsjMCr0Pk4LUB1ROivjE4auHmArUA91q/3UbC/k9VStLK
         sCFua0jbCK6f6s+cps4VjljEICVHWxE7VIJzSmw9f6aZqjtmkgPflxr65T9Fhc5BlzCX
         lFB8CSQ12MfakRpXf4EzRvG0ybXdW5PwYLHrCofls7N00IXPbeeyMiYIVQMRQDDFw9wh
         ZvR+HX+4zi+wVmfUSe0RF6cxzT63/KeYIOJ/yDqd5bDFrEypqAmbvZSfHpTuTPE7jR5E
         UIcqGZ3G8OodRwi9ZZkX9xAaD42be3CsXri/YFzzE01Wq/R7p4D8wJqGGhvsL6IRzkhZ
         cEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywGIn9LL+WdWZrY9v/GGM+XQz0CjxBSr644Hb+5V47Q=;
        b=lH9K0/pNRxPFBYEmQ8ZkBETdr2bxMDMW44wLVqfze0HuzAnHOJz8V7VWuC11p/3U4B
         4u9k9VUeBRYHXf1PJGyVkKlX3PDIv8q9okoX11N9UOevB50XSqLhl6FBwgkMU5av+LjE
         7ENeEk7VQw2MCtWIm1wtGkRwueLxvtbV5F9OIBrauXJEBuG/pP9b6snPtcn/H40+fEOy
         d+k6/dpwPKvX3+6FckhKasYF0hZHgjentZqNgAQ05gOuMMeUJvNu8KbWfg/vbyNjxIfw
         h6dIJMxPWLotDWs0YLURn17SVfyvuCiJooLasPnoIxi6vxX1RzQhppcjN9sst4sJ1U81
         EKsw==
X-Gm-Message-State: AOAM530gfbGI99lRYKnwPy2aul/Tlc/blaU90nJRaYw8+FZFAa/Ykk0s
        lbc7LPQOXN4HPvsGTfDTM3hseYAQ8e0vLg==
X-Google-Smtp-Source: ABdhPJyQ+fyYU92VGnHq/STB4VU/L0vKFqzDN7OjaYc/5kC763lwWt4ida6weayH+unCXetRgSG8fQ==
X-Received: by 2002:a05:6e02:1bce:: with SMTP id x14mr16255584ilv.9.1635282069425;
        Tue, 26 Oct 2021 14:01:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r11sm10429990ill.20.2021.10.26.14.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:08 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 2/9] midx.c: don't leak MIDX from verify_midx_file
Message-ID: <258a9e2e57eaa81c906a05f1d7f8c193d7efebae.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function midx.c:verify_midx_file() allocates a MIDX struct by
calling load_multi_pack_index(). But when cleaning up, it calls free()
without freeing any resources associated with the MIDX.

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


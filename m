Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D51C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 13:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhLMNYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 08:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLMNYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 08:24:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5A7C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:24:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so51260047eda.12
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qY5s4OpxwTOdoSunw0Od24zZ9/HGDpRR52kAt/FAlLQ=;
        b=KkOpW/rrC6MxB9HQMz5fJ8yJPdBEtILown6Pszk2A6ch1wYuYC5TLHlKWNledI2Ltq
         ew1SWnrP9qvlYj/HOPwIb1Qa3LHQE6+cOUT2J/PXLq5Pcl5iunP7AQG9bPmeb11dlAD/
         UA4J52PejjNL7HzLA1GTg1qJ7hV2EsW9tyUeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qY5s4OpxwTOdoSunw0Od24zZ9/HGDpRR52kAt/FAlLQ=;
        b=aUEDOnczOtNslJUTl4tWUqpmAppGhO7kk2Mhn5/QPafNBqiZJzYl/lh/BTq+/EiK7t
         qje7GLfEJxgKnYonoq5wdUKEtXUcWg2P6qmSz8dVXAYf9bPdv2qjy6SFkz1dpmvI7v/O
         29IB2mzqaCyY0KslJVnK0hs00tZHGfycrCYghw0KuQok8b3Q+CIIU+NdtitmA8+yoM+0
         furtXFNzxnqbIfKL8BpG0kuiZPnxUdZIcuw7Vd2BgSBg0K89GWJ3B8YYe9i+fEiO42wQ
         ZahqtRCTykcqtxJp7fVEg2Z/V/KRYkws4ZlN9dw6agIP6wNEs5Y1SiFomv175oPxvdXD
         xPyw==
X-Gm-Message-State: AOAM533m6DuKbLBoc7dvPHRWQxlbEuwd3y+XWw55QhKIbsdDiLGgFNpE
        aNrngK0fIS1eJ/AO/FH7o9f/E/fdDxZwMA==
X-Google-Smtp-Source: ABdhPJy8fHLHTMU9bs2t5U4zFDxWb6e1ldoV5lprvRBNrckkctDUCyiju0EFQv9r/KW1gxI2vwksnA==
X-Received: by 2002:a05:6402:51c7:: with SMTP id r7mr65696866edd.359.1639401879223;
        Mon, 13 Dec 2021 05:24:39 -0800 (PST)
Received: from localhost.localdomain (a164154.upc-a.chello.nl. [62.163.164.154])
        by smtp.gmail.com with ESMTPSA id di5sm5838739ejc.45.2021.12.13.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 05:24:38 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 0/1] Make upload-pack pack write size configurable
Date:   Mon, 13 Dec 2021 14:23:44 +0100
Message-Id: <20211213132345.26310-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When transfering packfile data, upload-pack.c uses an 8KB buffer.
This is a reasonable size but when you transfer a lot of packfile
data, like we do on GitLab.com, we find it is beneficial to use a
larger buffer size.

Below you will find a commit where we make the size of this 8KB
buffer configurable at compile time. It appears pack-objects always
does 8KB writes so I don't think we should change the default. But
for GitLab, where we have a cache for the output of pack-objects,
it is beneficial to use a larger IO size because the cache does
64KB writes.

I have also considered converting the packfile copying code to use
stdio when writing to stdout, but that would be a bigger change
because we have to be careful not to interleave stdio and stdlib
writes. And we would have to make the stdout output buffer size
configurable, because the default stdio buffer size is 4KB which
is no better than the status quo. A final argument against the stdio
approach is that it only reduces the number of writes from upload-pack,
while a larger buffer size reduces both the number of reads and
writes.

Having said all that, if the Git maintainers prefer the stdio
approach over this compile time constant, I am happy to submit a
patch series for that instead.

Thanks,

Jacob Vosmaer

Jacob Vosmaer (1):
  upload-pack.c: make output buffer size configurable

 upload-pack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.33.0


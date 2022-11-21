Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B257FC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKUMAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiKUMAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:00:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E7748C5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:00:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so8739378pji.4
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmwDBDiY6QNAXJf4a/Zr+AQ4b+xMVV3KgrRw2UGeEWI=;
        b=HfF3BsZIJMwyssNp2049VWIkepjeeXDoaIG8tmQkgg7dHouZGJMUW23DSgFZDtJ1sm
         R759xVjGzFXMHgQHRHTtx+WaQpFqBXfxTQ1mhyOI2KSYVEqpOcqX+mO/OKTOXmkM9MyV
         ui1HpWhiRqCxiAIJVUox2tkj5sttsuTcWlxajqUHX22RO9YG5C5X5x3V2JGIuymnhVuY
         380Mdzp4AKeKYPPYnwPNEjF+DWocQD44lXojLjUQxIHw+i0D0+UJp5jNOU+YlHA6wYMS
         Og/WB4rQbbyQtYYKSTWDRF7TeGv74jGJlZvF02uuDjD2KO5RqgdtYOG0bsyS4opmBgPH
         QDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmwDBDiY6QNAXJf4a/Zr+AQ4b+xMVV3KgrRw2UGeEWI=;
        b=XhZvdNV1xeNWW7wX6FTYdVY5D/9c9FNpUrQzCULAkszUWhsymWU7P1c2pCsB9vNLiz
         bBpBbknYFY3rO3I7bo6EXJCbkd02Z+FqQhptseBV8At+ycr4a9esIpdhk2jJpv+JZ1/e
         0P7XHNcNiXCxyX2V6y5cbVkJdQ8bmtvJFGBFsiCv63VAUjdZWaDqfbygh1K4bz6a5yFV
         DEsK535ES46Tedd/y903zqaNQthKk2gkN8RJgtG7a1gn/Rg/Vy2YtVmZ2AmxHJhS5LYn
         LRG1XLLqD1e5nI/08rTEUx5lJp3jde2TwGiUA9e33OFo1+06n7hG1bubcly3k04ddvvO
         1SPw==
X-Gm-Message-State: ANoB5pk5qAopAlAJaWiFgR6UsGW3iMYiH5zYq5ZDvO30INzB5lrHF3GO
        VgV1wpyVcORsU1BLAyk0/E0=
X-Google-Smtp-Source: AA0mqf7ZSHZKzpScUGVdZ30LLYp5DkauJId66S1ZQEKGUGricLlgApwdlOBcIY5YUMd+OMpNrCGhdQ==
X-Received: by 2002:a17:902:b20f:b0:188:d4ea:251f with SMTP id t15-20020a170902b20f00b00188d4ea251fmr11455360plr.36.1669032007834;
        Mon, 21 Nov 2022 04:00:07 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id h72-20020a62834b000000b0056bd1bf4243sm8552468pfe.53.2022.11.21.04.00.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:00:07 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, me@ttaylorr.com
Subject: [RFC PATCH 0/4] ls-tree: pass state in struct, not globals
Date:   Mon, 21 Nov 2022 20:00:01 +0800
Message-Id: <20221121120001.5466-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
References: <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> write:


> These are patches I've been carrying locally since April-ish, as a
> follow-up to the "ls-tree --format" topic.

Cool.

> Teng: This conflicts with your topic, but re my suggestion of
> submitting a separate clean-up series in [2] maybe you could look this
> over, see how they differ from yours, and see what would make sense to
> keep/incorporate for such a clean-up series?

Yes, I'd like to.

> E.g. 1/4 here is the opposite approach of your 3/6[3], but as 3/4
> eventually shows we don't need that struct for anything except that
> callback case.

Ok, I will check it out later.


Thanks.

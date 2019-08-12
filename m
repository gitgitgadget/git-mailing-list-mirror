Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039211F45C
	for <e@80x24.org>; Mon, 12 Aug 2019 21:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfHLVft (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 17:35:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35070 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHLVfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 17:35:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so8400906pgv.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 14:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=JpyVOFAvpCZ2nJkqQWeoXmLhtyu4twMoDdPZWDXhJ/U=;
        b=nWF7D0PlXbNQG46G1eZldtYMqFOTV9/CcqsnB/5kElWQnh2EOMY3lnRW+hwDMIrBT9
         M1omwBe/3kegospDJyRyWQWDkz2hdje/iUbbI1KIkLS2OupOGnVToc1wPhS7c7hGBQ8/
         TPGjTqmPNZPXE8JfRgj2vabegKs6ReaLtU0ASfRkQAQ4u/xo1hvRQRAZ3yVlKtoFceV4
         4ZjPukGQidSePWE3sTUwlcLgi88ybjtFu89coJGV4awOsh0OCuw50NkJkoeNRJbbhIe5
         jV9uqbtQshOW/5OJy1ELyzy3Nv2s14GMDUEdtABB2JT0wFnYckdWLK732YxAjeMW0wYh
         sfWQ==
X-Gm-Message-State: APjAAAXtKtnCi9aL5FSdHAf2/TNa6/VJq/Mq+wNs59QTCoQJT6cN1xtE
        OiR+YJsFN0UHoW2gLv/HfYdsxQ==
X-Google-Smtp-Source: APXvYqxNlnDvqAlQB1qaEHPgbkl1g03MonUoFeVxFMtRIMZs7XIiJg6PCqXko1uYIEW0kFREOXGlsQ==
X-Received: by 2002:a17:90a:4c:: with SMTP id 12mr1183686pjb.40.1565645746762;
        Mon, 12 Aug 2019 14:35:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d189sm14494798pfd.165.2019.08.12.14.35.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:35:46 -0700 (PDT)
Subject: [PATCH v2 4/5] fetch: Add the --submodule-fetch-jobs option
Date:   Mon, 12 Aug 2019 14:34:47 -0700
Message-Id: <20190812213448.2649-5-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812213448.2649-1-palmer@sifive.com>
References: <20190812213448.2649-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is exactly the same as --jobs, but the more explicit name will
allow us to later change the behavior of --jobs to control both the
number of jobs for remotes as well as submodules.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Documentation/fetch-options.txt | 1 +
 builtin/fetch.c                 | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index dbd2add686dd..5836024f1934 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -160,6 +160,7 @@ ifndef::git-pull[]
 
 -j::
 --jobs=<n>::
+--submodule-fetch-jobs=<n>::
 	Number of parallel children to be used for fetching submodules.
 	Each will fetch from different submodules, such that fetching many
 	submodules will be faster. By default submodules will be fetched
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4c5f2ea3a931..67d001f3f78b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -146,6 +146,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("number of submodules fetched in parallel")),
 	OPT_INTEGER(0, "fetch-jobs", &max_children_for_fetch,
 		    N_("number of remotes fetched in parallel")),
+	OPT_INTEGER(0, "submodule-fetch-jobs", &max_children_for_submodules,
+		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
-- 
2.21.0


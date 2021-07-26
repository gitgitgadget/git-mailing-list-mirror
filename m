Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679CC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C702F60F6B
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhGZRNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:13:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhGZRNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:13:12 -0400
Received: (qmail 24968 invoked by uid 109); 26 Jul 2021 17:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Jul 2021 17:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22967 invoked by uid 111); 26 Jul 2021 17:53:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Jul 2021 13:53:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Jul 2021 13:53:39 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] ci: run "apt-get update" before "apt-get install"
Message-ID: <YP72o/1Yg02BcDXw@coredump.intra.peff.net>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
 <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 11:50:33AM +0000, Johannes Schindelin via GitGitGadget wrote:

> +    - name: Install other dependencies
> +      run: |
> +        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev

My CI runs based on 'next' started failing today. I think we'd want this
on top (of js/ci-make-sparse):

-- >8 --
Subject: [PATCH] ci: run "apt-get update" before "apt-get install"

The "sparse" workflow runs "apt-get install" to pick up a few necessary
packages. But it needs to run "apt-get update" first, or it risks trying
to download an old package version that no longer exists. And in fact
this happens now, with output like:

  2021-07-26T17:40:51.2551880Z E: Failed to fetch http://security.ubuntu.com/ubuntu/pool/main/c/curl/libcurl4-openssl-dev_7.68.0-1ubuntu2.5_amd64.deb  404  Not Found [IP: 52.147.219.192 80]
  2021-07-26T17:40:51.2554304Z E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?

Our other ci jobs don't suffer from this; they rely on scripts in ci/,
and ci/install-dependencies does the appropriate "apt-get update".

Signed-off-by: Jeff King <peff@peff.net>
---
I guess this package setup could also be moved into ci/install-dependencies.sh,
but I don't think it really buys anything (the "apt-get update" line
would not even be shared, because the outermost layer is a big switch
statement on the jobname). OTOH, it looks like other one-off jobs are in
there (e.g., StaticAnalysis).

Anyway, this is the minimal fixup.

 .github/workflows/main.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 1b5c039207..01878884ae 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -368,6 +368,7 @@ jobs:
       run: sudo dpkg -i sparse-20.04/sparse_*.deb
     - name: Install other dependencies
       run: |
+        sudo apt-get update -q &&
         sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
     - uses: actions/checkout@v2
     - run: make sparse
-- 
2.32.0.805.g1fa0022869


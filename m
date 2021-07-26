Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B9C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7973760C51
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGZRmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:42:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:57686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhGZRl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:41:59 -0400
Received: (qmail 25074 invoked by uid 109); 26 Jul 2021 18:22:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Jul 2021 18:22:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23283 invoked by uid 111); 26 Jul 2021 18:22:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Jul 2021 14:22:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Jul 2021 14:22:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: run "apt-get update" before "apt-get install"
Message-ID: <YP79Y/jESfCPBKM/@coredump.intra.peff.net>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
 <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
 <YP72o/1Yg02BcDXw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP72o/1Yg02BcDXw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 01:53:40PM -0400, Jeff King wrote:

> I guess this package setup could also be moved into ci/install-dependencies.sh,
> but I don't think it really buys anything (the "apt-get update" line
> would not even be shared, because the outermost layer is a big switch
> statement on the jobname). OTOH, it looks like other one-off jobs are in
> there (e.g., StaticAnalysis).
> 
> Anyway, this is the minimal fixup.

That would look like this on top. I don't have a strong feeling either
way.

-- >8 --
Subject: [PATCH] ci/install-dependencies: handle "sparse" job package installs

This just matches the style/location of the package installation for
other jobs. There should be no functional change.

I did flip the order of the options and command-name ("-y update"
instead of "update -y") for consistency with other lines in the same
file.

Note also that we have to reorder the dependency install with the
"checkout" action, so that we actually have the "ci" scripts available.

Signed-off-by: Jeff King <peff@peff.net>
---
 .github/workflows/main.yml | 6 ++----
 ci/install-dependencies.sh | 5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 01878884ae..224c46b6d6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -366,11 +366,9 @@ jobs:
         artifact: sparse-20.04
     - name: Install the current `sparse` package
       run: sudo dpkg -i sparse-20.04/sparse_*.deb
-    - name: Install other dependencies
-      run: |
-        sudo apt-get update -q &&
-        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
     - uses: actions/checkout@v2
+    - name: Install other dependencies
+      run: ci/install-dependencies.sh
     - run: make sparse
   documentation:
     needs: ci-config
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 67852d0d37..5772081b6e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -65,6 +65,11 @@ StaticAnalysis)
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
+sparse)
+	sudo apt-get -q update -q
+	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
+		libexpat-dev gettext zlib1g-dev
+	;;
 Documentation)
 	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
-- 
2.32.0.806.g45f317a2a5


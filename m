Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53953C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 07:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A112070A
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 07:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKVHRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:17:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:57778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726018AbfKVHRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 02:17:17 -0500
Received: (qmail 18711 invoked by uid 109); 22 Nov 2019 07:17:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Nov 2019 07:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20292 invoked by uid 111); 22 Nov 2019 07:21:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2019 02:21:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Nov 2019 02:17:16 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, stolee@gmail.com,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] commit-graph: use start_delayed_progress()
Message-ID: <20191122071716.GD23225@sigill.intra.peff.net>
References: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
 <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
 <e62dcc1ce503311c6c11452862f384492965a35f.1574351516.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e62dcc1ce503311c6c11452862f384492965a35f.1574351516.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 03:51:56PM +0000, Derrick Stolee via GitGitGadget wrote:

> The tests that check for the progress output have already been updated
> to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
> is one test in t6500-gc.sh that uses the test_terminal method. This
> mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,
> so we need to modify check on the output. We still watch for the
> "Enumerating objects" progress but no longer look for "Computing
> commit graph generation numbers".

I'm still puzzled by this paragraph. If I replace the test hunk in your
patch with this:

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 7f79eedd1c..0a69a67117 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -109,7 +109,8 @@ test_expect_success 'gc --no-quiet' '
 '
 
 test_expect_success TTY 'with TTY: gc --no-quiet' '
-	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
+	test_terminal env GIT_PROGRESS_DELAY=0 \
+		git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
 	test_i18ngrep "Enumerating objects" stderr &&
 	test_i18ngrep "Computing commit graph generation numbers" stderr

the test works fine for me.

-Peff

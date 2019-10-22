Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C38C1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbfJVVpz (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 17:45:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:55328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733177AbfJVVpz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 17:45:55 -0400
Received: (qmail 32449 invoked by uid 109); 22 Oct 2019 21:45:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Oct 2019 21:45:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19199 invoked by uid 111); 22 Oct 2019 21:49:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2019 17:49:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Oct 2019 17:45:54 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] commit-graph: fix writing first commit-graph during
 fetch
Message-ID: <20191022214553.GA18314@sigill.intra.peff.net>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
 <20191022203316.GC12270@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022203316.GC12270@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 04:33:16PM -0400, Jeff King wrote:

> > I have failed to produce a test using the file:// protocol that
> > demonstrates this bug.
> 
> Hmm, from the description, it sounds like it should be easy. I might
> poke at it a bit.

Hmph. I can reproduce it here, but it seems to depend on the repository.
If I do this:

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ecabbe1616..8d473a456f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -583,6 +583,14 @@ test_expect_success 'fetch.writeCommitGraph' '
 	)
 '
 
+test_expect_success 'fetch.writeCommitGraph with a bigger repo' '
+	git clone "$TEST_DIRECTORY/.." repo &&
+	(
+		cd repo &&
+		git -c fetch.writeCommitGraph fetch origin
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {

it reliably triggers the bug. But if I make a synthetic repo, even it
has a lot of commits (thousands or more), it doesn't trigger. I thought
maybe it had to do with having commits that were not at tips (since the
tip ones presumably _are_ fed into the graph generation process). But
that doesn't seem to help.

Puzzling...

-Peff

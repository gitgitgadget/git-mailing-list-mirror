Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7601F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 00:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfJWAsW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 20:48:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:55494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727140AbfJWAsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 20:48:22 -0400
Received: (qmail 1627 invoked by uid 109); 23 Oct 2019 00:48:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Oct 2019 00:48:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20146 invoked by uid 111); 23 Oct 2019 00:51:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2019 20:51:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Oct 2019 20:48:21 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] commit-graph: fix writing first commit-graph during
 fetch
Message-ID: <20191023004820.GA19611@sigill.intra.peff.net>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
 <20191022203316.GC12270@sigill.intra.peff.net>
 <20191022214553.GA18314@sigill.intra.peff.net>
 <20191022233556.GF4348@szeder.dev>
 <b7473363-b257-c00b-7338-a7e1d51bb01b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7473363-b257-c00b-7338-a7e1d51bb01b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 08:35:57PM -0400, Derrick Stolee wrote:

> > In the cover letter Derrick mentioned that he used
> > https://github.com/derrickstolee/numbers for testing, and that repo
> > has a submodule as well.
> 
> I completely forgot that I put a submodule in that repo. It makes sense
> that the Git repo also has one. Thanks for the test! I'll get it into
> the test suite tomorrow.

Ah, right. Good catch Gábor. The test below fails for me without your
patch, and succeeds with it (the extra empty commit is necessary so that
we have a parent).

I admit I am puzzled, though, _why_ the presence of the submodule
matters. That is, from your explanation, I thought the issue was simply
that `fetch` walked (and marked) some commits, and the flags overlapped
with what the commit-graph code expected.

I could guess that the presence of the submodule triggers some analysis
for --recurse-submodules. But then we don't actually recurse (maybe
because they're not activated? In which case maybe we shouldn't be doing
that extra walk to look for submodules if there aren't any activated
ones in our local repo).

I'd also wonder if it would be possible to trigger in another way (say,
due to want/have negotiation, though I guess most of the walking there
is done on the server side). But it may not be worth digging too far
into it.

-Peff

---
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ecabbe1616..1b092fec0b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -583,6 +583,21 @@ test_expect_success 'fetch.writeCommitGraph' '
 	)
 '
 
+test_expect_success 'fetch.writeCommitGraph with a submodule' '
+	git init has-submodule &&
+	(
+		cd has-submodule &&
+		git commit --allow-empty -m parent &&
+		git submodule add ../three &&
+		git commit -m "add submodule"
+	) &&
+	git clone has-submodule submod-clone &&
+	(
+		cd submod-clone &&
+		git -c fetch.writeCommitGraph fetch origin
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {

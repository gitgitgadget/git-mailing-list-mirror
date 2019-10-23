Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B40F1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 01:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfJWBW6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 21:22:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:55518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727140AbfJWBW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 21:22:58 -0400
Received: (qmail 1876 invoked by uid 109); 23 Oct 2019 01:22:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Oct 2019 01:22:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20293 invoked by uid 111); 23 Oct 2019 01:26:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2019 21:26:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Oct 2019 21:22:57 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] commit-graph: fix writing first commit-graph during
 fetch
Message-ID: <20191023012256.GA24104@sigill.intra.peff.net>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
 <20191022203316.GC12270@sigill.intra.peff.net>
 <20191022214553.GA18314@sigill.intra.peff.net>
 <20191022233556.GF4348@szeder.dev>
 <b7473363-b257-c00b-7338-a7e1d51bb01b@gmail.com>
 <20191023004820.GA19611@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191023004820.GA19611@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 08:48:20PM -0400, Jeff King wrote:

> I admit I am puzzled, though, _why_ the presence of the submodule
> matters. That is, from your explanation, I thought the issue was simply
> that `fetch` walked (and marked) some commits, and the flags overlapped
> with what the commit-graph code expected.
> 
> I could guess that the presence of the submodule triggers some analysis
> for --recurse-submodules. But then we don't actually recurse (maybe
> because they're not activated? In which case maybe we shouldn't be doing
> that extra walk to look for submodules if there aren't any activated
> ones in our local repo).

Indeed, that seems to be it. If I do this:

  git init repo
  cd repo
  cat >.gitmodules <<\EOF
  [submodule "foo"]
  path = foo
  url = https://example.com
  EOF
  time git fetch /path/to/git.git

then we end up traversing the whole git.git history a second time, even
though we should know off the bat that there are no active submodules
that we would recurse to.

Doing this makes the problem go away:

diff --git a/submodule.c b/submodule.c
index 0f199c5137..0db2f18b93 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1193,7 +1193,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(r, NULL, NULL))
+	if (!is_submodule_active(r, NULL))
 		return;
 
 	argv_array_push(&argv, "--"); /* argv[0] program name */

but causes some tests to fail (I think that in some cases we're supposed
to auto-initialize, and we'd probably need to cover that case, too).

All of this is outside of your fix, of course, but:

  1. I'm satisfied now that I understand why the test triggers the
     problem.

  2. You may want have a real activated submodule in your test. Right
     now we'll trigger the submodule-recursion check even without that,
     but in the future we might do something like the hunk above. In
     which case your test wouldn't be checking anything interesting
     anymore.

-Peff

Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DAFC33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CD820715
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgAGPaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:30:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:59236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728020AbgAGPaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 10:30:08 -0500
Received: (qmail 13243 invoked by uid 109); 7 Jan 2020 15:30:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 15:30:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31894 invoked by uid 111); 7 Jan 2020 15:35:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 10:35:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 10:30:06 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] graph: fix case that hit assert()
Message-ID: <20200107153006.GA20591@coredump.intra.peff.net>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <65186f3ded251e0bcf1fcb18160163a3efd97c37.1578408947.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65186f3ded251e0bcf1fcb18160163a3efd97c37.1578408947.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 02:55:45PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> A failure was reported in "git log --graph --all" with the new
> graph-rendering logic. Create a test case that matches the
> topology of that example and uses an explicit ref ordering instead
> of the "--all" option. The test would fail with the following error:
> 
> 	graph.c:1228: graph_output_collapsing_line: Assertion
> 		      `graph->mapping[i - 3] == target' failed.
> 
> The situation is a little complicated, so let's break it down.

First off, thanks for digging into this so promptly. Your solution looks
correct to me. Everything else I'll mention here are nits. :)

Your commit message starts off talking about the test, but without
describing what's interesting about it. I think the answer is that we
have two "skewed" merge parents for the same merge; maybe it would make
sense to lead with that. I.e.:

  Subject: graph: drop assert() for merge with two collapsing parents

  When "git log --graph" shows a merge commit that has two collapsing
  lines, like:

    [your diagram]

  we trigger an assert():

    graph.c:1228: graph_output_collapsing_line: Assertion
                  `graph->mapping[i - 3] == target' failed.

  ...and so on...

> The assert was introduced by eaf158f8 ("graph API: Use horizontal
> lines for more compact graphs", 2009-04-21), which is quite old.
> This assert is trying to say that when we complete a horizontal
> line with a single slash, it is because we have reached our target.

Thanks for this final sentence; writing that out in English made the
purpose of the assert() much clearer.

That could perhaps be an argument in favor of writing it as a BUG()
with a similar human-readable explanation. I guess there was already a
comment in the code, but it didn't quite click with me as much as what
you wrote above.

> It is actually the _second_ collapsing line that hits this assert.
> The reason we are in this code path is because we are collapsing
> the first line, and it in that case we are hitting our target now

s/it//

> that the horizontal line is complete. However, the second line
> cannot be a horizontal line, so it will collapse without horizontal
> lines. In this case, it is inappropriate to assert that we have
> reached our target, as we need to continue for another column
> before reaching the target. Dropping the assert is safe here.

I think that makes sense. My big concern here is that the assert() was
preventing us from looking out of bounds in the graph->mapping array,
but I don't think that's the case here.

Worth mentioning that this was due to 0f0f389f12 (graph: tidy up display
of left-skewed merges, 2019-10-15), in case somebody has to later dig
deeper?

> Second, the horizontal lines in that first line drop their coloring.
> This is due to a use of graph_line_addch() instead of
> graph_line_write_column(). Using a ternary operator to pick the
> character is nice for compact code, but we actually need a column
> to provide the color.

It seems like this is a totally separate bug, and could be its own
commit?

I think it's also caused by 0f0f389f12, which actually introduced the
seen_parent mechanism that you're correcting here.

> Helped-by: Jeff King <peff@peff.net>
> Reported-by: Bradley Smith <brad@brad-smith.co.uk>

I don't know that I did much, but OK. :)

Thanks once again Bradley for the reproducible case.

> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index 18709a723e..ddf6f6f5d3 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -240,4 +240,46 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
>  	EOF
>  '
>  
> +test_expect_success 'log --graph with multiple tips' '

This nicely covers the assert() problem. Could we check the same case
with "--color" and test_decode_color to check the coloring issue (see
t4214 for some prior art)?

-Peff

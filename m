Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D43620281
	for <e@80x24.org>; Thu,  7 Sep 2017 05:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbdIGF5D (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 01:57:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750742AbdIGF5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 01:57:03 -0400
Received: (qmail 30668 invoked by uid 109); 7 Sep 2017 05:57:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 05:57:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28706 invoked by uid 111); 7 Sep 2017 05:57:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 01:57:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 01:57:01 -0400
Date:   Thu, 7 Sep 2017 01:57:01 -0400
From:   Jeff King <peff@peff.net>
To:     Ross Kabus <rkabus@aerotech.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit
 messages
Message-ID: <20170907055701.ujibki2jwmzhhycm@sigill.intra.peff.net>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
 <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net>
 <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
 <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net>
 <CAEVs+zbCj0Zv0t4_WG6y2jcLoXwHy-Mu-LH31c_QgFaE9i3HtQ@mail.gmail.com>
 <20170905170311.yhcksrw2bxevd3hk@sigill.intra.peff.net>
 <CAEVs+zZRw3kW0C56NcJNXieCSTOa=uMxg6tDPjU2u+WDzhTLfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVs+zZRw3kW0C56NcJNXieCSTOa=uMxg6tDPjU2u+WDzhTLfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for following up. A few minor comments:

On Tue, Sep 05, 2017 at 04:57:24PM -0400, Ross Kabus wrote:

> From: Ross Kabus <rkabus@aerotech.com>
> Date: Tue, 5 Sep 2017 13:54:52 -0400
> Subject: [PATCH] commit-tree: don't append a newline with -F

Usually you'd just omit these in favor of the email headers (and replace
the email subject with this one).

> This change makes it such that commit-tree -F never appends a newline
> character to the supplied commit message (either from file or stdin).
> 
> Previously, commit-tree -F would always append a newline character to
> the text brought in from file or stdin. This has caused confusion in a
> number of ways:
>   - This is a plumbing command and it is generally expected not to do
>     text cleanup or other niceties.
>   - stdin piping with "-F -" appends a newline but stdin piping without
>     -F does not append a newline (inconsistent).
>   - git-commit has the --cleanup=verbatim option that prevents appending
>     a newline with its -F argument. There is no verbatim counterpart to
>     commit-tree -F (inconsistent).

This explanation all makes sense to me except for the last bit, which is
a bit subtle. I'd have said it more like:

  - git-commit does not specifically append a newline to the "-F"
    input. The issue is somewhat muddled by the fact that git-commit
    does pass the message through its --cleanup option, which may add
    such a newline. But for commit-tree to match "commit --cleanup=verbatim",
    we should not do so here.

> ---
>  builtin/commit-tree.c | 1 -
>  1 file changed, 1 deletion(-)

Your patch needs to be signed-off; see the Developer's Certificate of
Origin section in Documentation/SubmittingPatches.

> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index 19e898fa4..2177251e2 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -102,7 +102,6 @@ int cmd_commit_tree(int argc, const char **argv,
> const char *prefix)
>   if (fd && close(fd))
>   die_errno("git commit-tree: failed to close '%s'",
>    argv[i]);
> - strbuf_complete_line(&buffer);
>   continue;

Aside from the whitespace damage, the patch itself looks good.

-Peff

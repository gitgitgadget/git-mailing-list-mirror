Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBA51F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750849AbdEAWU5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:20:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:43448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbdEAWU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:20:56 -0400
Received: (qmail 30405 invoked by uid 109); 1 May 2017 22:20:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 22:20:54 +0000
Received: (qmail 6926 invoked by uid 111); 1 May 2017 22:21:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 18:21:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 18:20:51 -0400
Date:   Mon, 1 May 2017 18:20:51 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 3/4] diff: enable indent heuristic by default
Message-ID: <20170501222051.svylxazjwnot3wwg@sigill.intra.peff.net>
References: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
 <20170501221345.4025-1-marcnarc@xiplink.com>
 <20170501221345.4025-4-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170501221345.4025-4-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 06:13:44PM -0400, Marc Branchaud wrote:

> From: Stefan Beller <sbeller@google.com>
> 
> The feature was included in v2.11 (released 2016-11-29) and we got no
> negative feedback. Quite the opposite, all feedback we got was positive.
> 
> Turn it on by default. Users who dislike the feature can turn it off
> by setting diff.indentHeuristic (which also configures plumbing commands,
> see prior patches).
> 
> The change to t/t4051-diff-function-context.sh is needed because the
> heuristic shifts the changed hunk in the patch.  To get the same result
> regardless of the heuristic configuration, we modify the test file
> differently:  We insert a completely new line after line 2, instead of
> simply duplicating it.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> 
> ---
> 
> Tested the sed "2a" command's escaping in both Ubuntu 17.04 and FreeBSD 10.3.
> Threw in a little indenting so that it isn't too ugly.

I think that should be fine. The indenting will go into the output, but
we really don't care _what_ that line is, just as long as it's new
content.

> diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
> index 13d3dc96a..56d7d7760 100755
> --- a/t/t4061-diff-indent.sh
> +++ b/t/t4061-diff-indent.sh
> @@ -153,7 +153,7 @@ test_expect_success 'prepare' '
>  '
>  
>  test_expect_success 'diff: ugly spaces' '
> -	git diff old new -- spaces.txt >out &&
> +	git diff --no-indent-heuristic old new -- spaces.txt >out &&
>  	compare_diff spaces-expect out
>  '

I guess one could argue that most of t4061 should be rewritten. This
fixes the failures that the "ugly" version is no longer the default. But
the tests checking that diff.indentHeuristic=true works are basically
doing nothing (the interesting thing after this patch is that setting it
to false goes back to the ugly output).

I dunno. If we drop the config and options as experiments, then the
whole script basically goes away in favor of checking that the test case
has the non-ugly output. If that's our endgame, it may not be worth
spending too much time refactoring it. But if we're going to keep the
config indefinitely, maybe we should make sure it works.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637F61F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeC3Nlv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:41:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:48642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751163AbeC3Nlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:41:50 -0400
Received: (qmail 10593 invoked by uid 109); 30 Mar 2018 13:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 13:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27670 invoked by uid 111); 30 Mar 2018 13:42:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 09:42:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 09:41:48 -0400
Date:   Fri, 30 Mar 2018 09:41:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] builtin/config.c: treat type specifiers singularly
Message-ID: <20180330134148.GC29568@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180330052830.57251-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180330052830.57251-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 01:28:29AM -0400, Taylor Blau wrote:

> Internally, we represent `git config`'s type specifiers as a bitset
> using OPT_BIT. 'bool' is 1<<0, 'int' is 1<<1, and so on. This technique
> allows for the representation of multiple type specifiers in the `int
> types` field, but this multi-representation is left unused.
> 
> In fact, `git config` will not accept multiple type specifiers at a
> time, as indicated by:
> 
>   $ git config --int --bool some.section
>   error: only one type at a time.
> 
> This patch uses `OPT_SET_INT` to prefer the _last_ mentioned type
> specifier, so that the above command would instead be valid, and a
> synonym of:
> 
>   $ git config --bool some.section
> 
> This change is motivated by two urges: (1) it does not make sense to
> represent a singular type specifier internally as a bitset, only to
> complain when there are multiple bits in the set. `OPT_SET_INT` is more
> well-suited to this task than `OPT_BIT` is. (2) a future patch will
> introduce `--type=<type>`, and we would like not to complain in the
> following situation:
> 
>   $ git config --int --type=int

I think you could just end here, since...

> Where--although the legacy and modern type specifier (`--int`, and
> `--type`, respectively) do not conflict--we would store the value of
> `--type=` in a `char *` and the `--int` as a bit in the `int` bitset.
> 
> In the above, when error-checking `if (types != && type_str)`, we do not
> check additionally whether or not these types are the same, and simply
> complain immediately. This change makes `--int` and `--type=int` a true
> synonym of each other, and removes the need for additional complexity,
> as above in the conditional.

None of this type_str stuff exists yet, and you've sufficiently
motivated the change.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/config.c       | 39 +++++++++++++++++----------------------
>  t/t1300-repo-config.sh | 11 +++++++++++
>  2 files changed, 28 insertions(+), 22 deletions(-)

The patch mostly looks good. We probably want to also rewrite the TYPE_*
#defines to be sequential, since somebody may scratch their head
wondering why we use one bit per type when we do not treat them as a
bitfield.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 4f8e6f5fd..aa45b9267 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1611,4 +1611,15 @@ test_expect_success '--local requires a repo' '
>  	test_expect_code 128 nongit git config --local foo.bar
>  '
>  
> +cat >.git/config <<-\EOF &&
> +[core]
> +number = 10
> +EOF
> +
> +test_expect_success 'later legacy specifiers are given precedence' '
> +	git config --bool --int core.number >actual &&
> +	echo 10 > expect &&
> +	test_cmp expect actual
> +'

Minor style nit: we prefer ">expect" with no space. Though t1300 is
certainly a cornucopia of style violations already. I could buy it under
the guise of matching existing style if there wasn't a counter-example
directly above. :)

We also prefer to put that "cat >.git/config" inside a test block,
though I'm pretty sure that _is_ following existing style in the test.

-Peff

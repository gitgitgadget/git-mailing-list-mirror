Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FDCB1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeBHQeS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:34:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:45354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752233AbeBHQeS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:34:18 -0500
Received: (qmail 25134 invoked by uid 109); 8 Feb 2018 16:34:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 16:34:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12081 invoked by uid 111); 8 Feb 2018 16:35:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 11:35:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 11:34:16 -0500
Date:   Thu, 8 Feb 2018 11:34:16 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 8/9] t: validate 'test_i18ngrep's parameters
Message-ID: <20180208163416.GA13078@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
 <20180208155656.9831-9-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180208155656.9831-9-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 04:56:55PM +0100, SZEDER Gábor wrote:

> Prevent similar mistakes in the future by validating 'test_i18ngrep's
> parameters requiring that
> 
>   - The last parameter names an existing file to be read, effectively
>     forbiding piping into 'test_i18ngrep'.

s/forbiding/forbidding/

>     Note that this change will also forbid cases where 'test_i18ngrep'
>     would legitimately read its standard input, e.g. when its standard
>     input is redirected from a file, or when a git command's standard
>     output is first written to an intermediate file, which is then
>     preprocessed by a non-git command before the results are piped
>     into 'test_i18ngrep'.  See two of the previous patches for the
>     only such cases we had in our test suite.  However, reliably
>     preventing the piping antipattern is arguably more important than
>     supporting these cases, which can be easily worked around by
>     opening the file directly or using an intermediate file anyway.
> 
>   - There are at least two parameters, not including the optional '!'
>     to negate the pattern.  This ought to catch corner cases when
>     'test_i18ngrep' looks for the name of an existing file on its
>     standard input; the above check would miss this case becase the
>     filename as pattern would be the last parameter.
> 
>     Note that this is not quite perfect, as it doesn't account for any
>     'grep --options' given as parameters.  However, doing so would be
>     far too complicated, considering that patterns can start with
>     dashes as well, and in the majority of the cases we don't use any
>     such options anyway.

And most importantly, we never err on the side of complaining
unnecessarily. So our safety might not kick in, but as long as it kicks
in most of the time, we're fine.

I like this approach much better than the previous round.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 92ed029371..a1676e0386 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -719,6 +719,18 @@ test_i18ncmp () {
>  # under GETTEXT_POISON this pretends that the command produced expected
>  # results.
>  test_i18ngrep () {
> +	eval "last_arg=\"\${$#}\""

These embedded double-quotes are unnecessary, I think, because it's a
variable assignment: E.g.:

  set -- one two 'foo bar'
  eval "last_arg=\${$#}"
  echo $last_arg

should produce "foo bar".

Usually not a big deal, but because of the extra quoting it may make the
whole thing a bit more readable to drop them.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E47E1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeAZSmJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:42:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:59060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752134AbeAZSly (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:41:54 -0500
Received: (qmail 15948 invoked by uid 109); 26 Jan 2018 18:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:41:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17424 invoked by uid 111); 26 Jan 2018 18:42:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:42:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:41:51 -0500
Date:   Fri, 26 Jan 2018 13:41:51 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] t: forbid piping into 'test_i18ngrep'
Message-ID: <20180126184151.GD27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-9-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180126123708.21722-9-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 01:37:06PM +0100, SZEDER Gábor wrote:

> When checking a git command's output with 'test_i18ngrep', it's
> tempting to conveniently pipe the git command's standard output into
> 'test_i18ngrep'.  Unfortunately, this is an anti-pattern, because it
> hides the git command's exit code, and the test could continue even if
> the command exited with error.
> 
> Add a bit of linting to 'test_i18ngrep' to detect when data is fed to
> its standard input and to error out with a "bug in the test script"
> message.
> 
> Note that this change will also forbid cases where 'test_i18ngrep'
> would legitimately read its standard input, e.g.
> 
>   - when its standard input is redirected from a file, or
> 
>   - when a git command's standard output is first written to an
>     intermediate file, which is then preprocessed by a non-git command
>     before the results are piped into 'test_i18ngrep'.
> 
> See two of the previous patches for the only such cases we had in our
> test suite.  However, reliably preventing this antipattern is arguably
> more important than supporting these cases, which can be worked around
> by only minor inconveniences.

The idea seems reasonable to me. Let's think about what the escape hatch
looks like to work around it if you need to.

I guess you've got:

  cat >file &&
  test_i18ngrep ... file

which is not too bad.

You've also got:

  test_i18ngrep ... -

though that relies on the underlying grep understanding "-" (which is in
POSIX, though with a rather vague "if the implementations supports it").
And it wouldn't work with the "read" test in this patch.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 92ed02937..e381d50d0 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -719,6 +719,10 @@ test_i18ncmp () {
>  # under GETTEXT_POISON this pretends that the command produced expected
>  # results.
>  test_i18ngrep () {
> +	( read line ) &&
> +	error "bug in the test script: data on test_i18ngrep's stdin;" \
> +	      "perhaps a git command's output is piped into it?"
> +

This seems kind of hacky compared to just seeing if there is a file
argument. But I suppose that is hard to do, since we just pass through
the arguments to grep.

Though looking at our test_18ngrep invocations, they are simple enough
that would just ask "are there two non-option arguments at the end of
the command line". The exception is "-e", but IMHO we could just drop
that. It serves no purpose unless you're trying to hide a "-" at the
start of your pattern, and in fact we used to ban it since sysv grep
didn't understand it (e.g., aadbe44f883).

-Peff

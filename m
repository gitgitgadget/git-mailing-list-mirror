Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B6420441
	for <e@80x24.org>; Mon, 16 Jan 2017 16:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdAPQFL (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 11:05:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:39767 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdAPQFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 11:05:06 -0500
Received: (qmail 32052 invoked by uid 109); 16 Jan 2017 16:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:04:58 +0000
Received: (qmail 10253 invoked by uid 111); 16 Jan 2017 16:05:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 11:05:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 11:04:56 -0500
Date:   Mon, 16 Jan 2017 11:04:56 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
Message-ID: <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701161251100.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 01:52:39PM +0100, Johannes Schindelin wrote:

> > >  An error message with an ASCII control character like '\r' in it
> > >  can alter the message to hide its early part, which is problematic
> > >  when a remote side gives such an error message that the local side
> > >  will relay with a "remote: " prefix.
> > >
> > >  Will merge to 'next'.
> > 
> > Please be not too hasty with advancing this topic to master. I could imagine
> > that there is some unwanted fallout on systems where the end-of-line marker
> > CRLF is common. Though, I haven't tested the topic myself, yet, nor do I
> > expect regressions in *my* typical workflow.
> 
> Thank you for being so attentive.
> 
> This topic branch would indeed have caused problems. Worse: it would have
> caused problems that are not covered by our test suite, as Git for
> Windows' own utilities do not generate CR/LF line endings. So this
> regression would have bit our users. Nasty.

Hmm.  I am not sure to what degree CRLFs are actually a problem here.
Keep in mind these are error messages generated via error(), and so not
processing arbitrary data. I can imagine that CRs might come from:

  1. A parameter like a filename or revision name. If I ask for a
     rev-parse of "foo\r\n", then it's probably useful to mention the
     "\r" in the error message, rather than ignoring it (or converting
     it to a line-feed).

     And I think that would apply to any input parameter we show via
     error(), etc, if it is connected to a newline (ideally we would
     show newlines as "?", too, but we cannot tell the difference
     between ones from parameters, and ones that are part of the error
     message).

  2. The printf-fmt strings themselves. But these come from C code,
     which just uses "\n". My impression is that it is fprintf() which
     is responsible for converting that to "\r\n". And we are doing our
     sanitizing here between an snprintf(), and an fprintf() of the
     result. So it should see only the raw "\n" fields.

I am certainly open to loosening the sanitizing for CR to make things
work seamlessly on Windows. But I am having trouble imagining a case
that is actually negatively impacted.

> -- snipsnap --
> Subject: [PATCH] fixup! vreport: sanitize ASCII control chars

Given the subtlety here, I'd much rather have a patch on top.

> The original patch is incorrect, as it turns carriage returns into
> question marks.
> 
> However, carriage returns should be left alone when preceding a line feed,
> and simply turned into line feeds otherwise.

The question of whether to leave CRLFs alone is addressed above. But I
do not understand why you'd want a lone CR to be converted to a line
feed. Running:

  git rev-parse --abbrev-ref "$(printf "foo\r")"

with my patch gets you:

  fatal: ambiguous argument 'foo?': unknown revision or path not in the working tree.

But with yours:

  fatal: ambiguous argument 'foo
  ': unknown revision or path not in the working tree.

Obviously the "?" thing is a lossy transformation, but I do not see how
a newline is any less confusing (but see below for some thoughts).

> To make the end result more readable, the logic is inverted so that the
> common case (no substitution) is handled first.
> 
> While at it, let's lose the unnecessary curly braces.

Please don't. Obviously C treats the "if/else" as a single unit, but
IMHO it's less error-prone to include the braces any time there are
multiple visual lines. E.g., something like:

  while (foo)
	if (bar)
		one();
	else
		two();
	three();

is much easier to spot as wrong when you would require braces either
way (and not relevant here, but I'd say that even an inner block with a
comment deserves braces for the same reason).

> We also add a regression test that verifies that carriage returns are
> handled properly. And as we expect CR/LF to be handled properly also on
> platforms other than Windows, this test case is not guarded by the MINGW
> prerequisite.

I am not sure what "properly" means here. In your test:

> +# This test verifies that the error reporting functions handle CR correctly.
> +# --abbrev-ref is simply used out of convenience, as it reports an error including
> +# a user-specified argument.
> +test_expect_success 'error messages treat CR/LF correctly' '
> +	test_must_fail git rev-parse --abbrev-ref "$(printf "CR/LF\\r\\n")" 2>err &&
> +	grep "^fatal: .*CR/LF$" err
> +'

The "\n" is eaten by the shell, and git sees only "CR/LF\r". So we are
not testing the CRLF case in vreportf() at all.

We do end up with "CR/LF\n" in vreportf(), which is presumably converted
by fprintf() to "CR/LF\r\n" on Windows. And so perhaps that is why you
are doing the "convert \r to \n" thing above.

But I still think it's not doing the right thing. Git _didn't_ see CRLF,
it saw CR.

-Peff

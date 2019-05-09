Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31BD1F45F
	for <e@80x24.org>; Thu,  9 May 2019 07:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEIHo6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 03:44:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:52840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725774AbfEIHo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 03:44:57 -0400
Received: (qmail 17225 invoked by uid 109); 9 May 2019 07:44:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 07:44:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32262 invoked by uid 111); 9 May 2019 07:45:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 03:45:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 03:44:55 -0400
Date:   Thu, 9 May 2019 03:44:55 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH 2/2] builtin/verify-tag: do not omit gpg on --format
Message-ID: <20190509074455.GB24493@sigill.intra.peff.net>
References: <20190427202123.15380-1-santiago@nyu.edu>
 <20190427202123.15380-3-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190427202123.15380-3-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 27, 2019 at 04:21:23PM -0400, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> The current implementation of git-verify-tag omits the gpg output when
> the --format flag is passed. This may not be useful to users that want
> to see the gpg output *and* --format the output of git verify-tag.
> Instead, respect the --raw flag or the default gpg output.

Yep, this is just the matching change to patch 1. Makes sense.

> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 6fa04b751a..262e73cb45 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -47,15 +47,13 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  	if (argc <= i)
>  		usage_with_options(verify_tag_usage, verify_tag_options);
>  
> -	if (verbose)
> +	if (verbose && !format.format)
>  		flags |= GPG_VERIFY_VERBOSE;

Now this one's VERBOSE handling is a bit interesting. Previously we'd
set VERBOSE even if we were going to show a format.  And then later we
just set the OMIT_STATUS bit, leaving VERBOSE in place:

> -		flags |= GPG_VERIFY_OMIT_STATUS;

That _usually_ didn't matter because with OMIT_STATUS, we'd never enter
print_signature_buffer(), which is where VERBOSE would usually kick in.
But there's another spot we look at it:

  $ grep -nC2 VERBOSE tag.c 
  22-
  23-	if (size == payload_size) {
  24:		if (flags & GPG_VERIFY_VERBOSE)
  25-			write_in_full(1, buf, payload_size);
  26-		return error("no signature found");

So the code prior to your patch actually had another weird behavior. Try
this:

  $ git verify-tag -v --format='my tag is %(tag)' v2.21.0
  my tag is v2.21.0

  $ git tag -m bar foo
  $ git verify-tag -v --format='my tag is %(tag)' foo
  object 66395b630f8ca08705b36c359415af8b25da9a11
  type commit
  tag foo
  tagger Jeff King <peff@peff.net> 1557387618 -0400
  
  bar
  error: no signature found

The "-v" only kicks in when there's an error. I think what your patch is
doing (consistently ignoring "-v" when there's a format) makes more
sense. It may be worth alerting the user when "-v" and "--format" are
used together (or arguably we should _always_ show "-v" if the user
really asked for it, but it does not make any sense to me for somebody
to do so).

> -	if (format.format) {
> +	if (format.format)
>  		if (verify_ref_format(&format))
>  			usage_with_options(verify_tag_usage,
>  					   verify_tag_options);
> -	}

This leaves us with a weird doubled conditional (with no braces
either!). Maybe:

  if (format.format && verify_ref_format(&format))
	usage_with_options(...);

?

Other than that, the patch looks good. I think it could use a test in
t7030, though.

-Peff

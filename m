Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9191F45F
	for <e@80x24.org>; Thu,  9 May 2019 07:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEIHgq (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 03:36:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:52814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725940AbfEIHgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 03:36:46 -0400
Received: (qmail 16952 invoked by uid 109); 9 May 2019 07:36:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 07:36:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32193 invoked by uid 111); 9 May 2019 07:37:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 03:37:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 03:36:44 -0400
Date:   Thu, 9 May 2019 03:36:44 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH 1/2] builtin/tag: do not omit -v gpg out for --format
Message-ID: <20190509073644.GA24493@sigill.intra.peff.net>
References: <20190427202123.15380-1-santiago@nyu.edu>
 <20190427202123.15380-2-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190427202123.15380-2-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 27, 2019 at 04:21:22PM -0400, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> The current implementation of git tag -v omits the gpg output when the
> --format flag is passed. This may not be useful to users that want to
> see the gpg output *and* --format the output of the git tag -v. Instead,
> pass the default gpg interface output if --format is specified.

Yeah, I think this is the right thing to do.

> @@ -110,10 +110,10 @@ static int verify_tag(const char *name, const char *ref,
>  {
>  	int flags;
>  	const struct ref_format *format = cb_data;
> -	flags = GPG_VERIFY_VERBOSE;
> +	flags = 0;
>  
> -	if (format->format)
> -		flags = GPG_VERIFY_OMIT_STATUS;
> +	if (!format->format)
> +		flags = GPG_VERIFY_VERBOSE;

So we're going to stop setting OMIT_STATUS ever, which makes sense.

It took me a minute to figure out here that the behavior for VERBOSE is
not changed, because we _overwrite_ flags, rather than just setting a
single bit. But that's definitely the right thing to do when there's a
format (both before and after your patch).

So this looks good to me. I think we should probably cover it with a
test in t7004.

-Peff

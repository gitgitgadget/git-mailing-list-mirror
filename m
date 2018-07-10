Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60BB1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934107AbeGJPtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:49:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:53754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934257AbeGJPtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:49:33 -0400
Received: (qmail 23348 invoked by uid 109); 10 Jul 2018 15:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 15:49:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27827 invoked by uid 111); 10 Jul 2018 15:49:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 11:49:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 11:49:31 -0400
Date:   Tue, 10 Jul 2018 11:49:31 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 6/9] gpg-interface: do not hardcode the key string len
 anymore
Message-ID: <20180710154931.GA23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:52:28AM +0200, Henning Schild wrote:

> gnupg does print the keyid followed by a space and the signer comes
> next. The same pattern is also used in gpgsm, but there the key length
> would be 40 instead of 16. Instead of hardcoding the expected length,
> find the first space and calculate it.

Sounds good, but I think there's an off-by-one in the patch.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0a8d1bff3..ac2df498d 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -88,10 +88,11 @@ static void parse_gpg_output(struct signature_check *sigc)
>  		sigc->result = sigcheck_gpg_status[i].result;
>  		/* The trust messages are not followed by key/signer information */
>  		if (sigc->result != 'U') {
> -			sigc->key = xmemdupz(found, 16);
> +			next = strchrnul(found, ' ');
> +			sigc->key = xmemdupz(found, next - found);

Here "next" may point to the trailing NUL of the string...

>  			/* The ERRSIG message is not followed by signer information */
>  			if (sigc-> result != 'E') {
> -				found += 17;
> +				found = next + 1;
>  				next = strchrnul(found, '\n');

...in which case "found" points past the end of the string, and we
search random memory. That's presumably impossible with well-formed gpg
output (you don't get 'E' without an extra message), but we should be
robust against bogus input.

In the general case you need:

  found = *next ? next + 1 : next;

or similar. In this case, you can actually do:

  found = next;

because we know that it's OK to search over the literal space again. But
that's pretty subtle, so we're probably better off just doing the
conditional above.

(And yes, looking at the existing code, I think it's even worse, as
there does not seem to be a guarantee that we even have 16 characters in
the string).

-Peff

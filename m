Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486271F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 17:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeGJRBN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 13:01:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:53980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754085AbeGJRBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 13:01:12 -0400
Received: (qmail 26282 invoked by uid 109); 10 Jul 2018 17:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 17:01:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28585 invoked by uid 111); 10 Jul 2018 17:01:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 13:01:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 13:01:10 -0400
Date:   Tue, 10 Jul 2018 13:01:10 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 8/9] gpg-interface: introduce new signature format
 "x509" using gpgsm
Message-ID: <20180710170109.GG23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <4a2cf83a63d25776cb1996490240ce3e5df8ada4.1531208187.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a2cf83a63d25776cb1996490240ce3e5df8ada4.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:52:30AM +0200, Henning Schild wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c0bd80954..b6f9b47d5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1830,7 +1830,7 @@ gpg.program::
>  
>  gpg.format::
>  	Specifies which key format to use when signing with `--gpg-sign`.
> -	Default is "openpgp", that is also the only supported value.
> +	Default is "opengpg" and another possible value is "x509".

opengpg?

Since we're having so much fun with naming discussions, let's talk about
"x509". :)

That's the cert format. I think of these signatures as S/MIME, but
really that's the mail-oriented parts of the standard. I think
technically this is "CMS".

That said, we should pick what most people will find natural when
referring to it. So maybe x509 isn't the worst choice, as I doubt most
people know the term CMS. Probably the term they know _most_ is "gpgsm",
but I think the point is that one does not have to be using gpgsm in the
first place.

So I dunno. I think I talked myself back into x509. ;)

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 65098430f..bf8d567a4 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -16,13 +16,18 @@ struct gpg_format_data {
>  
>  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
>  #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
> +#define X509_SIGNATURE "-----BEGIN SIGNED MESSAGE-----"
>  
> -enum gpgformats { PGP_FMT };
> +enum gpgformats { PGP_FMT, X509_FMT };
>  struct gpg_format_data gpg_formats[] = {
>  	{ .format = "openpgp", .program = "gpg",
>  	  .extra_args_verify = { "--keyid-format=long" },
>  	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE }
>  	},
> +	{ .format = "x509", .program = "gpgsm",
> +	  .extra_args_verify = { NULL },
> +	  .sigs = { X509_SIGNATURE, NULL }
> +	},

Extremely minor nit, but if there are no other uses of PGP_SIGNATURE etc
outside of this array (as I hope there wouldn't be after this series),
would it make more sense to just include the literals inline in the
array definition? That's one less layer of indirection when somebody is
reading the code.

-Peff

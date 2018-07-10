Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F541F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeGJQyP (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:54:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:53932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753848AbeGJQyP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:54:15 -0400
Received: (qmail 25946 invoked by uid 109); 10 Jul 2018 16:54:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 16:54:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28495 invoked by uid 111); 10 Jul 2018 16:54:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 12:54:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 12:54:13 -0400
Date:   Tue, 10 Jul 2018 12:54:13 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per
 gpg format program
Message-ID: <20180710165412.GE23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:52:29AM +0200, Henning Schild wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ac373e3f4..c0bd80954 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1832,6 +1832,11 @@ gpg.format::
>  	Specifies which key format to use when signing with `--gpg-sign`.
>  	Default is "openpgp", that is also the only supported value.
>  
> +gpg.<format>.program::
> +	Use this to customize the program used for the signing format you
> +	chose. (see gpg.program) gpg.openpgp.program is a synonym for the
> +	legacy gpg.program.

This seems like a good step forward. This is similar to the
signingtool.$name.program I proposed earlier, but keeping it specific to
gpg, which makes sense.

On the other hand, do we anticipate the user ever being able to add
gpg.foo.program? I don't think so; we'll provide a limited set of
options. So we _could_ go with "gpg.openpgpProgram" or similar, and
later add "gpg.x509Program".

And one reason to do so might be...

> diff --git a/gpg-interface.c b/gpg-interface.c
> index ac2df498d..65098430f 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -179,7 +179,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  		return git_config_string(&gpg_format, var, value);
>  	}
>  
> -	if (!strcmp(var, "gpg.program"))
> +	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
>  		return git_config_string(&gpg_formats[PGP_FMT].program, var,
>  					 value);

We normally match config keys with strcmp() because the config machinery
will have already normalized them to lowercase. But in Git's config
format, the subsection (the middle in a three-dot name) is less
restricted and is case-sensitive.

Should we allow:

  [gpg "OpenPGP"]
  program = whatever

given that we allow:

  [gpg]
  format = OpenPGP

? I think just using strcasecmp() here would be sufficient. But I wonder
if it is a symptom of using the wrong tool (subsections) when we don't
need it.

-Peff

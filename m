Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B671F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbeGKQU3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:20:29 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:59418 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKQU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:20:29 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6BGF7K4017568
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 18:15:07 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6BGF6aR029686;
        Wed, 11 Jul 2018 18:15:06 +0200
Date:   Wed, 11 Jul 2018 18:15:05 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Jeff King <peff@peff.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 6/9] gpg-interface: do not hardcode the key string
 len anymore
Message-ID: <20180711181505.31ea530b@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180711142751.GF23835@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
        <20180710154931.GA23624@sigill.intra.peff.net>
        <20180711105459.57ed99cc@md1pvb1c.ad001.siemens.net>
        <20180711123425.GB23835@sigill.intra.peff.net>
        <20180711154619.7b574dff@md1pvb1c.ad001.siemens.net>
        <20180711142751.GF23835@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Wed, 11 Jul 2018 10:27:52 -0400
schrieb Jeff King <peff@peff.net>:

> On Wed, Jul 11, 2018 at 03:46:19PM +0200, Henning Schild wrote:
> 
> > > I think it's worth addressing in the near term, if only because
> > > this kind of off-by-one is quite subtle, and I don't want to
> > > forget to deal with it. Whether that happens as part of this
> > > patch, or as a cleanup before or after, I'm not picky. :)  
> > 
> > I get that and if anyone is willing to write that code, i will base
> > my patches on it. What i want to avoid is taking responsibility for
> > problems i did not introduce, just because i happen to work on that
> > code at the moment. Keeping track of that (not forgetting) is also
> > not for the random contributor like myself.  
> 
> It doesn't make sense to do a patch before your series, since it would
> just be:
> 
>   if (strlen(found) > 16)
>     ...

Instead of randomly crashing on unexpected input, we would now silently
ignore it.

> which would get obliterated by your patch. The patch after is shown
> below. But frankly, it seems a lot easier to just handle this while
> you are rewriting the code.
> 
> -- >8 --  
> Subject: [PATCH] gpg-interface: handle off-by-one parsing gpg output
> 
> When parsing gpg's VALIDSIG lines, we look for a space
> followed by the signer information. Because we use
> strchrnul(), though, if the space is missing we'll end up
> pointing to the trailing NUL. When we try to move past that
> space, we have to handle the NUL case separately to avoid
> accidentally stepping out of the string entirely.

True.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  gpg-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gpg-interface.c b/gpg-interface.c
> index bf8d567a4c..139b0f561e 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -97,7 +97,7 @@ static void parse_gpg_output(struct signature_check
> *sigc) sigc->key = xmemdupz(found, next - found);
>  			/* The ERRSIG message is not followed by
> signer information */ if (sigc-> result != 'E') {
> -				found = next + 1;
> +				found = *next ? next + 1 : next;

This would keep us in bounds of the unexpected string. But ignore the
line instead of "complaining" or crashing.

But you are right, it is easy enough and ignoring the line is probably
the best way of dealing with it.

i will change the condition to
> if (*next && sigc-> result != 'E')

also skipping the following strchrnul and xmemdupz

Henning

>  				next = strchrnul(found, '\n');
>  				sigc->signer = xmemdupz(found, next
> - found); }


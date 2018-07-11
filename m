Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8540B1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 08:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeGKI6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 04:58:40 -0400
Received: from thoth.sbs.de ([192.35.17.2]:47278 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeGKI6i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 04:58:38 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6B8t0Q8006910
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 10:55:01 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6B8sxpQ023212;
        Wed, 11 Jul 2018 10:55:00 +0200
Date:   Wed, 11 Jul 2018 10:54:59 +0200
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
Message-ID: <20180711105459.57ed99cc@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180710154931.GA23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
        <20180710154931.GA23624@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 10 Jul 2018 11:49:31 -0400
schrieb Jeff King <peff@peff.net>:

> On Tue, Jul 10, 2018 at 10:52:28AM +0200, Henning Schild wrote:
> 
> > gnupg does print the keyid followed by a space and the signer comes
> > next. The same pattern is also used in gpgsm, but there the key
> > length would be 40 instead of 16. Instead of hardcoding the
> > expected length, find the first space and calculate it.  
> 
> Sounds good, but I think there's an off-by-one in the patch.
> 
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 0a8d1bff3..ac2df498d 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -88,10 +88,11 @@ static void parse_gpg_output(struct
> > signature_check *sigc) sigc->result = sigcheck_gpg_status[i].result;
> >  		/* The trust messages are not followed by
> > key/signer information */ if (sigc->result != 'U') {
> > -			sigc->key = xmemdupz(found, 16);
> > +			next = strchrnul(found, ' ');
> > +			sigc->key = xmemdupz(found, next -
> > found);  
> 
> Here "next" may point to the trailing NUL of the string...
> 
> >  			/* The ERRSIG message is not followed by
> > signer information */ if (sigc-> result != 'E') {
> > -				found += 17;
> > +				found = next + 1;
> >  				next = strchrnul(found, '\n');  
> 
> ...in which case "found" points past the end of the string, and we
> search random memory. That's presumably impossible with well-formed
> gpg output (you don't get 'E' without an extra message), but we
> should be robust against bogus input.
> 
> In the general case you need:
> 
>   found = *next ? next + 1 : next;
> 
> or similar. In this case, you can actually do:
> 
>   found = next;
> 
> because we know that it's OK to search over the literal space again.
> But that's pretty subtle, so we're probably better off just doing the
> conditional above.
> 
> (And yes, looking at the existing code, I think it's even worse, as
> there does not seem to be a guarantee that we even have 16 characters
> in the string).

The existing code works only on expected output and the same is true
for the version after this patch. Making the parser robust against
random input would imho be a sort of cleanup patch on top of my
series. .. or before, in which case i would become responsible for
making sure that still works after my modification.
This argument is twofold. I do not really want to fix that as well and
it might be a good idea to separate concerns anyways.

Henning

> -Peff


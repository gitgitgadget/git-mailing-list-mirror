Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3323F1F6AC
	for <e@80x24.org>; Thu,  5 Jul 2018 13:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeGENW3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 5 Jul 2018 09:22:29 -0400
Received: from thoth.sbs.de ([192.35.17.2]:50789 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753548AbeGENW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 09:22:28 -0400
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w65DLxq8007237
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 15:22:00 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.siemens.de (8.15.2/8.15.2) with ESMTP id w65DLxAs021676;
        Thu, 5 Jul 2018 15:21:59 +0200
Date:   Thu, 5 Jul 2018 15:21:58 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for
 multiple gpg formats
Message-ID: <20180705152158.6f661c85@md1pvb1c.ad001.siemens.net>
In-Reply-To: <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
        <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
        <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Wed, 4 Jul 2018 09:10:17 +0200
schrieb Martin Ågren <martin.agren@gmail.com>:

> Hi Henning,
> 
> On 3 July 2018 at 14:38, Henning Schild <henning.schild@siemens.com>
> wrote:
> > Create a struct that holds the format details for the supported
> > formats. At the moment that is still just "PGP". This commit
> > prepares for the introduction of more formats, that might use other
> > programs and match other signatures.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>  
> 
> Welcome to the mailing list! :-)

Thanks!

> I'll just comment on a few thoughts I had while skimming this.
> 
> >  static char *configured_signing_key;
> > -static const char *gpg_format = "PGP";
> > -static const char *gpg_program = "gpg";
> > +struct gpg_format_data {
> > +       const char *format;
> > +       const char *program;
> > +       const char *extra_args_verify[1];
> > +       const char *sigs[2];
> > +};
> >
> >  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> >  #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
> >
> > +enum gpgformats { PGP_FMT };
> > +struct gpg_format_data gpg_formats[] = {
> > +       { .format = "PGP", .program = "gpg",
> > +         .extra_args_verify = { "--keyid-format=long", },
> > +         .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
> > +       },
> > +};  
> 
> I think those trailing commas are ok now, but I'm not sure...
> 
> I had the same thought about designated initializers. Those should be
> ok now, c.f. cbc0f81d96 (strbuf: use designated initializers in
> STRBUF_INIT, 2017-07-10) and a73b3680c4 (Add and use generic name->id
> mapping code for color slot parsing, 2018-05-26).

Ok, i did not actually check coding style yet. I could run it through a
tool, given there is a suggestion. Or i could address issues someone
points out in the review.
What i get from your comment is that it might be ok to leave the code
as is, others have introduces similar constructs before me.

> > +static const char *gpg_format = "PGP";
> > +
> > +static struct gpg_format_data *get_format_data(void)
> > +{
> > +       int i;
> > +       for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> > +               if (!strcmp(gpg_formats[i].format, gpg_format))
> > +                       return gpg_formats + i;
> > +       assert(0);  
> 
> This might be better written as `BUG("bad gpg_format '%s'",
> gpg_format);` or something like that.
> 
> (It's not supposed to be triggered, not even by invalid data from the
> user, right?)

Yes that is code that can not (should not) be reached. I agree that an
assert(0) is not very expressive and will fix that in v2.

> 
> >         if (!strcmp(var, "gpg.format")) {
> > -               if (!strcmp(value, "PGP"))  
> 
> This line was added in patch 3. It errors out precisely when
> gpg.format is "PGP", no? That this doesn't break the whole series is
> explained by 1) it being removed in this patch 4, and 2) there being
> no tests. It makes me wonder if something like patch 5 (test
> gpg.format) could be part of patch 3, both with negative ("=
> malformed") and positive ("= PGP") tests?

I will pull the tests from patch 5 before touching that code and fix up
issues inbetween. The whole series saw a "make test" inbetween all
commits.

> > +               j = 0;
> > +               for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> > +                       if (!strcmp(value, gpg_formats[i].format)) {
> > +                               j++;
> > +                               break;
> > +                       }
> > +               if (!j)
> >                         return error("malformed value for %s: %s",
> > var, value);  
> 
> `if (i == ARRAY_SIZE(gpg_formats))` and drop `j`?
> 
> Or check whether `get_format_data()` returns NULL? Hmm, well you
> can't, since it takes its "input" from a global variable...
> 
> If you want to keep that global nature, the duplication of
> search-logic could perhaps be avoided by having a helper function for
> returning the index of a gpg_format (or -1).

True, the two are almost the same and should be merged. Will do in v2.

Henning

> >                 return git_config_string(&gpg_format, var, value);
> >         }  
> 
> Martin


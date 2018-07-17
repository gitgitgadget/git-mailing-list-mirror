Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85021F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbeGQNW5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:22:57 -0400
Received: from thoth.sbs.de ([192.35.17.2]:58729 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbeGQNW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:22:57 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCo8fV004338
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:08 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCo7qm004744;
        Tue, 17 Jul 2018 14:50:07 +0200
Date:   Tue, 17 Jul 2018 14:50:06 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/7] gpg-interface: introduce an abstraction for
 multiple gpg formats
Message-ID: <20180717145006.466277fe@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqq4lgyud6n.fsf@gitster-ct.c.googlers.com>
References: <cover.1531470729.git.henning.schild@siemens.com>
 <cover.1531470729.git.henning.schild@siemens.com>
 <38e2eb70233709aa73345d64c94d59d4ccc681ec.1531470729.git.henning.schild@siemens.com>
 <xmqq4lgyud6n.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mon, 16 Jul 2018 13:40:32 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > Create a struct that holds the format details for the supported
> > formats. At the moment that is still just "openpgp". This commit
> > prepares for the introduction of more formats, that might use other
> > programs and match other signatures.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  gpg-interface.c | 84
> > ++++++++++++++++++++++++++++++++++++++++++--------------- 1 file
> > changed, 63 insertions(+), 21 deletions(-)
> >
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 960c40086..699651fd9 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -7,11 +7,46 @@
> >  #include "tempfile.h"
> >  
> >  static char *configured_signing_key;
> > -static const char *gpg_format = "openpgp";
> > -static const char *gpg_program = "gpg";
> > +struct gpg_format {
> > +	const char *name;
> > +	const char *program;
> > +	const char **extra_args_verify;
> > +	const char **sigs;
> > +};
> > +
> > +static const char *openpgp_verify_args[] =
> > { "--keyid-format=long", NULL };  
> 
> Let's write it like this, even if the current line is short enough:
> 
> static const char *openpgp_verify_args[] = {
> 	"--keyid-format=long",
> 	NULL
> };
> 
> Ditto for the next one.  Even if you do not expect these two arrays
> to get longer, people tend to copy & paste to imitate existing code
> when making new things, and we definitely would not want them to be
> doing so on a code like the above (or below).  When they need to add
> new elements to their arrays, having the terminating NULL on its own
> line means they will have to see less patch noise.

Ok, for consistency a later patch will introduce { NULL }; on three
lines.

> > +static const char *openpgp_sigs[] = {
> > +	"-----BEGIN PGP SIGNATURE-----",
> > +	"-----BEGIN PGP MESSAGE-----", NULL };
> > +
> > +static struct gpg_format gpg_formats[] = {
> > +	{ .name = "openpgp", .program = "gpg",
> > +	  .extra_args_verify = openpgp_verify_args,  
> 
> If the underlying aray is "verify_args" (not "extra"), perhaps the
> field name should also be .verify_args to match.

Renamed extra_args_verify to verify_args.

> Giving an array of things a name "things[]" is a disease, unless the
> array is very often passed around as a whole to represent the
> collection of everything.  When the array is mostly accessed one
> element at a time, being able to say thing[3] to mean the third
> thing is much more pleasant.
> 
> So, from that point of view, I pretty much agree with
> openpgp_verify_args[] and openpgp_sigs[], but am against
> gpg_formats[].  The last one should be gpg_format[], for which we
> happen to have only one variant right now.

renamed gpg_formats[] to gpg_format[].

> > +	  .sigs = openpgp_sigs
> > +	},
> > +};
> > +static struct gpg_format *current_format = &gpg_formats[0];  
> 
> Have a blank line before the above one.
> 
> What does "current_format" mean?  Is it different from "format to be
> used"?  As we will overwrite the variable upon reading the config,
> we cannot afford to call it default_format, but somehow "current"
> feels misleading, at least to me.  I expected to find "old format"
> elsewhere and there may be some format conversion or something from
> the variable name.
> 
>     static struct gpg_format *use_format = &gpg_format[0];
> 
> perhaps?

renamed current_format to use_format.

> > +
> > +static struct gpg_format *get_format_by_name(const char *str)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> > +		if (!strcasecmp(gpg_formats[i].name, str))  
> 
> As [1/7], this would become strcmp(), I presume?
> 
> > +			return gpg_formats + i;
> > +	return NULL;
> > +}
> >  
> > -#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> > -#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
> > +static struct gpg_format *get_format_by_sig(const char *sig)
> > +{
> > +	int i, j;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> > +		for (j = 0; gpg_formats[i].sigs[j]; j++)
> > +			if (starts_with(sig,
> > gpg_formats[i].sigs[j]))
> > +				return gpg_formats + i;
> > +	return NULL;
> > +}  
> 
> OK.
> 
> > @@ -140,18 +172,23 @@ int git_gpg_config(const char *var, const
> > char *value, void *cb) }
> >  
> >  	if (!strcmp(var, "gpg.format")) {
> > -		if (value && strcasecmp(value, "openpgp"))
> > -			return error("malformed value for %s: %s",
> > var, value);
> > -		return git_config_string(&gpg_format, var, value);
> > -	}
> > -
> > -	if (!strcmp(var, "gpg.program")) {
> >  		if (!value)
> >  			return config_error_nonbool(var);
> > -		gpg_program = xstrdup(value);
> > +		fmt = get_format_by_name(value);
> > +		if (!fmt)
> > +			return error("malformed value for %s: %s",
> > var, value);  
> 
> If I say "opongpg", that probably is not "malformed" (it is all
> lowercase ascii alphabet that is very plausible-looking string), but
> simply "bad value".

Switched to "unsupported value", as suggested in another reply. 

Henning

> But other than the minor nit, yes, this structure is what I expected
> to see from the very first step 1/7.
> 
> > +		current_format = fmt;
> >  		return 0;
> >  	}  
> 
> >  
> > +	if (!strcmp(var, "gpg.program"))
> > +		fmtname = "openpgp";  
> 
> OK, this is a backward compatibility measure to treat gpg.program as
> if it were gpg.openpgp.program, which makes sense.
> 
> > +	if (fmtname) {
> > +		fmt = get_format_by_name(fmtname);
> > +		return git_config_string(&fmt->program, var,
> > value);
> > +	}
> > +
> >  	return 0;
> >  }  


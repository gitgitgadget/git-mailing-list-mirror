Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C101F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGQNXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:00 -0400
Received: from david.siemens.de ([192.35.17.14]:47224 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbeGQNXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:23:00 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w6HCoBRh027175
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:11 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCoAlS009164;
        Tue, 17 Jul 2018 14:50:10 +0200
Date:   Tue, 17 Jul 2018 14:50:09 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/7] gpg-interface: add new config to select how to
 sign a commit
Message-ID: <20180717145009.6cf163f3@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqh8kzszth.fsf@gitster-ct.c.googlers.com>
References: <cover.1531470729.git.henning.schild@siemens.com>
 <cover.1531470729.git.henning.schild@siemens.com>
 <5e88da5eac1e1aea8a946960d455ba321e3e42b1.1531470729.git.henning.schild@siemens.com>
 <xmqqh8kzszth.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mon, 16 Jul 2018 13:14:34 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > Add "gpg.format" where the user can specify which type of signature
> > to use for commits. At the moment only "openpgp" is supported and
> > the value is not even used. This commit prepares for a new types of
> > signatures.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  Documentation/config.txt | 4 ++++
> >  gpg-interface.c          | 7 +++++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 1cc18a828..ac373e3f4 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1828,6 +1828,10 @@ gpg.program::
> >  	signed, and the program is expected to send the result to
> > its standard output.
> >  
> > +gpg.format::
> > +	Specifies which key format to use when signing with
> > `--gpg-sign`.
> > +	Default is "openpgp", that is also the only supported
> > value. +
> >  gui.commitMsgWidth::
> >  	Defines how wide the commit message window is in the
> >  	linkgit:git-gui[1]. "75" is the default.
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 09ddfbc26..960c40086 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -7,6 +7,7 @@
> >  #include "tempfile.h"
> >  
> >  static char *configured_signing_key;
> > +static const char *gpg_format = "openpgp";
> >  static const char *gpg_program = "gpg";
> >  
> >  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> > @@ -138,6 +139,12 @@ int git_gpg_config(const char *var, const char
> > *value, void *cb) return 0;
> >  	}
> >  
> > +	if (!strcmp(var, "gpg.format")) {
> > +		if (value && strcasecmp(value, "openpgp"))
> > +			return error("malformed value for %s: %s",
> > var, value);
> > +		return git_config_string(&gpg_format, var,
> > value);  
> 
> I may be mistaken (sorry, I read so many topics X-<) but I think the
> consensus was to accept only "openpgp" so that we can ensure that
> 
> 	[gpg "openpgp"] program = foo
> 
> etc. can be parsed more naturally without having to manually special
> case the subsection name to be case insensitive.  In other words,
> strcasecmp() should just be strcmp().  Otherwise, people would get a
> wrong expectation that
> 
> 	[gpg] format = OpenPGP
> 	[gpg "openpgp"] program = foo
> 
> should refer to the same and single OpenPGP, but that would violate
> the usual configuration syntax rules.

Ok, also having read the other mails i think we are still at
gpg.format and gpg.<format>.program, so i switched the two patches from
strcasecmp back to strcmp.

> The structure of checking the error looks quite suboptimal even when
> we initially support the single "openpgp" at this step.  I would
> have expected you to be writing the above like so:
> 
> 	if (!value)
> 		return config_error_nonbool(var);
> 	if (strcmp(value, "openpgp"))
> 		return error("unsupported value for %s: %s", var,
> value); return git_config_string(...);
> 
> That would make it more clear that the variable is "nonbool", which
> does not change across additional support for new formats in later
> steps.

Right, at one point (not mailed) i had that but expected it would not
pass the review, since git_config_string contains that check as well.
Changed.

Henning
 
> > +	}
> > +
> >  	if (!strcmp(var, "gpg.program")) {
> >  		if (!value)
> >  			return config_error_nonbool(var);  


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB361F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeGPWID (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:08:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:48628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728290AbeGPWIC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:08:02 -0400
Received: (qmail 17339 invoked by uid 109); 16 Jul 2018 21:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 21:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16086 invoked by uid 111); 16 Jul 2018 21:38:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 17:38:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 17:38:43 -0400
Date:   Mon, 16 Jul 2018 17:38:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/7] gpg-interface: add new config to select how to
 sign a commit
Message-ID: <20180716213843.GK25189@sigill.intra.peff.net>
References: <cover.1531470729.git.henning.schild@siemens.com>
 <cover.1531470729.git.henning.schild@siemens.com>
 <5e88da5eac1e1aea8a946960d455ba321e3e42b1.1531470729.git.henning.schild@siemens.com>
 <xmqqh8kzszth.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8kzszth.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 01:14:34PM -0700, Junio C Hamano wrote:

> >  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> > @@ -138,6 +139,12 @@ int git_gpg_config(const char *var, const char *value, void *cb)
> >  		return 0;
> >  	}
> >  
> > +	if (!strcmp(var, "gpg.format")) {
> > +		if (value && strcasecmp(value, "openpgp"))
> > +			return error("malformed value for %s: %s", var, value);
> > +		return git_config_string(&gpg_format, var, value);
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

I was the one who argued the other way. But unless we are going to move
to a two-level config for all of it (i.e., gpg.openPGPProgram), I think
what you suggest here is the sanest way forward.

> The structure of checking the error looks quite suboptimal even when
> we initially support the single "openpgp" at this step.  I would
> have expected you to be writing the above like so:
> 
> 	if (!value)
> 		return config_error_nonbool(var);
> 	if (strcmp(value, "openpgp"))
> 		return error("unsupported value for %s: %s", var, value);
> 	return git_config_string(...);
> 
> That would make it more clear that the variable is "nonbool", which
> does not change across additional support for new formats in later
> steps.

Agreed.

-Peff

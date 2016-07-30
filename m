Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0508B1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 18:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbcG3SM4 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 14:12:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47905 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcG3SMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 14:12:55 -0400
Received: from mfilter47-d.gandi.net (mfilter47-d.gandi.net [217.70.178.178])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id BBF9717209A;
	Sat, 30 Jul 2016 20:12:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter47-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter47-d.gandi.net (mfilter47-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id l-Rm7t2hc4Zt; Sat, 30 Jul 2016 20:12:50 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CA78717209F;
	Sat, 30 Jul 2016 20:12:48 +0200 (CEST)
Date:	Sat, 30 Jul 2016 11:12:46 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] format-patch: Add a config option format.from to set
 the default for --from
Message-ID: <20160730181246.4aifnvqfeenddzdl@x>
References: <cover.8678faa71de50c8e78760b0bcb3d15ebeda207d5.1469871675.git-series.josh@joshtriplett.org>
 <20160730094156.etvrzqbhcpg3is2z@x>
 <20160730154034.thjrfu6zeprzwvxb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160730154034.thjrfu6zeprzwvxb@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 11:40:34AM -0400, Jeff King wrote:
> On Sat, Jul 30, 2016 at 02:41:56AM -0700, Josh Triplett wrote:
> 
> > @@ -807,6 +808,17 @@ static int git_format_config(const char *var, const char *value, void *cb)
> >  		base_auto = git_config_bool(var, value);
> >  		return 0;
> >  	}
> > +	if (!strcmp(var, "format.from")) {
> > +		int b = git_config_maybe_bool(var, value);
> > +		free(from);
> > +		if (b < 0)
> > +			from = xstrdup(value);
> > +		else if (b)
> > +			from = xstrdup(git_committer_info(IDENT_NO_DATE));
> > +		else
> > +			from = NULL;
> > +		return 0;
> > +	}
> 
> This "free old, then handle tri-state" mirrors the code in the parseopt
> callback pretty closely. I wonder if they could share the logic (it is
> not many lines, but we would want the logic to stay identical). I
> suspect the helper function would end up with more boilerplate than it's
> worth, though, trying to handle the unset and default cases.

I looked at trying to share that code for exactly that reason, but
didn't find a convenient way to share the two, because from_callback
checked two separate variables (unset and arg), while the logic above
checks one.  So, while the *bodies* of the three-way if are duplicated,
the *conditions* aren't.

However, if you'd like to avoid the duplication between the three
values, I can do that with a set_from function that takes an enum and a
new value; it'll actually increase lines of code, but remove the
duplication (as well as the second patch's third copy of setting from to
the committer info).

> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index 1206c48..b0579dd 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -229,6 +229,46 @@ check_patch () {
> >  	grep -e "^Subject:" "$1"
> >  }
> >  
> > +test_expect_success 'format.from=false' '
> > +
> > +	git -c format.from=false format-patch --stdout master..side |
> > +	sed -e "/^\$/q" >patch &&
> > +	check_patch patch &&
> > +	! grep "^From: C O Mitter <committer@example.com>\$" patch
> > +'
> 
> These tests follow a different style from the "--from" tests later in
> the script (and your second patch does follow it, and puts its test
> close there). Any reason not to have all of the "from" tests together,
> and using the same style?

The tests covered different things.  The later --from tests made sure
that --from behaved as expected.  These tests made sure that format.from
and --from/--no-from interacted in the expected way, with the
command-line options overriding the configuration.  So, I put them next
to the tests for other options like format.to and format.cc, which
tested the same thing (overriding those with --no-to, --no-cc, etc).

> Overall, the whole thing looks cleanly done, and I don't mind it going
> in as-is. These are just two things I noticed while reading it over.

I'll send a v2 with the code duplication fixed.

- Josh Triplett

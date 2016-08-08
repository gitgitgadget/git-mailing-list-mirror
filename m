Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1D81FD99
	for <e@80x24.org>; Mon,  8 Aug 2016 04:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbcHHEwl (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 00:52:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33081 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcHHEwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 00:52:40 -0400
Received: from mfilter15-d.gandi.net (mfilter15-d.gandi.net [217.70.178.143])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 446B0A80C7;
	Mon,  8 Aug 2016 06:52:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter15-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter15-d.gandi.net (mfilter15-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id GHj0bhL_WwN7; Mon,  8 Aug 2016 06:52:35 +0200 (CEST)
X-Originating-IP: 98.150.198.107
Received: from x (cpe-98-150-198-107.hawaii.res.rr.com [98.150.198.107])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 308C4A80C6;
	Mon,  8 Aug 2016 06:52:33 +0200 (CEST)
Date:	Sun, 7 Aug 2016 18:52:28 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] format-patch: Add a config option format.from to set
 the default for --from
Message-ID: <20160808045228.ag4mb55dwcsrro6y@x>
References: <cover.8678faa71de50c8e78760b0bcb3d15ebeda207d5.1469871675.git-series.josh@joshtriplett.org>
 <20160730094156.etvrzqbhcpg3is2z@x>
 <xmqqpopsi61a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpopsi61a.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 01:32:49PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > +static char *from;
> >  static const char *signature = git_version_string;
> >  static const char *signature_file;
> >  static int config_cover_letter;
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
> One potential issue I see here is that if we ever plan to switch the
> default, we may want to issue a warning message to users who do not
> have any format.from configured when they do run the program on a
> commit that will get a different result before and after the switch
> in a release of Git before that default switch happens.  The message
> would say something like "you are formatting somebody else's commit.
> the output will change in future versions of Git and show an explicit
> in-body From: header; if you want to keep the current behaviour, set
> format.from configuration variable to false".

The previous discussion between you and Jeff King seemed to suggest that
a mention in the release notes might suffice, rather than a "noisy
deprecation" warning.

> But you cannot tell by looking at from that is NULL between two
> cases, it is NULL because we defaulted to it (in which case we do
> want to warn), or the user set it explicitly to false (we do not
> want to give the warning).

If we wanted to issue such a warning, I'd suggest a separate boolean
"from_set", set when either the configuration or command line sets
"from", and then the code that handles "from" could emit a warning to
stderr if it would produce different results and !from_set.

- Josh Triplett

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B252021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759428AbcKCS0A (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:26:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:38220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbcKCS0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:26:00 -0400
Received: (qmail 6131 invoked by uid 109); 3 Nov 2016 18:26:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 18:26:00 +0000
Received: (qmail 15395 invoked by uid 111); 3 Nov 2016 18:26:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 14:26:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 14:25:57 -0400
Date:   Thu, 3 Nov 2016 14:25:57 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103182557.jov2sab7jtozqw7t@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
 <20161103181954.GD182568@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161103181954.GD182568@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 11:19:54AM -0700, Brandon Williams wrote:

> On 11/03, Jeff King wrote:
> > +
> > +	/* unknown; let them be used only directly by the user */
> > +	return PROTOCOL_ALLOW_USER_ONLY;
> > +}
> > +
> >  int is_transport_allowed(const char *type)
> >  {
> > -	const struct string_list *allowed = protocol_whitelist();
> > -	return !allowed || string_list_has_string(allowed, type);
> > +	const struct string_list *whitelist = protocol_whitelist();
> > +	if (whitelist)
> > +		return string_list_has_string(whitelist, type);
> > +
> > +	switch (get_protocol_config(type)) {
> > +	case PROTOCOL_ALLOW_ALWAYS:
> > +		return 1;
> > +	case PROTOCOL_ALLOW_NEVER:
> > +		return 0;
> > +	case PROTOCOL_ALLOW_USER_ONLY:
> > +		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> > +	}
> 
> I know this is just a rough patch you wiped up but one question:
> With the 'user' state, how exactly do you envision this env variable
> working?  Do we want the user to have to explicitly set
> GIT_PROTOCOL_FROM_USER in their environment and then have these other
> commands (like git-submodule) explicitly clear the env var or would we
> rather these subcommands set a variable indicating they aren't coming
> from the user and the deafult state (no var set) is a user run command?

See the follow-up I just posted, but basically, the rules are:

  - if you don't say anything, then the URL is from the user

  - git-submodule would set it to "0" (i.e., tell us to be more careful)

  - tools like "go get" would similarly set it to "0" if they are
    passing untrusted URLs

-Peff

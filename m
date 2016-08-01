Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413481F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbcHARZS (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:25:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:52576 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754227AbcHARZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:25:13 -0400
Received: (qmail 7466 invoked by uid 102); 1 Aug 2016 17:25:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:25:02 -0400
Received: (qmail 14970 invoked by uid 107); 1 Aug 2016 17:25:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:25:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 13:24:59 -0400
Date:	Mon, 1 Aug 2016 13:24:59 -0400
From:	Jeff King <peff@peff.net>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
Message-ID: <20160801172459.wz7wigmytxpfvs22@sigill.intra.peff.net>
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-2-e@80x24.org>
 <20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 01:43:03AM +0000, brian m. carlson wrote:

> On Mon, Aug 01, 2016 at 01:05:56AM +0000, Eric Wong wrote:
> > +static void setup_pager_env(struct argv_array *env)
> > +{
> > +	const char *pager_env = stringify(PAGER_ENV);
> > +
> > +	while (*pager_env) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +		const char *cp = strchrnul(pager_env, '=');
> > +
> > +		if (!*cp)
> > +			die("malformed build-time PAGER_ENV");
> > +		strbuf_add(&buf, pager_env, cp - pager_env);
> > +		cp = strchrnul(pager_env, ' ');
> > +		if (!getenv(buf.buf)) {
> > +			strbuf_reset(&buf);
> > +			strbuf_add(&buf, pager_env, cp - pager_env);
> > +			argv_array_push(env, strbuf_detach(&buf, NULL));
> > +		}
> > +		strbuf_reset(&buf);
> > +		while (*cp && *cp == ' ')
> > +			cp++;
> > +		pager_env = cp;
> > +	}
> 
> So it looks like this function splits on spaces but doesn't provide any
> escaping mechanism.  Is there any case in which we want to accept
> environment variables containing whitespace?  I ask this as someone that
> has EDITOR set to "gvim -f" on occasion and seeing how tools sometimes
> handle that poorly.
> 
> Even without that, I think this series is probably an improvement over
> the status quo.

I'm not too worried about spaces here. This is a resurrection of an old
discussion, and in all that time, I think the only realistic suggestions
for built-in values have been pretty tame.

If this were used to parse arbitrary user-provided runtime values, I'd
be more concerned. But I'm not sure why we would need that. Your $EDITOR
example is arbitrary shell code, and we let the shell handle it (modulo
some efficiency shortcuts). Likewise, fancy runtime things should go in
GIT_PAGER, where you can not only set options with spaces, but do fancy
things like pipes, shell functions, etc.

The use of stringify() here is funny to me; I think there is a cpp
tokenizing step in the middle that will do things like gobble up
whitespace (but I'm not sure if it has other possible effects). I think
our more usual method here would be to C-quote in the Makefile (with the
equivalent of 's/\\/\\\\/g; s/"/\\"/g'), and then pass it to the
compiler as a string literal, like -DPAGER_ENV=\"$(PAGER_ENV_CQ_SQ\".

-Peff

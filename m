Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9988F1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 18:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826AbcHCSrR (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:47:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:54030 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753699AbcHCSrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:47:14 -0400
Received: (qmail 11427 invoked by uid 102); 3 Aug 2016 18:40:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 14:40:32 -0400
Received: (qmail 4140 invoked by uid 107); 3 Aug 2016 18:41:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 14:41:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 14:40:29 -0400
Date:	Wed, 3 Aug 2016 14:40:29 -0400
From:	Jeff King <peff@peff.net>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	Laszlo Ersek <lersek@redhat.com>,
	public git mailing list <git@vger.kernel.org>
Subject: Re: appending a pattern to the default "diff.cpp.xfuncname"
Message-ID: <20160803184029.kg7xdcb5s7znxyjq@sigill.intra.peff.net>
References: <40ceebb8-b343-a5ca-e7ff-23cccc181528@redhat.com>
 <20160803180213.o7xpm4c4tw5rixmy@sigill.intra.peff.net>
 <8c4e96b9-165f-5168-d220-6a1548ff83c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c4e96b9-165f-5168-d220-6a1548ff83c7@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 08:34:28PM +0200, Jakub Narębski wrote:

> > Unfortunately, no, the config system has no notion of "append to this
> > value". 
> 
> And I think adding such capability would not be easy.  Well, perhaps
> we could support '+=' in addition to '='?

We could, but it would be an incompatible syntactic change, which we've
so far managed to avoid.

> >         So you are stuck with extracting the builtin value (which
> > annoyingly, you cannot even get without looking at the source code!),
> > and repeating it in your config file.
> 
> I wonder if `git var -l` could provide all default values :-P

I had a similar thought, but it's quite difficult because of the way
that default values are structured in git. Most code uses initialization
of C variables (including structs) to set up default values, and then
overrides them if it sees relevant config.

So there is no central code to ask "what is the value of X if I don't
provide any config"? It literally requires dumping a bunch of variables.

One thing we could do is move all of those defaults into an "internal"
config that is baked into the executable, and then parse that at the
lowest-priority level of config. And then "git config --list
--show-origin" could presumably just dump it.

But that would mean parsing it at run-time in every program (which is
probably not _that_ much overhead, but does feel wrong). I'd also
suspect there are a few cases whose defaults are expressed in code,
rather than as single variable assignments, and couldn't be represented
as config at all.

-Peff

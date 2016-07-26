Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA60203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbcGZULK (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:11:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:49457 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756791AbcGZULJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:11:09 -0400
Received: (qmail 9700 invoked by uid 102); 26 Jul 2016 20:11:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:11:08 -0400
Received: (qmail 10417 invoked by uid 107); 26 Jul 2016 20:11:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:11:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2016 16:11:05 -0400
Date:	Tue, 26 Jul 2016 16:11:05 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, jnareb@gmail.com,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	peartben@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v1 0/3] Git filter protocol
Message-ID: <20160726201105.GB21194@sigill.intra.peff.net>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <xmqqshv18i8i.fsf@gitster.mtv.corp.google.com>
 <7DABD0C7-8838-4FEC-B6E5-36F82E521312@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7DABD0C7-8838-4FEC-B6E5-36F82E521312@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 24, 2016 at 01:24:29PM +0200, Lars Schneider wrote:

> What if we would keep the config option "protocol" and make it an "int"? 
> Undefined or version "1" would describe the existing clean/smudge 
> protocol via command line and pipe. Version "2" would be the new protocol?

FWIW, that is what I expected when I saw the word "protocol".

It's possible that we might never need a "v3" protocol specified here,
because your v2 protocol should be able to auto-upgrade. That is, if we
start a filter and it says "hi, I am speaking protocol 3", then Git
knows to speak the requested version from there on (or will barf if it
doesn't understand the version).

So you'd only need to say "filter.foo.protocol=v3" if there was some
protocol change that broke the initial conversation.

That does mean it is the filter which sets the maximum protocol level,
not git. So a filter which can speak v3 or v2 (to work with older
versions of git) does not know which to use. That could be solved by
specifying

  [filter "foo"]
  smudge = my-filter --version=3

or something.

I'm not sure it's worth thinking too hard about what-ifs here. We should
do the simplest thing that will work and avoid painting ourselves into a
corner for future upgrades.

> > * The way the serialized access to these long-running processes
> >   work in 3/3 would make it harder or impossible to later
> >   parallelize conversion?  I am imagining a far future where we
> >   would run "git checkout ." using (say) two threads, one
> >   responsible for active_cache[0..active_nr/2] and the other
> >   responsible for the remainder.
> I hope this future is not too far away :-) 
> However, I don't think that would be a problem as we could start the
> long-running process once for each checkout thread, no?

That's reasonable if we have a worker-thread model (which seems likely,
as that's what we use elsewhere in git), and if the main cost you want
to amortize is just process startup (so you pay the cost once per
worker, which is a constant factor and not too bad).

It's not a good model if the long-running process wants to amortize
other shared costs. For example, persistent https connections. Or even
user-interactive authentication steps, where you really would prefer to
do them once. The filter can implement its own ad-hoc sharing of
resources, but doing that portably is complicated.

Of course having an async protocol between git and the filter is also
complicated. Perhaps that's something that could wait for a v3 if
somebody really wants it.

-Peff

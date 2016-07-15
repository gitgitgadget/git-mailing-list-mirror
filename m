Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1B520195
	for <e@80x24.org>; Fri, 15 Jul 2016 12:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbcGOMSo (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 08:18:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:45382 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932785AbcGOMSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 08:18:42 -0400
Received: (qmail 22709 invoked by uid 102); 15 Jul 2016 12:18:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 08:18:41 -0400
Received: (qmail 15199 invoked by uid 107); 15 Jul 2016 12:19:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 08:19:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 08:18:39 -0400
Date:	Fri, 15 Jul 2016 08:18:39 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Ben Peart <peartben@gmail.com>, Joey Hess <joey@kitenet.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
Message-ID: <20160715121838.GA21968@sigill.intra.peff.net>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 08:46:03AM +0200, Christian Couder wrote:

> One way to extend it for better performance is to require that the
> configured command should be able to deal with a number or a stream of
> files or objects (instead of just one objec/file) that are passed to
> it. It looks like that is what Lars wants for smudge/clean filters.
> 
> Another way is to have the external command run as a daemon, like what
> Duy and David implemented for the index-helper.

Where possible, I think we should avoid daemons. They introduce all
sorts of timings complexities and robustness issues (what happens when
the daemon isn't up? What happens when it hangs? Etc).

Junio mentioned elsewhere the way remote-helpers work, which is to have
a single program that is run once per git invocation, and that can serve
multiple requests interactively by speaking a specific protocol. I think
that's what you're getting at in the first paragraph I've quoted here,
and it's something that has worked reasonably well for us. I _do_ think
we've often not paid close attention to the protocol design, and it has
ended up biting us (there are some serious warts in the remote-helper
protocol, for instance).

I don't know if we would want to go so far as standardizing on something
like JSON for making RPC requests to any helpers. Probably the more
"git" thing would be to use something based around pkt-lines, but it's
a lot easier to find a JSON library for your helper program. :-/

For clean/smudge filters, that kind of model seems like it would work
well. Better still if it can actually accept requests asynchronously and
return them possibly out of order (so it can parallelize as it likes
under the hood).  I think that the external-odb stuff could run this way
pretty easily, too.

Though I'm not yet convinced that it wouldn't be sufficient to run each
request in its own program, but teach git to parallelize the invocations
and let multiple run at once. The problem often times is one of latency
in hitting the helper serially, not overall CPU time (and you'd need to
do this parallelizing anyway to make out-of-order requests of a single
program, so it seems like a useful first step anyway).


Some features, like the index-helper, aren't quite so easy. One reason
is that its data needs to persist as a cache between multiple git
invocations. In general, I think it would be nice to solve that by
communicating via on-disk files, rather than a running daemon (just
because it has fewer moving parts). But that's only half of it for
index-helper. It needs to monitor inotify while git isn't running at
all; so it really _does_ need some kind of long-running daemon.

> And a more integrated way is to require the external code to implement
> an API and to be compiled along with Git which looks like the approach
> taken by the ref backend work.

The nice thing about an API like this is that it can be very high
performance, and it's relatively easy to move data between the API and
the rest of Git. But I still don't think we've quite figured out how
backends are going to be compiled and linked into git. I'm not sure
anybody is really shooting for something like run-time loading of
modules. I think at this stage we're more likely to have a handful of
modules that are baked in at compile time.

That works OK for the refs code, which is mostly Git-related, and mostly
works synchronously; you ask it for a ref, it looks it up and returns
it. Something like Git-LFS seems much more complicated. Besides being
written in Go and having a bunch of extra library dependencies, it's
inherently network-oriented, and needs to handle being responsive on
multiple descriptors (especially if we try to do things in parallel).
That's a lot of complication to stuff into an API. It also has to make
policy decisions that shouldn't necessarily be part of git (like
managing the cache of objects).

> If people think that evolution is better than intelligent design, and
> want each current topic/work to just implement what is best for it,
> then that's ok for me. If on the other hand standardizing on some ways
> to interact with external processes could be helpful to avoid
> duplicating mechanisms/code in slightly different and incompatible
> ways, then I would be happy to discuss it in a thread that is not
> specific to one of the current work.

Those are all just my off-the-cuff thoughts. I reserve the right to
change my opinions above at any time. :)

I _do_ think each of the projects you've mentioned has their own needs,
so I don't think we'll find a one-size-fits-all solution.

-Peff

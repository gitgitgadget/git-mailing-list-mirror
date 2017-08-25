Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB05208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757257AbdHYR3G (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:29:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:49296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754737AbdHYR3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:29:05 -0400
Received: (qmail 846 invoked by uid 109); 25 Aug 2017 17:29:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 17:29:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20038 invoked by uid 111); 25 Aug 2017 17:29:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 13:29:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Aug 2017 10:29:02 -0700
Date:   Fri, 25 Aug 2017 10:29:02 -0700
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
References: <20170824225328.8174-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 03:53:21PM -0700, Brandon Williams wrote:

> Another version of Git's wire protocol is a topic that has been discussed and
> attempted by many in the community over the years.  The biggest challenge, as
> far as I understand, has been coming up with a transition plan to using the new
> server without breaking existing clients and servers.  As such this RFC is
> really only concerned with solidifying a transition plan.  Once it has been
> decided how we can transition to a new protocol we can get into decided what
> this new protocol would look like (though it would obviously eliminate the ref
> advertisement ;).

Sadly, while splitting these things apart makes the protocol
conceptually cleaner, I'm not sure if we can consider them separately
and avoid adding an extra round-trip to the protocol.

For instance, let's say as a client that I've communicated "I would like
to speak v2" to the server. I don't immediately know if it was received
and respected, so I have to wait for the server to say "OK, I know v2"
before sending any more data (like my list of capabilities that I'd like
the server to know before doing the ref advertisement).

So what was perhaps:

  C: please run upload-pack
  S: advertisement + caps
  C: caps + wants
  C+S: async have negotiation
  S: packfile

becomes:

  C: please run upload-pack (v2 if you support it)
  S: yes, I speak v2
  C: caps (including that I'm interested only in refs/heads/foo)
  S: advertise refs/heads/foo + caps
  C+S async have negotiation
  S: packfile

That extra round-trip is probably tolerable for stateful connections
like git:// or ssh. But what about http? We have to add a whole
request/response pair just to find out if v2 is supported.

But what if we instead think of it not as "protocol v2" but as "can I
give the server some hints that it may end up ignoring", then we end up
with something more like:

  C: please run upload-pack (btw, I'm only interested in refs/heads/foo)
  S: advertisement + caps (hopefully limited to foo, but client is prepared to receive all)
  ... etc, as before ...

It's a subtle distinction, but the question becomes not "can we sneak in
an extra bit of information" but "can we sneak in a reasonable number of
arbitrary key/value pairs".

Given the techniques you've used here, I suspect the answer may be
"yes". We could stick arbitrary data in each of those methods (though I
suspect our length may be limited to about 1024 bytes if we want
compatibility with very old git servers).

> The biggest question I'm trying to answer is if these are reasonable ways with
> which to communicate a request to a server to use a newer protocol, without
> breaking current servers/clients.  As far as I've tested, with patches 1-5
> applied I can still communicate with current servers without causing any
> problems.

Current git.git servers, I assume?. How much do we want to care about
alternate implementations? I would not be surprised if other git://
implementations are more picky about cruft after the virtual-host field
(though I double-checked GitHub's implementation at least, and it is
fine).

I don't think libgit2 implements the server side. That leaves probably
JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
and GitLab use.

There's not really a spec here.  I'm not entirely opposed to saying "if
your server does not behave like the git.git one it is wrong". But this
is awfully quirky behavior to be relying on, and if it behaves badly
with those implementations it will create headaches for users. The
centralized services I'm not too worried about; they'll upgrade
promptly. But any deployments of those systems may hang around for
years.

I dunno. Maybe it would be enough to have a config to switch off this
feature, which would give people using those systems an escape hatch
(until they upgrade). Or alternatively, I guess make this optional to
start with, and let early adopters turn it on and complain to their server
vendors for a while before flipping the default to on.

-Peff

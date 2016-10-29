Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFD02022A
	for <e@80x24.org>; Sat, 29 Oct 2016 13:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbcJ2NkD (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 09:40:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:35995 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbcJ2NkC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 09:40:02 -0400
Received: (qmail 24356 invoked by uid 109); 29 Oct 2016 13:40:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Oct 2016 13:40:01 +0000
Received: (qmail 5900 invoked by uid 111); 29 Oct 2016 13:40:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Oct 2016 09:40:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Oct 2016 09:39:59 -0400
Date:   Sat, 29 Oct 2016 09:39:59 -0400
From:   Jeff King <peff@peff.net>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
Message-ID: <20161029133959.kpkohjkku3jgwjql@sigill.intra.peff.net>
References: <1477690790.2904.22.camel@mattmccutchen.net>
 <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
 <1477692961.2904.36.camel@mattmccutchen.net>
 <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
 <1477712029.2904.64.camel@mattmccutchen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1477712029.2904.64.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 11:33:49PM -0400, Matt McCutchen wrote:

> On Fri, 2016-10-28 at 18:11 -0700, Junio C Hamano wrote:
> > Ah, I see.  My immediate reaction is that you can do worse things in
> > the reverse direction compared to this, but your scenario does sound
> > bad already.
> 
> Are you saying that clients connecting to untrusted servers already
> face worse risks that people should know about, so there is no point in
> documenting this one?  I guess I don't know about the other risks aside
> from accepting a corrupt object, which should be preventable by
> enabling fetch.fsckObjects.  It seems we need either a statement that
> connecting to untrusted servers is officially unsupported or a
> description of the specific risks.

I'm not sure I understand how connecting to a remote server to fetch is
a big problem. The server may learn about the existence of particular
sha1s in your repository, but cannot get their content.

It's the subsequent push that is a problem.

In the scenarios you've described, I'm mostly inclined to say that the
problem is not git or the protocol itself, but rather lax refspecs.
You mentioned earlier:

  the server can just generate another ref 'xx' pointing to Y2, assuming
  it can entice the victim to set up a corresponding local branch
  refs/heads/for-server1/xx and push it back.  Or if the victim is for
  some reason just mirroring back and forth:

This sounds a lot like "I told git to push a bunch of things without
checking if they were really secret, and it turned out to push some
secret things". IOW I think the problem is not that the server may lie
about what it has, but that the user was not careful about what they
pushed. I dunno. I do not mind making a note in the documentation
explaining the implications of a server lying, but the scenarios seem
pretty contrived to me.

A much more interesting one, IMHO, is a server whose receive-pack lies
about which objects it has (possibly ones it found out about earlier via
fetch), which provokes the client to generate deltas against objects the
server doesn't have (and thereby leaking information about the base
objects).

That is a problem no matter how careful your refspecs are. I suspect it
would be a hard attack to pull off in practice, just because it's going
to depend heavily on the content of the specific objects, what kinds of
deltas you can convince the other side to generate, etc. That might
merit a mention in the git-push documentation.

-Peff

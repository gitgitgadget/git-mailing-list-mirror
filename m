From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 00/11] Protocol version 2, again!
Date: Wed, 27 May 2015 02:18:19 -0400
Message-ID: <20150527061818.GA885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:18:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxUfb-00047D-6p
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbbE0GSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:18:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:36448 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751129AbbE0GSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:18:22 -0400
Received: (qmail 30090 invoked by uid 102); 27 May 2015 06:18:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 01:18:22 -0500
Received: (qmail 4694 invoked by uid 107); 27 May 2015 06:18:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:18:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 02:18:19 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270016>

On Tue, May 26, 2015 at 03:01:04PM -0700, Stefan Beller wrote:

>     "Just give us something to play around with" - Peff at GitMerge 2015

Sounds like something I would say.

> The new protocol works just like the old protocol, except for
> the capabilities negotiation being before any exchange of real data.

I like this approach. We all know that one next step is going to be a
"show me only these refs" capability negotiation of some kind. But it's
good to keep the version-breaking changes separated from that, and this
should be enough to bootstrap that conversation later.

If I understand correctly, your proposed protocol allows for a single
back-and-forth of capabilities followed by the server speaking the ref
advertisement. So it is worth thinking a moment how we might have a more
involved conversation before the advertisement if we want to do so in
the future.

I think in the simplest case, the server claims to understand the "foo"
extension, and then the client says "I wish to use foo". And then a rule
of "foo" might be that the conversation continues in some way before
sending the advertisement. Like (each line is a pkt-line):

  ...
  S: foo
  S: flush
  ...
  C: foo
  S: Here's some extra foo data.
  C: Now I respond to that foo data.
  S: Now the foo conversation is done. Here's the ref advertisement.

What if there are multiple such extensions? E.g., if the client asks for
both "foo" and "bar", and both require extra back-and-forth messages?
Which conversation happens first?

Maybe the rule is just "whichever one the client asked for first in the
capabilities list". And I think in general we want to avoid protocol
round-trips if we can (so we'd prefer the client say
"refspec=refs/heads/*", and not "I understand refspecs, too! Let's have
a conversation about which ones I'm interested in."). But I think it's
worth giving it a little thought to make sure we don't paint ourselves
in a corner.

> My preference for a string suffix instead of a sequential number is
> motiviated by the discussion of sha1 vs sequential numbers to describe
> a state of a repository. The main difference here is however how often
> we expect changes. Version 1 of the protocol is current for 10 years by
> now, so I do not changes to the protocol number often, which makes it
> suitable for just having a counter appended to the binary.

I think I prefer a number. I'm really hoping that v2 lasts even longer
than v1 has, because the capability negotiation should allow us to
extend it from within rather than breaking compatibility.

As a minor nit, I think I like "upload-pack-v2" better than
"upload-pack-2". But I can live with it either way. :)

> This series doesn't include an automatic upgrade of the protocol version
> for later changes if the server supports it, so for now the use of the new
> protocol needs to be activated manually via setting remote.origin.transportversion.

I think that's a good start. Last time we discussed it, I think
everybody was more or less on board with client probing (so v1 would
start to say "btw, I speak v2", and then client would set its
remote.origin.transportversion flag). That can come later, and we are
not painting ourselves into a corner.

I think we also discussed passing the version information out-of-band.
So over git-daemon, as "git-upload-pack repo\0host=...\0\0version=2",
for example. I _think_ we are also fine to build that on top of what you
have here. If the version information makes it through to upload-pack,
then we can do v2, and if not, we are no worse off than we were. HTTP
can do a similar out-of-band thing, but I think ssh is mostly out of
luck. The best I could think of was passing an environment variable, but
ssh typically only lets through a few variables. We could abuse PATH or
something, but that's getting pretty nasty.

Anyway, that is all for the future. The only reason I mention it is to
make sure that we are not closing any future doors, and I don't think we
are.

-Peff

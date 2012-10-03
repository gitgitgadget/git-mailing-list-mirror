From: Jeff King <peff@peff.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 16:13:16 -0400
Message-ID: <20121003201316.GA4484@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
 <7vobkj4cb4.fsf@alter.siamese.dyndns.org>
 <20121003185542.GA3635@sigill.intra.peff.net>
 <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:51:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtJ4-0001DP-SU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab2JCUNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 16:13:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39414 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025Ab2JCUNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 16:13:19 -0400
Received: (qmail 12278 invoked by uid 107); 3 Oct 2012 20:13:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 16:13:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 16:13:16 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206928>

On Wed, Oct 03, 2012 at 12:41:38PM -0700, Shawn O. Pearce wrote:

> > Out of curiosity, how are you thinking about triggering such a new
> > behavior in a backwards-compatible way? Invoke git-upload-pack2, and
> > fall back to reconnecting to start git-upload-pack if it fails?
> 
> Basically, yes. New clients connect for git-upload-pack2. Over git://
> the remote peer will just close the TCP socket with no messages. The
> client can fallback to git-upload-pack and try again. Over SSH a
> similar thing will happen in the sense there is no data output from
> the remote side, so the client can try again. This has the downside of
> authentication twice over SSH, which may prompt for a password twice.
> But the user can get out of this by setting remote.NAME.uploadpack =
> git-upload-pack and thus force the Git client to use the current
> protocol if they have a new client and must continue to work over SSH
> with an old server, and don't use an ssh-agent.

It's a shame that we have to reestablish the TCP or ssh connection to do
the retry. The password thing is annoying, but also it just wastes a
round-trip. It means we'd probably want to default the v2 probe to off
(and let the user turn it on for a specific remote) until v2 is much
more common than v1. Otherwise everyone pays the price.

It may also be worth designing v2 to handle more graceful capability
negotiation so this doesn't come up again.

Another alternative would be to tweak git-daemon to allow more graceful
fallback. That wouldn't help us now, but it would if we ever wanted a
v3. For stock ssh, you could send:

  sh -c 'git upload-pack2; test $? = 127 && git-upload-pack'

which would work if you have an unrestricted shell on the other side.
But it would break for a restricted shell or other "fake" ssh
environment. It's probably too ugly to have restricted shells recognize
that as a magic token (well, I could maybe even live with the ugliness,
but it is not strictly backwards compatible).

I was hoping we could do something like "git upload-pack --v2", but I'm
pretty sure current git-daemon would reject that.

> Over HTTP we can request ?service=git-upload-pack2 and retry just like
> git:// would, or be a bit smarter and say
> ?service=git-upload-pack&v=2, and determine the protocol support of
> the remote peer based on the response we get. If we see an immediate
> advertisement its still the "v1" protocol, if we get back the "yes I
> speak v2" response like git:// would see, we can continue the
> conversation from there.

Yeah, I would think "&v=2" would be better simply to avoid the
round-trip if we fail. It should be safe to turn the new protocol on by
default for http, then.

-Peff

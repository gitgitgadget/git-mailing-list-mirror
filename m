From: Jeff King <peff@peff.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Thu, 4 Oct 2012 20:20:48 -0400
Message-ID: <20121005002048.GA17586@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
 <20121003201316.GA4484@sigill.intra.peff.net>
 <7939878.c2fCDAx1ds@blacky>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sascha Cunz <sascha-ml@babbelbox.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 02:21:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJvf6-0008G8-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 02:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab2JEAUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 20:20:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41096 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576Ab2JEAUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 20:20:50 -0400
Received: (qmail 26353 invoked by uid 107); 5 Oct 2012 00:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 20:21:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 20:20:48 -0400
Content-Disposition: inline
In-Reply-To: <7939878.c2fCDAx1ds@blacky>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207057>

On Thu, Oct 04, 2012 at 11:52:13PM +0200, Sascha Cunz wrote:

> Would it be possible to use this workflow:
> 
> - Every client connects per default to v1
> 
> - If server is capable of v2, it sends a flag along with the usual response
>   (A v1 server will obviously not send that flag)

That is more or less the strategy we use for existing extensions (your
"flag" is a space-separated list of capability strings). But in this
case, the idea would be to change what the "usual response" is. Since a
v1 client would be expecting the response, we must send it, but at that
point it is too late to make the change. So we need to see some flag
from the client before the server says anything.

And the problem is that the client sending that flag will break v1
servers, and the client would need to waste time doing a retry when
connecting to the (initially more common) v1 servers.

> - If client is also capable of v2 and gets the flag, it enables v2 for
>   just that remote (probably unless the user said, "i never want to")
> 
> - Next time the client connects to that remote it will use v2.

So yeah, that would work to help with the wasted time. We'd have
git-upload-pack2 to do the v2 protocol, but the v1 git-upload-pack for
the server would say "by the way, next time you connect, try v2 first".
So the client would have to store a version number for each remote.
Which is not too onerous.

Another way to think of it is phasing it in like this:

  1. Add v2 support to client and server. Initially, clients try only
     v1.

  2. Add a remote.*.preferProtocol config option, defaulting to v1. This
     lets people turn on v2 for remotes they know support it. If v2
     fails, still fall back to v1.

  3. Add a server upload-pack capability that says "by the way, try v2
     next time".  Have the client set the preferProtocol config option
     for a remote if we see that capability.

  4. Wait a while until v2 is very popular.

  5. Switch the default for preferProtocol to v2 (but still fall back to
     v1).

So always fall back and remain compatible, and let the config option
just be an optimization to avoid extra failed requests.

> I'm not sure, if this is possible, since I think to remember that I have read 
> in the Documentation folder something along the line: Capabilities announced 
> from the server mean "I want you to use exactly these flags".

No, the server capability says "I can do this", and the client should
respond with "I want you to do this". Because the server might be
talking to an older client that does not know what "this" is, it must
handle the case that the capability does not come back.

-Peff

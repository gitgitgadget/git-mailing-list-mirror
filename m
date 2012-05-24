From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 16:51:07 -0400
Message-ID: <20120524205107.GA21329@sigill.intra.peff.net>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
 <7v62blxx2m.fsf@alter.siamese.dyndns.org>
 <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
 <20120524202930.GB18936@sigill.intra.peff.net>
 <CAJo=hJsfRr7MKcmn8owuyYf7LJ2jzpqgCfkijQ6ahrZfz3CDpw@mail.gmail.com>
 <CAJo=hJt4Suu5=kYh3kyOpDSPKr0jiZka=9g6U841PbiWCAQ_pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 22:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXf06-0005Kj-OI
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759169Ab2EXUvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:51:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54247
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513Ab2EXUvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:51:09 -0400
Received: (qmail 313 invoked by uid 107); 24 May 2012 20:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 16:51:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 16:51:07 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJt4Suu5=kYh3kyOpDSPKr0jiZka=9g6U841PbiWCAQ_pQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198426>

On Thu, May 24, 2012 at 01:46:36PM -0700, Shawn O. Pearce wrote:

> >> Nice numbers. And as clever as I find this helper-wrapping-a-helper
> >> solution, I wonder if the right layer for a fix isn't inside curl. It
> >> already keeps an ssl session-id cache in memory; how hard would it be to
> >> turn that into an on-disk cache?
> ...
> > Well, this helper "solution" also has the benefit of HTTP keep-alive
> > working across Git command invocations.

True. It also works even when the server does not support ssl id
caching.

> Here is plaintext HTTP, where the benefit is from HTTP keep-alive:
> 
>   (for i in {1..5}; do time git ls-remote
> http://android.googlesource.com/tools/repo >/dev/null;done) 2>&1  |
> grep real
>   real	0m0.098s
>   real	0m0.097s
>   real	0m0.106s
>   real	0m0.095s
>   real	0m0.105s
> 
>   (for i in {1..5}; do time git ls-remote
> persistent-http://android.googlesource.com/tools/repo >/dev/null;done)
> 2>&1  | grep real
>   real	0m0.134s
>   real	0m0.065s
>   real	0m0.063s
>   real	0m0.061s
>   real	0m0.067s
> 
> Notice we still save 30ms or so in this case. That is about the RTT
> for my workstation to that server. :-)

Nice. I assumed most of your speedup was coming from dropping the SSL
setup, but it seems that a good chunk of it is just the TCP setup.
Thanks for providing numbers.

-Peff

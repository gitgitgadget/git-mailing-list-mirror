From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Only print an error for the last connect() failure
Date: Thu, 9 Jun 2011 13:05:54 -0400
Message-ID: <20110609170554.GA29760@sigill.intra.peff.net>
References: <13539E82-3E8D-4210-9A3A-DD83F0CA6F85@apple.com>
 <20110609163340.GD25885@sigill.intra.peff.net>
 <767D7D04-6089-4C7B-A532-C5EC9FE0CCC6@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:06:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUigG-00042m-6k
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab1FIRF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:05:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54271
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab1FIRF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:05:58 -0400
Received: (qmail 16461 invoked by uid 107); 9 Jun 2011 17:06:05 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 13:06:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 13:05:54 -0400
Content-Disposition: inline
In-Reply-To: <767D7D04-6089-4C7B-A532-C5EC9FE0CCC6@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175551>

On Thu, Jun 09, 2011 at 09:49:28AM -0700, Dave Zarzycki wrote:

> I'm happy to make that change.
> 
> Personally speaking, I don't think we're masking failures any more
> than git is masking failures when it doesn't find a ref in .git/refs
> and it falls back to .git/packed-refs. This fallback is by design, and
> the same is true of any classic loop around getaddrinfo(). Of course,
> reasonable people may disagree about what the "right" thing to do here
> is. :-)

When the fallback actually _works_, then yes, there's no reason to say
anything. But when the fallback fails, it can be useful to get
information on each of the steps. In your refs analogy, it would just be
"I couldn't look up this ref; I tried .git/refs and packed refs". Which
would be the same every time, so it's not really interesting enough to
print.

But in the case of host lookup (especially with ipv6), it may be very
useful to say "I tried this address, and it failed for this reason; then
I tried this address, and it failed for this reason". If I see:

  $ git fetch git://example.com/foo
  example.com[0: 192.0.32.10]: errno=Connection timed out
  example.com[0: 2620:0:2d0:200::10]: errno=Network is unreachable
  fatal: unable to connect a socket (Network is unreachable)

then I don't care about the second error. Of course the IPv6 network is
unreachable; I don't have IPv6 connectivity. The first line contains the
useful information. But with your patch, it won't be shown at all.

We should perhaps also always print intermediate error messages as we
get them in verbose mode. Even if we succeed, seeing connection timeouts
on earlier addresses can explain long pauses before success (but I agree
they shouldn't be shown by default).

-Peff

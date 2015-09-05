From: Jeff King <peff@peff.net>
Subject: Re: glibc mutex deadlock in signal handler
Date: Sat, 5 Sep 2015 04:59:34 -0400
Message-ID: <20150905085934.GA31358@sigill.intra.peff.net>
References: <s5hfv2vn4wq.wl-tiwai@suse.de>
 <xmqqvbbrjrs9.fsf@gitster.mtv.corp.google.com>
 <s5h7fo7wb3e.wl-tiwai@suse.de>
 <87y4gn5ijr.fsf@igel.home>
 <s5hy4gmvii2.wl-tiwai@suse.de>
 <20150904092355.GA524@sigill.intra.peff.net>
 <xmqq7fo5g85x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Takashi Iwai <tiwai@suse.de>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 11:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY9KS-0001uQ-1K
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 11:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbbIEI7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 04:59:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:55375 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750838AbbIEI7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 04:59:37 -0400
Received: (qmail 16839 invoked by uid 102); 5 Sep 2015 08:59:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Sep 2015 03:59:37 -0500
Received: (qmail 1216 invoked by uid 107); 5 Sep 2015 08:59:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Sep 2015 04:59:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2015 04:59:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fo5g85x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277365>

On Fri, Sep 04, 2015 at 02:56:58PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Perhaps we should reconsider whether f4c3edc (vreportf: avoid
> > intermediate buffer, 2015-08-11) is a good idea.  Note that snprintf is
> > not on the list of safe functions, but I imagine that in practice it is
> > fine. Though just avoiding error()/warning() in signal handlers might be
> > a more practical solution anyway.
> 
> I had exactly the same thought when I read the initial report here.
> 
> I wish we can just do "if (in_signal) return;" at the beginning of
> vreportf(), but we would not want a global variable there, so... ;-)

Why not? I mean, sure it's gross. But it actually seems like a pretty
simple fix that doesn't have to hurt other callers (or involve passing
an "in_signal" through the stack). We could even fallback to snprintf()
into a fixed-sized buffer, or some other degraded mode.

> Further, I briefly hoped that avoiding error/warning in the signal
> handler codepath would allow us to be more lax around allocations,
> but I suspect that it unfortunately would not help us that much, as
> we may be calling these functions in low memory situations.

I'm not sure the low-memory thing isn't a red herring. Sure, we call
die() when malloc fails. But only with a tiny string. Something like the
robust_buf patch I posted would handle that just fine.

The real danger of signal handlers is that you don't get to say "oh,
malloc failed, so let's fallback to some degraded mode". You just get
deadlocked in a futex and never return. :)

> So let's queue Takashi's patch as-is for now and look at other
> signal codepaths.

Sounds like a good first step, unless we are going to do refactoring
that Takashi's patch could take advantage of (either a global in_signal,
or some register_cleanup() infrastructure).

-Peff

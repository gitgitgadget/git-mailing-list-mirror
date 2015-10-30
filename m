From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Fri, 30 Oct 2015 17:08:49 -0400
Message-ID: <20151030210849.GA7149@sigill.intra.peff.net>
References: <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
 <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
 <20151026215016.GA17419@sigill.intra.peff.net>
 <xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
 <20151027184702.GB12717@sigill.intra.peff.net>
 <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
 <20151030001000.GA2123@sigill.intra.peff.net>
 <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
 <20151030005057.GA23251@sigill.intra.peff.net>
 <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsGuu-0002Lo-Om
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 22:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760147AbbJ3VIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 17:08:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:50654 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757943AbbJ3VIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 17:08:52 -0400
Received: (qmail 16281 invoked by uid 102); 30 Oct 2015 21:08:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 16:08:51 -0500
Received: (qmail 26521 invoked by uid 107); 30 Oct 2015 21:09:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 17:09:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 17:08:49 -0400
Content-Disposition: inline
In-Reply-To: <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280542>

On Thu, Oct 29, 2015 at 09:20:01PM -0400, Noam Postavsky wrote:

> On Thu, Oct 29, 2015 at 8:50 PM, Jeff King <peff@peff.net> wrote:
> > workaround (the real inelegance is that you are assuming that "foo"
> > needs run in the first place).
> 
> Well, we currently check the output from "git config
> credential.helpers" to determine what's needed, so the inelegance here
> is that we reimplement git's checking of this option.

Right. And not only is that hard to get right (I doubt, for example, you
support the arbitrary "!" shell expressions that git does), but it's
impossible to know for sure that will be needed, because you cannot know
all possible helpers (I might even have a helper that is a shell snippet
that calls credential-cache).

As a workaround, I don't think looking for just "cache" is unreasonable.
But it is not a very robust solution. :)

> > I'm still not sure how the pre-helper would work. What git command kicks
> > off the pre-helper command? Wouldn't it also be subject to the SIGHUP
> > problem?
> 
> Ah, maybe the missing piece I forgot to mention is that we could make
> our pre/1st-helper be an emacsclient command, which would tell Emacs
> to startup the daemon. So the daemon would be a subprocess of Emacs,
> not "git push", thereby avoiding the SIGHUP. In our current workaround
> we startup the daemon (if it's not running) before git commands that
> we think are going to run credential helpers (i.e. "push", "pull",
> "fetch"), hence my thought that it would be nicer if we only did that
> before git is *actually* going to run the helpers.

I don't think even git knows it will need a helper until it is actually
ready to call one (e.g., it may depend on getting an HTTP 401 from the
server).

I am leaning more towards ignoring SIGHUP (configurably) being the only
really sane path forward. Do you want to try your hand at a patch?

-Peff

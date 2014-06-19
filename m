From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] strbuf: add xstrdup_fmt helper
Date: Thu, 19 Jun 2014 05:05:32 -0400
Message-ID: <20140619090532.GB1009@sigill.intra.peff.net>
References: <20140618200000.GA22994@sigill.intra.peff.net>
 <20140618200133.GA23057@sigill.intra.peff.net>
 <xmqq7g4dj1cn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 11:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxYHv-0002RA-IW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 11:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757741AbaFSJFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 05:05:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:47348 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755362AbaFSJFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 05:05:34 -0400
Received: (qmail 10910 invoked by uid 102); 19 Jun 2014 09:05:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 04:05:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 05:05:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g4dj1cn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252104>

On Wed, Jun 18, 2014 at 03:32:08PM -0700, Junio C Hamano wrote:

> >   str = xstrdup_fmt(fmt, some, args);
> > ---
> > I'm open to suggestions on the name. This really is the same thing
> > conceptually as the GNU asprintf(), but the interface is different (that
> > function takes a pointer-to-pointer as an out-parameter, and returns the
> > number of characters return).
> 
> Naming it with anything "dup" certainly feels wrong.  The returned
> string is not a duplicate of anything.

I was somewhat inspired by "mkpathdup" and friends. It is quite simialr
to mkpathdup, except that it is not limited to paths (and does not do
any path-specific munging). I agree something with "printf" in the name
is probably more descriptive, though.

> I wonder if our callers can instead use asprintf(3) with its
> slightly more quirky API (and then we supply compat/asprintf.c for
> non-GNU platforms).  Right now we only have three call sites, but if
> we anticipate that "printf-like format into an allocated piece of
> memory" will prove be generally useful in our code base, following
> an API that other people already have established may give our
> developers one less thing that they have to learn.

I considered that, but I do find asprintf's interface unnecessarily
annoying (you can't return a value directly, and you run afoul of const
issues when passing pointers to pointers). As you noted, it's not _too_
bad, but we really get nothing from the integer return type. AFAICT, it
helps with:

  1. You know how many characters are in the string. If you cared about
     that here, you would just use a strbuf directly, which is much more
     flexible.

  2. The error handling is different. But our x-variant would just die()
     on errors anyway, so we do not care.

So modeling after asprintf feels like carrying around unnecessary
baggage (and I am not convinced asprintf is in wide enough use, nor that
the function is complicated enough to care about developer familiarity).
Part of me is tempted to call it xasprintf anyway, and use our own
interface. GNU does not get to squat on that useful name. ;)

That is probably unnecessarily confusing, though.

> As usual, I would expect we would have xasprintf wrapper around it
> to die instead of returning -1 upon allocation failure.

Would it be crazy to just call it xprintf? By our current scheme that
would be "a wrapper for printf", which means it is potentially
confusing.

Literally any other unused letter would be fine. dprintf for detach? I
dunno.

-Peff

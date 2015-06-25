From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Thu, 25 Jun 2015 13:22:47 -0400
Message-ID: <20150625172246.GA24744@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165501.GB23503@peff.net>
 <20150625170328.GV18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:22:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ArY-0001Ak-Ja
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 19:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbbFYRWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 13:22:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:51794 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750777AbbFYRWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 13:22:49 -0400
Received: (qmail 21202 invoked by uid 102); 25 Jun 2015 17:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 12:22:49 -0500
Received: (qmail 8517 invoked by uid 107); 25 Jun 2015 17:22:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 13:22:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 13:22:47 -0400
Content-Disposition: inline
In-Reply-To: <20150625170328.GV18226@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272702>

On Thu, Jun 25, 2015 at 06:03:28PM +0100, John Keeping wrote:

> > Ideally we could say:
> > 
> >   show_date(t, tz, &{ DATE_NORMAL });
> > 
> > but of course C does not allow that.
> 
> Yes it does, e.g. in 6.5.2.5 of C11, example 3 shows:

Well, yes. But we generally restrict ourselves to C89 here, so we are
not even close.

> Of course, whether all of the compilers we target support it is a
> different question.  If they do, perhaps something like:
> 
> #define SIMPLE_DATE(f)		&(struct date_mode) { DATE_NORMAL }
> 
> would allow the callers to remain reasonably sane.

My patch already introduces DATE_MODE, so you could conditionally hide
it there, and fall back to date_mode_from_type when the compiler is too
old for this. But then, what is the advantage over the existing
solution? It's reentrant, but I don't think that is a problem here.

And in patch 3, you'll see that I add an extra assertion to
date_mode_from_type that this cannot support (to make sure that we do
not create a DATE_STRFTIME mode with no matching format string). The
syntax above would at least give us NULL for the string, which is better
than random garbage, but I think the assert is better still.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/41] usage.c: move format processing out of die_errno()
Date: Tue, 3 May 2016 06:15:34 -0400
Message-ID: <20160503101533.GA27522@sigill.intra.peff.net>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462101297-8610-2-git-send-email-pclouds@gmail.com>
 <CAPig+cQhQ2C-gOuQwJ9RBXM7HBBJkWORfRkq-t-PY=vvxgAonA@mail.gmail.com>
 <xmqqlh3stiyt.fsf@gitster.mtv.corp.google.com>
 <20160503044528.GA32259@sigill.intra.peff.net>
 <CACsJy8DS5-dL8p8iMQs5B1++GaXNQWwdxUeaMCeZ12OoQcPO7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 12:15:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axXMk-0001NB-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 12:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbcECKPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 06:15:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:60964 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932252AbcECKPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 06:15:38 -0400
Received: (qmail 26881 invoked by uid 102); 3 May 2016 10:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 06:15:37 -0400
Received: (qmail 25414 invoked by uid 107); 3 May 2016 10:15:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 06:15:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 06:15:34 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DS5-dL8p8iMQs5B1++GaXNQWwdxUeaMCeZ12OoQcPO7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293351>

On Tue, May 03, 2016 at 04:39:45PM +0700, Duy Nguyen wrote:

> On Tue, May 3, 2016 at 11:45 AM, Jeff King <peff@peff.net> wrote:
> > On Mon, May 02, 2016 at 11:26:02AM -0700, Junio C Hamano wrote:
> >
> >> Caller supplied buffer would be the way to go when multiple threads
> >> could be showing errors and warnings, right?
> >>
> >> It would not make too much of a difference for die(), though.
> >
> > I think it can matter for die(). This is happening above the pluggable
> > die_routine() layer, so it's possible for an async task to call die()
> > which will end in pthread_exit(), while the main program is calling
> > die() to end in regular exit().
> >
> > I imagine it's exceedingly unlikely, and of course both threads are
> > dying anyway, but it could result in some pretty weird memory errors.
> > It's probably worth taking precautions against, especially because it's
> > to easy to do so.
> 
> So, sum it up, the new fmt_with_err() will take a buffer and size.
> die_errno() sticks to its static buffer as before. error_errno() and
> warning_errno() can allocate 1k on stack to be more
> multithread-friendly. Let me know if some other change is needed.

Yes, though note that die_errno() currently has a stack buffer, not a
static one. It should remain that way (and error_errno and warning_errno
should follow suit) to be friendly to multi-threading.

-Peff

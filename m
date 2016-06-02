From: Jeff King <peff@peff.net>
Subject: Re: Mark remote `gc --auto` error messages
Date: Thu, 2 Jun 2016 17:48:35 -0400
Message-ID: <20160602214834.GB13356@sigill.intra.peff.net>
References: <146489432847.688.11121862368709034386@typhoon>
 <xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com>
 <146489800609.1944.4398103814754920753@typhoon.lan>
 <CAPc5daXVx1=ptsKJEfEzXbjCNvwYxjAPyp_pob9CeR+Qr3tG_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:48:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aTq-0007lE-EY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbcFBVsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:48:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:48041 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932240AbcFBVsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:48:38 -0400
Received: (qmail 5813 invoked by uid 102); 2 Jun 2016 21:48:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:48:37 -0400
Received: (qmail 14561 invoked by uid 107); 2 Jun 2016 21:48:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:48:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 17:48:35 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daXVx1=ptsKJEfEzXbjCNvwYxjAPyp_pob9CeR+Qr3tG_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296242>

On Thu, Jun 02, 2016 at 01:14:02PM -0700, Junio C Hamano wrote:

> On Thu, Jun 2, 2016 at 1:06 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> > On Thu, 02 Jun 2016 at 21:33:33, Junio C Hamano wrote:
> >> Lukas Fleischer <lfleischer@lfos.de> writes:
> >>
> >> > When running `git push`, it might occur that error messages are
> >> > transferred from the server to the client. While most messages (those
> >> > explicitly sent on sideband 2) are prefixed with "remote:", it seems
> >> > that error messages printed during the automatic householding performed
> >> > by git-gc(1) are displayed without any additional decoration. Thus, such
> >> > messages can easily be misinterpreted as git-gc failing locally, see [1]
> >> > for an actual example of where that happened.
> >>
> >> Sounds like a sensible goal to me.
> >
> > What exactly are you referring to (you only quoted the introduction)?
> > Do you think we should fix the git-gc issue but keep the general
> > behavior of printing messages unaltered? Do you think it would be
> > worthwhile to make server messages distinguishable in general?
> 
> The latter, which I think was what your implementation was attempting to do
> if I read it correctly.

I think the implementation is doing much more, but it is probably a good
thing.

Right now we do not send auto-gc output over the sideband, and its
stderr goes to receive-pack's stderr. But that is a different place for
different protocols. For git-over-https, it is probably apache's error
log, or /dev/null if the server admin configured it. For ssh, it may be
back over the ssh stderr channel, or it may go to a log or nowhere if
the server admin intercepts receive-pack and redirects it.

So the greater question is not "should this output be marked" but
"should auto-gc data go over the sideband so that all clients see it
(and any server-side stderr does not)". And I think the answer is
probably yes. And that fixes the "remote: " thing as a side effect.

If it were no, then this is not the right solution, and the solution is
to swap out copy_to_sideband() for something that copies to stderr with
"remote: " prepended, or something.

-Peff

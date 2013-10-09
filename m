From: Jeff King <peff@peff.net>
Subject: Re: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed, 9 Oct 2013 15:48:20 -0400
Message-ID: <20131009194820.GB3767@sigill.intra.peff.net>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
 <CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com>
 <CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com>
 <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
 <vpqy562y9b8.fsf@anie.imag.fr>
 <CAAcnjCQCJYbYUkTK+ZM6xFe=u1mj9iHetaG--yg3Qzn0_Ty0hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Giarrusso <p.giarrusso@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 21:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTzkA-0005xj-VA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 21:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab3JITsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 15:48:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:46476 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752357Ab3JITsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 15:48:22 -0400
Received: (qmail 6341 invoked by uid 102); 9 Oct 2013 19:48:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 14:48:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 15:48:20 -0400
Content-Disposition: inline
In-Reply-To: <CAAcnjCQCJYbYUkTK+ZM6xFe=u1mj9iHetaG--yg3Qzn0_Ty0hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235840>

On Wed, Oct 09, 2013 at 02:03:24PM +0200, Paolo Giarrusso wrote:

> On Wed, Oct 9, 2013 at 1:26 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Paolo Giarrusso <p.giarrusso@gmail.com> writes:
> >
> >> Otherwise, one could
> >> change say to use printf, but that's more invasive.
> >
> > "invasive" in the sense that it impacts indirectly more callers, but are
> > there really cases where "echo" is needed when calling "say"? Aren't
> > there other potential bugs when arbitrary strings are passed to "say",
> > that would be fixed by using printf once and for all?
> 
> (1) Changing the implementation of say to use printf "%s\n" would be
> trivial, and I think would address your concerns.

Yeah, I think we should do that. I had the same thought as Matthieu when
I read your initial patch; there are real portability bugs caused by
using "echo" that would be fixed.

However, that is somewhat orthogonal to the bug you are fixing. For
handling this one site, I think it would be fine to just convert it to
use printf, as your patch did. As you noted, the alternatives:

> (2) add an explicit \n to all callers (invasive & error prone), or
> (3) make `say` parse the `-n` option and conditionally add "\n" to the
> format string or to a final argument, if -n is not specified; this
> would affect no current caller, but complicate the implementation of
> say. Doing that for just one call site has too much potential for
> breakage, so I'm not sure I'd do it. (I'm not even sure on what should
> `say` do when `-n` is not the first argument).

...are either annoying or complicated (and in particular, parsing "-n"
means that callers need to be aware that 'say "$foo"' might accidentally
trigger "-n" if $foo comes from the user). So the sanest interface is
probably "say_nonl" or something similar. But since there would only be
one caller, I don't see much point in factoring it out.

> Options (1), (2) and (3) are mutually alternative; my favorite is (1).

Me too. :)

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 12:18:45 -0400
Message-ID: <20130411161845.GA665@sigill.intra.peff.net>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211552.GA3256@sigill.intra.peff.net>
 <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKDH-0001Oo-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab3DKQS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 12:18:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40635 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270Ab3DKQS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:18:58 -0400
Received: (qmail 16308 invoked by uid 107); 11 Apr 2013 16:20:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 12:20:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 12:18:45 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220885>

On Thu, Apr 11, 2013 at 08:22:26AM -0500, Felipe Contreras wrote:

> > We
> > currently do so robustly when the helper uses the "done"
> > feature (and that is what we test).  We cannot do so
> > reliably when the helper does not use the "done" feature,
> > but it is not even worth testing; the right solution is for
> > the helper to start using "done".
> 
> This doesn't help anyone, and it's not even accurate. I think it might
> be possible enforce remote-helpers to implement the "done" feature,
> and we might want to do that later. But of course, discussing what bad
> things remote-helpers could do, and how we should test and babysit
> them is not relevant here.
> 
> If it was important to explain the subtleties and reasoning behind
> this change, it should be a separate patch.

I am OK with adding the test for import as a separate patch. What I am
not OK with (and this goes for the rest of the commit message, too) is
failing to explain any back-story at all for why the change is done in
the way it is.

_You_ may understand it _right now_, but that is not the primary
audience of the message. The primary audience is somebody else a year
from now who is wondering why this patch was done the way it was. When
they are trying to find out why git does not detect errors in a helper,
and they notice that our test for failure only check the "done" case,
isn't it more helpful to say "we considered the other case, but it was
not worth fixing" rather than leaving them to guess?

I may be more verbose than necessary in some of my commit messages, but
I would much rather err on the side of explaining too much than too
little.

> >         export)
> > +               if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
> > +               then
> > +                       # consume input so fast-export doesn't get SIGPIPE;
> 
> I think this is explanation enough.
> 
> > +                       # git would also notice that case, but we want
> > +                       # to make sure we are exercising the later
> > +                       # error checks
> 
> I don't understand what is being said here. What is "that case"?

The case that fast-export gets SIGPIPE. I was trying to explain not
just _what_ we are doing, but _why_ it is important. Perhaps a better
wording would be:

  # consume input so fast-export doesn't get SIGPIPE;
  # we do not technically need to do so in order for
  # git to notice the failure to export, as it will
  # detect problems either with fast-export or with
  # the helper failing to report ref status. But since
  # we are trying to demonstrate that the latter
  # check works, we must avoid the SIGPIPE, which would
  # trigger the former.

-Peff

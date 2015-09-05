From: Jeff King <peff@peff.net>
Subject: Re: More builtin git-am issues..
Date: Fri, 4 Sep 2015 20:07:45 -0400
Message-ID: <20150905000745.GC11443@sigill.intra.peff.net>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
 <CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 02:08:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY11e-0004fc-Ur
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 02:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760609AbbIEAHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 20:07:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:55292 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759995AbbIEAHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 20:07:48 -0400
Received: (qmail 8375 invoked by uid 102); 5 Sep 2015 00:07:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 19:07:47 -0500
Received: (qmail 30696 invoked by uid 107); 5 Sep 2015 00:07:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 20:07:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 20:07:45 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277350>

On Fri, Sep 04, 2015 at 04:52:42PM -0700, Linus Torvalds wrote:

> On Fri, Sep 4, 2015 at 4:47 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I *think* it's this part:
> >
> >                 if (!(found_rfc2822 ||
> >                       is_cherry_picked_from_line(buf + i, k - i - 1)))
> >                         return 0;
> >
> > which basically returns 0 for _any_ line in the footer that doesn't
> > match the found_rfc2822 format.
> 
> Confirmed. I hacked up a version that just doesn't do that check at
> all, and it works fine (but obviously only on well-formatted emails
> that really do have a sign-off).
> 
> So I think that logic should basically be extended to saying
> 
>  - if any line in the last chunk has a "Signed-off-by:", set a flag.
> 
>  - at the end of the loop, if that flag wasn't set, return 0.

Do we want to make Signed-off-by a special token here? What about "Cc:",
and other project-specific trailers? You wouldn't want to end up with:

  [some comment]
  Cc: somebody

  Signed-off-by: somebody else

It's not a problem for git-am, which should be taking in patches that
are already signed-off (and after all, if your project does not use
signoffs, why are you using "am -s"?). But won't "git commit -s" run
into the same problem?

We could look for an arbitrary rfc2822-ish string, but I'd be worried
slightly about false positives, like:

  This is a paragraph with arbitrary text. But one
  of the lines will use a colon, and that a causes a
  problem: because of wrapping, this line kind of looks
  like a trailer.

Maybe only the final line needs to look rfc2822-ish? Or maybe we can
constrain the content that _doesn't_ look like a trailer line. Is it
sufficient to allow a block encased in "[]", rather than arbitrary text?

All that being said, I think we can punt on the harder issues for now,
and just restore the original git-am.sh behavior (which it looks
like was fairly naive) for the upcoming release, so that there is no
regression.

-Peff

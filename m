From: Jeff King <peff@github.com>
Subject: Re: GSoC questions
Date: Thu, 31 Mar 2011 15:27:58 -0400
Message-ID: <20110331192758.GD16981@sigill.intra.peff.net>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
 <20110328001152.GA11294@elie>
 <AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
 <AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
 <AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
 <AANLkTi=TOYOj2HWzy62G24Kg=NZC5X1=psA3GDhaH3Hc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexandru Sutii <sutii.alex@gmail.com>,
	Vicent Marti <vicent@github.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:28:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5NXN-00074u-32
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759098Ab1CaT2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 15:28:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51954
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab1CaT2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 15:28:00 -0400
Received: (qmail 1983 invoked by uid 107); 31 Mar 2011 19:28:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 15:28:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 15:27:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=TOYOj2HWzy62G24Kg=NZC5X1=psA3GDhaH3Hc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170523>

On Thu, Mar 31, 2011 at 01:58:23PM +0200, Vincent van Ravesteijn wrote:

> On Thu, Mar 31, 2011 at 11:36 AM, Alexandru Sutii <sutii.alex@gmail.com> wrote:
> > I have also used the original "usage.c" and "git-compat-util.h" for
> > error handling.
> > Is there a problem if the git2 client will reuse non-gitcore code, such
> > as string parsing code, parameter parsing code, etc?
> 
> I guess the git2 client will consist solely of non-gitcore code, as
> all the gitcore code will be part of libgit2 eventually.
> 
> I expect the transition to be not so difficult for many commands, but
> the challenge I see is to do it not by 'reusing' git code, but by
> 'sharing' the code. Otherwise we end up with a second Git and someone
> should spend a lifetime to keep the reused code in synchronisation
> with the git repo.
> 
> This might, however, require some (major) refactorization to the Git
> code. I don't know whether that will be supported by everyone.

I had sort of assumed that git-core code would be taken as inspiration,
but that it would be an entirely new implementation, based around the
error handling and build infrastructure provided by libgit2.

And obviously libgit2 isn't going to provide everything you need. For
example, in the mktag implementation that Alex posted, there's still a
big verify_and_create_tag() function. I would prefer to see that code
broken into library-sized chunks and added to libgit2 itself, with the
eventual goal that mktag.c could consist of a very short main() function
that just parses options calls into the library (and yeah, I realize
that things are not always so simple, but it is a goal to work towards).

So when starting with a command, rather than trying to port code from
git.git, look at what it does and say "how would I do this in libgit2?
What else needs to be implemented in the library before I can do it?".
And then write the bulk of your code for libgit2, filling in those gaps
in functionality, and as a final step make the actual executable
command.

In this case, one of the things that is lacking is the die() error
handling. In general, that is not something libgit2 wants, because its
goal is to pass errors back up the call chain. Another thing that is
missing is option-parsing (though mktag doesn't need it). Again, not
something that libgit2 wants to use.

But maybe those are things that libgit2 should be providing to callers.
Or maybe they should be spun off into their own separate utility
library. But in either case, they should probably be pulled out of core
git, cleaned up to make them fit for library use, and then made part of
libgit2.

-Peff

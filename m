From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Add user.explicit boolean for when ident shouldn't be
 guessed
Date: Thu, 4 Feb 2016 00:50:35 -0500
Message-ID: <20160204055035.GA13537@sigill.intra.peff.net>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <20160203082112.GA27454@gmail.com>
 <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
 <20160203192227.GA13878@gmail.com>
 <20160204040111.GA27371@sigill.intra.peff.net>
 <20160204053646.GA24453@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 06:50:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRCoU-0002nL-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 06:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbcBDFuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 00:50:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:37179 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbcBDFui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 00:50:38 -0500
Received: (qmail 8996 invoked by uid 102); 4 Feb 2016 05:50:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 00:50:38 -0500
Received: (qmail 31463 invoked by uid 107); 4 Feb 2016 05:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 00:50:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 00:50:35 -0500
Content-Disposition: inline
In-Reply-To: <20160204053646.GA24453@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285399>

On Thu, Feb 04, 2016 at 07:36:46AM +0200, Dan Aloni wrote:

> > In a sense, that encourages a nice workflow for your intended feature.
> > You have to do:
> > 
> >   git clone -c user.name=... -c user.email=... clone ...
> > 
> > to set up your ident in the newly-cloned repository, or else clone will
> > yell at you. But it's a little unfriendly. If you are just cloning to
> > view and not make commits, you don't need your ident set up. And worse,
> > if you forget to add your "-c" ident, clone will go through the trouble
> > to copy all of the objects, and only then complain about your ident.
> 
> I think that forcing to give the configuration in 'git clone' could be
> problematic for automated tools (e.g. o build) that invoke 'git clone'
> just for building purposes (i.e. read-only) to a tool-managed directory.
> And what about sub-modules clones? It would be hard to distinguish manual
> clones and automatic clones anyway.

Yeah. I sort of assumed that people with automated tools _wouldn't_ set
user.explicit. But even with that assumption, I think it's too
unfriendly to continue.

> > So I'd argue that this should only kick in for the strict case. Which
> > means the check _has_ to go into fmt_ident, and we have to somehow
> > inform fmt_ident of the four cases:
> [...]
> 
> Looks like an enum type would be better here instead of a set of booleans.

Yeah, if we can actually split the state space into the 4 cases, I agree
an enum would be easier to follow. I'm not 100% sure that my cases map
completely to what the code does now, though.

> > I also wonder if we could simply expose the 4 levels of above in a
> > variable, and default it to type-3. That would let people loosen or
> > tighten as they see fit. But it would be a more complicated patch, so if
> > nobody really cares about it beyond this use case, it may be overkill.
> 
> I get the impression from this and your later E-Mails that there are
> much more cases to cover when testing this feature (and I would not
> like to break stuff implementing this, obviously).
> 
> The code should be cleaned up anyway. I only delved into that code for
> the first time two days ago, so it would take me more time to come up
> with a new one (though reading your overview here of the cases is going
> to be helpful, thanks).

Feel free to look into this direction, but having pushed a little
further towards the "simple" approach (with the 2 patches I just sent),
I think that does what you want without too much complication. I'd be
fine, too, if you wanted to pick those up[1] and put the finishing
touches on the second one.

-Peff

[1] To clarify, since you are new to the git.git workflow: I'd expect
    you to use `git am` to pick up my two patches. Leave me as the
    author of the first cleanup patch. Squash your additions onto the
    second one using `cherry-pick`, `commit --amend`, or whatever, and
    make sure to `commit --reset-author` so that you're the author. Post
    both as part of the v4 re-roll.

    But that's just "here is what I meant", not "what you have to do". :)

From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 03:50:20 -0800
Message-ID: <20121115115018.GA3437@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
 <20121115111334.GA1879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 12:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYxxv-0004MJ-QM
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 12:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993281Ab2KOLuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 06:50:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49304 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993197Ab2KOLuY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 06:50:24 -0500
Received: (qmail 16108 invoked by uid 107); 15 Nov 2012 11:51:13 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 06:51:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 03:50:20 -0800
Content-Disposition: inline
In-Reply-To: <20121115111334.GA1879@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209816>

On Thu, Nov 15, 2012 at 03:13:47AM -0800, Jeff King wrote:

> I think a much more compelling argument/commit message for your
> suggested patch would be:
> 
>   We currently prompt the user for the "From" address. This is an
>   inconvenience in the common case that the user has configured their
>   identity in the environment, but is meant as a safety check for when
>   git falls back to an implicitly generated identity (which may or may
>   not be valid).
> 
>   That safety check is not really necessary, though, as by default
>   send-email will prompt the user for a final confirmation before
>   sending out any message. The likelihood that a user has both bothered
>   to turn off this default _and_ not configured any identity (nor
>   checked that the automatic identity is valid) is rather low.

If that is the route we want to go, then we should obviously drop my
series in favor of your final patch. I think it would also need a test
update, no?

I think a more concise commit message would help, too. I disagree with a
great deal of the reasoning in your existing message, but those parts
turn out not to be relevant. The crux of the issue is that the safety
check is not necessary because there is already one (i.e., point 8 of
your list).  Feel free to use any or all of my text above.

>From my series, there were a few cleanups that might be worth salvaging.
Here is a rundown by patch:

  [1/8]: test-lib: allow negation of prerequisites

This stands on its own, and is something I have wanted a few times in
the past. However, since there is no immediate user, I don't know if it
is worth doing or not.

  [2/8]: t7502: factor out autoident prerequisite

A minor cleanup and possible help to future tests, but since there are
no other callers now, not sure if it is worth it.

  [3/8]: ident: make user_ident_explicitly_given static

A cleanup that is worth doing, I think.

  [4/8]: ident: keep separate "explicit" flags for author and committer

Another cleanup.  This is "more correct", in that it handles the corner
cases I mentioned in the commit message. But no current code cares about
those corner cases, because the only real caller is git-commit, and this
is a purely internal interface. I could take or leave it.

  [5/8]: var: accept multiple variables on the command line

The tests for this can be split out; we currently don't have "git var"
tests at all, so increasing our test coverage is reasonable. The
multiple variables thing is potentially useful, but there are simply not
that many callers of "git var", and nobody has been asking for such a
feature (we could use it to save a process in git-send-email, but it is
probably not worth the complexity).

  [6/8]: var: provide explicit/implicit ident information
  [7/8]: Git.pm: teach "ident" to query explicitness

These two should probably be dropped. They would lock us into supporting
the explicit/implicit variables in "git var", for no immediate benefit.

  [8/8]: send-email: do not prompt for explicit repo ident

Obviously drop.

> I could accept that line of reasoning.  I see that this argument is
> buried deep in your commit message, but I will admit to not reading your
> 9-point list of conditions all that closely, as the first 7 points are,
> in my opinion, not relevant (and I had already read and disagreed with
> them in other messages).

If it sounds like I am blaming you here, I am to some degree. But I am
also blaming myself. I should have read your commit message more
carefully, and I'm sorry for not doing so. I hope we can both try harder
to avoid getting side-tracked on arguing about issues that turned out
not to be important at all (of course, we cannot know which part of the
discussion will turn out to be important, but I think there some
obviously unproductive parts of this discussion).

-Peff

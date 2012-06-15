From: Jeff King <peff@peff.net>
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Fri, 15 Jun 2012 11:01:08 -0400
Message-ID: <20120615150107.GA4572@sigill.intra.peff.net>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
 <877gva1a4b.fsf@thomas.inf.ethz.ch>
 <4fdb326f.WB/xRjZx4pXtMhhZ%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: trast@student.ethz.ch, git@vger.kernel.org
To: perryh@pluto.rain.com
X-From: git-owner@vger.kernel.org Fri Jun 15 17:01:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfY1a-0001aS-Dd
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 17:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982Ab2FOPBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 11:01:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56373
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab2FOPBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 11:01:15 -0400
Received: (qmail 32340 invoked by uid 107); 15 Jun 2012 15:01:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 11:01:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 11:01:08 -0400
Content-Disposition: inline
In-Reply-To: <4fdb326f.WB/xRjZx4pXtMhhZ%perryh@pluto.rain.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200057>

On Fri, Jun 15, 2012 at 06:02:39AM -0700, perryh@pluto.rain.com wrote:

> > You are looking at two different dates:
> >
> > a) The dates stored within the commit object:
> >
> >    - committer date, similarly shown by %ci: when the commit
> >      was created.
> >    - author date, shown by %ai: when "this" commit was "first
> >      created".
> >
> >    These are properties of the commits, and thus part of the project
> >    history.  Anyone who clones the project sees the same dates.
> >
> > b) The dates in the reflog, tracking the movement of *your local*
> >    refs (like the name implies).  The HEAD reflog tracks what *you*
> >    had "currently checked out" at a given time.
> >
> > An automated search in (b) is possible with the @{} syntax, but
> > note that it tracks the *branch state*.  It says nothing about how
> > "current" a certain resulting commit was.  For example, if you say
> >
> >   git checkout v1.6.0
> >   sleep 2
> >   git checkout -
> >   git show '@{1 second ago}'
> >
> > you will see the commit for v1.6.0 from back in 2008.
> >
> > An automated search in (a) is hard, mostly because in nonlinear
> > history there is not usually a single (and well-defined) commit
> > that could be returned.
> 
> Given that we are discussing "git blame", which reports on the
> history of a file (specifically the commit in which each line
> originated), I think (a) must logically be included in the search
> -- especially if (as in the example) the date specified is earlier
> than any time in (b).  Perhaps such a request needs to use some
> other syntax rather than @{}, but surely the capability ought to
> be provided somehow.

It would have to use a different syntax, as reflog times (selected by
@{}) and commit dates (usually selected via --since and --until) are
measuring fundamentally different things, and have no meaningful
relation to each other.

But that still doesn't address the issue that (a) is not well-defined.
Imagine I have this history:


  A--B--C---G--H
   \       /
    D--E--F

that is, two lines of development splitting at A and merging at H. And
imagine the commit timestamps are (let's just refer to them as integers
for the sake of simplicity, but they are representing days or seconds or
whatever):

  A(1)--B(2)--C(3)--G(7)--H(8)
   \               /
    D(2)--E(4)--F(6)

What does it mean to ask for the commit at time=5? If you were to choose
the commit with the highest timestamp <= 5, you would pick E. But there
are two independent, simultaneous lines of development, and at time=5 on
the top branch, the most current commit was C.

So the question doesn't make sense. There was no one commit at time=5;
there were multiple (as many as you have simultaneous branches). You can
pick a winner out of them, but there are multiple ways to do it. For
example, you might want to say "of all lines of development, the one
that had most recently committed as of time=5" (and of course you can
still have a tie there). Or you could say "along the first-parent
ancestry, the commit that was most recent as of time=5". I am sure one
could come up with others, as well.

Git-blame expects you to give it a well-defined point (as it must, since
it is a backwards walk down history showing what led to a particular set
of content; it wouldn't make sense to feed it multiple starting points).
You could do so by asking rev-list to walk the graph according to your
requirements and feeding the result to blame, like:

  # most recent on any line of development that is merged to HEAD
  git blame `git rev-list -1 --until=5 HEAD`

  # most recent on any line of development in the whole repo
  git blame `git rev-list -1 --until=5 --all`

  # most recent version on the first-parent; if you follow a
  # topic-branch workflow and always merge up into "master", then this
  # will blame what was on master at time=5
  git blame `git rev-list -1 --until=5 --first-parent HEAD`

-Peff

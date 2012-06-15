From: perryh@pluto.rain.com
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Fri, 15 Jun 2012 06:02:39 -0700
Message-ID: <4fdb326f.WB/xRjZx4pXtMhhZ%perryh@pluto.rain.com>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
 <877gva1a4b.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Fri Jun 15 08:13:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfPmv-0006wW-Cp
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 08:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab2FOGNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 02:13:33 -0400
Received: from agora.rdrop.com ([199.26.172.34]:3907 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab2FOGNc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 02:13:32 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id q5F6DM0G057696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jun 2012 23:13:23 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id q5F6DMxg057695;
	Thu, 14 Jun 2012 23:13:22 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA07915; Thu, 14 Jun 12 23:03:59 PDT
In-Reply-To: <877gva1a4b.fsf@thomas.inf.ethz.ch>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200041>

Thomas Rast <trast@student.ethz.ch> wrote:

> perryh@pluto.rain.com writes:
>
> > How do I get "git blame" to operate "as of" a particular date in
> > the past, without having to manually look up the corresponding
> > SHA1 using "git rev-list"?  For example, I can get a report as
> > of 2011-12-29 by doing something like:
> >
> >   $ git rev-list --all --date-order --format="%h %ai" .
> >   ...
> >   7c69106 2012-01-03 ...
> >   b4227af 2011-12-27 ...
> >   ...
> >
> >   $ git blame <file> b4227af
> >
> > but I want to have git look up the last revision prior to the
> > given date, by doing something like
> >
> >   $ git blame <file> @{2011-12-29}
>
> You are looking at two different dates:
>
> a) The dates stored within the commit object:
>
>    - committer date, similarly shown by %ci: when the commit
>      was created.
>    - author date, shown by %ai: when "this" commit was "first
>      created".
>
>    These are properties of the commits, and thus part of the project
>    history.  Anyone who clones the project sees the same dates.
>
> b) The dates in the reflog, tracking the movement of *your local*
>    refs (like the name implies).  The HEAD reflog tracks what *you*
>    had "currently checked out" at a given time.
>
> An automated search in (b) is possible with the @{} syntax, but
> note that it tracks the *branch state*.  It says nothing about how
> "current" a certain resulting commit was.  For example, if you say
>
>   git checkout v1.6.0
>   sleep 2
>   git checkout -
>   git show '@{1 second ago}'
>
> you will see the commit for v1.6.0 from back in 2008.
>
> An automated search in (a) is hard, mostly because in nonlinear
> history there is not usually a single (and well-defined) commit
> that could be returned.

Given that we are discussing "git blame", which reports on the
history of a file (specifically the commit in which each line
originated), I think (a) must logically be included in the search
-- especially if (as in the example) the date specified is earlier
than any time in (b).  Perhaps such a request needs to use some
other syntax rather than @{}, but surely the capability ought to
be provided somehow.

> Git could attempt to search all of your branches, like you have
> done above ...

Actually, I am not at all sure that one would want --all in the
general case; it works well in my particular case because all
branches in this repository have been merged back to master.

Intuitively, I suspect that the default search set should be all
commits reachable from HEAD.  (BTW I may not have the terminology
exactly right; while I have been working with other CM systems
for a couple of decades, I am quite new to git and there is much
about it that I do not yet understand.)

> but which one among all commits from that date should it pick?

The latest one that is not later than the specified date (and time
-- a timestamp within {} can provide more granularity than just
the day; in the example provided there were in fact no commits on
2011-12-29 so no ambiguity would arise from using the date alone.)

> Furthermore, the result set to pick from will change if you
> fetch more history into your repo.

Using the "commits reachable from HEAD" strategy above, I think
not, unless I also merge from some of that additional history.

> It's even worse with the author (as opposed to committer) dates:
> those are not even remotely close to monotonic in most repos,
> because they are kept across rewriting.  (The committer dates
> would be monotonic if everyone kept their clocks in sync and
> avoided filter-branch tricks.)

Since it is the file's included commits that "git blame" reports on,
I doubt it would be all that useful to deal in anything other than
commit dates.  (I seem to have copy-pasted the wrong format in the
rev-list part of the example -- it should be "%h %ci".)

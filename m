From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Thu, 14 Jun 2012 12:05:56 +0200
Message-ID: <877gva1a4b.fsf@thomas.inf.ethz.ch>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: <perryh@pluto.rain.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 12:06:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6wH-0002Lk-JC
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 12:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab2FNKGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 06:06:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41688 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540Ab2FNKF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 06:05:59 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 14 Jun
 2012 12:05:56 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 14 Jun
 2012 12:05:56 +0200
In-Reply-To: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
	(perryh@pluto.rain.com's message of "Thu, 14 Jun 2012 08:26:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199996>

perryh@pluto.rain.com writes:

> How do I get "git blame" to operate "as of" a particular date in
> the past, without having to manually look up the corresponding
> SHA1 using "git rev-list"?  For example, I can get a report as of
> 2011-12-29 by doing something like:
>
>   $ git rev-list --all --date-order --format="%h %ai" .
>   ...
>   7c69106 2012-01-03 ...
>   b4227af 2011-12-27 ...
>   ...
>
>   $ git blame <file> b4227af
>
> but I want to have git look up the last revision prior to the given
> date, by doing something like
>
>   $ git blame <file> @{2011-12-29}

You are looking at two different dates:

a) The dates stored within the commit object:

   - committer date, similarly shown by %ci: when the commit was created.
   - author date, shown by %ai: when "this" commit was "first created".

   These are properties of the commits, and thus part of the project
   history.  Anyone who clones the project sees the same dates.

b) The dates in the reflog, tracking the movement of *your local* refs
   (like the name implies).  The HEAD reflog tracks what *you* had
   "currently checked out" at a given time.

An automated search in (b) is possible with the @{} syntax, but note
that it tracks the *branch state*.  It says nothing about how "current"
a certain resulting commit was.  For example, if you say

  git checkout v1.6.0
  sleep 2
  git checkout -
  git show '@{1 second ago}'

you will see the commit for v1.6.0 from back in 2008.

An automated search in (a) is hard, mostly because in nonlinear history
there is not usually a single (and well-defined) commit that could be
returned.  Git could attempt to search all of your branches, like you
have done above, but which one among all commits from that date should
it pick?  Furthermore, the result set to pick from will change if you
fetch more history into your repo.

It's even worse with the author (as opposed to committer) dates: those
are not even remotely close to monotonic in most repos, because they are
kept across rewriting.  (The committer dates would be monotonic if
everyone kept their clocks in sync and avoided filter-branch tricks.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

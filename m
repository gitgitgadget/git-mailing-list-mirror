From: Mike Hommey <mh@glandium.org>
Subject: Re: Is there interest in a n-sect tool?
Date: Mon, 18 Jan 2016 17:58:35 +0900
Message-ID: <20160118085835.GA15642@glandium.org>
References: <20160118075653.GA13911@glandium.org>
 <xmqq1t9fe0qw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 09:58:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL5eD-0006sN-Em
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 09:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbcARI6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 03:58:45 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:36406 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbcARI6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 03:58:44 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aL5dz-00047t-P8; Mon, 18 Jan 2016 17:58:35 +0900
Content-Disposition: inline
In-Reply-To: <xmqq1t9fe0qw.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284282>

On Mon, Jan 18, 2016 at 12:43:35AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > - I have a script that, for a given git-cinnabar commit, clones
> >   those four mercurial repositories, and determines a global state
> >   for the resulting repositories. (for example, the sha1sum of all
> >   the sha1s of the remote refs for all repositories)
> > - The script is run for the earliest commit and gives a sha1.
> > - Then I bisect run with a script wrapping the other, returning 0
> >   when the state is the same as the one for the earliest commit,
> >   or 1 otherwise.
> > - The result of that first bisection is the first state change.
> > - Then I bisect run again, using the state of the result of that first
> >   bisect instead of the earliest commit.
> > - The result of that second bisection is the second state change.
> > - And so on...
> >
> > I do, in fact, cache the states for each iteration of each bisect,
> > so that I can do some smarter decisions than just start from the last
> > bisection for the next one.
> >
> > I don't have that many state changes to track, but I do have different
> > kind of states that I want to track down, so I will be running this
> > a couple more times.
> >
> > The question is, is there sufficient interest in a generic n-sect tool
> > for me to justify spending the time to do it properly, vs. just doing
> > the minimalist thing I did to make it work for my use case.
> 
> After reading the above a few times, I still am not sure what you
> mean by n-sect (as opposed to bi-sect), especially given that you
> sounded as if you consider the straight "bisect" is about having
> only two states, bad/good, new/old, or black/white.  "Bi" in the
> word "bisect" refers to the search going by dividing the space into
> two to find state transition, and does not necessarily mean there
> are two states (hence implying a single state transition between the
> two).  If you have three states, black/gray/white, that linearly
> transitions states twice (i.e. one part of the history is
> continuously black, and at one boundary it turns gray and continues
> to be gray, until at another boundary it turns white and continues
> to be white to the other end), you would still "bi"-sect to find
> these two transition points.  You start from a black A and a white
> Z, pick a midpoint M that tests to be gray and know the transition
> point from black to gray exists somewhere between A and M, while the
> other transision point from gray to white exists somewhere between M
> and Z.  Is that the kind of search you are talking about?

Yes, it is. Somehow, I was thinking of the result once you're done
bisecting, not the process itself of cutting history in two parts.

Anyways, 

> (...)
> If that is the problem you are solving, I think you actually can
> reuse what learned in the first bisection directly when you start
> your second bisection without changing the current system.  "git
> bisect good" and "git bisect bad" takes zero or more commit object
> names to mark that commit to be good or bad (they default to HEAD if
> you do not give any), so when you start the second bisection run for
> the second variable, you can tell "git bisect good" all the commits
> that was good for the second trait you tested in the first bisect
> run you did to find the breakage for the first trait, and similarly,
> you can tell "git bisect bad" all the ones that you know are broken
> with respect to the second trait.  After that, you would do the
> straight bisection for the second trait.  If you have more than 2
> traits that are independent and you can test at once, you would be
> walking the graph painted in 8 colors, but the principle would be
> the same.  The bisection run for the third trait would take
> advantage of the knowledge you already have for many commits that
> you have visited during the two previous bisection you did for the
> first two traits.

Seems like, while you seemed to associate this paragraph with the
other interpretation, this would work in both cases. This might, in
fact, be less cumbersome than what I'm currently doing... I'll test it
for my next run, since I do need one :)

That being said, while I can do these things locally with my own
scripts, as a user, I would have found it useful if git bisect (and
especially git bisect run) would support this out of the box. The
question remains whether it would be useful to more people than
just me.

Cheers,

Mike

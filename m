From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 21:43:14 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130121024314.GA27799@thyrsus.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
 <20130120125838.GK31172@serenity.lan>
 <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
 <20130120152857.GM31172@serenity.lan>
 <7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
 <CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com>
 <CAEUsAPYdpsbhCZfp-1w91ZiyqgEa=8TNf2MJihMViqVZmW3sRw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 03:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx7Ml-0006rx-Dg
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 03:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab3AUCnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 21:43:45 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34046
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3AUCnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 21:43:45 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id B7E3144121; Sun, 20 Jan 2013 21:43:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAEUsAPYdpsbhCZfp-1w91ZiyqgEa=8TNf2MJihMViqVZmW3sRw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214076>

> > I probably won't be sending any more patches on this.  My hope was to
> > get cvsimport-3 (w/ cvsps as the engine) in a state such that one
> > could transition from the previous version seamlessly.  But the break
> > in t9605 has convinced me this is not worth the effort--even in this
> > trivial case cvsps is broken.  The fuzzing logic aggregates commits
> > into patch sets that have timestamps within a specified window and
> > otherwise matching attributes.  This aggregation causes file-level
> > commit timestamps to be lost and we are left with a single timestamp
> > for the patch set: the minimum for all contained CVS commits.  When
> > all commits have been processed, the patch sets are ordered
> > chronologically and printed.
> >
> > The problem is that is that a CVS commit is rolled into a patch set
> > regardless of whether the patch set's timestamp falls within the
> > adjacent CVS file-level commits.  Even worse, since the patch set
> > timestamp changes as subsequent commits are added (i.e., it's always
> > picking the earliest) it is potentially indeterminate at the time a
> > commit is added.  The result is that file revisions can be reordered
> > in resulting Git import (see t9605.)  I spent some time last week
> > trying to solve this but I coudln't think of anything that wasn't a
> > substantial re-work of the code.

I've lost who was who in the comment thread, but I think it is rather likely
that the above diagnosis is correct in every respect.

I won't know for certain until I finish the test suite and apply it to
all three tools (cvsps, cvs2git, cvs-fast-export) but what I've seen
of their code indicates that cvsps has the weakest changeset analysis of
the three, even after my fixes.

> > I have never used cvs2git, but I suspect Eric's efforts in making it a
> > potential backend for cvsimport are a better use of time.

Agreed.  I didn't add multiengine support to csvsimport at random or
just because Heiko Vogt was bugging me about parsecvs.  I was
half-expecting cvsps to manifest a showstopper like this - hoping it
wouldn't, but hedging against the possibility by making alternate
engines easy to plug into git-cvsimport seemed like a *really good
idea* from the beginning of my work on it.  Sometimes being that kind
of right really sucks.

While I am going to have a try at modifying cvsps to make Chris's
t9605 case work, I'm going to strictly limit the amount of time I
spend on that effort since (as you imply) it is fairly likely this
would be throwing good money after bad.

> Fixing this seemed like it would require splitting the processing out
> into a couple phases and would be a fair amount of work, but maybe I'm
> just not looking at the problem right.

Actually I think you've called it *exactly* right.  The job has to be 
done in multiple clique-spitting phases - that's why cvs2git has 7 passes
(though a few of those, perhaps as many as 3, are artifactual).

This is why the next step in my current work plan for CVS-related stuff will
be unbundling my test suite from the cvsps tree and running it to see if
cvs-fast-export dominates cvsps.  

I'm expecting that it will, in which case my plan will be to salvage
the CVS client code out of cvsps (*that* part is quite good - fast,
clean, effective) gluing it to the better analysis stage in
cvs-fast-export, and then shooting cvsps through the head and burying
it behind the barn.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

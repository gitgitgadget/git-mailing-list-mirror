From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 10:40:25 +0200
Message-ID: <20091017084025.GC5474@atjola.homenet>
References: <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <20091017075551.GA5474@atjola.homenet>
 <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 10:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz4tD-0000z6-3Q
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 10:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbZJQIk0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 04:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbZJQIk0
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 04:40:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:53383 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751244AbZJQIkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 04:40:25 -0400
Received: (qmail invoked by alias); 17 Oct 2009 08:40:28 -0000
Received: from i59F5487B.versanet.de (EHLO atjola.homenet) [89.245.72.123]
  by mail.gmx.net (mp049) with SMTP; 17 Oct 2009 10:40:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18KWN12C9QKRJjWp3BhfjT8TyZxqXlDVaU6K7ukSw
	gZ9wLD3lYww9mp
Content-Disposition: inline
In-Reply-To: <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130552>

On 2009.10.17 01:11:23 -0700, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > ... If so, it does a "git checkout --merge
> > <upstream>" (possibly leaving conflicts for the uncommitted changes=
,
> > just like "svn update").
>=20
> Up to this point I was reading with quite a lot of interest.  But her=
e I
> strongly disagree to the point of getting actually disgusted.
>=20
> "svn up" is one of the areas Subversion folks failed to make their sy=
stem
> a better CVS.  It has the same "local changes are lost in the merge
> conflict mess in an irreversible way" failure mode, and we shouldn't =
be
> making it easy to new people.  It is not something we should emulate.
>=20
> You can and should instead refuse the update, and suggest committing =
first
> so that the user has a safe record of what he has done and the merge =
with
> upstream can be retried if necessary.  As you need to have that "refu=
se
> but guide the lost soul by telling what to do" mode anyway when...

Hm, probably I (mentally) focussed to much on "people that just want to
look" and didn't really think that they'd have much to lose. Not sure.
Over the time, I got so used to do "git checkout --merge <something>"
with some I-don't-care-much debugging or whatever change, that I lost
track of how bad that was with svn. If I have just I care about, I
commit, and then "git update" would no longer be an option anyway. But
yeah, not a good option to give to the uninitiated user...

Interestingly, I irregularly give advice to use "git stash; git
checkout; git stash apply" instead of "git checkout -m" on #git, as tha=
t
allows you to try again if you messed up the conflict resolution, and
even allows you to completely go back to the initial state. Maybe that
would be an option? But I fail to come up with a convenient and at the
same time error safe way for such a "stash wrap". The only thing that
comes to mind would be to have "git update" completely wrapping the
thing:

git update
 - Stashes uncommitted changes
 - fetches
 - checks out
 - "stash apply --index", if that fails, just "stash apply"

If there are conflicts, show options (similar to what rebase does):

git update --retry # Start over
 - reset --hard
 - "stash apply --index", if that fails, just "stash apply"

git update --abort
 - git reset --hard HEAD@{1}
 - "stash apply --index"
 - "stash drop stash@{0}"

git update --done
 - Check whether there are still unmerged files, if so: complain
 - otherwise: "stash drop stash@{0}"


OTOH, it might be easier to just tell the user to do the stash thing
himself. But I wonder how many users would really know how to get back
to the initial state then.

Bj=F6rn

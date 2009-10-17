From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 21:41:53 +0200
Message-ID: <20091017194153.GA30003@atjola.homenet>
References: <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <20091017075551.GA5474@atjola.homenet>
 <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
 <20091017084025.GC5474@atjola.homenet>
 <7vaazqcry5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 21:43:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzFBD-00084V-Ig
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 21:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbZJQTl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 15:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZJQTl4
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 15:41:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:33655 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751726AbZJQTlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 15:41:55 -0400
Received: (qmail invoked by alias); 17 Oct 2009 19:41:58 -0000
Received: from i59F5B216.versanet.de (EHLO atjola.homenet) [89.245.178.22]
  by mail.gmx.net (mp036) with SMTP; 17 Oct 2009 21:41:58 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX181uoQqHco1aqChgk7Izkh0RDmkXL0vB0ksv7Q/ey
	D27amzRlotCeT9
Content-Disposition: inline
In-Reply-To: <7vaazqcry5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130575>

On 2009.10.17 02:04:02 -0700, Junio C Hamano wrote:
> The "save" part of the work-save-then-merge sequence should be made v=
ery
> visible to help people get used to the "not up, but work-save-then-me=
rge"
> mental model.  I do not think it would help people in the long run to=
 make
> the "save" step less visible by wrapping the sequence into an unrelia=
ble
> "up" script, especially because the script would sometimes work but o=
ther
> times *has to* force users to know that what is happening behind the =
scene
> is work-save-then-merge in order to resolve and recover from conflict=
s
> anyway.

Hm, which cases would that be? I basically see three cases:

 1) No uncommitted changes =3D> No problem
 2) Uncommitted changes merge cleanly =3D> No problem
 3) Uncommitted changes causes conflicts =3D>
   - User can resolve
   - User can start over (git update --retry)
   - User can give up (git update --abort)

Of course the user can clearly see that some state was saved (otherwise
you couldn't retry or abort), but I don't see how the user is "forced"
in any way, he just gets those two commands to work with (which
internally just wrap reset + stash apply, making things more
convenient).

I do see problems with a "stash around merge" thing ("stash" around
rebase seems easier, as that could just create a commit and reset later=
,
but I'm not exactly sure that such smartness is a good idea). As soon a=
s
the merge has conflicts, you need to know that you have to unstash afte=
r
committing the merge, but what I have in mind is fast-forward only (or
possibly reset, when upstream was rewritten).  Primarily for users that
don't commit at all, but just look at things [*1*]. And also for the
semi-detached HEAD case, in which you may not commit and in which doing
a merge/rebase is therefore not an option, but git still knows what to
fetch/checkout by using the discussed extra info in HEAD, or by
examining the reflog.

> > OTOH, it might be easier to just tell the user to do the stash thin=
g
> > himself. But I wonder how many users would really know how to get b=
ack
> > to the initial state then.
>=20
> I agree with the first sentence, but I do not understand what "the in=
itial
> state" you talk about here in the second sentence, sorry.

The state they were in before they did the "git stash" part.

*work on stuff not ready to be committed*
git pull # refused
git stash
git pull
git stash apply # Conflicts, user decides that he wants go back

At that point, you need the reflog (also handle fast-forwards), and do:

git reset --hard HEAD@{1}
git stash apply --index


Of course, a more correct way might be to use commit and rebase instead=
:

*work on stuff not ready to be committed*
git pull # refused
git add -A # Or whatever
git commit
git pull --rebase # conflicts, decide to abort
git rebase --abort
git reset HEAD^

But that still needs the extra "reset HEAD^" step to really get back to
the state with your uncommitted changes.

The problem with "svn up" is that there's no other way, and no way back=
=2E
Git has other ways, but no convenient one for non-committers and no
"obvious" way to go back, should you decide that you actually prefer no=
t
to update after seeing the conflicts.

Anyway, this isn't _my_ itch and to some (large) degree I'm trying to
guess what someone else would expect. If at all, I'm more interested in
a command that figures out which remote tracking branch I checked out,
and that updates it, and updates my work tree/index as well. Uncommitte=
d
changes aren't important to me there. So I'll simply give up on that
part.

Bj=F6rn


[*1*] One could also say: Users that don't give a damn about git, but
just need it to get the code and maybe have some minor, uncommitted
modifications on top. I'm _not_ thinking about users that actually
commit and do stuff. Those should use merge/rebase/pull, and get a
complaint from "git update" if the update is not a fast-forward one,
telling them what to use instead.

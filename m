From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 07:03:12 +0200
Message-ID: <20091016050312.GB9233@atjola.homenet>
References: <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
 <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
 <885649360910151647v27a15334x63fe3b6f5035dbd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 07:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myf3A-0005Xi-30
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 07:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZJPFEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 01:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZJPFED
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 01:04:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:53291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752125AbZJPFEC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 01:04:02 -0400
Received: (qmail invoked by alias); 16 Oct 2009 05:03:14 -0000
Received: from i59F5472B.versanet.de (EHLO atjola.homenet) [89.245.71.43]
  by mail.gmx.net (mp058) with SMTP; 16 Oct 2009 07:03:14 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/47UdHGV34fdGJlNtTatJwKjtNYpFlkp+uB0GnHp
	u4n1lKFCK2JUzN
Content-Disposition: inline
In-Reply-To: <885649360910151647v27a15334x63fe3b6f5035dbd2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130454>

On 2009.10.15 16:47:57 -0700, James Pickens wrote:
> On Thu, Oct 15, 2009 at 3:08 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>     $ git checkout origin/next ;# ditto
> >>     $ git symbolic-ref HEAD
> >>     refs/remotes/origin/next
> >
> > Ok, after reading Daniel's message to remind us that "git fetch" af=
ter
> > this will get us into trouble, I agree that detaching HEAD is inevi=
table.
>=20
> Some people liked the idea, so let's not give up just yet.  Here are =
a few
> things Git could do when a fetch wants to update the currently checke=
d out
> branch:
>=20
> 1. Refuse the fetch.
> 2. Update the ref, leaving the user with a work tree and index that d=
on't
>    match their HEAD.
> 3. Detach the HEAD, then update the ref.
> 4. Update the ref, then check it out.
>=20
> Option 1 is ok, as long as the "next step" is not too complicated.  I=
t's no
> good if the user has to checkout a different branch, then fetch, then
> checkout the original branch again.

Not good. It makes "git fetch; git log ..origin/foo" impossible. And
that's IMHO a very useful thing for people that just want to follow
things and look at what happens.

> Option 2 is crap.

Agreed.

> Option 3 seems reasonable, but it might be just as scary/confusing to
> newbies as the current behavior, so I don't think it should be the de=
fault.

Doesn't seem very good to me. The idea was to stop people from
accidently getting on a detached HEAD, if common operations like "fetch=
"
now suddenly detach HEAD, that's _worse_ than before. And for a
single-branch remote, even "git pull" may detach HEAD then:

git init;
git remote add -f -t master origin git://...
git checkout origin/master
*wait*
git pull # Will work, as the fetch refspec is not a glob

But that "pull" does:
git fetch origin refs/heads/master:refs/remotes/origin/master

Which detaches HEAD before merging/fast-forwarding.

Bad.

And seeing that the requests for "clone just a single branch" seem to
increase in #git, I guess that such non-globbing refspecs for
remote.origin.fetch might become more common in the future.

> Option 4 also seems reasonable, but you run into problems if the user=
 had
> changed the index or work tree.  In that case Git could do 'checkout
> --merge' automatically.  This option is also less "pure" since it let=
s 'git
> fetch' modify the index and work tree.

Same as for option 1, it kills "git fetch; git log ..origin/foo". And
that would basically turn "fetch" into a hypothetical "pull --reset".
That's IMHO better done in a separate command.

> So how about this:
> * 'git fetch' refuses the fetch by default.
> * 'git fetch --detach' detaches HEAD, then updates the ref
> * 'git pull' detaches HEAD, updates the ref, then checks out the new =
ref
>   with --merge.

"fetch --detach" doesn't feel right to me. Wrong class of commands to
have such an option. And I'm not sure about adding a third mode to
"pull" (besides "merge" and "rebase") that only triggers for special
cases. Again, I'd prefer a separate command.

If we store "where did I come from" instead of just "where am I" in HEA=
D
when detached, those problems don't seem to show up (but just storing
that information correctly seems hard enough, see the other mail I wrot=
e
a few minutes ago).

"git fetch" just updates the remote tracking branch, you stay at where
you are, "git log ..origin/foo" keeps working. It could give a special
hint that you might want to use "git checkout origin/foo" or "git
new-command" to update your working tree to the newest version, when
your working tree is based upon an old version of that remote tracking
branch.

And "git pull" might perform a fast-forward automatically (figuring out
the right remote from the extra info in HEAD), but refuse to do merges
(if upstream has been rewritten), pointing the user to "git checkout" o=
r
"git new-command". (Interestingly, "pull --rebase" wouldn't suffer from
such history rewriting, as it looks at the reflog for the remote
tracking branch, but I guess a working "git pull --rebase" while "git
pull" fails is bound to cause major user confusion).

"git new-command" could act like "svn up", doing a fetch and a
"checkout --merge <remote_tracking_branch>" to just get the user
up-to-date keeping local uncommitted modifications. I can't tell why,
but my feeling is that this should be a new command, and not part of
pull, as said above.

Bj=F6rn

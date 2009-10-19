From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Mon, 19 Oct 2009 10:44:07 +0200
Message-ID: <20091019084407.GA2796@atjola.homenet>
References: <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <20091017075551.GA5474@atjola.homenet>
 <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
 <20091017084025.GC5474@atjola.homenet>
 <7vaazqcry5.fsf@alter.siamese.dyndns.org>
 <20091017194153.GA30003@atjola.homenet>
 <7vws2snwum.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mznqp-0005Q2-N9
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbZJSIoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 04:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZJSIoM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:44:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:50366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750821AbZJSIoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:44:11 -0400
Received: (qmail invoked by alias); 19 Oct 2009 08:44:12 -0000
Received: from i59F5B861.versanet.de (EHLO atjola.homenet) [89.245.184.97]
  by mail.gmx.net (mp040) with SMTP; 19 Oct 2009 10:44:12 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+hArtbazGhOrwEYuVJDahmWDwOI4r3JbM2JRLbAR
	Pjc7lJCBudKqcX
Content-Disposition: inline
In-Reply-To: <7vws2snwum.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130679>

On 2009.10.18 15:47:13 -0700, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> > On 2009.10.17 02:04:02 -0700, Junio C Hamano wrote:
> >  1) No uncommitted changes =3D> No problem
> >  2) Uncommitted changes merge cleanly =3D> No problem
> >  3) Uncommitted changes causes conflicts =3D>
> >    - User can resolve
> >    - User can start over (git update --retry)
> >    - User can give up (git update --abort)
>=20
> By "--abort", if you meant to discard the local change, that is only
> suitable for people who would say "what I was doing was minor anyway,=
 and
> I'll redo them based on the updated upstream", and may not be so usef=
ul, I
> think.  The user may want to pretend that he did not even start "upda=
te"
> (i.e. not pulled while he was still working on something) at this poi=
nt,
> and if you meant by "give up" (aka --abort) to "reset --hard @{1} &&
> unstash", I think it makes quite a lot of sense.  Then the user has a=
n
> option to fork a topic at that point:
>=20
>     git update --abort
>     git checkout -b topic
>     work on more with committing
>     git checkout master
>     git update

Yes, I meant the latter. The former would just be "git reset --hard" an=
d
is pointless to be rewrapped in "git update --abort". Maybe "abort" is
the wrong word there? I'm not a native speaker and basically took that
from "git rebase", which returns you to your (unchanged) branch head,
i.e. the state you were in before you started the rebase.

> But then this starts to look more like an enhanced failure recovery m=
ode
> for "git pull" command.

Yeah, I notice that, also while working on my "proof-of-concept"
implementation. Currently, I simply suggest "git pull" to the user when
the update is not a fast-forward one.

I'm probably influenced by a latent hatred for "git pull"... Explaining
that it is fetch+merge/rebase and uses defaults from the config which
are automagically setup is probably something my fingers can do on
their own by now. Confusion about "git pull" probably beats
misunderstandings about HEAD.

If it wasn't so inconvenient for people that actually commit, I'd even
dare to suggest:

git update
 - FF update only, using branch.<name>.{remote,merge}
 - suggests "git update --merge" or "git update --rebase" if non-ff

git update --merge
 - Does a merge

git update --rebase
 - Does a rebase

And "git pull" would stop using branch.<name>.{remote,merge} and requir=
e
command line arguments.

That would at least raise awareness that "git update --merge" is doing =
a
merge, unlike "git pull", which many new users simply treat as magic,
not realizing what actually happens (and thus they create butt-ugly
criss-cross merge histories). Of course, I can't tell whether being
aware that a merge happens actually makes the user realize that they
shouldn't update/pull/merge 50 times a day.

But passing --merge all the time seems just too inconvenient. And havin=
g
a config option to make --merge or --rebase the default would probably
end up with --merge as the "default default", ultimately turning "git
update" into "git pull".

Anyway, I'm probably getting quite far off the track here.

> In addition, I think that you would internally implement the "save" s=
tep
> with "stash" (which would be a sane thing to do), but then you would =
need
> to worry about the case where the user was in the middle of a merge (=
or
> "revert", "cherry-pick", "checkout -m") that did not complete.  "git =
pull"
> fails upfront, says why and tells users what to do.  "git update" sho=
uld
> do the same.

Yup, got the same check in my PoC

> > I do see problems with a "stash around merge" thing ("stash" around
> > rebase seems easier, as that could just create a commit and reset l=
ater,
> > but I'm not exactly sure that such smartness is a good idea). As so=
on as
> > the merge has conflicts, you need to know that you have to unstash =
after
> > committing the merge, but what I have in mind is fast-forward only =
(or
> > possibly reset, when upstream was rewritten).  Primarily for users =
that
> > don't commit at all, but just look at things [*1*].
>=20
> Ok.  If you have a clean way to guarantee that "update" users won't
> commit, I think the above would sort of make sense and my earlier wor=
ries
> about (1) a user who wish he did not fetch and (2) a user who was doi=
ng
> something more complex and had conflicts already would go away.

Currently it's just:
test -z "$(git rev-list -1 $upstream..)"

As a "is a fast-forward" check, suggesting the user to use "git pull"
instead of "git update", if it is not. Maybe I should use "git
merge-base" there instead? Is that better? Not sure whether history
simplication might break the rev-list based test...

> If the sole target audience is "minor changes only, never committing"
> people, then I would even rescind my earlier suggestion on --abort; i=
t
> should mean "remove the minor changes and get pristine copy of the
> upstream---the user will redo the minor changes to adjust to the upda=
ted
> upstream from scratch", to keep the end user experience simpler and
> clearer.

Hmhm... If the user can't resolve the conflict, but still keep those
changes, he might want to ask someone else for help. And then he might
want to present his changes to that other person, so I think allowing
the user to go back to the old commit with his changes on top is better=
=2E
Maybe "git update --drop" could do the "drop the user's changes", if th=
e
user wants to do so. No support for going back is what's bad about "svn
update" (and, I guess, "git checkout --merge").

> I am undecided if it is a good thing to divide the userbase into two
> classes, "update" people and "work-commit-fetch-merge-resolve" people=
=2E

I expect that there are already two userbases. Developers in one
userbase and users that just want the latest code in the other. And
these users might have some uncommitted stuff (either self-made or
possibly found somewhere, or maybe a bit of both).

I just wonder what's easier/better: to cater to each one or trying to
unify them by trying to educate the one that actually doesn't care.

Bj=F6rn

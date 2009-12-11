From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Fri, 11 Dec 2009 12:07:20 +0100
Message-ID: <20091211110720.GA19232@atjola.homenet>
References: <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet>
 <m2pr6ocqrb.fsf@igel.home>
 <20091209120610.GA29430@atjola.homenet>
 <20091209120748.GI2977@redhat.com>
 <20091209130653.GA30218@atjola.homenet>
 <7v1vj4orra.fsf@alter.siamese.dyndns.org>
 <20091210074358.GA7723@atjola.homenet>
 <7vpr6mkaoz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 12:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ3LQ-0007Ur-6W
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 12:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761044AbZLKLHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 06:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756803AbZLKLHU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 06:07:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:51432 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756762AbZLKLHT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 06:07:19 -0500
Received: (qmail invoked by alias); 11 Dec 2009 11:07:24 -0000
Received: from i59F564AD.versanet.de (EHLO atjola.homenet) [89.245.100.173]
  by mail.gmx.net (mp047) with SMTP; 11 Dec 2009 12:07:24 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+36dAju7G3WbuBHi9olzWikw2XfaLys7cRG3V1Tm
	T+EkjkpWMUlw6r
Content-Disposition: inline
In-Reply-To: <7vpr6mkaoz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135078>

On 2009.12.10 09:20:28 -0800, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> >> But at the conceptual level, "merge --squash" is a short-hand for =
this
> >> command sequence:
> >>=20
> >>     git rebase -i HEAD that-branch
> >>     ... make everything except the first one into "squash"
> >>     git checkout - ;# come back to the original branch
> >>     git merge that-branch ;# fast forward to it
> >>=20
> >> So after all, it is "merge it after squashing them".
> >
> > To me, that approach looks backwards,...
>=20
> Yes, of course, but what you are missing (and I am at blame for forge=
tting
> to mention the history behind this in the message you are responding =
to)
> is that "merge --squash" to support a particular need/use case was do=
ne
> way before "rebase -i" came into existence.

Hm? You started explaining that "merge --squash" would be right because
you can do it via some command sequence that involves rebase -i and the=
n
merge. I said that using that rebase+merge sequence as an argument for
the choice of the name is wrong. It would even have made more sense to
me if you said:

git merge that-branch
git reset --soft HEAD^
git commit -C ORIG_HEAD

Which is "merge, but then drop the extra parents", which pretty close t=
o
what "merge --squash" does (and that sequence even gets it right not to
rewrite that-branch).

I'm not arguing that you shouldn't have chosen "merge --squash" to do
that. You couldn't possibly foresee the future and that git might get
rebase -i or maybe at some day cherry-pick -i <range>. I'm just saying
that in retrospective, it's sad that merge doesn't always mean "merge
histories", but that --squash makes it degenerate to "merge changes".

I don't see why you're trying to defend the choice of "merge --squash"
using a IMHO rather weird command sequence that happens to involve
"merge", using commands that weren't present when "merge --squash" was
added, but at the same ignore the "cherry-pick -i <range>" command git
might learn in the near future, which allows for a much saner
explanation:

git cherry-pick -i ..that-branch
=2E.. make everything except the first one into "squash"

And given that, one could add a --squash flag to cherry-pick that makes
it do the "squash everything" itself, allowing it to be a bit smarter
about the whole thing, because it could use a three-way merge
internally, instead of cherry-picking all the individual commits. Makin=
g
"git cherry-pick --squash ..that-branch" the same as "git merge --squas=
h
that-branch".

> A nicer workflow may be to use "rebase -i" to clean up the history be=
fore
> even contemplating to integrate the topic to the mainline, instead of=
 the
> above "abandoning or forking off again", if you know today's git. =20

Well, I'm not saying that git should completely lose the abilitiy to do
something like "merge --squash", just that if it learns "git cherry-pic=
k
<range>", it might as well get the --squash thing for cherry-pick, mayb=
e
allowing for "merge --squash" to be phased out. And heck, having it as
an option to cherry-pick instead of merge would probably already help a
lot to make people realise that it won't remember that the changes got
"integrated". We've had people on #git that wondered why repeated "git
merge --squash" commands would try to merge the same stuff over and ove=
r
again, leading to the same conflicts every time. Because they didn't
realise that with --squash, "git merge" is no longer about merging
histories.

> But interactive was not available back then.  It was introduced at 1b=
1dce4
> (Teach rebase an interactive mode, 2007-06-25), which is 1 year after
> 7d0c688 (git-merge --squash, 2006-06-23).

Again, I'm not blaming you for having chosen that command back then.
Just saying that it might be better to have the same functionality in a=
n
extended cherry-pick now.

Bj=F6rn

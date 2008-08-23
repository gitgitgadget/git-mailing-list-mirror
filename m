From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: nicer frontend to get rebased tree?
Date: Sun, 24 Aug 2008 00:13:24 +0200
Message-ID: <20080823221324.GA18472@atjola.homenet>
References: <20080822174655.GP23334@one.firstfloor.org> <m37ia8sv49.fsf@localhost.localdomain> <20080823071552.GU23334@one.firstfloor.org> <200808231121.41694.jnareb@gmail.com> <20080823165350.GY23334@one.firstfloor.org> <4d8e3fd30808231404y7293eb56g4fbed5565ab2aa9a@mail.gmail.com> <alpine.LFD.1.10.0808231440530.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Andi Kleen <andi@firstfloor.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 00:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX1NR-0006wb-AM
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 00:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbYHWWN3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbYHWWN3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 18:13:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:48865 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751522AbYHWWN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 18:13:29 -0400
Received: (qmail invoked by alias); 23 Aug 2008 22:13:26 -0000
Received: from i577BB1D4.versanet.de (EHLO atjola.local) [87.123.177.212]
  by mail.gmx.net (mp005) with SMTP; 24 Aug 2008 00:13:26 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+7/itVnTW70nv5YX0Bu3TcocPraBP8eqi5fBG7LA
	5wA5CxrMCEhjs6
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808231440530.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93496>

On 2008.08.23 14:52:37 -0700, Linus Torvalds wrote:
> On Sat, 23 Aug 2008, Paolo Ciarrocchi wrote:
> >
> > you got nice and detailed answers,  for example you can track a
> > rebased tree in your working directory using git pull --rebase.
> > What's wrong with that?
>=20
> No, you really really cannot do that.
>=20
> If the _tree_ you are tracking is itself rebasing (not just your own=20
> tree), then you cannot and absolutely SHOULD NOT use rebase (not dire=
ctly,=20
> and not with "git pull --rebase".
>=20
> Why?
>=20
> Let's look at what happens. Let's say that your history looks like
>=20
> 	... -> A -> B -> C -> a -> b -> c
>=20
> where the upper-case letters are from the tree you track, and the=20
> lower-case letters are the commits you added yourself.
>=20
> Now, let's say that the tree you track gets rebased, and in the proce=
ss=20
> 'B' is removed (because it turns out it was buggy), and A and C get=20
> modified. What happens?
>=20
> You now have
>=20
> 	... -> A -> B -> C -> a -> b -> c     <- your branch
> 	  \
> 	    other stuff -> A' -> C'     <- newly rebased branch
>=20
> (where "other stuff" is whatever the remote branch was rebased on top=
=20
> of) and when you now try to rebase your stuff on top of the newly reb=
ased=20
> branch, you are going to end up trying to rebase all the _old_ commit=
s=20
> that weren't even yours (ie it's going to try to rebase A, B and C to=
o!)

But before the fetch step, you have remote/branch point to your old
upstream. If "pull --rebase" remembers that and uses:

git rebase --onto remote/branch $old_upstream

That should work. And in fact, it actually seems to do that.

	exec git-rebase $strategy_args --onto $merge_head \
	${oldremoteref:-$merge_head}

With $oldremoteref being the remote tracking branch before the rebase.

That said, it seems very fragile. One "git fetch" and your upstream is
lost and the next "pull --rebase" will fail.

So a somewhat less fragile way to do it would be:

git checkout -b foo origin/foo
git branch foo-upstream
=2E...
git fetch origin
git rebase --onto origin/foo foo-upstream
git branch -f foo-upstream origin/foo

So that you always have the current upstream for your branch available
and can thus do a correct rebase. That at least doesn't break on its
own, but still does when you forget to adjust your upstream reference.

I don't actually like the idea, but maybe a refs/upstreams namespace
could be used by some script to keep track of the current upstreams of
local branches and to help with such a workflow, if one really badly
wants to do that... *hides*

Bj=F6rn

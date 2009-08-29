From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How does git follow branch history across a merge commit?
Date: Sat, 29 Aug 2009 02:25:59 +0200
Message-ID: <20090829002559.GA32479@atjola.homenet>
References: <8363c75zug.fsf@torus.sehlabs.com>
 <7vskfbcy9n.fsf@alter.siamese.dyndns.org>
 <7vmy5jbjkr.fsf@alter.siamese.dyndns.org>
 <831vmv5wh7.fsf@torus.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 02:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhBln-0001dN-03
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 02:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbZH2A0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 20:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbZH2A0E
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 20:26:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:60782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751274AbZH2A0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 20:26:03 -0400
Received: (qmail invoked by alias); 29 Aug 2009 00:26:03 -0000
Received: from i59F56DEE.versanet.de (EHLO atjola.homenet) [89.245.109.238]
  by mail.gmx.net (mp040) with SMTP; 29 Aug 2009 02:26:03 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/c5xR6diLcR8CB4TOc9ryRHJYn6+wbRQstH+5vqx
	FJcSXP/6I1qG7E
Content-Disposition: inline
In-Reply-To: <831vmv5wh7.fsf@torus.sehlabs.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127367>

On 2009.08.28 19:50:44 -0400, Steven E. Harris wrote:
> I missed the point that merge commits are not "predecessor neutral";
> they apparently have a bias indicating "/this branch/ received conten=
t
> from /that branch/ (or /those branches/)".
>=20
> To try to recreate my confusing scenario, I tried this:
>=20
> ,----
> | git checkout competition
> | git merge master
> | # This fast-forwarded "competition" be equivalent to "master".
> | git checkout 'HEAD^'
> | # This wound up again at "master"'s predecessor, not "competition"'=
s.
> `----
>=20
> It seems that since fast-forward merges don't produce a commit, the
> merge record remains in place recording that branch "competition" cam=
e
> into branch "master".Even though we're checked out to branch
> "competition" here, following its history back in time requires some
> manual intervention. Do you concur, or is my example perhaps flawed?

As there is no merge commit, there's no "merge record" either.
"competition" just got updated to reference the same commit as "master"=
=2E
Branch "competition" did not "come into" branch "master" either.
"competition" and "master" are just the names of the branch heads. And
those just reference commits, which actually form the history and have
no record of belonging to any branch head on their own.

IOW: "master" and "competition" aren't branches as in "a series of
commits with a fixed relation to each other", but just branch heads,
referencing the tips where the branches grow.

Scenario A:

Given this history:

A---B---C (master)
 \
  D---E (competition)

If you now merge "master" to "competition" you get:

A---B---C (master)
 \       \
  D---E---M (competition)

Where M is a merge commit with two parents, E being the first one, C
being the second one. And that's everything that git knows, that M is a
merged of C and E. That E is the first parent is just a smart choice,
nothing else.


Scenario B:

Given this history:

A (competition)
 \
  B---C (master)

If you ask git to merge "master" to "competition", it will see that
there aren't any commits reachable through "competition" that aren't
reachable through "master". So simply fast-forwarding "competition won'=
t
make you lose anything. Thus you get:

A---B---C (master) (competition)

There's no trace of any merge, because it wasn't required. You can't
even tell that a fast-forward happened from that history. You could as
well just have created "competition".


That said, if you want to force a merge commit (which can sometimes be
useful), you can use the --no-ff flag:

git checkout competition
git merge --no-ff master

And this leads to:

A------M (competition)
 \    /
  B---C (master)


With M's first parent being A, and the second parent being C.

(Assuming that "competition" is a topic branch, this would be a bit
weird though, as you produce a totally pointless merge commit, before
you even started working on your topic branch. OTOH doing this the othe=
r way
around, i.e. forcing a merge commit when you merge a topic branch to
"master" _can_ be useful. Don't over do it though).

HTH
Bj=F6rn

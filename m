From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multi-headed branches (hydra? :)) for basic patch calculus
Date: Mon, 03 Apr 2006 06:10:33 +0200
Organization: At home
Message-ID: <e0q77o$9v5$1@sea.gmane.org>
References: <1143950852.21233.23.camel@localhost.localdomain> <e0ns59$uq2$1@sea.gmane.org> <44305B1F.7030509@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Apr 03 06:10:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGP2-0006h5-E5
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWDCEKl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Apr 2006 00:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWDCEKl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:10:41 -0400
Received: from main.gmane.org ([80.91.229.2]:25472 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932295AbWDCEKl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 00:10:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FQGOk-0006fv-Jl
	for git@vger.kernel.org; Mon, 03 Apr 2006 06:10:38 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 06:10:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 06:10:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18306>

Sam Vilain wrote:

> Jakub Narebski wrote:

>>Wouldn't it be better to somehow represent rather partial ordering be=
tween
>>commits in history, to have something from Darcs in GIT?  Although I'=
m not
>>sure about efficiency, and if we should do detect commits dependency =
-- or
>>in other words partial ordering of commits/patches -- at commit or at
>>merge.
>>
>=20
> That is more or less what I proposed, except that the ordering is bui=
lt
> at commit time to pick a best head rather than when you try to pull t=
he
> patch, which seems a trivial difference at best.
>=20
> I think git-commit --hydra is called for.
>=20
> First we define a "hydra leash", I can think of two definitions:
>=20
>  - a hydra leash is a specially marked commit
>  - a hydra leash is a commit that has multiple parents, and is
>    the result of just an index merge of its parents
>=20
> We must also define the concept of a commit being "against" the head(=
s)
> of a hydra.
>=20
> With that term in mind, we can make "git commit --hydra" do as follow=
s:
>=20
>  a) find the head(s) of the hydra that the commit is against;
>  b) apply the commit, and set its parents to those head(s)
>  c) put the hydra leash back on.

Let's reiterate to check if I understand that:

You've got a sequence of changes like this:

1. add foo.c
2. add bar.c
3. modify foo.c
4. modify bar.c
5. modify foo.c again

You want patch/commit dependency, which is partial ordering of
patches/commits/trees:

=C2=A0=C2=A01=C2=A0->=C2=A03=C2=A0->=C2=A05
=C2=A0=C2=A02=C2=A0->=C2=A04

be represented as

=C2=A0=C2=A01=C2=A0->=C2=A03=C2=A0->=C2=A05=C2=A0\
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0>-=C2=A0head
=C2=A0=C2=A02=C2=A0->=C2=A04=C2=A0-----/


=46irst, to clean up my error, head is not a commit. Head is floating p=
ointer
to the top commit (something like "last" pointer in the list, except we
don't have list but directed acyclic graph). Getting head means getting=
 the
tree corresponding to that commit.

Your hydra is a set of pointers to top commit. Getting hydra means gett=
ing
the tree which is trivial merge of top commits (no conflicts!). Ordinar=
y
head is just hydra with one top commit.

Do I understand that hydra is constructed *at commit*?


Second, to repeat my patches vs. trees arguments. In GIT now if one get=
s
(4), one would get tree with files foo.c and bar.c added, both modified=
=2E
With hydra, and with the arrows meaning that one commit is parent of th=
e
other (unless you modify commit structure too), one would get tree with
only file bar.c added, and modified.

BTW, the arrows should be in other direction to show how commits refers=
 to
toher commits.


Third, let us consider different possible "git-commit --hydra" in above
hydra [head] sitiation:

a.) 6. modify bar.c dependent on 4

=C2=A0=C2=A01=C2=A0->=C2=A03=C2=A0->=C2=A05=C2=A0\
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0>-=C2=A0head/hydra
=C2=A0=C2=A02=C2=A0->=C2=A04=C2=A0-> 6 /

b.) 6. modify foo.c independently of 5, depends on changes in 3:=20
it is getting complicated.

  1=C2=A0->=C2=A03=C2=A0->=C2=A05=C2=A0--\
        \        \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0->=C2=A06=C2=A0--=
-->-=C2=A0head
                 /
=C2=A0=C2=A02=C2=A0->=C2=A04=C2=A0-------/

c.) 6. moves some content from foo.c to bar.c, thus depending (at least=
) on
both 3 (let's assume that independently 5) and on 4. How to represent t=
hat
without modyfying commit structure (and not only head structure)? If we=
 use
multiple commits as parents for 6, how do we distinguish between 6 bein=
g
merge commit of commits 3 and 4, and 6 depending on commits 3 and 4?

  1=C2=A0->=C2=A03=C2=A0->=C2=A05=C2=A0--\
        \        \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(?) ->=C2=A06=C2=A0---->-=C2=A0head
        /        /
=C2=A0=C2=A02=C2=A0->=C2=A04=C2=A0-------/


=46ourth, the fact that commits do not generate conflicts doesn't mean =
that
they are independent. Let's assume that we are introducing new function=
 for
example. If we change first header file foo.h, *commit* that change (no=
t
the best practice/workflow, I know) resulting in commit (1), then chang=
e
file foo.c resulting in commit (2), then commits (1) and (2) are
independent in the sense of commits, and so would say the tool which
detects dependencies (partial ordering). But actually commits (1) and (=
2)
depends on each other, and commiting both one after another to the same
branch says so now.


=46or more comments I would need to read theory of patches in more deta=
il
first.

I hope that all the above makes sense...
--=20
Jakub Narebski
Warsaw, Poland

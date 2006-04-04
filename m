From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 02:51:03 +0200
Organization: At home
Message-ID: <e0sfti$1nb$1@sea.gmane.org>
References: <4430D352.4010707@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Apr 04 02:51:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQZlX-0008Ls-P6
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 02:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWDDAvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Apr 2006 20:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWDDAvX
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 20:51:23 -0400
Received: from main.gmane.org ([80.91.229.2]:38276 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964930AbWDDAvW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 20:51:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FQZlJ-0008J6-Cu
	for git@vger.kernel.org; Tue, 04 Apr 2006 02:51:13 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 02:51:13 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 02:51:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18365>

Sam Vilain wrote:

>=C2=A0The=C2=A0IRC=C2=A0log:
>=C2=A0
>=C2=A017:45=C2=A0<=C2=A0mugwump>=C2=A0the=C2=A0other=C2=A0suggestions=C2=
=A0look=C2=A0quite=C2=A0good.=C2=A0=C2=A0I=C2=A0don't=C2=A0know
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0how=C2=A0I=C2=A0got=C2=A0roped=C2=A0=
into=C2=A0spending=C2=A0a=C2=A0whole=C2=A0day=C2=A0on=C2=A0this=C2=A0:)
>=C2=A017:46=C2=A0<=C2=A0mugwump>=C2=A0oh=C2=A0yeah,=C2=A0I=C2=A0rememb=
er=C2=A0now.=C2=A0=C2=A0somebody=C2=A0asked=C2=A0for=C2=A0a
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0comparison=C2=A0between=C2=A0darcs=C2=
=A0and=C2=A0git
>=C2=A017:46=C2=A0=C2=A0*=C2=A0ShadeHawk=C2=A0whistles=C2=A0innocently

Let me describe in my own words results of IRC discussion and posts on =
Git
Mailing List, both in this thread and in "Multi-headed branches (hydra?=
 :))
for basic patch calculus" one
  http://permalink.gmane.org/gmane.comp.version-control.git/18258
and Sam Vilain work (prototype). It might help with understanding Sam's
work; and I hope Sam would correct me if I'm wrong.

It started I think as a way to describe (represent, save) in core GIT t=
he
partial ordering of patches (commits) by dependence Darcs uses in it's
patch algebra theory {i.e. patch1 <- patch2 if patch2 depends on patch1
(patches does not commute)} at *commit time*.

> Say you've got a sequence of changes like this:
>=20
> 1. add foo.c
> 2. add bar.c
> 3. modify foo.c
> 4. modify bar.c
>=20
> The darcs-like operation of this would be to have two sequences of
> ordered patches that combine to a final result.=C2=A0=C2=A0ie:
>=20
> =C2=A0=C2=A01=C2=A0<-=C2=A03
> =C2=A0=C2=A02=C2=A0<-=C2=A04
>=20
> Unless you jump through hoops, git will represent it as:
>=20
> =C2=A0=C2=A01=C2=A0<-=C2=A02=C2=A0<-=C2=A03=C2=A0<-=C2=A04.
[the direction of arrows has changed in this quote]

=46irst part of the idea is to represent the partial ordering of patche=
s by
their interdependence (the sequences, chains of ordered patches) using
"parent" relation. (There was also idea of adding another field(s)
"depends-on" to represent only commit dependency in addition to "parent=
(s)"
relations defining history.)

Second part of the idea is to avoid creating, then recreating the final
something (commit) which combines commit chains to a final result
>
> =C2=A0=C2=A01=C2=A0->=C2=A03=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0>-=C2=
=A0head
> =C2=A0=C2=A02=C2=A0->=C2=A04=C2=A0=C2=A0/
>=20
> Where "head" is a merge commit that just combines the trees of 3 and =
4.
>=20
So an idea of "hydra", or "n-head" was born, which is just virtual triv=
ial
merge commit which gives us final result, HEAD of chains. (It is trivia=
l
because trees 3 and 4 are independent, merge without conflicts.) And al=
so
related idea of "hydra commit", which automatically adds commit to corr=
ect
chain (places commit in correct place of partial ordering by dependence=
)
and advances n-head (virtual trival merge commit which is HEAD).

The side effects (perhaps more important than making use of Darcs patch
algebra theory, and Darcs merge algorithm) is that we have automatical
topic branches, or to be more exact automatical dependency (sub)branche=
s
(commit/patch dependency chains).

Does it make sense?


To be continued...

In next installment we will see how "hydra commits" or "n-heads" might =
work:
simplifications in defining commit dependency, "coarse" ordering i.e. n=
o
branching dependency chains, updating n-head during commit and during
merge. Sam Vilain wrote some scripts for "proving of concept"; I would
present my idea on that matter, untested.

--=20
Jakub Nar=C4=99bski
ShadeHawk on #git
Poland

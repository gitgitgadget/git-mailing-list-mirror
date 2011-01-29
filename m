From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Sat, 29 Jan 2011 03:34:08 +0100
Message-ID: <4D437CA0.1070006@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx> <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx> <7v1v3wd1al.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 03:34:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj0eH-0000in-BL
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 03:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab1A2Cef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 21:34:35 -0500
Received: from india601.server4you.de ([85.25.151.105]:35411 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1A2Cee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 21:34:34 -0500
Received: from [192.168.2.104] (p4FFD9AF7.dip.t-dialin.net [79.253.154.247])
	by india601.server4you.de (Postfix) with ESMTPSA id 083C12F8091;
	Sat, 29 Jan 2011 03:34:32 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7v1v3wd1al.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165648>

Am 29.01.2011 01:02, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Subject: pickaxe: don't simplify history too much
>>
>> If pickaxe is used, turn off history simplification and make sure to=
 keep
>> merges with at least one interesting parent.
>>
>> If path specs are used, merges that have at least one parent whose f=
iles
>> match those in the specified subset are edited out.  This is good in
>> general, but leads to unexpectedly few results if used together with
>> pickaxe.  Merges that also have an interesting parent (in terms of -=
S or
>> -G) are dropped, too.
>>
>> This change makes sure pickaxe takes precedence over history
>> simplification.
>=20
> Hmmm, I understand the _motivation_ behind the change in the second h=
unk,
> in that you _might_ want to dig the side branch that did not contribu=
te
> anything to the end result when looking for a needle with either -S o=
r -G,
> but doesn't the same logic apply to things like --grep?

Yes, that's true.  I have to admit that I'm mostly reacting to the
unintuitive output given in the specific case ("test driven") and
probably don't fully understand the underlying problem and all its
implications.

> I do not think it is a good idea to unconditionally disable simplific=
ation
> for -S/G without a way for the user to countermand (even though I cou=
ld be
> persuaded to say that the flipping the default for -S/-G/--grep might=
 have
> been a better alternative in hindsight).

Currently there is no way to turn simplification off, resulting in
certain commits to become invisible when using e.g. -S in combination
with path specs.

> The user can control this behaviour by giving or not giving --simplif=
y
> from the command line anyway, no?

Yes, but that goes only so far (see the examples in the parent post
which use --full-history; --simplify-merges gives 3 more results with
-m, but still not the full 160).

And as a user I don't want to have to add another option in order to us=
e
pickaxe with path specs.  My expectation is that my search has
precedence over any history simplification, which is a nice and
necessary optimization, but shouldn't hide any search results that I
would have got if I had used no path specs.

However, it definitely looks like a corner case and I still don't know
what happened with all these merges.

> As to the first hunk, I have no idea why this is a good change.

I didn't see any other way to fix the example given in the commit messa=
ge..

> It feels as if you are fighting against what this part of the code do=
es in
> try_to_simplify_commit():
>=20
> 	switch (rev_compare_tree(revs, p, commit)) {
> 	case REV_TREE_SAME:
> 		tree_same =3D 1;
> 		if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
> 			/* ... */
> 			pp =3D &parent->next;
> 			continue;
> 		}
> 		parent->next =3D NULL;
> 		commit->parents =3D parent;
> 		commit->object.flags |=3D TREESAME;
> 		return;
> 	...
>=20
> When we see a _single_ parent that has the same tree, we set tree_sam=
e and
> also cull the parent list to contain only that parent.  When we are n=
ot
> simplifying the history, we do not cull the parent list and will insp=
ect
> other parents as well, but still we set tree_same to 1 here.  When so=
me
> other parent is found to be different, we set tree_changed to 1.  So =
we
> have four states (same =3D (0, 1) x changed =3D (0, 1)).
>=20
> The code before your addition in the first hunk says that we keep the
> commit if there is no parent with the same contents (i.e. !tree_same)=
 and
> there is at least one parent with different contents (i.e. tree_chang=
ed).
> I suspect that this logic may not be working well when we do not simp=
lify
> the merge.
>=20
> Let's look at the original code before your patch again.
>=20
>  1. If all the parents of a commit are the same, we will see (tree_sa=
me &&
>     !tree_changed), so we get TREESAME.
>=20
>  2. If some but not all of the parents are the same, we will see (tre=
e_same
>     && tree_changed), and we end up getting TREESAME.
>=20
>  3. If none of the parents is the same, (!tree_same && tree_changed) =
holds
>     true, and we do not get TREESAME.

=46or completeness, a fourth case (!tree_same && !tree_changed), which
would be triggered by commits whose parents are all classified as
REV_TREE_NEW.  That's another corner case for sure, but the old code
would mark it TREESAME and your patch changes that.

> Perhaps the second condition needs to be tweaked for the "do not simp=
lify
> merges" case?  That is, we split 2. into two cases:
>=20
>  2a. When simplifying the merges, if any of the parents is the same a=
s the
>      commit, we say TREESAME (the same as before);
>=20
>  2b. When not simplifying, we say TREESAME only when all the parents =
are
>      the same as the commit.  Otherwise the merge commit itself is wo=
rth
>      showing, i.e. !TREESAME.
>=20
> But I probably am missing some corner cases you saw in your analysis.=
=2E.
>=20
> diff --git a/revision.c b/revision.c
> index 7b9eaef..0147124 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -439,7 +439,7 @@ static void try_to_simplify_commit(struct rev_inf=
o *revs, struct commit *commit)
>  		}
>  		die("bad tree compare for commit %s", sha1_to_hex(commit->object.s=
ha1));
>  	}
> -	if (tree_changed && !tree_same)
> +	if ((!revs->simplify_history && tree_changed) || !tree_same)
>  		return;
>  	commit->object.flags |=3D TREESAME;
>  }

The patch lists the right commits in the test case, but requires the
option --full-history to be given.  Without it no output is given if th=
e
full file name is specified, as in master.

Perhaps we should check my underlying assumption first: is it reasonabl=
e
to expect a git log command to show the same commits with and without a
path spec that covers all changed files?

Ren=C3=A9

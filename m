From: Jamey Sharp <jamey@minilop.net>
Subject: Re: [PATCH v3 1/3] Support multiple virtual repositories with a
 single object store and refs
Date: Wed, 25 May 2011 09:08:16 -0700
Message-ID: <20110525160816.GB4839@oh.minilop.net>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
 <7vr57n60eb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 18:08:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPGdH-0001YO-RU
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab1EYQIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 12:08:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38116 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1EYQIV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 12:08:21 -0400
Received: by pwi15 with SMTP id 15so3493191pwi.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 09:08:20 -0700 (PDT)
Received: by 10.68.14.234 with SMTP id s10mr3455970pbc.12.1306339700518;
        Wed, 25 May 2011 09:08:20 -0700 (PDT)
Received: from oh.minilop.net (69-71-169-164.mammothnetworks.com [69.71.169.164])
        by mx.google.com with ESMTPS id h6sm5751543pbn.56.2011.05.25.09.08.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 09:08:19 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QPGd6-0001Jz-Dm; Wed, 25 May 2011 09:08:16 -0700
Content-Disposition: inline
In-Reply-To: <7vr57n60eb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174421>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2011 at 06:21:00PM -0700, Junio C Hamano wrote:
> Jamey Sharp <jamey@minilop.net> writes:
>=20
> > From: Josh Triplett <josh@joshtriplett.org>
> >
> > Given many repositories with copies of the same objects (such as branch=
es of
> > the same source), sharing a common object store will avoid duplication.
> > Alternates provide a single baseline, but don't handle ongoing activity=
 in the
> > various repositories.  Furthermore, operations such as git-gc need to k=
now
> > about all of the refs.
> >
> > Git supports storing multiple virtual repositories within the object st=
ore and
> > references of a single underlying repository.  The underlying repository
> > stores the objects for all of the virtual repositories, and includes al=
l the
> > refs and heads of the virtual repositories using prefixed names.
>=20
> I do not see anything changed up to this point since the previous
> round... sent a wrong patch?

Apparently so. I watched Josh fix up that commit message, and then I
don't know where it went.

> In any case, I _think_ what you are trying to say is:
>=20
>  - Implemented in the most na=EFve way, you can host multiple instances of
>    related projects, but that is wasteful; their object stores will have
>    duplicated objects without sharing. (This is the crucial part missing
>    from your description that confused me when trying to _guess_ what
>    problem you are trying to solve in the first place).
>=20
>  - You _could_ use alternates mechanism to alleviate that problem, but it
>    has issues, e.g. gc needs to be aware of other repositories (This is in
>    your first paragraph).
>=20
>  - Instead, we could store a single, large, repository and carve out its
>    refs namespaces into multiple hierarchies, to make it look as if there
>    are multiple repositories. (The first sentence of the second paragraph
>    also confused me, as you said "Git supports storing multiple ..." in
>    present tense).

Yes. I hope you won't mind if we blatantly steal this description. :-)

> One thing you would want to be careful with is what to do with the HEAD
> symrefs, which should appear to read "ref: refs/heads/<some-branch>" from
> the point of view of the clients that are under the illusion that they are
> interacting with one specific repository among others, while for the
> purpose of gc and things in the huge single repository they should be
> pointing at something like "refs/hosted-1-project/heads/<that-branch>",

As far as I can tell, that isn't true. Judging by the pack-protocol
documentation, my reading of the implementation, and the results of some
tests I ran, symrefs are resolved to hashes before being sent over the
wire, and then HEAD is magically re-inferred back into a symref on the
other end.

(This has the odd property that if you create a repository containing
two branches with identical heads, then clone that repository, the
clone's origin/HEAD will point to a randomly-selected one of the two
branches. Tested in version 1.7.4.4, and seems to be a necessary
consequence of the protocol design.)

As a result, symrefs only need to be valid in the underlying repository;
there's no mapping needed for the protocol. However, you probably do
want a different HEAD for each virtual repository, which is why we added
the --head option.

We didn't actually think about impact of these virtual HEADs on gc. As
long as they're all symrefs, they can't matter for gc, right? The head
they reference is already a suitable gc root. If the virtual HEADs do
need to participate in gc, then I guess we should update the conventions
documentation to recommend that they live somewhere under refs/.

> but other than that, after a lot of guesswork, the problem you are trying
> to solve seems clearer to me.
>=20
> But please do not make me guess.

Indeed. We'll get that right next round, honest this time. :-/

Now that you have the problem statement down, is the proposed solution
acceptable for merge?

Jamey

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3dKW0ACgkQp1aplQ4I9mUw3QCfQ77QDsQXgRxllOt2LE7Ku2CL
2OAAn1gNUGkAdEo0ufcBaR90VKtEik2T
=4jMN
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

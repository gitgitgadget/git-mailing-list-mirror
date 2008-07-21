From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-merge: missing structure bzero.
Date: Mon, 21 Jul 2008 23:49:09 +0200
Message-ID: <20080721214909.GF2718@artemis.madism.org>
References: <1216659830-22063-1-git-send-email-madcoder@debian.org> <20080721172119.GE32057@genesis.frugalware.org> <20080721181850.GA2718@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="iBwuxWUsK/REspAd";
	protocol="application/pgp-signature"; micalg=SHA1
To: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 21 23:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL3Gp-0002ow-Nm
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbYGUVtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYGUVtQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:49:16 -0400
Received: from pan.madism.org ([88.191.52.104]:50728 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbYGUVtP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:49:15 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3E04F34D73;
	Mon, 21 Jul 2008 23:49:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CC7E5224078; Mon, 21 Jul 2008 23:49:09 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20080721181850.GA2718@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89411>


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2008 at 06:18:50PM +0000, Pierre Habouzit wrote:
> On Mon, Jul 21, 2008 at 05:21:19PM +0000, Miklos Vajna wrote:
> > On Mon, Jul 21, 2008 at 07:03:50PM +0200, Pierre Habouzit <madcoder@deb=
ian.org> wrote:
> > > This cause segfaults when replacing a directory with a submodule in a
> > > fast-forward.
> >=20
> > Thanks.
> >=20
> > > +test_expect_failure 'Replace a directory with a submodule, with a fi=
le conflict' '
> > > +	mkdir test &&
> > > +	cd test &&
> > > +	: create our repository with a sub/a file &&
> > > +	git init &&
> > > +	mkdir sub && echo a > sub/a &&
> > > +	git add sub && git commit -asm"initial repository" &&
> > > +	: save this state in a new branch &&
> > > +	git branch temp &&
> > > +	: then replace sub with it &&
> > > +	git rm -rf sub &&
> > > +        git submodule add -- "$(pwd)/../submodule/.git/" sub &&
> > > +	git commit -asm "replace sub/ with a submodule" &&
> > > +	: then try to update the "temp" branch &&
> > > +	git checkout temp &&
> >=20
> > It seems this one fails. I guess this will be a problem in the low-level
> > merge code (read-tree -m) and not in builtin-merge.
>=20
>   Yeah, I saw that afterwards, the error was misleading (as it tells
> about some "merge" issue), but when I tried to debug it, it was indeed
> in git checkout. The easiest way to reproduce, is to have a submodule
> that replace a file that was previously versionned (which is something
> that will happen in real life when you take out a subdirectory of a
> project to make it live into a submodule) and that you then git checkout
> HEAD~1.

Actually, the issue is quite obvious when thinking. At git-checkout
time, git doesn't recurse (yet) into submodules, hence when we checkout
'temp' that is basically master~1 that basically does that:

"sub/" is a submodule, and gets replaced by sub/ a tree with "a" in it,
and the submodule _also_ has "a". As submodules are ignored silently, it
just:

  (1) forgets about the submodule at once, leaving all the submodules
      files into the wild, and sub/a (that was in the submodule) is now
      an untracked file.

  (2) tries to checkout sub/a and sees a file currently untracked and
      barfs.

So it boils down to the fact that git-checkout does nothing with
submodules. I really think we should address that, it's a major issue
wrt submodules and usability.


I believe we should for now require that all submodules are clean for
checkout to be able to work, and then we have those cases:

  * submodule -> directory: ignore any file that is either versionned or
    ignored in the submodule wrt checkout issues. If no issue arises
    with untracked non ignored files in the submodule, then basically:
    (1) in the submodule: git ls-files | xargs rm -f ; rm -rf .git=20
    (2) proceed with the checkout.

  * submodule -> blob: refuse to proceed if there is any untracked non
    ignored file in the submodule, else just rm -rf it, and proceed.

  * submodule h1 -> h2: if "git checkout h2" will work in the submodule,
    then we have no problem with the checkout, and do proceed. Though,
    if the checkout isn't possible because "h2" is unknown, then instead
    of a "cannot read h2" error, one should suggest the user to update
    its submodules (he probably lacks some objects and needs to fetch).

    Special case: if the submodule isn't initialized, proceed and warn
    about the submodule being uninitialized.

  * {blob,directory} -> submodule already work properly, though
    suggesting the user to run "git submodule update -i" when we *know*
    we have uninitialized submodules because of a checkout is a good
    idea.

  Note that uninitialized submodules are not special cases for the two
first cases, because uninitialized submodules are not different from a
directory with possibly untracked files in it. An uninitialized
submodule probably need to be dealt with as if it's clean from many
places actually.


  The issue is that I tried to grok upack-trees.c, but the code is quite
dense, and how to hack this efficiently still eludes me, because I don't
really get the big picture enough yet.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiFBFUACgkQvGr7W6HudhyJLwCfZsv+GD1hy/ld5PEjrSOEMUYM
vCgAn0nZYTSMXSXJG+jXpPqCOz6yenHe
=Fw0F
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--

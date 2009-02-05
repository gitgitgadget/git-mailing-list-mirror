From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [wishlist] git-archive -L
Date: Thu, 05 Feb 2009 16:04:29 +0100
Message-ID: <20090205150429.GB6434@artemis.corp>
References: <20090202143425.GA30667@artemis.corp> <4987FC03.60607@lsrfire.ath.cx> <498A1E02.6020707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="MfFXiAuoTsnnDAfZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV5nk-0004UP-5t
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 16:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZBEPEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 10:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZBEPEd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 10:04:33 -0500
Received: from pan.madism.org ([88.191.52.104]:41972 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbZBEPEc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 10:04:32 -0500
Received: from madism.org (unknown [91.68.206.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id CCAF340E01;
	Thu,  5 Feb 2009 16:04:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 026D02B4CB; Thu,  5 Feb 2009 16:04:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <498A1E02.6020707@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108568>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2009 at 11:00:18PM +0000, Ren=C3=A9 Scharfe wrote:
> Ren=C3=A9 Scharfe schrieb:
> > Anyway, I'll try to resurrect my old, incomplete symlink following code,
> > but I don't have much time, either. :-/
>=20
> After a second and a third look I don't see any salvageable parts in the
> old code any more.  It was a just prototype that taught me something I
> should have been able to find out by thinking alone: that to follow
> links within tracked content we can't simply jump to the target, but we
> have to walk the whole path step by step.
>=20
> E.g., consider a repository with these four entries:
>=20
> 	Type	Name	Target
> 	-------	-------	------
> 	file	a/f
> 	symlink	a/x	f
> 	symlink a/y	../b/f
> 	symlink	b	a
>=20
> Let's say our goal is to follow symlinks pointing to tracked content.
>=20
> We can easily follow "a/x" to get to its target "f" by concatenating the
> directory part of the symlink's path ("a/") with the target ("f"), i.e.
> we only need to do a simple string operation.
>=20
> If we do the same for "a/y", we'd arrive at "b/f", which is not a
> tracked file by itself, though.  We need to look up each path element
> one by one and follow symlinks at each step.  That can't be done with
> our existing tree walkers, AFAICS, so we'd need to write a new one.

I mostly stumbled on those issues before I gave up having no time to
understand how tree walkers work :/

Because of course, our symlinks are exactly symlinks to directories, so
not supporting'em is unacceptable to us.

> The decision to follow a link can be made by the callback and passed to
> read_tree_recursive() as a return value, with, e.g., READ_TREE_FOLLOW
> and READ_TREE_FOLLOW_NON_MATCHES meaning to follow all internal symlinks
> and to follow only those whose target doesn't match the specified paths,
> respectively.

It has to be more clever. If you consider something like:

    symlink a/b   ..

Or funnier:

    symlink a/b   ../../c
    symlink c/d   ../../a

If you don't pay attention, you end up with a nice busy loop, and really
really really long path names (a/b/b/b/b/b.... for the first one,
and a/b/d/b/d/b/d/b/d/b/... for the latter).

That's why I was thinking of a more straight approach, basicaly doing
that:
  * when meeting a symlink to a blob, see if that blob is tracked or
    not, and if its "real" path in the repository is inside what we're
    archiving or not. Then match that with what the user asked
    (following any symlinks -- if we want to, this looks like a pretty
    big security risk to me, and I see no good reason for that --, only
    tracked symlinks outside of the archived paths, or only tracked
    symlinks no matter what), and do it.

    This one is the almost easy bit.

  * when meeting a symlink to a directory, look at the pointee, and like
    for the file, see if it's "tracked" (IOW contains tracked files) and
    see if the user want symlink replacement or not. If yes, then
    remember the current <path, pointed directory inside the repository>
    and put it in a worklist.

When finishing the first "pass" of archiving, run a new archiving based
on the worklist. Do it a few times. and if you don't converge to a fixed
point where the worklist is empty, then you are likely to be in a
situation like the ones I depict earlier. *phew*.


Though this need quite a reeingeenering of the code, and I had (still
don't really have) no time for it. But I think this is the straight
approach that would work easily (I don't know for zip though, but in tar
where entries are not really sorted, it should work).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmK//0ACgkQvGr7W6HudhwPAwCfRKr3bXNEChppiW4Asiz8Jy9o
S9YAn00XVNtgXq+3PvUd/rnJSk61Nu82
=FeVx
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

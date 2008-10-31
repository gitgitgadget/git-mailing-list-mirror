From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 19:54:35 +0100
Message-ID: <20081031185435.GC8464@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3siQDZowHQqNOShm";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 19:56:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvzA0-0001QB-VN
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYJaSyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYJaSyj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:54:39 -0400
Received: from pan.madism.org ([88.191.52.104]:50886 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbYJaSyi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 14:54:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7C7F93B644;
	Fri, 31 Oct 2008 19:54:36 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4F20B5EE243; Fri, 31 Oct 2008 19:54:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031184154.GV14786@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99620>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 06:41:54PM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:

> How about this?
>=20
> http://www.spearce.org/projects/scm/libgit2/apidocs/CONVENTIONS

looks like a good start.

> > Second, if we want this to be a successful stuff, we all agree we must
> > let git be able to use it medium term. That means that when git-core is
> > experimenting with new interfaces, it will probably need to hook into
> > some more internal aspects of the library. This is a problem to solve
> > elegantly, linking git against a static library won't please a lot of
> > vendors and linux distributions, and exporting "private" symbols is a
> > sure way to see them being abused.
>=20
> Private symbols are a problem.  On some systems we can use link
> editing to strip them out of the .so, but that isn't always going to
> work everywhere.  I've outlined the idea of using double underscore
> to name private functions, and we can link-edit out '*__*' if the
> platform's linker supports it (e.g. GNU ld).

Well, I propose the following: we set-up on GNU-ld + gcc enabled systems
all what is needed to use symbol visibility, which isn't that intrusive,
and also rather easy given your GIT_EXPORT macro definition.

This way, people who care about portability across all libgit2 supported
platforms will have to align on the lowest common denominator, which
will not have any kind of private stuff available, so we're safe. And
GCC/GNU-ld enabled platforms cover most of the popular platforms (namely
linux and *BSD, I'm not sure about Macos dynlibs). Even win32 has kind
of what you need to do visibility I think.

IOW prehistoric systems will be have to cope with that because of Linux
(yeah, this is kind of deliciously backwards ;p).

No, my worry was rather wrt git core itself, I really think we _must_
make it link against libgit2 if we want libgit2 to stay current, but git
core will _very likely_ need the private stuff, and it _will_ be a
problem. I mean we cannot seriously so-name a library and show its guts
at the same time, and I'm unsure how to fix that problem. _that_ was my
actual question.

> > Last but not least, I believe parts of git-core are currently easy to
> > just take. For example, any code *I* wrote, I hereby give permission to
> > relicense it in any of the following licenses: BSD-like, MIT-like,
> > WTFPL.
>=20
> Yea.  We could try to do that.  I don't know how far it will get us,
> but if we have to "steal" code we can rip a good part from JGit.
> Its BSD-like, but has that "icky Java smell" to it.  :-)
>=20
> Before worrying about where we get implementation bits from I'm
> more interested in trying to get a consistent view of what our
> namespace looks like, and what our calling conventions are, so we
> have some sort of benchmark to measure APIs against as we add them
> to the implementation.

I'd say we should do both at the same time. Asking people if they would
agree to relicense code can be done in parallel. We could extract a list
of source files that we may need (my extraction included stuff that is
very unlikely to be useful like test-*.c that aren't useful, and some
that are already BSD I think), and see who it yields. It should be
possible to do a matrix source-file x people and see on a per-file basis
what they think.

If someone gives me the list of files we should consider (I'm not sure
about a good list right now) I could do the matrix at some fixed sha1
=66rom git.git using git blame -C -M -M -w, and ask people see where it
leads us ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLVGsACgkQvGr7W6HudhwfVACgo8+DAaGBJZ0SjlH7anrt7azk
Md8Anjmnks6gWk7387xSO1DcoDmUGoy0
=C3bl
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--

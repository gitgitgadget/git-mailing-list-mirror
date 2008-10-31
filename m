From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 21:12:35 +0100
Message-ID: <20081031201235.GE8464@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081031185435.GC8464@artemis.corp> <20081031195711.GW14786@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="G6nVm6DDWH/FONJq";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:13:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0NU-0003dv-9a
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYJaUMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbYJaUMj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:12:39 -0400
Received: from pan.madism.org ([88.191.52.104]:45234 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbYJaUMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:12:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AE94B3B6D6;
	Fri, 31 Oct 2008 21:12:36 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3888A5EE242; Fri, 31 Oct 2008 21:12:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031195711.GW14786@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99634>


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 07:57:11PM +0000, Shawn O. Pearce wrote:
> This "fixes" the "we leak everything" behavior and allows
> applications to have multiple pools on different threads if
> it needs to.  Thus the core git_revp_t isn't thread-safe and
> doesn't get weighed down by locking if the application wants
> multiple threads.

Note that on Linux (and also BSDs I think) many pthread locking
functions have stubs in the glibc and cost 0 until you use the
libpthread. So unless we need to use locking inside the tight-loop, it's
virtually free to write a thread-safe library (a function call is
basically 10 times cheaper than an xchg-based lock).

(Though for git it would suck as we get libpthread in our depends
through some of the other dependencies.

Another way is to use function pointers for the locking, and have a
function to make the object store thread safe by setting the pointers to
functions actually doing locking, and to let it point to functions doing
nothing else.

It looks unrealistic to me to let people deal with the locking,
especially if we mean this library to _also_ be used in language
bindings, hence used in sloppily written scripts.

But of course, if locking calls are used in the tight loop that would
rather suck :/

> Pierre Habouzit <madcoder@debian.org> wrote:
> >=20
> > Well, I propose the following: we set-up on GNU-ld + gcc enabled systems
> > all what is needed to use symbol visibility, which isn't that intrusive,
> > and also rather easy given your GIT_EXPORT macro definition.
>=20
> Yes, agreed.  Only I don't know how to do it myself.  I know its
> possible, so if someone wants to contribute a patch for this ... :-)

I will, basically, you need to build everything with -fvisibilty=3Dhidden
in your CFLAGS, and mark the prototypes of symbols you want to export
with __attribute__((visibility("default"))) (that you can set into your
EXPORT_GIT macro when you're building with __GNUC__).

You don't even need a linker script (unless we're going to do some
symbol versioning but I'm unsure whether it's that useful for now).

> > No, my worry was rather wrt git core itself, I really think we _must_
> > make it link against libgit2 if we want libgit2 to stay current, but git
> > core will _very likely_ need the private stuff, and it _will_ be a
> > problem. I mean we cannot seriously so-name a library and show its guts
> > at the same time, and I'm unsure how to fix that problem. _that_ was my
> > actual question.
>=20
> Hmmph.  I agree git-core needs to link to libgit2.
>=20
> I disagree it needs private bits.  If we do the library right
> git-core can use the public API.  And where it cannot its either
> not something that is "right" for libgit2

> (e.g. its parseopts and
> we aren't committed yet to including option parsing)

Sure, I didn't mean we have to put it in libgit2, it's highly UI related
and other tool may want to use something else, and it makes no sense for
many languages that have their library already (python, perl do e.g.).
=20
> or its highly
> experimental and we shouldn't put it into the library (and thus
> also git-core) until its more frozen.
>=20
> That said, I don't think its criminal to have git-core include and
> link to a static libgit2, especially if git-core's usage of the
> library is ahead of what the library itself is able to expose at
> the present time.

Okay, we'll see how that turns out to work then :)

> Off the top of my head some really important ones:
>=20
> 	diff-delta.c
> 	object.c
> 	patch-delta.c
> 	refs.c
> 	revision.c
> 	sha1_file.c
> 	sha1_name.c
>=20
> They form a pretty large part of the guts of what most people want
> from a git library.
>=20
> Slightly less important, but still fairly core:
>=20
> 	builtin-fetch-pack.c
> 	builtin-send-pack.c
> 	connect.c
> 	remote.c
> 	transport.c
>=20
> Is most of the client side of the git:// transport, something people want.

Okay I'll let people mention what they would like to see too, and I'll
work from that then.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLZrMACgkQvGr7W6HudhyrjQCfcurXyafb9WWELNbOptnvhUF+
PY4An3AH72Ki7HRzpIUdEwlF9hq1GVop
=ZY77
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--

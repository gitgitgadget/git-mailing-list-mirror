From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 02:02:11 +0100
Message-ID: <20081101010211.GC29036@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org> <20081101000213.GB29036@artemis.corp> <20081101001926.GF14786@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="S1BNGpv0yoYahz37";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:03:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4tu-0008LS-DM
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbYKABCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYKABCQ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:02:16 -0400
Received: from pan.madism.org ([88.191.52.104]:43644 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbYKABCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:02:15 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3738B3B776;
	Sat,  1 Nov 2008 02:02:13 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B93145EE245; Sat,  1 Nov 2008 02:02:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081101001926.GF14786@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99694>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 12:19:26AM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > On Fri, Oct 31, 2008 at 11:49:11PM +0000, Junio C Hamano wrote:
> > >=20
> > > I understand that the apidocs/ is a very early work-in-progress, but
> > > still, it bothers me that it is unclear to me what lifetime rules are=
 in
> > > effect on the in-core objects.  For example, in C-git, commit objects=
 are
> > > not just parsed but are modified in place as history is traversed
> > > (e.g. their flags smudged and their parents simplified).  You have "f=
lags"
> > > field in commit, which implies to me that the design shares this same
> > > "modified by processing in-place" assumption.
> >=20
> > I don't think it's impossible to have something efficient without this
> > kind of hacks. You just need to dissociate the objects from their
> > annotations, though use some kind of allocator that allow numbering of
> > the objects, and use that number as a lookup in an array of annotations.
> > It will require pool allocators for the annotations, but that should
> > work fine and efficientely.
>=20
> Interesting approach.  I don't know why I didn't think of that one.
>=20
> You'll still need to be able to toss parts of the git graph though.
> If you just pin everything in memory under a single global object
> table you'll run server processes out of memory as they chug through
> large numbers of repositories.

Sure, but for that you just need to reinject the numbers into some kind
of free list (hint a bitmap) to reuse old slots. Of course this is some
kind of take-once never-release approach _BUT_ one can do better and
"defrag" this at times.

E.g. for a server if we take your idea, there are some times we probably
*know* nobody has kept a reference to one of the pointers and we can
reorganize some pointers around to free chunks of data not allocated.

An escape way is to use mmap + madvise for those pools, the former to
allocate the memory and the latter to drop large unused ranges when
needed (remapping with MAP_FIXED is also supposed to work but fails on
Macos it seems).  Even win32 has what it takes to do so (just skim
through the code of jemalloc, that is used for mozilla, it's quite
portable on POSIX + Windows).

I was thinking that one should create and register pools of annotations
as such, define the size of the annotation (IOW the size of cell), and
let deal with that. I imagine the stuff as some kind of allocator that
would allocate the first time e.g. 4k of objects, and if you need more
8k, and if need more 16k and so on exponentially. Mapping an integer to
a cell in this kind of ropes is _really_ efficient: you need to know the
first bit set (__builtin_clz is of help with gcc, it can be emulated
with proper asm for many non-gcc platforms also) to give you the number
of the rope component that you intend to address, you clear that bit,
the resulting number is the index in that rope component of the cell
you're interested in. On most machines such an operation would be a few
cycles, which should be fairly little wrt the operation you would do
during a traversal.

Maintaining the bitmap is important, so that we can give back large
chunks of physical memory back to the system, and many malloc
implementations would likely use such kind of implementations, we would
just do our (which is arguably heavy) but gives us control on the cell
number, which is just what we need.

Of _course_ when we have a better / more natural place to put
annotations we need, let's do it ! But the kind of thing I just imagined
is more generic and can help to do arbitrary complex stuff during a
traversal.

We may want to explore a storage that is aware of the objects type also,
as I expect the liveness of objects to depend on the objects type a lot,
and some traversal to not care about some kind of objects at all, which
when combined with lazy allocation in the annotations pools, could end
up with reduced memory footprint. We could e.g. use two bits of the
"object handler" to store the type and dispatch into 3 (commit, tree,
blob) ropes instead of a big one.


The object and annotations store _is_ what makes git efficient, and is
the very service the library will have to support well. We _will_ have
to put some clever code in there and we cannot sacrifice any kind of
performance, this will be the tight loop every time.  I don't think
there will be anything else in git that is so central for performance.

On the other hand, it's probably ok for the first versions of the
library to have some things in it that don't perform well in long lived
processes (repacking e.g., if we ever want to do that in the library, as
it's slow and that forking a git-repack away should not be a too
expensive cost anyway).
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLqpMACgkQvGr7W6Hudhx12QCfcXg4U7Z6F0bsvrm5QtBkgHOi
/bsAnj2ceViT2uMmFK5JSAsb5MpYwB4I
=kl75
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--

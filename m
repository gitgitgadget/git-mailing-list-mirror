From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 14:19:28 +0100
Message-ID: <20081028131928.GB8272@artemis.googlewifi.com>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net> <20081028131116.GA8272@artemis.googlewifi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8P1HSweYDcXXzwPJ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 14:21:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuoV7-0005OA-1U
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 14:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYJ1NTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 09:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbYJ1NTc
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 09:19:32 -0400
Received: from pan.madism.org ([88.191.52.104]:55860 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbYJ1NTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 09:19:31 -0400
Received: from madism.org (user-64-9-235-148.googlewifi.com [64.9.235.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9A1583A85A;
	Tue, 28 Oct 2008 14:19:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 353042A29F; Tue, 28 Oct 2008 14:19:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081028131116.GA8272@artemis.googlewifi.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99289>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2008 at 01:11:16PM +0000, Pierre Habouzit wrote:
> On Tue, Oct 28, 2008 at 05:45:40AM +0000, Jeff King wrote:
> > On Mon, Oct 27, 2008 at 01:07:10PM -0700, Linus Torvalds wrote:
> > > Of course, if the commit is reachable through multiple sources (which=
 is
> > > common), our particular choice of "first" reachable is entirely random
> > > and depends on the particular path we happened to follow.
> >=20
> > Hmm. It would be nice to keep even a simple counter to get a "distance"
> > from the ref and choose the one with the smallest distance (I think we
> > can get away without the complex rules that git-describe uses, since we
> > are not interested in describing the full commit, but rather finding a
> > "likely" branch).
> >=20
> > However, that would require making multiple passes over the commit
> > graph, which might impact the startup speed.
>=20
> Actually I tried to do that (and you meant name-rev --contains rather
> than describe actually ;p), and I stopped because it's too slow. I
> believe the proper way to do that is to help git-log knowing which are
> the short (topic) branches, and to crawl incrementally using a
> date-based hack. This would basically work a bit like this. Let's
> imaging you want to crawl "next" in git and know which topics from pu
> are in it. You would say e.g.:
>=20
> git-log --topics=3D*/* next (as pretty much every */* is a topic branch
> for git.git).
>=20
>=20
> Then one has to know which are the heads of every topic branches first,
> then crawl next the usual way, except that when you arrive to a point
> that is a topic branch head, you don't look that way. You remember the
> date of that point, and continue to crawl "next" a bit further so that
> you can start annotating the topic's commits you've stumbled upon. And
> you do that, you look at jd/topic (as in John Doe topic branch) and mark
> all the commits as being from jd/topic, until you either go back to some
> commit from next, or your current commit date is younger than your
> current "next" crawling front. In the former case, you're done with that
> topic, in the latter you must continue to preprocess "next" a bit more.

My description is clumsy, as we probably sometimes want to crawl topics
that aren't merged either like in git-log --topics=3D*/* --all.  But we
just have to mark the current "front" of the walk, and have it sorted
between things that are part of topic heads and the thing that are not.
We don't even need to decorate the things that are _not_ part of the
topics at all I'd say, because that's where you definitely need distance
based algorithms and multiple passes to yield correct results.

Whereas for the specific case of topic branches, which is what people
want (see Ingo's mails on the subject a week or so ago), the algorithm I
propose is, I guess, mostly O(n + m) in the number of walked commits (n)
and references (m). IOW fast.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkHEWAACgkQvGr7W6HudhxU8ACfTfrUhrFajrOTA587nbr/MS+y
xN4AoJK7r4xKDFiQ1g4BjN+/b9OMUJud
=FLvM
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--

From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: merging .gitignore
Date: Tue, 02 Oct 2007 22:13:18 +0200
Message-ID: <20071002201318.GD16776@artemis.corp>
References: <20071001130314.GA5932@lapse.madduck.net> <Pine.LNX.4.64.0710011457120.28395@racer.site> <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="vni90+aGYgRvsTuO";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 22:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ico7b-0002S5-I5
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbXJBUNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbXJBUNV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:13:21 -0400
Received: from pan.madism.org ([88.191.52.104]:47649 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbXJBUNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:13:20 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0168D22A4C;
	Tue,  2 Oct 2007 22:13:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8CFAE3437C9; Tue,  2 Oct 2007 22:13:18 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20071002195148.GA14171@lapse.madduck.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59723>


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2007 at 07:51:48PM +0000, martin f krafft wrote:
> Well, with gitignore I am ready to say that merges should be
> resolved in an additive way. Remember that I am talking about an
> intergration branch, and if feature branches A and B used to ignore
> .o files, and now B suddenly does not ignore them anymore, the only
> real reason I can think of is that it was rewritten in a languages
> other than C*. So then you *still* want to ignore .o files in the
> integration branch.
>=20
> Basically I am saying that it should be
>=20
>   cat $gitignore_files | sort -u

  Except that this would not work, just take that example (for the sake
of conciseness I put lines as members of a set):


  Common ancestor content: (bar, foo, quux)
  Left child: (bar, baz, foo, quux)
  Right child: (bar, quux)

  This one is a conflict, and if you apply your method, the merge always
"works" (as in has no cases where it fails) and would yield a result
like:

  (bar, baz, foo, quux) whereas it's probably (bar, baz, quux) that
would be the proper one (aka left branch added a new ignore `baz` and
the right one removed it).

  The proper way for gitignore is probably to work on the sets
operations, like diff does with lines, but without taking ordering into
account. What gets harder is when your lists are:

  Ancestor: (aa*, aaa, bbb)
  Left child: (aa*, bbb)   <-- remove aaa because aa* covers it
  Right child: (aaa, aabcd, bbb, cc*) <-- remove aa* and be explicit

  The proper result is probably: (aaa, aabcd, bbb, cc*) but is in fact a
case of conflict, because the "left" child could have used the fact that
aa* was present and hide say a aaXXX that the right child did not had,
and the merge would be wrong.

  Of course, .gitignore aren't _that_ important and if you ignore one
less file, or one too many, git will continue to behave properly, but
well, merge implementations aren't _that_ trivial.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAqZevGr7W6HudhwRAtp4AJ0cJn5MRsQNysEY2umVs/ctp/jHOACeN9Xf
9bIGzgGGQtMeSQfC/1A4yZw=
=TgqL
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--

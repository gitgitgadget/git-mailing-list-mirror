From: Pierre Habouzit <madcoder@debian.org>
Subject: libxdiff and patience diff
Date: Tue, 04 Nov 2008 01:40:01 +0100
Message-ID: <20081104004001.GB29458@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Yylu36WmvOXNoKYn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: davidel@xmailserver.org
X-From: git-owner@vger.kernel.org Tue Nov 04 01:41:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx9z4-0008Pg-Qr
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 01:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbYKDAkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 19:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbYKDAkG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 19:40:06 -0500
Received: from pan.madism.org ([88.191.52.104]:45625 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbYKDAkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 19:40:05 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id ED9D03BEA2;
	Tue,  4 Nov 2008 01:40:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4A2402AF01; Tue,  4 Nov 2008 01:40:01 +0100 (CET)
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100016>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Davide,

I've been working tonight, trying to make libxdiff support the patience
diff algorithm, but I've totally failed, because I _thought_ I
understood what xdl_split was doing, but it appears I don't.


[ For the readers playing at home, the patience diff algorithm is
  explained after my sig. ]


What I did is to:
(1) add a flag to the xenv in xdl_split that says that I want a
    patience "split".
(2) Then in xdl_split, if that bit is set, I compute the longest common
    subsequence from the patience diff.
(3) for each split it computes I call xdl_recs_cmp on that interval.


What I thought it would achieve is that I force some boundaries at which
libxdiff _must_ resync. Though, it seems that for some reason it doesn't
work, probably because the "ha" stuff and the boundaries absolutely
don't work the way I thought it did.

So where is the place I should do that ? I suspect it should be
partly in xprepare.c but I'm a bit stuck right now.


Any pointer on how the stuff in xprepare.c and xdiffi.c work would help
greatly, it's really not self-evident to me :)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org



Patience diff
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Basically, it's an algorithm that considers line from the left file A
and the right file B.

It searches for lines that are unique *IN* A and unique *IN* B as well.
Then using a clever O(n log log n) where n is that number of lines, you
extract the longer common sequence of those lines.

This defines two splits of file A and B. For each corresponding chunks,
you then reduce the lines matching at the beginning and the end, and
reiterate the algorithm on the interior of that space, until there are
_no_ unique lines at all, and then you apply a usual diff algorithm to
generate the diff in that final section.

http://alfedenzo.livejournal.com/170301.html has a nice visual
explanation of the fact, even if it forgets about the "zones" trimming
that helps for the efficiency. It's also often wrong to generate the
stacks in the order shown on the blog, because you recurse from the max
line to the min line, which is not the natural order to work on a diff.
But that's just a matter of "inverting" all the comparisons which is
pretty obvious to do.


The difference of output can be seen on http://glandium.org/blog/?p=3D120
where the patience diff picks the line
   "include $(topsrcdir)/config/rules.mk"
as being unique on the left and the right file, hence will use it as
sync point rather than using it in a diff.


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkPmeEACgkQvGr7W6HudhzwNgCgkiEM6zZYMLR4EjI7mW2tnorN
TOMAnA83B6FITSzlT4Kwx2DN36tTTizD
=X+AP
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

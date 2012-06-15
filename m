From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] cherry-pick ignores some arguments
Date: Fri, 15 Jun 2012 15:12:23 +0200
Message-ID: <1339765943.4625.57.camel@beez.lab.cmartin.tk>
References: <20120614114415.39cbb64c@chalon.bertin.fr>
	 <1339691389.4625.9.camel@beez.lab.cmartin.tk>
	 <20120615091425.20e40af9@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-WsRdUMPdY3iDTjVYupwv"
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Fri Jun 15 15:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfWKM-0001VW-PZ
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 15:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab2FONMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 09:12:31 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:34968 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756844Ab2FONMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 09:12:30 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id BFAD14614A;
	Fri, 15 Jun 2012 15:12:22 +0200 (CEST)
In-Reply-To: <20120615091425.20e40af9@chalon.bertin.fr>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200051>


--=-WsRdUMPdY3iDTjVYupwv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-06-15 at 09:14 +0200, Yann Dirson wrote:
> On Thu, 14 Jun 2012 18:29:49 +0200 Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> > On Thu, 2012-06-14 at 11:44 +0200, Yann Dirson wrote:
> > > Hello list,
> > >=20
> > > I just did a "git cherry-pick AAA BBB..CCC" using 1.7.10.3, and was s=
urprised
> > > that only the BBB..CCC range got picked - AAA was silently ignored.
> > >=20
> >=20
> > There is no way to know whether this is a bug without knowing how AAA,
> > BBB and ccc are related? From the names, can we assume that AAA is a
> > (grand)parent of BBB? If that is the case, cherry-pick is behaving as
> > expected.
> >
> > See the DESCRIPTION in http://git-scm.com/docs/git-rev-list for further
> > explanation, but the short of the story is that the second argument tol=
d
> > it to ignore any commit before BBB, so AAA is not in the list of commit=
s
> > to be applied.
>=20
> OK, this is exactly the case.  Looking back at the cherry-pick manpage, I=
'd say that
> what confused me is the implicit --no-walk: the standard "git cherry-pick=
 AAA" does
> not look like a rev-list spec at all!

The typical cherry-pick usage is for a few select commits out of a
different branch. The manpage itself only started explaining the ranges
in 2010 and they may be more of a side-effect than a conscious design
decision. But that's neither here nor there.

>=20
> At least for this command, it would seem more natural (to me at least) to=
 take
> each arg one by one and feed it to "rev-list --no-walk" or similar.  Mayb=
e some
> special rev-list flag could trigger such a particular behaviour, pretty m=
uch like
> what --no-walk does ?

This would cause a regression, as passing it "A..B" is the same as "B
^A" which is spellt as two different arguments. Making

    git cherry-pick B ^A

internally cause

    git cherry-pick B
    git cherry-pick ^A

to be called would cause the wrong thing to happen. Instead of
cherry-picking the commits between B and A, it would cherry-pick B and
then do nothing in the second run (as there were no positive commits
specified).

>=20
>=20
> Another orthogonal UI issue I see, is that rev-list could be more user-fr=
iendly to warn
> the user when one element of a rev list is ignored because of another one=
.  Not sure
> whether this would be useful for all explicit rev lists specified by the =
user - maybe a
> config var and associated option would be needed too.

Doing it by default is not an option, as that would start causing all
sorts of commands and scripts to start warning during normal operation
with an error message that comes completely out of the blue from the
user's perspective. It's a perfectly valid thing to give it positive
references that are hidden by other arguments.

Another thing is that rev-list is plumbing so it's not allowed to change
(and it's not something users would generally be using). What I see
looking at the cherry-pick manpage is that it doesn't mention what
happens when you do ask rev-list to walk (which is what you do by giving
it a range). Though it does say that no traversal is done by default, it
doesn't say how you override that default. The EXAMPLES section isn't
that clear either, and the explanation for rev-list's --no-walk isn't
much help either. I'll try to create a couple of patches to make the
behaviour clearer.

   cmn


--=-WsRdUMPdY3iDTjVYupwv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJP2zS3AAoJEHKRP1jG7ZzTASgH/1YnXz6nJEPX6h24cO02YR/+
SR48aizhfIo1SMAYftk/NAad1DBeduDNTqPpESPh2HU0mbHOOhthGOcOS+WqS94d
f3ReRW2yi0gBJ8Fnp58MpIDOkFZ1fyQVSCIV8msMcGPm4yTZgMq26OZFm4dnIk9B
hHWGUXA75EwO7WS8BWKS+u0o7egYsElIOARCrCYOKzYJXok7XtagJez5K6py8P2V
4t0UoWtL0RSvJwQ5/rTBxgNuic95cPT0x6KpPEnGgRIJFAfKSQNB8Xy4Rxc9Kued
1N5p6P5puYuWxv9xrOP0xwlBFJClzBFauA0cuC4RE8PV2ss0a2tmnj1XZWKkn4g=
=O9Yl
-----END PGP SIGNATURE-----

--=-WsRdUMPdY3iDTjVYupwv--

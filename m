From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/3] fetch: honor the user-provided refspecs when
 pruning refs
Date: Fri, 07 Oct 2011 18:37:13 +0200
Message-ID: <1318005433.4579.5.camel@centaur.lab.cmartin.tk>
References: <20111006205103.GA1271@erythro.kitwarein.com>
	 <1317936107-1230-1-git-send-email-cmn@elego.de>
	 <1317936107-1230-3-git-send-email-cmn@elego.de>
	 <20111007162625.GB4399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IPgiAOsm2REPH24rZkqW"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 18:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCDQQ-0004PT-Uf
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 18:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965399Ab1JGQh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 12:37:26 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:33366 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760163Ab1JGQhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 12:37:25 -0400
Received: from [192.168.1.17] (brln-4dbc5717.pool.mediaWays.net [77.188.87.23])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 943A146103;
	Fri,  7 Oct 2011 18:36:59 +0200 (CEST)
In-Reply-To: <20111007162625.GB4399@sigill.intra.peff.net>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183086>


--=-IPgiAOsm2REPH24rZkqW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-10-07 at 12:26 -0400, Jeff King wrote:
> On Thu, Oct 06, 2011 at 11:21:46PM +0200, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > If the user gave us refspecs on the command line, we should use those
> > when deciding whether to prune a ref instead of relying on the
> > refspecs in the config.
> >=20
> > Previously, running
> >=20
> >     git fetch --prune origin refs/heads/master:refs/remotes/origin/mast=
er
> >=20
> > would delete every other tag under the origin namespace because we
>=20
> I assume you mean s/tag/branch/ in the last line?

Yeah, maybe ref would be better?

>=20
> > ---
> >  builtin/fetch.c  |    6 ++--
> >  builtin/remote.c |    2 +-
> >  remote.c         |   78 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
> >  remote.h         |    3 +-
> >  4 files changed, 77 insertions(+), 12 deletions(-)
>=20
> Tests?

Good point.

>=20
> >  static int get_stale_heads_cb(const char *refname,
> >  	const unsigned char *sha1, int flags, void *cb_data)
> >  {
> >  	struct stale_heads_info *info =3D cb_data;
> >  	struct refspec refspec;
> > +	int ret;
> >  	memset(&refspec, 0, sizeof(refspec));
> >  	refspec.dst =3D (char *)refname;
> > -	if (!remote_find_tracking(info->remote, &refspec)) {
> > -		if (!((flags & REF_ISSYMREF) ||
> > -		    string_list_has_string(info->ref_names, refspec.src))) {
> > -			struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tail=
);
> > -			hashcpy(ref->new_sha1, sha1);
> > -		}
> > +
> > +	/*
> > +	 * If the user speicified refspecs on the command line, we
> > +	 * should only use those to check. Otherwise, look in the
> > +	 * remote's configuration for the branch.
> > +	 */
> > +	if (info->ref_count)
> > +		ret =3D find_in_refs(info->refs, info->ref_count, &refspec);
> > +	else
> > +		ret =3D remote_find_tracking(info->remote, &refspec);
>=20
> Minor typo in the comment. But more importantly, this feels like a very
> low-level place to be thinking about things like what the user gave us
> on the command line.
>=20
> Shouldn't get_stale_heads not get a remote at all, and just get a set of
> refspecs? Those should be the minimal information it needs to get its
> answer, right?

OK, so take a step back and figure out what we want the rules to be
before we call get_stale_heads. It does sound like a more elegant
approach. I was trying to disrupt the callers as little as possible, but
then again, there's only two. Will change.

   cmn


--=-IPgiAOsm2REPH24rZkqW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOjyq5AAoJEHKRP1jG7ZzTZZYH/RVXH8UXWMd+jcEWGVAHLNXp
ydeLhmKIh1ED1CnNhdrkQZ2jU13XM4/PyjRMAtyXrUB/eFe/3qYQxHyijt2Cih6Q
iLWzfK1YHuKvxhdljPol/N7lNqfscy1mVQaYicMnk+bnEJBcfUqXH2yFiF18DS7y
nRlb2UiLiis+bENgdSuMFTlg/wKWJwf1ghz+ZrK4U+qw/ZipjkRn1XMfi1wpI7CB
WCBomrXs/vTYs7Ai00AA+Y14p/XrqQ30hUirSSZGQ4IPZxhGDDyRh2Olb3BgW0Oa
Yznr4jpEL/9yqu93hfir+opVK7Cvv1DtmjtxmJxuEA1VoCIzdHtnwru8JVvt4D8=
=T8c8
-----END PGP SIGNATURE-----

--=-IPgiAOsm2REPH24rZkqW--

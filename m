From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH 1/3] expanded hook api with stdio support
Date: Fri, 30 Dec 2011 13:13:44 -0400
Message-ID: <20111230171344.GA9667@gnu.kitenet.net>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net>
 <1325207240-22622-2-git-send-email-joey@kitenet.net>
 <4EFD88CB.3050403@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 30 18:14:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rgg1q-00078K-GY
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 18:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181Ab1L3RNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 12:13:54 -0500
Received: from wren.kitenet.net ([80.68.85.49]:42442 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab1L3RNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 12:13:52 -0500
Received: from gnu.kitenet.net (dialup-4.88.8.192.Dial1.Atlanta1.Level3.net [4.88.8.192])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 55F7F1183D4;
	Fri, 30 Dec 2011 12:13:49 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 81B824695F; Fri, 30 Dec 2011 12:13:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4EFD88CB.3050403@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187806>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johannes Sixt wrote:
> IMHO, this is overengineered. I don't think that we need something like
> this in the foreseeable future, particularly because such a pipeline or
> multi-hook infrastructure can easily be constructed by the (single) hook
> script itself.

Junio seemed to think this was a good direction to move in and gave some
examples in <7vlipz930t.fsf@alter.siamese.dyndns.org>

Anyway, the minimum cases for run_hook_complex() to support are:

* no stdin, no stdout
* only stdin
* stdin and stdout (needed for tweak-fetch)
* only stdout (perhaps)

The generator and reader members of struct hook allow the caller to
easily specify which of these cases applies to a hook, and also provides
a natural separation of the caller's stdin generation and stdout parsing
code.

That leaves the feeder and data members of struct hook as possible
overengineering. See below regarding the feeder. The data member could
be eliminated and global variables used by callers that need that,
but I prefer designs that don't require global variables.

> > +`run_hook_complex`::
> > +
> > +	Run a hook, with the caller providing its stdin and/or parsing its
> > +	stdout.
> > +	Takes a pointer to a `struct hook` that specifies the details,
> > +	including the name of the hook, any parameters to pass to it,
> > +	and how to handle the stdin and stdout. (See below.)
> > +	If the hook does not exist or is not executable, the return value
> > +	will be zero.
> > +	If it is executable, the hook will be executed and the exit
> > +	status of the hook is returned.
>=20
> What is the rationale for these error modes? It is as if a non-existent
> or non-executable hook counts as 'success'. (I'm not saying that this
> would be wrong, I'm just asking.)

They are identical to how run_hook already works.
A non-existant/non-executable hook *is* a valid configuration,
indeed it's the most likely configuration.

> > +/* A feeder that ensures the hook consumes all its stdin. */
> > +int feed_hook_in_full(int handle, struct strbuf *buf, struct hook *hoo=
k)
> > +{
> > +	if (write_in_full(handle, buf->buf, buf->len) !=3D buf->len) {
> > +		warning("%s hook failed to consume all its input", hook->name);
>=20
> Really? Could there not be any other error condition? The warning would
> be correct only if errno =3D=3D EPIPE, and this error will be returned on=
ly
> if SIGPIPE is ignored. Does this happen anywhere?
>=20
> Futhermore, if all data was written to the pipe successfully, there is
> no way to know whether the reader consumed everything.
>=20
> IOW, I don't it is worth to make the distinction. However, I do think
> that the parent process must be protected against SIGPIPE.

Yes, this was not thought through, I missed that a write to a pipe can
succeed (due to buffering) despite not being fully consumed.

Dealing with the hook SIGPIPE issue is complicated as Jeff explains in
<20111205214351.GA15029@sigill.intra.peff.net>, and I don't feel I'm the
one to do it. I'm feeling like ripping the "feeder" stuff out of my
patch, and not having my patch change the status quo on this issue.

--=20
see shy jo

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTv3xRckQ2SIlEuPHAQh94Q//SI9uR+ebFYgftkuAFBbpNOVemS6kLP45
alfASNXqLGFV06a5DREFgsupM2t7Tbb2O1Q0GKNqb1zwRiUE3nBr9zKl5HaWx2/u
N/V+cRea3xiljiFNnSYLfTDY3H9cXdv4EkdWB/c5VXBtDJg06jEKFtja0mGCwQJq
7eC00IdPj38ZurtnoxRB1fJMgySzGjuARtoMdhsjmcPLOkmDpZixObQvZhWlEGIJ
DB/4s4nRzr/Zx9YaO1zqOJG5e5rMQ59/HlmebbfzAGgr9cOni1On/CjIHuBM87/F
nHsOmBBlt/YkFSt/wGS5EFDwt3h8lmXxwUQjdc2MAUrdStcPdCWSKKslicH4Y7qt
nqkDTYykU+7CdosICMrl2uc8TmJ3d+yLofHGBeBhGSOFP079rBNzP+FURd3pgQyY
YwEgfJ3umPau/YW7HgEdIezCl7BfnaG0WMVGb26yE+c5X/cn+QU2vxyZJEcxGkVQ
82bfYRhk6jxCXURmwZVnCkeJt4uikCfNtWpmRML0/f0rhAUVDRklqTzYMjFNMNNu
Wu8USy69+/PGIV3mdLuBUL0vXdLp8wlyfNI+l1Le2crpEbMkp/QWYAlvOreba1+x
yluTj7OeDI0s/UQQzabBeu3AePtbgPvyhDWfDoysFMdxSRgktncW0p+IosDifDjq
ohiB4bDNouQ=
=WFRg
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

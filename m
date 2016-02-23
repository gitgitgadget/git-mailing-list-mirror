From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] xdiff/xmerge: fix memory leak in xdl_merge
Date: Tue, 23 Feb 2016 12:51:35 +0100
Message-ID: <20160223115135.GA977@pks-pc.localdomain>
References: <1456217151-16473-1-git-send-email-ps@pks.im>
 <alpine.DEB.2.20.1602231108260.3152@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 12:51:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYBVH-0001WD-ED
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 12:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbcBWLvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 06:51:39 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48888 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750704AbcBWLvi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 06:51:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 08578209EB
	for <git@vger.kernel.org>; Tue, 23 Feb 2016 06:51:37 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 23 Feb 2016 06:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=hD9A8CyYMGk7XIe+iz4uEVDA9i8=; b=YdmzG
	EpSof6kJQX9Wg8Yj4AqLeojYiJIaTvQzcYpc5BZE1xUZNdk5CotD3huASmp7SKMn
	/wpXbvn3WwqcTU0mMVKqo0LyUA9COODDCXSI6OndADTDtCm/0bP5ONssSiZg4AQE
	9Mwi/UgQeh2GHceBtGKN9FtiaFCP5rYnbhXAE8=
X-Sasl-enc: p7DduweFYPW/pyEAeAlBBnc8Nh4HilF1dyvrgQqT6pjN 1456228296
Received: from localhost (x5ce0f886.dyn.telefonica.de [92.224.248.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8FA22C00013;
	Tue, 23 Feb 2016 06:51:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602231108260.3152@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287043>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2016 at 11:09:50AM +0100, Johannes Schindelin wrote:
> Hi Patrick,
>=20
> On Tue, 23 Feb 2016, Patrick Steinhardt wrote:
>=20
> > When building the script for the second file that is to be merged
> > we have already allocated memory for data structures related to
> > the first file. When we encounter an error in building the second
> > script we only free allocated memory related to the second file
> > before erroring out.
>=20
> ACK.
>=20
> I wonder, though, whether we need this in addition:
>=20
> -- snipsnap --
> t a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 625198e..e5c8745 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -579,8 +579,11 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t
> *mf2,
>  	result->ptr =3D NULL;
>  	result->size =3D 0;
> =20
> -	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0 ||
> -			xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
> +	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
> +		return -1;
> +	}
> +	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
> +		xdl_free_env(&xe1);
>  		return -1;
>  	}
>  	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||

Oh, yes, this is required. I am somewhat confused by all the
pointers being passed around there, it is not immediately obvious
which pointers are being allocated and which not when you are not
intimate with the code base.

So thanks for pointing this out. Will post v2 soon.

Patrick

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzEfHAAoJEBF8Z7aeq/EsbnkP/26+EkLyv4h9UK8RHB5nlCY0
TjplR3R6bB4lxFtnMgILSh3hFtXJ16IAj4VvOtVmwuNtBbXHhldEXGv1ULGYhbEE
aFhWDQLmKQ+mYbf0LuvxTuDsdHZrYeMC2p+WlXqciup7kbMT4Qk/ojI5dh8CtGy4
RUuQHQPdPRlt0F59rbo96k7Xsv1DNL63A8hOX2wC7HDoqBX4WmJI4LlbNngLoiPb
FVFsCXEBXcUHClAcwFfmzdy6mQUZ91mkdXndYV3VkAJKbxYSD5DQ1HLO30vsxlFZ
6xvsErTsav3fYujtXJlq+u8Y+aQBgSwxp7Y+A2a6+bdgPYpZ+kyneTW5Ta1Y7KrF
xHPxkV+Q/gwm7lIYd7/EpueqyRnt4mxJpKCBS8SPOgrbqXgO2m5UW8dHSXVguTHE
jUUQf+EUT7hKt6Phewkq45HHjgFDFUozht7a32Cwsz7HAgFBKQHqpHWOD/bOyJMN
Q9+kUxN9fgAvl17PZQ7hWKYwhFvupMMNVLtSieSSN+XgWGt+KRa/P8w7BGLsGq2Y
RegH96ypeQtVp4w7nJFuJc2d8DfoB7iL+14tRuAGlLV8VjtjPwdoebR3l6YjtsKz
RBeglT6zxHcetQCMyBTgWkQvg0zPO/TSUxx6ehwrVRHh6E9Ydh41wUkmFiBTCQXF
CuH0h19N0YrgevtRfG3A
=AEDe
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

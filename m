From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/3] clone: do not include authentication data in
 guessed dir
Date: Thu, 6 Aug 2015 11:47:32 +0200
Message-ID: <20150806094732.GA746@pks-xps>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438769179-5943-1-git-send-email-ps@pks.im>
 <1438769179-5943-2-git-send-email-ps@pks.im>
 <xmqqzj253a39.fsf@gitster.dls.corp.google.com>
 <xmqqr3nh34tv.fsf@gitster.dls.corp.google.com>
 <xmqqmvy534m0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sunshine@sunshineco.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 11:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNHm2-0004og-3U
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 11:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbbHFJrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 05:47:36 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42892 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753433AbbHFJrf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2015 05:47:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EA13B20813
	for <git@vger.kernel.org>; Thu,  6 Aug 2015 05:47:34 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 06 Aug 2015 05:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=8tPa7WQfQNmCko0v8crwHb8ET6A=; b=HsTxV
	uxzNURraUBEq5c/jwfFdn9/WpunHGKqCY9NiRgLv1ZJagAzl34/nuA7r61AMqkSn
	DngbLYCNMkrWayJK6jZhWwgrGZwZ1Iv/7pp8CFxpdzLqmk6ivEsY58bGdgr72u47
	oFDUlfhOKD6l7VGEfqsr+eVLjPdax91AeHjvVk=
X-Sasl-enc: /tOW5+UJFYYgcd6IUC1qyGEF8wzxLZVs3zW3pgsCOabW 1438854454
Received: from localhost (i59f7870a.versanet.de [89.247.135.10])
	by mail.messagingengine.com (Postfix) with ESMTPA id 21EB5C00017;
	Thu,  6 Aug 2015 05:47:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqmvy534m0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275421>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 12:41:27PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > For completeness, here is what I think the end result (together with
> > Peff's series) of the test should look like.
> > ...
> > Note that ssh://user:passw@rd@host:1234/ and user:passw@rd@host:/
> > tests fail for the same reason (finding @ should be greedy, I think).
>=20
> And I think this should make it pass.  Just remember the last
> occurrence of '@' by moving the 'start' every time we see an '@'
> sign.
>=20
>  builtin/clone.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/builtin/clone.c b/builtin/clone.c
> index cae288f..5d86439 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -160,13 +160,12 @@ static char *guess_dir_name(const char *repo, int i=
s_bundle, int is_bare)
>  		start +=3D 3;
> =20
>  	/*
> -	 * Skip authentication data.
> +	 * Skip authentication data, if exists.
>  	 */
> -	ptr =3D start;
> -	while (ptr < end && !is_dir_sep(*ptr) && *ptr !=3D '@')
> -		ptr++;
> -	if (*ptr =3D=3D '@')
> -		start =3D ptr + 1;
> +	for (ptr =3D start; ptr < end && !is_dir_sep(*ptr); ptr++) {
> +		if (*ptr =3D=3D '@')
> +			start =3D ptr + 1;
> +	}
> =20
>  	/*
>  	 * Strip trailing spaces, slashes and /.git

I guess it makes sense to skip over @-signs greedily. Is there
anything I need to do here or will you squash those changes in?

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVwy0wAAoJEBF8Z7aeq/EsF5IP/jEPr9575uIrqSlA4D2wVq1l
f/09uu23xPRPe05QuhrHxs5saFHUrAsU8vBxouoJ8papaQI2u72Y21fSFvhck60+
1uS0bV1u3/5K3an7XH/zNtBhupc0d6nfjamDFakkQqPqadYWl4EVv8pz1Vj0cyx1
/D9tqkAJ5hVGxnMVclW3XhRGMieLXdSwNPSQBe5KNlBQRQq9dtITUHixQr9R54IZ
Ldqlo5314IpgPBaJXNjR44aIkqp7d8FfIp41YtHYuNfZTUmoCF5BMY/8ywbtBWYq
cL7tXkbbaH6xncMRU01OVnb6gzpYOfv1YbO8461y1/089CBWryq7Z5NX1C8QKZQ8
xbooomoCUL+OGLSelHkUsWE/eMjflGIj6GooDFwxSD5yzQbttUoZ6wjS0swm1RvB
MTSIXHLjxCqWuoRociVUEEWU22m0zMZB4Z1HSsL2MfgOlYQdXYzOdoBvJ6QcpLWB
nmn29Gm0eJBwChI1ZVRHcp0cZBVVdccFAthsChTogZ0OYJocPQnmvPlZqMyMPMUv
kpcgSU2ADTkst/BccW7jwhzr14jZpK0EdAMCPV11zTa/dfYb4HY/N2JIc161EVaF
xQ/RWgjfZFXcRkImN1dDjsd5nqT61PNpKDG5PAIK6pioszEBGKj/adePscTB+6yP
dtinaBrwKYWY56dkuR7x
=4rXZ
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

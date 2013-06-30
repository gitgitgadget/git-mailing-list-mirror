From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] commit: reject invalid UTF-8 codepoints
Date: Sun, 30 Jun 2013 02:29:21 +0000
Message-ID: <20130630022921.GP862789@vauxhall.crustytoothpaste.net>
References: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
 <7v7ghcl50r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 04:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ut7Oj-0007jS-6k
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 04:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab3F3C3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 22:29:35 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54523 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751751Ab3F3C3e (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jun 2013 22:29:34 -0400
Received: from omta03.emeryville.ca.mail.comcast.net ([76.96.30.27])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id uSQ11l0050b6N64A1SVZ1e; Sun, 30 Jun 2013 02:29:33 +0000
Received: from castro.crustytoothpaste.net ([98.195.173.111])
	by omta03.emeryville.ca.mail.comcast.net with comcast
	id uSVW1l0062QaLlN8PSVXhb; Sun, 30 Jun 2013 02:29:32 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 212C828073;
	Sun, 30 Jun 2013 02:29:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v7ghcl50r.fsf@alter.siamese.dyndns.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372559373;
	bh=MSoh2NMfMkQpPeV+YhANwGqlEnZxSBtBH5Cvsaz4EsM=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=QxGEAmzLUhnYCdpmBwc3B+0B5/tI58LbMLxiiFEsvOWjIH5eEKvhV1PlEIufYO13D
	 lp/kN2KYxxhCw8T24LBuftra4PS4p873ECsquN027jDLfFBNLPrQjzmALZo384TDpM
	 XpSW+mFEj8nUe63OFfWIxZ298Nj9c/sX99OTtc+47p0Azh+4fsQZ/LdjxOE3otZTMh
	 fXOmRqi3mHHYq8p3OQG4cgo7FItBk3ps7bhVvBYNJ2J0iUFxZmy9suHxN/x4RFc96W
	 wrd13b83qtX1WZb2Ahcr7z+Ktakn2Y3EcHkL8foK9o0BUYV+Y0ySRKOyzTrFrA/rG3
	 W071JyXFsJvZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229262>


--JQ29orswtRjjfiJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2013 at 07:13:40PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> Does this correspond to the following comment in the same file, and
> if so, shouldn't this part of your patch?

Yes, yes, it should.

> We used to allow te original up-to-6 form and this update is about
> rejecting anything above U+10FFFF (in line with e.g. RFC 3629)?

Correct.  Since no codepoints above U+10FFFF will ever be assigned,
there's no point in trying to allow those UTF-8 sequences, since they
will be caught below anyway.  Some four-byte sequences will produce
too-large codepoints, but all five- and six-byte sequences are
guaranteed to.

> As you use separate if statements for this check, perhaps you can
> give each of them a better comment to say what each is rejecting?
> E.g.
>=20
> 	/* do not allow range for surrogate pair */
> 		if (codepoint >=3D 0xd800 && codepoint <=3D 0xdfff)
> 			return bad_offset;

Sure.

> As that comment I quoted at the beginning says, we did not check for
> invalid encoded values and the primary reason for it is beccause
> this function did not want to look into the actual values here.  But
> now you are looking into "codepoint", you can now also check for
> "overlong" form (e.g. sequence "C0 80" turning into U+0000)?

Correct.  That's what my second patch does.  I thought I would make the
changes separately, since they're slightly different and from what I've
seen git development prefers small, independent patches, but if you'd
prefer, I can squash them into one patch.

> Perhaps
>=20
>         test_expect_success 'test name' '
>                 test_when_finished "rm -f $HOME/stderr" &&

I wasn't aware that existed, but it makes sense to use it.

> > +Invalid surrogate:???
>=20
> I suspect that I did not receive what you intended to send.  Do you
> want to send this part as a binary patch perhaps?

If you ended up with an encoding of U+D800, then you got it.  Otherwise,
I can resend it as a binary patch during the reroll.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRz5gBAAoJEL9TXYEfUvaL5Y4P/iI2UM9Exut5J1Y6npP6A5kx
8//sMaSwvA79v4h0X2bVVwZIT0GbPoJcLz03DsIsTXMH/dCMQ5vqJwH8Ky2nvMsA
tVS3Gd/fnvkOyxfJOorWTdDwr4WU3EN7/qpzt722OW5khwP0mK6qkIW8ocdT3BHY
OsoW1V/9wm49ZSVp4V/Jzz/joaTvk5KbAZPSjgpPYHk4GJiWm5svGJ+8knkqvb2x
8aSg1bim9bQpK+Ten/utjf/LW/kPjQqlax+WOBwmCcDjSsU/SrwrsGUjK/G0A1F0
lVlmQ05+1CmjNt2m2b3MlJ2SQ3wqP3IghIylk8Ra9/OGyPypHUwpvdstcRX7UVR/
pZEndgD6fcd6fBnCgg3gAdT1u8EAls3sZQ6j5NHbCjbHRnmFns4n+gxi0K3MNn32
yHu8RFXBM1cH6upwO6U+e3ihrlRxjTeXZ8isme3iDpRRv8WcWV7JfvaHVW3ZYGvY
t+n8otsf8XC6jefG8KNj3gXgMK10BxD4HUzkRPNfI1439vzyDOSrgHyxq2eT1lZg
v0R+yofivbALoLEqWvPYPD+4faChF9FqIUCAsG1e9hu7EWNFkX5A+iQzbPwV36WQ
6zGdZvviAwbjNZw30ZIcIKSOuptcWluBLI7tYR3AiaZKH/NTHC0fsM1YAI1NNrP0
w6xi2fnfhY1tQOpA4+j7
=WGND
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--

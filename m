From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/3] clone: do not include authentication data in
 guessed dir
Date: Sat, 8 Aug 2015 19:37:37 +0200
Message-ID: <20150808173737.GA949@pks-pc.localdomain>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438769179-5943-1-git-send-email-ps@pks.im>
 <1438769179-5943-2-git-send-email-ps@pks.im>
 <xmqqzj253a39.fsf@gitster.dls.corp.google.com>
 <xmqqr3nh34tv.fsf@gitster.dls.corp.google.com>
 <xmqqmvy534m0.fsf@gitster.dls.corp.google.com>
 <20150806094732.GA746@pks-xps>
 <xmqqh9oayghp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sunshine@sunshineco.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 19:37:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZO841-0007gX-E8
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 19:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992459AbbHHRhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 13:37:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39655 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946701AbbHHRhk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2015 13:37:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 92CB720387
	for <git@vger.kernel.org>; Sat,  8 Aug 2015 13:37:39 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 08 Aug 2015 13:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=nFr8AUkf6xO+deh2qtHKvyDnULU=; b=PdsHk
	BcN2RJMA9D1s30bovnHOE3ARJZLLsA4gFCvlR2ftIWVGEUpSrxIUpo9Mida5PALX
	Jco3syxhq44OXroOQxJvgkWOu+bLvCGLSyT3C7c0WDTBqx32F0xClaT/4ibFp+U7
	0AbGySd+hKdr+oaXVbnwUfaqXeM0NABCwYtwB0=
X-Sasl-enc: JgkGB1ZJZ6gFKPs5vKsfQ+Yk6vhUfEbbHF0fl6P7RzqB 1439055459
Received: from localhost (x5ce12267.dyn.telefonica.de [92.225.34.103])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1A2C06801A1;
	Sat,  8 Aug 2015 13:37:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqh9oayghp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275515>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 01:45:54PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Wed, Aug 05, 2015 at 12:41:27PM -0700, Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>=20
> >> > For completeness, here is what I think the end result (together with
> >> > Peff's series) of the test should look like.
> >> > ...
> >> > Note that ssh://user:passw@rd@host:1234/ and user:passw@rd@host:/
> >> > tests fail for the same reason (finding @ should be greedy, I think).
> >>=20
> >> And I think this should make it pass.  Just remember the last
> >> occurrence of '@' by moving the 'start' every time we see an '@'
> >> sign.
> >>=20
> >>  builtin/clone.c | 11 +++++------
> >>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>=20
> >> diff --git a/builtin/clone.c b/builtin/clone.c
> >> index cae288f..5d86439 100644
> >> --- a/builtin/clone.c
> >> +++ b/builtin/clone.c
> >> @@ -160,13 +160,12 @@ static char *guess_dir_name(const char *repo, in=
t is_bundle, int is_bare)
> >>  		start +=3D 3;
> >> =20
> >>  	/*
> >> -	 * Skip authentication data.
> >> +	 * Skip authentication data, if exists.
> >>  	 */
> >> -	ptr =3D start;
> >> -	while (ptr < end && !is_dir_sep(*ptr) && *ptr !=3D '@')
> >> -		ptr++;
> >> -	if (*ptr =3D=3D '@')
> >> -		start =3D ptr + 1;
> >> +	for (ptr =3D start; ptr < end && !is_dir_sep(*ptr); ptr++) {
> >> +		if (*ptr =3D=3D '@')
> >> +			start =3D ptr + 1;
> >> +	}
> >> =20
> >>  	/*
> >>  	 * Strip trailing spaces, slashes and /.git
> >
> > I guess it makes sense to skip over @-signs greedily. Is there
> > anything I need to do here or will you squash those changes in?
>=20
> Sorry but I won't have patience to split the "these need squashing
> in" into multiple pieces and add them to appropriate commits in the
> 5 patch series (counting Peff's two fixes on top of which you built
> your 3 patch series) correctly.  You as the original author are much
> better equipped to do so than I am, so I'd appreciate if you can
> reroll them as a 5-patch series.
>=20
> Among the changes, the fix to builtin/clone.c needs to be squashed
> into your "clone: do not include authentication data in guessed
> dir", and the remainder of the patch to t5603 should go to Peff's
> "clone: add tests for output directory", but with most of them
> marked initially as failing.  And then as you fix them in your
> patches, some of the "fail" mark should be dropped.
>=20
> Thanks.

No problem, just wanted to make sure on how to proceed.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVxj5hAAoJEBF8Z7aeq/EsRmEP/iza3BLhXRmW+NGSy475ChKd
DeWeBOP5altfOecd0Z75Gg9fq0yUWxH8MIT9KDpz024+dq25CtCTRS2P3kjRUZCe
tyxScDJDpJ6X1WZncyMCmS0nspubJGA6C4k+TTBArqkQIoFYQIQ9otUr+kLAnnUU
jyQjiwnFBylJAoK/C1UzvGbVKVo5+tHgoA1lPO9VFlw6ImgIOFMEc66pN1O7LGFD
0dckY3cDwlOQ9GsaxM2gdNtWRpx104KJ6UNhTog2FfMMfwUh/zdhpMJS59aPTJc9
VSaDnm+AWHykkiQnPWcZi72ScPn8512Z1mFcVHb+T9fumH/nFP2FmpNVyYHDj3gU
3WCCW1hwYywrNS19RGI/VgxDPqKe3ULFnelo2TClolfjprCX64wURfBu9BtCUogr
oKipY2lwG8KStoFb8i61gLm2LkuB/bNeN/tTPK/5Idk6ErWyFFT15L5CdxpE+Xil
RgbB5Ht6gQlmtBTJ/CZrzjuAj/U0H2S6Hk0jRKRePX7fxlRlSCpSlzd5/tFpO3lD
GKM3PseH7HgFV107OfSaB3WD3ZzAXTpXwAA8GJOW1KnH3zuJdcOl07UJTDuZQeAw
9D22YDzYJv1ne57WT9V2efmAGDzl8rFxATnCGVXfi/Vk9ZwS94eqaiFoSSQwfbaH
s6uty1UffaraTE+RjE2S
=A5Ux
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E864820195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbcGLWVK (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:21:10 -0400
Received: from kitenet.net ([66.228.36.95]:41806 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbcGLWVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:21:09 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=Tmqeb566;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468362054; bh=j+7Rg72FywRojbxaXRW3HrSVQ9KRf7K6YwU5kAUH5pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tmqeb566EifPgfikO0OEemU+fgMWwlQK6NB+A5wy7XyqCKlaySif2pO8ZgjIjfDpF
	 ZD72GBoMwZnb+BMcXDKba1uGyISTfOD2Q8nu77WfdehewdRvsUlSHnTdsppx6GkWa8
	 kZ5VDyPmcfxrpyHugAmZIL3Duf42lsEa4grl8DyE=
Date:	Tue, 12 Jul 2016 18:20:54 -0400
From:	Joey Hess <id@joeyh.name>
To:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
Message-ID: <20160712222054.GA10128@kitenet.net>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <18617acb-bcdb-607d-007e-552dabd352cb@web.de>
 <20160622210958.GA24618@kitenet.net>
 <1f76a4d3-68b1-db33-5c7b-dc5ab104a3ef@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1f76a4d3-68b1-db33-5c7b-dc5ab104a3ef@web.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Torsten B=F6gershausen wrote re jh/clean-smudge-annex:
> The thing is that we need to check the file system to find .gitatttibutes,
> even if we just did it 1 nanosecond ago.
>=20
> So the .gitattributes is done 3 times:
> -1 would_convert_to_git_filter_fd(
> -2 assert(would_convert_to_git_filter_fd(path));
> -3 convert.c/convert_to_git_filter_fd()
>=20
> The only situation where this could be useful is when the .gitattributes
> change between -1 and -2,
> but then they would have changed between -1 and -3, and convert.c
> will die().
>=20
> Does it make sense to remove -2 ?

There's less redundant work going on than at first seems, because=20
=2Egitattribute files are only read once and cached. Verified by strace.

So, the redundant work is only in the processing that convert_attrs() does
of the cached .gitattributes.

Notice that there was a similar redundant triple call to convert_attrs()
before my patch set:

1. index_fd checks would_convert_to_git_filter_fd
2. index_stream_convert_blob does assert(would_convert_to_git_filter_fd(pat=
h))
   (Again redundantly since 1. is its only caller and has already
   checked.)
3. in convert_to_git_filter_fd

If convert_attrs() is somehow expensive, it might be worth passing a
struct conv_attrs * into the functions that currently call
convert_attrs(). But it does not look expensive to me.

I think it would be safe enough to remove both asserts, at least as the
code is structured now.

--=20
see shy jo

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV4VtRskQ2SIlEuPHAQIHgw/+IMc+YJA5KrajP1e8PEAAvNUHISb+xdua
ER66bfTKPbxl/NrkDWiH7NokdFYZloE1f4vkrG5l/Sn7YmmiT55giqiLDrCLYEWw
ru9ODEj9+BDsNuXKjlOCX6UHGZd2mpUHY9lN0Oscx7PQiuL+4HhE8sVy59Xy9dDz
vYSbVg8Cgn6YineyQz1S4dkGkBIN2/wZFLp1Ax5VsqP9KkwcX1zzT5TB1hDgozPO
iH5vMqnratJ4+f7PrkSELsmUTj1kDghXnTR9dS2YHntAc2NulH+xcFkqMIvuz34y
7zJbWFD3s1UY7RpHaxC7scohT97eBosG6+ctBmxT4JcWdXpBHFuoGApTpjYoh5d9
SjAcKYaJ6qawAFG+vQRJ2oJCOh1DzFlSzoeO0E3otw6qLsNIpqpOXUnHZAAuPBwy
bpz6sUH5Jwshyy2h2E8sRJ1V3RnPyVuYM5ZzM8P3b4O9RFM69LP0xez3mtmuMJfF
h+KwP7INyIewI9y+4SImp6s+HSKoXviXMdazuCagJcOu4t4nN2+GRK3Wdasg8HXl
+k+6mUv5xaiSSGWAHona3NdJRTkUUO5tcgS34YeBjpQQY8uJSOWiz+VO6QtIJqWU
k8U/wvNSTmEZ5Rsx9IjI4RB3lrrelJd5e8qKg2x3LIL4lGNQCQ4HjKXYcHDLeCoB
V8c26+5+VDo=
=sWfd
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

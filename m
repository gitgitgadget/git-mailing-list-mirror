Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D635120189
	for <e@80x24.org>; Sun, 19 Jun 2016 17:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbcFSRZs (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 13:25:48 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37990 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191AbcFSRZs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 13:25:48 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [64.134.182.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4DFBA2809F;
	Sun, 19 Jun 2016 17:25:45 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466357145;
	bh=zEPBr4xrKVtIaDRU+KHsmgGOVshGaC7H0lsycMYFpHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTxIXI70G/0mm5LYKL+8s9a9XTndYOzaXE4jB574+taYe3KEMMzg58Y//BlVKrN98
	 EX5jwG9HHxaf5v8PwXAa6WZTTRwYsMLjpBgKGWe5fUf3IyaoDFbg9tpCH3o7LXXdLK
	 nqHze1Vigm8N121nwJjrIOAMNav94lQw65pm99ggfQnSPe8by91D6wNdup/BxjN6Tk
	 +lc1yh2ffP0wAmaotgnrkZAoffdMD6Yo1vDnWJm4+hbO86wp5tkDY3716ptXaR+O8E
	 dRPhNMnVA8XraRVb6LelecwHj7KWz9Ux9kXNWDTmCnVdFE+vmhmPqF2+khr65xJpiH
	 a9zwEoK676o+Wph5wU68CREvfU+UYnKx752pHUr4oHQNs8wXEG/9NOv2elanBgwNyP
	 tzE28pymJlw2QfMFfqVDJWTEuohDgMRnV0gyTvs1tjJpmUje8kWeGK5MxW0o0AvTck
	 4qfuwcsdTFLOTUINxmJalhAA+I1sByqshMn+8rnudDcmFqfEF0J
Date:	Sun, 19 Jun 2016 17:25:39 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/8] object_id part 4
Message-ID: <20160619172538.GA16194@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
 <57665CC6.6070208@kdbg.org>
 <20160619092448.GA12221@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20160619092448.GA12221@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-trunk-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 19, 2016 at 05:24:48AM -0400, Jeff King wrote:
> On Sun, Jun 19, 2016 at 10:50:14AM +0200, Johannes Sixt wrote:
> > To avoid future mistakes, can you write down how "transform plain struc=
ts
> > before pointers to structs" looks like? Is it a particular order of
> > Coccinelle rules? Which part of the interdiff between the previous roun=
d and
> > this round makes the difference?
>=20
> Yeah, I'd also like a better understanding of what went wrong in the
> original (just to be able to better evaluate the tool).

I'm not completely clear on why Coccinelle made the transform that it
did.  If you look at the commit messages, the new patch is this:

  @@
  struct diff_filespec o;
  @@
  - o.sha1
  + o.oid.hash

  @@
  struct diff_filespec *p;
  @@
  - p->sha1
  + p->oid.hash

whereas the two pieces were reversed before.  This fixes the problem
because it's never possible for the second transform to match after the
first has transformed a given piece of code.  The functional interdiff
shows that only the issues the two of you found are changed.

> Also, for the record, the issue was noticed by Johannes originally, not
> me, as indicated above (I just found a similar case after seeing his
> report).

I apologize for the misattribution.

> > On a tangent, I wondered recently, why we need oidcpy() and oidclr(). A=
fter
> > all, in place of, e.g.,
> >=20
> > 	oidcpy(&pair->two->oid, &p->oid);
> > 	oidclr(&one->oid);
> >=20
> > we can write
> >=20
> > 	pair->two->oid =3D p->oid;
> > 	one->oid =3D null_oid;
> >=20
> > Is there a particular reason *not* to make this transition? I find the
> > latter less cluttered with equal clarity.
>=20
> I think traditionally we've avoided struct assignment because some
> ancient compilers didn't do it. But it's in C89, and I suspect it's
> crept into the code base anyway over the years without anyone
> complaining.

I asked about this earlier and Junio felt that struct assignment was
less desirable.

Also, if we do struct assignment, if we add a new hash, we may copy more
than necessary (e.g. 64 bytes when we're only using SHA-1); however,
this may be offset by the ability of the compiler to compute the offset
at compile time.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXZtWSAAoJEL9TXYEfUvaLkvgP/jHZiXSu3A97tt971pGP3GK3
o4+E+7dXS9xioEINKnYCiljrYqDrIatlujE8fb+xxteDe7ZT6SAfmB1WUsKSC8CI
T044oTpLG4hVKoxSyaPQxe9UwR8p5E7JLFfNWEa8XyyFU+3D3bAD3oiEaxzdhZwy
hKeP2d/njpaj9PyE5zqd7cj8sl/Q2np5pZ2aJ4YVUle09E6Z6Gvx1raKMyjgnJXo
7kdr/Rp7qCYkJqLrzJKvyYXeAjFnZ+g39FPyM1rszfAJpWcUHnhQkdmCAODuhSIF
R2ddm3zVa/TF+blRlRMlyUL8j0orUcPYsh8gIrtrg2Y6dC3AfBHMtggThqaHQ7c/
jb/nmB18nf+FDGfFU8fUan1sp8Xdo2MghBMxGpP8rnwRq08Q+1Um80WzL7cj3NKq
PxgjKC5ZVi/7lJkGI0KULo/kJUky/VpNhw2/UMbAQxM9D6xtyJugRT7fQ2hYgeqJ
yDK4EoFfkTTZo6lU76nWVO0iEoH2mJtOuEwMq7JWHJiQMieHLxVtxzuvY2G5uwnD
frXsp4Ln2po7VzOG39HmE2u0WOQTRJGG/x3uS0M6Y+odBs6LBC3W22406yROt4zm
1v05bHUhxS6yQtBvXrpHScdRsQwfWij8JU4y3/3ZP+jy+nO3Ws+qU2qXh7ljL8zd
1266rEYQs3B0vZPSBtgM
=tFcz
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] new test fails "add -p" for adds on the top line
Date: Sat, 16 May 2009 16:12:22 +0200
Message-ID: <200905161612.30911.trast@student.ethz.ch>
References: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com> <20090516192529.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2758120.4o2knWFYyk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat May 16 16:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Kdr-0007CS-Ew
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 16:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbZEPONT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 10:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbZEPONS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 10:13:18 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:20904 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782AbZEPONR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 10:13:17 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 16 May 2009 16:13:12 +0200
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 16 May 2009 16:13:16 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <20090516192529.6117@nanako3.lavabit.com>
X-OriginalArrivalTime: 16 May 2009 14:13:17.0058 (UTC) FILETIME=[753E9620:01C9D630]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119362>

--nextPart2758120.4o2knWFYyk
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nanako Shiraishi wrote:
> Quoting Matt Graham <mdg149@gmail.com>:
>=20
> > add -p doesn't work for some diffs.  diffs adding a new line at the top=
 of
> > the file with other adds later in the file are one way to trigger the p=
roblem.
> >
> > during add -p, split the diff and then answer y for all segments.  the =
file
> > won't have been added to the index.
> >
> > Signed-off-by: Matthew Graham <mdg149@gmail.com>
>=20
> I tried "git-add -p" from different versions and I found out that version=
s before the commit 0beee4c6dec15292415e3d56075c16a76a22af54 doesn't have t=
his problem.
>=20
> commit 0beee4c6dec15292415e3d56075c16a76a22af54
> Author: Thomas Rast <trast@student.ethz.ch>
> Date:   Wed Jul 2 23:59:44 2008 +0200
>=20
>     git-add--interactive: remove hunk coalescing
>    =20
>     Current git-apply has no trouble at all applying chunks that have
>     overlapping context, as produced by the splitting feature. So we can
>     drop the manual coalescing.
>    =20
>     Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

The above commit still reverts cleanly, but AFAICS merge_hunk blindly
trusts the hunk headers, an assumption that is no longer valid due to
the 'edit' feature.  So either we need to recount the hunk headers
prior to merging (which was rejected back in the 'edit' feature
discussion due to code complexity) or find some other solution.

Passing either --unidiff-zero or -C1 with the failing patch fixes the
problem, but oddly (to me at least) -C2 does not.  The generated error
looks like

  $ git apply --check -v -C2 < patch
  Checking patch file...
  error: while searching for:
  baseline
  content

  error: patch failed: file:1
  error: file: patch does not apply

The corresponding call (builtin-apply.c:2093) is

			error("while searching for:\n%.*s",
			      (int)(old - oldlines), oldlines);

so it does not seem to insert the extra newline.  Is it actually
looking for a blank line in the context?  If so, wouldn't that be a
git-apply bug?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2758120.4o2knWFYyk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoOyc4ACgkQqUud07tmzP0yDwCffLMTHS0b81Pw0YOkQzccPMgO
B64An3qXmhm4p0gKyTZttVVGrvTlS6Mk
=RtNv
-----END PGP SIGNATURE-----

--nextPart2758120.4o2knWFYyk--

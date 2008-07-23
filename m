From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-checkout: fix argument parsing to detect ambiguous arguments.
Date: Wed, 23 Jul 2008 03:13:22 +0200
Message-ID: <20080723011322.GH11831@artemis.madism.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="e5bfZ/T2xnjpUIbw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 03:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSvx-0003Df-33
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbYGWBNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYGWBNZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:13:25 -0400
Received: from pan.madism.org ([88.191.52.104]:35584 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYGWBNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:13:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 79677CE2;
	Wed, 23 Jul 2008 03:13:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4824014248F; Wed, 23 Jul 2008 03:13:22 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1216774940-4955-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89588>


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 01:02:20AM +0000, Pierre Habouzit wrote:
> Note that it also fix a bug, git checkout -- <path> would be badly
> understood as git checkout <branch> if <path> is ambiguous with a branch.
>=20
> Testcases included.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>=20
>   A user on #git happened to have issues that made me realize that
>   builtin-checkout is badly broken wrt argument parseing.
>=20
>   This clearly needs to be applied to master, probably to maint too.
>=20
>   The patch is against next though, but should probably apply to other
>   branches just fine.
>=20
>=20
>  builtin-checkout.c            |    9 +++++++--
>  t/t2010-checkout-ambiguous.sh |   27 +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 2 deletions(-)
>  create mode 100755 t/t2010-checkout-ambiguous.sh
>=20
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index fbd5105..1490e8e 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -438,9 +438,14 @@ int cmd_checkout(int argc, const char **argv, const =
char *prefix)
> =20
>  	opts.track =3D git_branch_track;
> =20
> -	argc =3D parse_options(argc, argv, options, checkout_usage, 0);
> -	if (argc) {
> +	argc =3D parse_options(argc, argv, options, checkout_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (argc && strcmp(argv[0], "--")) {
>  		arg =3D argv[0];
> +
> +		if (argc =3D=3D 1 || strcmp(argv[1], "--"))
> +			verify_non_filename(NULL, arg);
>  		if (get_sha1(arg, rev))
>  			;
>  		else if ((new.commit =3D lookup_commit_reference_gently(rev, 1))) {
> diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
> new file mode 100755
> index 0000000..c1a86a2
> --- /dev/null
> +++ b/t/t2010-checkout-ambiguous.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +test_description=3D'checkout and pathspecs/refspecs ambiguities'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo hello >world &&
> +	git add world &&
> +	git commit -m initial &&
> +	git branch world
> +'
> +
> +test_expect_success 'branch switching' '
> +	git checkout world --
> +'
> +
> +test_expect_success 'checkout world from the index' '
> +	git checkout -- world
> +'

  Okay those two tests are stupid in the sense that they don't check
git-checkout does what it's supposed to do. One should check the first
one outputs 'Switched to branch "world"'

  and the second should rather be:

'
  echo "bye bye" > world &&
  git checkout -- world &&
  git diff --quiet --exit-code
'


--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGhbIACgkQvGr7W6Hudhyk1gCgnjGFmK/1KNH2+LyWN9597K4l
XMcAn1R4HlcXj940/qGZacBaoIXte+pP
=VYyN
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--

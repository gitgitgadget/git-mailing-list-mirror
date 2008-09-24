From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] maint: check return of split_cmdline to avoid bad
	config strings
Date: Wed, 24 Sep 2008 11:28:47 +0200
Message-ID: <20080924092847.GD23137@genesis.frugalware.org>
References: <20080924061028.GA2792@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Wed Sep 24 11:30:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiQh6-0001pE-KG
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 11:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbYIXJ2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 05:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYIXJ2v
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 05:28:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52768 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbYIXJ2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 05:28:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 463011B24FA;
	Wed, 24 Sep 2008 11:28:48 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BC63D4465E;
	Wed, 24 Sep 2008 11:28:47 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7D35A11901A1; Wed, 24 Sep 2008 11:28:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080924061028.GA2792@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96624>


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2008 at 02:10:28AM -0400, Deskin Miller <deskinm@umich.edu>=
 wrote:
> As the testcase demonstrates, it's possible to have split_cmdline return =
-1 and
> deallocate any memory it's allocated, if the config string is missing an =
end
> quote.  In both the cases below, the return isn't checked, causing a pret=
ty
> immediate segfault.

I think this could go to the commit message.

> diff --git a/builtin-merge.c b/builtin-merge.c
> index b280444..dcaf368 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -442,6 +442,8 @@ static int git_merge_config(const char *k, const char=
 *v, void *cb)
> =20
>  		buf =3D xstrdup(v);
>  		argc =3D split_cmdline(buf, &argv);
> +		if (argc < 0)
> +			die("Bad branch.%s.mergeoptions string", branch);
>  		argv =3D xrealloc(argv, sizeof(*argv) * (argc + 2));
>  		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
>  		argc++;

ACK.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 64567fb..3794d23 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -741,4 +741,14 @@ test_expect_success 'symlinked configuration' '
> =20
>  '
> =20
> +test_expect_success 'check split_cmdline return' "
> +	git config alias.split-cmdline-fix 'echo \"' &&
> +	git split-cmdline-fix || test \$? =3D 128 &&
> +	echo foo > foo &&
> +	git add foo &&
> +	git commit -m 'initial commit' &&
> +	git config branch.master.mergeoptions 'echo \"' &&
> +	git merge master || test \$? =3D 128
> +	"

Why don't you use test_must_fail here?

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjaCE8ACgkQe81tAgORUJajqwCdG63Al5ugY37mVVEv/0AD4cTK
XecAoJvSrp6z7EJd1DnqcAAWsJOe/2QN
=DF2l
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--

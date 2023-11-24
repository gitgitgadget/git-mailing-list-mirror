Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2C31726
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7FFMl/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FACDC433C8
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700840948;
	bh=OJtCSFmEPRllwZc+DkkKHYRPALRcsGo3ZWXvR8JusME=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=c7FFMl/ITuRcZKCITANwnfg3g4vr2yU2fxYCNcIbp+9N5k2IG7322ItlOmA9sRMcJ
	 +RkgZk4U5l27Kpcll3zYBLFXLVov4DCT2wBVgQbFL4sF3T4bwaftXLIuqFjTn6sXf5
	 p/O4EGYgxZFAXy1FfMmreVlHO+BCVhW8cvoWIqM93+ztqEMjQEJPCYN98QyBDcSPR+
	 hGpYOAUuU6hNMg48JAXcI/1/kIpXOF7G9/KemDFU7EwdA/K4TMSQ7b7M6DtjYKsToN
	 GL48t0z8nM/QLKjunZLlpNFy0vMUSI10QiBylyytYs4kT3xfo9Pr+42VA0KUAY+XZz
	 hcoUX/vsTP0WA==
Date: Fri, 24 Nov 2023 16:49:05 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Re: Running git(1) from within hooks/post-update
Message-ID: <ZWDF8TBw_YM3UC6N@debian>
References: <ZWCsd3cJZ3LAqOwg@debian>
 <ZWDEWDTtiFYAYp2P@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mjHBs1irstkZgaMI"
Content-Disposition: inline
In-Reply-To: <ZWDEWDTtiFYAYp2P@debian>


--mjHBs1irstkZgaMI
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Nov 2023 16:49:05 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Re: Running git(1) from within hooks/post-update

On Fri, Nov 24, 2023 at 04:42:16PM +0100, Alejandro Colomar wrote:
> On Fri, Nov 24, 2023 at 03:00:22PM +0100, Alejandro Colomar wrote:
> > Hi,
> >=20
> > I'm trying to set up a post-update hook to produce a build of the Linux
> > man-pages PDF book after every push to my personal server to the 'main'
> > branch, so that I can serve man-pages-HEAD.pdf at some URL, for users to
> > be able to easily check the manual at git HEAD without having to clone
> > the repo.
> >=20
> > I thought of having a git non-bare repo where I build it, so the script
> > would be the following (the paths are tmp, because I'm still testing).
> >=20
> > 	$ cat post-update=20
> > 	#!/bin/sh
> >=20
> > 	test "$1" =3D "refs/heads/main" || exit 0;
> >=20
> > 	cd ~/tmp/man-pages/;
> >=20
> > 	whoami; pwd; ls -ld .git/;  # This is for debugging.
> >=20
> > 	git fetch srv			#>/dev/null 2>&1;
> > 	git reset srv/main --hard	#>/dev/null 2>&1;
> > 	git clean -dffx			#>/dev/null 2>&1;
> > 	scripts/LinuxManBook/build.sh	>~/tmp/LMB-HEAD.pdf &
>=20
> The script works fine when called manually.  It seems it's calling it
> as a hook that fails.  It seems it's running git(1) from within a
> post-update hook that is problematic.  Is that expected, or is it a bug,
> and can it be fixed?

Ahh, after this I've found it documented in githooks(5):

     Environment variables, such as GIT_DIR, GIT_WORK_TREE, etc., are
     exported so that Git commands run by the hook can correctly
     locate the repository. If your hook needs to invoke Git commands
     in a foreign repository or in a different working tree of the
     same repository, then it should clear these environment variables
     so they do not interfere with Git operations at the foreign
     location. For example:

         local_desc=3D$(git describe)
         foreign_desc=3D$(unset $(git rev-parse --local-env-vars); git -C .=
=2E/foreign-repo describe)

Never mind.

Thanks,
Alex

>=20
> >=20
> > But it's not working.  The git(1) calls are failing, saying it's not a
> > git repo, but it clearly is, and I have permissions, so I don't
> > understand what's going wrong.  Here's the 'remote:' output of a push to
> > that testing server:
> >=20
> > 	remote: alx
> > 	remote: /home/alx/tmp/man-pages
> > 	remote: drwxr-xr-x 8 alx alx 4096 Nov 24 14:41 .git/
> > 	remote: fatal: not a git repository: '.'
> > 	remote: fatal: not a git repository: '.'
> > 	remote: fatal: not a git repository: '.'
> > 	remote: hooks/post-update: 12: ./scripts/LinuxManBook/build.sh: not fo=
und
> >=20
> > Can you please help?  :)
> >=20
> > Thanks,
> > Alex
> >=20
> > --=20
> > <https://www.alejandro-colomar.es/>
>=20
>=20
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--mjHBs1irstkZgaMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVgxfEACgkQnowa+77/
2zLDlg/+OTX9MnOdTpHN32gXmXvARfMEQj4FwsnIpQ0v9bky/HluipGqAsyLgAE7
JS4ZQheTfgHO2kL5xZtAyV5CTHBvNHWUgrvKI0NqHjrqwgS41HvSnUEr4PNDVLB7
2Qx3t9wx4S2+jlW/jD373BiX1RtP8IY2I+KO846QfiwpIBo2BlbTFHOkjaxRHKbS
KXuZMkEzW0YshkN1OMr3hR2JqtQ3ulYyiwDImEhC9jKAUzY3DSes5vycdxvKqT/o
Pva6LITqzOk8Xt16fqTdRdPzr3MCjAjTtzISSHRwf7yyYIHiYVNqs/RRK4bCgNmT
9SEbYCZbhFVuX2mYnoNkbjUyqcOsaC/l1Na1N8W8aPwdW3QV3seMrIz/tCvPIPv7
pCK+sqUyZxqDzJqg4o4bM7DlnMSrbHer3/wHSd/iCRFB1rceZ1BzaiLcqLdAiDEt
oOwbvLulrEKoBp2KuCKPfcMWU1YVOCJZ6zuwUp7R/aadd+d/7DZOCLVhxS5nXk5D
r0vuUzKsyERFqEyFjHkb+oZovgHNv6rtFM6enI7ezVDFtowGrvBdj0IkR5tzrppi
cVck0ge2g8mwH4Xhp3MVSSlhI8KMpIa2VcDx5fSs6Ft8wqoKuQxjhsj78Yq9MnFE
B9/cHOWeiDeZyowiBJXLtoBI8rVqfEYhLAv7dOoxVKapjhXMXQ4=
=HMIs
-----END PGP SIGNATURE-----

--mjHBs1irstkZgaMI--

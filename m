Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47045208C3
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481912; cv=none; b=moiIkWeprGfFSBQbFYY8ofSvVg7llpEDobaYqK9PtsyCSNmcpumkBKzhdfWfAFXbmnNIbg8ZaVukiRmQwKz2AMIbCqSXNYfMob+n5fuP9u5TtVTR4ta5MJuA9ErnwzC7TUy0e6c3NfvRxfn3L0i48o7V43t3FfAYIiP7/R/5/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481912; c=relaxed/simple;
	bh=s92G5HTAFuPIxBtFNdR6lqt69EglWpuEcfWhj4eRFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0H6ro212ZweFIF/xIe1ZI+YBmkLcUi3Zix0y2RHXNSdco0PrErlHEgRPO9FVbz3XSavRQHqm2oL2LN3X4w28TCdlrzcP+GSJnbTTdgaB5sjH2GcGZY8lVcQxPiiMr7kk3lTMIBmi/1il1yZZtNkszehr2l6FCluv8Ehh5OCfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=cYv9LP0D; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="cYv9LP0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1716481897; bh=s92G5HTAFuPIxBtFNdR6lqt69EglWpuEcfWhj4eRFIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYv9LP0Dy2qUgyqAHSUhi3oz7FWRk3XBJXQN2Qa3uiJ9h6bJN7edoMuYWC/JInbvc
	 f8a+4g/IOmJp0dixsvIj1rv2gC7zK3F+ZKzj4eXjYkraIkS7enq5Oc44BBJoH1PGys
	 ciu91y6wJzRMWEnId/KQ451muw5q8NWlR1GBmE7o=
X-Question: 42
Date: Thu, 23 May 2024 12:31:37 -0400
From: Joey Hess <id@joeyh.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
Message-ID: <Zk9vafYPijqyWpXv@kitenet.net>
References: <20240521195659.870714-1-gitster@pobox.com>
 <Zk3ChIHr5amGh8Mt@kitenet.net>
 <xmqqv835xekc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u41pnQEbGvZFuKoW"
Content-Disposition: inline
In-Reply-To: <xmqqv835xekc.fsf@gitster.g>


--u41pnQEbGvZFuKoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
>  - The extra check seems to have meant to target the symbolic links
>    that point at objects, refs, config, and anything _we_ care
>    about, as opposed to random garbage (from _our_ point of view)
>    files third-parties throw into .git/ directory.  Would it have
>    made a better trade-off if we tried to make the check more
>    precise, only complaining about the things we care about (in
>    other words, what _we_ use)

I wondered about that possibility too. But it's not at all clear to
me how a symlink to .git/objects/foo risks any more security problem
to git than one to .git/annex/whatever, or indeed to /home/linus/.bashrc.

Git clearly has to get the security right of handling working tree files
that are symlinks.

The security hole that triggered this defense in depth, CVE-2024-32021,
involved an attacker with write access to .git/objects/ making a symlink
in there while another repo was cloning it. So it involved symlinks
inside a remote .git/objects/, which is very different than symlinks
into .git/objects/.

While it's understandable that dealing with such a symlink related
security hole may make one want to throw out the baby with the
bathwater, this fsck check is more like you've kept the bathwater and
only thrown out the baby. ;-)

>  - In any case, if it is merely warnings, not errors, these checks
>    can be configured out.  Wouldn't that be an escape-hatch enough?

The issue with that is, as we've experienced with Gitlab, git hosts that
choose to set receive.fsckObjects will prevent pushes of git-annex
repositories, and there's probably no way for a user to configure it
out. So every major git host that does it has to be approached to
configure it out, and some fraction probably won't. Which will be a
major impact and ongoing concern for git-annex users[1], all for
something that certainly adds no security to a bare repository on such a
host.

> I am not sure which one is more practical between ripping
> everything out and demoting these new fsck error types with
> FSCK_WARN to FSCK_IGNORE.=20

It could indeed be beneficial to have some kind of symlink check that is
at FSCK_IGNORE by default. If someone is receiving a repository from an
untrusted source, and doesn't want to deal with the security risks of
symlinks in the working tree, they could configure it to be an error.
Such a symlink check would probably need to catch more symlinks than
only the ones into .git/ though. Having this available to git users
seems like it could prevent a much larger class of security holes.

As for the symlink length check, I do think it makes sense for fsck to
notice symlinks that are too long to make sense for any OS and so picking
some appropriate value, rather than the local PATH_MAX, could keep that one.

--=20
see shy jo

[1] I'm particularly concerned about the class of large institutional
    users who are managing more data with git-annex than the total size of
    all of Github[2]. They have a good reason to be risk averse,
    and it could be a major disruption to cross-organizational workflows
    and need updates to DOIs etc for them to switch hosting providers.
[2] https://hachyderm.io/@joeyh/112486445240754919


--u41pnQEbGvZFuKoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmZPb2cACgkQ2xLbD/Bf
jzjpUg/+K+TmCEb9JQ7QmREgocCoiMqJYt4x42VduF+RlNP1eW4m1xlwKxCMBNfE
/e/ysUBjpW3zT1vRrvzRBXkKDBo02tsG1g9iuTCI1HiCel/Zci22ITqvY3+cstHd
Na7gJZQetnKEpdoEXK9Etk1+IVdNCeLBqJr91tYkAAYexdN1EFxD6sPQr3qDjfNd
RTH0GnwrWljdt1fIWWcABOVWaraMPVoJRTxoVRY6coxSiILY2ifuCXthi1WA7vje
MmB4b+3FD0fOdKYZvooKysowYczDQufd6/XXTJL/8Jt+dZBTHv1/hDRFoDr829D4
627PrSLZyTBJV8j3TAPJBzU5x29hc8U8I9anh0UZauG4Cuttwz8tEioeXUeKVpHn
zCCQaXEJLzfaJVvQY37LTtyJQCLq7KTkxxNOmOlPPkkHkp7Lxp67/fk6Ppdnj1lV
ielNdpbm4hgUKIMhSnBMl75ZpAmCt3+4FV+h5eXPEuJRdBCwr1niACj6k/7hOMKB
vW6l9VoP4t4jlSqbzJIOWFX3H8Ajwjh0p95ATBpT+izFcORkkfjh2E6fAbTsTJYu
jn1Qc4MNJ282BT4wD2p9R6fDNQgO9qfFXbqzcsZ+qFmJ3HVCP0ojujfoWJFlKIfV
0V5oEnwLUljJaZztKJkgc6B+TJeeCwQIZIyW/Fnh6h3Qon74QXU=
=mS2E
-----END PGP SIGNATURE-----

--u41pnQEbGvZFuKoW--

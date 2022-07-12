Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E789C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 10:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiGLKWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGLKWj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 06:22:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58300ACF6A
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657621356;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=PiMwQbqldIw1C3nZdT1mXTDTd8a97K1D3kHYxTsvQ3I=;
    b=FdD8glGABCL7C0TNjTYMJma3ZBWR1zjpeFTsBRClHN3TQBlPA7vrG969dI0tMqZCrl
    hWSq9+JkSRpCOPkocAXk9zPn0r8v7StaYLqeVlWvoiGGj2IxW1H7S/OULPW2K6HmC7IE
    qS0JcQz2UDyoLyHV9s3bVuLyRVk/zA3vRlEkBJWp4wvVIubE7MghwtCygJdtAUc7Vn4E
    YrCHm2cjD/PVbKAqCh4EwS2Mypvb8gnqIWAokzRinmTYmGbi7I5nFLI8SV43BxfzmhhC
    B5eg4nW0Ni38jtS/g6OyOh4YhGeNsFhqiwOJBY1P69ZeO+H0a6p+iFBgU5kImF+m00Tr
    085w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuDsbSEit9KU5r3k6L5NRbajILDt10="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.46.4 AUTH)
    with ESMTPSA id k61132y6CAMa4Tf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 12:22:36 +0200 (CEST)
Date:   Tue, 12 Jul 2022 12:22:26 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git tag triggers out-of-memory killer
Message-ID: <20220712122226.183fff9b.olaf@aepfle.de>
In-Reply-To: <YswuaPx6Mk7YkIim@coredump.intra.peff.net>
References: <20220711153135.35b1b135.olaf@aepfle.de>
        <YswuaPx6Mk7YkIim@coredump.intra.peff.net>
X-Mailer: Claws Mail 20220621T115632.b389e5f8 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nnH2N/M8ttr3Tg/nJIvv+5M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/nnH2N/M8ttr3Tg/nJIvv+5M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 11 Jul 2022 10:06:32 -0400 Jeff King <peff@peff.net>:

> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -486,6 +486,8 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  	int ret =3D 0;
>  	const char *only_in_list =3D NULL;
> =20
> +	save_commit_buffer =3D 0;
> +
>  	setup_ref_filter_porcelain_msg();
> =20
>  	git_config(git_tag_config, &sorting_options);
>=20


Thanks, this patch helps.

The individual git processes start with a maximum of ~320M, and slowly reac=
h around ~600M as maximum.

I was not aware of commit-graph. After writing a commit-graph the processin=
g is much faster, and an unmodified git 2.35.3 uses ~320M as a maximum.

Olaf

--Sig_/nnH2N/M8ttr3Tg/nJIvv+5M
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmLNS2MACgkQ86SN7mm1
DoBfTg//XysOYzfHMPDu1laZrItKZqMwTFKqywivoJTAe4JassnbDFK+IODFd1V5
Wjbo138HBAG5KrB34ouy6o1B5q+IpgDich5Q+Yy2pJ5oYpVSo8hy6aX9vBeFwa+V
fN/kr+XO+0MmTPMqkYO1jLz3xbWSOaLqOl0wNYAbXnU0G4kMnDOm1ZkzFOxqoBKt
IbdnutleUcltzSMdh1hOkmarlgYus0EXRo/QDzWY8wAmv9RHeICSYp+v1vatakM4
VciciMPvpteaMNDUKtSOBgiWEeS5h9wYetILqcXSN09NPVSrsgAd0+Tci8+RyRJk
ib4F7HsoSNGUIDEZoFcqwNaNb47xd/M3Kpk4Plmr80gBPAUOCfNKaaNWWYhc1IGU
NDf1/rQ84pDEfK5hx/sCP8TjxgSzqp9bB+ti3wwifi5Nrk30VrhHfpfRo8TjoTif
vqI0wkLJiDaGA6x2rBYegMCkUxD6zce1YuI0v30retWcCiW5eA/pSu1zCi90tAZB
MGKosR0BT9rwouln88QxzCIRqOzJWhdBCnvqWKSZrVK9KQBmlB6YjMiVejj/fUYx
3J/4uhpX+mVpyFF7UvqJdiFtDLyi1+SF3IPDE93BPxA2FSeEOFck2/gXnQ4DWeL/
dMArnwH91veofCMGW/yYzBooO6fiCS+hbM7fl8u2CBSpZXst+zc=
=8gLu
-----END PGP SIGNATURE-----

--Sig_/nnH2N/M8ttr3Tg/nJIvv+5M--

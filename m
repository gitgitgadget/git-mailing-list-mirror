Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C8DC6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 21:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUVNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIUVNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 17:13:23 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5F5E557
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 14:13:19 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4591F5A26C;
        Wed, 21 Sep 2022 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663794798;
        bh=8EcJ3q/I2H02kqSuTmHnsJVL0k6gI1hLmMqHawnWyFA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xidRlfptmT/2TKSD5cIDVc0WEesNBZZ+bzjQVwQX7jHQVy7AV7D+9Vl6KWrAadhbu
         LsQct49Q3QQVch3T07aI2K7umRjWHuDEUH4KFyDu0DFUivD0dDplQYqXc4Z2byvgip
         /DkWlW/IzYKduNlpwCmRVDNGih9vlENcz2ecM9qsOIbN0d90rqxXT7lRfGN4LDyVWL
         WceSPTVX9gq7ZrsSbdalLVzSA7wTB2skaaw0hGuDNtf3Tavmv/0HHLsu71RY8b+NMg
         hU9k9LzcdfWT3v7J/xM8DwW846tAEffQdvQItkNyl3c3wRmL5SLW6sCXpoKfoPCeR0
         DIJnik3DSN1elkHaFLeXbUiRbMEtQxOEHR3i3VQIEGaIjWoYARjtyRJ1882WZc1oJ0
         /iiC/Opk7waTF95h9QvsJX/TMrJ5fem9NRWUeA3EEjFn3KGsLBlL546TM/jiP44n1V
         Xn9ZTV1fBBiX08WObSaeq4iohXomeU43lhFqdRYfIyFK/+ELGKI
Date:   Wed, 21 Sep 2022 21:13:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jan Tosovsky <j.tosovsky@email.cz>
Cc:     git@vger.kernel.org
Subject: Re: Preserving credentials on authentication failures
Message-ID: <Yyt+bAllVYJ9+SXa@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jan Tosovsky <j.tosovsky@email.cz>, git@vger.kernel.org
References: <007401d8ccc6$ef8ebe50$ceac3af0$@email.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="06fD6Yo97Z4nViPp"
Content-Disposition: inline
In-Reply-To: <007401d8ccc6$ef8ebe50$ceac3af0$@email.cz>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--06fD6Yo97Z4nViPp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-20 at 07:59:38, Jan Tosovsky wrote:
> On my local Windows machine I maintain a credential store in the form of a
> text file. But from time to time one of the entries disappears. I run
> regularly some background jobs, cloning some stuff, and I suspect this
> happens when the external authentication service is down temporarily. When
> it is later resumed, I can't clone the repo anymore because of that delet=
ed
> entry.
>=20
> Is there any option to keep entries on authentication failures? Or is this
> simply a bug? Or is there another reason why this happens?

If you have a credential helper and the credentials retrieved from it
cause the server to send a 401, then Git will erase the credentials and
ask for new ones.  If your auth service is down, then the best thing for
your Git server to do is return a 503 if service cannot be maintained.
If it returns a 401 (which is not correct according to the RFC), then
Git will clear the credentials.

Git doesn't provide an option to preserve entries on authentication
failure, but you could write a simple shell script that wraps your
normal credential helper and ignores the "erase" command and use that
instead in `credential.helper`.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--06fD6Yo97Z4nViPp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYyt+bAAKCRB8DEliiIei
gXMZAQCkwrsm54daw6I187fLT2x0TIymQo4rg49sBQK4OEuMKgD+Jm02Q/wRAqze
jZTVBl3ZgD/8tgLQbz6SaFOKXPevrQM=
=6PkS
-----END PGP SIGNATURE-----

--06fD6Yo97Z4nViPp--

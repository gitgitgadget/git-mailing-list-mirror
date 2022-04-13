Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB70FC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 22:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiDMWf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiDMWfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 18:35:24 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC349928
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 15:33:01 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 073CA5A0CA
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649889181;
        bh=hfeJhDVjrZEJqYjoLEYws6+0WKpN3ryWukmsMiF0jb4=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=yukethdxSYw/CHSfW6IiqkqU7uTg7uIOxpEQaM3qYtIgdvTRuBldWvPPikdfjkEsD
         7wlTadhISEkdEK70eJgkeTU7QCS5jS+aBOvrrkWpO3DfhG6LqK7/yFxu9cwlvFFwA/
         1UCZXOZ4G8SoUwHKVQrju/IbzU8U25a5YTERYSiekUGx3MpK0vB2XC1mmga72ap0ZU
         nHFfieMSJ/JNOLF6x1ObQtXeUq1rX65A3Ivt6ZBw5rWWcPYwwZEUnTJ+mAh66ZStgX
         JB4mFDfV/1r6Q+vDSscp03GOz8zRpRpvMXP56T8ZkioGY0pPa+RL2DUg8JDnPcZ5Fc
         PojkRsIPS2vqkM2ZQb0kY77UziAnPoHmoN4hEROqnn4Osw0SLTfHlH/QMF+vvrJpwH
         Liz9pcypOdKZ46vvzFEdvdlwxEAfYWyJ/sHDLFw+i83VIKwutHn8boWGOjDL7N8ffZ
         xV1v9qBqZlw2D1uOqcyFFbHUfr9KnJlVDzzKUtbXptQen4lRo9V
Date:   Wed, 13 Apr 2022 22:32:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Pathological performance with git remote rename and many tracking
 refs
Message-ID: <YldPmUskbU+bOU2n@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WpH6/3HkziuP/SjL"
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WpH6/3HkziuP/SjL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In my day-to-day work, I have the occasion to use GitHub Codespaces on a
repository with about 20,000 refs on the server.  The environment is set
up to pre-clone the repository, but I use a different default remote
name than "origin" ("def", to be particular), and thus, one of the things
I do when I set up that environment is to run "git remote rename origin
def".

This process takes 35 minutes, which is extremely pathological.  I
believe what's happening is that all of the refs are packed, and
renaming the ref causes a loose ref to be created and the old ref to be
deleted (necessitating a rewrite of the packed-refs file).  This is
essentially O(N^2) in the order of refs.

We recently added a --progress option, but I think this performance is
bad enough that that's not going to suffice here, and we should try to
do better.

I found that using "git for-each-ref" and "git update-ref --stdin" in a
pipeline to create and delete the refs as a single transaction takes a
little over 2 seconds.  This is greater than a 99.9% improvement and is
much more along the line of what I'd expect.

I thought about porting this code to use a ref transaction, but I
realized that we don't rename reflogs in that situation, which might be
a problem for some people.  In my case, since it's a freshly cloned repo
and the reflogs aren't interesting, I don't care.

I think a possible way forward may be to either teach ref transactions
about ref renames, or simply to add a --no-reflogs option, which omits
the reflogs in case the user doesn't care.  I'm interested to hear ideas
=66rom others, though, about the best way forward.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--WpH6/3HkziuP/SjL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYldPmAAKCRB8DEliiIei
gTF5AQCKeroa21eeaJThSiGs2+IN61Qi1gY+K49cyOYNjSGAtQD/T53YZJvXE8z4
6Glhs6YpQrvqoKlV8dzJ6eBZGqNRPg0=
=m9eD
-----END PGP SIGNATURE-----

--WpH6/3HkziuP/SjL--

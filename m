Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC6C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 21:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5085764E2C
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 21:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBNVv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 16:51:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48548 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229916AbhBNVvz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Feb 2021 16:51:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7B3C260B15
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613339442;
        bh=1oGKtmau4M9P2EmdMCft8opRTkRtX6Rmihe+4s4biCk=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=FfhpusRZC0AnU+YNDKAX5ilWsjBF9ZZTNTfcFTleewzr6gxDRPCq+YTzMLAt9F9jc
         0+piNfk/oARmCBwEW1LmDcdDF4f2WYiCywohgap/AzXJX6EDJcBOEiceDkPlAIGyAZ
         vSEDLqU+e7J1jzXr1XOPNKpkCdBCNYIH1Tu/Jci4TuMvPWvIJB0KDGzw2jywTIgl9K
         P4UcAhBua+Yivn3Wpf3FruoqN86wdh0z/V8kMkRpIzzER1IkrUCnV0jNOnwbw263Su
         eU+EUsgEEU1xe64qKLhm0tawwSJ2UUB2JpvRjctyL4J2Q6PbWGAAgAw3/7g/zcU0E1
         4iOXcCFAfgYbvTHejCFDmKn9BO5xsj7wPIgmclFFjV6Ib/YEkSUO/QY/mP7SaJS5X7
         6GntApBL3o2K3MWLIpGS7umnY803n+CEaroZxrpBXsJGjb86xySAMSJ5F6zKmilAOH
         wu4Iq5g6MrXT00HyfSMLCM0M2Q0bFb2lkH6lHWf7KnOcsifvs3+
Date:   Sun, 14 Feb 2021 21:50:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Submodules and SHA-256/SHA-1 interoperability
Message-ID: <YCmbKrTsJhgPHYLc@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bV/rUc5OSP/ZMmnc"
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bV/rUc5OSP/ZMmnc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm currently working on the next step of the SHA-256 transition code,
which is SHA-256/SHA-1 interoperability.  Essentially, when we write a
loose object into the store, or when we index a pack, we take one form
of the object, usually the SHA-256 form, and rewrite it so that it is in
its SHA-1 form, and then hash it to determine its SHA-1 name.  We then
write this correspondence either into the loose object index (for loose
objects) or a v3 index (for packs).

Blobs are simply hashed with both algorithms, but trees, commits, and
tags need to be rewritten to use the SHA-1 names of the objects they
refer to.  For most situations, we already have this data, since it will
exist in the loose object index, in some pack index, or elsewhere in the
pack we're indexing.

However, for submodules, we have a problem.  By definition, the object
exists in a different repository.  If we have the submodule locally on
the system, then this works fine, but if we're performing a fetch or
clone and the submodule is not present, then we cannot rewrite the tree
or anything that refers to it, directly or indirectly.

So there are some possible courses of action:

* Disallow compatibility algorithms when using submodules.  This is
  simple, but inconvenient.
* Force users to always clone submodules and fetch them before fetching
  the main repository.  This is also relatively simple, but
  inconvenient.
* Have the remote server keep a list of correspondences and send them in
  a protocol extension.
* Just skip rewriting objects until the data is filled in later and
  admit the data will be incomplete.  This means that pushing to or
  pulling from a repository using a incompatible algorithm will be
  impossible.
* Something else I haven't thought of.

The third option is where I'm leaning, but it has some potential
downsides.  First, the server must support both hash algorithms and have
this data.  Second, it essentially requires all submodule updates to be
pushed from a compatible client.  Third, we need to trust that the
server hasn't tampered with the data, which should be possible by doing
an fsck on both forms (I think).  Fourth, we need to store this
somewhere, and the only place we have right now is the loose object
index, which would potentially grow to inefficient sizes.

We could potentially change this to be slightly different by asking the
submodule server for a list of correspondences instead via a new
protocol extension, but it has the same downsides except for the second
one, and additionally means that we'd need to make multiple connections.

So I'm seeking some ideas on which approach we want to use here before
I start sinking a lot of work into this.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--bV/rUc5OSP/ZMmnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYCmbKQAKCRB8DEliiIei
gVXWAP9vzaMovZwKtYLLrJB+ClL+pernsH+P2QZzOS6l8lm/rQD+LrTccUEbhfXU
UlrACNzDVh7PjrNBRkfvj8GA+ye5/Q4=
=OvQV
-----END PGP SIGNATURE-----

--bV/rUc5OSP/ZMmnc--

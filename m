Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6262A1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbeKFGSc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 01:18:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53308 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbeKFGSc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Nov 2018 01:18:32 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E0C926077B;
        Mon,  5 Nov 2018 20:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541451417;
        bh=brH/XkGBm8F5bMe6ZPjgQYL/04FL1TZEmeE3YjpvmZ8=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=eD8Pl8MJGVuBjkQOeC6XILxFV6M5RNIroXdrzncTuBqfg52zW8Ua3Qn0cS+HrDIcS
         VQ7nGM4FVngz4ELQpWQjazNmsy+8dmODW7ar3qP+OcP1scu/dnJnhzfaTvWpB+fCxM
         KqMbZNRlSnRDIeTTHOlWB+0Morg4yBPT/5vPWWCNyeId9lKVWeduKahyBQCezJx7dT
         qt7A65yidjDfPpWDfc53GacqwVYPX3Dy2HS/n/0l4CgvrW+PUpHNzwKW+Hxu/+WIPi
         eKDddDJj68YBFCKgkNpW4yVBH80+oc55idLnL7Ti8b1cgTgRNI2/XmO1IA6WSVsGaz
         RCRYhnkaVXM7BvM47Sd1HPgkzvzXPMnnM8G2trzsRRSXwSYldl6emdyPf19m18AvmH
         mqVfCdknTDT+9G04EGxzoUVQtYIWsqkYhi7T1t/05arhYKelxITu2H4+/4Lbr1Doeb
         /MIbwqRkDqMnCX611xOlVl9tuzkOEM+e88+XbKBf7uJWxyqvCIE
Date:   Mon, 5 Nov 2018 20:56:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Subject: Wildcard URL config matching
Message-ID: <20181105205652.GA890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Patrick Steinhardt <patrick.steinhardt@elego.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In a272b9e70a ("urlmatch: allow globbing for the URL host part",
2017-01-31), we added support for wildcard matching for URLs when
reading from .git/config.  Now it's possible to specify an option like
http.http://*.example.com/.cookieFile and have it match for the URL
http://foo.example.com.  However, since this option also allows
wildcards at any level, the following also matches:
http.http://*.*.*/.cookieFile.

I'm wondering if it was intentional to allow this behavior or if we
intended to allow only the leftmost label (or labels) to be a wildcard.
The tests seem to test only the leftmost label, and that is the behavior
that one has for TLS certificates, for example.  I don't really see a
situation where one would want to match hostname labels in an arbitrary
position, but perhaps I'm simply not being imaginative enough in
thinking through the use cases.

Regardless of what we decide, I'll be sending a patch, either to add
additional tests, or correct the code (or both).

I ask because we're implementing this behavior for Git LFS, where we
don't iterate over all configuration keys, instead looking up certain
values in a hash.  We'll need to make some changes in order to have
things work correctly if we want to implement the current Git behavior
to prevent combinatorial explosion.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvgrpMACgkQv1NdgR9S
9ouScw/9HahUpy3OmVNwCOkyBafyH1LJcaHyzD4XgZfl69yoy4W+hgnN+DB489yF
8jwsrZPQ2UpRLrtiL6eOhTfAH/4RGvPQSaSKLllucyHVRBc0TMs+DDkOUo1imoCb
7Y7yrL0P/lSNFCO6HxUH3jYSthB+RGlYHwjaYQjlI5Sspk+dzQkz72kEnNVzapJ7
YmNNFZUkesrtLgz/83zqpQ4Lpw8JaAs24nynttetYCxkhgzS3xNMJVKj0fLnePEB
sAUhuIqraxWKX5uazAheoJLW/AA+w+mbdcbb1ORmlnhyHcpGyxcqhSQzfjkI/CkU
chnonvSIwiILs9tt9Z5W11eV1TSCIpY86mg+/3t0DVctvP1rOZPgyZMG259TN8+3
+pSvPhqNkW7lMKTPZLxQSX1/lx+39YiEHXaBK7TmMuYZJqAKzylyi/XcfFaGTKBY
RfkfAsfyWzuXEnn3+xrLMwiaah6xecLlwQws3Yu+hgqx5zHEpHJVJHNwjRdw5IlY
eF3Xj1Bf6mkKZ8W4FRBtTT4tUufCbHXd2FO9fsQATiiFXjxCiYfntbfljGvHnQ1K
cfqFIzSHOL5HUiHfM+SpZtm/OHjJb9YPpKokzX6ljm+Al92ZUjvcvwoGbSYgmVAY
73xIG2NH+M8P4/7gkeQMqlTpxZoVjlO4/7D94dszJHuk+ssfolI=
=mHKC
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

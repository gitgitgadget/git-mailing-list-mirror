Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB9C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 00:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJLAkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLAkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 20:40:43 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 17:40:41 PDT
Received: from pukcab.korelogic.com (unknown [139.138.148.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E772B48
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 17:40:41 -0700 (PDT)
Received: from mail.korelogic.com (mail.korelogic.com [205.134.174.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.korelogic.com", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by pukcab.korelogic.com (Postfix) with ESMTPS id 440EF2B200C2
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 20:33:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1]) by mail.korelogic.com with ESMTPSA id AD4C91EE0299 for <git@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=korelogic.com;
        s=mail; t=1665534808;
        bh=eV/fKrm8MHYj6yRbGic7aNmq5uvuFNL13dghphcE8NA=;
        h=Date:From:To:Subject:Reply-To;
        b=EJndUk0iSQP9o0N/qPQs74d2p1iU0PPkjfaFzr+U6U8Q85Xk3sUFUQugdGXvJy7KX
         e27/qW8qmzbmsJtNGIDJ4hOVfsk6TyJmrt90+7L/B7rCp2DpWn8ptCdRxbdcxXyvDB
         LwuLhZfESS/yrsR7vDsZ8MU61uxbATmfvC63prO8=
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.7 at mail.korelogic.com
Date:   Tue, 11 Oct 2022 18:33:26 -0600
From:   Hank Leininger <hlein@korelogic.com>
To:     git@vger.kernel.org
Subject: bug in Git.pm handling unsafe repos
Message-ID: <20221011182607.f1113fff-9333-427d-ba45-741a78fa6040@korelogic.com>
Reply-To: Hank Leininger <hlein@korelogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+J6BTSpRSC5conaE"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+J6BTSpRSC5conaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Git.pm dies with a syntax error rather than a meaningful message when
told to open a repo that the new logic deems unsafe.

What did you do before the bug happened? (Steps to reproduce your issue)

Create a bare repo as a different user, without registering it as "safe".
Then attempt to open that repo using the perl Git.pm module:

  patsy@foo ~/tmp/test-repo-bare.git $ id
  uid=3D986(patsy) gid=3D986(patsy) groups=3D986(patsy)
  patsy@foo ~/tmp/test-repo-bare.git $ ls -la
  total 36
  drwxrwxr-x  6 hlein hlein 4096 Oct 11 17:02 .
  drwxrwx--- 12 patsy hlein 4096 Oct 11 17:04 ..
  -rw-rw-r--  1 hlein hlein   23 Oct 11 17:02 HEAD
  -rw-rw-r--  1 hlein hlein   66 Oct 11 17:02 config
  -rw-rw-r--  1 hlein hlein   73 Oct 11 17:02 description
  drwxrwxr-x  2 hlein hlein 4096 Oct 11 17:02 hooks
  drwxrwxr-x  2 hlein hlein 4096 Oct 11 17:02 info
  drwxrwxr-x  4 hlein hlein 4096 Oct 11 17:02 objects
  drwxrwxr-x  4 hlein hlein 4096 Oct 11 17:02 refs

  patsy@foo ~/tmp/test-repo-bare.git $ perl -MGit -e 'my $repo =3D Git->rep=
ository'
  Can't use string ("/home/patsy/tmp/test-repo-bare.g"...) as a HASH ref wh=
ile "strict refs" in use at /usr/lib64/perl5/vendor_perl/5.36/Error.pm line=
 234.

What did you expect to happen? (Expected behavior)

A meaningful error because the repo is not safe to open, similar to what
'git status' produces:

  patsy@foo ~/tmp/test-repo-bare.git $ git status
  fatal: detected dubious ownership in repository at '/home/patsy/tmp/test-=
repo-bare.git'
  ...

What happened instead? (Actual behavior)

  Can't use string ("/home/patsy/tmp/test-repo-bare.g"...) as a HASH ref wh=
ile "strict refs" in use at /usr/lib64/perl5/vendor_perl/5.36/Error.pm line=
 234.=20

What's different between what you expected and what actually happened?

Perl syntax error when trying to generate the meaningful error.

Anything else you want to add:

Opening a "safe" repo (owned by the user, or marked safe in gitconfig)
of course does not error, which is as expected.

It seems that this call at Git.pm line 181:

  try {  =20
    $dir =3D $search->command_oneline(['rev-parse', '--git-dir'],
                                    STDERR =3D> 0);
  } catch Git::Error::Command with {
    $dir =3D undef;
  };

=2E..discards errors so that it just moves on to the next test, but in
this case what it discards would be new and interesting:

  [pid  1448] write(2, "fatal: detected dubious ownershi"..., 212) =3D 212

=2E..which is the first chance to catch the problem. It doesn't die right
away; I suspect this just sends the logic down a previously untested path.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.mumble
compiler info: gnuc: 11.3
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

Thanks,

--=20

Hank Leininger <hlein@korelogic.com>
9606 3BF9 B593 4CBC E31A  A384 6200 F6E3 781E 3DD7

--+J6BTSpRSC5conaE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElgY7+bWTTLzjGqOEYgD243gePdcFAmNGC1YACgkQYgD243ge
Pdc9eQ//fMdfdTMv55d6vjivdui+hMTrD/xPrGj+pxEZPxh622woI0F1WSX8ujNW
gTR+mJnksfP0XJVOqqO4OyJHMvAaTeZzQxwEuwmVJzGWglu6lOzgpnlejJ1kkhzD
32+rID5AL5gCnpQsssbnYG1kVDEoSdVFfO6oX2AXlF7BMa8HZ/DV/TCcpFcSC6cD
VsaRwDM7hSiPgNZtWFZ1Yqx76ovArMjcIhXnCLRk+7u5uLWc2LagBJLXkL0LceG7
/sY/WFCbOw0h848yW07/T2ui402AgwHfjuhLC6qzEsGMnimsnnJ9sOA0AZ5iX+io
XAwD9y4hc9ixq1IW2mOS90PSLd7j/bBSFKJ+ifdk+lKgJI33xdZK8pw3SilE2qF+
f9voEPVwb8dZCuXToHzWzvxk0oPl2VAUOdA2qR3MOYLV2epJEc9cDMoAOoQd0qde
8WXyBD/uu4U5N0MSJoRnonHr3SSF742efu/UhjbHHDAzyjWwNmAyBu9YML9oWADB
bzw+Uu0zJsHFCiAH6HqCsaY9JDHXn4xggQ/cImE9vUbhFtfWrGLJVju2Uxhu3/+b
lA5kyEU3apVD3rL9Jhnb4YUcLxRc/t5brJESDlx03ANLDNBs8F2jcYXisHT6qBF6
VBcJJ+oE738aEYJIMmwTBU61OobTax2JuabLjFMUp2GXAkCsil8=
=VHah
-----END PGP SIGNATURE-----

--+J6BTSpRSC5conaE--

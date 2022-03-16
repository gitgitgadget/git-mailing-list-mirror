Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1438FC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350891AbiCPUax (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiCPUaw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:30:52 -0400
X-Greylist: delayed 1187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 13:29:36 PDT
Received: from smtp.onerussian.com (washoe.dartmouth.edu [129.170.30.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E5B53B76
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:29:36 -0700 (PDT)
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <yoh@onerussian.com>)
        id 1nUZxo-0006E4-UB
        for git@vger.kernel.org; Wed, 16 Mar 2022 16:09:45 -0400
Date:   Wed, 16 Mar 2022 16:09:44 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <YjJECDbAV0DXUTMB@lena.dartmouth.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DGpz1mD7lcBbD5Z0"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: crash upon "commit removedfile/newfile removedfile"
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DGpz1mD7lcBbD5Z0
Content-Type: multipart/mixed; boundary="gv+SIN9RUhy5lhpm"
Content-Disposition: inline


--gv+SIN9RUhy5lhpm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Git Gurus,

Originally ran into in DANDI project [#127] while using datalad [#6558]
which uses git and git-annex.

"git commit" seems to not tolerate well whenever both removed path which be=
came
a directory and a file under that directory  are provided to commit
invocation along with the new file path under that directory.  But it is ok
whenever removed paths (staged or not) are provided to commit.

A reproducer of the former defect and latter behavior is attached, and
execution of it on my laptop provides output pasted in full below, where you
can see the=20

	+ rm p1
	+ mkdir p1
	+ touch p1/p2
	+ git add p1/p2
	+ git commit -m 2 p1/p2 p1
	error: 'p1' does not have a commit checked out
	fatal: updating files failed

problematic use case and  git commits just fine whenever removed paths
provided in commit invocation:

	+ rm p2 p3
	+ git add p2
	+ git commit -m 'removed and even staged one of them' p2 p3
	[master 209490a] removed and even staged one of them
	 2 files changed, 0 insertions(+), 0 deletions(-)
	 delete mode 100644 p2
	 delete mode 100644 p3

I think such inconsistent behavior is a defect in git. Ideally the former  =
"git
commit -m 2 p1/p2 p1" shouldn't crash.

	git version 2.35.1.473.g83b2b277ed
	+ git init
	Initialized empty Git repository in /home/yoh/.tmp/git-h0HvnyH/.git/
	+ touch p1
	+ git add p1
	+ git commit -m 1
	[master (root-commit) c9e0bff] 1
	 1 file changed, 0 insertions(+), 0 deletions(-)
	 create mode 100644 p1
	+ rm p1
	+ mkdir p1
	+ touch p1/p2
	+ git add p1/p2
	+ git commit -m 2 p1/p2 p1
	error: 'p1' does not have a commit checked out
	fatal: updating files failed
	+ echo 'that did not work when imho should have!'
	that did not work when imho should have!
	+ git commit -m 2 p1/p2
	[master 446b8dc] 2
	 1 file changed, 0 insertions(+), 0 deletions(-)
	 rename p1 =3D> p1/p2 (100%)
	+ echo 'done -- committed just fine'
	done -- committed just fine
	+ touch p2 p3
	+ git add p2 p3
	+ git commit -m 3 p2 p3
	[master 19ffa50] 3
	 2 files changed, 0 insertions(+), 0 deletions(-)
	 create mode 100644 p2
	 create mode 100644 p3
	+ rm p2 p3
	+ git add p2
	+ git commit -m 'removed and even staged one of them' p2 p3
	[master 209490a] removed and even staged one of them
	 2 files changed, 0 insertions(+), 0 deletions(-)
	 delete mode 100644 p2
	 delete mode 100644 p3
	+ echo 'and it worked just fine'


[#127] https://github.com/dandi/dandisets/issues/127#issuecomment-1066934910
[#6558]  DataLad bugreport https://github.com/datalad/datalad/issues/6558

--=20
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik       =20

--gv+SIN9RUhy5lhpm
Content-Type: application/x-sh
Content-Disposition: attachment; filename="git-commit-removed.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Acd "$(mktemp -d ${TMPDIR:-/tmp}/git-XXXXXXX)"=0A=0Agit --v=
ersion=0A=0Aset -eux=0A=0Agit init=0A=0Atouch p1 && git add p1 && git commi=
t -m 1=0A=0A# create problematic situation=0Arm p1 && mkdir p1 && touch p1/=
p2 && git add p1/p2=0A=0Agit commit -m 2 p1/p2 p1 \=0A&& { echo "must have =
crashed!"; exit 1; } \=0A|| { echo "that did not work when imho should have=
!"; }=0A=0Agit commit -m 2 p1/p2 \=0A&& echo "done -- committed just fine"=
=0A=0A# but why it works if I do specify removed path to commit?=0Atouch p2=
 p3 && git add p2 p3 && git commit -m 3 p2 p3=0A=0Arm p2 p3=0Agit add p2=0A=
git commit -m 'removed and even staged one of them' p2 p3=0A=0Aecho "and it=
 worked just fine"=0A=0A
--gv+SIN9RUhy5lhpm--

--DGpz1mD7lcBbD5Z0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEExbkF8OjZ/ZZo/zZvot4jUGLaM/oFAmIyRAUACgkQot4jUGLa
M/rKUg//fENNHq6ldAAANMWuP3kTD5j1OI914xbw+eEl2N1iZIgzkqbln0uJo2KP
vi9V6tzAddyV71vTRU9rF/VVRvINNLvcvcyliYDfiqttzCtd8QI7nrdnApkx+Vyv
8vK6ku9ULu4Gf8x5BYcBKrTbVoNf4Za5PQtZhQfNv3LqFY81FZcTRJZuYzUdKI/q
CODIQGJGczRLK+VpxfLVpI2nUOdm0bHGcLDzpBKLAOeR0GEXsW3fJ29HBG9NIkbu
cDdSHZiekhJQN8YSY0BOFOQvCr9XhYn9eMzcOssniVxnFFwj0/3roJdIZgzKwkMM
hAimgMExnEuK7QT1y8S3YEqktv4CtxhTPrOw8tuiWeAcg29+vizgUIprx/v80CVD
KchDAiUCzybIHqF6CbVwB2RiDdTasydz3dbnETNgVKCwm4YZ81brrT4Y3V91WbCg
BNf2/8/yy7YYr0F1oCnNY0VMTcV9Fecl9ocaHc762TS8FlpfgcPBAc6D5iZWtrod
Sjik0rv4SiMS+Lh0xQerZWnknWapccMudevgI7zSeYh7HH0afQwt1mRLikRmo9Cr
w9MRW6vm4aikN0DAffJfq1dWwqC/FOHyQkoeKrvBxxVorjAkKrEcSLb93a5CUBQb
pL5OGIBmU7aBdT0vMWBZ0BlZ5ZjCDujNPCU8g62vFmweFIR/9oY=
=Bn6o
-----END PGP SIGNATURE-----

--DGpz1mD7lcBbD5Z0--

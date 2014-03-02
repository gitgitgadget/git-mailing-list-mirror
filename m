From: Max Horn <max@quendi.de>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Sun, 2 Mar 2014 15:36:03 +0100
Message-ID: <3DC821FE-7330-4163-9E73-D3313B74E001@quendi.de>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_7F95C82E-F00F-4F78-A8E5-28B1B494B8C1"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 15:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK7V4-0002dj-Kv
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 15:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbaCBOgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 09:36:13 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:60286 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbaCBOgN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 09:36:13 -0500
Received: from ip-178-201-245-81.unitymediagroup.de ([178.201.245.81] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WK7Uu-00067w-H7; Sun, 02 Mar 2014 15:36:08 +0100
In-Reply-To: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1393770972;9387a854;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243149>


--Apple-Mail=_7F95C82E-F00F-4F78-A8E5-28B1B494B8C1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


On 01.03.2014, at 00:26, Conley Owens <cco3@android.com> wrote:

> $ git --version  # This is just the git from MacPorts
> git version 1.8.5.5
> $ sw_vers
> ProductName:    Mac OS X
> ProductVersion: 10.8.5
> BuildVersion:   12F45

I cannot reproduce this, neither with 1.8.5.5 nor with 1.9.0. I am also =
running Mac OS X 10.8.5.

Note: I tried this both with you original test.sh, and also with a =
version were I replaced the ">" by ">>", as per Jeff's suggestion. It =
(as predicted) didn't make any difference).

If this is a race condition, it might be easier to trigger it on slower =
hardware. I am running this on a 2012 MBP with 2.3 Ghz i7 and an SSD. =
What is your test machine?


Cheers,
Max

>=20
> test.sh
> """""""""""""""""""""""""""""""""""""
> #!/bin/bash
> rungit() {
>    mkdir $1
>    GIT_DIR=3D$1 git init --bare
>    echo '[remote "aosp"]' > $1/config
>    echo '    url =3D
> https://android.googlesource.com/platform/external/tinyxml2' >>
> $1/config
>    GIT_DIR=3D$1 git fetch aosp =
+refs/heads/master:refs/remotes/aosp/master
>    rm -rf $1
> }
>=20
> for i in $(seq 1 100)
> do
>    rungit testdir$i &
> done
> """""""""""""""""""""""""""""""""""""""
> $ ./test.sh  # Warning! This script fetches ~40MB of data
>=20
> When everything cools, you can see that there are some fetches hanging
> (typically).
> $ ps | grep 'git fetch'
> ...
> 63310 ttys004    0:00.01 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63314 ttys004    0:00.01 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63319 ttys004    0:00.01 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63407 ttys004    0:00.00 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63414 ttys004    0:00.00 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63420 ttys004    0:00.00 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> ...
>=20
> You can look at the parent process of each and see that one half
> spawned the other half, or you can look at the environment variables
> for each to see that there are two processes operating in the same
> directory for each directory where there's an issue.
> $ echo "$(for pid in $(ps | grep 'git fetch' | grep -o '^[0-9]*'); do
> ps -p $pid -wwwE | grep 'GIT_DIR=3D[^ ]*' -o; done)" | sort
> GIT_DIR=3Dtestdir14
> GIT_DIR=3Dtestdir14
> GIT_DIR=3Dtestdir32
> GIT_DIR=3Dtestdir32
> GIT_DIR=3Dtestdir47
> GIT_DIR=3Dtestdir47
>=20
> I've searched through the mailing list, but this doesn't seem to be a
> known issue.  I've only seen this occur on macs (and with a good deal
> of regularity).  It doesn't occur on my Ubuntu box.
>=20
> ~cco3
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--Apple-Mail=_7F95C82E-F00F-4F78-A8E5-28B1B494B8C1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMTQdgACgkQIpJVslrhe1kA9AEAoI+gRifQn2+lKgf2rGoM9lhW
YhXiiTvBqxgNzsj37OMBALjPONW/h0YLUAPL6uV3vcjeisILzx8C91XEugdpEGln
=xsuf
-----END PGP SIGNATURE-----

--Apple-Mail=_7F95C82E-F00F-4F78-A8E5-28B1B494B8C1--

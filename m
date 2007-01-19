From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Don't call fstat() on stdin in index-pack.
Date: Fri, 19 Jan 2007 04:02:42 +0100
Message-ID: <45B034D2.6010007@fs.ei.tum.de>
References: <20070118212615.GO8624@jukie.net> <20070119024436.GQ8624@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3F8E2F1BF32D739B4DE523FE"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 04:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7k1x-0003Lh-Vg
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 04:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbXASDCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 22:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbXASDCu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 22:02:50 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:42652 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964774AbXASDCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 22:02:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 885112816B;
	Fri, 19 Jan 2007 04:02:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gUglOWLCA9Vg; Fri, 19 Jan 2007 04:02:46 +0100 (CET)
Received: from [62.216.208.62] (ppp-62-216-208-62.dynamic.mnet-online.de [62.216.208.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 9226C28156;
	Fri, 19 Jan 2007 04:02:46 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
To: Bart Trojanowski <bart@jukie.net>
In-Reply-To: <20070119024436.GQ8624@jukie.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37149>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F8E2F1BF32D739B4DE523FE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Bart Trojanowski wrote:
>  	/* If input_fd is a file, we should have reached its end now. */
> -	if (fstat(input_fd, &st))
> -		die("cannot fstat packfile: %s", strerror(errno));
> -	if (S_ISREG(st.st_mode) && st.st_size !=3D consumed_bytes)
> -		die("pack has junk at the end");
> +        if (input_fd) {
> +                if (fstat(input_fd, &st))
> +                        die("cannot fstat packfile: %s", strerror(errn=
o));
> +                if (S_ISREG(st.st_mode) && st.st_size !=3D consumed_by=
tes)
> +                        die("pack has junk at the end");
> +        }

This is clearly the wrong fix.  input_fd being 0 doesn't mean that it is =
*not* a regular file.  Only doing a fstat can tell.  You are simply hidin=
g your real issue there, which is that you can't fstat on a pipe or whate=
ver input_fd is.

The problem here is that your 64bit kernel can't fit the data into your s=
truct stat provided by your 32bit libc.  Not a problem of git.  However, =
it would be interesting to know what exactly produces the EOVERFLOW.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig3F8E2F1BF32D739B4DE523FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsDTVr5S+dk6z85oRApUzAKCXvJHk+iq6JErb0ZcphyEeupCy8gCggM+Z
Q30cOdx+k8u9Fafth1ksAWk=
=qQN3
-----END PGP SIGNATURE-----

--------------enig3F8E2F1BF32D739B4DE523FE--

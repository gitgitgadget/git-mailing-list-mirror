From: Konstantin Ryabitsev <icon@mricon.com>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 13:55:54 -0500
Organization: Linux Foundation/Kernel.org
Message-ID: <1328900154.3171.27.camel@i5.mricon.com>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
	 <20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
	 <vpqbop6tyj6.fsf@bauges.imag.fr>
	 <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-7zMISncPscnBZJMR427l"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 10 19:56:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvvdf-0005pl-0c
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 19:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759800Ab2BJS4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 13:56:01 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46222 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab2BJS4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 13:56:00 -0500
Received: by ghrr11 with SMTP id r11so1664759ghr.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 10:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:x-mailer:mime-version;
        bh=7C+wXq9Cj0O8PblguIeIChaqOn01UfKz6k1hmrmcukM=;
        b=BhHfBtvbfvHyLXb339d9PmMLAP/rznYIH92bqxIu8vn2UMHXYhVFTpYNw+QihbYYc4
         OBC4m39FJBQz072y4/G3KdbdVFUtFoiB5E6YQa6u35chjY3LLg60Q7os94BNaY/CINFz
         5UaYCdBymiBUIXR6woXJrD8GzU4OMAo25Rguc=
Received: by 10.50.170.73 with SMTP id ak9mr13421580igc.3.1328900159581;
        Fri, 10 Feb 2012 10:55:59 -0800 (PST)
Received: from [69.165.198.147] ([69.165.198.147])
        by mx.google.com with ESMTPS id ut1sm10382905igc.2.2012.02.10.10.55.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 10:55:58 -0800 (PST)
In-Reply-To: <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
X-Mailer: Evolution 3.2.3 (3.2.3-1.fc16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190435>


--=-7zMISncPscnBZJMR427l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-02-10 at 13:00 -0500, Theodore Tso wrote:
> This would satisfy the security concerns, and it wouldn't be hard, but it=
 would
> require some implementation work.   Anyone have some perl hacking time to
> take a look at:=20
>=20
>       git://git.kernel.org/pub/scm/utils/kup/kup.git
>=20
> =E2=80=A6 and add a "UNPACK pathanme" to the kup-server file, and work wi=
th the
> sysadmins at kernel.org to get it reviewed and accepted?

I have a few comments off the top of my head:

     1. "kup rm" will need to be modified, as it currently only allows
        deleting things that have a matching signature. The alternative
        is for UNPACK to create a foo.tar.manifest file that will be
        consulted upon "kup rm" to clean up any unpacked contents upon
        the deletion of the source archive. Note, that there are many,
        many gotchas with this solution -- e.g. .manifest should
        probably contain checksums, too, as there are bound to be
        conditions when two tarballs reference the same files, and you
        want to make sure that you delete files matching the contents of
        the old tarball, not the newer one, etc.
     2. I would suggest that UNPACK ignores any directory structure in
        the archive, and only copies over files matching a restricted
        set of extensions (.html, .txt, .jpg, .png) into the same dir as
        the original tarball. Basically, untar into a temporary
        directory, then find any files matching the above set of
        extensions, copy them into another temporary location, force
        permissions to 0644, and then move them into the final "live"
        location in the same dir with the tarball (with the
        corresponding .manifest, if that solution used). There should be
        logic to make sure that we never overwrite any files that have a
        matching .sign file.
     3. There should be some support to ensure that the unpack process
        is terminated if unpacked content size reaches a certain limit,
        or if it is taking too long to complete.

Best regards,
--=20
Konstantin Ryabitsev
Systems Administrator, Kernel.org
Montr=C3=A9al, Qu=C3=A9bec

--=-7zMISncPscnBZJMR427l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQGcBAABCAAGBQJPNWg6AAoJEI6WedmufEletSsL/2RU3sP3vofMWCUxYwctlnku
hirUA1d2xKtOOKo3/wqT1LAbLnGxhuBBUyB0QvoKLk1f7pfANIHO9/OcLSLWKDYo
cifm/pz+fzAJtjmuwezrCoDhySzovPmXXnYKqoLX9S+BQDejRXJ3C94TcBkGdBm7
hsIcmL+5OLGaGAFvrDHlrTnMyPk66Sm5u0bMB845D86rTJbqGzHnAihG3WNTHORa
jzaXo5SNd62CcfZd3LYdIK4aSGTsf6+IGUVeS9tkzrgqolB9BNZv+5DhjDTOVZks
0r7j104E6Z/xcMcXLV2u0xu5QOSfzHlCXqETUSRQBumPjAWLIrKrVvS3rjFDtUUP
wcUIm7NBG10YIuCfq2U+IjVJkluXI5x1aU0qTFiOViRUj0k7bZ6AMuRvfOe14V6j
TQ5LZg6NUkYVvOEVRgyBKDNoj8LG8NDZ/g/Ixuw/MgAKIZZDfBtwqONdYEUmh0/H
VLPNsK8w3dTW/5ZrWRpJNUA7KdlWSfKYcogKA38KvQ==
=K9/8
-----END PGP SIGNATURE-----

--=-7zMISncPscnBZJMR427l--
